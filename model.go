// Package model provides structure of model in profiling
package model

import (
	"math"
	"sort"
	"sync"

	"gitlab.visc.com/WAF-Product/web-profiling/pkg/config"
	"gitlab.visc.com/WAF-Product/web-profiling/pkg/request"
	"gitlab.visc.com/WAF-Product/web-profiling/pkg/score"
)

const (
	deleteThreshold = 1
	trustThreshold  = 40
	levelThreshold  = 60

	lengthV = float64(score.ScaleLength)
)

type (
	Model struct {
		*sync.RWMutex `json:"-"`

		VFreq map[string]score.Counter
		SFreq map[string]int

		LFreq map[uint8]int
		WFreq map[uint8]int

		GFreq *GroupFreq

		LengthMean, LengthVariance float32

		VFreqMax, LFreqMax, SFreqMax, Sum                          int
		LengthScore, GroupScore, SpecialScore, LengthVarianceScore float32
		CreatedAt                                                  int64
	}

	GroupFreq struct {
		NumberFreq, LetterFreq, SpecialFreq map[uint8]int
	}
)

func NewModel(createdAt int64) *Model {
	return &Model{
		RWMutex: &sync.RWMutex{},
		VFreq:   make(map[string]score.Counter),
		SFreq:   make(map[string]int),
		LFreq:   make(map[uint8]int),
		WFreq:   make(map[uint8]int),
		GFreq: &GroupFreq{
			NumberFreq:  make(map[uint8]int),
			LetterFreq:  make(map[uint8]int),
			SpecialFreq: make(map[uint8]int),
		},
		LengthScore:  2.0,
		GroupScore:   5.0,
		SpecialScore: 2.0,
		CreatedAt:    createdAt,
	}
}

func NewEmptyModel() *Model {
	return &Model{
		RWMutex: &sync.RWMutex{},
	}
}

func (m *Model) Merge(other *Model) {
	for value, distinct := range other.VFreq {
		var pLetter, pNumber, pSpecial, pWord uint8 = 0, 0, 0, 0
		var length uint8 = 0
		if value != "" {
			pLetter, pNumber, pSpecial, pWord = score.CalcCharacterPercentage(value)
			length = scaleLength(len(value))
		}

		if v, ok := m.VFreq[value]; !ok {
			m.VFreq[value] = distinct
			countDistinctIP := distinct.Len()

			if value != "" {
				m.LFreq[length] += countDistinctIP
				m.WFreq[pWord] += countDistinctIP
				m.GFreq.NumberFreq[pNumber] += countDistinctIP
				m.GFreq.LetterFreq[pLetter] += countDistinctIP
				m.GFreq.SpecialFreq[pSpecial] += countDistinctIP

				exist := make(map[string]bool)
				for _, s := range score.SplitSpecial(value) {
					if _, ok := exist[s]; !ok {
						m.SFreq[s] += countDistinctIP
						exist[s] = true
					}
				}

				m.Sum += countDistinctIP
				if m.SFreqMax < countDistinctIP {
					m.SFreqMax = countDistinctIP
				}
			}
			if m.VFreqMax < countDistinctIP {
				m.VFreqMax = countDistinctIP
			}
		} else {
			for ip := range distinct {
				if _, ok := v[ip]; !ok && value != "" {
					m.LFreq[length]++
					m.WFreq[pWord]++
					m.GFreq.NumberFreq[pNumber]++
					m.GFreq.LetterFreq[pLetter]++
					m.GFreq.SpecialFreq[pSpecial]++

					exist := make(map[string]bool)
					for _, s := range score.SplitSpecial(value) {
						if _, ok := exist[s]; !ok {
							m.SFreq[s]++
							if m.SFreqMax < m.SFreq[s] {
								m.SFreqMax = m.SFreq[s]
							}
							exist[s] = true
						}
					}
					m.Sum++
				}
				v.Set(ip)
				if m.VFreqMax < v.Len() {
					m.VFreqMax = v.Len()
				}
			}
		}
	}

	m.LFreqMax = 0
	m.LengthMean = 0
	m.LengthVariance = 0

	if m.Sum == 0 {
		return
	}

	sum := 0
	for length, value := range m.LFreq {
		if m.LFreqMax < value {
			m.LFreqMax = value
		}
		sum += int(length) * value
	}

	m.LengthMean = float32(sum) / float32(m.Sum)
	for length, value := range m.LFreq {
		m.LengthVariance += float32(value) * (float32(length) - m.LengthMean) * (float32(length) - m.LengthMean)
	}
	m.LengthVariance /= float32(m.Sum)
	m.LengthVariance = float32(math.Sqrt(float64(m.LengthVariance)))
}

func (m *Model) Update(ip, value string) {
	if _, ok := m.VFreq[value]; !ok {
		m.VFreq[value] = make(score.Counter)
	}
	m.VFreq[value].Set(ip)
}

func (m *Model) Score(key, value string, req *request.HttpRequest) {
	if v, ok := m.VFreq[value]; ok && v.Len() >= trustThreshold {
		req.IsTrust = true
	} else {
		req.IsTrust = false
	}

	if v, ok := m.VFreq[""]; ok && m.VFreqMax >= levelThreshold && v.Len() == m.VFreqMax && float32(v.Len())*0.2 > float32(m.Sum) && m.Sum < 1000 {
		req.IsAlertEmpty = true
		return
	}

	pLetter, pNumber, pSpecial, pWord := score.CalcCharacterPercentage(value)

	l := scaleLength(len(value))
	req.Score.LengthScore = score.LengthScore(m.LFreq, l, m.Sum, m.LFreqMax, score.BinsLength)

	req.Score.GroupScoreLetter = score.GroupScore(m.GFreq.LetterFreq, pLetter, m.Sum, score.BinsGroupCharacter)
	req.Score.GroupScoreNumber = score.GroupScore(m.GFreq.NumberFreq, pNumber, m.Sum, score.BinsGroupCharacter)
	req.Score.GroupScoreSpecial = score.GroupScore(m.GFreq.SpecialFreq, pSpecial, m.Sum, score.BinsGroupCharacter)
	req.Score.GroupScore = req.Score.GroupScoreLetter + req.Score.GroupScoreNumber + req.Score.GroupScoreSpecial

	req.Score.SpecialScore = score.SpecialScore(m.SFreq, value, m.SFreqMax, score.BinsSpecialCharacter)
	req.Score.WordScore = score.WordScore(m.WFreq, pWord, m.Sum, score.BinsSpecialCharacter)
	req.Score.LengthVarianceScore = score.LengthVarianceScore(m.LengthMean, m.LengthVariance, l)
}

type transformValueFunc func(value string) string

func (m *Model) Rebuild(transformFunc transformValueFunc) *Model {
	newModel := NewModel(m.CreatedAt)

	counter := make(map[string]score.Counter)
	for value, distinct := range m.VFreq {
		v := transformFunc(value)

		counter[v] = distinct
	}
	m.VFreq = counter

	newModel.Merge(m)
	return newModel
}

func (m *Model) PlotValues() map[string]int {
	return SortByValueCounter(m.VFreq).ExportStringKey()
}

func (m *Model) PlotSpecial() map[string]int {
	return SortByValueDistinct(m.SFreq).ExportStringKey()
}

func (m *Model) PlotWords() map[uint8]int {
	return SortByValueDistinctUInt8(m.WFreq).ExportUInt8Key()
}

func (m *Model) PlotLength() map[uint8]int {
	var keys []int

	opt := config.GetInstance()
	count := 0

	for k := range m.LFreq {
		keys = append(keys, int(k))
		count++
		if count >= opt.MaxData {
			break
		}
	}

	sort.Ints(keys)

	data := make(map[uint8]int)
	for _, k := range keys {
		data[uint8(k)] = m.LFreq[uint8(k)]
	}

	return data
}

func (m *Model) Clean(now int64) int {
	if m.CreatedAt >= now {
		return -1
	}

	m.Lock()
	defer m.Unlock()

	deleted := 0

	vtotal := int(len(m.VFreq) / 2)
	for k, v := range m.VFreq {
		if v.Len() <= deleteThreshold {
			delete(m.VFreq, k)
			deleted++
			if deleted >= vtotal {
				break
			}
		}
	}

	return deleted
}

func scaleLength(l int) uint8 {
	v := uint8(math.Round(float64(l)/lengthV) * lengthV)
	if l != 0 && v == 0 {
		return uint8(lengthV)
	}
	return v
}

func (m *Model) Fix() []string {
	var anomaly []string
	if m.LengthMean == 0 {
		return anomaly
	}
	for value, num := range m.VFreq {
		length := scaleLength(len(value))
		lvScore := score.LengthVarianceScore(m.LengthMean, m.LengthVariance, length)
		if float32(length) > m.LengthMean && lvScore > 2 && num.Len() < 5 && score.CountSpecial(value) != 0 {
			anomaly = append(anomaly, value)
		}
	}
	return anomaly
}

// Improve threshold of each model when too many alert
func (m *Model) PIDModel(AlertRequests []*request.HttpRequest, sumRequest int) {
	countAlertLength, countAlertGroup, countAlertSpecial := countAlert(AlertRequests)
	var output float64
	setpoint := 0.01 // expect alert percentage smaller than 1%
	c := pid.NewPIDController(-10.0, 0.0, 0.0)
	c.Set(setpoint)
	ratioAlertLength := float64(countAlertLength) / float64(sumRequest)
	ratioAlerGroup := float64(countAlertGroup) / float64(sumRequest)
	ratioAlertSpecial := float64(countAlertSpecial) / float64(sumRequest)
	if countAlertLength > 10 {
		//PID Length
		c.SetOutputLimits(0.01, 0.3)
		output = c.Update(ratioAlertLength)
		m.LengthScore += float32(math.Log(output))
	}
	if countAlertGroup > 10 {
		//PID Group
		c.SetOutputLimits(0.03, 1)
		output = c.Update(ratioAlerGroup)
		m.GroupScore += float32(math.Log(output))
	}
	if countAlertSpecial > 10 {
		//PID Special
		c.SetOutputLimits(0.01, 0.3)
		output = c.Update(ratioAlertSpecial)
		m.SpecialScore += float32(math.Log(output))

	}
}

//count number Label request alert
func countAlert(AlertRequests []*request.HttpRequest) (countAlertLength, countAlertGroup, countAlertSpecial int8) {
	for req := range AlertRequests {
		if req.Label[request.OverLengthIndex] != "" {
			countAlertLength++
		}
		if req.Label[request.OverGroupIndex] != "" {
			countAlertGroup++
		}
		if req.Label[request.OverSpecialIndex] != "" {
			countAlertLength++
		}
	}
}

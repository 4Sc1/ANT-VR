using System;
using System.IO;
using System.Linq;
using UnityEngine;

namespace Assets.Tasks.AttentionalNetwork.Scripts
{
    [Serializable]
    public class ExperimentResult
    {

        public string ExperimentName;
        public string DataStreamName;
        public string DeviceId;
        public string AppName;
        public string AppVersion;
        public string AndroidVersion;
        public DateTimeOffset DeviceDateTime = DateTimeOffset.Now;
        public ExperimentConditionsBase ExperimentConditions;

        private TrialResultType[] _results;
        private uint _numberOfTrialsForSuccessRateInPractice;
        private uint _currentResultCount;

        public DateTimeOffset FirstResultTime;
        public DateTimeOffset LastResultTime;

        public TrialResult[] TrialResults;
        public Scores Scores;

        public ExperimentResult(string experimentName, string deviceId, string appName, string appVersion, string androidVersion, uint numberOfTrialsForSuccessRateInPractice, ExperimentConditionsBase experimentConditions)
        {
            if (string.IsNullOrWhiteSpace(experimentName))
                throw new ArgumentNullException(nameof(experimentName));

            if (string.IsNullOrWhiteSpace(deviceId))
                throw new ArgumentNullException(nameof(deviceId));

            if (string.IsNullOrWhiteSpace(appName))
                throw new ArgumentNullException(nameof(appName));

            if (string.IsNullOrWhiteSpace(appVersion))
                throw new ArgumentNullException(nameof(appVersion));

            if (string.IsNullOrWhiteSpace(androidVersion))
                throw new ArgumentNullException(nameof(androidVersion));

            if (experimentConditions == null)
                throw new ArgumentNullException(nameof(experimentConditions));

            _numberOfTrialsForSuccessRateInPractice = numberOfTrialsForSuccessRateInPractice;
            _results = new TrialResultType[_numberOfTrialsForSuccessRateInPractice];

            ExperimentName = experimentName;
            DeviceId = deviceId;
            AppName = appName;
            AppVersion = appVersion;
            AndroidVersion = androidVersion;
            ExperimentConditions = experimentConditions;
            TrialResults = new TrialResult[ExperimentConditions.TrialCount];
            _currentResultCount = 0;

            for (int i = 0; i < _numberOfTrialsForSuccessRateInPractice; i++)
                _results[i] = TrialResultType.Incorrect;
        }

        public uint CurrentResultCount => _currentResultCount;

        public void AddTrialResult(TrialResult trialResult)
        {
            try
            {
                if (_currentResultCount == 0)
                    FirstResultTime = DateTimeOffset.Now;

                LastResultTime = DateTimeOffset.Now;

                TrialResults[_currentResultCount] = trialResult;

                if (ExperimentConditions.ExperimentType == ExperimentType.Practice)
                {
                    if (_currentResultCount >= ExperimentConditions.TrialCount)
                        _currentResultCount = 0;

                    _results[_currentResultCount % _numberOfTrialsForSuccessRateInPractice] = trialResult.Type;
                }                
            }
            catch (Exception ex)
            {
                //if (Debug.isDebugBuild)
                Debug.LogError(ex.Message);
            }

            _currentResultCount += 1;
        }

        public float PracticeRunAccuracy()
        {
            return ((float)_results.Count((tp) => tp == TrialResultType.Correct)) / _numberOfTrialsForSuccessRateInPractice;
        }

        public void CalculateScores()
        {
            try
            {
                Scores = ResultScorer.Calculate(ExperimentConditions.Trials, TrialResults, CurrentResultCount, ExperimentConditions.PhoneIsOnTheLeft);
            }
            catch (Exception ex)
            {
                //if (Debug.isDebugBuild)
                Debug.LogError(ex);
            }
        }

        public void Save()
        {
            try
            {
                File.WriteAllText(GetResultFileName(), JsonUtility.ToJson(this, true), System.Text.Encoding.UTF8);
            }
            catch (Exception ex)
            {
                //if (Debug.isDebugBuild)
                Debug.LogError(ex);
            }
        }

        private string GetResultFileName()
        {
            return Path.Combine(Application.persistentDataPath, ExperimentName + @".json");
        }
    }
}

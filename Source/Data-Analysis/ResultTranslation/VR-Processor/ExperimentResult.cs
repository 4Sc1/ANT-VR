using System;
using System.IO;
using Newtonsoft.Json;

namespace VR_Processor
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

        public DateTimeOffset FirstResultTime;
        public DateTimeOffset LastResultTime;

        public TrialResult[] TrialResults;
        [JsonIgnore]
        public Scores Scores;

        public ExperimentResult()
        {

        }

        public static ExperimentResult Read(string pathToExperimentResult)
        {
            using (var streamReader = File.OpenText(pathToExperimentResult))
            using (var jsonReader = new JsonTextReader(streamReader))
            {
                var serializer = new JsonSerializer();

                return serializer.Deserialize<ExperimentResult>(jsonReader);
            }
        }
    }
}

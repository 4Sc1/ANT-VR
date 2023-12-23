using System.Collections.Generic;
using System.IO;

namespace VR_Processor
{
    public class ANTRCompResult
    {
        private const string ANTRCompResultHeader = @"CueCondition,CueValidity,FlankerCondition,LocationCondition,IntervalBetweenCueAndTarget,SlideTargetAndResponseCollection.ACC,SlideTargetAndResponseCollection.RT";

        private readonly List<ANTRCompTrialResult> _antrCompTrialResults = new List<ANTRCompTrialResult>();

        public ANTRCompResult(ExperimentResult experimentResult)
        {
            foreach (var trialResult in experimentResult.TrialResults)
                _antrCompTrialResults.Add(new ANTRCompTrialResult(experimentResult.ExperimentConditions.Trials[trialResult.TrialNumber], trialResult, experimentResult.ExperimentConditions.PhoneIsOnTheLeft));
        }

        public void Save(string pathToFile)
        {
            using (var writer = File.CreateText(pathToFile))
            {
                writer.WriteLine(ANTRCompResultHeader);

                foreach (var antrCompTrialResult in _antrCompTrialResults)
                    writer.WriteLine(antrCompTrialResult.ToString());
            }
        }
    }
}

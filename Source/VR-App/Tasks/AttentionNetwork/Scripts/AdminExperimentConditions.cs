using System;

namespace Assets.Tasks.AttentionalNetwork.Scripts
{
    [Serializable]
    public class AdminExperimentConditions : ExperimentConditionsBase
    {
        public AdminExperimentConditions() : base()
        {

        }

        public AdminExperimentConditions(uint experimentStartDelay, uint cuePresentationTimeSpan, uint targetPresentationTimeSpan, uint responseCollectionOnset, uint responseCollectionEnd, uint fixedDeltaTime, bool randomizeCueTargetConditions, bool isLimitedTestRun, bool phoneIsOnTheLeft, bool playBackgroundNoise, bool useOriginalCueTargetConditions) : base(ExperimentType.Admin, experimentStartDelay, cuePresentationTimeSpan, targetPresentationTimeSpan, responseCollectionOnset, responseCollectionEnd, fixedDeltaTime, randomizeCueTargetConditions, isLimitedTestRun, phoneIsOnTheLeft, playBackgroundNoise, useOriginalCueTargetConditions)
        {
        }
    }
}

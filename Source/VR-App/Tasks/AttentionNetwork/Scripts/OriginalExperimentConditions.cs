using System;

namespace Assets.Tasks.AttentionalNetwork.Scripts
{
    [Serializable]
    public class OriginalExperimentConditions : ExperimentConditionsBase
    {
        public OriginalExperimentConditions() : base()
        {

        }

        public OriginalExperimentConditions(uint experimentStartDelay, uint cuePresentationTimeSpan, uint targetPresentationTimeSpan, uint responseCollectionOnset, uint responseCollectionEnd, uint fixedDeltaTime) : base(ExperimentType.Original, experimentStartDelay, cuePresentationTimeSpan, targetPresentationTimeSpan, responseCollectionOnset, responseCollectionEnd, fixedDeltaTime, true, false, true, false, true)
        {
        }
    }
}

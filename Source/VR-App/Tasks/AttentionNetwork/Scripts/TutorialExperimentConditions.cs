using System;

namespace Assets.Tasks.AttentionalNetwork.Scripts
{
    [Serializable]
    public class TutorialExperimentConditions : ExperimentConditionsBase
    {
        public TutorialExperimentConditions() : base()
        {
        }

        public TutorialExperimentConditions(uint experimentStartDelay, uint cuePresentationTimeSpan, uint targetPresentationTimeSpan, uint responseCollectionOnset, uint responseCollectionEnd, uint fixedDeltaTime) : base(ExperimentType.Practice, experimentStartDelay, cuePresentationTimeSpan, targetPresentationTimeSpan, responseCollectionOnset, responseCollectionEnd, fixedDeltaTime, true, false, true, false, true)
        {
        }
    }
}

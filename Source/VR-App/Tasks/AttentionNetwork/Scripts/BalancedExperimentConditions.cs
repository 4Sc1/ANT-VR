using System;

namespace Assets.Tasks.AttentionalNetwork.Scripts
{
    [Serializable]
    public class BalancedExperimentConditions : ExperimentConditionsBase
    {
        public BalancedExperimentConditions() : base()
        {

        }

        public BalancedExperimentConditions(uint experimentStartDelay, uint cuePresentationTimeSpan, uint targetPresentationTimeSpan, uint responseCollectionOnset, uint responseCollectionEnd, uint fixedDeltaTime) : base(ExperimentType.Balanced, experimentStartDelay, cuePresentationTimeSpan, targetPresentationTimeSpan, responseCollectionOnset, responseCollectionEnd, fixedDeltaTime, true, false, true, false, false)
        {
        }
    }
}

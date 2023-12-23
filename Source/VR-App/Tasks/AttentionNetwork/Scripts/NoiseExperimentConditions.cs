using System;

namespace Assets.Tasks.AttentionalNetwork.Scripts
{
    [Serializable]
    public class NoiseExperimentConditions : ExperimentConditionsBase
    {
        public NoiseExperimentConditions() : base()
        {

        }

        public NoiseExperimentConditions(uint experimentStartDelay, uint cuePresentationTimeSpan, uint targetPresentationTimeSpan, uint responseCollectionOnset, uint responseCollectionEnd, uint fixedDeltaTime) : base(ExperimentType.Noise, experimentStartDelay, cuePresentationTimeSpan, targetPresentationTimeSpan, responseCollectionOnset, responseCollectionEnd, fixedDeltaTime, true, false, true, true, true)
        {
        }
    }
}

using System;

namespace VR_Processor
{
    [Serializable]
    public class ExperimentConditionsBase
    {
        public ExperimentType ExperimentType;
        public uint TrialCount;
        public uint ExperimentStartDelay;
        public uint CuePresentationTimeSpan;
        public uint TargetPresentationTimeSpan;
        public uint ResponseCollectionOnset;
        public uint ResponseCollectionEnd;
        public uint InterExperimentPartTimeSpan;
        public uint FixedDeltaTime;
        public bool RandomizeCueTargetConditions;
        public bool IsLimitedTestRun;
        public bool PhoneIsOnTheLeft;
        public bool PlayBackgroundNoise;
        public bool UseOriginalCueTargetConditions;
        public CueTargetCondition[] CueTargetConditions;
        public CueTargetCondition[] CueTargetConditionsOrder;
        public Trial[] Trials;

        protected ExperimentConditionsBase()
        {

        }
    }
}

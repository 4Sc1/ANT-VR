namespace VR_Processor
{
    internal class TargetFlankerConditionAndCueTargetIntervalTuple
    {
        public readonly TargetFlankerCondition TargetFlankerCondition;
        public readonly CueTargetInterval CueTargetInterval;

        public TargetFlankerConditionAndCueTargetIntervalTuple(TargetFlankerCondition targetFlankerCondition, CueTargetInterval cueTargetInterval)
        {
            TargetFlankerCondition = targetFlankerCondition;
            CueTargetInterval = cueTargetInterval;
        }

        internal double RankableValue()
        {
            return (int)TargetFlankerCondition * 10 + (int)CueTargetInterval;
        }
    }
}

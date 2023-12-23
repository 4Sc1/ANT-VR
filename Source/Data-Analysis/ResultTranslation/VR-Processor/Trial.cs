using System;

namespace VR_Processor
{
    [Serializable]
    /// <summary>
    /// The conditions of this individual trial.
    /// </summary>
    public class Trial
    {
        public uint Number;
        public CueTargetCondition CueTargetCondition;
        public TargetFlankerCondition TargetFlankerCondition;
        public CueTargetInterval CueTargetInterval;
        public PostTargetFixationInterval PostTargetFixationInterval;

        public Trial()
        {

        }

        public Trial(uint number, CueTargetCondition cueTargetCondition, TargetFlankerCondition targetFlankerCondition, CueTargetInterval cueTargetInterval, PostTargetFixationInterval postTargetFixationInterval)
        {
            Number = number;
            CueTargetCondition = cueTargetCondition;
            TargetFlankerCondition = targetFlankerCondition;
            CueTargetInterval = cueTargetInterval;
            PostTargetFixationInterval = postTargetFixationInterval;
        }

        internal bool TargetIsPhone()
        {
            return TargetFlankerCondition == TargetFlankerCondition.PhoneFlankedByPhones || TargetFlankerCondition == TargetFlankerCondition.PhoneFlankedByTablets;
        }

        public override string ToString()
        {
            return nameof(Number) + @" = " + Number + @": " + nameof(CueTargetCondition) + @" = " + CueTargetCondition + @"; " + nameof(TargetFlankerCondition) + @" = " + TargetFlankerCondition + @"; " + nameof(CueTargetInterval) + @" = " + CueTargetInterval + @"; " + nameof(PostTargetFixationInterval) + @" = " + PostTargetFixationInterval + @".";
        }

        internal bool FlankersAreCongruent()
        {
            return TargetFlankerCondition == TargetFlankerCondition.PhoneFlankedByPhones || TargetFlankerCondition == TargetFlankerCondition.TabletFlankedByTablets;
        }

        private bool TargetIsOnTheLeft()
        {
            return CueTargetCondition == CueTargetCondition.NoCueTargetLeft || CueTargetCondition == CueTargetCondition.CueLeftTargetLeft || CueTargetCondition == CueTargetCondition.CueRightTargetLeft || CueTargetCondition == CueTargetCondition.DoubleCueTargetLeft;
        }

        internal bool LocationIsCongruent(bool phoneIsOnTheLeft)
        {
            if (TargetIsOnTheLeft() && (phoneIsOnTheLeft == TargetIsPhone()))
                return true;

            if (!TargetIsOnTheLeft() && (phoneIsOnTheLeft != TargetIsPhone()))
                return true;

            return false;
        }
    }
}

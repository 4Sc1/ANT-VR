using System;

namespace VR_Processor
{
    public class ANTRCompTrialResult
    {
        private readonly Trial _trial;
        private readonly TrialResult _result;
        private readonly bool _phoneIsOnTheLeft;

        public ANTRCompTrialResult(Trial trial, TrialResult result, bool phoneIsOnTheLeft)
        {
            _trial = trial;
            _result = result;
            _phoneIsOnTheLeft = phoneIsOnTheLeft;
        }

        public override string ToString()
        {
            return GetCueConditionCueValidity() + GetFlankerCondition() + GetLocationCondition() + GetCueToTargetOnset() + GetAccuracy() + GetReactionTime();
        }

        private string GetCueConditionCueValidity()
        {
            switch (_trial.CueTargetCondition)
            {
                case CueTargetCondition.CueLeftTargetLeft:
                    return @"spacial,valid,";
                case CueTargetCondition.CueLeftTargetRight:
                    return @"spacial,invalid,";
                case CueTargetCondition.CueRightTargetLeft:
                    return @"spacial,invalid,";
                case CueTargetCondition.CueRightTargetRight:
                    return @"spacial,valid,";
                case CueTargetCondition.DoubleCueTargetLeft:
                    return @"double,double,";
                case CueTargetCondition.DoubleCueTargetRight:
                    return @"double,double,";
                case CueTargetCondition.NoCueTargetLeft:
                    return @"no,na,";
                case CueTargetCondition.NoCueTargetRight:
                    return @"no,na,";
            }

            return @"NULL,";
        }

        private string GetFlankerCondition()
        {
            if (_trial.FlankersAreCongruent())
                return @"congruent,";

            return @"incongruent,";
        }

        private string GetLocationCondition()
        {
            if(_trial.LocationIsCongruent(_phoneIsOnTheLeft))
                return @"congruent,";

            return @"incongruent,";
        }

        private string GetCueToTargetOnset()
        {
            switch (_trial.CueTargetInterval)
            {
                case CueTargetInterval.Interval0:
                    return @"0,";
                case CueTargetInterval.Interval400:
                    return @"400,";
                case CueTargetInterval.Interval800:
                    return @"800,";
            }

            return @"NULL";
        }

        private string GetAccuracy()
        {
            if (_result.Type == TrialResultType.Correct)
                return @"1,";

            return @"0,";
        }

        private string GetReactionTime()
        {
            if(!double.IsNaN(_result.ReactionTimeInSeconds)) 
                return Convert.ToInt32(_result.ReactionTimeInSeconds * 1000).ToString();

            return @"0";
        }
    }
}

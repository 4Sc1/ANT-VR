using System;

namespace VR_Processor
{
    [Serializable]
    public class TrialResult
    {
        public uint TrialNumber;
        public double TrialStart;
        public TrialResultType Type;
        public double ReactionTimeInSeconds;

        public TrialResult()
        {

        }

        public TrialResult(uint trialNumber, double trialStart, TrialResultType type, double reactionTimeInSeconds)
        {
            TrialNumber = trialNumber;
            TrialStart = trialStart;
            Type = type;
            ReactionTimeInSeconds = reactionTimeInSeconds;
        }

        public override string ToString()
        {
            return nameof(TrialNumber) + @" = " + TrialNumber + @": " + nameof(TrialStart) + @" = " + TrialStart + @"; " + nameof(Type) + @" = " + Type + @"; " + nameof(ReactionTimeInSeconds) + @" = " + ReactionTimeInSeconds + @".";
        }
    }
}

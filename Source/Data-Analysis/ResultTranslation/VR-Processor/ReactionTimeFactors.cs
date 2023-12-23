using System;

namespace VR_Processor
{
    [Serializable]
    public class ReactionTimeFactors
    {
        public ReactionTimeFactor NoCue;
        public ReactionTimeFactor DoubleCue;
        public ReactionTimeFactor InvalidCue;
        public ReactionTimeFactor ValidCue;
        public ReactionTimeFactor ValidCueZeroCueToTargetOnset;
        public ReactionTimeFactor ValidCue800CueToTargetOnset;
        public ReactionTimeFactor FlankerIncongruent;
        public ReactionTimeFactor FlankerCongruent;
        public ReactionTimeFactor LocationIncongruent;
        public ReactionTimeFactor LocationCongruent;
        public ReactionTimeFactor FlankerCongruentLocationCongruent;
        public ReactionTimeFactor FlankerIncongruentLocationIncongruent;
        public ReactionTimeFactor FlankerCongruentLocationIncongruent;
        public ReactionTimeFactor FlankerIncongruentLocationCongruent;
        public ReactionTimeFactor NoCueFlankerIncongruent;
        public ReactionTimeFactor DoubleCueFlankerCongruent;
        public ReactionTimeFactor NoCueFlankerCongruent;
        public ReactionTimeFactor DoubleCueFlankerIncongruent;
        public ReactionTimeFactor ValidCueFlankerIncongruent;
        public ReactionTimeFactor ValidCueFlankerCongruent;
        public ReactionTimeFactor InvalidCueFlankerIncongruent;
        public ReactionTimeFactor InvalidCueFlankerCongruent;
        public ReactionTimeFactor NoCueLocationIncongruent;
        public ReactionTimeFactor DoubleCueLocationCongruent;
        public ReactionTimeFactor NoCueLocationCongruent;
        public ReactionTimeFactor DoubleCueLocationIncongruent;
        public ReactionTimeFactor ValidCueLocationIncongruent;
        public ReactionTimeFactor ValidCueLocationCongruent;
        public ReactionTimeFactor InvalidCueLocationIncongruent;
        public ReactionTimeFactor InvalidCueLocationCongruent;
        public ReactionTimeFactor InvalidCueZeroCueToTargetOnset;
        public ReactionTimeFactor ValidCue400CueToTargetOnset;
        public ReactionTimeFactor InvalidCue400CueToTargetOnset;
        public ReactionTimeFactor Overall;

        public ReactionTimeFactors()
        {

        }
    }
}

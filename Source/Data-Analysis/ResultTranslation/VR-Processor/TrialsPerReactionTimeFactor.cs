using System;
using System.Collections.Generic;

namespace VR_Processor
{
    [Serializable]
    public class TrialsPerReactionTimeFactor
    {
        public List<uint> CorrectResponseNoCue;
        public List<uint> CorrectResponseDoubleCue;
        public List<uint> CorrectResponseInvalidCue;
        public List<uint> CorrectResponseValidCue;
        public List<uint> CorrectResponseValidCueZeroCueToTargetOnset;
        public List<uint> CorrectResponseValidCue800CueToTargetOnset;
        public List<uint> CorrectResponseFlankerIncongruent;
        public List<uint> CorrectResponseFlankerCongruent;
        public List<uint> CorrectResponseLocationIncongruent;
        public List<uint> CorrectResponseLocationCongruent;
        public List<uint> CorrectResponseFlankerCongruentLocationCongruent;
        public List<uint> CorrectResponseFlankerIncongruentLocationIncongruent;
        public List<uint> CorrectResponseFlankerCongruentLocationIncongruent;
        public List<uint> CorrectResponseFlankerIncongruentLocationCongruent;
        public List<uint> CorrectResponseNoCueFlankerIncongruent;
        public List<uint> CorrectResponseDoubleCueFlankerCongruent;
        public List<uint> CorrectResponseNoCueFlankerCongruent;
        public List<uint> CorrectResponseDoubleCueFlankerIncongruent;
        public List<uint> CorrectResponseValidCueFlankerIncongruent;
        public List<uint> CorrectResponseValidCueFlankerCongruent;
        public List<uint> CorrectResponseInvalidCueFlankerIncongruent;
        public List<uint> CorrectResponseInvalidCueFlankerCongruent;
        public List<uint> CorrectResponseNoCueLocationIncongruent;
        public List<uint> CorrectResponseDoubleCueLocationCongruent;
        public List<uint> CorrectResponseNoCueLocationCongruent;
        public List<uint> CorrectResponseDoubleCueLocationIncongruent;
        public List<uint> CorrectResponseValidCueLocationIncongruent;
        public List<uint> CorrectResponseValidCueLocationCongruent;
        public List<uint> CorrectResponseInvalidCueLocationIncongruent;
        public List<uint> CorrectResponseInvalidCueLocationCongruent;
        public List<uint> CorrectResponseInvalidCueZeroCueToTargetOnset;
        public List<uint> CorrectResponseValidCue400CueToTargetOnset;
        public List<uint> CorrectResponseInvalidCue400CueToTargetOnset;

        public List<uint> IncorrectResponseNoCue;
        public List<uint> IncorrectResponseDoubleCue;
        public List<uint> IncorrectResponseInvalidCue;
        public List<uint> IncorrectResponseValidCue;
        public List<uint> IncorrectResponseValidCueZeroCueToTargetOnset;
        public List<uint> IncorrectResponseValidCue800CueToTargetOnset;
        public List<uint> IncorrectResponseFlankerIncongruent;
        public List<uint> IncorrectResponseFlankerCongruent;
        public List<uint> IncorrectResponseLocationIncongruent;
        public List<uint> IncorrectResponseLocationCongruent;
        public List<uint> IncorrectResponseFlankerCongruentLocationCongruent;
        public List<uint> IncorrectResponseFlankerIncongruentLocationIncongruent;
        public List<uint> IncorrectResponseFlankerCongruentLocationIncongruent;
        public List<uint> IncorrectResponseFlankerIncongruentLocationCongruent;
        public List<uint> IncorrectResponseNoCueFlankerIncongruent;
        public List<uint> IncorrectResponseDoubleCueFlankerCongruent;
        public List<uint> IncorrectResponseNoCueFlankerCongruent;
        public List<uint> IncorrectResponseDoubleCueFlankerIncongruent;
        public List<uint> IncorrectResponseValidCueFlankerIncongruent;
        public List<uint> IncorrectResponseValidCueFlankerCongruent;
        public List<uint> IncorrectResponseInvalidCueFlankerIncongruent;
        public List<uint> IncorrectResponseInvalidCueFlankerCongruent;
        public List<uint> IncorrectResponseNoCueLocationIncongruent;
        public List<uint> IncorrectResponseDoubleCueLocationCongruent;
        public List<uint> IncorrectResponseNoCueLocationCongruent;
        public List<uint> IncorrectResponseDoubleCueLocationIncongruent;
        public List<uint> IncorrectResponseValidCueLocationIncongruent;
        public List<uint> IncorrectResponseValidCueLocationCongruent;
        public List<uint> IncorrectResponseInvalidCueLocationIncongruent;
        public List<uint> IncorrectResponseInvalidCueLocationCongruent;
        public List<uint> IncorrectResponseInvalidCueZeroCueToTargetOnset;
        public List<uint> IncorrectResponseValidCue400CueToTargetOnset;
        public List<uint> IncorrectResponseInvalidCue400CueToTargetOnset;

        public List<uint> IncorrectResponse;
        public List<uint> TimedOutResponse;
        public List<uint> PrematureResponse;
        public List<uint> CorrectResponse;
        public List<uint> NotCorrectResponse;

        public TrialsPerReactionTimeFactor()
        {
            CorrectResponseNoCue = new List<uint>();
            CorrectResponseDoubleCue = new List<uint>();
            CorrectResponseInvalidCue = new List<uint>();
            CorrectResponseValidCue = new List<uint>();
            CorrectResponseValidCueZeroCueToTargetOnset = new List<uint>();
            CorrectResponseValidCue800CueToTargetOnset = new List<uint>();
            CorrectResponseFlankerIncongruent = new List<uint>();
            CorrectResponseFlankerCongruent = new List<uint>();
            CorrectResponseLocationIncongruent = new List<uint>();
            CorrectResponseLocationCongruent = new List<uint>();
            CorrectResponseFlankerCongruentLocationCongruent = new List<uint>();
            CorrectResponseFlankerIncongruentLocationIncongruent = new List<uint>();
            CorrectResponseFlankerCongruentLocationIncongruent = new List<uint>();
            CorrectResponseFlankerIncongruentLocationCongruent = new List<uint>();
            CorrectResponseNoCueFlankerIncongruent = new List<uint>();
            CorrectResponseDoubleCueFlankerCongruent = new List<uint>();
            CorrectResponseNoCueFlankerCongruent = new List<uint>();
            CorrectResponseDoubleCueFlankerIncongruent = new List<uint>();
            CorrectResponseValidCueFlankerIncongruent = new List<uint>();
            CorrectResponseValidCueFlankerCongruent = new List<uint>();
            CorrectResponseInvalidCueFlankerIncongruent = new List<uint>();
            CorrectResponseInvalidCueFlankerCongruent = new List<uint>();
            CorrectResponseNoCueLocationIncongruent = new List<uint>();
            CorrectResponseDoubleCueLocationCongruent = new List<uint>();
            CorrectResponseNoCueLocationCongruent = new List<uint>();
            CorrectResponseDoubleCueLocationIncongruent = new List<uint>();
            CorrectResponseValidCueLocationIncongruent = new List<uint>();
            CorrectResponseValidCueLocationCongruent = new List<uint>();
            CorrectResponseInvalidCueLocationIncongruent = new List<uint>();
            CorrectResponseInvalidCueLocationCongruent = new List<uint>();
            CorrectResponseInvalidCueZeroCueToTargetOnset = new List<uint>();
            CorrectResponseValidCue400CueToTargetOnset = new List<uint>();
            CorrectResponseInvalidCue400CueToTargetOnset = new List<uint>();

            IncorrectResponseNoCue = new List<uint>();
            IncorrectResponseDoubleCue = new List<uint>();
            IncorrectResponseInvalidCue = new List<uint>();
            IncorrectResponseValidCue = new List<uint>();
            IncorrectResponseValidCueZeroCueToTargetOnset = new List<uint>();
            IncorrectResponseValidCue800CueToTargetOnset = new List<uint>();
            IncorrectResponseFlankerIncongruent = new List<uint>();
            IncorrectResponseFlankerCongruent = new List<uint>();
            IncorrectResponseLocationIncongruent = new List<uint>();
            IncorrectResponseLocationCongruent = new List<uint>();
            IncorrectResponseFlankerCongruentLocationCongruent = new List<uint>();
            IncorrectResponseFlankerIncongruentLocationIncongruent = new List<uint>();
            IncorrectResponseFlankerCongruentLocationIncongruent = new List<uint>();
            IncorrectResponseFlankerIncongruentLocationCongruent = new List<uint>();
            IncorrectResponseNoCueFlankerIncongruent = new List<uint>();
            IncorrectResponseDoubleCueFlankerCongruent = new List<uint>();
            IncorrectResponseNoCueFlankerCongruent = new List<uint>();
            IncorrectResponseDoubleCueFlankerIncongruent = new List<uint>();
            IncorrectResponseValidCueFlankerIncongruent = new List<uint>();
            IncorrectResponseValidCueFlankerCongruent = new List<uint>();
            IncorrectResponseInvalidCueFlankerIncongruent = new List<uint>();
            IncorrectResponseInvalidCueFlankerCongruent = new List<uint>();
            IncorrectResponseNoCueLocationIncongruent = new List<uint>();
            IncorrectResponseDoubleCueLocationCongruent = new List<uint>();
            IncorrectResponseNoCueLocationCongruent = new List<uint>();
            IncorrectResponseDoubleCueLocationIncongruent = new List<uint>();
            IncorrectResponseValidCueLocationIncongruent = new List<uint>();
            IncorrectResponseValidCueLocationCongruent = new List<uint>();
            IncorrectResponseInvalidCueLocationIncongruent = new List<uint>();
            IncorrectResponseInvalidCueLocationCongruent = new List<uint>();
            IncorrectResponseInvalidCueZeroCueToTargetOnset = new List<uint>();
            IncorrectResponseValidCue400CueToTargetOnset = new List<uint>();
            IncorrectResponseInvalidCue400CueToTargetOnset = new List<uint>();
                        
            IncorrectResponse = new List<uint>();
            TimedOutResponse = new List<uint>();
            PrematureResponse = new List<uint>();
            CorrectResponse = new List<uint>();
            NotCorrectResponse = new List<uint>();
        }
    }
}

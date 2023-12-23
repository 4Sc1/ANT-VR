using System;

namespace VR_Processor
{
    [Serializable]
    public enum TrialResultType
    {
        Premature = 0,
        TimeOut = 1,
        Correct = 2,
        Incorrect = 3,
        Count = 4
    }
}
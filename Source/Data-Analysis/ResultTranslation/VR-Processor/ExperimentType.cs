using System;

namespace VR_Processor
{
    [Serializable]
    public enum ExperimentType
    {
        UNKNOWN = -1,
        Admin = 0,
        Practice = 1,
        Original = 2,
        Balanced = 3,
        Noise = 4,        
        Count = 6
    }
}

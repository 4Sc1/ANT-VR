using System;

namespace Assets.Tasks.AttentionalNetwork.Scripts
{
    [Serializable]
    public enum CueTargetCondition
    {
        NoCueTargetLeft = 0,
        CueLeftTargetLeft = 1,
        CueRightTargetLeft = 2,
        DoubleCueTargetLeft = 3,
        NoCueTargetRight = 4,
        CueRightTargetRight = 5,
        CueLeftTargetRight = 6,
        DoubleCueTargetRight = 7,
        Count = 8
    }
}

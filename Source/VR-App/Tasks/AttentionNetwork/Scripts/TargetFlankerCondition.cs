using System;

namespace Assets.Tasks.AttentionalNetwork.Scripts
{
    [Serializable]
    public enum TargetFlankerCondition
    {
        PhoneFlankedByPhones = 0,
        TabletFlankedByTablets = 1,
        PhoneFlankedByTablets = 2,
        TabletFlankedByPhones = 3,
        Count = 4
    }
}
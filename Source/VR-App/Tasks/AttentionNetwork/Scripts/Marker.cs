using System;

namespace Assets.Tasks.AttentionalNetwork.Scripts
{
    [Serializable]
    public enum Marker
    {
        Error = -1,
        Pause = 0,
        CuePresentation = 1,
        CueTargetInterval = 2,
        TargetPresentation = 3,
        TargetPresentationAndResponseCollection = 4,
        PostTargetInterval = 5,
        ButtonPress = 6,
        ResponseCollectionEnd = 7,        
        Count = 9
    }
}

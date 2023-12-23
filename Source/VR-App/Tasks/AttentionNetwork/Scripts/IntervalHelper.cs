namespace Assets.Tasks.AttentionalNetwork.Scripts
{    
    internal static class IntervalHelper
    {
        internal static double GetPostTargetFixationInterval(PostTargetFixationInterval postTargetFixationInterval)
        {
            switch(postTargetFixationInterval)
            {
                case PostTargetFixationInterval.Interval2000:
                    return 2.000;
                case PostTargetFixationInterval.Interval2250:
                    return 2.250;
                case PostTargetFixationInterval.Interval2500:
                    return 2.500;
                case PostTargetFixationInterval.Interval2750:
                    return 2.750;
                case PostTargetFixationInterval.Interval3000:
                    return 3.000;
                case PostTargetFixationInterval.Interval3250:
                    return 3.250;
                case PostTargetFixationInterval.Interval3500:
                    return 3.500;
                case PostTargetFixationInterval.Interval3750:
                    return 3.750;
                case PostTargetFixationInterval.Interval4000:
                    return 4.000;
                case PostTargetFixationInterval.Interval4250:
                    return 4.250;
                case PostTargetFixationInterval.Interval4750:
                    return 4.750;
                case PostTargetFixationInterval.Interval12000:
                    return 12.000;
            }

            return 0.000;
        }

        internal static double GetCueTargetInterval(CueTargetInterval cueTargetInterval)
        {
            switch (cueTargetInterval)
            {
                case CueTargetInterval.Interval0:
                    return 0.000;
                case CueTargetInterval.Interval400:
                    return 0.400;
                case CueTargetInterval.Interval800:
                    return 0.800;                
            }

            return 0.000;
        }
    }
}

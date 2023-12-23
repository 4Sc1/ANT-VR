using System;

namespace Assets.Tasks.AttentionalNetwork.Scripts
{
    [Serializable]
    public class ReactionTimeFactor
    {
        public uint ResultCount;
        public double RTMax;
        public double RTMean;
        public double RTMedian;
        public double RTMin;
        public double Accuracy;

        public ReactionTimeFactor()
        {
            ResultCount = 0;
            RTMax = double.NaN;
            RTMean = double.NaN;
            RTMedian = double.NaN;
            RTMin = double.NaN;
            Accuracy = double.NaN;
        }
    }
}

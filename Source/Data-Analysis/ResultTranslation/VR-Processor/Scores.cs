using System;

namespace VR_Processor
{
    [Serializable]
    public class Scores
    {
        public TrialsPerReactionTimeFactor TrialsPerReactionTimeFactor;
        public ReactionTimeFactors ReactionTimeFactors;

        public double AlertingBenefit;
        public double ValidityEffect;
        public double DisengagingCost;
        public double OrientingTime;
        public double FlankerConflictEffect;
        public double LocationConflictEffect;
        public double FlankerByLocationInteraction;
        public double AlertingByFlankerConflict;
        public double OrientingByFlankerConflict;
        public double ValidityByFlankerConflict;
        public double AlertingByLocationConflict;
        public double OrientingByLocationConflict;
        public double ValidityByLocationConflict;
        public double InhibitionOfReturnEffect;

        public Scores()
        {

        }
    }
}

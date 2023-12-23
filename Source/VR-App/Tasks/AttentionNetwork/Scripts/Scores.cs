using System;

namespace Assets.Tasks.AttentionalNetwork.Scripts
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

        public Scores(TrialsPerReactionTimeFactor trialsPerReactionTimeFactor, ReactionTimeFactors reactionTimeFactors, double alertingBenefit, double validityEffect, double disengagingCost, double orientingTime, double flankerConflictEffect,
        double locationConflictEffect, double flankerByLocationInteraction, double alertingByFlankerConflict, double orientingByFlankerConflict,
        double validityByFlankerConflict, double alertingByLocationConflict, double orientingByLocationConflict, double validityByLocationConflict,
        double inhibitionOfReturnEffect)
        {
            TrialsPerReactionTimeFactor = trialsPerReactionTimeFactor;
            ReactionTimeFactors = reactionTimeFactors;
            AlertingBenefit = alertingBenefit;
            ValidityEffect = validityEffect;
            DisengagingCost = disengagingCost;
            OrientingTime = orientingTime;
            FlankerConflictEffect = flankerConflictEffect;
            LocationConflictEffect = locationConflictEffect;
            FlankerByLocationInteraction = flankerByLocationInteraction;
            AlertingByFlankerConflict = alertingByFlankerConflict;
            OrientingByFlankerConflict = orientingByFlankerConflict;
            ValidityByFlankerConflict = validityByFlankerConflict;
            AlertingByLocationConflict = alertingByLocationConflict;
            OrientingByLocationConflict = orientingByLocationConflict;
            ValidityByLocationConflict = validityByLocationConflict;
            InhibitionOfReturnEffect = inhibitionOfReturnEffect;
        }
    }
}

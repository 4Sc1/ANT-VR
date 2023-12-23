using System;
using UnityEngine;

namespace Assets.Tasks.AttentionalNetwork.Scripts
{
    internal static class ResultScorer
    {
        public static Scores Calculate(Trial[] trials, TrialResult[] results, uint currentResults, bool phoneIsOnTheLeft)
        {
            try
            {
                if (trials == null)
                {
                    Debug.Log(@"Aborted. " + nameof(trials) + @" is null.");
                    return null;
                }


                if (results == null)
                {
                    Debug.Log(@"Aborted. " + nameof(results) + @" is null.");
                    return null;
                }

                Debug.Log(nameof(currentResults) + @" = " + currentResults + @"," + nameof(trials.Length) + @" = " + trials.Length + @", " + nameof(results.Length) + @" = " + results.Length + @".");

                var trialsPerReactionTimeFactor = new TrialsPerReactionTimeFactor(phoneIsOnTheLeft);

                for (var i = 0; i < currentResults; i++)
                    trialsPerReactionTimeFactor.AddTrialResultToReactionTimes(trials[i], results[i]);

                var reactionTimeFactors = new ReactionTimeFactors(results, trialsPerReactionTimeFactor);

                double alertingBenefit = GetAlertingBenefit(reactionTimeFactors);
                double validityEffect = GetValidityEffect(reactionTimeFactors);
                double disengagingCost = GetDisengagingCost(reactionTimeFactors);
                double orientingTime = GetOrientingTime(reactionTimeFactors);
                double flankerConflictEffect = GetFlankerConflictEffect(reactionTimeFactors);
                double locationConflictEffect = GetLocationConflictEffect(reactionTimeFactors);
                double flankerByLocationInteraction = GetFlankerByLocationInteraction(reactionTimeFactors);
                double alertingByFlankerConflict = GetAlertingByFlankerConflict(reactionTimeFactors);
                double orientingByFlankerConflict = GetOrientingByFlankerConflict(reactionTimeFactors);
                double validityByFlankerConflict = GetValidityByFlankerConflict(reactionTimeFactors);
                double alertingByLocationConflict = GetAlertingByLocationConflict(reactionTimeFactors);
                double orientingByLocationConflict = GetOrientingByLocationConflict(reactionTimeFactors);
                double validityByLocationConflict = GetValidityByLocationConflict(reactionTimeFactors);
                double inhibitionOfReturnEffect = GetInhibitionOfReturnEffect(reactionTimeFactors);

                return new Scores(trialsPerReactionTimeFactor, reactionTimeFactors, alertingBenefit, validityEffect, disengagingCost, orientingTime, flankerConflictEffect, locationConflictEffect, flankerByLocationInteraction, alertingByFlankerConflict, orientingByFlankerConflict, validityByFlankerConflict, alertingByLocationConflict, orientingByLocationConflict, validityByLocationConflict, inhibitionOfReturnEffect);
            }
            catch (Exception ex)
            {
                Debug.LogError(ex);
            }

            return null;
        }

        private static double GetAlertingBenefit(ReactionTimeFactors rtfs)
        {
            if (double.IsNaN(rtfs.NoCue.RTMean) || double.IsNaN(rtfs.DoubleCue.RTMean))
                return double.NaN;

            return rtfs.NoCue.RTMean - rtfs.DoubleCue.RTMean;
        }

        private static double GetValidityEffect(ReactionTimeFactors rtfs)
        {
            if (double.IsNaN(rtfs.InvalidCue.RTMean) || double.IsNaN(rtfs.ValidCue.RTMean))
                return double.NaN;

            return rtfs.InvalidCue.RTMean - rtfs.ValidCue.RTMean;
        }

        private static double GetDisengagingCost(ReactionTimeFactors rtfs)
        {
            if (double.IsNaN(rtfs.InvalidCue.RTMean) || double.IsNaN(rtfs.DoubleCue.RTMean))
                return double.NaN;

            return rtfs.InvalidCue.RTMean - rtfs.DoubleCue.RTMean;
        }

        private static double GetOrientingTime(ReactionTimeFactors rtfs)
        {
            if (double.IsNaN(rtfs.ValidCueZeroCueToTargetOnset.RTMean) || double.IsNaN(rtfs.ValidCue800CueToTargetOnset.RTMean))
                return double.NaN;

            return rtfs.ValidCueZeroCueToTargetOnset.RTMean - rtfs.ValidCue800CueToTargetOnset.RTMean;
        }

        private static double GetFlankerConflictEffect(ReactionTimeFactors rtfs)
        {
            if (double.IsNaN(rtfs.FlankerIncongruent.RTMean) || double.IsNaN(rtfs.FlankerCongruent.RTMean))
                return double.NaN;

            return rtfs.FlankerIncongruent.RTMean - rtfs.FlankerCongruent.RTMean;
        }

        private static double GetLocationConflictEffect(ReactionTimeFactors rtfs)
        {
            if (double.IsNaN(rtfs.LocationIncongruent.RTMean) || double.IsNaN(rtfs.LocationCongruent.RTMean))
                return double.NaN;

            return rtfs.LocationIncongruent.RTMean - rtfs.LocationCongruent.RTMean;
        }

        private static double GetFlankerByLocationInteraction(ReactionTimeFactors rtfs)
        {
            if (double.IsNaN(rtfs.FlankerCongruentLocationCongruent.RTMean) || double.IsNaN(rtfs.FlankerIncongruentLocationIncongruent.RTMean) || double.IsNaN(rtfs.FlankerCongruentLocationIncongruent.RTMean) || double.IsNaN(rtfs.FlankerIncongruentLocationCongruent.RTMean))
                return double.NaN;

            return rtfs.FlankerCongruentLocationCongruent.RTMean + rtfs.FlankerIncongruentLocationIncongruent.RTMean - rtfs.FlankerCongruentLocationIncongruent.RTMean - rtfs.FlankerIncongruentLocationCongruent.RTMean;
        }

        private static double GetAlertingByFlankerConflict(ReactionTimeFactors rtfs)
        {
            if (double.IsNaN(rtfs.NoCueFlankerIncongruent.RTMean) || double.IsNaN(rtfs.DoubleCueFlankerCongruent.RTMean) || double.IsNaN(rtfs.NoCueFlankerCongruent.RTMean) || double.IsNaN(rtfs.DoubleCueFlankerIncongruent.RTMean))
                return double.NaN;

            return rtfs.NoCueFlankerIncongruent.RTMean + rtfs.DoubleCueFlankerCongruent.RTMean - rtfs.NoCueFlankerCongruent.RTMean - rtfs.DoubleCueFlankerIncongruent.RTMean;
        }

        private static double GetOrientingByFlankerConflict(ReactionTimeFactors rtfs)
        {
            if (double.IsNaN(rtfs.DoubleCueFlankerIncongruent.RTMean) || double.IsNaN(rtfs.ValidCueFlankerCongruent.RTMean) || double.IsNaN(rtfs.DoubleCueFlankerCongruent.RTMean) || double.IsNaN(rtfs.ValidCueFlankerIncongruent.RTMean))
                return double.NaN;

            return rtfs.DoubleCueFlankerIncongruent.RTMean + rtfs.ValidCueFlankerCongruent.RTMean - rtfs.DoubleCueFlankerCongruent.RTMean - rtfs.ValidCueFlankerIncongruent.RTMean;
        }

        private static double GetValidityByFlankerConflict(ReactionTimeFactors rtfs)
        {
            if (double.IsNaN(rtfs.InvalidCueFlankerIncongruent.RTMean) || double.IsNaN(rtfs.ValidCueFlankerCongruent.RTMean) || double.IsNaN(rtfs.InvalidCueFlankerCongruent.RTMean) || double.IsNaN(rtfs.ValidCueFlankerIncongruent.RTMean))
                return double.NaN;

            return rtfs.InvalidCueFlankerIncongruent.RTMean + rtfs.ValidCueFlankerCongruent.RTMean - rtfs.InvalidCueFlankerCongruent.RTMean - rtfs.ValidCueFlankerIncongruent.RTMean;
        }

        private static double GetAlertingByLocationConflict(ReactionTimeFactors rtfs)
        {
            if (double.IsNaN(rtfs.NoCueLocationIncongruent.RTMean) || double.IsNaN(rtfs.DoubleCueLocationCongruent.RTMean) || double.IsNaN(rtfs.NoCueLocationCongruent.RTMean) || double.IsNaN(rtfs.DoubleCueLocationIncongruent.RTMean))
                return double.NaN;

            return rtfs.NoCueLocationIncongruent.RTMean + rtfs.DoubleCueLocationCongruent.RTMean - rtfs.NoCueLocationCongruent.RTMean - rtfs.DoubleCueLocationIncongruent.RTMean;
        }

        private static double GetOrientingByLocationConflict(ReactionTimeFactors rtfs)
        {
            if (double.IsNaN(rtfs.DoubleCueLocationIncongruent.RTMean) || double.IsNaN(rtfs.ValidCueLocationCongruent.RTMean) || double.IsNaN(rtfs.DoubleCueLocationCongruent.RTMean) || double.IsNaN(rtfs.ValidCueLocationIncongruent.RTMean))
                return double.NaN;

            return rtfs.DoubleCueLocationIncongruent.RTMean + rtfs.ValidCueLocationCongruent.RTMean - rtfs.DoubleCueLocationCongruent.RTMean - rtfs.ValidCueLocationIncongruent.RTMean;
        }

        private static double GetValidityByLocationConflict(ReactionTimeFactors rtfs)
        {
            if (double.IsNaN(rtfs.InvalidCueLocationIncongruent.RTMean) || double.IsNaN(rtfs.ValidCueLocationCongruent.RTMean) || double.IsNaN(rtfs.InvalidCueLocationCongruent.RTMean) || double.IsNaN(rtfs.ValidCueLocationIncongruent.RTMean))
                return double.NaN;

            return rtfs.InvalidCueLocationIncongruent.RTMean + rtfs.ValidCueLocationCongruent.RTMean - rtfs.InvalidCueLocationCongruent.RTMean - rtfs.ValidCueLocationIncongruent.RTMean;
        }

        private static double GetInhibitionOfReturnEffect(ReactionTimeFactors rtfs)
        {
            if (double.IsNaN(rtfs.InvalidCueZeroCueToTargetOnset.RTMean) || double.IsNaN(rtfs.ValidCue400CueToTargetOnset.RTMean) || double.IsNaN(rtfs.ValidCueZeroCueToTargetOnset.RTMean) || double.IsNaN(rtfs.InvalidCue400CueToTargetOnset.RTMean))
                return double.NaN;

            return rtfs.InvalidCueZeroCueToTargetOnset.RTMean + rtfs.ValidCue400CueToTargetOnset.RTMean - rtfs.ValidCueZeroCueToTargetOnset.RTMean - rtfs.InvalidCue400CueToTargetOnset.RTMean;
        }
    }
}

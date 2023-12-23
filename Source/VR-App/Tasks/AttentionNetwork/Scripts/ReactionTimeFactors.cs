using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Assets.Tasks.AttentionalNetwork.Scripts
{
    [Serializable]
    public class ReactionTimeFactors
    {
        public ReactionTimeFactor NoCue;
        public ReactionTimeFactor DoubleCue;
        public ReactionTimeFactor InvalidCue;
        public ReactionTimeFactor ValidCue;
        public ReactionTimeFactor ValidCueZeroCueToTargetOnset;
        public ReactionTimeFactor ValidCue800CueToTargetOnset;
        public ReactionTimeFactor FlankerIncongruent;
        public ReactionTimeFactor FlankerCongruent;
        public ReactionTimeFactor LocationIncongruent;
        public ReactionTimeFactor LocationCongruent;
        public ReactionTimeFactor FlankerCongruentLocationCongruent;
        public ReactionTimeFactor FlankerIncongruentLocationIncongruent;
        public ReactionTimeFactor FlankerCongruentLocationIncongruent;
        public ReactionTimeFactor FlankerIncongruentLocationCongruent;
        public ReactionTimeFactor NoCueFlankerIncongruent;
        public ReactionTimeFactor DoubleCueFlankerCongruent;
        public ReactionTimeFactor NoCueFlankerCongruent;
        public ReactionTimeFactor DoubleCueFlankerIncongruent;
        public ReactionTimeFactor ValidCueFlankerIncongruent;
        public ReactionTimeFactor ValidCueFlankerCongruent;
        public ReactionTimeFactor InvalidCueFlankerIncongruent;
        public ReactionTimeFactor InvalidCueFlankerCongruent;
        public ReactionTimeFactor NoCueLocationIncongruent;
        public ReactionTimeFactor DoubleCueLocationCongruent;
        public ReactionTimeFactor NoCueLocationCongruent;
        public ReactionTimeFactor DoubleCueLocationIncongruent;
        public ReactionTimeFactor ValidCueLocationIncongruent;
        public ReactionTimeFactor ValidCueLocationCongruent;
        public ReactionTimeFactor InvalidCueLocationIncongruent;
        public ReactionTimeFactor InvalidCueLocationCongruent;
        public ReactionTimeFactor InvalidCueZeroCueToTargetOnset;
        public ReactionTimeFactor ValidCue400CueToTargetOnset;
        public ReactionTimeFactor InvalidCue400CueToTargetOnset;
        public ReactionTimeFactor Overall;

        public ReactionTimeFactors()
        {

        }

        internal ReactionTimeFactors(TrialResult[] results, TrialsPerReactionTimeFactor trialsPerReactionTimeFactor)
        {
            CalculateReactionTimeFactors(results, trialsPerReactionTimeFactor);
        }

        private void CalculateReactionTimeFactors(TrialResult[] results, TrialsPerReactionTimeFactor tPRTF)
        {
            try
            {
                if (results == null)
                {
                    Debug.Log(@"Aborted. " + nameof(results) + @" is null.");
                    return;
                }

                if (tPRTF == null)
                {
                    Debug.Log(@"Aborted. " + nameof(tPRTF) + @" is null.");
                    return;
                }

                Debug.Log(@"C Block 1");

                var resultsByTrialNumber = new Dictionary<uint, TrialResult>();

                foreach (var result in results)
                {
                    if (result == null)
                    {
                        Debug.Log(@"Skipped. " + nameof(result) + @" is null.");
                        continue;
                    }

                    resultsByTrialNumber.Add(result.TrialNumber, result);
                }

                Overall = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponse, tPRTF.NotCorrectResponse);
                NoCue = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseNoCue, tPRTF.IncorrectResponseNoCue);
                DoubleCue = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseDoubleCue, tPRTF.IncorrectResponseDoubleCue);
                InvalidCue = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseInvalidCue, tPRTF.IncorrectResponseInvalidCue);
                ValidCue = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseValidCue, tPRTF.IncorrectResponseValidCue);
                ValidCueZeroCueToTargetOnset = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseValidCueZeroCueToTargetOnset, tPRTF.IncorrectResponseValidCueZeroCueToTargetOnset);
                ValidCue800CueToTargetOnset = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseValidCue800CueToTargetOnset, tPRTF.IncorrectResponseValidCue800CueToTargetOnset);
                FlankerIncongruent = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseFlankerIncongruent, tPRTF.IncorrectResponseFlankerIncongruent);
                FlankerCongruent = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseFlankerCongruent, tPRTF.IncorrectResponseFlankerCongruent);
                LocationIncongruent = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseLocationIncongruent, tPRTF.IncorrectResponseLocationIncongruent);

                Debug.Log(@"C Block 5");

                LocationCongruent = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseLocationCongruent, tPRTF.IncorrectResponseLocationCongruent);
                FlankerCongruentLocationCongruent = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseFlankerCongruentLocationCongruent, tPRTF.IncorrectResponseFlankerCongruentLocationCongruent);
                FlankerIncongruentLocationIncongruent = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseFlankerIncongruentLocationIncongruent, tPRTF.IncorrectResponseFlankerIncongruentLocationIncongruent);
                FlankerCongruentLocationIncongruent = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseFlankerCongruentLocationIncongruent, tPRTF.IncorrectResponseFlankerCongruentLocationIncongruent);
                FlankerIncongruentLocationCongruent = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseFlankerIncongruentLocationCongruent, tPRTF.IncorrectResponseFlankerIncongruentLocationCongruent);
                NoCueFlankerIncongruent = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseNoCueFlankerIncongruent, tPRTF.IncorrectResponseNoCueFlankerIncongruent);
                DoubleCueFlankerCongruent = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseDoubleCueFlankerCongruent, tPRTF.IncorrectResponseDoubleCueFlankerCongruent);
                NoCueFlankerCongruent = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseNoCueFlankerCongruent, tPRTF.IncorrectResponseNoCueFlankerCongruent);
                DoubleCueFlankerIncongruent = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseDoubleCueFlankerIncongruent, tPRTF.IncorrectResponseDoubleCueFlankerIncongruent);
                ValidCueFlankerIncongruent = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseValidCueFlankerIncongruent, tPRTF.IncorrectResponseValidCueFlankerIncongruent);

                Debug.Log(@"C Block 6");

                ValidCueFlankerCongruent = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseValidCueFlankerCongruent, tPRTF.IncorrectResponseValidCueFlankerCongruent);
                InvalidCueFlankerIncongruent = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseInvalidCueFlankerIncongruent, tPRTF.IncorrectResponseInvalidCueFlankerIncongruent);
                InvalidCueFlankerCongruent = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseInvalidCueFlankerCongruent, tPRTF.IncorrectResponseInvalidCueFlankerCongruent);
                NoCueLocationIncongruent = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseNoCueLocationIncongruent, tPRTF.IncorrectResponseNoCueLocationIncongruent);
                DoubleCueLocationCongruent = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseDoubleCueLocationCongruent, tPRTF.IncorrectResponseDoubleCueLocationCongruent);
                NoCueLocationCongruent = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseNoCueLocationCongruent, tPRTF.IncorrectResponseNoCueLocationCongruent);
                DoubleCueLocationIncongruent = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseDoubleCueLocationIncongruent, tPRTF.IncorrectResponseDoubleCueLocationIncongruent);
                ValidCueLocationIncongruent = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseValidCueLocationIncongruent, tPRTF.IncorrectResponseValidCueLocationIncongruent);
                ValidCueLocationCongruent = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseValidCueLocationCongruent, tPRTF.IncorrectResponseValidCueLocationCongruent);
                InvalidCueLocationIncongruent = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseInvalidCueLocationIncongruent, tPRTF.IncorrectResponseInvalidCueLocationIncongruent);
                InvalidCueLocationCongruent = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseInvalidCueLocationCongruent, tPRTF.IncorrectResponseInvalidCueLocationCongruent);
                InvalidCueZeroCueToTargetOnset = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseInvalidCueZeroCueToTargetOnset, tPRTF.IncorrectResponseInvalidCueZeroCueToTargetOnset);
                ValidCue400CueToTargetOnset = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseValidCue400CueToTargetOnset, tPRTF.IncorrectResponseValidCue400CueToTargetOnset);
                InvalidCue400CueToTargetOnset = CalculateFactor(resultsByTrialNumber, tPRTF.CorrectResponseInvalidCue400CueToTargetOnset, tPRTF.IncorrectResponseInvalidCue400CueToTargetOnset);

            }
            catch (Exception ex)
            {
                Debug.Log(ex);
            }
        }

        private ReactionTimeFactor CalculateFactor(Dictionary<uint, TrialResult> resultsByTrialNumber, List<uint> correctTrialsContributingToFactor, List<uint> incorrectTrialsContributingToFactor)
        {
            var rtFactor = new ReactionTimeFactor();

            try
            {
                if (!(resultsByTrialNumber?.Any() == true))
                {
                    //if (Debug.isDebugBuild)
                    Debug.Log(nameof(resultsByTrialNumber) + @" is null.");
                    return rtFactor;
                }

                if (correctTrialsContributingToFactor == null)
                {
                    //if (Debug.isDebugBuild)
                    Debug.Log(nameof(correctTrialsContributingToFactor) + @" is null.");
                    return rtFactor;
                }

                if (incorrectTrialsContributingToFactor == null)
                {
                    //if (Debug.isDebugBuild)
                    Debug.Log(nameof(incorrectTrialsContributingToFactor) + @" is null.");
                    return rtFactor;
                }

                var rTs = new List<double>();

                foreach (uint trialNumber in correctTrialsContributingToFactor)
                {
                    if (resultsByTrialNumber.ContainsKey(trialNumber))
                    {
                        var rt = resultsByTrialNumber.GetValueOrDefault(trialNumber)?.ReactionTimeInSeconds;

                        if (rt >= 0)
                            rTs.Add(resultsByTrialNumber.GetValueOrDefault(trialNumber).ReactionTimeInSeconds);
                    }
                }

                var allCount = (double)(correctTrialsContributingToFactor.Count() + incorrectTrialsContributingToFactor.Count());

                if (!allCount.Equals(0d))
                    rtFactor.Accuracy = correctTrialsContributingToFactor.Count() * 100.0d / allCount;

                if (!rTs.Any())
                {
                    Debug.Log(nameof(rTs) + @" is empty.");
                    return rtFactor;
                }

                var orderedRTs = rTs.OrderBy((rt) => rt).ToList();

                rtFactor.ResultCount = (uint)orderedRTs.Count;
                rtFactor.RTMin = orderedRTs.FirstOrDefault();
                rtFactor.RTMax = orderedRTs.LastOrDefault();
                rtFactor.RTMean = orderedRTs.Sum() / orderedRTs.Count;
                rtFactor.RTMedian = GetMedian(orderedRTs);
            }
            catch (Exception ex)
            {
                //if (Debug.isDebugBuild)
                Debug.Log(ex);
            }

            return rtFactor;
        }

        private double GetMedian(List<double> values)
        {
            try
            {
                if (!(values?.Any() == true))
                    return double.NaN;

                if (values.Count % 2 == 0)
                    return (values[values.Count / 2] + values[values.Count / 2 - 1]) / 2.0d;
                else
                    return values[(int)Math.Floor(values.Count / 2.0d)];
            }
            catch(Exception ex)
            {
                Debug.Log(ex);
            }

            return double.NaN;
        }

        private double ACCCalculateFactor(List<uint> validTrialsContributingToFactor, List<uint> invalidTrialsContributingToFactor)
        {
            try
            {

                if (invalidTrialsContributingToFactor is null)
                {
                    //if (Debug.isDebugBuild)
                    Debug.Log(nameof(invalidTrialsContributingToFactor) + @" is null.");
                    return double.NaN;
                }

                if (validTrialsContributingToFactor is null)
                {
                    //if (Debug.isDebugBuild)
                    Debug.Log(nameof(validTrialsContributingToFactor) + @" is null.");
                    return double.NaN;
                }

                var allCount = (double)(validTrialsContributingToFactor.Count() + invalidTrialsContributingToFactor.Count());

                if (allCount.Equals(0d))
                {
                    //if (Debug.isDebugBuild)
                    Debug.Log(nameof(validTrialsContributingToFactor) + @" and " + nameof(invalidTrialsContributingToFactor) + @" are empty.");
                    return double.NaN;
                }

                return validTrialsContributingToFactor.Count() * 100.0d / allCount;
            }
            catch (Exception ex)
            {
                //if (Debug.isDebugBuild)
                Debug.Log(ex);
            }

            return double.NaN;
        }

        private double ACCCalculateFactorOverall(List<uint> validTrials, List<uint> invalidTrials, List<uint> prematureTrials, List<uint> timedOutTrials)
        {
            try
            {

                if (validTrials is null)
                {
                    //if (Debug.isDebugBuild)
                    Debug.Log(nameof(validTrials) + @" is null.");
                    return double.NaN;
                }

                if (invalidTrials is null)
                {
                    //if (Debug.isDebugBuild)
                    Debug.Log(nameof(invalidTrials) + @" is null.");
                    return double.NaN;
                }

                if (prematureTrials is null)
                {
                    //if (Debug.isDebugBuild)
                    Debug.Log(nameof(prematureTrials) + @" is null.");
                    return double.NaN;
                }

                if (timedOutTrials is null)
                {
                    //if (Debug.isDebugBuild)
                    Debug.Log(nameof(timedOutTrials) + @" is null.");
                    return double.NaN;
                }

                var allCount = validTrials.Count() + invalidTrials.Count() + prematureTrials.Count() + timedOutTrials.Count();

                if (allCount.Equals(0d))
                {
                    //if (Debug.isDebugBuild)
                    Debug.Log(@"All trials are empty.");
                    return double.NaN;
                }

                return validTrials.Count() * 100.0d / allCount;
            }
            catch (Exception ex)
            {
                //if (Debug.isDebugBuild)
                Debug.Log(ex);
            }

            return double.NaN;
        }

    }
}

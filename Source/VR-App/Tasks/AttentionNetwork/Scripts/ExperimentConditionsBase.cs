using Assets.Helpers.Scripts;
using System;
using System.Linq;
using System.Collections.Generic;
using UnityEngine;

namespace Assets.Tasks.AttentionalNetwork.Scripts
{
    [Serializable]
    public class ExperimentConditionsBase
    {
        private const int CueTargetConditionCount = 12;

        public ExperimentType ExperimentType;
        public uint TrialCount;
        public uint ExperimentStartDelay;
        public uint CuePresentationTimeSpan;
        public uint TargetPresentationTimeSpan;
        public uint ResponseCollectionOnset;
        public uint ResponseCollectionEnd;
        public uint InterExperimentPartTimeSpan;
        public uint FixedDeltaTime;
        public bool RandomizeCueTargetConditions;
        public bool IsLimitedTestRun;
        public bool PhoneIsOnTheLeft;
        public bool PlayBackgroundNoise;
        public bool UseOriginalCueTargetConditions;
        public CueTargetCondition[] CueTargetConditions;
        public CueTargetCondition[] CueTargetConditionsOrder;
        public Trial[] Trials;

        protected ExperimentConditionsBase()
        {

        }

        protected ExperimentConditionsBase(ExperimentType experimentType, uint experimentStartDelay, uint cuePresentationTimeSpan, uint targetPresentationTimeSpan, uint responseCollectionOnset, uint responseCollectionEnd, uint fixedDeltaTime, bool randomizeCueTargetConditions, bool isLimitedTestRun, bool phoneIsOnTheLeft, bool playBackgroundNoise, bool useOriginalCueTargetConditions)
        {
            //Debug.Log(nameof(ExperimentConditionsBase) + @": Entered.");
            ExperimentType = experimentType;
            TrialCount = (uint)(CueTargetConditionCount * CueTargetConditionCount);

            if (experimentType == ExperimentType.Original || experimentType == ExperimentType.Practice)
                TrialCount *= 2;

            ExperimentStartDelay = experimentStartDelay;
            CuePresentationTimeSpan = cuePresentationTimeSpan;
            TargetPresentationTimeSpan = targetPresentationTimeSpan;
            ResponseCollectionOnset = responseCollectionOnset;
            ResponseCollectionEnd = responseCollectionEnd;            
            FixedDeltaTime = fixedDeltaTime;
            RandomizeCueTargetConditions = randomizeCueTargetConditions;
            IsLimitedTestRun = isLimitedTestRun;
            PhoneIsOnTheLeft = phoneIsOnTheLeft;
            PlayBackgroundNoise = playBackgroundNoise;
            UseOriginalCueTargetConditions = useOriginalCueTargetConditions;


            if (useOriginalCueTargetConditions)
                CueTargetConditions = GetOriginalCueTargetConditions();
            else
                CueTargetConditions = GetBalancedCueTargetConditions();

            //Debug.Log(nameof(ExperimentConditionsBase) + @": " + nameof(TrialCount) + @" = " + TrialCount.ToString() + @".");
            //Debug.Log(nameof(ExperimentConditionsBase) + @": " + nameof(CuePresentationTimeSpan) + @" = " + CuePresentationTimeSpan.ToString() + @".");            
            //Debug.Log(nameof(ExperimentConditionsBase) + @": " + nameof(TargetPresentationTimeSpan) + @" = " + TargetPresentationTimeSpan.ToString() + @".");            
            //Debug.Log(nameof(ExperimentConditionsBase) + @": " + nameof(ResponseCollectionOnset) + @" = " + ResponseCollectionOnset.ToString() + @".");
            //Debug.Log(nameof(ExperimentConditionsBase) + @": " + nameof(ResponseCollectionEnd) + @" = " + ResponseCollectionEnd.ToString() + @".");
            //Debug.Log(nameof(ExperimentConditionsBase) + @": " + nameof(InterExperimentRunTimeSpan) + @" = " + InterExperimentRunTimeSpan.ToString() + @".");
            //Debug.Log(nameof(ExperimentConditionsBase) + @": " + nameof(InterExperimentPartTimeSpan) + @" = " + InterExperimentPartTimeSpan.ToString() + @".");
            //Debug.Log(nameof(ExperimentConditionsBase) + @": " + nameof(RandomizeCueTargetConditions) + @" = " + RandomizeCueTargetConditions.ToString() + @".");
            //Debug.Log(nameof(ExperimentConditionsBase) + @": " + nameof(IsLimitedTestRun) + @" = " + IsLimitedTestRun.ToString() + @".");
            //Debug.Log(nameof(ExperimentConditionsBase) + @": " + nameof(CueTargetConditions) + @"." + nameof(CueTargetConditions.Length) + @" = " + CueTargetConditions.Length.ToString() + @".");

            var targetFlankerConditionAndCueTargetIntervalTuplePerOrderedCueTargetCondition = new Dictionary<int, TargetFlankerConditionAndCueTargetIntervalTuple[]>();
            var postTargetFixationIntervalPerOrderedCueTargetCondition = new Dictionary<int, uint[]>();

            if (randomizeCueTargetConditions)
                CueTargetConditionsOrder = GetRandomizedOrder(CueTargetConditions);
            else
                CueTargetConditionsOrder = CueTargetConditions;

            //Debug.Log(nameof(ExperimentConditionsBase) + @": " + nameof(CueTargetConditionsOrder) + @"." + nameof(CueTargetConditionsOrder.Length) + @" = " + CueTargetConditionsOrder.Length.ToString() + @".");

            //Debug.Log(nameof(ExperimentConditionsBase) + @": First block of initializations imminent.");

            uint[] postTargetFixationIntervals = new uint[] { (uint)PostTargetFixationInterval.Interval2000, (uint)PostTargetFixationInterval.Interval2250, (uint)PostTargetFixationInterval.Interval2500, (uint)PostTargetFixationInterval.Interval2750, (uint)PostTargetFixationInterval.Interval3000, (uint)PostTargetFixationInterval.Interval3250, (uint)PostTargetFixationInterval.Interval3500, (uint)PostTargetFixationInterval.Interval3750, (uint)PostTargetFixationInterval.Interval4000, (uint)PostTargetFixationInterval.Interval4250, (uint)PostTargetFixationInterval.Interval4750, (uint)PostTargetFixationInterval.Interval12000 };

            for (int i = 0; i < CueTargetConditionsOrder.Length; i++)
            {
                var conditionTuples = new TargetFlankerConditionAndCueTargetIntervalTuple[(int)TargetFlankerCondition.Count * (int)CueTargetInterval.Count];

                for (int tfc = 0; tfc < (int)TargetFlankerCondition.Count; tfc++)
                {
                    for (int cettots = 0; cettots < (int)CueTargetInterval.Count; cettots++)
                        conditionTuples[tfc * (int)CueTargetInterval.Count + cettots] = new TargetFlankerConditionAndCueTargetIntervalTuple((TargetFlankerCondition)tfc, (CueTargetInterval)cettots);
                }

                var targetFlankerConditionAndCueTargetIntervalTuple = GetRandomizedOrder(conditionTuples);
                targetFlankerConditionAndCueTargetIntervalTuplePerOrderedCueTargetCondition.Add(i, targetFlankerConditionAndCueTargetIntervalTuple);

                double[] rankableValuesA;
                uint[] randomOrderOfPostTargetFixationIntervals;
                double[] rankableValuesB;

                while (true)
                {
                    try
                    {
                        rankableValuesA = targetFlankerConditionAndCueTargetIntervalTuple.Select(tp => tp.RankableValue()).ToArray();
                        randomOrderOfPostTargetFixationIntervals = GetRandomizedOrder(postTargetFixationIntervals);
                        rankableValuesB = StatisticsHelper.GetRankableValues(randomOrderOfPostTargetFixationIntervals);

                        var rankCC = StatisticsHelper.Spearman(rankableValuesA, rankableValuesB);
                        var absRankCC = Math.Abs(rankCC);
                        Debug.Log(@"i: " + i + @", spearman rank: " + rankCC + @", NaN: " + double.IsNaN(rankCC) + @", < 0.005: " + (absRankCC < 0.005d) + @".");

                        if (!double.IsNaN(rankCC) && absRankCC < 0.005d)
                            break;
                    }
                    catch(Exception ex)
                    {
                        Debug.LogError(nameof(ExperimentConditionsBase) + @": " + ex.Message);
                    }
                }

                postTargetFixationIntervalPerOrderedCueTargetCondition.Add(i, randomOrderOfPostTargetFixationIntervals);
            }

            //Debug.Log(nameof(ExperimentConditionsBase) + @": Second block of initializations imminent.");

            Trials = new Trial[TrialCount];

            for (int row = 0; row < CueTargetConditionCount; row++)
            {
                for (int column = 0; column < CueTargetConditionCount; column++)
                {
                    //Debug.Log(nameof(ExperimentConditionsBase) + @": " + nameof(row) + @" = " + row.ToString() + @", " + nameof(column) + @" = " + column + @".");
                    var posInOrderedCueTargetArray = LatinSquareContainer.BalancedLatinSquare12[row, column];
                    //Debug.Log(nameof(ExperimentConditionsBase) + @": " + nameof(posInOrderedCueTargetArray) + @" = " + posInOrderedCueTargetArray.ToString() + @".");
                    var orderedCueTargetCondition = CueTargetConditionsOrder[posInOrderedCueTargetArray];
                    //Debug.Log(nameof(ExperimentConditionsBase) + @": " + nameof(orderedCueTargetCondition) + @" = " + orderedCueTargetCondition.ToString() + @".");
                    var conditionTuple = targetFlankerConditionAndCueTargetIntervalTuplePerOrderedCueTargetCondition[(int)posInOrderedCueTargetArray][row];
                    //Debug.Log(nameof(ExperimentConditionsBase) + @": " + nameof(conditionTuple) + @"." + nameof(conditionTuple.TargetFlankerCondition) + @" = " + conditionTuple.TargetFlankerCondition.ToString() + @", " + nameof(conditionTuple) + @"." + nameof(conditionTuple.CueTargetInterval) + @" = " + conditionTuple.CueTargetInterval.ToString() + @".");
                    var targetEndToNextTrialTimeSpan = (PostTargetFixationInterval)postTargetFixationIntervalPerOrderedCueTargetCondition[(int)posInOrderedCueTargetArray][row];
                    //Debug.Log(nameof(ExperimentConditionsBase) + @": " + nameof(targetEndToNextTrialTimeSpan) + @" = " + targetEndToNextTrialTimeSpan.ToString() + @".");
                    Trials[row * CueTargetConditionCount + column] = new Trial((uint)(row * CueTargetConditionCount + column), orderedCueTargetCondition, conditionTuple.TargetFlankerCondition, conditionTuple.CueTargetInterval, targetEndToNextTrialTimeSpan);

                    if (experimentType == ExperimentType.Original || experimentType == ExperimentType.Practice)
                        Trials[TrialCount - row * CueTargetConditionCount - column - 1] = new Trial((uint)(TrialCount - row * CueTargetConditionCount - column - 1), orderedCueTargetCondition, conditionTuple.TargetFlankerCondition, conditionTuple.CueTargetInterval, targetEndToNextTrialTimeSpan);
                }
            }
        }

        private T[] GetRandomizedOrder<T>(T[] originalOrder)
        {
            var totalNumberOfConditions = (uint)originalOrder.Length;
            var originalConditions = new List<T>(originalOrder);
            var randomizedConditions = new List<T>();

            var rng = new RandomNumbersGenerator();

            for (uint i = 0; i < totalNumberOfConditions; i++)
            {
                var lastIndex = totalNumberOfConditions - 1 - i;
                var randomIndex = (int)rng.GetRandomUInt(0, lastIndex);
                var randomCondition = originalConditions[randomIndex];
                randomizedConditions.Add(randomCondition);
                originalConditions.RemoveAt(randomIndex);
            }

            return randomizedConditions.ToArray();
        }

        private static CueTargetCondition[] GetOriginalCueTargetConditions()
        {
            var cueTargetConditions = new CueTargetCondition[CueTargetConditionCount];

            cueTargetConditions[0] = CueTargetCondition.CueRightTargetRight;
            cueTargetConditions[1] = CueTargetCondition.DoubleCueTargetRight;
            cueTargetConditions[2] = CueTargetCondition.CueLeftTargetLeft;
            cueTargetConditions[3] = CueTargetCondition.CueRightTargetRight;
            cueTargetConditions[4] = CueTargetCondition.NoCueTargetLeft;
            cueTargetConditions[5] = CueTargetCondition.DoubleCueTargetLeft;
            cueTargetConditions[6] = CueTargetCondition.CueRightTargetLeft;
            cueTargetConditions[7] = CueTargetCondition.CueLeftTargetLeft;
            cueTargetConditions[8] = CueTargetCondition.NoCueTargetRight;
            cueTargetConditions[9] = CueTargetCondition.CueLeftTargetRight;
            cueTargetConditions[10] = CueTargetCondition.CueLeftTargetLeft;
            cueTargetConditions[11] = CueTargetCondition.CueRightTargetRight;

            return cueTargetConditions;
        }

        private static CueTargetCondition[] GetBalancedCueTargetConditions()
        {
            var cueTargetConditions = new CueTargetCondition[CueTargetConditionCount];

            cueTargetConditions[0] = CueTargetCondition.CueLeftTargetRight;
            cueTargetConditions[1] = CueTargetCondition.DoubleCueTargetRight;
            cueTargetConditions[2] = CueTargetCondition.CueLeftTargetLeft;
            cueTargetConditions[3] = CueTargetCondition.CueRightTargetRight;
            cueTargetConditions[4] = CueTargetCondition.NoCueTargetLeft;
            cueTargetConditions[5] = CueTargetCondition.DoubleCueTargetLeft;
            cueTargetConditions[6] = CueTargetCondition.CueRightTargetLeft;
            cueTargetConditions[7] = CueTargetCondition.CueLeftTargetLeft;
            cueTargetConditions[8] = CueTargetCondition.NoCueTargetRight;
            cueTargetConditions[9] = CueTargetCondition.CueLeftTargetRight;
            cueTargetConditions[10] = CueTargetCondition.CueRightTargetRight;
            cueTargetConditions[11] = CueTargetCondition.CueRightTargetLeft;

            return cueTargetConditions;
        }
    }
}

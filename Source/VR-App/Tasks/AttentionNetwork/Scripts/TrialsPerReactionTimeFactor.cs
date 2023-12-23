using System;
using System.Collections.Generic;
using UnityEngine;

namespace Assets.Tasks.AttentionalNetwork.Scripts
{
    [Serializable]
    public class TrialsPerReactionTimeFactor
    {
        public List<uint> CorrectResponseNoCue;
        public List<uint> CorrectResponseDoubleCue;
        public List<uint> CorrectResponseInvalidCue;
        public List<uint> CorrectResponseValidCue;
        public List<uint> CorrectResponseValidCueZeroCueToTargetOnset;
        public List<uint> CorrectResponseValidCue800CueToTargetOnset;
        public List<uint> CorrectResponseFlankerIncongruent;
        public List<uint> CorrectResponseFlankerCongruent;
        public List<uint> CorrectResponseLocationIncongruent;
        public List<uint> CorrectResponseLocationCongruent;
        public List<uint> CorrectResponseFlankerCongruentLocationCongruent;
        public List<uint> CorrectResponseFlankerIncongruentLocationIncongruent;
        public List<uint> CorrectResponseFlankerCongruentLocationIncongruent;
        public List<uint> CorrectResponseFlankerIncongruentLocationCongruent;
        public List<uint> CorrectResponseNoCueFlankerIncongruent;
        public List<uint> CorrectResponseDoubleCueFlankerCongruent;
        public List<uint> CorrectResponseNoCueFlankerCongruent;
        public List<uint> CorrectResponseDoubleCueFlankerIncongruent;
        public List<uint> CorrectResponseValidCueFlankerIncongruent;
        public List<uint> CorrectResponseValidCueFlankerCongruent;
        public List<uint> CorrectResponseInvalidCueFlankerIncongruent;
        public List<uint> CorrectResponseInvalidCueFlankerCongruent;
        public List<uint> CorrectResponseNoCueLocationIncongruent;
        public List<uint> CorrectResponseDoubleCueLocationCongruent;
        public List<uint> CorrectResponseNoCueLocationCongruent;
        public List<uint> CorrectResponseDoubleCueLocationIncongruent;
        public List<uint> CorrectResponseValidCueLocationIncongruent;
        public List<uint> CorrectResponseValidCueLocationCongruent;
        public List<uint> CorrectResponseInvalidCueLocationIncongruent;
        public List<uint> CorrectResponseInvalidCueLocationCongruent;
        public List<uint> CorrectResponseInvalidCueZeroCueToTargetOnset;
        public List<uint> CorrectResponseValidCue400CueToTargetOnset;
        public List<uint> CorrectResponseInvalidCue400CueToTargetOnset;

        public List<uint> IncorrectResponseNoCue;
        public List<uint> IncorrectResponseDoubleCue;
        public List<uint> IncorrectResponseInvalidCue;
        public List<uint> IncorrectResponseValidCue;
        public List<uint> IncorrectResponseValidCueZeroCueToTargetOnset;
        public List<uint> IncorrectResponseValidCue800CueToTargetOnset;
        public List<uint> IncorrectResponseFlankerIncongruent;
        public List<uint> IncorrectResponseFlankerCongruent;
        public List<uint> IncorrectResponseLocationIncongruent;
        public List<uint> IncorrectResponseLocationCongruent;
        public List<uint> IncorrectResponseFlankerCongruentLocationCongruent;
        public List<uint> IncorrectResponseFlankerIncongruentLocationIncongruent;
        public List<uint> IncorrectResponseFlankerCongruentLocationIncongruent;
        public List<uint> IncorrectResponseFlankerIncongruentLocationCongruent;
        public List<uint> IncorrectResponseNoCueFlankerIncongruent;
        public List<uint> IncorrectResponseDoubleCueFlankerCongruent;
        public List<uint> IncorrectResponseNoCueFlankerCongruent;
        public List<uint> IncorrectResponseDoubleCueFlankerIncongruent;
        public List<uint> IncorrectResponseValidCueFlankerIncongruent;
        public List<uint> IncorrectResponseValidCueFlankerCongruent;
        public List<uint> IncorrectResponseInvalidCueFlankerIncongruent;
        public List<uint> IncorrectResponseInvalidCueFlankerCongruent;
        public List<uint> IncorrectResponseNoCueLocationIncongruent;
        public List<uint> IncorrectResponseDoubleCueLocationCongruent;
        public List<uint> IncorrectResponseNoCueLocationCongruent;
        public List<uint> IncorrectResponseDoubleCueLocationIncongruent;
        public List<uint> IncorrectResponseValidCueLocationIncongruent;
        public List<uint> IncorrectResponseValidCueLocationCongruent;
        public List<uint> IncorrectResponseInvalidCueLocationIncongruent;
        public List<uint> IncorrectResponseInvalidCueLocationCongruent;
        public List<uint> IncorrectResponseInvalidCueZeroCueToTargetOnset;
        public List<uint> IncorrectResponseValidCue400CueToTargetOnset;
        public List<uint> IncorrectResponseInvalidCue400CueToTargetOnset;

        public List<uint> IncorrectResponse;
        public List<uint> TimedOutResponse;
        public List<uint> PrematureResponse;
        public List<uint> CorrectResponse;
        public List<uint> NotCorrectResponse;

        private bool _phoneIsOnTheLeft;

        public TrialsPerReactionTimeFactor()
        {
            CorrectResponseNoCue = new List<uint>();
            CorrectResponseDoubleCue = new List<uint>();
            CorrectResponseInvalidCue = new List<uint>();
            CorrectResponseValidCue = new List<uint>();
            CorrectResponseValidCueZeroCueToTargetOnset = new List<uint>();
            CorrectResponseValidCue800CueToTargetOnset = new List<uint>();
            CorrectResponseFlankerIncongruent = new List<uint>();
            CorrectResponseFlankerCongruent = new List<uint>();
            CorrectResponseLocationIncongruent = new List<uint>();
            CorrectResponseLocationCongruent = new List<uint>();
            CorrectResponseFlankerCongruentLocationCongruent = new List<uint>();
            CorrectResponseFlankerIncongruentLocationIncongruent = new List<uint>();
            CorrectResponseFlankerCongruentLocationIncongruent = new List<uint>();
            CorrectResponseFlankerIncongruentLocationCongruent = new List<uint>();
            CorrectResponseNoCueFlankerIncongruent = new List<uint>();
            CorrectResponseDoubleCueFlankerCongruent = new List<uint>();
            CorrectResponseNoCueFlankerCongruent = new List<uint>();
            CorrectResponseDoubleCueFlankerIncongruent = new List<uint>();
            CorrectResponseValidCueFlankerIncongruent = new List<uint>();
            CorrectResponseValidCueFlankerCongruent = new List<uint>();
            CorrectResponseInvalidCueFlankerIncongruent = new List<uint>();
            CorrectResponseInvalidCueFlankerCongruent = new List<uint>();
            CorrectResponseNoCueLocationIncongruent = new List<uint>();
            CorrectResponseDoubleCueLocationCongruent = new List<uint>();
            CorrectResponseNoCueLocationCongruent = new List<uint>();
            CorrectResponseDoubleCueLocationIncongruent = new List<uint>();
            CorrectResponseValidCueLocationIncongruent = new List<uint>();
            CorrectResponseValidCueLocationCongruent = new List<uint>();
            CorrectResponseInvalidCueLocationIncongruent = new List<uint>();
            CorrectResponseInvalidCueLocationCongruent = new List<uint>();
            CorrectResponseInvalidCueZeroCueToTargetOnset = new List<uint>();
            CorrectResponseValidCue400CueToTargetOnset = new List<uint>();
            CorrectResponseInvalidCue400CueToTargetOnset = new List<uint>();

            IncorrectResponseNoCue = new List<uint>();
            IncorrectResponseDoubleCue = new List<uint>();
            IncorrectResponseInvalidCue = new List<uint>();
            IncorrectResponseValidCue = new List<uint>();
            IncorrectResponseValidCueZeroCueToTargetOnset = new List<uint>();
            IncorrectResponseValidCue800CueToTargetOnset = new List<uint>();
            IncorrectResponseFlankerIncongruent = new List<uint>();
            IncorrectResponseFlankerCongruent = new List<uint>();
            IncorrectResponseLocationIncongruent = new List<uint>();
            IncorrectResponseLocationCongruent = new List<uint>();
            IncorrectResponseFlankerCongruentLocationCongruent = new List<uint>();
            IncorrectResponseFlankerIncongruentLocationIncongruent = new List<uint>();
            IncorrectResponseFlankerCongruentLocationIncongruent = new List<uint>();
            IncorrectResponseFlankerIncongruentLocationCongruent = new List<uint>();
            IncorrectResponseNoCueFlankerIncongruent = new List<uint>();
            IncorrectResponseDoubleCueFlankerCongruent = new List<uint>();
            IncorrectResponseNoCueFlankerCongruent = new List<uint>();
            IncorrectResponseDoubleCueFlankerIncongruent = new List<uint>();
            IncorrectResponseValidCueFlankerIncongruent = new List<uint>();
            IncorrectResponseValidCueFlankerCongruent = new List<uint>();
            IncorrectResponseInvalidCueFlankerIncongruent = new List<uint>();
            IncorrectResponseInvalidCueFlankerCongruent = new List<uint>();
            IncorrectResponseNoCueLocationIncongruent = new List<uint>();
            IncorrectResponseDoubleCueLocationCongruent = new List<uint>();
            IncorrectResponseNoCueLocationCongruent = new List<uint>();
            IncorrectResponseDoubleCueLocationIncongruent = new List<uint>();
            IncorrectResponseValidCueLocationIncongruent = new List<uint>();
            IncorrectResponseValidCueLocationCongruent = new List<uint>();
            IncorrectResponseInvalidCueLocationIncongruent = new List<uint>();
            IncorrectResponseInvalidCueLocationCongruent = new List<uint>();
            IncorrectResponseInvalidCueZeroCueToTargetOnset = new List<uint>();
            IncorrectResponseValidCue400CueToTargetOnset = new List<uint>();
            IncorrectResponseInvalidCue400CueToTargetOnset = new List<uint>();
                        
            IncorrectResponse = new List<uint>();
            TimedOutResponse = new List<uint>();
            PrematureResponse = new List<uint>();
            CorrectResponse = new List<uint>();
            NotCorrectResponse = new List<uint>();
        }

        internal TrialsPerReactionTimeFactor(bool phoneIsOnTheLeft) : this()
        {
            _phoneIsOnTheLeft = phoneIsOnTheLeft;
        }

        public void AddTrialResultToReactionTimes(Trial trial, TrialResult result)
        {
            try
            {
                if (trial == null || result == null)
                {
                    //if (Debug.isDebugBuild)
                    Debug.Log(@"Aborted. Trials or results are null.");
                    return;
                }

                Debug.Log(trial.ToString());
                Debug.Log(result.ToString());

                Debug.Log(nameof(trial.Number) + @" = " + trial.Number + @", " + nameof(result.TrialNumber) + @" = " + result.TrialNumber + @".");

                if (trial.Number != result.TrialNumber)
                {
                    //if (Debug.isDebugBuild)
                    Debug.Log(@"Aborted. Trial numbers differ.");
                    return;
                }

                Debug.Log(@"Block 1");

                if (result.Type == TrialResultType.Incorrect)
                    IncorrectResponse.Add(trial.Number);

                if (result.Type == TrialResultType.TimeOut)
                    TimedOutResponse.Add(trial.Number);

                if (result.Type == TrialResultType.Premature)
                    PrematureResponse.Add(trial.Number);

                if (result.Type == TrialResultType.Correct)
                    CorrectResponse.Add(trial.Number);
                else
                    NotCorrectResponse.Add(trial.Number);

                Debug.Log(@"Block 2");

                if (trial.CueTargetCondition == CueTargetCondition.NoCueTargetLeft || trial.CueTargetCondition == CueTargetCondition.NoCueTargetRight)
                {
                    if (result.Type == TrialResultType.Correct)
                        CorrectResponseNoCue.Add(trial.Number);
                    else
                        IncorrectResponseNoCue.Add(trial.Number);

                    if (trial.FlankersAreCongruent())
                    {
                        if (result.Type == TrialResultType.Correct)
                            CorrectResponseNoCueFlankerCongruent.Add(trial.Number);
                        else
                            IncorrectResponseNoCueFlankerCongruent.Add(trial.Number);
                    }
                    else
                    {
                        if (result.Type == TrialResultType.Correct)
                            CorrectResponseNoCueFlankerIncongruent.Add(trial.Number);
                        else
                            IncorrectResponseNoCueFlankerIncongruent.Add(trial.Number);
                    }

                    if (trial.LocationIsCongruent(_phoneIsOnTheLeft))
                    {
                        if (result.Type == TrialResultType.Correct)
                            CorrectResponseNoCueLocationCongruent.Add(trial.Number);
                        else
                            IncorrectResponseNoCueLocationCongruent.Add(trial.Number);
                    }
                    else
                    {
                        if (result.Type == TrialResultType.Correct)
                            CorrectResponseNoCueLocationIncongruent.Add(trial.Number);
                        else
                            IncorrectResponseNoCueLocationIncongruent.Add(trial.Number);
                    }
                }

                Debug.Log(@"Block 3");

                if (trial.CueTargetCondition == CueTargetCondition.DoubleCueTargetLeft || trial.CueTargetCondition == CueTargetCondition.DoubleCueTargetRight)
                {
                    if (result.Type == TrialResultType.Correct)
                        CorrectResponseDoubleCue.Add(trial.Number);
                    else
                        IncorrectResponseDoubleCue.Add(trial.Number);

                    if (trial.FlankersAreCongruent())
                    {
                        if (result.Type == TrialResultType.Correct)
                            CorrectResponseDoubleCueFlankerCongruent.Add(trial.Number);
                        else
                            IncorrectResponseDoubleCueFlankerCongruent.Add(trial.Number);
                    }
                    else
                    {
                        if (result.Type == TrialResultType.Correct)
                            CorrectResponseDoubleCueFlankerIncongruent.Add(trial.Number);
                        else
                            IncorrectResponseDoubleCueFlankerIncongruent.Add(trial.Number);
                    }

                    if (trial.LocationIsCongruent(_phoneIsOnTheLeft))
                    {
                        if (result.Type == TrialResultType.Correct)
                            CorrectResponseDoubleCueLocationCongruent.Add(trial.Number);
                        else
                            IncorrectResponseDoubleCueLocationCongruent.Add(trial.Number);
                    }
                    else
                    {
                        if (result.Type == TrialResultType.Correct)
                            CorrectResponseDoubleCueLocationIncongruent.Add(trial.Number);
                        else
                            IncorrectResponseDoubleCueLocationIncongruent.Add(trial.Number);
                    }
                }

                Debug.Log(@"Block 4");

                if (trial.CueTargetCondition == CueTargetCondition.CueLeftTargetRight || trial.CueTargetCondition == CueTargetCondition.CueRightTargetLeft)
                {
                    if (result.Type == TrialResultType.Correct)
                        CorrectResponseInvalidCue.Add(trial.Number);
                    else
                        IncorrectResponseInvalidCue.Add(trial.Number);

                    if (trial.FlankersAreCongruent())
                    {
                        if (result.Type == TrialResultType.Correct)
                            CorrectResponseInvalidCueFlankerCongruent.Add(trial.Number);
                        else
                            IncorrectResponseInvalidCueFlankerCongruent.Add(trial.Number);
                    }
                    else
                    {
                        if (result.Type == TrialResultType.Correct)
                            CorrectResponseInvalidCueFlankerIncongruent.Add(trial.Number);
                        else
                            IncorrectResponseInvalidCueFlankerIncongruent.Add(trial.Number);
                    }

                    if (trial.LocationIsCongruent(_phoneIsOnTheLeft))
                    {
                        if (result.Type == TrialResultType.Correct)
                            CorrectResponseInvalidCueLocationCongruent.Add(trial.Number);
                        else
                            IncorrectResponseInvalidCueLocationCongruent.Add(trial.Number);
                    }
                    else
                    {
                        if (result.Type == TrialResultType.Correct)
                            CorrectResponseInvalidCueLocationIncongruent.Add(trial.Number);
                        else
                            IncorrectResponseInvalidCueLocationIncongruent.Add(trial.Number);
                    }

                    if (trial.CueTargetInterval == CueTargetInterval.Interval0)
                    {
                        if (result.Type == TrialResultType.Correct)
                            CorrectResponseInvalidCueZeroCueToTargetOnset.Add(trial.Number);
                        else
                            IncorrectResponseInvalidCueZeroCueToTargetOnset.Add(trial.Number);
                    }

                    if (trial.CueTargetInterval == CueTargetInterval.Interval400)
                    {
                        if (result.Type == TrialResultType.Correct)
                            CorrectResponseInvalidCue400CueToTargetOnset.Add(trial.Number);
                        else
                            IncorrectResponseInvalidCue400CueToTargetOnset.Add(trial.Number);
                    }
                }

                Debug.Log(@"Block 5");

                if (trial.CueTargetCondition == CueTargetCondition.CueLeftTargetLeft || trial.CueTargetCondition == CueTargetCondition.CueRightTargetRight)
                {
                    if (result.Type == TrialResultType.Correct)
                        CorrectResponseValidCue.Add(trial.Number);
                    else
                        IncorrectResponseValidCue.Add(trial.Number);

                    if (trial.FlankersAreCongruent())
                    {
                        if (result.Type == TrialResultType.Correct)
                            CorrectResponseValidCueFlankerCongruent.Add(trial.Number);
                        else
                            IncorrectResponseValidCueFlankerCongruent.Add(trial.Number);
                    }
                    else
                    {
                        if (result.Type == TrialResultType.Correct)
                            CorrectResponseValidCueFlankerIncongruent.Add(trial.Number);
                        else
                            IncorrectResponseValidCueFlankerIncongruent.Add(trial.Number);
                    }

                    if (trial.LocationIsCongruent(_phoneIsOnTheLeft))
                    {
                        if (result.Type == TrialResultType.Correct)
                            CorrectResponseValidCueLocationCongruent.Add(trial.Number);
                        else
                            IncorrectResponseValidCueLocationCongruent.Add(trial.Number);
                    }
                    else
                    {
                        if (result.Type == TrialResultType.Correct)
                            CorrectResponseValidCueLocationIncongruent.Add(trial.Number);
                        else
                            IncorrectResponseValidCueLocationIncongruent.Add(trial.Number);
                    }

                    if (trial.CueTargetInterval == CueTargetInterval.Interval0)
                    {
                        if (result.Type == TrialResultType.Correct)
                            CorrectResponseValidCueZeroCueToTargetOnset.Add(trial.Number);
                        else
                            IncorrectResponseValidCueZeroCueToTargetOnset.Add(trial.Number);
                    }

                    if (trial.CueTargetInterval == CueTargetInterval.Interval400)
                    {
                        if (result.Type == TrialResultType.Correct)
                            CorrectResponseValidCue400CueToTargetOnset.Add(trial.Number);
                        else
                            IncorrectResponseValidCue400CueToTargetOnset.Add(trial.Number);
                    }

                    if (trial.CueTargetInterval == CueTargetInterval.Interval800)
                    {
                        if (result.Type == TrialResultType.Correct)
                            CorrectResponseValidCue800CueToTargetOnset.Add(trial.Number);
                        else
                            IncorrectResponseValidCue800CueToTargetOnset.Add(trial.Number);
                    }
                }

                Debug.Log(@"Block 6");

                if (trial.FlankersAreCongruent())
                {
                    if (result.Type == TrialResultType.Correct)
                        CorrectResponseFlankerCongruent.Add(trial.Number);
                    else
                        IncorrectResponseFlankerCongruent.Add(trial.Number);

                    if (trial.LocationIsCongruent(_phoneIsOnTheLeft))
                    {
                        if (result.Type == TrialResultType.Correct)
                        {
                            CorrectResponseLocationCongruent.Add(trial.Number);
                            CorrectResponseFlankerCongruentLocationCongruent.Add(trial.Number);
                        }
                        else
                        {
                            IncorrectResponseLocationCongruent.Add(trial.Number);
                            IncorrectResponseFlankerCongruentLocationCongruent.Add(trial.Number);
                        }
                    }
                    else
                    {
                        if (result.Type == TrialResultType.Correct)
                        {
                            CorrectResponseLocationIncongruent.Add(trial.Number);
                            CorrectResponseFlankerCongruentLocationIncongruent.Add(trial.Number);
                        }
                        else
                        {
                            IncorrectResponseLocationIncongruent.Add(trial.Number);
                            IncorrectResponseFlankerCongruentLocationIncongruent.Add(trial.Number);
                        }
                    }
                }
                else
                {
                    if (result.Type == TrialResultType.Correct)
                        CorrectResponseFlankerIncongruent.Add(trial.Number);
                    else
                        IncorrectResponseFlankerIncongruent.Add(trial.Number);

                    if (trial.LocationIsCongruent(_phoneIsOnTheLeft))
                    {
                        if (result.Type == TrialResultType.Correct)
                        {
                            CorrectResponseLocationCongruent.Add(trial.Number);
                            CorrectResponseFlankerIncongruentLocationCongruent.Add(trial.Number);
                        }
                        else
                        {
                            IncorrectResponseLocationCongruent.Add(trial.Number);
                            IncorrectResponseFlankerIncongruentLocationCongruent.Add(trial.Number);
                        }
                    }
                    else
                    {
                        if (result.Type == TrialResultType.Correct)
                        {
                            CorrectResponseLocationIncongruent.Add(trial.Number);
                            CorrectResponseFlankerIncongruentLocationIncongruent.Add(trial.Number);
                        }
                        else
                        {
                            IncorrectResponseLocationIncongruent.Add(trial.Number);
                            IncorrectResponseFlankerIncongruentLocationIncongruent.Add(trial.Number);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                //if (Debug.isDebugBuild)
                Debug.Log(ex);
            }
        }
    }
}

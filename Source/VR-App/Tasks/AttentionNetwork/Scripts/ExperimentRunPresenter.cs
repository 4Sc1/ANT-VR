using System;
using System.Collections;
using UnityEngine;
using UnityEngine.UI;
using Assets.Helpers.Scripts;
using TMPro;

namespace Assets.Tasks.AttentionalNetwork.Scripts
{
    public class ExperimentRunPresenter : MonoBehaviour
    {
        public TextMeshProUGUI LabelTop;
        public TextMeshProUGUI LabelMiddle;
        public TextMeshProUGUI LabelBottom;
        public TextMeshProUGUI LabelButtons;
        public Image ScreenImage;
        public Image PhoneDiplayImage;
        public Image TabletDiplayImage;
        public Sprite IdleTexture;
        public Sprite ResumeTexture;
        public Sprite EndingTexture;
        public Sprite BlankTexture;
        public Sprite NoCueTexture;
        public Sprite DoubleCueTexture;
        public Sprite LeftCueTexture;
        public Sprite RightCueTexture;
        public Sprite LeftTarget5PhonesTexture;
        public Sprite RightTarget5PhonesTexture;
        public Sprite LeftTarget5TabletsTexture;
        public Sprite RightTarget5TabletsTexture;
        public Sprite LeftTarget1Phone4TabletsTexture;
        public Sprite RightTarget1Phone4TabletsTexture;
        public Sprite LeftTarget1Tablet4PhonesTexture;
        public Sprite RightTarget1Tablet4PhonesTexture;
        public Sprite TrialPassedTexture;
        public Sprite TrialFailedTexture;
        public Sprite DeviceIdleTexture;
        public LSLPluginHost LSLPluginHost;

        private bool _startNewRun;
        private ExperimentResult _experimentResult;
        private ExperimentConditionsBase _experimentConditions;

        private Trial _currentTrial;
        private TrialResult _currentTrialResult;
        private double _currentTrialStart;
        private double _currentTrialPhaseStart;
        private ExperimentState _currentExperimentState;
        private IEnumerator _experimentRunRoutine;
        private static readonly Type _typeOfExperimentState = typeof(ExperimentState);

        public uint NumberOfTrialsInTestRun = 24;
        public uint NumberOfTrialsToPauseAfter = 72;
        public uint MinimalNumberOfTrialsInPracticeRun = 32;
        public float MinimalPracticeRunAccuracy = 0.9f;

        internal bool CurrentTrialHasResult()
        {
            return _currentTrialResult != null;
        }

        internal bool CurrentTargetIsPhone()
        {
            return _currentTrial.TargetIsPhone();
        }

        internal ExperimentState GetCurrentExperimentState()
        {
            return _currentExperimentState;
        }

        internal void InstructionsShown()
        {
            _currentExperimentState = ExperimentState.NotRunning;
            SetResumeTextures();

            LabelTop.enabled = true;
            LabelMiddle.enabled = false;
            LabelBottom.enabled = true;
            LabelButtons.enabled = false;

            LabelTop.text = @"Please press button";
            LabelMiddle.text = string.Empty;
            LabelBottom.text = @"on your right-hand side controller to start the experiment.";
            LabelButtons.text = string.Empty;
        }

        private IEnumerator ShowTrial(Trial trial)
        {
            if (Debug.isDebugBuild)
                Debug.Log(nameof(ShowTrial) + @": Entered.");

            _currentTrial = trial;
            _currentTrialResult = null;

            if (Debug.isDebugBuild)
            {
                Debug.Log(nameof(ShowTrial) + @": " + nameof(_currentTrial) + @" = " + _currentTrial + @".");
                Debug.Log(nameof(ShowTrial) + @": " + nameof(ExperimentState.CuePresentation) + @".");
            }
            var cuePresentationStart = LSLPluginHost.GetTimeStamp();
            SetCueTexture(trial.CueTargetCondition);
            _currentExperimentState = ExperimentState.CuePresentation;

            var cuePresentationEnd = cuePresentationStart + _experimentConditions.CuePresentationTimeSpan / 1000.0d;
            _currentTrialPhaseStart = cuePresentationStart;
            _currentTrialStart = _currentTrialPhaseStart;
            if (Debug.isDebugBuild)
                Debug.Log(nameof(ShowTrial) + @": " + nameof(cuePresentationEnd) + @" = " + cuePresentationEnd + @".");
            LSLPluginHost.PushEventMessage(GetEventMessage(Marker.CuePresentation, ButtonPress.None), cuePresentationStart);

            while (LSLPluginHost.GetTimeStamp() < cuePresentationEnd)
                yield return new WaitForSecondsRealtime(_experimentConditions.FixedDeltaTime / 1000.0f);

            if (trial.CueTargetInterval != CueTargetInterval.Interval0)
            {
                if (Debug.isDebugBuild)
                    Debug.Log(nameof(ShowTrial) + @": " + nameof(ExperimentState.WaitingForTarget) + @".");
                SetIdleTextures();
                _currentExperimentState = ExperimentState.WaitingForTarget;
                var waitingForTargetStart = LSLPluginHost.GetTimeStamp();
                var waitingForTargetEnd = waitingForTargetStart + IntervalHelper.GetCueTargetInterval(trial.CueTargetInterval);
                _currentTrialPhaseStart = waitingForTargetStart;
                if (Debug.isDebugBuild)
                    Debug.Log(nameof(ShowTrial) + @": " + nameof(waitingForTargetEnd) + @" = " + waitingForTargetEnd + @".");
                LSLPluginHost.PushEventMessage(GetEventMessage(Marker.CueTargetInterval, ButtonPress.None), waitingForTargetStart);

                while (LSLPluginHost.GetTimeStamp() < waitingForTargetEnd)
                    yield return new WaitForSecondsRealtime(_experimentConditions.FixedDeltaTime / 1000.0f);
            }

            if (Debug.isDebugBuild)
                Debug.Log(nameof(ShowTrial) + @": " + nameof(ExperimentState.TargetPresentation) + @".");
            SetTargetTexture(trial.CueTargetCondition, trial.TargetFlankerCondition);
            _currentExperimentState = ExperimentState.TargetPresentation;
            var targetPresentationStart = LSLPluginHost.GetTimeStamp();
            var responseCollectionStart = targetPresentationStart + _experimentConditions.ResponseCollectionOnset / 1000.0d;
            _currentTrialPhaseStart = targetPresentationStart;

            if (_experimentConditions.ResponseCollectionOnset > 0)
            {
                if (Debug.isDebugBuild)
                    Debug.Log(nameof(ShowTrial) + @": " + nameof(responseCollectionStart) + @" = " + responseCollectionStart + @".");
                LSLPluginHost.PushEventMessage(GetEventMessage(Marker.TargetPresentation, ButtonPress.None), targetPresentationStart);

                while (LSLPluginHost.GetTimeStamp() < responseCollectionStart)
                    yield return new WaitForSecondsRealtime(_experimentConditions.FixedDeltaTime / 1000.0f);
            }

            if (Debug.isDebugBuild)
                Debug.Log(nameof(ShowTrial) + @": " + nameof(ExperimentState.TargetPresentationAndResponseCollection) + @".");
            _currentExperimentState = ExperimentState.TargetPresentationAndResponseCollection;
            var targetPresentationAndResponseCollectionStart = LSLPluginHost.GetTimeStamp();
            var targetPresentationEnd = targetPresentationStart + _experimentConditions.TargetPresentationTimeSpan / 1000.0d;
            if (Debug.isDebugBuild)
                Debug.Log(nameof(ShowTrial) + @": " + nameof(targetPresentationEnd) + @" = " + targetPresentationEnd + @".");
            LSLPluginHost.PushEventMessage(GetEventMessage(Marker.TargetPresentationAndResponseCollection, ButtonPress.None), targetPresentationAndResponseCollectionStart);

            while (LSLPluginHost.GetTimeStamp() < targetPresentationEnd)
                yield return new WaitForSecondsRealtime(_experimentConditions.FixedDeltaTime / 1000.0f);

            if (Debug.isDebugBuild)
                Debug.Log(nameof(ShowTrial) + @": " + nameof(ExperimentState.ResponseCollection) + @".");
            if (_currentTrialResult == null)
                SetIdleTextures();
            var pureResponseCollectionStart = LSLPluginHost.GetTimeStamp();
            _currentExperimentState = ExperimentState.ResponseCollection;
            var responseCollectionEnd = targetPresentationStart + _experimentConditions.ResponseCollectionEnd / 1000.0d;
            if (Debug.isDebugBuild)
                Debug.Log(nameof(ShowTrial) + @": " + nameof(responseCollectionEnd) + @" = " + responseCollectionEnd + @".");
            LSLPluginHost.PushEventMessage(GetEventMessage(Marker.PostTargetInterval, ButtonPress.None), pureResponseCollectionStart);

            while (LSLPluginHost.GetTimeStamp() < responseCollectionEnd)
                yield return new WaitForSecondsRealtime(_experimentConditions.FixedDeltaTime / 1000.0f);

            if (_currentTrialResult == null)
            {
                if (Debug.isDebugBuild)
                    Debug.Log(nameof(ShowTrial) + @": Setting timeout result.");
                _currentTrialResult = new TrialResult(_currentTrial.Number, _currentTrialStart, TrialResultType.TimeOut, Double.NaN);
            }

            if (Debug.isDebugBuild)
                Debug.Log(nameof(ShowTrial) + @": " + nameof(ExperimentState.WaitingForNextTrial) + @".");
            SetIdleTextures();
            var beginOfPostTargetFixationInterval = LSLPluginHost.GetTimeStamp();
            _currentExperimentState = ExperimentState.WaitingForNextTrial;
            var waitingForNextTrialEnd = targetPresentationEnd + IntervalHelper.GetPostTargetFixationInterval(trial.PostTargetFixationInterval);
            if (Debug.isDebugBuild)
                Debug.Log(nameof(ShowTrial) + @": " + nameof(waitingForNextTrialEnd) + @" = " + waitingForNextTrialEnd + @".");
            LSLPluginHost.PushEventMessage(GetEventMessage(Marker.ResponseCollectionEnd, ButtonPress.None), beginOfPostTargetFixationInterval);

            while (LSLPluginHost.GetTimeStamp() < waitingForNextTrialEnd)
                yield return new WaitForSecondsRealtime(_experimentConditions.FixedDeltaTime / 1000.0f);

            _experimentResult.AddTrialResult(_currentTrialResult);

            _currentTrialResult = null;

            yield return null;
        }

        private IEnumerator ShowPause()
        {
            _currentExperimentState = ExperimentState.Pausing;
            var pauseStart = LSLPluginHost.GetTimeStamp();
            LSLPluginHost.PushEventMessage(GetEventMessage(Marker.Pause, ButtonPress.None), pauseStart);

            SetResumeTextures();

            LabelTop.text = @"You can take a pause now." + Environment.NewLine + "Please press button";
            LabelMiddle.text = string.Empty;
            LabelBottom.text = @"on your right-hand side controller to resume the experiment.";
            LabelButtons.text = string.Empty;
            LabelTop.enabled = true;
            LabelMiddle.enabled = false;
            LabelBottom.enabled = true;
            LabelButtons.enabled = false;

            while (!OVRInput.GetDown(OVRInput.RawButton.B))
                yield return new WaitForSecondsRealtime(_experimentConditions.FixedDeltaTime / 1000.0f);

            _currentExperimentState = ExperimentState.FixationCrossPresentation;

            LabelTop.enabled = false;
            LabelMiddle.enabled = false;
            LabelBottom.enabled = false;
            LabelButtons.enabled = false;

            SetIdleTextures();

            var now = LSLPluginHost.GetTimeStamp();
            var delayedResume = now + _experimentConditions.ExperimentStartDelay / 1000d;

            while (LSLPluginHost.GetTimeStamp() < delayedResume)
                yield return new WaitForSecondsRealtime(_experimentConditions.FixedDeltaTime / 1000.0f);

            yield return null;
        }

        internal int GetEventMessage(Marker marker, ButtonPress buttonPress)
        {
            try
            {
                if (marker == Marker.Pause)
                    return (int)Marker.Pause;

                if (_currentTrial == null)
                    return (int)Marker.Error;

                return (int)marker * 10000 + (int)_currentTrial.CueTargetCondition * 1000 + (int)_currentTrial.CueTargetInterval * 100 + (int)_currentTrial.TargetFlankerCondition * 10 + (int)buttonPress;
            }
            catch
            {
            }

            return (int)Marker.Error;
        }

        internal void PushDataMessage(float gyroX, float gyroY, float gyroZ, double timeStamp)
        {
            LSLPluginHost.PushDataMessage(gyroX, gyroY, gyroZ, timeStamp);
        }

        internal void PushButtonPressMessage(bool leftButtonPressed, bool rightButtonPressed, double timeStamp)
        {
            var buttonPress = ButtonPress.None;

            if (leftButtonPressed && rightButtonPressed)
                buttonPress = ButtonPress.Both;

            if (leftButtonPressed && !rightButtonPressed)
                buttonPress = ButtonPress.Left;

            if (!leftButtonPressed && rightButtonPressed)
                buttonPress = ButtonPress.Right;

            LSLPluginHost.PushEventMessage(GetEventMessage(Marker.ButtonPress, buttonPress), timeStamp);
        }

        internal double GetLSLTimeStamp()
        {
            return LSLPluginHost.GetTimeStamp();
        }

        internal void StartNewRun(ExperimentConditionsBase experimentConditions)
        {
            if (Debug.isDebugBuild)
                Debug.Log(nameof(StartNewRun) + @": Entered.");
            StopAllCoroutines();
            _experimentConditions = experimentConditions;
            _experimentResult = new ExperimentResult(LSLPluginHost.GetExperimentName(), AndroidHelper.GetDeviceId(), Application.productName, Application.version, AndroidHelper.ALL_VERSION, MinimalNumberOfTrialsInPracticeRun, _experimentConditions);
            _currentExperimentState = ExperimentState.InstructionPresentation;
            _currentTrialResult = null;
            _startNewRun = true;
        }

        internal void StopRun()
        {
            if (Debug.isDebugBuild)
                Debug.Log(nameof(StopRun) + @": Stopping experiment run.");

            StopAllCoroutines();
            _currentExperimentState = ExperimentState.NotRunning;
            SetIdleTextures();
        }

        internal void SetPrematureResult(double timeStamp)
        {
            if (Debug.isDebugBuild)
                Debug.Log(nameof(SetPrematureResult) + @": Entered.");

            _currentTrialResult = new TrialResult(_currentTrial.Number, _currentTrialStart, TrialResultType.Premature, timeStamp - _currentTrialPhaseStart);
            SetTrialFailedTextures();
        }

        internal void SetIncorrectResult(double timeStamp)
        {
            if (Debug.isDebugBuild)
                Debug.Log(nameof(SetIncorrectResult) + @": Entered.");

            _currentTrialResult = new TrialResult(_currentTrial.Number, _currentTrialStart, TrialResultType.Incorrect, timeStamp - _currentTrialPhaseStart);
            SetTrialFailedTextures();
        }

        internal void SetCorrectResult(double timeStamp)
        {
            if (Debug.isDebugBuild)
                Debug.Log(nameof(SetCorrectResult) + @": Entered.");

            _currentTrialResult = new TrialResult(_currentTrial.Number, _currentTrialStart, TrialResultType.Correct, timeStamp - _currentTrialPhaseStart);
            SetTrialPassedTextures();
        }

        private void Update()
        {
            if (_startNewRun && _currentExperimentState == ExperimentState.NotRunning)
            {
                if (Debug.isDebugBuild)
                    Debug.Log(nameof(Update) + @": Starting experiment run.");

                SetResumeTextures();

                LabelTop.enabled = false;
                LabelMiddle.enabled = false;
                LabelBottom.enabled = false;
                LabelButtons.enabled = false;

                _startNewRun = false;
                _experimentRunRoutine = ShowExperimentRun();
                StartCoroutine(_experimentRunRoutine);
            }
        }

        private IEnumerator ShowExperimentRun()
        {
            if (Debug.isDebugBuild)
            {
                Debug.Log(nameof(ShowExperimentRun) + @": Entered.");
                Debug.Log(nameof(ShowExperimentRun) + @": " + nameof(_experimentConditions.TrialCount) + @" = " + _experimentConditions.TrialCount + ".");
            }

            SetIdleTextures();
            _currentExperimentState = ExperimentState.FixationCrossPresentation;

            var experimentStart = LSLPluginHost.GetTimeStamp();
            var delayedStart = experimentStart += _experimentConditions.ExperimentStartDelay / 1000d;

            if (Debug.isDebugBuild)
                Debug.Log(nameof(ShowExperimentRun) + @": Delaying start for " + _experimentConditions.ExperimentStartDelay + "ms.");

            while (LSLPluginHost.GetTimeStamp() < delayedStart)
                yield return new WaitForSecondsRealtime(_experimentConditions.FixedDeltaTime / 1000.0f);

            for (uint i = 0; i < _experimentConditions.TrialCount; i++)
            {
                if (Debug.isDebugBuild)
                    Debug.Log(nameof(ShowExperimentRun) + @": Starting coroutine " + nameof(ShowTrial) + ".");

                var showTrialRoutine = ShowTrial(_experimentConditions.Trials[i]);
                StartCoroutine(showTrialRoutine);
                yield return showTrialRoutine;

                if ((_experimentConditions.ExperimentType != ExperimentType.Practice) && ((_currentTrial.Number + 1) < _experimentConditions.TrialCount) && (((_currentTrial.Number + 1) % NumberOfTrialsToPauseAfter) == 0))
                {
                    var showPauseRoutine = ShowPause();
                    StartCoroutine(showPauseRoutine);
                    yield return showPauseRoutine;
                }

                if (_experimentConditions.IsLimitedTestRun && _experimentResult.CurrentResultCount >= NumberOfTrialsInTestRun)
                    break;

                if (_experimentConditions.ExperimentType == ExperimentType.Practice)
                {
                    if ((_currentTrial.Number + 1) >= MinimalNumberOfTrialsInPracticeRun && _experimentResult.PracticeRunAccuracy() >= MinimalPracticeRunAccuracy)
                        break;

                    if (i == _experimentConditions.TrialCount - 1)
                        i = 0;
                }
            }

            if (Debug.isDebugBuild)
                Debug.Log(nameof(ShowExperimentRun) + @": Saving result.");

            _experimentResult.CalculateScores();
            _experimentResult.Save();
            SetEndingTextures();
            SetEndingInstructions();
            yield return null;
        }

        private void SetEndingInstructions()
        {

            LabelTop.enabled = true;
            LabelMiddle.enabled = false;
            LabelBottom.enabled = true;
            LabelButtons.enabled = false;

            LabelTop.text = @"The experiment has ended. Please press button";
            LabelBottom.text = @"on your right-hand side controller once and quit the application.";
        }

        private void SetCueTexture(CueTargetCondition cueTargetCondition)
        {
            Sprite textureToSet = null;

            if (cueTargetCondition == CueTargetCondition.NoCueTargetLeft || cueTargetCondition == CueTargetCondition.NoCueTargetRight)
                textureToSet = NoCueTexture;

            if (cueTargetCondition == CueTargetCondition.CueLeftTargetLeft || cueTargetCondition == CueTargetCondition.CueLeftTargetRight)
                textureToSet = LeftCueTexture;

            if (cueTargetCondition == CueTargetCondition.CueRightTargetLeft || cueTargetCondition == CueTargetCondition.CueRightTargetRight)
                textureToSet = RightCueTexture;

            if (cueTargetCondition == CueTargetCondition.DoubleCueTargetLeft || cueTargetCondition == CueTargetCondition.DoubleCueTargetRight)
                textureToSet = DoubleCueTexture;

            ScreenImage.sprite = textureToSet;
        }

        private void SetResumeTextures()
        {
            ScreenImage.sprite = ResumeTexture;
            PhoneDiplayImage.sprite = DeviceIdleTexture;
            TabletDiplayImage.sprite = DeviceIdleTexture;
        }

        private void SetIdleTextures()
        {
            ScreenImage.sprite = NoCueTexture;
            PhoneDiplayImage.sprite = DeviceIdleTexture;
            TabletDiplayImage.sprite = DeviceIdleTexture;
        }

        private void SetEndingTextures()
        {
            ScreenImage.sprite = EndingTexture;
            PhoneDiplayImage.sprite = DeviceIdleTexture;
            TabletDiplayImage.sprite = DeviceIdleTexture;
        }

        private void SetTargetTexture(CueTargetCondition cueTargetCondition, TargetFlankerCondition targetFlankerCondition)
        {
            Sprite textureToSet = null;

            var onTheRight = cueTargetCondition >= CueTargetCondition.NoCueTargetRight;

            if (targetFlankerCondition == TargetFlankerCondition.PhoneFlankedByPhones)
            {
                if (onTheRight)
                    textureToSet = RightTarget5PhonesTexture;
                else
                    textureToSet = LeftTarget5PhonesTexture;
            }

            if (targetFlankerCondition == TargetFlankerCondition.PhoneFlankedByTablets)
            {
                if (onTheRight)
                    textureToSet = RightTarget1Phone4TabletsTexture;
                else
                    textureToSet = LeftTarget1Phone4TabletsTexture;
            }

            if (targetFlankerCondition == TargetFlankerCondition.TabletFlankedByPhones)
            {
                if (onTheRight)
                    textureToSet = RightTarget1Tablet4PhonesTexture;
                else
                    textureToSet = LeftTarget1Tablet4PhonesTexture;
            }

            if (targetFlankerCondition == TargetFlankerCondition.TabletFlankedByTablets)
            {
                if (onTheRight)
                    textureToSet = RightTarget5TabletsTexture;
                else
                    textureToSet = LeftTarget5TabletsTexture;
            }

            ScreenImage.sprite = textureToSet;
        }

        private void SetTrialPassedTextures()
        {
            ScreenImage.sprite = NoCueTexture;
            if (_currentTrial.TargetIsPhone())
                PhoneDiplayImage.sprite = TrialPassedTexture;
            else
                TabletDiplayImage.sprite = TrialPassedTexture;
        }

        private void SetTrialFailedTextures()
        {
            ScreenImage.sprite = NoCueTexture;
            if (_currentTrial.TargetIsPhone())
                PhoneDiplayImage.sprite = TrialFailedTexture;
            else
                TabletDiplayImage.sprite = TrialFailedTexture;
        }

    }
}

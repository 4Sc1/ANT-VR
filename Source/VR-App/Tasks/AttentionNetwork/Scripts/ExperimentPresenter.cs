using UnityEngine;

namespace Assets.Tasks.AttentionalNetwork.Scripts
{
    public class ExperimentPresenter : MonoBehaviour
    {
        public static ExperimentPresenter Instance;

        public OVRCameraRig CameraRig;
        public RefreshRate RefreshRate;
        public ExperimentType ExperimentType;
        public uint StartDelayInMilliSeconds;
        public uint CuePresentationTimeSpanInMilliSeconds;
        public uint TargetPresentationTimeSpanInMilliSeconds;
        public uint ResponseCollectionOnsetInMilliSeconds;
        public uint ResponseCollectionEndInMilliSeconds;
        //public uint PauseTimeSpanInMilliSeconds;
        public bool RandomizeCueTargetConditions;
        public bool UseOriginalCueTargetConditions;
        public bool IsLimitedTestRun;
        public bool PhoneIsOnTheLeft;
        public bool PlayBackgroundNoise;
        public float Resolution;
        public LaserPointer SettingsPointer;
        public Canvas SettingsCanvas;

        public GameObject Phone;
        public GameObject Tablet;
        public GameObject LeftTargetStand;
        public GameObject RightTargetStand;
        public GameObject BackgroundNoise;
        private AudioSource _backgroundNoiseAudioSource;

        public ExperimentRunPresenter ExperimentRunPresenter;

        private LineRenderer _settingsPointerRenderer;

        private Vector3 _initialPhonePosition;
        private Vector3 _initialTabletPosition;
        private Vector3 _phoneOnTheRightPosition;
        private Vector3 _tabletOnTheLeftPosition;
        private Vector3 _initialPhoneRotation;
        private Vector3 _initialTabletRotation;
        private Vector3 _phoneOnTheRightRotation;
        private Vector3 _tabletOnTheLeftRotation;

        private uint _fixedDeltaTimeInMilliSeconds;
        private OVRManager _ovrManager;

        internal ExperimentType GetExperimentType()
        {
            return ExperimentType;
        }

        private void Awake()
        {
            Instance = this;

            _ovrManager = OVRManager.instance;
            _settingsPointerRenderer = SettingsPointer.gameObject.GetComponent<LineRenderer>();
            _backgroundNoiseAudioSource = BackgroundNoise.gameObject.GetComponent<AudioSource>();

            _initialPhonePosition = Phone.transform.position;
            _initialTabletPosition = Tablet.transform.position;
            var leftStandPosition = LeftTargetStand.transform.position;
            var rightStandPosition = RightTargetStand.transform.position;
            var phoneOnTheRightTranslation = _initialPhonePosition - leftStandPosition;
            phoneOnTheRightTranslation.x = phoneOnTheRightTranslation.x * -1.0F;
            var tabletOnTheLeftTranslation = _initialTabletPosition - rightStandPosition;
            tabletOnTheLeftTranslation.x = tabletOnTheLeftTranslation.x * -1.0F;

            _phoneOnTheRightPosition = rightStandPosition + phoneOnTheRightTranslation;
            _tabletOnTheLeftPosition = leftStandPosition + tabletOnTheLeftTranslation;

            _initialPhoneRotation = Phone.transform.localEulerAngles;
            _initialTabletRotation = Tablet.transform.localEulerAngles;

            _phoneOnTheRightRotation = _initialPhoneRotation;
            _phoneOnTheRightRotation.y = _initialTabletRotation.y;
            _tabletOnTheLeftRotation = _initialTabletRotation;
            _tabletOnTheLeftRotation.y = _initialPhoneRotation.y;

            OVRManager.DisplayRefreshRateChanged += DisplayRefreshRateChanged;

            SettingsCanvas.enabled = ExperimentType == ExperimentType.Admin;
            SettingsPointer.enabled = ExperimentType == ExperimentType.Admin;
            _settingsPointerRenderer.enabled = ExperimentType == ExperimentType.Admin;

//#if DEBUG
//            Debug.unityLogger.logEnabled = true;
//#else
            Debug.unityLogger.logEnabled = false;
//#endif
        }

        private void DisplayRefreshRateChanged(float fromRefreshRate, float ToRefreshRate)
        {
            if (Debug.isDebugBuild)
                Debug.Log(@"Refresh rate changed from " + fromRefreshRate + @" to " + ToRefreshRate + @".");
        }

        private void Start()
        {
            if (Debug.isDebugBuild)
                Debug.Log(nameof(Start) + @": Entered.");
            Initialize();
            if (Debug.isDebugBuild)
                Debug.Log(nameof(Start) + @": Left.");
        }

        private void Initialize(bool startExperiment = false)
        {
            if (Debug.isDebugBuild)
                Debug.Log(nameof(Initialize) + @": Entered.");
            InitializeTargets();
            InitializeRefreshRateAndTimeScale();
        }

        private ExperimentConditionsBase CreateExperimentConditions()
        {
            if (ExperimentType == ExperimentType.Admin)
                return new AdminExperimentConditions(StartDelayInMilliSeconds, CuePresentationTimeSpanInMilliSeconds, TargetPresentationTimeSpanInMilliSeconds, ResponseCollectionOnsetInMilliSeconds, ResponseCollectionEndInMilliSeconds, _fixedDeltaTimeInMilliSeconds, RandomizeCueTargetConditions, IsLimitedTestRun, PhoneIsOnTheLeft, PlayBackgroundNoise, UseOriginalCueTargetConditions);

            if (ExperimentType == ExperimentType.Practice)
                return new TutorialExperimentConditions(StartDelayInMilliSeconds, CuePresentationTimeSpanInMilliSeconds, TargetPresentationTimeSpanInMilliSeconds, ResponseCollectionOnsetInMilliSeconds, ResponseCollectionEndInMilliSeconds, _fixedDeltaTimeInMilliSeconds);

            if (ExperimentType == ExperimentType.Original)
                return new OriginalExperimentConditions(StartDelayInMilliSeconds, CuePresentationTimeSpanInMilliSeconds, TargetPresentationTimeSpanInMilliSeconds, ResponseCollectionOnsetInMilliSeconds, ResponseCollectionEndInMilliSeconds, _fixedDeltaTimeInMilliSeconds);

            if (ExperimentType == ExperimentType.Balanced)
                return new BalancedExperimentConditions(StartDelayInMilliSeconds, CuePresentationTimeSpanInMilliSeconds, TargetPresentationTimeSpanInMilliSeconds, ResponseCollectionOnsetInMilliSeconds, ResponseCollectionEndInMilliSeconds, _fixedDeltaTimeInMilliSeconds);

            if (ExperimentType == ExperimentType.Noise)
                return new NoiseExperimentConditions(StartDelayInMilliSeconds, CuePresentationTimeSpanInMilliSeconds, TargetPresentationTimeSpanInMilliSeconds, ResponseCollectionOnsetInMilliSeconds, ResponseCollectionEndInMilliSeconds, _fixedDeltaTimeInMilliSeconds);

            return null;
        }

        private void StartNewRun()
        {
            if (Debug.isDebugBuild)
                Debug.Log(nameof(StartNewRun) + @": Entered.");
            _settingsPointerRenderer.enabled = false;
            SettingsPointer.enabled = false;
            SettingsCanvas.enabled = false;
            Initialize();
            var experimentConditions = CreateExperimentConditions();
            if (experimentConditions.PlayBackgroundNoise || PlayBackgroundNoise)
                _backgroundNoiseAudioSource.Play();
            ExperimentRunPresenter.StartNewRun(experimentConditions);
        }

        private void StopRun()
        {
            if (Debug.isDebugBuild)
                Debug.Log(nameof(StartNewRun) + @": Entered.");
            _backgroundNoiseAudioSource.Stop();
            ExperimentRunPresenter.StopRun();
            SettingsCanvas.enabled = ExperimentType == ExperimentType.Admin;
            SettingsPointer.enabled = ExperimentType == ExperimentType.Admin;
            _settingsPointerRenderer.enabled = ExperimentType == ExperimentType.Admin;
        }

        private void InitializeTargets()
        {
            if (Debug.isDebugBuild)
            {
                Debug.Log(nameof(InitializeTargets) + @": Entered.");
                Debug.Log(nameof(InitializeTargets) + nameof(PhoneIsOnTheLeft) + @" = " + PhoneIsOnTheLeft + @".");
            }

            if (PhoneIsOnTheLeft)
            {
                Phone.transform.position = _initialPhonePosition;
                Phone.transform.localEulerAngles = _initialPhoneRotation;
                Tablet.transform.position = _initialTabletPosition;
                Tablet.transform.localEulerAngles = _initialTabletRotation;
            }
            else
            {
                Phone.transform.position = _phoneOnTheRightPosition;
                Phone.transform.localEulerAngles = _phoneOnTheRightRotation;
                Tablet.transform.position = _tabletOnTheLeftPosition;
                Tablet.transform.localEulerAngles = _tabletOnTheLeftRotation;
            }

            if (Debug.isDebugBuild)
                Debug.Log(nameof(InitializeTargets) + @": Left.");
        }

        private void InitializeRefreshRateAndTimeScale()
        {
            if (Debug.isDebugBuild)
                Debug.Log(nameof(InitializeRefreshRateAndTimeScale) + @": Entered.");
            OVRPlugin.systemDisplayFrequency = (float)RefreshRate;
            Time.fixedDeltaTime = 1f / (float)RefreshRate;
            _fixedDeltaTimeInMilliSeconds = (uint)(Time.fixedDeltaTime * 1000);
            Time.timeScale = 1.0f;
            if (Debug.isDebugBuild)
                Debug.Log(nameof(InitializeRefreshRateAndTimeScale) + @": " + nameof(_fixedDeltaTimeInMilliSeconds) + @" = " + _fixedDeltaTimeInMilliSeconds + @".");
            Time.maximumDeltaTime = 1f / (float)RefreshRate;
            Time.maximumParticleDeltaTime = 1f / (float)RefreshRate;
            if (Debug.isDebugBuild)
                Debug.Log(nameof(InitializeRefreshRateAndTimeScale) + @": Left.");
        }

        private void Update()
        {
            double timeStamp = ExperimentRunPresenter.GetLSLTimeStamp();
            bool leftButtonPressed = OVRInput.GetDown(OVRInput.RawButton.X);
            bool rightButtonPressed = OVRInput.GetDown(OVRInput.RawButton.A);

            var angles = CameraRig.centerEyeAnchor.localEulerAngles;

            if (Debug.isDebugBuild)
                Debug.Log(@"X: " + angles.x + @", Y: " + angles.y + @", Z: " + angles.z + @".");

            ExperimentRunPresenter.PushDataMessage(angles.x, angles.y, angles.z, timeStamp);

            var experimentState = ExperimentRunPresenter.GetCurrentExperimentState();

            if (experimentState != ExperimentState.NotRunning && ExperimentType == ExperimentType.Admin && OVRInput.GetDown(OVRInput.RawButton.B))
            {
                if (Debug.isDebugBuild)
                    Debug.Log(nameof(Update) + @": Stopping experiment run.");
                StopRun();
                return;
            }

            if (experimentState == ExperimentState.NotRunning && OVRInput.GetDown(OVRInput.RawButton.B))
            {
                if (Debug.isDebugBuild)
                    Debug.Log(nameof(Update) + @": Starting experiment run.");
                StartNewRun();
                return;
            }

            if (ExperimentRunPresenter.CurrentTrialHasResult())
            {
                if (Debug.isDebugBuild)
                    Debug.Log(nameof(Update) + @": Aborted. Current trial finished.");
                return;
            }

            if (experimentState != ExperimentState.TargetPresentation && experimentState != ExperimentState.TargetPresentationAndResponseCollection && experimentState != ExperimentState.ResponseCollection)
            {
                //Debug.Log(nameof(Update) + @": Aborted. " + nameof(experimentState) + " = " + experimentState + @".");
                return;
            }

            if (leftButtonPressed || rightButtonPressed)
            {
                ExperimentRunPresenter.PushButtonPressMessage(leftButtonPressed, rightButtonPressed, timeStamp);

                if (experimentState == ExperimentState.TargetPresentation)
                {
                    ExperimentRunPresenter.SetPrematureResult(timeStamp);
                    if (Debug.isDebugBuild)
                        Debug.Log(nameof(Update) + @": Failure. The participant pressed prematurely.");
                    return;
                }

                if (leftButtonPressed && rightButtonPressed)
                {
                    ExperimentRunPresenter.SetIncorrectResult(timeStamp);
                    if (Debug.isDebugBuild)
                        Debug.Log(nameof(Update) + @": Failure. The participant pressed both buttons.");
                    return;
                }

                var foundPhone = false;
                var foundTablet = false;

                if (PhoneIsOnTheLeft)
                {
                    foundPhone = leftButtonPressed && ExperimentRunPresenter.CurrentTargetIsPhone();
                    foundTablet = rightButtonPressed && !ExperimentRunPresenter.CurrentTargetIsPhone();
                }
                else
                {
                    foundPhone = rightButtonPressed && ExperimentRunPresenter.CurrentTargetIsPhone();
                    foundTablet = leftButtonPressed && !ExperimentRunPresenter.CurrentTargetIsPhone();
                }

                if (foundPhone || foundTablet)
                {
                    ExperimentRunPresenter.SetCorrectResult(timeStamp);
                    if (Debug.isDebugBuild)
                        Debug.Log(nameof(Update) + @": Passed. The participant pressed the correct button.");
                    return;
                }

                ExperimentRunPresenter.SetIncorrectResult(timeStamp);

                if (Debug.isDebugBuild)
                    Debug.Log(nameof(Update) + @": Failure. The participant pressed the wrong button.");
            }
        }

        public void UseOriginalCueTargetConditionsChanged(bool useOriginalCueTargetConditions)
        {
            if (Debug.isDebugBuild)
            {
                Debug.Log(nameof(UseOriginalCueTargetConditionsChanged) + @": Entered.");
                Debug.Log(nameof(UseOriginalCueTargetConditionsChanged) + @": " + nameof(useOriginalCueTargetConditions) + @" = " + useOriginalCueTargetConditions + @".");
            }

            if (ExperimentRunPresenter.GetCurrentExperimentState() == ExperimentState.NotRunning)
                UseOriginalCueTargetConditions = useOriginalCueTargetConditions;

            if (Debug.isDebugBuild)
                Debug.Log(nameof(UseOriginalCueTargetConditionsChanged) + @": Left.");
        }

        public void IsLimitedTestRunChanged(bool isLimitedTestRun)
        {
            if (Debug.isDebugBuild)
            {
                Debug.Log(nameof(IsLimitedTestRunChanged) + @": Entered.");
                Debug.Log(nameof(IsLimitedTestRunChanged) + @": " + nameof(isLimitedTestRun) + @" = " + isLimitedTestRun + @".");
            }

            if (ExperimentRunPresenter.GetCurrentExperimentState() == ExperimentState.NotRunning)
                IsLimitedTestRun = isLimitedTestRun;

            if (Debug.isDebugBuild)
                Debug.Log(nameof(IsLimitedTestRunChanged) + @": Left.");
        }

        public void RandomizeCueTargetConditionsChanged(bool randomizeCueTargetConditions)
        {
            if (Debug.isDebugBuild)
            {
                Debug.Log(nameof(RandomizeCueTargetConditionsChanged) + @": Entered.");
                Debug.Log(nameof(RandomizeCueTargetConditionsChanged) + @": " + nameof(randomizeCueTargetConditions) + @" = " + randomizeCueTargetConditions + @".");
            }

            if (ExperimentRunPresenter.GetCurrentExperimentState() == ExperimentState.NotRunning)
                RandomizeCueTargetConditions = randomizeCueTargetConditions;

            if (Debug.isDebugBuild)
                Debug.Log(nameof(RandomizeCueTargetConditionsChanged) + @": Left.");
        }

        public void PhoneIsOnTheLeftChanged(bool phoneIsOnTheLeft)
        {
            if (Debug.isDebugBuild)
            {
                Debug.Log(nameof(PhoneIsOnTheLeftChanged) + @": Entered.");
                Debug.Log(nameof(PhoneIsOnTheLeftChanged) + @": " + nameof(phoneIsOnTheLeft) + @" = " + phoneIsOnTheLeft + @".");
            }

            if (ExperimentRunPresenter.GetCurrentExperimentState() == ExperimentState.NotRunning)
            {
                PhoneIsOnTheLeft = phoneIsOnTheLeft;
                InitializeTargets();
            }

            if (Debug.isDebugBuild)
                Debug.Log(nameof(PhoneIsOnTheLeftChanged) + @": Left.");
        }

        public void PlayBackgroundNoiseChanged(bool playBackgroundNoise)
        {
            if (Debug.isDebugBuild)
            {
                Debug.Log(nameof(PlayBackgroundNoiseChanged) + @": Entered.");
                Debug.Log(nameof(PlayBackgroundNoiseChanged) + @": " + nameof(playBackgroundNoise) + @" = " + playBackgroundNoise + @".");
            }

            if (ExperimentRunPresenter.GetCurrentExperimentState() == ExperimentState.NotRunning)
                PlayBackgroundNoise = playBackgroundNoise;

            if (Debug.isDebugBuild)
                Debug.Log(nameof(PlayBackgroundNoiseChanged) + @": Left.");
        }

        private void OnDestroy()
        {
            OVRManager.DisplayRefreshRateChanged -= DisplayRefreshRateChanged;
        }
    }
}

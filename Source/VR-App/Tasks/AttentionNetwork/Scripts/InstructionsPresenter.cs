using System;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

namespace Assets.Tasks.AttentionalNetwork.Scripts
{
    public class InstructionsPresenter : MonoBehaviour
    {        
        public Image ScreenImage;
        public TextMeshProUGUI LabelTop;
        public TextMeshProUGUI LabelMiddle;
        public TextMeshProUGUI LabelBottom;
        public TextMeshProUGUI LabelButtons;
        public Sprite Idle;
        public Sprite OButton;
        public Sprite PracticePage2;
        public Sprite PracticePage3;
        public Sprite PracticePage4;
        public Sprite PracticePage5;
        public Sprite PracticePage6;
        public Sprite PracticePage7;
        public Sprite PracticePage8;
        public Sprite PracticePage9;
        public Sprite PracticePage10;
        public Sprite PracticePage11;
        public Sprite PracticePage12;
        public Sprite PracticePage13;
        public Sprite BehaviouralPage1;
        public ExperimentRunPresenter ExperimentRunPresenter;
        public ExperimentPresenter ExperimentPresenter;

        private ExperimentType _experimentType;
        private int _praticePageMax = 17;
        private int _behavioralPageMax = 4;
        private int _currentPage;

        void Awake()
        {
            _experimentType = ExperimentPresenter.GetExperimentType();
            
            if (_experimentType == ExperimentType.Practice)
                ShowPracticeInstructions();
            else
                ShowBehavioralInstructions();
        }

        private void ShowBehavioralInstructions()
        {
            _currentPage = 0;
            SetBehavioralInstructionPage(_currentPage);
        }

        private void ShowPracticeInstructions()
        {
            _currentPage = 0;
            SetPraticeInstructionPage(_currentPage);
        }

        private void Update()
        {
            if (ExperimentRunPresenter.GetCurrentExperimentState() != ExperimentState.InstructionPresentation)
            {
                if (Debug.isDebugBuild)
                    Debug.Log(@"Aborted. " + nameof(ExperimentState) + @": " + ExperimentRunPresenter.GetCurrentExperimentState() + @".");
                return;
            }

            bool leftButtonPressed = OVRInput.GetDown(OVRInput.RawButton.Y);
            bool rightButtonPressed = OVRInput.GetDown(OVRInput.RawButton.B);

            if (leftButtonPressed && rightButtonPressed)
                return;

            if (leftButtonPressed)
                _currentPage -= 1;

            if (rightButtonPressed)
                _currentPage += 1;

            if (_currentPage < 0)
                _currentPage = 0;

            if (_experimentType == ExperimentType.Practice)
            {
                if (_currentPage <= _praticePageMax)
                    SetPraticeInstructionPage(_currentPage);

                if (_currentPage > _praticePageMax)
                {
                    ExperimentRunPresenter.InstructionsShown();
                }
            }
            else
            {
                if (_currentPage <= _behavioralPageMax)
                    SetBehavioralInstructionPage(_currentPage);

                if (_currentPage > _behavioralPageMax)
                {
                 
                    ExperimentRunPresenter.InstructionsShown();
                }
            }
        }

        private void SetBehavioralInstructionPage(int page)
        {
            if (Debug.isDebugBuild)
                Debug.Log(@"Show behavioral page:" + page + @".");

            switch (page)
            {
                case 0:
                    SetBehavioralInstructionPageWelcome();
                    break;
                case 1:
                    SetPositioningAvatarPage();
                    break;
                case 2:
                    SetBehavioralInstructionPageOne();
                    break;
                case 3:
                    SetBehavioralInstructionPageTwo();
                    break;
                case 4:
                    SetBehavioralTaskWarning();
                    break;
            }
        }

        private void SetBehavioralInstructionPageWelcome()
        {
            LabelTop.enabled = false;
            LabelMiddle.enabled = true;
            LabelBottom.enabled = false;
            LabelButtons.enabled = true;
            
            LabelTop.text = string.Empty;
            LabelMiddle.text = @"Welcome to the Attention Network Test (VR)" + Environment.NewLine + @"(Behavioural)";
            LabelBottom.text = string.Empty;
            LabelButtons.text = @"Press B for next page.";
            ScreenImage.sprite = Idle;
        }

        private void SetBehavioralInstructionPageOne()
        {
            LabelTop.enabled = true;
            LabelMiddle.enabled = false;
            LabelBottom.enabled = true;
            LabelButtons.enabled = true;
            
            LabelTop.text = @"This is an experiment investigating attention. On each trial, you will be shown a group of 5 phone or tablet symbols on a computer screen. They will be one of the following:";
            LabelMiddle.text = string.Empty;
            LabelBottom.text = @"Your task is to respond to the CENTRE symbol of the group. You should press the X button on your left-hand side controller if the CENTRE symbol is a phone or press the A button on your right-hand side controller if the CENTRE symbol is a tablet.";
            LabelButtons.text = @"Press Y for previous page, press B for next page.";
            ScreenImage.sprite = BehaviouralPage1;
        }

        private void SetBehavioralInstructionPageTwo()
        {
            LabelTop.enabled = true;
            LabelMiddle.enabled = true;
            LabelBottom.enabled = true;
            LabelButtons.enabled = true;
            
            LabelTop.text = @"There will be a cross (+) in the centre of the screen and the groups of phone or tablet symbols will appear on either the left or the right side of the cross. You should try to fixate on the cross throughout the experiment.";
            LabelMiddle.text = @"On some trials rounded rectangles will be shown indicating when the symbols will appear. If rounded rectangles are shown on both sides of the fixation cross, they indicate that the symbols will appear shortly. If there is a rounded rectangle on either the left or the right side of the fixation cross, it indicates that the symbols will appear shortly, in the same or opposite location.";
            LabelBottom.text = @"Please respond as quickly and accurately as possible. Your reaction time and accuracy will be recorded. You will also get feedback via a received or missed call symbol on the phone and tablet situated left and right of the computer screen.";
            LabelButtons.text = @"Press Y for previous page, press B for next page.";
            ScreenImage.sprite = Idle;
        }

        private void SetBehavioralTaskWarning()
        {
            LabelTop.enabled = true;
            LabelMiddle.enabled = true;
            LabelBottom.enabled = true;
            LabelButtons.enabled = true;
            
            LabelTop.text = @"Please lay your wrists on the desk in front of you and keep them positioned there during the experiment.";

            if (_experimentType != ExperimentType.Original)
                LabelMiddle.text = @"The experiment will take about 14 minutes.";
            else
                LabelMiddle.text = @"The experiment will take about 30 minutes.";

            LabelBottom.text = @"If you have any questions, please ask the experimenter now.";
            LabelButtons.text = @"Press Y for previous page, press B to enter the experiment.";
            ScreenImage.sprite = Idle;
        }

        private void SetPraticeInstructionPage(int page)
        {
            if (Debug.isDebugBuild)
                Debug.Log(@"Show pratice page:" + page + @".");

            switch (page)
            {
                case 0:
                    SetPraticeInstructionPageWelcome();
                    break;
                case 1:
                    SetPositioningAvatarPage();
                    break;
                case 2:
                    SetTakeALookPage();
                    break;
                case 3:
                    SetPraticeInstructionPageOne();
                    break;
                case 4:
                    SetPraticeInstructionPageTwo();
                    break;
                case 5:
                    SetPraticeInstructionPageThree();
                    break;
                case 6:
                    SetPraticeInstructionPageFour();
                    break;
                case 7:
                    SetPraticeInstructionPageFive();
                    break;
                case 8:
                    SetPraticeInstructionPageSix();
                    break;
                case 9:
                    SetPraticeInstructionPageSeven();
                    break;
                case 10:
                    SetPraticeInstructionPageEight();
                    break;
                case 11:
                    SetPraticeInstructionPageNine();
                    break;
                case 12:
                    SetPraticeInstructionPageTen();
                    break;
                case 13:
                    SetPraticeInstructionPageEleven();
                    break;
                case 14:
                    SetPraticeInstructionPageTwelve();
                    break;
                case 15:
                    SetPraticeInstructionPageThirteen();
                    break;
                case 16:
                    SetPositioningHandsPage();
                    break;
                case 17:
                    SetPraticeTaskWarning();
                    break;
            }
        }

        private void SetPraticeInstructionPageWelcome()
        {
            LabelTop.enabled = false;
            LabelMiddle.enabled = true;
            LabelBottom.enabled = false;
            LabelButtons.enabled = true;
            
            LabelTop.text = string.Empty;
            LabelMiddle.text = @"Welcome to the Attention Network Test (VR)" + Environment.NewLine + @"Practice Session";
            LabelBottom.text = string.Empty;
            LabelButtons.text = @"Press B for next page.";
            ScreenImage.sprite = Idle;
        }

        private void SetPositioningAvatarPage()
        {
            LabelTop.enabled = true;
            LabelMiddle.enabled = false;
            LabelBottom.enabled = true;
            LabelButtons.enabled = true;
            
            LabelTop.text = @"Please stretch out your right arm so that it is perpendicular to the desk in your real world environment.";
            LabelMiddle.text = string.Empty;
            LabelBottom.text = @"Now, please keep the oval button on your right-hand side controller pressed until a full circle is drawn around an oval symbol right in front of you. This will ensure that you are correctly positioned in the virtual environment.";
            LabelButtons.text = @"Press Y for previous page, press B for next page.";
            ScreenImage.sprite = OButton;
        }

        private void SetTakeALookPage()
        {
            LabelTop.enabled = false;
            LabelMiddle.enabled = true;
            LabelBottom.enabled = false;
            LabelButtons.enabled = true;
            
            LabelTop.text = string.Empty;
            LabelMiddle.text = @"Please take a look around you to familiarise yourself with the virtual environment.";
            LabelBottom.text = string.Empty;
            LabelButtons.text = @"Press Y for previous page, press B for next page.";
            ScreenImage.sprite = Idle;
        }

        private void SetPraticeInstructionPageOne()
        {
            LabelTop.enabled = true;
            LabelMiddle.enabled = true;
            LabelBottom.enabled = true;
            LabelButtons.enabled = true;
            
            LabelTop.text = @"In this experiment, a phone is standing on the left of a computer screen in front of you and a tablet is standing on the right of this screen.";
            LabelMiddle.text = @" On the computer screen, a group of five phone or tablet symbols will appear. Your task is to respond to the symbol in the centre of the group. The symbols will appear either left or right of the cross in the middle of the computer screen.";
            LabelBottom.text = @"Please respond as quickly and accurately as possible. Your reaction time and accuracy will be recorded by the computer.";
            LabelButtons.text = @"Press Y for previous page, press B for next page.";
            ScreenImage.sprite = Idle;
        }

        private void SetPraticeInstructionPageTwo()
        {
            LabelTop.enabled = true;
            LabelMiddle.enabled = false;
            LabelBottom.enabled = false;
            LabelButtons.enabled = true;
            
            LabelTop.text = @"If the centre symbol is a phone, press the X button on your left-hand side controller.";
            LabelMiddle.text = string.Empty;
            LabelBottom.text = string.Empty;
            LabelButtons.text = @"Press Y for previous page, press B for next page.";
            ScreenImage.sprite = PracticePage2;
        }

        private void SetPraticeInstructionPageThree()
        {
            LabelTop.enabled = true;
            LabelMiddle.enabled = false;
            LabelBottom.enabled = false;
            LabelButtons.enabled = true;
            
            LabelTop.text = @"If the centre symbol is a phone, even if the target is on the right side of the cross, press the X button on your left-hand side controller.";
            LabelMiddle.text = string.Empty;
            LabelBottom.text = string.Empty;
            LabelButtons.text = @"Press Y for previous page, press B for next page.";
            ScreenImage.sprite = PracticePage3;
        }

        private void SetPraticeInstructionPageFour()
        {
            LabelTop.enabled = true;
            LabelMiddle.enabled = false;
            LabelBottom.enabled = false;
            LabelButtons.enabled = true;
            
            LabelTop.text = @"If the centre symbol is a tablet, press the A button on your right-hand side controller.";
            LabelMiddle.text = string.Empty;
            LabelBottom.text = string.Empty;
            LabelButtons.text = @"Press Y for previous page, press B for next page.";
            ScreenImage.sprite = PracticePage4;
        }

        private void SetPraticeInstructionPageFive()
        {
            LabelTop.enabled = true;
            LabelMiddle.enabled = false;
            LabelBottom.enabled = false;
            LabelButtons.enabled = true;
            
            LabelTop.text = @"If the centre symbol is a tablet, even if the target is on the left side of the cross, press the A button on your right-hand side controller.";
            LabelMiddle.text = string.Empty;
            LabelBottom.text = string.Empty;
            LabelButtons.text = @"Press Y for previous page, press B for next page.";
            ScreenImage.sprite = PracticePage5;
        }

        private void SetPraticeInstructionPageSix()
        {
            LabelTop.enabled = true;
            LabelMiddle.enabled = false;
            LabelBottom.enabled = true;
            LabelButtons.enabled = true;
            
            LabelTop.text = @"Your target is only the CENTRE symbol. PAY ATTENTION if this symbol is a PHONE or TABLET.";
            LabelMiddle.text = string.Empty;
            LabelBottom.text = @"The correct response would be the X button on your left-hand side controller.";
            LabelButtons.text = @"Press Y for previous page, press B for next page.";
            ScreenImage.sprite = PracticePage6;
        }

        private void SetPraticeInstructionPageSeven()
        {
            LabelTop.enabled = true;
            LabelMiddle.enabled = false;
            LabelBottom.enabled = true;
            LabelButtons.enabled = true;
            
            LabelTop.text = @"Your target is the CENTRE symbol.";
            LabelMiddle.text = string.Empty;
            LabelBottom.text = @"The correct response would be the X button on your left-hand side controller.";
            LabelButtons.text = @"Press Y for previous page, press B for next page.";
            ScreenImage.sprite = PracticePage7;
        }

        private void SetPraticeInstructionPageEight()
        {
            LabelTop.enabled = false;
            LabelMiddle.enabled = false;
            LabelBottom.enabled = true;
            LabelButtons.enabled = true;
            
            LabelTop.text = string.Empty;
            LabelMiddle.text = string.Empty;
            LabelBottom.text = @"The correct response would be the A button on your right-hand side controller.";
            LabelButtons.text = @"Press Y for previous page, press B for next page.";
            ScreenImage.sprite = PracticePage8;
        }

        private void SetPraticeInstructionPageNine()
        {
            LabelTop.enabled = false;
            LabelMiddle.enabled = false;
            LabelBottom.enabled = true;
            LabelButtons.enabled = true;
            
            LabelTop.text = string.Empty;
            LabelMiddle.text = string.Empty;
            LabelBottom.text = @"The correct response would be the A button on your right-hand side controller.";
            LabelButtons.text = @"Press Y for previous page, press B for next page.";
            ScreenImage.sprite = PracticePage9;
        }

        private void SetPraticeInstructionPageTen()
        {
            LabelTop.enabled = true;
            LabelMiddle.enabled = false;
            LabelBottom.enabled = true;
            LabelButtons.enabled = true;
            
            LabelTop.text = @"Additionally, a rounded box may appear on the screen immediately before the phone and tablet symbols appear.";
            LabelMiddle.text = string.Empty;
            LabelBottom.text = @"The box may appear at the same location as the target or at the opposite location.";
            LabelButtons.text = @"Press Y for previous page, press B for next page.";
            ScreenImage.sprite = PracticePage10;
        }

        private void SetPraticeInstructionPageEleven()
        {
            LabelTop.enabled = true;
            LabelMiddle.enabled = false;
            LabelBottom.enabled = false;
            LabelButtons.enabled = true;
            
            LabelTop.text = @"Sometimes, two boxes will appear.";
            LabelMiddle.text = string.Empty;
            LabelBottom.text = string.Empty;
            LabelButtons.text = @"Press Y for previous page, press B for next page.";
            ScreenImage.sprite = PracticePage11;
        }

        private void SetPraticeInstructionPageTwelve()
        {
            LabelTop.enabled = true;
            LabelMiddle.enabled = false;
            LabelBottom.enabled = true;
            LabelButtons.enabled = true;
            
            LabelTop.text = @"You will receive immediate feedback on your performance.";
            LabelMiddle.text = string.Empty;
            LabelBottom.text = @"A green received call symbol will appear on the phone or tablet if you pressed the correct button in time.";
            LabelButtons.text = @"Press Y for previous page, press B for next page.";
            ScreenImage.sprite = PracticePage12;
        }

        private void SetPraticeInstructionPageThirteen()
        {
            LabelTop.enabled = false;
            LabelMiddle.enabled = false;
            LabelBottom.enabled = true;
            LabelButtons.enabled = true;
            
            LabelTop.text = string.Empty;
            LabelMiddle.text = string.Empty;
            LabelBottom.text = @"A red missed call symbol will appear on the phone or tablet if you pressed the wrong button.";
            LabelButtons.text = @"Press Y for previous page, press B for next page.";
            ScreenImage.sprite = PracticePage13;
        }

        private void SetPositioningHandsPage()
        {
            LabelTop.enabled = false;
            LabelMiddle.enabled = true;
            LabelBottom.enabled = false;
            LabelButtons.enabled = true;
            
            LabelTop.text = string.Empty;
            LabelMiddle.text = @"Please lay your wrists on the desk in front of you and keep them positioned there during the following practice session. If you feel that your wrists are not in the right place, please inform the experimenter now.";
            LabelBottom.text = string.Empty;
            LabelButtons.text = @"Press Y for previous page, press B for next page.";
            ScreenImage.sprite = Idle;
        }

        private void SetPraticeTaskWarning()
        {
            LabelTop.enabled = false;
            LabelMiddle.enabled = true;
            LabelBottom.enabled = false;
            LabelButtons.enabled = true;
            
            LabelTop.text = string.Empty;
            LabelMiddle.text = @"There will now be a short practice session.";
            LabelBottom.text = string.Empty;
            LabelButtons.text = @"Press Y for previous page. Press B to enter the pratice session.";
            ScreenImage.sprite = Idle;
        }
    }
}

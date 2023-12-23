namespace Assets.Tasks.AttentionalNetwork.Scripts
{
    public enum ExperimentState
    {
        /// <summary>
        /// Presenting Instructions.
        /// </summary>
        InstructionPresentation = 0,

        /// <summary>
        /// The Experiment hasn't started yet.
        /// </summary>
        NotRunning = 1,

        /// <summary>
        /// The fixation cross is shown for 30 seconds.
        /// </summary>
        FixationCrossPresentation = 2,

        /// <summary>
        /// The experiment has started.
        /// </summary>
        Running = 3,
        
        /// <summary>
        /// The experiment is in the cue phase of a trial.
        /// </summary>
        CuePresentation = 4,

        /// <summary>
        /// The experiment is between cue and onset of the target.
        /// </summary>
        WaitingForTarget = 5,

        /// <summary>
        /// The target is presented but response collection hasn't started yet.
        /// </summary>
        TargetPresentation = 6,

        /// <summary>
        /// The target is still presented and response collection has started.
        /// </summary>
        TargetPresentationAndResponseCollection = 7,

        /// <summary>
        /// The target is not presented anymore but the response collection hasn't stopped yet.
        /// </summary>
        ResponseCollection = 8,

        /// <summary>
        /// The response collection has stopped. The experiment is between two trials.
        /// </summary>
        WaitingForNextTrial = 9,

        Pausing = 10,

        End = 11,

        /// <summary>
        /// The total number of experiment states.
        /// </summary>
        Count = 12
    }
}

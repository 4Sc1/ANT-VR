if (!require(renv)) {
  install.packages("renv")
}

library(renv)

options(scipen = 999)

getRoundedValue <- function(originalValue, numberOfDigits) {
  if (!require(janitor)) {
    install.packages("janitor")
  }
  library(janitor)

  result <- round_half_up(originalValue, digit = numberOfDigits)
}

getMonospacedRoundedValue <- function(originalValue, numberOfDigits) {
  result <- sprintf(
    paste("%.", toString(numberOfDigits), "f", sep = ""),
    getRoundedValue(originalValue, numberOfDigits)
  )
}

getMeanForANOVA <- function(values, numberOfDigits) {
  return(getRoundedValue(mean(values, na.rm = TRUE), numberOfDigits))
}

getFormattedPValue <- function(originalValue) {
  if (originalValue < 0.001) {
    result <- "< 0.001"
  } else {
    result <- paste(getRoundedValue(originalValue, 3), sep = "")
  }
}

getFormattedPValueForANOVA <- function(originalValue) {
  if (originalValue < 0.001) {
    result <- "< 0.001"
  } else if (originalValue < 0.01) {
    result <- "< 0.01"
  } else if (originalValue < 0.05) {
    result <- "< 0.05"
  } else {
    result <- "> 0.05"
  }
}

getFormattedPValueForPairwiseCorrelation <- function(originalValue) {
  if (originalValue < 0.001) {
    result <- "< 0.001"
  } else {
    result <- paste(getRoundedValue(originalValue, 3), sep = "")
  }
}

getFormattedPValueForPlot <- function(originalValue) {
  if (originalValue < 0.001) {
    result <- "<.001"
  } else {
    result <- sub("^0+", "", sprintf(
      paste("%.", 3, "f", sep = ""),
      getRoundedValue(originalValue, 3)
    ))
  }
}

getValueWithPValueAsterisks <- function(valueToDecorate, pValue) {
  if (pValue < 0.001) {
    result <- paste(valueToDecorate, "***", sep = "")
  } else if (pValue < 0.01) {
    result <- paste(valueToDecorate, "**", sep = "")
  } else if (pValue < 0.05) {
    result <- paste(valueToDecorate, "*", sep = "")
  } else {
    result <- paste(valueToDecorate, sep = "")
  }
}

printDescriptiveStatisticsForAge_All <- function() {
  if (!require(psych)) {
    install.packages("psych")
  }
  library(psych)

  dems <- importDemographicsAndQoE_All()
  print(describe(dems$Age))
}

printDescriptiveStatistics <- function(nameOfFactor, values) {
  writeLines(sprintf(nameOfFactor))
  print(prop.table(table(values)))
  writeLines(sprintf(""))
  writeLines(sprintf(""))
}

getDescriptiveStatisticsForDemographics <- function(demographicsAndQoE) {
  if (!require(psych)) {
    install.packages("psych")
  }
  library(psych)

  dems <- demographicsAndQoE
  dems$Gender <- as.factor(dems$Gender)
  dems$Education <- as.factor(dems$Education)
  dems$Nationality <- as.factor(dems$Nationality)
  dems$Handedness <- as.factor(dems$Handedness)
  dems$TimeOfDay <- as.factor(dems$TimeOfDay)

  return(dems)
}

getMissedTrials <- function(participantName, participantResults) {
  missedTrials <- paste(
    which(
      participantResults$SlideTargetAndResponseCollection.ACC == "0"
    ),
    collapse = " "
  )
  return(paste(participantName, " [", missedTrials, "]", sep = ""))
}

printMissedTrialsAll <- function(participantsResults, experimentName) {
  listOfNames <- c(
    "P2",
    "P3",
    "P4",
    "P5",
    "P7",
    "P8",
    "P9",
    "P11",
    "P12",
    "P13",
    "P14",
    "P15",
    "P16",
    "P17",
    "P18",
    "P19",
    "P20",
    "P21",
    "P22",
    "P24",
    "P25",
    "P27",
    "P28",
    "P29",
    "P30",
    "P31",
    "P33",
    "P34",
    "P35",
    "P36",
    "P37",
    "P38",
    "P39",
    "P40",
    "P41",
    "P42",
    "P43",
    "P44",
    "P45",
    "P46",
    "P47",
    "P48",
    "P49",
    "P50"
  )

  pathToOutputFile <- getPath(
    paste(
      "../../../Results/",
      experimentName,
      "_MissedTrials.txt",
      sep = ""
    )
  )
  sink(
    file = pathToOutputFile,
    append = FALSE,
    type = "output",
    split = FALSE
  )

  for (i in 1:length(listOfNames))
  {
    pMissedTrials <- getMissedTrials(listOfNames[i], participantsResults[[i]])
    writeLines(pMissedTrials)
  }

  sink()
}

printAllMissedTrialsAll <- function() {
  antRResults <- importANT_R_All()
  antVRResults <- importANT_VR_All()
  antVRBResults <- importANT_VR_B_All()

  printMissedTrialsAll(antRResults, "ANT-R")
  printMissedTrialsAll(antVRResults, "ANT-VR")
  printMissedTrialsAll(antVRBResults, "ANT-VR Balanced")
}

printDescriptiveStatisticsForDemographics <- function(demographicsAndQoE) {
  if (!require(psych)) {
    install.packages("psych")
  }
  library(psych)

  dems <- getDescriptiveStatisticsForDemographics(demographicsAndQoE)

  pathToOutputFile <- getPath("../../../Results/DescriptiveStatisticsForDemographics.txt")

  sink(
    file = pathToOutputFile,
    append = FALSE,
    type = "output",
    split = FALSE
  )

  writeLines(
    "----------------------------------------------------------------------------"
  )
  writeLines("Descriptive statistics: Demographics and QoE")
  print(describe(dems))
  writeLines("Summary: Demographics and QoE")
  print(summary(dems))
  printDescriptiveStatistics("Gender", dems$Gender)
  printDescriptiveStatistics("Education", dems$Education)
  printDescriptiveStatistics("Nationality", dems$Nationality)
  printDescriptiveStatistics("Handedness", dems$Handedness)
  printDescriptiveStatistics("TimeOfDay", dems$TimeOfDay)
  printDescriptiveStatistics("QoE_PQ", dems$QoE_PQ)
  printDescriptiveStatistics("QoE_RQ", dems$QoE_RQ)
  printDescriptiveStatistics("QoE_TQ", dems$QoE_TQ)
  printDescriptiveStatistics("QoE_CQ", dems$QoE_CQ)
  printDescriptiveStatistics("QoE_IQ", dems$QoE_IQ)
  printDescriptiveStatistics("QoE_OQ", dems$QoE_OQ)
  writeLines(
    "----------------------------------------------------------------------------"
  )

  sink()
}

getSimpleNetworkAndInteractionEffect <- function(diffs) {
  if (!require(lsr)) {
    install.packages("lsr")
  }
  library(lsr)

  rtTtest <- t.test(diffs, mu = 0, alternative = "two.sided")
  rtMean <- getMonospacedRoundedValue(rtTtest[["estimate"]], 1)
  rtSD <- getMonospacedRoundedValue(sd(diffs), 1)

  return(c(rtMean, rtSD))
}

getNetworkAndInteractionEffectForJointPlot <- function(diffs) {
  if (!require(lsr)) {
    install.packages("lsr")
  }
  library(lsr)

  rtTtest <- t.test(diffs, mu = 0, alternative = "two.sided")
  rtMean <- getRoundedValue(rtTtest[["estimate"]], 1)
  rtSD <- getRoundedValue(sd(diffs), 1)

  return(c(rtMean, rtSD))
}

getNetworkAndInteractionEffect <- function(reactDiff, accDiff) {
  if (!require(lsr)) {
    install.packages("lsr")
  }
  library(lsr)

  rtTtest <- t.test(reactDiff, mu = 0, alternative = "two.sided")

  rtMean <- getMonospacedRoundedValue(rtTtest[["estimate"]], 1)
  rtSD <- getMonospacedRoundedValue(sd(reactDiff), 1)
  rtTtest <- getValueWithPValueAsterisks(getMonospacedRoundedValue(rtTtest[["statistic"]], 2), rtTtest[["p.value"]])
  rtCohensD <- getMonospacedRoundedValue(cohensD(reactDiff, mu = 0), 2)

  accTtest <- t.test(accDiff, mu = 0, alternative = "two.sided")

  accMean <- getMonospacedRoundedValue(accTtest[["estimate"]], 1)
  accSD <- getMonospacedRoundedValue(sd(accDiff), 1)
  accTtest <- getValueWithPValueAsterisks(getMonospacedRoundedValue(accTtest[["statistic"]], 2), accTtest[["p.value"]])
  accCohensD <- getMonospacedRoundedValue(cohensD(accDiff, mu = 0), 2)

  resultVector <-
    c(
      rtMean,
      rtSD,
      rtTtest,
      rtCohensD,
      accMean,
      accSD,
      accTtest,
      accCohensD
    )
  names(resultVector) <- c(
    "RT_mean",
    "RT_sd",
    "RT_Tt",
    "RT_CohensD",
    "ACC_mean",
    "ACC_sd",
    "ACC_Tt",
    "ACC_CohensD"
  )

  return(resultVector)
}

printNetworkAndInteractionEffect <- function(nameOfEffect, values) {
  if (!require(lsr)) {
    install.packages("lsr")
  }
  library(lsr)

  writeLines(sprintf(nameOfEffect))
  tTest <- t.test(values, mu = 0, alternative = "two.sided")
  mean <- getRoundedValue(tTest[["estimate"]], 2)
  sd <- getRoundedValue(sd(values), 2)
  p <- getFormattedPValueForPairwiseCorrelation(tTest[["p.value"]])
  param <- tTest[["parameter"]]
  tres <- getRoundedValue(tTest[["statistic"]], 2)
  cohen <- getRoundedValue(cohensD(values, mu = 0), 3)
  print(tTest)
  writeLines(toString(paste(
    "n:", length(values),
    sep = " ", collapse = NULL
  )))
  writeLines(toString(paste(
    "sd:", sd(values),
    sep = " ", collapse = NULL
  )))
  writeLines(toString(paste("cohen's D:", cohensD(values, mu = 0))))
  writeLines(
    paste(
      nameOfEffect,
      ": (M = ",
      mean,
      ", SD = ",
      sd,
      ") , t(",
      param,
      ") = ",
      tres,
      ", p = ",
      p,
      ", Cohen's D = ",
      cohen,
      sep = ""
    )
  )
  writeLines(sprintf(""))
  writeLines(sprintf(""))
}

printNetworkAndInteractionEffects <- function(allResults) {
  pathToOutputFile <- getPath("../../../Results/NetworkAndInteractionEffects.txt")

  sink(
    file = pathToOutputFile,
    append = FALSE,
    type = "output",
    split = FALSE
  )

  writeLines(
    "----------------------------------------------------------------------------"
  )
  writeLines("Network And Interaction Effects: Two-tailed One Sample T-test")
  printNetworkAndInteractionEffect("ANT-R Alerting (RT)", allResults$R_RT_Alerting)
  printNetworkAndInteractionEffect("ANT-R Alerting (ACC)", allResults$R_ACC_Alerting)
  printNetworkAndInteractionEffect("ANT-R Validity (RT)", allResults$R_RT_Validity)
  printNetworkAndInteractionEffect("ANT-R Validity (ACC)", allResults$R_ACC_Validity)
  printNetworkAndInteractionEffect("ANT-R Disengaging (RT)", allResults$R_RT_Disengaging)
  printNetworkAndInteractionEffect("ANT-R Disengaging (ACC)", allResults$R_ACC_Disengaging)
  printNetworkAndInteractionEffect(
    "ANT-R Moving + Engaging (RT)",
    allResults$R_RT_Moving_Engaging
  )
  printNetworkAndInteractionEffect(
    "ANT-R Moving + Engaging (ACC)",
    allResults$R_ACC_Moving_Engaging
  )
  printNetworkAndInteractionEffect("ANT-R Orienting Time (RT)", allResults$R_RT_OrientingTime)
  printNetworkAndInteractionEffect("ANT-R Orienting Time (ACC)", allResults$R_ACC_OrientingTime)
  printNetworkAndInteractionEffect(
    "ANT-R Flanker Conflict (RT)",
    allResults$R_RT_FlankerConflict
  )
  printNetworkAndInteractionEffect(
    "ANT-R Flanker Conflict (ACC)",
    allResults$R_ACC_FlankerConflict
  )
  printNetworkAndInteractionEffect(
    "ANT-R Location Conflict (RT)",
    allResults$R_RT_LocationConflict
  )
  printNetworkAndInteractionEffect(
    "ANT-R Location Conflict (ACC)",
    allResults$R_ACC_LocationConflict
  )
  printNetworkAndInteractionEffect(
    "ANT-R Flanker By Location (RT)",
    allResults$R_RT_FlankerByLocation
  )
  printNetworkAndInteractionEffect(
    "ANT-R Flanker By Location (ACC)",
    allResults$R_ACC_FlankerByLocation
  )
  printNetworkAndInteractionEffect(
    "ANT-R Alerting By Flanker (RT)",
    allResults$R_RT_AlertingByFlanker
  )
  printNetworkAndInteractionEffect(
    "ANT-R Alerting By Flanker (ACC)",
    allResults$R_ACC_AlertingByFlanker
  )
  printNetworkAndInteractionEffect(
    "ANT-R Orienting By Flanker (RT)",
    allResults$R_RT_OrientingByFlanker
  )
  printNetworkAndInteractionEffect(
    "ANT-R Orienting By Flanker (ACC)",
    allResults$R_ACC_OrientingByFlanker
  )
  printNetworkAndInteractionEffect(
    "ANT-R Validity By Flanker (RT)",
    allResults$R_RT_ValidityByFlanker
  )
  printNetworkAndInteractionEffect(
    "ANT-R Validity By Flanker (ACC)",
    allResults$R_ACC_ValidityByFlanker
  )
  printNetworkAndInteractionEffect(
    "ANT-R Alerting By Location (RT)",
    allResults$R_RT_AlertingByLocation
  )
  printNetworkAndInteractionEffect(
    "ANT-R Alerting By Location (ACC)",
    allResults$R_ACC_AlertingByLocation
  )
  printNetworkAndInteractionEffect(
    "ANT-R Orienting By Location (RT)",
    allResults$R_RT_OrientingByLocation
  )
  printNetworkAndInteractionEffect(
    "ANT-R Orienting By Location (ACC)",
    allResults$R_ACC_OrientingByLocation
  )
  printNetworkAndInteractionEffect(
    "ANT-R Validity By Location (RT)",
    allResults$R_RT_ValidityByLocation
  )
  printNetworkAndInteractionEffect(
    "ANT-R Validity By Location (ACC)",
    allResults$R_ACC_ValidityByLocation
  )
  printNetworkAndInteractionEffect("ANT-R Inhibition of Return (RT)", allResults$R_RT_IOR)
  printNetworkAndInteractionEffect("ANT-R Inhibition of Return (ACC)", allResults$R_ACC_IOR)
  printNetworkAndInteractionEffect("ANT-R Mean RT", allResults$R_RT)
  printNetworkAndInteractionEffect("ANT-R Mean ACC", allResults$R_ACC)

  printNetworkAndInteractionEffect("ANT-VR Alerting (RT)", allResults$VR_RT_Alerting)
  printNetworkAndInteractionEffect("ANT-VR Alerting (ACC)", allResults$VR_ACC_Alerting)
  printNetworkAndInteractionEffect("ANT-VR Validity (RT)", allResults$VR_RT_Validity)
  printNetworkAndInteractionEffect("ANT-VR Validity (ACC)", allResults$VR_ACC_Validity)
  printNetworkAndInteractionEffect("ANT-VR Disengaging (RT)", allResults$VR_RT_Disengaging)
  printNetworkAndInteractionEffect("ANT-VR Disengaging (ACC)", allResults$VR_ACC_Disengaging)
  printNetworkAndInteractionEffect(
    "ANT-VR Moving + Engaging (RT)",
    allResults$VR_RT_Moving_Engaging
  )
  printNetworkAndInteractionEffect(
    "ANT-VR Moving + Engaging (ACC)",
    allResults$VR_ACC_Moving_Engaging
  )
  printNetworkAndInteractionEffect("ANT-VR Orienting Time (RT)", allResults$VR_RT_OrientingTime)
  printNetworkAndInteractionEffect(
    "ANT-VR Orienting Time (ACC)",
    allResults$VR_ACC_OrientingTime
  )
  printNetworkAndInteractionEffect(
    "ANT-VR Flanker Conflict (RT)",
    allResults$VR_RT_FlankerConflict
  )
  printNetworkAndInteractionEffect(
    "ANT-VR Flanker Conflict (ACC)",
    allResults$VR_ACC_FlankerConflict
  )
  printNetworkAndInteractionEffect(
    "ANT-VR Location Conflict (RT)",
    allResults$VR_RT_LocationConflict
  )
  printNetworkAndInteractionEffect(
    "ANT-VR Location Conflict (ACC)",
    allResults$VR_ACC_LocationConflict
  )
  printNetworkAndInteractionEffect(
    "ANT-VR Flanker By Location (RT)",
    allResults$VR_RT_FlankerByLocation
  )
  printNetworkAndInteractionEffect(
    "ANT-VR Flanker By Location (ACC)",
    allResults$VR_ACC_FlankerByLocation
  )
  printNetworkAndInteractionEffect(
    "ANT-VR Alerting By Flanker (RT)",
    allResults$VR_RT_AlertingByFlanker
  )
  printNetworkAndInteractionEffect(
    "ANT-VR Alerting By Flanker (ACC)",
    allResults$VR_ACC_AlertingByFlanker
  )
  printNetworkAndInteractionEffect(
    "ANT-VR Orienting By Flanker (RT)",
    allResults$VR_RT_OrientingByFlanker
  )
  printNetworkAndInteractionEffect(
    "ANT-VR Orienting By Flanker (ACC)",
    allResults$VR_ACC_OrientingByFlanker
  )
  printNetworkAndInteractionEffect(
    "ANT-VR Validity By Flanker (RT)",
    allResults$VR_RT_ValidityByFlanker
  )
  printNetworkAndInteractionEffect(
    "ANT-VR Validity By Flanker (ACC)",
    allResults$VR_ACC_ValidityByFlanker
  )
  printNetworkAndInteractionEffect(
    "ANT-VR Alerting By Location (RT)",
    allResults$VR_RT_AlertingByLocation
  )
  printNetworkAndInteractionEffect(
    "ANT-VR Alerting By Location (ACC)",
    allResults$VR_ACC_AlertingByLocation
  )
  printNetworkAndInteractionEffect(
    "ANT-VR Orienting By Location (RT)",
    allResults$VR_RT_OrientingByLocation
  )
  printNetworkAndInteractionEffect(
    "ANT-VR Orienting By Location (ACC)",
    allResults$VR_ACC_OrientingByLocation
  )
  printNetworkAndInteractionEffect(
    "ANT-VR Validity By Location (RT)",
    allResults$VR_RT_ValidityByLocation
  )
  printNetworkAndInteractionEffect(
    "ANT-VR Validity By Location (ACC)",
    allResults$VR_ACC_ValidityByLocation
  )
  printNetworkAndInteractionEffect("ANT-VR Inhibition of Return (RT)", allResults$VR_RT_IOR)
  printNetworkAndInteractionEffect("ANT-VR Inhibition of Return (ACC)", allResults$VR_ACC_IOR)
  printNetworkAndInteractionEffect("ANT-VR Mean RT", allResults$VR_RT)
  printNetworkAndInteractionEffect("ANT-VR Mean ACC", allResults$VR_ACC)

  printNetworkAndInteractionEffect("ANT-VR B Alerting (RT)", allResults$VR_B_RT_Alerting)
  printNetworkAndInteractionEffect("ANT-VR B Alerting (ACC)", allResults$VR_B_ACC_Alerting)
  printNetworkAndInteractionEffect("ANT-VR B Validity (RT)", allResults$VR_B_RT_Validity)
  printNetworkAndInteractionEffect("ANT-VR B Validity (ACC)", allResults$VR_B_ACC_Validity)
  printNetworkAndInteractionEffect("ANT-VR B Disengaging (RT)", allResults$VR_B_RT_Disengaging)
  printNetworkAndInteractionEffect(
    "ANT-VR B Disengaging (ACC)",
    allResults$VR_B_ACC_Disengaging
  )
  printNetworkAndInteractionEffect(
    "ANT-VR B Moving + Engaging (RT)",
    allResults$VR_B_RT_Moving_Engaging
  )
  printNetworkAndInteractionEffect(
    "ANT-VR B Moving + Engaging (ACC)",
    allResults$VR_B_ACC_Moving_Engaging
  )
  printNetworkAndInteractionEffect(
    "ANT-VR B Orienting Time (RT)",
    allResults$VR_B_RT_OrientingTime
  )
  printNetworkAndInteractionEffect(
    "ANT-VR B Orienting Time (ACC)",
    allResults$VR_B_ACC_OrientingTime
  )
  printNetworkAndInteractionEffect(
    "ANT-VR B Flanker Conflict (RT)",
    allResults$VR_B_RT_FlankerConflict
  )
  printNetworkAndInteractionEffect(
    "ANT-VR B Flanker Conflict (ACC)",
    allResults$VR_B_ACC_FlankerConflict
  )
  printNetworkAndInteractionEffect(
    "ANT-VR B Location Conflict (RT)",
    allResults$VR_B_RT_LocationConflict
  )
  printNetworkAndInteractionEffect(
    "ANT-VR B Location Conflict (ACC)",
    allResults$VR_B_ACC_LocationConflict
  )
  printNetworkAndInteractionEffect(
    "ANT-VR B Flanker By Location (RT)",
    allResults$VR_B_RT_FlankerByLocation
  )
  printNetworkAndInteractionEffect(
    "ANT-VR B Flanker By Location (ACC)",
    allResults$VR_B_ACC_FlankerByLocation
  )
  printNetworkAndInteractionEffect(
    "ANT-VR B Alerting By Flanker (RT)",
    allResults$VR_B_RT_AlertingByFlanker
  )
  printNetworkAndInteractionEffect(
    "ANT-VR B Alerting By Flanker (ACC)",
    allResults$VR_B_ACC_AlertingByFlanker
  )
  printNetworkAndInteractionEffect(
    "ANT-VR B Orienting By Flanker (RT)",
    allResults$VR_B_RT_OrientingByFlanker
  )
  printNetworkAndInteractionEffect(
    "ANT-VR B Orienting By Flanker (ACC)",
    allResults$VR_B_ACC_OrientingByFlanker
  )
  printNetworkAndInteractionEffect(
    "ANT-VR B Validity By Flanker (RT)",
    allResults$VR_B_RT_ValidityByFlanker
  )
  printNetworkAndInteractionEffect(
    "ANT-VR B Validity By Flanker (ACC)",
    allResults$VR_B_ACC_ValidityByFlanker
  )
  printNetworkAndInteractionEffect(
    "ANT-VR B Alerting By Location (RT)",
    allResults$VR_B_RT_AlertingByLocation
  )
  printNetworkAndInteractionEffect(
    "ANT-VR B Alerting By Location (ACC)",
    allResults$VR_B_ACC_AlertingByLocation
  )
  printNetworkAndInteractionEffect(
    "ANT-VR B Orienting By Location (RT)",
    allResults$VR_B_RT_OrientingByLocation
  )
  printNetworkAndInteractionEffect(
    "ANT-VR B Orienting By Location (ACC)",
    allResults$VR_B_ACC_OrientingByLocation
  )
  printNetworkAndInteractionEffect(
    "ANT-VR B Validity By Location (RT)",
    allResults$VR_B_RT_ValidityByLocation
  )
  printNetworkAndInteractionEffect(
    "ANT-VR B Validity By Location (ACC)",
    allResults$VR_B_ACC_ValidityByLocation
  )
  printNetworkAndInteractionEffect("ANT-VR B Inhibition of Return (RT)", allResults$VR_B_RT_IOR)
  printNetworkAndInteractionEffect("ANT-VR B Inhibition of Return (ACC)", allResults$VR_B_ACC_IOR)
  printNetworkAndInteractionEffect("ANT-VR B Mean RT", allResults$VR_B_RT)
  printNetworkAndInteractionEffect("ANT-VR B Mean ACC", allResults$VR_B_ACC)
  writeLines(
    "----------------------------------------------------------------------------"
  )

  sink()
}

getTwoSampleCohensD <- function(groupA, groupB) {
  meanA <- mean(groupA)
  sdA <- sd(groupA)
  meanB <- mean(groupB)
  sdB <- sd(groupB)

  meanDiff <- meanA - meanB
  sdCommon <- sqrt((sdA * sdA + sdB * sdB) / 2)

  return(meanDiff / sdCommon)
}

printANOVAResultAsFormulas <- function(anovaResult) {
  if (!require(rstatix)) {
    install.packages("rstatix")
  }
  library(rstatix)

  anovaData <- anovaResult$ANOVA

  writeLines("ANOVA results for reporting: ")
  for (row in 1:nrow(anovaData)) {
    writeLines(
      paste(
        anovaData$Effect[row],
        ": F(",
        anovaData$DFn[row],
        ",",
        anovaData$DFd[row],
        ") = ",
        getRoundedValue(anovaData$F[row], 2),
        ", p ",
        getFormattedPValueForANOVA(anovaData$p[row]),
        ", ηp² = ",
        getRoundedValue(anovaData$pes[row], 3),
        sep = ""
      )
    )
  }
}

printAlertingByConflict_ANOVA <- function(id,
                                          nc_FCLC,
                                          nc_FICLC,
                                          nc_FCLIC,
                                          nc_FICLIC,
                                          dc_0_FCLC,
                                          dc_0_FICLC,
                                          dc_0_FCLIC,
                                          dc_0_FICLIC,
                                          dc_400_FCLC,
                                          dc_400_FICLC,
                                          dc_400_FCLIC,
                                          dc_400_FICLIC,
                                          dc_800_FCLC,
                                          dc_800_FICLC,
                                          dc_800_FCLIC,
                                          dc_800_FICLIC,
                                          experimentName,
                                          valueColumnName) {
  if (!require(tidyverse)) {
    install.packages("tidyverse")
  }
  if (!require(rstatix)) {
    install.packages("rstatix")
  }
  library(tidyverse)
  library(rstatix)

  resultSet <- data.frame(
    Id = integer(0),
    CueToTarget = character(0),
    FlankerCongruency = character(0),
    LocationCongruency = character(0),
    ValueCol = numeric(0)
  )

  for (row in 1:length(id)) {
    resultSet <- (
      resultSet %>% add_row(
        Id = id[row],
        CueToTarget = "no-cue",
        FlankerCongruency = "congruent",
        LocationCongruency = "congruent",
        ValueCol = nc_FCLC[row]
      )
      %>% add_row(
          Id = id[row],
          CueToTarget = "no-cue",
          FlankerCongruency = "incongruent",
          LocationCongruency = "congruent",
          ValueCol = nc_FICLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "no-cue",
          FlankerCongruency = "congruent",
          LocationCongruency = "incongruent",
          ValueCol = nc_FCLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "no-cue",
          FlankerCongruency = "incongruent",
          LocationCongruency = "incongruent",
          ValueCol = nc_FICLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "0",
          FlankerCongruency = "congruent",
          LocationCongruency = "congruent",
          ValueCol = dc_0_FCLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "0",
          FlankerCongruency = "incongruent",
          LocationCongruency = "congruent",
          ValueCol = dc_0_FICLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "0",
          FlankerCongruency = "congruent",
          LocationCongruency = "incongruent",
          ValueCol = dc_0_FCLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "0",
          FlankerCongruency = "incongruent",
          LocationCongruency = "incongruent",
          ValueCol = dc_0_FICLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "400",
          FlankerCongruency = "congruent",
          LocationCongruency = "congruent",
          ValueCol = dc_400_FCLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "400",
          FlankerCongruency = "incongruent",
          LocationCongruency = "congruent",
          ValueCol = dc_400_FICLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "400",
          FlankerCongruency = "congruent",
          LocationCongruency = "incongruent",
          ValueCol = dc_400_FCLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "400",
          FlankerCongruency = "incongruent",
          LocationCongruency = "incongruent",
          ValueCol = dc_400_FICLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "800",
          FlankerCongruency = "congruent",
          LocationCongruency = "congruent",
          ValueCol = dc_800_FCLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "800",
          FlankerCongruency = "incongruent",
          LocationCongruency = "congruent",
          ValueCol = dc_800_FICLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "800",
          FlankerCongruency = "congruent",
          LocationCongruency = "incongruent",
          ValueCol = dc_800_FCLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "800",
          FlankerCongruency = "incongruent",
          LocationCongruency = "incongruent",
          ValueCol = dc_800_FICLIC[row]
        )
    )
  }

  writeLines("")
  writeLines(paste(experimentName, valueColumnName, sep = " "))
  abc_anova <- anova_test(
    data = resultSet,
    dv = ValueCol,
    wid = Id,
    within = c(CueToTarget, FlankerCongruency, LocationCongruency),
    effect.size = "pes"
  )
  print(abc_anova)
  printANOVAResultAsFormulas(abc_anova)

  noCue <- getMeanForANOVA(subset(resultSet, CueToTarget == "no-cue")$ValueCol, 2)
  doubleCue <- getMeanForANOVA(subset(resultSet, CueToTarget != "no-cue")$ValueCol, 2)
  doubleCue0 <- getMeanForANOVA(subset(resultSet, CueToTarget == "0")$ValueCol, 2)
  doubleCue400 <- getMeanForANOVA(subset(resultSet, CueToTarget == "400")$ValueCol, 2)
  doubleCue800 <- getMeanForANOVA(subset(resultSet, CueToTarget == "800")$ValueCol, 2)
  fc <- getMeanForANOVA(
    subset(resultSet, FlankerCongruency == "congruent")$ValueCol, 2
  )
  fic <- getMeanForANOVA(
    subset(resultSet, FlankerCongruency == "incongruent")$ValueCol, 2
  )
  lc <- getMeanForANOVA(
    subset(resultSet, LocationCongruency == "congruent")$ValueCol, 2
  )
  lic <- getMeanForANOVA(
    subset(resultSet, LocationCongruency == "incongruent")$ValueCol, 2
  )

  noCue_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "no-cue" &
        FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget != "no-cue" &
        FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue0_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "0" & FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue400_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "400" &
        FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue800_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "800" &
        FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  noCue_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "no-cue" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget != "no-cue" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue0_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "0" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue400_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "400" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue800_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "800" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )

  noCue_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "no-cue" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget != "no-cue" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue0_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "0" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue400_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "400" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue800_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "800" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  noCue_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "no-cue" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget != "no-cue" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue0_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "0" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue400_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "400" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue800_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "800" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )

  fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )

  noCue_fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "no-cue" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue_fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget != "no-cue" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue0_fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "0" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue400_fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "400" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue800_fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "800" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  noCue_fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "no-cue" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue_fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget != "no-cue" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue0_fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "0" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue400_fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "400" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue800_fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "800" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  noCue_fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "no-cue" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue_fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget != "no-cue" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue0_fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "0" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue400_fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "400" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue800_fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "800" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  noCue_fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "no-cue" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue_fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget != "no-cue" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue0_fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "0" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue400_fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "400" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue800_fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "800" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )

  writeLines(sprintf(""))
  writeLines("Main Effects")
  writeLines("     CueToTarget")
  writeLines(paste("     no-cue = ", noCue, sep = ""))
  writeLines(paste("     double-cue = ", doubleCue, sep = ""))
  writeLines(paste("     0 = ", doubleCue0, sep = ""))
  writeLines(paste("     400 = ", doubleCue400, sep = ""))
  writeLines(paste("     800 = ", doubleCue800, sep = ""))
  writeLines(sprintf(""))

  writeLines("     FlankerCongruency")
  writeLines(paste("     congruent = ", fc, sep = ""))
  writeLines(paste("     incongruent = ", fic, sep = ""))
  writeLines(sprintf(""))

  writeLines("     LocationCongruency")
  writeLines(paste("     congruent = ", lc, sep = ""))
  writeLines(paste("     incongruent = ", lic, sep = ""))
  writeLines(sprintf(""))

  writeLines("     CueToTarget : FlankerCongruency")
  writeLines(paste("     no-cue : congruent = ", noCue_fc, sep = ""))
  writeLines(paste("     double-cue : congruent = ", doubleCue_fc, sep = ""))
  writeLines(paste("     0 : congruent = ", doubleCue0_fc, sep = ""))
  writeLines(paste("     400 : congruent = ", doubleCue400_fc, sep = ""))
  writeLines(paste("     800 : congruent = ", doubleCue800_fc, sep = ""))
  writeLines(paste("     no-cue : incongruent = ", noCue_fic, sep = ""))
  writeLines(paste("     double-cue : incongruent = ", doubleCue_fic, sep = ""))
  writeLines(paste("     0 : incongruent = ", doubleCue0_fic, sep = ""))
  writeLines(paste("     400 : incongruent = ", doubleCue400_fic, sep = ""))
  writeLines(paste("     800 : incongruent = ", doubleCue800_fic, sep = ""))
  writeLines(sprintf(""))

  writeLines("     CueToTarget : LocationCongruency")
  writeLines(paste("     no-cue : congruent = ", noCue_lc, sep = ""))
  writeLines(paste("     double-cue : congruent = ", doubleCue_lc, sep = ""))
  writeLines(paste("     0 : congruent = ", doubleCue0_lc, sep = ""))
  writeLines(paste("     400 : congruent = ", doubleCue400_lc, sep = ""))
  writeLines(paste("     800 : congruent = ", doubleCue800_lc, sep = ""))
  writeLines(paste("     no-cue : incongruent = ", noCue_lic, sep = ""))
  writeLines(paste("     double-cue : incongruent = ", doubleCue_lic, sep = ""))
  writeLines(paste("     0 : incongruent = ", doubleCue0_lic, sep = ""))
  writeLines(paste("     400 : incongruent = ", doubleCue400_lic, sep = ""))
  writeLines(paste("     800 : incongruent = ", doubleCue800_lic, sep = ""))
  writeLines(sprintf(""))

  writeLines("     FlankerCongruency : LocationCongruency")
  writeLines(paste("     congruent : congruent = ", fc_lc, sep = ""))
  writeLines(paste("     congruent : incongruent = ", fc_lic, sep = ""))
  writeLines(paste("     incongruent : congruent = ", fic_lc, sep = ""))
  writeLines(paste("     incongruent : incongruent = ", fic_lic, sep = ""))
  writeLines(sprintf(""))

  writeLines("     CueToTarget : FlankerCongruency : LocationCongruency")
  writeLines(paste("     no-cue : congruent : congruent = ", noCue_fc_lc, sep = ""))
  writeLines(paste("     double-cue : congruent : congruent = ", doubleCue_fc_lc, sep = ""))
  writeLines(paste("     0 : congruent : congruent = ", doubleCue0_fc_lc, sep = ""))
  writeLines(paste("     400 : congruent : congruent = ", doubleCue400_fc_lc, sep = ""))
  writeLines(paste("     800 : congruent : congruent = ", doubleCue800_fc_lc, sep = ""))
  writeLines(paste("     no-cue : incongruent : congruent = ", noCue_fic_lc, sep = ""))
  writeLines(paste(
    "     double-cue : incongruent : congruent = ",
    doubleCue_fic_lc,
    sep = ""
  ))
  writeLines(paste("     0 : incongruent : congruent = ", doubleCue0_fic_lc, sep = ""))
  writeLines(paste("     400 : incongruent : congruent = ", doubleCue400_fic_lc, sep = ""))
  writeLines(paste("     800 : incongruent : congruent = ", doubleCue800_fic_lc, sep = ""))
  writeLines(paste("     no-cue : congruent : incongruent = ", noCue_fc_lic, sep = ""))
  writeLines(paste(
    "     double-cue : congruent : incongruent = ",
    doubleCue_fc_lic,
    sep = ""
  ))
  writeLines(paste("     0 : congruent : incongruent = ", doubleCue0_fc_lic, sep = ""))
  writeLines(paste("     400 : congruent : incongruent = ", doubleCue400_fc_lic, sep = ""))
  writeLines(paste("     800 : congruent : incongruent = ", doubleCue800_fc_lic, sep = ""))
  writeLines(paste("     no-cue : incongruent : incongruent = ", noCue_fic_lic, sep = ""))
  writeLines(paste(
    "     double-cue : incongruent : incongruent = ",
    doubleCue_fic_lic,
    sep = ""
  ))
  writeLines(paste("     0 : incongruent : incongruent = ", doubleCue0_fic_lic, sep = ""))
  writeLines(paste("     400 : incongruent : incongruent = ", doubleCue400_fic_lic, sep = ""))
  writeLines(paste("     800 : incongruent : incongruent = ", doubleCue800_fic_lic, sep = ""))

  writeLines(sprintf(""))
  writeLines(sprintf(""))
}

printAlertingByConflict_ANOVAs <- function(allResults, participantsFolder) {
  pathToOutputFile <- getPath("../../../Results/AlertingByConflict_ANOVAs.txt")

  sink(
    file = pathToOutputFile,
    append = FALSE,
    type = "output",
    split = FALSE
  )

  writeLines(
    "----------------------------------------------------------------------------"
  )
  writeLines("Within-subject ANOVAs: Alerting by Conflict")

  printAlertingByConflict_ANOVA(
    allResults$Id,
    allResults$R_RT_NC_FCLC,
    allResults$R_RT_NC_FICLC,
    allResults$R_RT_NC_FCLIC,
    allResults$R_RT_NC_FICLIC,
    allResults$R_RT_DC_0_FCLC,
    allResults$R_RT_DC_0_FICLC,
    allResults$R_RT_DC_0_FCLIC,
    allResults$R_RT_DC_0_FICLIC,
    allResults$R_RT_DC_400_FCLC,
    allResults$R_RT_DC_400_FICLC,
    allResults$R_RT_DC_400_FCLIC,
    allResults$R_RT_DC_400_FICLIC,
    allResults$R_RT_DC_800_FCLC,
    allResults$R_RT_DC_800_FICLC,
    allResults$R_RT_DC_800_FCLIC,
    allResults$R_RT_DC_800_FICLIC,
    "ANT-R",
    "(RT)"
  )

  printAlertingByConflict_ANOVA(
    allResults$Id,
    allResults$R_ACC_NC_FCLC,
    allResults$R_ACC_NC_FICLC,
    allResults$R_ACC_NC_FCLIC,
    allResults$R_ACC_NC_FICLIC,
    allResults$R_ACC_DC_0_FCLC,
    allResults$R_ACC_DC_0_FICLC,
    allResults$R_ACC_DC_0_FCLIC,
    allResults$R_ACC_DC_0_FICLIC,
    allResults$R_ACC_DC_400_FCLC,
    allResults$R_ACC_DC_400_FICLC,
    allResults$R_ACC_DC_400_FCLIC,
    allResults$R_ACC_DC_400_FICLIC,
    allResults$R_ACC_DC_800_FCLC,
    allResults$R_ACC_DC_800_FICLC,
    allResults$R_ACC_DC_800_FCLIC,
    allResults$R_ACC_DC_800_FICLIC,
    "ANT-R",
    "(ACC)"
  )

  printAlertingByConflict_ANOVA(
    allResults$Id,
    allResults$VR_RT_NC_FCLC,
    allResults$VR_RT_NC_FICLC,
    allResults$VR_RT_NC_FCLIC,
    allResults$VR_RT_NC_FICLIC,
    allResults$VR_RT_DC_0_FCLC,
    allResults$VR_RT_DC_0_FICLC,
    allResults$VR_RT_DC_0_FCLIC,
    allResults$VR_RT_DC_0_FICLIC,
    allResults$VR_RT_DC_400_FCLC,
    allResults$VR_RT_DC_400_FICLC,
    allResults$VR_RT_DC_400_FCLIC,
    allResults$VR_RT_DC_400_FICLIC,
    allResults$VR_RT_DC_800_FCLC,
    allResults$VR_RT_DC_800_FICLC,
    allResults$VR_RT_DC_800_FCLIC,
    allResults$VR_RT_DC_800_FICLIC,
    "ANT-VR",
    "(RT)"
  )

  printAlertingByConflict_ANOVA(
    allResults$Id,
    allResults$VR_ACC_NC_FCLC,
    allResults$VR_ACC_NC_FICLC,
    allResults$VR_ACC_NC_FCLIC,
    allResults$VR_ACC_NC_FICLIC,
    allResults$VR_ACC_DC_0_FCLC,
    allResults$VR_ACC_DC_0_FICLC,
    allResults$VR_ACC_DC_0_FCLIC,
    allResults$VR_ACC_DC_0_FICLIC,
    allResults$VR_ACC_DC_400_FCLC,
    allResults$VR_ACC_DC_400_FICLC,
    allResults$VR_ACC_DC_400_FCLIC,
    allResults$VR_ACC_DC_400_FICLIC,
    allResults$VR_ACC_DC_800_FCLC,
    allResults$VR_ACC_DC_800_FICLC,
    allResults$VR_ACC_DC_800_FCLIC,
    allResults$VR_ACC_DC_800_FICLIC,
    "ANT-VR",
    "(ACC)"
  )

  printAlertingByConflict_ANOVA(
    allResults$Id,
    allResults$VR_B_RT_NC_FCLC,
    allResults$VR_B_RT_NC_FICLC,
    allResults$VR_B_RT_NC_FCLIC,
    allResults$VR_B_RT_NC_FICLIC,
    allResults$VR_B_RT_DC_0_FCLC,
    allResults$VR_B_RT_DC_0_FICLC,
    allResults$VR_B_RT_DC_0_FCLIC,
    allResults$VR_B_RT_DC_0_FICLIC,
    allResults$VR_B_RT_DC_400_FCLC,
    allResults$VR_B_RT_DC_400_FICLC,
    allResults$VR_B_RT_DC_400_FCLIC,
    allResults$VR_B_RT_DC_400_FICLIC,
    allResults$VR_B_RT_DC_800_FCLC,
    allResults$VR_B_RT_DC_800_FICLC,
    allResults$VR_B_RT_DC_800_FCLIC,
    allResults$VR_B_RT_DC_800_FICLIC,
    "ANT-VR B",
    "(RT)"
  )

  printAlertingByConflict_ANOVA(
    allResults$Id,
    allResults$VR_B_ACC_NC_FCLC,
    allResults$VR_B_ACC_NC_FICLC,
    allResults$VR_B_ACC_NC_FCLIC,
    allResults$VR_B_ACC_NC_FICLIC,
    allResults$VR_B_ACC_DC_0_FCLC,
    allResults$VR_B_ACC_DC_0_FICLC,
    allResults$VR_B_ACC_DC_0_FCLIC,
    allResults$VR_B_ACC_DC_0_FICLIC,
    allResults$VR_B_ACC_DC_400_FCLC,
    allResults$VR_B_ACC_DC_400_FICLC,
    allResults$VR_B_ACC_DC_400_FCLIC,
    allResults$VR_B_ACC_DC_400_FICLIC,
    allResults$VR_B_ACC_DC_800_FCLC,
    allResults$VR_B_ACC_DC_800_FICLC,
    allResults$VR_B_ACC_DC_800_FCLIC,
    allResults$VR_B_ACC_DC_800_FICLIC,
    "ANT-VR B",
    "(ACC)"
  )

  writeLines(
    "----------------------------------------------------------------------------"
  )

  sink()
}

printOrientingByConflict_ANOVA <- function(id,
                                           dc_0_FCLC,
                                           dc_0_FICLC,
                                           dc_0_FCLIC,
                                           dc_0_FICLIC,
                                           dc_400_FCLC,
                                           dc_400_FICLC,
                                           dc_400_FCLIC,
                                           dc_400_FICLIC,
                                           dc_800_FCLC,
                                           dc_800_FICLC,
                                           dc_800_FCLIC,
                                           dc_800_FICLIC,
                                           vc_0_FCLC,
                                           vc_0_FICLC,
                                           vc_0_FCLIC,
                                           vc_0_FICLIC,
                                           vc_400_FCLC,
                                           vc_400_FICLC,
                                           vc_400_FCLIC,
                                           vc_400_FICLIC,
                                           vc_800_FCLC,
                                           vc_800_FICLC,
                                           vc_800_FCLIC,
                                           vc_800_FICLIC,
                                           experimentName,
                                           valueColumnName) {
  if (!require(tidyverse)) {
    install.packages("tidyverse")
  }
  if (!require(rstatix)) {
    install.packages("rstatix")
  }
  library(tidyverse)
  library(rstatix)

  resultSet <- data.frame(
    Id = integer(0),
    CueCondition = character(0),
    CueToTarget = character(0),
    FlankerCongruency = character(0),
    LocationCongruency = character(0),
    ValueCol = numeric(0)
  )

  for (row in 1:length(id)) {
    resultSet <- (
      resultSet %>% add_row(
        Id = id[row],
        CueCondition = "double",
        CueToTarget = "0",
        FlankerCongruency = "congruent",
        LocationCongruency = "congruent",
        ValueCol = dc_0_FCLC[row]
      )
      %>% add_row(
          Id = id[row],
          CueCondition = "double",
          CueToTarget = "0",
          FlankerCongruency = "incongruent",
          LocationCongruency = "congruent",
          ValueCol = dc_0_FICLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "double",
          CueToTarget = "0",
          FlankerCongruency = "congruent",
          LocationCongruency = "incongruent",
          ValueCol = dc_0_FCLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "double",
          CueToTarget = "0",
          FlankerCongruency = "incongruent",
          LocationCongruency = "incongruent",
          ValueCol = dc_0_FICLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "double",
          CueToTarget = "400",
          FlankerCongruency = "congruent",
          LocationCongruency = "congruent",
          ValueCol = dc_400_FCLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "double",
          CueToTarget = "400",
          FlankerCongruency = "incongruent",
          LocationCongruency = "congruent",
          ValueCol = dc_400_FICLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "double",
          CueToTarget = "400",
          FlankerCongruency = "congruent",
          LocationCongruency = "incongruent",
          ValueCol = dc_400_FCLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "double",
          CueToTarget = "400",
          FlankerCongruency = "incongruent",
          LocationCongruency = "incongruent",
          ValueCol = dc_400_FICLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "double",
          CueToTarget = "800",
          FlankerCongruency = "congruent",
          LocationCongruency = "congruent",
          ValueCol = dc_800_FCLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "double",
          CueToTarget = "800",
          FlankerCongruency = "incongruent",
          LocationCongruency = "congruent",
          ValueCol = dc_800_FICLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "double",
          CueToTarget = "800",
          FlankerCongruency = "congruent",
          LocationCongruency = "incongruent",
          ValueCol = dc_800_FCLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "double",
          CueToTarget = "800",
          FlankerCongruency = "incongruent",
          LocationCongruency = "incongruent",
          ValueCol = dc_800_FICLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "valid",
          CueToTarget = "0",
          FlankerCongruency = "congruent",
          LocationCongruency = "congruent",
          ValueCol = vc_0_FCLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "valid",
          CueToTarget = "0",
          FlankerCongruency = "incongruent",
          LocationCongruency = "congruent",
          ValueCol = vc_0_FICLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "valid",
          CueToTarget = "0",
          FlankerCongruency = "congruent",
          LocationCongruency = "incongruent",
          ValueCol = vc_0_FCLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "valid",
          CueToTarget = "0",
          FlankerCongruency = "incongruent",
          LocationCongruency = "incongruent",
          ValueCol = vc_0_FICLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "valid",
          CueToTarget = "400",
          FlankerCongruency = "congruent",
          LocationCongruency = "congruent",
          ValueCol = vc_400_FCLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "valid",
          CueToTarget = "400",
          FlankerCongruency = "incongruent",
          LocationCongruency = "congruent",
          ValueCol = vc_400_FICLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "valid",
          CueToTarget = "400",
          FlankerCongruency = "congruent",
          LocationCongruency = "incongruent",
          ValueCol = vc_400_FCLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "valid",
          CueToTarget = "400",
          FlankerCongruency = "incongruent",
          LocationCongruency = "incongruent",
          ValueCol = vc_400_FICLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "valid",
          CueToTarget = "800",
          FlankerCongruency = "congruent",
          LocationCongruency = "congruent",
          ValueCol = vc_800_FCLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "valid",
          CueToTarget = "800",
          FlankerCongruency = "incongruent",
          LocationCongruency = "congruent",
          ValueCol = vc_800_FICLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "valid",
          CueToTarget = "800",
          FlankerCongruency = "congruent",
          LocationCongruency = "incongruent",
          ValueCol = vc_800_FCLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "valid",
          CueToTarget = "800",
          FlankerCongruency = "incongruent",
          LocationCongruency = "incongruent",
          ValueCol = vc_800_FICLIC[row]
        )
    )
  }

  writeLines("")
  writeLines(paste(experimentName, valueColumnName, sep = " "))
  obc_anova <- anova_test(
    data = resultSet,
    dv = ValueCol,
    wid = Id,
    within = c(
      CueCondition,
      CueToTarget,
      FlankerCongruency,
      LocationCongruency
    ),
    effect.size = "pes"
  )
  print(obc_anova)
  printANOVAResultAsFormulas(obc_anova)

  validCue <- getMeanForANOVA(subset(resultSet, CueCondition == "valid")$ValueCol, 2)
  doubleCue <- getMeanForANOVA(subset(resultSet, CueCondition == "double")$ValueCol, 2)
  ct0 <- getMeanForANOVA(subset(resultSet, CueToTarget == "0")$ValueCol, 2)
  ct400 <- getMeanForANOVA(subset(resultSet, CueToTarget == "400")$ValueCol, 2)
  ct800 <- getMeanForANOVA(subset(resultSet, CueToTarget == "800")$ValueCol, 2)
  fc <- getMeanForANOVA(
    subset(resultSet, FlankerCongruency == "congruent")$ValueCol, 2
  )
  fic <- getMeanForANOVA(
    subset(resultSet, FlankerCongruency == "incongruent")$ValueCol, 2
  )
  lc <- getMeanForANOVA(
    subset(resultSet, LocationCongruency == "congruent")$ValueCol, 2
  )
  lic <- getMeanForANOVA(
    subset(resultSet, LocationCongruency == "incongruent")$ValueCol, 2
  )

  validCue_ct0 <- getMeanForANOVA(
    subset(resultSet, CueCondition == "valid" &
      CueToTarget == "0")$ValueCol, 2
  )
  validCue_ct400 <- getMeanForANOVA(
    subset(resultSet, CueCondition == "valid" &
      CueToTarget == "400")$ValueCol, 2
  )
  validCue_ct800 <- getMeanForANOVA(
    subset(resultSet, CueCondition == "valid" &
      CueToTarget == "800")$ValueCol, 2
  )
  doubleCue_ct0 <- getMeanForANOVA(
    subset(resultSet, CueCondition == "double" &
      CueToTarget == "0")$ValueCol, 2
  )
  doubleCue_ct400 <- getMeanForANOVA(
    subset(resultSet, CueCondition == "double" &
      CueToTarget == "400")$ValueCol, 2
  )
  doubleCue_ct800 <- getMeanForANOVA(
    subset(resultSet, CueCondition == "double" &
      CueToTarget == "800")$ValueCol, 2
  )

  validCue_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )

  validCue_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )

  ct0_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "0" & FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  ct400_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "400" &
        FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  ct800_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "800" &
        FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  ct0_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "0" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )
  ct400_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "400" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )
  ct800_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "800" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )

  ct0_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "0" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  ct400_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "400" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  ct800_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "800" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  ct0_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "0" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  ct400_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "400" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  ct800_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "800" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )

  fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )

  validCue_ct0_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "0" & FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_ct400_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "400" &
        FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_ct800_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "800" &
        FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue_ct0_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        CueToTarget == "0" & FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue_ct400_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        CueToTarget == "400" &
        FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue_ct800_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        CueToTarget == "800" &
        FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_ct0_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "0" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )
  validCue_ct400_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "400" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )
  validCue_ct800_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "800" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue_ct0_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        CueToTarget == "0" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue_ct400_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        CueToTarget == "400" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue_ct800_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        CueToTarget == "800" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )

  validCue_ct0_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "0" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_ct400_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "400" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_ct800_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "800" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue_ct0_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        CueToTarget == "0" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue_ct400_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        CueToTarget == "400" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue_ct800_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        CueToTarget == "800" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_ct0_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "0" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  validCue_ct400_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "400" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  validCue_ct800_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "800" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue_ct0_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        CueToTarget == "0" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue_ct400_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        CueToTarget == "400" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue_ct800_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        CueToTarget == "800" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )

  ct0_fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "0" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  ct400_fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "400" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  ct800_fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "800" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  ct0_fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "0" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  ct400_fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "400" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  ct800_fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "800" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  ct0_fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "0" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  ct400_fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "400" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  ct800_fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "800" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  ct0_fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "0" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  ct400_fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "400" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  ct800_fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "800" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )

  validCue_ct0_fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "0" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_ct400_fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "400" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_ct800_fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "800" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue_ct0_fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        CueToTarget == "0" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue_ct400_fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        CueToTarget == "400" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue_ct800_fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        CueToTarget == "800" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_ct0_fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "0" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_ct400_fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "400" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_ct800_fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "800" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue_ct0_fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        CueToTarget == "0" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue_ct400_fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        CueToTarget == "400" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  doubleCue_ct800_fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        CueToTarget == "800" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_ct0_fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "0" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  validCue_ct400_fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "400" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  validCue_ct800_fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "800" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue_ct0_fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        CueToTarget == "0" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue_ct400_fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        CueToTarget == "400" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue_ct800_fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        CueToTarget == "800" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  validCue_ct0_fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "0" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  validCue_ct400_fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "400" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  validCue_ct800_fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "800" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue_ct0_fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        CueToTarget == "0" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue_ct400_fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        CueToTarget == "400" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  doubleCue_ct800_fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "double" &
        CueToTarget == "800" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )

  writeLines(sprintf(""))
  writeLines("Main Effects")
  writeLines("     CueCondition")
  writeLines(paste("     valid = ", validCue, sep = ""))
  writeLines(paste("     double = ", doubleCue, sep = ""))
  writeLines(sprintf(""))

  writeLines("     CueToTarget")
  writeLines(paste("     0 = ", ct0, sep = ""))
  writeLines(paste("     400 = ", ct400, sep = ""))
  writeLines(paste("     800 = ", ct800, sep = ""))
  writeLines(sprintf(""))

  writeLines("     FlankerCongruency")
  writeLines(paste("     congruent = ", fc, sep = ""))
  writeLines(paste("     incongruent = ", fic, sep = ""))
  writeLines(sprintf(""))

  writeLines("     LocationCongruency")
  writeLines(paste("     congruent = ", lc, sep = ""))
  writeLines(paste("     incongruent = ", lic, sep = ""))
  writeLines(sprintf(""))

  writeLines("     CueCondition : CueToTarget")
  writeLines(paste("     valid : 0 = ", validCue_ct0, sep = ""))
  writeLines(paste("     valid : 400 = ", validCue_ct400, sep = ""))
  writeLines(paste("     valid : 800 = ", validCue_ct800, sep = ""))
  writeLines(paste("     double : 0 = ", doubleCue_ct0, sep = ""))
  writeLines(paste("     double : 400 = ", doubleCue_ct400, sep = ""))
  writeLines(paste("     double : 800 = ", doubleCue_ct800, sep = ""))
  writeLines(sprintf(""))

  writeLines("     CueCondition : FlankerCongruency")
  writeLines(paste("     valid : congruent = ", validCue_fc, sep = ""))
  writeLines(paste("     valid : incongruent = ", validCue_fic, sep = ""))
  writeLines(paste("     double : congruent = ", doubleCue_fc, sep = ""))
  writeLines(paste("     double : incongruent = ", doubleCue_fic, sep = ""))
  writeLines(sprintf(""))

  writeLines("     CueCondition : LocationCongruency")
  writeLines(paste("     valid : congruent = ", validCue_lc, sep = ""))
  writeLines(paste("     valid : incongruent = ", validCue_lic, sep = ""))
  writeLines(paste("     double : congruent = ", doubleCue_lc, sep = ""))
  writeLines(paste("     double : incongruent = ", doubleCue_lic, sep = ""))
  writeLines(sprintf(""))

  writeLines("     CueToTarget : FlankerCongruency")
  writeLines(paste("     0 : congruent = ", ct0_fc, sep = ""))
  writeLines(paste("     400 : congruent = ", ct400_fc, sep = ""))
  writeLines(paste("     800 : congruent = ", ct800_fc, sep = ""))
  writeLines(paste("     0 : incongruent = ", ct0_fic, sep = ""))
  writeLines(paste("     400 : incongruent = ", ct400_fic, sep = ""))
  writeLines(paste("     800 : incongruent = ", ct800_fic, sep = ""))
  writeLines(sprintf(""))

  writeLines("     CueToTarget : LocationCongruency")
  writeLines(paste("     0 : congruent = ", ct0_lc, sep = ""))
  writeLines(paste("     400 : congruent = ", ct400_lc, sep = ""))
  writeLines(paste("     800 : congruent = ", ct800_lc, sep = ""))
  writeLines(paste("     0 : incongruent = ", ct0_lic, sep = ""))
  writeLines(paste("     400 : incongruent = ", ct400_lic, sep = ""))
  writeLines(paste("     800 : incongruent = ", ct800_lic, sep = ""))
  writeLines(sprintf(""))

  writeLines("     FlankerCongruency : LocationCongruency")
  writeLines(paste("     congruent : congruent = ", fc_lc, sep = ""))
  writeLines(paste("     congruent : incongruent = ", fc_lic, sep = ""))
  writeLines(paste("     incongruent : congruent = ", fic_lc, sep = ""))
  writeLines(paste("     incongruent : incongruent = ", fic_lic, sep = ""))
  writeLines(sprintf(""))

  writeLines("     CueCondition : CueToTarget : FlankerCongruency")
  writeLines(paste("     valid : 0 : congruent = ", validCue_ct0_fc, sep = ""))
  writeLines(paste("     valid : 400 : congruent = ", validCue_ct400_fc, sep = ""))
  writeLines(paste("     valid : 800 : congruent = ", validCue_ct800_fc, sep = ""))
  writeLines(paste("     double : 0 : congruent = ", doubleCue_ct0_fc, sep = ""))
  writeLines(paste("     double : 400 : congruent = ", doubleCue_ct400_fc, sep = ""))
  writeLines(paste("     double : 800 : congruent = ", doubleCue_ct800_fc, sep = ""))
  writeLines(paste("     valid : 0 : incongruent = ", validCue_ct0_fic, sep = ""))
  writeLines(paste("     valid : 400 : incongruent = ", validCue_ct400_fic, sep = ""))
  writeLines(paste("     valid : 800 : incongruent = ", validCue_ct800_fic, sep = ""))
  writeLines(paste("     double : 0 : incongruent = ", doubleCue_ct0_fic, sep = ""))
  writeLines(paste("     double : 400 : incongruent = ", doubleCue_ct400_fic, sep = ""))
  writeLines(paste("     double : 800 : incongruent = ", doubleCue_ct800_fic, sep = ""))
  writeLines(sprintf(""))

  writeLines("     CueCondition : CueToTarget : LocationCongruency")
  writeLines(paste("     valid : 0 : congruent = ", validCue_ct0_lc, sep = ""))
  writeLines(paste("     valid : 400 : congruent = ", validCue_ct400_lc, sep = ""))
  writeLines(paste("     valid : 800 : congruent = ", validCue_ct800_lc, sep = ""))
  writeLines(paste("     double : 0 : congruent = ", doubleCue_ct0_lc, sep = ""))
  writeLines(paste("     double : 400 : congruent = ", doubleCue_ct400_lc, sep = ""))
  writeLines(paste("     double : 800 : congruent = ", doubleCue_ct800_lc, sep = ""))
  writeLines(paste("     valid : 0 : incongruent = ", validCue_ct0_lic, sep = ""))
  writeLines(paste("     valid : 400 : incongruent = ", validCue_ct400_lic, sep = ""))
  writeLines(paste("     valid : 800 : incongruent = ", validCue_ct800_lic, sep = ""))
  writeLines(paste("     double : 0 : incongruent = ", doubleCue_ct0_lic, sep = ""))
  writeLines(paste("     double : 400 : incongruent = ", doubleCue_ct400_lic, sep = ""))
  writeLines(paste("     double : 800 : incongruent = ", doubleCue_ct800_lic, sep = ""))
  writeLines(sprintf(""))

  writeLines("     CueToTarget : FlankerCongruency : LocationCongruency")
  writeLines(paste("     0 : congruent : congruent = ", ct0_fc_lc, sep = ""))
  writeLines(paste("     400 : congruent : congruent = ", ct400_fc_lc, sep = ""))
  writeLines(paste("     800 : congruent : congruent = ", ct800_fc_lc, sep = ""))
  writeLines(paste("     0 : incongruent : congruent = ", ct0_fic_lc, sep = ""))
  writeLines(paste("     400 : incongruent : congruent = ", ct400_fic_lc, sep = ""))
  writeLines(paste("     800 : incongruent : congruent = ", ct800_fic_lc, sep = ""))
  writeLines(paste("     0 : congruent : incongruent = ", ct0_fc_lic, sep = ""))
  writeLines(paste("     400 : congruent : incongruent = ", ct400_fc_lic, sep = ""))
  writeLines(paste("     800 : congruent : incongruent = ", ct800_fc_lic, sep = ""))
  writeLines(paste("     0 : incongruent : incongruent = ", ct0_fic_lic, sep = ""))
  writeLines(paste("     400 : incongruent : incongruent = ", ct400_fic_lic, sep = ""))
  writeLines(paste("     800 : incongruent : incongruent = ", ct800_fic_lic, sep = ""))
  writeLines(sprintf(""))

  writeLines("     CueCondition : CueToTarget : FlankerCongruency : LocationCongruency")
  writeLines(paste("     valid : 0 : congruent : congruent = ", validCue_ct0_fc_lc, sep = ""))
  writeLines(paste(
    "     valid : 400 : congruent : congruent = ",
    validCue_ct400_fc_lc,
    sep = ""
  ))
  writeLines(paste(
    "     valid : 800 : congruent : congruent = ",
    validCue_ct800_fc_lc,
    sep = ""
  ))
  writeLines(paste(
    "     valid : 0 : incongruent : congruent = ",
    validCue_ct0_fic_lc,
    sep = ""
  ))
  writeLines(paste(
    "     valid : 400 : incongruent : congruent = ",
    validCue_ct400_fic_lc,
    sep = ""
  ))
  writeLines(paste(
    "     valid : 800 : incongruent : congruent = ",
    validCue_ct800_fic_lc,
    sep = ""
  ))
  writeLines(paste(
    "     valid : 0 : congruent : incongruent = ",
    validCue_ct0_fc_lic,
    sep = ""
  ))
  writeLines(paste(
    "     valid : 400 : congruent : incongruent = ",
    validCue_ct400_fc_lic,
    sep = ""
  ))
  writeLines(paste(
    "     valid : 800 : congruent : incongruent = ",
    validCue_ct800_fc_lic,
    sep = ""
  ))
  writeLines(paste(
    "     valid : 0 : incongruent : incongruent = ",
    validCue_ct0_fic_lic,
    sep = ""
  ))
  writeLines(paste(
    "     valid : 400 : incongruent : incongruent = ",
    validCue_ct400_fic_lic,
    sep = ""
  ))
  writeLines(paste(
    "     valid : 800 : incongruent : incongruent = ",
    validCue_ct800_fic_lic,
    sep = ""
  ))
  writeLines(paste("     double : 0 : congruent : congruent = ", doubleCue_ct0_fc_lc, sep = ""))
  writeLines(paste(
    "     double : 400 : congruent : congruent = ",
    doubleCue_ct400_fc_lc,
    sep = ""
  ))
  writeLines(paste(
    "     double : 800 : congruent : congruent = ",
    doubleCue_ct800_fc_lc,
    sep = ""
  ))
  writeLines(paste(
    "     double : 0 : incongruent : congruent = ",
    doubleCue_ct0_fic_lc,
    sep = ""
  ))
  writeLines(paste(
    "     double : 400 : incongruent : congruent = ",
    doubleCue_ct400_fic_lc,
    sep = ""
  ))
  writeLines(paste(
    "     double : 800 : incongruent : congruent = ",
    doubleCue_ct800_fic_lc,
    sep = ""
  ))
  writeLines(paste(
    "     double : 0 : congruent : incongruent = ",
    doubleCue_ct0_fc_lic,
    sep = ""
  ))
  writeLines(paste(
    "     double : 400 : congruent : incongruent = ",
    doubleCue_ct400_fc_lic,
    sep = ""
  ))
  writeLines(paste(
    "     double : 800 : congruent : incongruent = ",
    doubleCue_ct800_fc_lic,
    sep = ""
  ))
  writeLines(paste(
    "     double : 0 : incongruent : incongruent = ",
    doubleCue_ct0_fic_lic,
    sep = ""
  ))
  writeLines(paste(
    "     double : 400 : incongruent : incongruent = ",
    doubleCue_ct400_fic_lic,
    sep = ""
  ))
  writeLines(paste(
    "     double : 800 : incongruent : incongruent = ",
    doubleCue_ct800_fic_lic,
    sep = ""
  ))

  writeLines(sprintf(""))
  writeLines(sprintf(""))
}

printOrientingByConflict_ANOVAs <- function(allResults, participantsFolder) {
  pathToOutputFile <- getPath("../../../Results/OrientingByConflict_ANOVAs.txt")

  sink(
    file = pathToOutputFile,
    append = FALSE,
    type = "output",
    split = FALSE
  )

  writeLines(
    "----------------------------------------------------------------------------"
  )
  writeLines("Within-subject ANOVAs: Orienting by Conflict")

  printOrientingByConflict_ANOVA(
    allResults$Id,
    allResults$R_RT_DC_0_FCLC,
    allResults$R_RT_DC_0_FICLC,
    allResults$R_RT_DC_0_FCLIC,
    allResults$R_RT_DC_0_FICLIC,
    allResults$R_RT_DC_400_FCLC,
    allResults$R_RT_DC_400_FICLC,
    allResults$R_RT_DC_400_FCLIC,
    allResults$R_RT_DC_400_FICLIC,
    allResults$R_RT_DC_800_FCLC,
    allResults$R_RT_DC_800_FICLC,
    allResults$R_RT_DC_800_FCLIC,
    allResults$R_RT_DC_800_FICLIC,
    allResults$R_RT_VC_0_FCLC,
    allResults$R_RT_VC_0_FICLC,
    allResults$R_RT_VC_0_FCLIC,
    allResults$R_RT_VC_0_FICLIC,
    allResults$R_RT_VC_400_FCLC,
    allResults$R_RT_VC_400_FICLC,
    allResults$R_RT_VC_400_FCLIC,
    allResults$R_RT_VC_400_FICLIC,
    allResults$R_RT_VC_800_FCLC,
    allResults$R_RT_VC_800_FICLC,
    allResults$R_RT_VC_800_FCLIC,
    allResults$R_RT_VC_800_FICLIC,
    "ANT-R",
    "(RT)"
  )

  printOrientingByConflict_ANOVA(
    allResults$Id,
    allResults$R_ACC_DC_0_FCLC,
    allResults$R_ACC_DC_0_FICLC,
    allResults$R_ACC_DC_0_FCLIC,
    allResults$R_ACC_DC_0_FICLIC,
    allResults$R_ACC_DC_400_FCLC,
    allResults$R_ACC_DC_400_FICLC,
    allResults$R_ACC_DC_400_FCLIC,
    allResults$R_ACC_DC_400_FICLIC,
    allResults$R_ACC_DC_800_FCLC,
    allResults$R_ACC_DC_800_FICLC,
    allResults$R_ACC_DC_800_FCLIC,
    allResults$R_ACC_DC_800_FICLIC,
    allResults$R_ACC_VC_0_FCLC,
    allResults$R_ACC_VC_0_FICLC,
    allResults$R_ACC_VC_0_FCLIC,
    allResults$R_ACC_VC_0_FICLIC,
    allResults$R_ACC_VC_400_FCLC,
    allResults$R_ACC_VC_400_FICLC,
    allResults$R_ACC_VC_400_FCLIC,
    allResults$R_ACC_VC_400_FICLIC,
    allResults$R_ACC_VC_800_FCLC,
    allResults$R_ACC_VC_800_FICLC,
    allResults$R_ACC_VC_800_FCLIC,
    allResults$R_ACC_VC_800_FICLIC,
    "ANT-R",
    "(ACC)"
  )

  printOrientingByConflict_ANOVA(
    allResults$Id,
    allResults$VR_RT_DC_0_FCLC,
    allResults$VR_RT_DC_0_FICLC,
    allResults$VR_RT_DC_0_FCLIC,
    allResults$VR_RT_DC_0_FICLIC,
    allResults$VR_RT_DC_400_FCLC,
    allResults$VR_RT_DC_400_FICLC,
    allResults$VR_RT_DC_400_FCLIC,
    allResults$VR_RT_DC_400_FICLIC,
    allResults$VR_RT_DC_800_FCLC,
    allResults$VR_RT_DC_800_FICLC,
    allResults$VR_RT_DC_800_FCLIC,
    allResults$VR_RT_DC_800_FICLIC,
    allResults$VR_RT_VC_0_FCLC,
    allResults$VR_RT_VC_0_FICLC,
    allResults$VR_RT_VC_0_FCLIC,
    allResults$VR_RT_VC_0_FICLIC,
    allResults$VR_RT_VC_400_FCLC,
    allResults$VR_RT_VC_400_FICLC,
    allResults$VR_RT_VC_400_FCLIC,
    allResults$VR_RT_VC_400_FICLIC,
    allResults$VR_RT_VC_800_FCLC,
    allResults$VR_RT_VC_800_FICLC,
    allResults$VR_RT_VC_800_FCLIC,
    allResults$VR_RT_VC_800_FICLIC,
    "ANT-VR",
    "(RT)"
  )

  printOrientingByConflict_ANOVA(
    allResults$Id,
    allResults$VR_ACC_DC_0_FCLC,
    allResults$VR_ACC_DC_0_FICLC,
    allResults$VR_ACC_DC_0_FCLIC,
    allResults$VR_ACC_DC_0_FICLIC,
    allResults$VR_ACC_DC_400_FCLC,
    allResults$VR_ACC_DC_400_FICLC,
    allResults$VR_ACC_DC_400_FCLIC,
    allResults$VR_ACC_DC_400_FICLIC,
    allResults$VR_ACC_DC_800_FCLC,
    allResults$VR_ACC_DC_800_FICLC,
    allResults$VR_ACC_DC_800_FCLIC,
    allResults$VR_ACC_DC_800_FICLIC,
    allResults$VR_ACC_VC_0_FCLC,
    allResults$VR_ACC_VC_0_FICLC,
    allResults$VR_ACC_VC_0_FCLIC,
    allResults$VR_ACC_VC_0_FICLIC,
    allResults$VR_ACC_VC_400_FCLC,
    allResults$VR_ACC_VC_400_FICLC,
    allResults$VR_ACC_VC_400_FCLIC,
    allResults$VR_ACC_VC_400_FICLIC,
    allResults$VR_ACC_VC_800_FCLC,
    allResults$VR_ACC_VC_800_FICLC,
    allResults$VR_ACC_VC_800_FCLIC,
    allResults$VR_ACC_VC_800_FICLIC,
    "ANT-VR",
    "(ACC)"
  )

  printOrientingByConflict_ANOVA(
    allResults$Id,
    allResults$VR_B_RT_DC_0_FCLC,
    allResults$VR_B_RT_DC_0_FICLC,
    allResults$VR_B_RT_DC_0_FCLIC,
    allResults$VR_B_RT_DC_0_FICLIC,
    allResults$VR_B_RT_DC_400_FCLC,
    allResults$VR_B_RT_DC_400_FICLC,
    allResults$VR_B_RT_DC_400_FCLIC,
    allResults$VR_B_RT_DC_400_FICLIC,
    allResults$VR_B_RT_DC_800_FCLC,
    allResults$VR_B_RT_DC_800_FICLC,
    allResults$VR_B_RT_DC_800_FCLIC,
    allResults$VR_B_RT_DC_800_FICLIC,
    allResults$VR_B_RT_VC_0_FCLC,
    allResults$VR_B_RT_VC_0_FICLC,
    allResults$VR_B_RT_VC_0_FCLIC,
    allResults$VR_B_RT_VC_0_FICLIC,
    allResults$VR_B_RT_VC_400_FCLC,
    allResults$VR_B_RT_VC_400_FICLC,
    allResults$VR_B_RT_VC_400_FCLIC,
    allResults$VR_B_RT_VC_400_FICLIC,
    allResults$VR_B_RT_VC_800_FCLC,
    allResults$VR_B_RT_VC_800_FICLC,
    allResults$VR_B_RT_VC_800_FCLIC,
    allResults$VR_B_RT_VC_800_FICLIC,
    "ANT-VR B",
    "(RT)"
  )

  printOrientingByConflict_ANOVA(
    allResults$Id,
    allResults$VR_B_ACC_DC_0_FCLC,
    allResults$VR_B_ACC_DC_0_FICLC,
    allResults$VR_B_ACC_DC_0_FCLIC,
    allResults$VR_B_ACC_DC_0_FICLIC,
    allResults$VR_B_ACC_DC_400_FCLC,
    allResults$VR_B_ACC_DC_400_FICLC,
    allResults$VR_B_ACC_DC_400_FCLIC,
    allResults$VR_B_ACC_DC_400_FICLIC,
    allResults$VR_B_ACC_DC_800_FCLC,
    allResults$VR_B_ACC_DC_800_FICLC,
    allResults$VR_B_ACC_DC_800_FCLIC,
    allResults$VR_B_ACC_DC_800_FICLIC,
    allResults$VR_B_ACC_VC_0_FCLC,
    allResults$VR_B_ACC_VC_0_FICLC,
    allResults$VR_B_ACC_VC_0_FCLIC,
    allResults$VR_B_ACC_VC_0_FICLIC,
    allResults$VR_B_ACC_VC_400_FCLC,
    allResults$VR_B_ACC_VC_400_FICLC,
    allResults$VR_B_ACC_VC_400_FCLIC,
    allResults$VR_B_ACC_VC_400_FICLIC,
    allResults$VR_B_ACC_VC_800_FCLC,
    allResults$VR_B_ACC_VC_800_FICLC,
    allResults$VR_B_ACC_VC_800_FCLIC,
    allResults$VR_B_ACC_VC_800_FICLIC,
    "ANT-VR B",
    "(ACC)"
  )

  writeLines(
    "----------------------------------------------------------------------------"
  )

  sink()
}

printValidityByConflict_ANOVA <- function(id,
                                          ivc_0_FCLC,
                                          ivc_0_FICLC,
                                          ivc_0_FCLIC,
                                          ivc_0_FICLIC,
                                          ivc_400_FCLC,
                                          ivc_400_FICLC,
                                          ivc_400_FCLIC,
                                          ivc_400_FICLIC,
                                          ivc_800_FCLC,
                                          ivc_800_FICLC,
                                          ivc_800_FCLIC,
                                          ivc_800_FICLIC,
                                          vc_0_FCLC,
                                          vc_0_FICLC,
                                          vc_0_FCLIC,
                                          vc_0_FICLIC,
                                          vc_400_FCLC,
                                          vc_400_FICLC,
                                          vc_400_FCLIC,
                                          vc_400_FICLIC,
                                          vc_800_FCLC,
                                          vc_800_FICLC,
                                          vc_800_FCLIC,
                                          vc_800_FICLIC,
                                          experimentName,
                                          valueColumnName) {
  if (!require(tidyverse)) {
    install.packages("tidyverse")
  }
  if (!require(rstatix)) {
    install.packages("rstatix")
  }
  library(tidyverse)
  library(rstatix)

  resultSet <- data.frame(
    Id = integer(0),
    CueCondition = character(0),
    CueToTarget = character(0),
    FlankerCongruency = character(0),
    LocationCongruency = character(0),
    ValueCol = numeric(0)
  )

  for (row in 1:length(id)) {
    resultSet <- (
      resultSet %>% add_row(
        Id = id[row],
        CueCondition = "invalid",
        CueToTarget = "0",
        FlankerCongruency = "congruent",
        LocationCongruency = "congruent",
        ValueCol = ivc_0_FCLC[row]
      )
      %>% add_row(
          Id = id[row],
          CueCondition = "invalid",
          CueToTarget = "0",
          FlankerCongruency = "incongruent",
          LocationCongruency = "congruent",
          ValueCol = ivc_0_FICLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "invalid",
          CueToTarget = "0",
          FlankerCongruency = "congruent",
          LocationCongruency = "incongruent",
          ValueCol = ivc_0_FCLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "invalid",
          CueToTarget = "0",
          FlankerCongruency = "incongruent",
          LocationCongruency = "incongruent",
          ValueCol = ivc_0_FICLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "invalid",
          CueToTarget = "400",
          FlankerCongruency = "congruent",
          LocationCongruency = "congruent",
          ValueCol = ivc_400_FCLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "invalid",
          CueToTarget = "400",
          FlankerCongruency = "incongruent",
          LocationCongruency = "congruent",
          ValueCol = ivc_400_FICLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "invalid",
          CueToTarget = "400",
          FlankerCongruency = "congruent",
          LocationCongruency = "incongruent",
          ValueCol = ivc_400_FCLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "invalid",
          CueToTarget = "400",
          FlankerCongruency = "incongruent",
          LocationCongruency = "incongruent",
          ValueCol = ivc_400_FICLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "invalid",
          CueToTarget = "800",
          FlankerCongruency = "congruent",
          LocationCongruency = "congruent",
          ValueCol = ivc_800_FCLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "invalid",
          CueToTarget = "800",
          FlankerCongruency = "incongruent",
          LocationCongruency = "congruent",
          ValueCol = ivc_800_FICLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "invalid",
          CueToTarget = "800",
          FlankerCongruency = "congruent",
          LocationCongruency = "incongruent",
          ValueCol = ivc_800_FCLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "invalid",
          CueToTarget = "800",
          FlankerCongruency = "incongruent",
          LocationCongruency = "incongruent",
          ValueCol = ivc_800_FICLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "valid",
          CueToTarget = "0",
          FlankerCongruency = "congruent",
          LocationCongruency = "congruent",
          ValueCol = vc_0_FCLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "valid",
          CueToTarget = "0",
          FlankerCongruency = "incongruent",
          LocationCongruency = "congruent",
          ValueCol = vc_0_FICLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "valid",
          CueToTarget = "0",
          FlankerCongruency = "congruent",
          LocationCongruency = "incongruent",
          ValueCol = vc_0_FCLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "valid",
          CueToTarget = "0",
          FlankerCongruency = "incongruent",
          LocationCongruency = "incongruent",
          ValueCol = vc_0_FICLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "valid",
          CueToTarget = "400",
          FlankerCongruency = "congruent",
          LocationCongruency = "congruent",
          ValueCol = vc_400_FCLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "valid",
          CueToTarget = "400",
          FlankerCongruency = "incongruent",
          LocationCongruency = "congruent",
          ValueCol = vc_400_FICLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "valid",
          CueToTarget = "400",
          FlankerCongruency = "congruent",
          LocationCongruency = "incongruent",
          ValueCol = vc_400_FCLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "valid",
          CueToTarget = "400",
          FlankerCongruency = "incongruent",
          LocationCongruency = "incongruent",
          ValueCol = vc_400_FICLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "valid",
          CueToTarget = "800",
          FlankerCongruency = "congruent",
          LocationCongruency = "congruent",
          ValueCol = vc_800_FCLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "valid",
          CueToTarget = "800",
          FlankerCongruency = "incongruent",
          LocationCongruency = "congruent",
          ValueCol = vc_800_FICLC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "valid",
          CueToTarget = "800",
          FlankerCongruency = "congruent",
          LocationCongruency = "incongruent",
          ValueCol = vc_800_FCLIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueCondition = "valid",
          CueToTarget = "800",
          FlankerCongruency = "incongruent",
          LocationCongruency = "incongruent",
          ValueCol = vc_800_FICLIC[row]
        )
    )
  }

  writeLines("")
  writeLines(paste(experimentName, valueColumnName, sep = " "))
  vbc_anova <- anova_test(
    data = resultSet,
    dv = ValueCol,
    wid = Id,
    within = c(
      CueCondition,
      CueToTarget,
      FlankerCongruency,
      LocationCongruency
    ),
    effect.size = "pes"
  )
  print(vbc_anova)
  printANOVAResultAsFormulas(vbc_anova)

  validCue <- getMeanForANOVA(subset(resultSet, CueCondition == "valid")$ValueCol, 2)
  invalidCue <- getMeanForANOVA(subset(resultSet, CueCondition == "invalid")$ValueCol, 2)
  ct0 <- getMeanForANOVA(subset(resultSet, CueToTarget == "0")$ValueCol, 2)
  ct400 <- getMeanForANOVA(subset(resultSet, CueToTarget == "400")$ValueCol, 2)
  ct800 <- getMeanForANOVA(subset(resultSet, CueToTarget == "800")$ValueCol, 2)
  fc <- getMeanForANOVA(
    subset(resultSet, FlankerCongruency == "congruent")$ValueCol, 2
  )
  fic <- getMeanForANOVA(
    subset(resultSet, FlankerCongruency == "incongruent")$ValueCol, 2
  )
  lc <- getMeanForANOVA(
    subset(resultSet, LocationCongruency == "congruent")$ValueCol, 2
  )
  lic <- getMeanForANOVA(
    subset(resultSet, LocationCongruency == "incongruent")$ValueCol, 2
  )

  validCue_ct0 <- getMeanForANOVA(
    subset(resultSet, CueCondition == "valid" &
      CueToTarget == "0")$ValueCol, 2
  )
  validCue_ct400 <- getMeanForANOVA(
    subset(resultSet, CueCondition == "valid" &
      CueToTarget == "400")$ValueCol, 2
  )
  validCue_ct800 <- getMeanForANOVA(
    subset(resultSet, CueCondition == "valid" &
      CueToTarget == "800")$ValueCol, 2
  )
  invalidCue_ct0 <- getMeanForANOVA(
    subset(resultSet, CueCondition == "invalid" &
      CueToTarget == "0")$ValueCol, 2
  )
  invalidCue_ct400 <- getMeanForANOVA(
    subset(resultSet, CueCondition == "invalid" &
      CueToTarget == "400")$ValueCol, 2
  )
  invalidCue_ct800 <- getMeanForANOVA(
    subset(resultSet, CueCondition == "invalid" &
      CueToTarget == "800")$ValueCol, 2
  )

  validCue_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )
  invalidCue_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  invalidCue_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )

  validCue_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  invalidCue_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  invalidCue_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )

  ct0_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "0" & FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  ct400_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "400" &
        FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  ct800_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "800" &
        FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  ct0_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "0" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )
  ct400_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "400" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )
  ct800_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "800" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )

  ct0_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "0" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  ct400_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "400" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  ct800_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "800" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  ct0_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "0" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  ct400_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "400" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  ct800_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "800" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )

  fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )

  validCue_ct0_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "0" & FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_ct400_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "400" &
        FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_ct800_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "800" &
        FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  invalidCue_ct0_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        CueToTarget == "0" & FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  invalidCue_ct400_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        CueToTarget == "400" &
        FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  invalidCue_ct800_fc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        CueToTarget == "800" &
        FlankerCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_ct0_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "0" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )
  validCue_ct400_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "400" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )
  validCue_ct800_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "800" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )
  invalidCue_ct0_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        CueToTarget == "0" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )
  invalidCue_ct400_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        CueToTarget == "400" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )
  invalidCue_ct800_fic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        CueToTarget == "800" &
        FlankerCongruency == "incongruent"
    )$ValueCol, 2
  )

  validCue_ct0_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "0" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_ct400_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "400" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_ct800_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "800" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  invalidCue_ct0_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        CueToTarget == "0" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  invalidCue_ct400_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        CueToTarget == "400" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  invalidCue_ct800_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        CueToTarget == "800" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_ct0_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "0" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  validCue_ct400_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "400" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  validCue_ct800_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "800" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  invalidCue_ct0_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        CueToTarget == "0" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  invalidCue_ct400_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        CueToTarget == "400" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  invalidCue_ct800_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        CueToTarget == "800" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )

  ct0_fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "0" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  ct400_fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "400" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  ct800_fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "800" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  ct0_fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "0" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  ct400_fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "400" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  ct800_fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "800" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  ct0_fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "0" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  ct400_fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "400" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  ct800_fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "800" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  ct0_fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "0" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  ct400_fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "400" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  ct800_fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueToTarget == "800" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )

  validCue_ct0_fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "0" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_ct400_fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "400" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_ct800_fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "800" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  invalidCue_ct0_fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        CueToTarget == "0" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  invalidCue_ct400_fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        CueToTarget == "400" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  invalidCue_ct800_fc_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        CueToTarget == "800" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_ct0_fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "0" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_ct400_fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "400" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_ct800_fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "800" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  invalidCue_ct0_fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        CueToTarget == "0" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  invalidCue_ct400_fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        CueToTarget == "400" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  invalidCue_ct800_fic_lc <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        CueToTarget == "800" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "congruent"
    )$ValueCol, 2
  )
  validCue_ct0_fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "0" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  validCue_ct400_fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "400" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  validCue_ct800_fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "800" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  invalidCue_ct0_fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        CueToTarget == "0" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  invalidCue_ct400_fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        CueToTarget == "400" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  invalidCue_ct800_fc_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        CueToTarget == "800" &
        FlankerCongruency == "congruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  validCue_ct0_fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "0" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  validCue_ct400_fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "400" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  validCue_ct800_fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "valid" &
        CueToTarget == "800" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  invalidCue_ct0_fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        CueToTarget == "0" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  invalidCue_ct400_fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        CueToTarget == "400" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )
  invalidCue_ct800_fic_lic <- getMeanForANOVA(
    subset(
      resultSet,
      CueCondition == "invalid" &
        CueToTarget == "800" &
        FlankerCongruency == "incongruent" &
        LocationCongruency == "incongruent"
    )$ValueCol, 2
  )

  writeLines(sprintf(""))
  writeLines("Main Effects")
  writeLines("     CueCondition")
  writeLines(paste("     valid = ", validCue, sep = ""))
  writeLines(paste("     invalid = ", invalidCue, sep = ""))
  writeLines(sprintf(""))

  writeLines("     CueToTarget")
  writeLines(paste("     0 = ", ct0, sep = ""))
  writeLines(paste("     400 = ", ct400, sep = ""))
  writeLines(paste("     800 = ", ct800, sep = ""))
  writeLines(sprintf(""))

  writeLines("     FlankerCongruency")
  writeLines(paste("     congruent = ", fc, sep = ""))
  writeLines(paste("     incongruent = ", fic, sep = ""))
  writeLines(sprintf(""))

  writeLines("     LocationCongruency")
  writeLines(paste("     congruent = ", lc, sep = ""))
  writeLines(paste("     incongruent = ", lic, sep = ""))
  writeLines(sprintf(""))

  writeLines("     CueCondition : CueToTarget")
  writeLines(paste("     valid : 0 = ", validCue_ct0, sep = ""))
  writeLines(paste("     valid : 400 = ", validCue_ct400, sep = ""))
  writeLines(paste("     valid : 800 = ", validCue_ct800, sep = ""))
  writeLines(paste("     invalid : 0 = ", invalidCue_ct0, sep = ""))
  writeLines(paste("     invalid : 400 = ", invalidCue_ct400, sep = ""))
  writeLines(paste("     invalid : 800 = ", invalidCue_ct800, sep = ""))
  writeLines(sprintf(""))

  writeLines("     CueCondition : FlankerCongruency")
  writeLines(paste("     valid : congruent = ", validCue_fc, sep = ""))
  writeLines(paste("     valid : incongruent = ", validCue_fic, sep = ""))
  writeLines(paste("     invalid : congruent = ", invalidCue_fc, sep = ""))
  writeLines(paste("     invalid : incongruent = ", invalidCue_fic, sep = ""))
  writeLines(sprintf(""))

  writeLines("     CueCondition : LocationCongruency")
  writeLines(paste("     valid : congruent = ", validCue_lc, sep = ""))
  writeLines(paste("     valid : incongruent = ", validCue_lic, sep = ""))
  writeLines(paste("     invalid : congruent = ", invalidCue_lc, sep = ""))
  writeLines(paste("     invalid : incongruent = ", invalidCue_lic, sep = ""))
  writeLines(sprintf(""))

  writeLines("     CueToTarget : FlankerCongruency")
  writeLines(paste("     0 : congruent = ", ct0_fc, sep = ""))
  writeLines(paste("     400 : congruent = ", ct400_fc, sep = ""))
  writeLines(paste("     800 : congruent = ", ct800_fc, sep = ""))
  writeLines(paste("     0 : incongruent = ", ct0_fic, sep = ""))
  writeLines(paste("     400 : incongruent = ", ct400_fic, sep = ""))
  writeLines(paste("     800 : incongruent = ", ct800_fic, sep = ""))
  writeLines(sprintf(""))

  writeLines("     CueToTarget : LocationCongruency")
  writeLines(paste("     0 : congruent = ", ct0_lc, sep = ""))
  writeLines(paste("     400 : congruent = ", ct400_lc, sep = ""))
  writeLines(paste("     800 : congruent = ", ct800_lc, sep = ""))
  writeLines(paste("     0 : incongruent = ", ct0_lic, sep = ""))
  writeLines(paste("     400 : incongruent = ", ct400_lic, sep = ""))
  writeLines(paste("     800 : incongruent = ", ct800_lic, sep = ""))
  writeLines(sprintf(""))

  writeLines("     FlankerCongruency : LocationCongruency")
  writeLines(paste("     congruent : congruent = ", fc_lc, sep = ""))
  writeLines(paste("     congruent : incongruent = ", fc_lic, sep = ""))
  writeLines(paste("     incongruent : congruent = ", fic_lc, sep = ""))
  writeLines(paste("     incongruent : incongruent = ", fic_lic, sep = ""))
  writeLines(sprintf(""))

  writeLines("     CueCondition : CueToTarget : FlankerCongruency")
  writeLines(paste("     valid : 0 : congruent = ", validCue_ct0_fc, sep = ""))
  writeLines(paste("     valid : 400 : congruent = ", validCue_ct400_fc, sep = ""))
  writeLines(paste("     valid : 800 : congruent = ", validCue_ct800_fc, sep = ""))
  writeLines(paste("     invalid : 0 : congruent = ", invalidCue_ct0_fc, sep = ""))
  writeLines(paste("     invalid : 400 : congruent = ", invalidCue_ct400_fc, sep = ""))
  writeLines(paste("     invalid : 800 : congruent = ", invalidCue_ct800_fc, sep = ""))
  writeLines(paste("     valid : 0 : incongruent = ", validCue_ct0_fic, sep = ""))
  writeLines(paste("     valid : 400 : incongruent = ", validCue_ct400_fic, sep = ""))
  writeLines(paste("     valid : 800 : incongruent = ", validCue_ct800_fic, sep = ""))
  writeLines(paste("     invalid : 0 : incongruent = ", invalidCue_ct0_fic, sep = ""))
  writeLines(paste("     invalid : 400 : incongruent = ", invalidCue_ct400_fic, sep = ""))
  writeLines(paste("     invalid : 800 : incongruent = ", invalidCue_ct800_fic, sep = ""))
  writeLines(sprintf(""))

  writeLines("     CueCondition : CueToTarget : LocationCongruency")
  writeLines(paste("     valid : 0 : congruent = ", validCue_ct0_lc, sep = ""))
  writeLines(paste("     valid : 400 : congruent = ", validCue_ct400_lc, sep = ""))
  writeLines(paste("     valid : 800 : congruent = ", validCue_ct800_lc, sep = ""))
  writeLines(paste("     invalid : 0 : congruent = ", invalidCue_ct0_lc, sep = ""))
  writeLines(paste("     invalid : 400 : congruent = ", invalidCue_ct400_lc, sep = ""))
  writeLines(paste("     invalid : 800 : congruent = ", invalidCue_ct800_lc, sep = ""))
  writeLines(paste("     valid : 0 : incongruent = ", validCue_ct0_lic, sep = ""))
  writeLines(paste("     valid : 400 : incongruent = ", validCue_ct400_lic, sep = ""))
  writeLines(paste("     valid : 800 : incongruent = ", validCue_ct800_lic, sep = ""))
  writeLines(paste("     invalid : 0 : incongruent = ", invalidCue_ct0_lic, sep = ""))
  writeLines(paste("     invalid : 400 : incongruent = ", invalidCue_ct400_lic, sep = ""))
  writeLines(paste("     invalid : 800 : incongruent = ", invalidCue_ct800_lic, sep = ""))
  writeLines(sprintf(""))

  writeLines("     CueToTarget : FlankerCongruency : LocationCongruency")
  writeLines(paste("     0 : congruent : congruent = ", ct0_fc_lc, sep = ""))
  writeLines(paste("     400 : congruent : congruent = ", ct400_fc_lc, sep = ""))
  writeLines(paste("     800 : congruent : congruent = ", ct800_fc_lc, sep = ""))
  writeLines(paste("     0 : incongruent : congruent = ", ct0_fic_lc, sep = ""))
  writeLines(paste("     400 : incongruent : congruent = ", ct400_fic_lc, sep = ""))
  writeLines(paste("     800 : incongruent : congruent = ", ct800_fic_lc, sep = ""))
  writeLines(paste("     0 : congruent : incongruent = ", ct0_fc_lic, sep = ""))
  writeLines(paste("     400 : congruent : incongruent = ", ct400_fc_lic, sep = ""))
  writeLines(paste("     800 : congruent : incongruent = ", ct800_fc_lic, sep = ""))
  writeLines(paste("     0 : incongruent : incongruent = ", ct0_fic_lic, sep = ""))
  writeLines(paste("     400 : incongruent : incongruent = ", ct400_fic_lic, sep = ""))
  writeLines(paste("     800 : incongruent : incongruent = ", ct800_fic_lic, sep = ""))
  writeLines(sprintf(""))

  writeLines("     CueCondition : CueToTarget : FlankerCongruency : LocationCongruency")
  writeLines(paste("     valid : 0 : congruent : congruent = ", validCue_ct0_fc_lc, sep = ""))
  writeLines(paste(
    "     valid : 400 : congruent : congruent = ",
    validCue_ct400_fc_lc,
    sep = ""
  ))
  writeLines(paste(
    "     valid : 800 : congruent : congruent = ",
    validCue_ct800_fc_lc,
    sep = ""
  ))
  writeLines(paste(
    "     valid : 0 : incongruent : congruent = ",
    validCue_ct0_fic_lc,
    sep = ""
  ))
  writeLines(paste(
    "     valid : 400 : incongruent : congruent = ",
    validCue_ct400_fic_lc,
    sep = ""
  ))
  writeLines(paste(
    "     valid : 800 : incongruent : congruent = ",
    validCue_ct800_fic_lc,
    sep = ""
  ))
  writeLines(paste(
    "     valid : 0 : congruent : incongruent = ",
    validCue_ct0_fc_lic,
    sep = ""
  ))
  writeLines(paste(
    "     valid : 400 : congruent : incongruent = ",
    validCue_ct400_fc_lic,
    sep = ""
  ))
  writeLines(paste(
    "     valid : 800 : congruent : incongruent = ",
    validCue_ct800_fc_lic,
    sep = ""
  ))
  writeLines(paste(
    "     valid : 0 : incongruent : incongruent = ",
    validCue_ct0_fic_lic,
    sep = ""
  ))
  writeLines(paste(
    "     valid : 400 : incongruent : incongruent = ",
    validCue_ct400_fic_lic,
    sep = ""
  ))
  writeLines(paste(
    "     valid : 800 : incongruent : incongruent = ",
    validCue_ct800_fic_lic,
    sep = ""
  ))
  writeLines(paste(
    "     invalid : 0 : congruent : congruent = ",
    invalidCue_ct0_fc_lc,
    sep = ""
  ))
  writeLines(paste(
    "     invalid : 400 : congruent : congruent = ",
    invalidCue_ct400_fc_lc,
    sep = ""
  ))
  writeLines(paste(
    "     invalid : 800 : congruent : congruent = ",
    invalidCue_ct800_fc_lc,
    sep = ""
  ))
  writeLines(paste(
    "     invalid : 0 : incongruent : congruent = ",
    invalidCue_ct0_fic_lc,
    sep = ""
  ))
  writeLines(paste(
    "     invalid : 400 : incongruent : congruent = ",
    invalidCue_ct400_fic_lc,
    sep = ""
  ))
  writeLines(paste(
    "     invalid : 800 : incongruent : congruent = ",
    invalidCue_ct800_fic_lc,
    sep = ""
  ))
  writeLines(paste(
    "     invalid : 0 : congruent : incongruent = ",
    invalidCue_ct0_fc_lic,
    sep = ""
  ))
  writeLines(paste(
    "     invalid : 400 : congruent : incongruent = ",
    invalidCue_ct400_fc_lic,
    sep = ""
  ))
  writeLines(paste(
    "     invalid : 800 : congruent : incongruent = ",
    invalidCue_ct800_fc_lic,
    sep = ""
  ))
  writeLines(paste(
    "     invalid : 0 : incongruent : incongruent = ",
    invalidCue_ct0_fic_lic,
    sep = ""
  ))
  writeLines(
    paste(
      "     invalid : 400 : incongruent : incongruent = ",
      invalidCue_ct400_fic_lic,
      sep = ""
    )
  )
  writeLines(
    paste(
      "     invalid : 800 : incongruent : incongruent = ",
      invalidCue_ct800_fic_lic,
      sep = ""
    )
  )

  writeLines(sprintf(""))
  writeLines(sprintf(""))
}

printValidityByConflict_ANOVAs <- function(allResults, participantsFolder) {
  pathToOutputFile <- getPath("../../../Results/ValidityByConflict_ANOVAs.txt")

  sink(
    file = pathToOutputFile,
    append = FALSE,
    type = "output",
    split = FALSE
  )

  writeLines(
    "----------------------------------------------------------------------------"
  )
  writeLines("Within-subject ANOVAs: Validity by Conflict")

  printValidityByConflict_ANOVA(
    allResults$Id,
    allResults$R_RT_IVC_0_FCLC,
    allResults$R_RT_IVC_0_FICLC,
    allResults$R_RT_IVC_0_FCLIC,
    allResults$R_RT_IVC_0_FICLIC,
    allResults$R_RT_IVC_400_FCLC,
    allResults$R_RT_IVC_400_FICLC,
    allResults$R_RT_IVC_400_FCLIC,
    allResults$R_RT_IVC_400_FICLIC,
    allResults$R_RT_IVC_800_FCLC,
    allResults$R_RT_IVC_800_FICLC,
    allResults$R_RT_IVC_800_FCLIC,
    allResults$R_RT_IVC_800_FICLIC,
    allResults$R_RT_VC_0_FCLC,
    allResults$R_RT_VC_0_FICLC,
    allResults$R_RT_VC_0_FCLIC,
    allResults$R_RT_VC_0_FICLIC,
    allResults$R_RT_VC_400_FCLC,
    allResults$R_RT_VC_400_FICLC,
    allResults$R_RT_VC_400_FCLIC,
    allResults$R_RT_VC_400_FICLIC,
    allResults$R_RT_VC_800_FCLC,
    allResults$R_RT_VC_800_FICLC,
    allResults$R_RT_VC_800_FCLIC,
    allResults$R_RT_VC_800_FICLIC,
    "ANT-R",
    "(RT)"
  )

  printValidityByConflict_ANOVA(
    allResults$Id,
    allResults$R_ACC_IVC_0_FCLC,
    allResults$R_ACC_IVC_0_FICLC,
    allResults$R_ACC_IVC_0_FCLIC,
    allResults$R_ACC_IVC_0_FICLIC,
    allResults$R_ACC_IVC_400_FCLC,
    allResults$R_ACC_IVC_400_FICLC,
    allResults$R_ACC_IVC_400_FCLIC,
    allResults$R_ACC_IVC_400_FICLIC,
    allResults$R_ACC_IVC_800_FCLC,
    allResults$R_ACC_IVC_800_FICLC,
    allResults$R_ACC_IVC_800_FCLIC,
    allResults$R_ACC_IVC_800_FICLIC,
    allResults$R_ACC_VC_0_FCLC,
    allResults$R_ACC_VC_0_FICLC,
    allResults$R_ACC_VC_0_FCLIC,
    allResults$R_ACC_VC_0_FICLIC,
    allResults$R_ACC_VC_400_FCLC,
    allResults$R_ACC_VC_400_FICLC,
    allResults$R_ACC_VC_400_FCLIC,
    allResults$R_ACC_VC_400_FICLIC,
    allResults$R_ACC_VC_800_FCLC,
    allResults$R_ACC_VC_800_FICLC,
    allResults$R_ACC_VC_800_FCLIC,
    allResults$R_ACC_VC_800_FICLIC,
    "ANT-R",
    "(ACC)"
  )

  printValidityByConflict_ANOVA(
    allResults$Id,
    allResults$VR_RT_IVC_0_FCLC,
    allResults$VR_RT_IVC_0_FICLC,
    allResults$VR_RT_IVC_0_FCLIC,
    allResults$VR_RT_IVC_0_FICLIC,
    allResults$VR_RT_IVC_400_FCLC,
    allResults$VR_RT_IVC_400_FICLC,
    allResults$VR_RT_IVC_400_FCLIC,
    allResults$VR_RT_IVC_400_FICLIC,
    allResults$VR_RT_IVC_800_FCLC,
    allResults$VR_RT_IVC_800_FICLC,
    allResults$VR_RT_IVC_800_FCLIC,
    allResults$VR_RT_IVC_800_FICLIC,
    allResults$VR_RT_VC_0_FCLC,
    allResults$VR_RT_VC_0_FICLC,
    allResults$VR_RT_VC_0_FCLIC,
    allResults$VR_RT_VC_0_FICLIC,
    allResults$VR_RT_VC_400_FCLC,
    allResults$VR_RT_VC_400_FICLC,
    allResults$VR_RT_VC_400_FCLIC,
    allResults$VR_RT_VC_400_FICLIC,
    allResults$VR_RT_VC_800_FCLC,
    allResults$VR_RT_VC_800_FICLC,
    allResults$VR_RT_VC_800_FCLIC,
    allResults$VR_RT_VC_800_FICLIC,
    "ANT-VR",
    "(RT)"
  )

  printValidityByConflict_ANOVA(
    allResults$Id,
    allResults$VR_ACC_IVC_0_FCLC,
    allResults$VR_ACC_IVC_0_FICLC,
    allResults$VR_ACC_IVC_0_FCLIC,
    allResults$VR_ACC_IVC_0_FICLIC,
    allResults$VR_ACC_IVC_400_FCLC,
    allResults$VR_ACC_IVC_400_FICLC,
    allResults$VR_ACC_IVC_400_FCLIC,
    allResults$VR_ACC_IVC_400_FICLIC,
    allResults$VR_ACC_IVC_800_FCLC,
    allResults$VR_ACC_IVC_800_FICLC,
    allResults$VR_ACC_IVC_800_FCLIC,
    allResults$VR_ACC_IVC_800_FICLIC,
    allResults$VR_ACC_VC_0_FCLC,
    allResults$VR_ACC_VC_0_FICLC,
    allResults$VR_ACC_VC_0_FCLIC,
    allResults$VR_ACC_VC_0_FICLIC,
    allResults$VR_ACC_VC_400_FCLC,
    allResults$VR_ACC_VC_400_FICLC,
    allResults$VR_ACC_VC_400_FCLIC,
    allResults$VR_ACC_VC_400_FICLIC,
    allResults$VR_ACC_VC_800_FCLC,
    allResults$VR_ACC_VC_800_FICLC,
    allResults$VR_ACC_VC_800_FCLIC,
    allResults$VR_ACC_VC_800_FICLIC,
    "ANT-VR",
    "(ACC)"
  )

  printValidityByConflict_ANOVA(
    allResults$Id,
    allResults$VR_B_RT_IVC_0_FCLC,
    allResults$VR_B_RT_IVC_0_FICLC,
    allResults$VR_B_RT_IVC_0_FCLIC,
    allResults$VR_B_RT_IVC_0_FICLIC,
    allResults$VR_B_RT_IVC_400_FCLC,
    allResults$VR_B_RT_IVC_400_FICLC,
    allResults$VR_B_RT_IVC_400_FCLIC,
    allResults$VR_B_RT_IVC_400_FICLIC,
    allResults$VR_B_RT_IVC_800_FCLC,
    allResults$VR_B_RT_IVC_800_FICLC,
    allResults$VR_B_RT_IVC_800_FCLIC,
    allResults$VR_B_RT_IVC_800_FICLIC,
    allResults$VR_B_RT_VC_0_FCLC,
    allResults$VR_B_RT_VC_0_FICLC,
    allResults$VR_B_RT_VC_0_FCLIC,
    allResults$VR_B_RT_VC_0_FICLIC,
    allResults$VR_B_RT_VC_400_FCLC,
    allResults$VR_B_RT_VC_400_FICLC,
    allResults$VR_B_RT_VC_400_FCLIC,
    allResults$VR_B_RT_VC_400_FICLIC,
    allResults$VR_B_RT_VC_800_FCLC,
    allResults$VR_B_RT_VC_800_FICLC,
    allResults$VR_B_RT_VC_800_FCLIC,
    allResults$VR_B_RT_VC_800_FICLIC,
    "ANT-VR B",
    "(RT)"
  )

  printValidityByConflict_ANOVA(
    allResults$Id,
    allResults$VR_B_ACC_IVC_0_FCLC,
    allResults$VR_B_ACC_IVC_0_FICLC,
    allResults$VR_B_ACC_IVC_0_FCLIC,
    allResults$VR_B_ACC_IVC_0_FICLIC,
    allResults$VR_B_ACC_IVC_400_FCLC,
    allResults$VR_B_ACC_IVC_400_FICLC,
    allResults$VR_B_ACC_IVC_400_FCLIC,
    allResults$VR_B_ACC_IVC_400_FICLIC,
    allResults$VR_B_ACC_IVC_800_FCLC,
    allResults$VR_B_ACC_IVC_800_FICLC,
    allResults$VR_B_ACC_IVC_800_FCLIC,
    allResults$VR_B_ACC_IVC_800_FICLIC,
    allResults$VR_B_ACC_VC_0_FCLC,
    allResults$VR_B_ACC_VC_0_FICLC,
    allResults$VR_B_ACC_VC_0_FCLIC,
    allResults$VR_B_ACC_VC_0_FICLIC,
    allResults$VR_B_ACC_VC_400_FCLC,
    allResults$VR_B_ACC_VC_400_FICLC,
    allResults$VR_B_ACC_VC_400_FCLIC,
    allResults$VR_B_ACC_VC_400_FICLIC,
    allResults$VR_B_ACC_VC_800_FCLC,
    allResults$VR_B_ACC_VC_800_FICLC,
    allResults$VR_B_ACC_VC_800_FCLIC,
    allResults$VR_B_ACC_VC_800_FICLIC,
    "ANT-VR B",
    "(ACC)"
  )

  writeLines(
    "----------------------------------------------------------------------------"
  )

  sink()
}

getPearsonCorrelation <- function(a, b) {
  correlation <- getRoundedValue(cor(a, b, use = "complete.obs", method = "pearson"), 2)
  corTest <- cor.test(a,
    b,
    use = "complete.obs",
    method = "pearson",
    conf.level = 0.95
  )
  df <- corTest[["parameter"]]
  pvalue <- getFormattedPValueForPairwiseCorrelation(corTest[["p.value"]])
  result <- paste("r(", df, ") = ", correlation, ", p = ", pvalue, sep = "")
}

getPearsonCorrelationTable <- function(alerting,
                                       validity,
                                       disengaging,
                                       moving_engaging,
                                       orientingTime,
                                       flankerConflict,
                                       locationConflict,
                                       ior,
                                       meanRT) {
  n1n1_cor <- NA
  n1n2_cor <- getPearsonCorrelation(alerting, validity)
  n1n3_cor <- getPearsonCorrelation(alerting, disengaging)
  n1n4_cor <- getPearsonCorrelation(alerting, moving_engaging)
  n1n5_cor <- getPearsonCorrelation(alerting, orientingTime)
  n1n6_cor <- getPearsonCorrelation(alerting, flankerConflict)
  n1n7_cor <- getPearsonCorrelation(alerting, locationConflict)
  n1n8_cor <- getPearsonCorrelation(alerting, ior)
  n1n9_cor <- getPearsonCorrelation(alerting, meanRT)

  n2n1_cor <- NA
  n2n2_cor <- NA
  n2n3_cor <- getPearsonCorrelation(validity, disengaging)
  n2n4_cor <- getPearsonCorrelation(validity, moving_engaging)
  n2n5_cor <- getPearsonCorrelation(validity, orientingTime)
  n2n6_cor <- getPearsonCorrelation(validity, flankerConflict)
  n2n7_cor <- getPearsonCorrelation(validity, locationConflict)
  n2n8_cor <- getPearsonCorrelation(validity, ior)
  n2n9_cor <- getPearsonCorrelation(validity, meanRT)

  n3n1_cor <- NA
  n3n2_cor <- NA
  n3n3_cor <- NA
  n3n4_cor <- getPearsonCorrelation(disengaging, moving_engaging)
  n3n5_cor <- getPearsonCorrelation(disengaging, orientingTime)
  n3n6_cor <- getPearsonCorrelation(disengaging, flankerConflict)
  n3n7_cor <- getPearsonCorrelation(disengaging, locationConflict)
  n3n8_cor <- getPearsonCorrelation(disengaging, ior)
  n3n9_cor <- getPearsonCorrelation(disengaging, meanRT)

  n4n1_cor <- NA
  n4n2_cor <- NA
  n4n3_cor <- NA
  n4n4_cor <- NA
  n4n5_cor <- getPearsonCorrelation(moving_engaging, orientingTime)
  n4n6_cor <- getPearsonCorrelation(moving_engaging, flankerConflict)
  n4n7_cor <- getPearsonCorrelation(moving_engaging, locationConflict)
  n4n8_cor <- getPearsonCorrelation(moving_engaging, ior)
  n4n9_cor <- getPearsonCorrelation(moving_engaging, meanRT)

  n5n1_cor <- NA
  n5n2_cor <- NA
  n5n3_cor <- NA
  n5n4_cor <- NA
  n5n5_cor <- NA
  n5n6_cor <- getPearsonCorrelation(orientingTime, flankerConflict)
  n5n7_cor <- getPearsonCorrelation(orientingTime, locationConflict)
  n5n8_cor <- getPearsonCorrelation(orientingTime, ior)
  n5n9_cor <- getPearsonCorrelation(orientingTime, meanRT)

  n6n1_cor <- NA
  n6n2_cor <- NA
  n6n3_cor <- NA
  n6n4_cor <- NA
  n6n5_cor <- NA
  n6n6_cor <- NA
  n6n7_cor <- getPearsonCorrelation(flankerConflict, locationConflict)
  n6n8_cor <- getPearsonCorrelation(flankerConflict, ior)
  n6n9_cor <- getPearsonCorrelation(flankerConflict, meanRT)

  n7n1_cor <- NA
  n7n2_cor <- NA
  n7n3_cor <- NA
  n7n4_cor <- NA
  n7n5_cor <- NA
  n7n6_cor <- NA
  n7n7_cor <- NA
  n7n8_cor <- getPearsonCorrelation(locationConflict, ior)
  n7n9_cor <- getPearsonCorrelation(locationConflict, meanRT)

  n8n1_cor <- NA
  n8n2_cor <- NA
  n8n3_cor <- NA
  n8n4_cor <- NA
  n8n5_cor <- NA
  n8n6_cor <- NA
  n8n7_cor <- NA
  n8n8_cor <- NA
  n8n9_cor <- getPearsonCorrelation(ior, meanRT)

  alerting_res <- c(
    n1n1_cor,
    n1n2_cor,
    n1n3_cor,
    n1n4_cor,
    n1n5_cor,
    n1n6_cor,
    n1n7_cor,
    n1n8_cor,
    n1n9_cor
  )

  validity_res <- c(
    n2n1_cor,
    n2n2_cor,
    n2n3_cor,
    n2n4_cor,
    n2n5_cor,
    n2n6_cor,
    n2n7_cor,
    n2n8_cor,
    n2n9_cor
  )

  disengaging_res <- c(
    n3n1_cor,
    n3n2_cor,
    n3n3_cor,
    n3n4_cor,
    n3n5_cor,
    n3n6_cor,
    n3n7_cor,
    n3n8_cor,
    n3n9_cor
  )

  moving_engaging_res <- c(
    n4n1_cor,
    n4n2_cor,
    n4n3_cor,
    n4n4_cor,
    n4n5_cor,
    n4n6_cor,
    n4n7_cor,
    n4n8_cor,
    n4n9_cor
  )

  orientingTime_res <- c(
    n5n1_cor,
    n5n2_cor,
    n5n3_cor,
    n5n4_cor,
    n5n5_cor,
    n5n6_cor,
    n5n7_cor,
    n5n8_cor,
    n5n9_cor
  )

  flankerConflict_res <- c(
    n6n1_cor,
    n6n2_cor,
    n6n3_cor,
    n6n4_cor,
    n6n5_cor,
    n6n6_cor,
    n6n7_cor,
    n6n8_cor,
    n6n9_cor
  )

  locationConflict_res <- c(
    n7n1_cor,
    n7n2_cor,
    n7n3_cor,
    n7n4_cor,
    n7n5_cor,
    n7n6_cor,
    n7n7_cor,
    n7n8_cor,
    n7n9_cor
  )

  ior_res <- c(
    n8n1_cor,
    n8n2_cor,
    n8n3_cor,
    n8n4_cor,
    n8n5_cor,
    n8n6_cor,
    n8n7_cor,
    n8n8_cor,
    n8n9_cor
  )

  rowname <- c(
    "Alerting",
    "Validity",
    "Disengaging",
    "Moving + Engaging",
    "Orienting Time",
    "Flanker Conflict",
    "Location Conflict",
    "IOR",
    "Mean RT"
  )
  result <- data.frame(
    rowname,
    alerting_res,
    validity_res,
    disengaging_res,
    moving_engaging_res,
    orientingTime_res,
    flankerConflict_res,
    locationConflict_res,
    ior_res
  )
}

getPearsonCorrelationForPlot <- function(a, b) {
  correlation <- getMonospacedRoundedValue(cor(a, b, use = "complete.obs", method = "pearson"), 2)
  corTest <- cor.test(a,
    b,
    use = "complete.obs",
    method = "pearson",
    conf.level = 0.95
  )
  degOfFreedom <- corTest[["parameter"]]
  pvalue <- getFormattedPValueForPlot(corTest[["p.value"]])
  result <- c(correlation, pvalue, degOfFreedom)
}

getPearsonCorrelationsForPlot <- function(alerting,
                                          validity,
                                          disengaging,
                                          moving_engaging,
                                          orientingTime,
                                          flankerConflict,
                                          locationConflict,
                                          ior,
                                          overall) {
  sni <- getSimpleNetworkAndInteractionEffect(alerting)
  n1_Mean <- sni[1]
  n1_SD <- sni[2]

  sni <- getSimpleNetworkAndInteractionEffect(validity)
  n2_Mean <- sni[1]
  n2_SD <- sni[2]

  sni <- getSimpleNetworkAndInteractionEffect(disengaging)
  n3_Mean <- sni[1]
  n3_SD <- sni[2]

  sni <- getSimpleNetworkAndInteractionEffect(moving_engaging)
  n4_Mean <- sni[1]
  n4_SD <- sni[2]

  sni <- getSimpleNetworkAndInteractionEffect(orientingTime)
  n5_Mean <- sni[1]
  n5_SD <- sni[2]

  sni <- getSimpleNetworkAndInteractionEffect(flankerConflict)
  n6_Mean <- sni[1]
  n6_SD <- sni[2]

  sni <- getSimpleNetworkAndInteractionEffect(locationConflict)
  n7_Mean <- sni[1]
  n7_SD <- sni[2]

  sni <- getSimpleNetworkAndInteractionEffect(ior)
  n8_Mean <- sni[1]
  n8_SD <- sni[2]

  sni <- getSimpleNetworkAndInteractionEffect(overall)
  n9_Mean <- sni[1]
  n9_SD <- sni[2]

  n1n1_cor <- NA
  n1n2_cor <- getPearsonCorrelationForPlot(alerting, validity)
  n1n3_cor <- getPearsonCorrelationForPlot(alerting, disengaging)
  n1n4_cor <- getPearsonCorrelationForPlot(alerting, moving_engaging)
  n1n5_cor <- getPearsonCorrelationForPlot(alerting, orientingTime)
  n1n6_cor <- getPearsonCorrelationForPlot(alerting, flankerConflict)
  n1n7_cor <- getPearsonCorrelationForPlot(alerting, locationConflict)
  n1n8_cor <- getPearsonCorrelationForPlot(alerting, ior)
  n1n9_cor <- getPearsonCorrelationForPlot(alerting, overall)

  n2n1_cor <- NA
  n2n2_cor <- NA
  n2n3_cor <- getPearsonCorrelationForPlot(validity, disengaging)
  n2n4_cor <- getPearsonCorrelationForPlot(validity, moving_engaging)
  n2n5_cor <- getPearsonCorrelationForPlot(validity, orientingTime)
  n2n6_cor <- getPearsonCorrelationForPlot(validity, flankerConflict)
  n2n7_cor <- getPearsonCorrelationForPlot(validity, locationConflict)
  n2n8_cor <- getPearsonCorrelationForPlot(validity, ior)
  n2n9_cor <- getPearsonCorrelationForPlot(validity, overall)

  n3n1_cor <- NA
  n3n2_cor <- NA
  n3n3_cor <- NA
  n3n4_cor <- getPearsonCorrelationForPlot(disengaging, moving_engaging)
  n3n5_cor <- getPearsonCorrelationForPlot(disengaging, orientingTime)
  n3n6_cor <- getPearsonCorrelationForPlot(disengaging, flankerConflict)
  n3n7_cor <- getPearsonCorrelationForPlot(disengaging, locationConflict)
  n3n8_cor <- getPearsonCorrelationForPlot(disengaging, ior)
  n3n9_cor <- getPearsonCorrelationForPlot(disengaging, overall)

  n4n1_cor <- NA
  n4n2_cor <- NA
  n4n3_cor <- NA
  n4n4_cor <- NA
  n4n5_cor <- getPearsonCorrelationForPlot(moving_engaging, orientingTime)
  n4n6_cor <- getPearsonCorrelationForPlot(moving_engaging, flankerConflict)
  n4n7_cor <- getPearsonCorrelationForPlot(moving_engaging, locationConflict)
  n4n8_cor <- getPearsonCorrelationForPlot(moving_engaging, ior)
  n4n9_cor <- getPearsonCorrelationForPlot(moving_engaging, overall)

  n5n1_cor <- NA
  n5n2_cor <- NA
  n5n3_cor <- NA
  n5n4_cor <- NA
  n5n5_cor <- NA
  n5n6_cor <- getPearsonCorrelationForPlot(orientingTime, flankerConflict)
  n5n7_cor <- getPearsonCorrelationForPlot(orientingTime, locationConflict)
  n5n8_cor <- getPearsonCorrelationForPlot(orientingTime, ior)
  n5n9_cor <- getPearsonCorrelationForPlot(orientingTime, overall)

  n6n1_cor <- NA
  n6n2_cor <- NA
  n6n3_cor <- NA
  n6n4_cor <- NA
  n6n5_cor <- NA
  n6n6_cor <- NA
  n6n7_cor <- getPearsonCorrelationForPlot(flankerConflict, locationConflict)
  n6n8_cor <- getPearsonCorrelationForPlot(flankerConflict, ior)
  n6n9_cor <- getPearsonCorrelationForPlot(flankerConflict, overall)

  n7n1_cor <- NA
  n7n2_cor <- NA
  n7n3_cor <- NA
  n7n4_cor <- NA
  n7n5_cor <- NA
  n7n6_cor <- NA
  n7n7_cor <- NA
  n7n8_cor <- getPearsonCorrelationForPlot(locationConflict, ior)
  n7n9_cor <- getPearsonCorrelationForPlot(locationConflict, overall)

  n8n1_cor <- NA
  n8n2_cor <- NA
  n8n3_cor <- NA
  n8n4_cor <- NA
  n8n5_cor <- NA
  n8n6_cor <- NA
  n8n7_cor <- NA
  n8n8_cor <- NA
  n8n9_cor <- getPearsonCorrelationForPlot(ior, overall)

  mean_res <- c(
    n1_Mean,
    n2_Mean,
    n3_Mean,
    n4_Mean,
    n5_Mean,
    n6_Mean,
    n7_Mean,
    n8_Mean,
    n9_Mean
  )

  sd_res <- c(n1_SD, n2_SD, n3_SD, n4_SD, n5_SD, n6_SD, n7_SD, n8_SD, n9_SD)

  alerting_mean <- c(
    n1n1_cor[1],
    n1n2_cor[1],
    n1n3_cor[1],
    n1n4_cor[1],
    n1n5_cor[1],
    n1n6_cor[1],
    n1n7_cor[1],
    n1n8_cor[1],
    n1n9_cor[1]
  )

  validity_mean <- c(
    n2n1_cor[1],
    n2n2_cor[1],
    n2n3_cor[1],
    n2n4_cor[1],
    n2n5_cor[1],
    n2n6_cor[1],
    n2n7_cor[1],
    n2n8_cor[1],
    n2n9_cor[1]
  )

  disengaging_mean <- c(
    n3n1_cor[1],
    n3n2_cor[1],
    n3n3_cor[1],
    n3n4_cor[1],
    n3n5_cor[1],
    n3n6_cor[1],
    n3n7_cor[1],
    n3n8_cor[1],
    n3n9_cor[1]
  )

  moving_engaging_mean <- c(
    n4n1_cor[1],
    n4n2_cor[1],
    n4n3_cor[1],
    n4n4_cor[1],
    n4n5_cor[1],
    n4n6_cor[1],
    n4n7_cor[1],
    n4n8_cor[1],
    n4n9_cor[1]
  )

  orientingTime_mean <- c(
    n5n1_cor[1],
    n5n2_cor[1],
    n5n3_cor[1],
    n5n4_cor[1],
    n5n5_cor[1],
    n5n6_cor[1],
    n5n7_cor[1],
    n5n8_cor[1],
    n5n9_cor[1]
  )

  flankerConflict_mean <- c(
    n6n1_cor[1],
    n6n2_cor[1],
    n6n3_cor[1],
    n6n4_cor[1],
    n6n5_cor[1],
    n6n6_cor[1],
    n6n7_cor[1],
    n6n8_cor[1],
    n6n9_cor[1]
  )

  locationConflict_mean <- c(
    n7n1_cor[1],
    n7n2_cor[1],
    n7n3_cor[1],
    n7n4_cor[1],
    n7n5_cor[1],
    n7n6_cor[1],
    n7n7_cor[1],
    n7n8_cor[1],
    n7n9_cor[1]
  )

  ior_mean <- c(
    n8n1_cor[1],
    n8n2_cor[1],
    n8n3_cor[1],
    n8n4_cor[1],
    n8n5_cor[1],
    n8n6_cor[1],
    n8n7_cor[1],
    n8n8_cor[1],
    n8n9_cor[1]
  )

  alerting_p <- c(
    n1n1_cor[2],
    n1n2_cor[2],
    n1n3_cor[2],
    n1n4_cor[2],
    n1n5_cor[2],
    n1n6_cor[2],
    n1n7_cor[2],
    n1n8_cor[2],
    n1n9_cor[2]
  )

  validity_p <- c(
    n2n1_cor[2],
    n2n2_cor[2],
    n2n3_cor[2],
    n2n4_cor[2],
    n2n5_cor[2],
    n2n6_cor[2],
    n2n7_cor[2],
    n2n8_cor[2],
    n2n9_cor[2]
  )

  disengaging_p <- c(
    n3n1_cor[2],
    n3n2_cor[2],
    n3n3_cor[2],
    n3n4_cor[2],
    n3n5_cor[2],
    n3n6_cor[2],
    n3n7_cor[2],
    n3n8_cor[2],
    n3n9_cor[2]
  )

  moving_engaging_p <- c(
    n4n1_cor[2],
    n4n2_cor[2],
    n4n3_cor[2],
    n4n4_cor[2],
    n4n5_cor[2],
    n4n6_cor[2],
    n4n7_cor[2],
    n4n8_cor[2],
    n4n9_cor[2]
  )

  orientingTime_p <- c(
    n5n1_cor[2],
    n5n2_cor[2],
    n5n3_cor[2],
    n5n4_cor[2],
    n5n5_cor[2],
    n5n6_cor[2],
    n5n7_cor[2],
    n5n8_cor[2],
    n5n9_cor[2]
  )

  flankerConflict_p <- c(
    n6n1_cor[2],
    n6n2_cor[2],
    n6n3_cor[2],
    n6n4_cor[2],
    n6n5_cor[2],
    n6n6_cor[2],
    n6n7_cor[2],
    n6n8_cor[2],
    n6n9_cor[2]
  )

  locationConflict_p <- c(
    n7n1_cor[2],
    n7n2_cor[2],
    n7n3_cor[2],
    n7n4_cor[2],
    n7n5_cor[2],
    n7n6_cor[2],
    n7n7_cor[2],
    n7n8_cor[2],
    n7n9_cor[2]
  )

  ior_p <- c(
    n8n1_cor[2],
    n8n2_cor[2],
    n8n3_cor[2],
    n8n4_cor[2],
    n8n5_cor[2],
    n8n6_cor[2],
    n8n7_cor[2],
    n8n8_cor[2],
    n8n9_cor[2]
  )

  result <- list(
    data.frame(
      mean_res,
      sd_res,
      alerting_mean,
      alerting_p,
      validity_mean,
      validity_p,
      disengaging_mean,
      disengaging_p,
      moving_engaging_mean,
      moving_engaging_p,
      orientingTime_mean,
      orientingTime_p,
      flankerConflict_mean,
      flankerConflict_p,
      locationConflict_mean,
      locationConflict_p,
      ior_mean,
      ior_p
    ),
    n8n9_cor[3]
  )
}

printPearsonCorrelationTable <- function(alerting,
                                         validity,
                                         disengaging,
                                         moving_engaging,
                                         orientingTime,
                                         flankerConflict,
                                         locationConflict,
                                         ior,
                                         meanRT,
                                         experimentName) {
  cr <- getPearsonCorrelationTable(
    alerting,
    validity,
    disengaging,
    moving_engaging,
    orientingTime,
    flankerConflict,
    locationConflict,
    ior,
    meanRT
  )

  writeLines(experimentName)
  print(cr)
  writeLines(sprintf(""))
  writeLines(sprintf(""))
}

printPearsonCorrelationTables <- function(allResults, participantsFolder) {
  pathToOutputFile <- getPath("../../../Results/PearsonCorrelationTables.txt")
  sink(
    file = pathToOutputFile,
    append = FALSE,
    type = "output",
    split = FALSE
  )

  writeLines(
    "----------------------------------------------------------------------------"
  )
  writeLines("Correlation Coefficient between Network Effects: Pearson Correlation Coefficient")

  printPearsonCorrelationTable(
    allResults$R_RT_Alerting,
    allResults$R_RT_Validity,
    allResults$R_RT_Disengaging,
    allResults$R_RT_Moving_Engaging,
    allResults$R_RT_OrientingTime,
    allResults$R_RT_FlankerConflict,
    allResults$R_RT_LocationConflict,
    allResults$R_RT_IOR,
    allResults$R_RT,
    "ANT-R"
  )

  printPearsonCorrelationTable(
    allResults$VR_RT_Alerting,
    allResults$VR_RT_Validity,
    allResults$VR_RT_Disengaging,
    allResults$VR_RT_Moving_Engaging,
    allResults$VR_RT_OrientingTime,
    allResults$VR_RT_FlankerConflict,
    allResults$VR_RT_LocationConflict,
    allResults$VR_RT_IOR,
    allResults$VR_RT,
    "ANT-VR"
  )

  printPearsonCorrelationTable(
    allResults$VR_B_RT_Alerting,
    allResults$VR_B_RT_Validity,
    allResults$VR_B_RT_Disengaging,
    allResults$VR_B_RT_Moving_Engaging,
    allResults$VR_B_RT_OrientingTime,
    allResults$VR_B_RT_FlankerConflict,
    allResults$VR_B_RT_LocationConflict,
    allResults$VR_B_RT_IOR,
    allResults$VR_B_RT,
    "ANT-VR Balanced"
  )

  writeLines(
    "----------------------------------------------------------------------------"
  )

  sink()
}

getFormattedPValueForPairwiseOneSampledTTest <- function(originalValue) {
  if (originalValue < 0.001) {
    result <- "< .001"
  } else {
    result <- sub("^0+", "", paste(getRoundedValue(originalValue, 3),
      sep =
        ""
    ))
  }
}

getPairwiseOneSampledTTest <- function(x, y, numberOfDigits) {
  tTest <- t.test(x, y, paired = TRUE, alternative = "two.sided")
  result <- c(
    getRoundedValue(tTest[["statistic"]], numberOfDigits),
    getFormattedPValueForPairwiseOneSampledTTest(tTest[["p.value"]])
  )
}

getPairedTtest <- function(nameOfEffect,
                           nameOfExperimentX,
                           nameOfExperimentY,
                           nameOfValueCol,
                           x,
                           y) {
  tTest <- t.test(x, y, paired = TRUE, alternative = "two.sided")
  nameOfResult <- paste(
    nameOfExperimentX,
    " vs ",
    nameOfExperimentY,
    ", (",
    nameOfValueCol,
    "), ",
    nameOfEffect,
    sep = ""
  )

  writeLines("--------------------")
  print(nameOfResult)
  print(tTest)

  sumOfCols <- x - y
  meanX <- getRoundedValue(mean(x), 2)
  sdX <- getRoundedValue(sd(x), 2)
  meanY <- getRoundedValue(mean(y), 2)
  sdY <- getRoundedValue(sd(y), 2)
  meanDifference <- getRoundedValue(tTest[["estimate"]], 2)
  ciLow <- getRoundedValue(tTest[["conf.int"]][1], 2)
  ciHigh <- getRoundedValue(tTest[["conf.int"]][2], 2)
  param <- tTest[["parameter"]]
  tres <- getRoundedValue(tTest[["statistic"]], 2)
  tp <- getFormattedPValueForPairwiseCorrelation(tTest[["p.value"]])
  cres <- getRoundedValue(cor(x, y, use = "complete.obs"), 2)
  cp <- getFormattedPValueForPairwiseCorrelation(cor.test(x, y, use = "complete.obs")[["p.value"]])
  cohen <- getRoundedValue(cohensD(sumOfCols, mu = 0), 3)
  writeLines(sprintf(""))
  writeLines(
    paste(
      nameOfResult,
      ": (M = ",
      meanX,
      ", SD = ",
      sdX,
      ") , (M = ",
      meanY,
      ", SD = ",
      sdY,
      ") , mean difference ",
      meanDifference,
      ", 95%CI [",
      ciLow,
      ", ",
      ciHigh,
      "], t(",
      param,
      ") = ",
      tres,
      ", p = ",
      tp,
      ", r(",
      param,
      ") = ",
      cres,
      ", p = ",
      cp,
      ", Cohen's D = ",
      cohen,
      sep = ""
    )
  )
  writeLines(sprintf(""))
  writeLines(sprintf(""))
  writeLines("--------------------")
  result <- getValueWithPValueAsterisks(getRoundedValue(tTest[["statistic"]], 2), tTest[["p.value"]])
}

getPairwiseCorrelation <- function(a_Alerting,
                                   b_Alerting,
                                   a_Validity,
                                   b_Validity,
                                   a_Disengaging,
                                   b_Disengaging,
                                   a_Moving_Engaging,
                                   b_Moving_Engaging,
                                   a_OrientingTime,
                                   b_OrientingTime,
                                   a_FlankerConflict,
                                   b_FlankerConflict,
                                   a_LocationConflict,
                                   b_LocationConflict,
                                   a_FlankerByLocation,
                                   b_FlankerByLocation,
                                   a_AlertingByFlanker,
                                   b_AlertingByFlanker,
                                   a_OrientingByFlanker,
                                   b_OrientingByFlanker,
                                   a_ValidityByFlanker,
                                   b_ValidityByFlanker,
                                   a_AlertingByLocation,
                                   b_AlertingByLocation,
                                   a_OrientingByLocation,
                                   b_OrientingByLocation,
                                   a_ValidityByLocation,
                                   b_ValidityByLocation,
                                   a_IOR,
                                   b_IOR,
                                   a_Overall,
                                   b_Overall,
                                   nameOfA,
                                   nameOfB,
                                   nameOfValueCol) {
  alertingTtest <- getPairedTtest(
    "Alerting",
    nameOfA,
    nameOfB,
    nameOfValueCol,
    a_Alerting,
    b_Alerting
  )

  validityTtest <- getPairedTtest(
    "Validity",
    nameOfA,
    nameOfB,
    nameOfValueCol,
    a_Validity,
    b_Validity
  )

  disengagingTtest <- getPairedTtest(
    "Disengaging",
    nameOfA,
    nameOfB,
    nameOfValueCol,
    a_Disengaging,
    b_Disengaging
  )

  moving_engagingTtest <- getPairedTtest(
    "Moving + Engaging",
    nameOfA,
    nameOfB,
    nameOfValueCol,
    a_Moving_Engaging,
    b_Moving_Engaging
  )

  orientingTimeTtest <- getPairedTtest(
    "Orienting Time",
    nameOfA,
    nameOfB,
    nameOfValueCol,
    a_OrientingTime,
    b_OrientingTime
  )

  flankerConflictTtest <- getPairedTtest(
    "Flanker Conflict",
    nameOfA,
    nameOfB,
    nameOfValueCol,
    a_FlankerConflict,
    b_FlankerConflict
  )

  locationConflictTtest <- getPairedTtest(
    "Location Conflict",
    nameOfA,
    nameOfB,
    nameOfValueCol,
    a_LocationConflict,
    b_LocationConflict
  )

  flankerByLocationTtest <- getPairedTtest(
    "Flanker Conflict by Location Conflict",
    nameOfA,
    nameOfB,
    nameOfValueCol,
    a_FlankerByLocation,
    b_FlankerByLocation
  )

  alertingByFlankerTtest <- getPairedTtest(
    "Alerting by Flanker Conflict",
    nameOfA,
    nameOfB,
    nameOfValueCol,
    a_AlertingByFlanker,
    b_AlertingByFlanker
  )

  orientingByFlankerTtest <- getPairedTtest(
    "Orienting Time by Flanker Conflict",
    nameOfA,
    nameOfB,
    nameOfValueCol,
    a_OrientingByFlanker,
    b_OrientingByFlanker
  )

  validityByFlankerTtest <- getPairedTtest(
    "Validity by Flanker Conflict",
    nameOfA,
    nameOfB,
    nameOfValueCol,
    a_ValidityByFlanker,
    b_ValidityByFlanker
  )

  alertingByLocationTtest <- getPairedTtest(
    "Alerting by Location Conflict",
    nameOfA,
    nameOfB,
    nameOfValueCol,
    a_AlertingByLocation,
    b_AlertingByLocation
  )

  orientingByLocationTtest <- getPairedTtest(
    "Orienting Time by Location Conflict",
    nameOfA,
    nameOfB,
    nameOfValueCol,
    a_OrientingByLocation,
    b_OrientingByLocation
  )


  iorTtest <- getPairedTtest(
    "Inhibition Of Return",
    nameOfA,
    nameOfB,
    nameOfValueCol,
    a_IOR,
    b_IOR
  )

  overallMeanTtest <- getPairedTtest(
    paste("Mean ", nameOfValueCol, sep = ""),
    nameOfA,
    nameOfB,
    nameOfValueCol,
    a_Overall,
    b_Overall
  )
}

printPairwiseCorrelation_R_VR_RT <- function(res) {
  pathToOutputFile <- getPath("../../../Results/PairwiseCorrelationTable_R_VR_RT.txt")

  sink(
    file = pathToOutputFile,
    append = FALSE,
    type = "output",
    split = FALSE
  )

  writeLines(
    "----------------------------------------------------------------------------"
  )
  writeLines("Pairwise correlation between ANT-R and ANT-VR (RT)")

  pwc_R_VR_RT <- getPairwiseCorrelation(
    res$R_RT_Alerting,
    res$VR_RT_Alerting,
    res$R_RT_Validity,
    res$VR_RT_Validity,
    res$R_RT_Disengaging,
    res$VR_RT_Disengaging,
    res$R_RT_Moving_Engaging,
    res$VR_RT_Moving_Engaging,
    res$R_RT_OrientingTime,
    res$VR_RT_OrientingTime,
    res$R_RT_FlankerConflict,
    res$VR_RT_FlankerConflict,
    res$R_RT_LocationConflict,
    res$VR_RT_LocationConflict,
    res$R_RT_FlankerByLocation,
    res$VR_RT_FlankerByLocation,
    res$R_RT_AlertingByFlanker,
    res$VR_RT_AlertingByFlanker,
    res$R_RT_OrientingByFlanker,
    res$VR_RT_OrientingByFlanker,
    res$R_RT_ValidityByFlanker,
    res$VR_RT_ValidityByFlanker,
    res$R_RT_AlertingByLocation,
    res$VR_RT_AlertingByLocation,
    res$R_RT_OrientingByLocation,
    res$VR_RT_OrientingByLocation,
    res$R_RT_ValidityByLocation,
    res$VR_RT_ValidityByLocation,
    res$R_RT_IOR,
    res$VR_RT_IOR,
    res$R_RT,
    res$VR_RT,
    "ANT-R",
    "ANT-VR",
    "RT"
  )

  writeLines(
    "----------------------------------------------------------------------------"
  )
  sink()
}

printPairwiseCorrelation_R_VR_ACC <- function(res) {
  pathToOutputFile <- getPath("../../../Results/PairwiseCorrelationTable_R_VR_ACC.txt")

  sink(
    file = pathToOutputFile,
    append = FALSE,
    type = "output",
    split = FALSE
  )

  writeLines(
    "----------------------------------------------------------------------------"
  )
  writeLines("Pairwise correlation between ANT-R and ANT-VR (ACC)")

  pwc_R_VR_ACC <- getPairwiseCorrelation(
    res$R_ACC_Alerting,
    res$VR_ACC_Alerting,
    res$R_ACC_Validity,
    res$VR_ACC_Validity,
    res$R_ACC_Disengaging,
    res$VR_ACC_Disengaging,
    res$R_ACC_Moving_Engaging,
    res$VR_ACC_Moving_Engaging,
    res$R_ACC_OrientingTime,
    res$VR_ACC_OrientingTime,
    res$R_ACC_FlankerConflict,
    res$VR_ACC_FlankerConflict,
    res$R_ACC_LocationConflict,
    res$VR_ACC_LocationConflict,
    res$R_ACC_FlankerByLocation,
    res$VR_ACC_FlankerByLocation,
    res$R_ACC_AlertingByFlanker,
    res$VR_ACC_AlertingByFlanker,
    res$R_ACC_OrientingByFlanker,
    res$VR_ACC_OrientingByFlanker,
    res$R_ACC_ValidityByFlanker,
    res$VR_ACC_ValidityByFlanker,
    res$R_ACC_AlertingByLocation,
    res$VR_ACC_AlertingByLocation,
    res$R_ACC_OrientingByLocation,
    res$VR_ACC_OrientingByLocation,
    res$R_ACC_ValidityByLocation,
    res$VR_ACC_ValidityByLocation,
    res$R_ACC_IOR,
    res$VR_ACC_IOR,
    res$R_ACC,
    res$VR_ACC,
    "ANT-R",
    "ANT-VR",
    "ACC"
  )

  writeLines(
    "----------------------------------------------------------------------------"
  )
  sink()
}

printPairwiseCorrelation_R_VR_Balanced_RT <- function(res) {
  pathToOutputFile <- getPath("../../../Results/PairwiseCorrelationTable_R_VR_Balanced_RT.txt")

  sink(
    file = pathToOutputFile,
    append = FALSE,
    type = "output",
    split = FALSE
  )

  writeLines(
    "----------------------------------------------------------------------------"
  )
  writeLines("Pairwise correlation between ANT-R and ANT-VR Balanced (RT)")

  pwc_R_VR_B_RT <- getPairwiseCorrelation(
    res$R_RT_Alerting,
    res$VR_B_RT_Alerting,
    res$R_RT_Validity,
    res$VR_B_RT_Validity,
    res$R_RT_Disengaging,
    res$VR_B_RT_Disengaging,
    res$R_RT_Moving_Engaging,
    res$VR_B_RT_Moving_Engaging,
    res$R_RT_OrientingTime,
    res$VR_B_RT_OrientingTime,
    res$R_RT_FlankerConflict,
    res$VR_B_RT_FlankerConflict,
    res$R_RT_LocationConflict,
    res$VR_B_RT_LocationConflict,
    res$R_RT_FlankerByLocation,
    res$VR_B_RT_FlankerByLocation,
    res$R_RT_AlertingByFlanker,
    res$VR_B_RT_AlertingByFlanker,
    res$R_RT_OrientingByFlanker,
    res$VR_B_RT_OrientingByFlanker,
    res$R_RT_ValidityByFlanker,
    res$VR_B_RT_ValidityByFlanker,
    res$R_RT_AlertingByLocation,
    res$VR_B_RT_AlertingByLocation,
    res$R_RT_OrientingByLocation,
    res$VR_B_RT_OrientingByLocation,
    res$R_RT_ValidityByLocation,
    res$VR_B_RT_ValidityByLocation,
    res$R_RT_IOR,
    res$VR_B_RT_IOR,
    res$R_RT,
    res$VR_B_RT,
    "ANT-R",
    "ANT-VR Balanced",
    "RT"
  )

  writeLines(
    "----------------------------------------------------------------------------"
  )
  sink()
}

printPairwiseCorrelation_R_VR_Balanced_ACC <- function(res) {
  pathToOutputFile <- getPath("../../../Results/PairwiseCorrelationTable_R_VR_Balanced_ACC.txt")

  sink(
    file = pathToOutputFile,
    append = FALSE,
    type = "output",
    split = FALSE
  )

  writeLines(
    "----------------------------------------------------------------------------"
  )
  writeLines("Pairwise correlation between ANT-R and ANT-VR Balanced (ACC)")

  pwc_R_VR_B_ACC <- getPairwiseCorrelation(
    res$R_ACC_Alerting,
    res$VR_B_ACC_Alerting,
    res$R_ACC_Validity,
    res$VR_B_ACC_Validity,
    res$R_ACC_Disengaging,
    res$VR_B_ACC_Disengaging,
    res$R_ACC_Moving_Engaging,
    res$VR_B_ACC_Moving_Engaging,
    res$R_ACC_OrientingTime,
    res$VR_B_ACC_OrientingTime,
    res$R_ACC_FlankerConflict,
    res$VR_B_ACC_FlankerConflict,
    res$R_ACC_LocationConflict,
    res$VR_B_ACC_LocationConflict,
    res$R_ACC_FlankerByLocation,
    res$VR_B_ACC_FlankerByLocation,
    res$R_ACC_AlertingByFlanker,
    res$VR_B_ACC_AlertingByFlanker,
    res$R_ACC_OrientingByFlanker,
    res$VR_B_ACC_OrientingByFlanker,
    res$R_ACC_ValidityByFlanker,
    res$VR_B_ACC_ValidityByFlanker,
    res$R_ACC_AlertingByLocation,
    res$VR_B_ACC_AlertingByLocation,
    res$R_ACC_OrientingByLocation,
    res$VR_B_ACC_OrientingByLocation,
    res$R_ACC_ValidityByLocation,
    res$VR_B_ACC_ValidityByLocation,
    res$R_ACC_IOR,
    res$VR_B_ACC_IOR,
    res$R_ACC,
    res$VR_B_ACC,
    "ANT-R",
    "ANT-VR Balanced",
    "ACC"
  )

  writeLines(
    "----------------------------------------------------------------------------"
  )
  sink()
}

printPairwiseCorrelation_VR_VR_Balanced_RT <- function(res) {
  pathToOutputFile <- getPath("../../../Results/PairwiseCorrelationTable_VR_VR_Balanced_RT.txt")

  sink(
    file = pathToOutputFile,
    append = FALSE,
    type = "output",
    split = FALSE
  )

  writeLines(
    "----------------------------------------------------------------------------"
  )
  writeLines("Pairwise correlation between ANT-VR and ANT-VR Balanced (RT)")

  pwc_VR_VR_B_RT <- getPairwiseCorrelation(
    res$VR_RT_Alerting,
    res$VR_B_RT_Alerting,
    res$VR_RT_Validity,
    res$VR_B_RT_Validity,
    res$VR_RT_Disengaging,
    res$VR_B_RT_Disengaging,
    res$VR_RT_Moving_Engaging,
    res$VR_B_RT_Moving_Engaging,
    res$VR_RT_OrientingTime,
    res$VR_B_RT_OrientingTime,
    res$VR_RT_FlankerConflict,
    res$VR_B_RT_FlankerConflict,
    res$VR_RT_LocationConflict,
    res$VR_B_RT_LocationConflict,
    res$VR_RT_FlankerByLocation,
    res$VR_B_RT_FlankerByLocation,
    res$VR_RT_AlertingByFlanker,
    res$VR_B_RT_AlertingByFlanker,
    res$VR_RT_OrientingByFlanker,
    res$VR_B_RT_OrientingByFlanker,
    res$VR_RT_ValidityByFlanker,
    res$VR_B_RT_ValidityByFlanker,
    res$VR_RT_AlertingByLocation,
    res$VR_B_RT_AlertingByLocation,
    res$VR_RT_OrientingByLocation,
    res$VR_B_RT_OrientingByLocation,
    res$VR_RT_ValidityByLocation,
    res$VR_B_RT_ValidityByLocation,
    res$VR_RT_IOR,
    res$VR_B_RT_IOR,
    res$VR_RT,
    res$VR_B_RT,
    "ANT-VR",
    "ANT-VR Balanced",
    "RT"
  )

  writeLines(
    "----------------------------------------------------------------------------"
  )
  sink()
}

printPairwiseCorrelation_VR_VR_Balanced_ACC <- function(res) {
  pathToOutputFile <- getPath("../../../Results/PairwiseCorrelationTable_VR_VR_Balanced_ACC.txt")

  sink(
    file = pathToOutputFile,
    append = FALSE,
    type = "output",
    split = FALSE
  )

  writeLines(
    "----------------------------------------------------------------------------"
  )
  writeLines("Pairwise correlation between ANT-VR and ANT-VR Balanced (ACC)")

  pwc_VR_VR_B_ACC <- getPairwiseCorrelation(
    res$VR_ACC_Alerting,
    res$VR_B_ACC_Alerting,
    res$VR_ACC_Validity,
    res$VR_B_ACC_Validity,
    res$VR_ACC_Disengaging,
    res$VR_B_ACC_Disengaging,
    res$VR_ACC_Moving_Engaging,
    res$VR_B_ACC_Moving_Engaging,
    res$VR_ACC_OrientingTime,
    res$VR_B_ACC_OrientingTime,
    res$VR_ACC_FlankerConflict,
    res$VR_B_ACC_FlankerConflict,
    res$VR_ACC_LocationConflict,
    res$VR_B_ACC_LocationConflict,
    res$VR_ACC_FlankerByLocation,
    res$VR_B_ACC_FlankerByLocation,
    res$VR_ACC_AlertingByFlanker,
    res$VR_B_ACC_AlertingByFlanker,
    res$VR_ACC_OrientingByFlanker,
    res$VR_B_ACC_OrientingByFlanker,
    res$VR_ACC_ValidityByFlanker,
    res$VR_B_ACC_ValidityByFlanker,
    res$VR_ACC_AlertingByLocation,
    res$VR_B_ACC_AlertingByLocation,
    res$VR_ACC_OrientingByLocation,
    res$VR_B_ACC_OrientingByLocation,
    res$VR_ACC_ValidityByLocation,
    res$VR_B_ACC_ValidityByLocation,
    res$VR_ACC_IOR,
    res$VR_B_ACC_IOR,
    res$VR_ACC,
    res$VR_B_ACC,
    "ANT-VR",
    "ANT-VR Balanced",
    "ACC"
  )

  writeLines(
    "----------------------------------------------------------------------------"
  )
  sink()
}

printAnalysis <- function() {
  demoGraphics_All <- importDemographicsAndQoE_All()
  results_All <- getResults_All()

  printDescriptiveStatisticsForDemographics(demoGraphics_All)
  printNetworkAndInteractionEffects(results_All)
  printAlertingByConflict_ANOVAs(results_All)
  printOrientingByConflict_ANOVAs(results_All)
  printValidityByConflict_ANOVAs(results_All)
  printPearsonCorrelationTables(results_All)
  printPairwiseCorrelation_R_VR_RT(results_All)
  printPairwiseCorrelation_R_VR_Balanced_RT(results_All)
  printPairwiseCorrelation_VR_VR_Balanced_RT(results_All)
  printPairwiseCorrelation_R_VR_ACC(results_All)
  printPairwiseCorrelation_R_VR_Balanced_ACC(results_All)
  printPairwiseCorrelation_VR_VR_Balanced_ACC(results_All)
  printAllMissedTrialsAll()
}

printAnalysis()

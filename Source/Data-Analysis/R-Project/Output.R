if (!require(renv)) {
  install.packages("renv")
}

library(renv)

options(scipen = 999)

# Tables

# Demographics
getDemographicsTable <- function(descriptiveStatisticsForDemographics) {
  if (!require(dplyr)) {
    install.packages("dplyr")
  }
  if (!require(papaja)) {
    install.packages("papaja")
  }
  if (!require(psych)) {
    install.packages("psych")
  }
  library(dplyr)
  library(papaja)
  library(psych)

  demographics <- dplyr::select(
    descriptiveStatisticsForDemographics,
    c(
      "Gender",
      "Education",
      "Nationality",
      "Handedness",
      "TimeOfDay"
    )
  )

  n <- nrow(demographics)

  genderNumber <- summary(descriptiveStatisticsForDemographics$Gender)
  genderProportions <- prop.table(table(descriptiveStatisticsForDemographics$Gender))
  genderNumberOfRows <- length(genderProportions)
  genderNames <- names(genderProportions)

  educationNumber <- summary(descriptiveStatisticsForDemographics$Education)
  educationProportions <- prop.table(table(descriptiveStatisticsForDemographics$Education))
  educationNumberOfRows <- length(educationProportions)
  educationNames <- names(educationProportions)

  nationalityNumber <- summary(descriptiveStatisticsForDemographics$Nationality)
  nationalityProportions <- prop.table(table(descriptiveStatisticsForDemographics$Nationality))
  nationalityNumberOfRows <- length(nationalityProportions)
  nationalityNames <- names(nationalityProportions)

  handednessNumber <- summary(descriptiveStatisticsForDemographics$Handedness)
  handednessProportions <- prop.table(table(descriptiveStatisticsForDemographics$Handedness))
  handednessNumberOfRows <- length(handednessProportions)
  handednessNames <- names(handednessProportions)

  timeOfDayNumber <- summary(descriptiveStatisticsForDemographics$TimeOfDay)
  timeOfDayProportions <- prop.table(table(descriptiveStatisticsForDemographics$TimeOfDay))
  timeOfDayNumberOfRows <- length(timeOfDayProportions)
  timeOfDayNames <- names(timeOfDayProportions)

  description <- data.frame(
    Number = numeric(),
    Percentage = numeric(),
    stringsAsFactors = FALSE
  )
  rownames <- c()

  for (i in 1:genderNumberOfRows)
  {
    newRow <- c(genderNumber[i], genderProportions[i] * 100)
    description <- rbind(description, newRow)
    rownames <- append(rownames, genderNames[i])
  }

  for (i in 1:educationNumberOfRows)
  {
    newRow <- c(educationNumber[i], educationProportions[i] * 100)
    description <- rbind(description, newRow)
    rownames <- append(rownames, educationNames[i])
  }

  otherNationalitiesNumber <- 0
  otherNationalitiesProportions <- 0

  for (i in 1:nationalityNumberOfRows)
  {
    nNumber <- nationalityNumber[i]
    nProportions <- nationalityProportions[i]

    if (nNumber > 1) {
      newRow <- c(nNumber, nProportions * 100)
      description <- rbind(description, newRow)
      rownames <- append(rownames, nationalityNames[i])
    } else {
      otherNationalitiesNumber <- otherNationalitiesNumber + 1
      otherNationalitiesProportions <- otherNationalitiesProportions + nProportions
    }
  }

  if (otherNationalitiesNumber > 0) {
    newRow <- c(
      otherNationalitiesNumber,
      otherNationalitiesProportions * 100
    )
    description <- rbind(description, newRow)
    rownames <- append(rownames, "Other")
    nationalityNumberOfRows <- nationalityNumberOfRows - otherNationalitiesNumber + 1
  }

  for (i in 1:handednessNumberOfRows)
  {
    newRow <- c(handednessNumber[i], handednessProportions[i] * 100)
    description <- rbind(description, newRow)
    rownames <- append(rownames, handednessNames[i])
  }

  for (i in 1:timeOfDayNumberOfRows)
  {
    newRow <- c(timeOfDayNumber[i], timeOfDayProportions[i] * 100)
    description <- rbind(description, newRow)
    rownames <- append(rownames, timeOfDayNames[i])
  }

  colnames(description) <- c("Number", "Percentage")
  rownames(description) <- rownames

  papaja::apa_table(
    description,
    note = paste("n = ", n, ".", sep = ""),
    digits = c(2, 0),
    stub_indents = list(
      "Gender" = c(1, genderNumberOfRows),
      "Education" = c((genderNumberOfRows + 1):(genderNumberOfRows + educationNumberOfRows)),
      "Nationality" = c((genderNumberOfRows + educationNumberOfRows + 1):(
        genderNumberOfRows + educationNumberOfRows + nationalityNumberOfRows
      )),
      "Handedness" = c((
        genderNumberOfRows + educationNumberOfRows + nationalityNumberOfRows + 1
      ):(
        genderNumberOfRows + educationNumberOfRows + nationalityNumberOfRows + handednessNumberOfRows
      )),
      "Time Of Day" = c((
        genderNumberOfRows + educationNumberOfRows + nationalityNumberOfRows + handednessNumberOfRows + 1
      ):(
        genderNumberOfRows + educationNumberOfRows + nationalityNumberOfRows + handednessNumberOfRows + timeOfDayNumberOfRows
      ))
    )
  )
}

getDemographicsTable_All <- function() {
  demoGraphics_All <- importDemographicsAndQoE_All()
  demoGraphics <- getDescriptiveStatisticsForDemographics(demoGraphics_All)
  getDemographicsTable(demoGraphics)
}

# Age
getAgePlot <- function(res) {
  if (!require(RColorBrewer)) {
    install.packages("RColorBrewer")
  }
  if (!require(ggplot2)) {
    install.packages("ggplot2")
  }
  if (!require(psych)) {
    install.packages("psych")
  }
  if (!require(ggrepel)) {
    install.packages("ggrepel")
  }
  if (!require(tidyverse)) {
    install.packages("tidyverse")
  }
  library(RColorBrewer)
  library(ggplot2)
  library(psych)
  library(ggrepel)
  library(tidyverse)

  nres <- nrow(res)
  resAge <- res$Age

  ageMean <- getRoundedValue(psych::describe(resAge)$mean[1], 1)
  ageSD <- getRoundedValue(psych::describe(resAge)$sd[1], 1)
  tableAge <- table(resAge)
  dfAge <- data.frame(tableAge)

  fillColorPalette <- colorRampPalette(colors = brewer.pal(9, "PuBu"))
  fillColors <- fillColorPalette(nrow(dfAge))
  labelColors <- rep("black", nrow(dfAge) * 2 / 3)
  index <- nrow(dfAge) * 2 / 3

  while (index < nrow(dfAge)) {
    labelColors <- append(labelColors, "white")
    index <- index + 1
  }

  pie <- (
    ggplot(dfAge, aes(
      x = "", y = Freq, fill = resAge
    )) +
      geom_bar(width = 1, stat = "identity") +
      coord_polar("y", start = 0) +
      scale_fill_manual(values = fillColors) +
      geom_text(
        aes(label = Freq),
        color = labelColors,
        position = position_stack(vjust = 0.5),
        size = 2.5
      ) +
      guides(fill = guide_legend(title = "Age (years)", ncol = 2)) +
      labs(
        caption = paste("Note. n = ", nres, ", M = ", ageMean, ", SD = ", ageSD, sep = ""),
        x = "",
        y = ""
      ) +
      theme(
        axis.text = element_blank(),
        axis.text.y = element_text(hjust = 0),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        legend.key.size = unit(3, "mm"),
        legend.text = element_text(size = 4),
        legend.title = element_text(size = 8),
        plot.title = element_text(
          face = "bold",
          hjust = 0,
          size = 11
        ),
        plot.caption = element_text(face = "italic", hjust = 0)
      )
  )

  return(pie)
}

################################################################################

# Gender
getGenderPlot <- function(res) {
  if (!require(RColorBrewer)) {
    install.packages("RColorBrewer")
  }
  if (!require(ggplot2)) {
    install.packages("ggplot2")
  }
  if (!require(psych)) {
    install.packages("psych")
  }
  if (!require(ggrepel)) {
    install.packages("ggrepel")
  }
  if (!require(tidyverse)) {
    install.packages("tidyverse")
  }
  library(RColorBrewer)
  library(ggplot2)
  library(psych)
  library(ggrepel)
  library(tidyverse)

  nres <- nrow(res)

  res$Gender <- replace(res$Gender, res$Gender == "Male", "cis-male")
  res$Gender <- replace(res$Gender, res$Gender == "Female", "cis-female")
  resGender <- res$Gender
  tableGender <- table(resGender)
  dfGender <- data.frame(tableGender)

  fillColorPalette <- colorRampPalette(colors = brewer.pal(9, "PuBu"))
  fillColors <- fillColorPalette(nrow(dfGender))
  labelColors <- rep("black", nrow(dfGender) * 2 / 3)
  index <- nrow(dfGender) * 2 / 3

  while (index < nrow(dfGender)) {
    labelColors <- append(labelColors, "white")
    index <- index + 1
  }

  pie <- (
    ggplot(dfGender, aes(
      x = "", y = Freq, fill = resGender
    )) +
      geom_bar(width = 1, stat = "identity") +
      coord_polar("y", start = 0) +
      scale_fill_manual(values = fillColors) +
      geom_text(
        aes(label = Freq),
        color = labelColors,
        position = position_stack(vjust = 0.5),
        size = 2.5
      ) +
      guides(fill = guide_legend(title = "Gender")) +
      labs(
        caption = paste("Note. n = ", nres, sep = ""),
        x = "",
        y = ""
      ) +
      theme(
        axis.text = element_blank(),
        axis.text.y = element_text(hjust = 0),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        legend.key.size = unit(3, "mm"),
        legend.text = element_text(size = 4),
        legend.title = element_text(size = 8),
        plot.title = element_text(
          face = "bold",
          hjust = 0,
          size = 11
        ),
        plot.caption = element_text(face = "italic", hjust = 0)
      )
  )

  return(pie)
}

################################################################################

# Education
getEducationPlot <- function(res) {
  if (!require(RColorBrewer)) {
    install.packages("RColorBrewer")
  }
  if (!require(ggplot2)) {
    install.packages("ggplot2")
  }
  if (!require(psych)) {
    install.packages("psych")
  }
  if (!require(ggrepel)) {
    install.packages("ggrepel")
  }
  if (!require(tidyverse)) {
    install.packages("tidyverse")
  }
  library(RColorBrewer)
  library(ggplot2)
  library(psych)
  library(ggrepel)
  library(tidyverse)

  nres <- nrow(res)
  resEducation <- res$Education
  tableEducation <- table(resEducation)
  dfEducation <- data.frame(tableEducation)

  fillColorPalette <- colorRampPalette(colors = brewer.pal(9, "PuBu"))
  fillColors <- fillColorPalette(nrow(dfEducation))
  labelColors <- rep("black", nrow(dfEducation) * 2 / 3)
  index <- nrow(dfEducation) * 2 / 3

  while (index < nrow(dfEducation)) {
    labelColors <- append(labelColors, "white")
    index <- index + 1
  }

  pie <- (
    ggplot(dfEducation, aes(
      x = "", y = Freq, fill = resEducation
    )) +
      geom_bar(width = 1, stat = "identity") +
      coord_polar("y", start = 0) +
      scale_fill_manual(values = fillColors) +
      geom_text(
        aes(label = Freq),
        color = labelColors,
        position = position_stack(vjust = 0.5),
        size = 2.5
      ) +
      guides(fill = guide_legend(title = "Education")) +
      labs(
        caption = paste("Note. n = ", nres, sep = ""),
        x = "",
        y = ""
      ) +
      theme(
        axis.text = element_blank(),
        axis.text.y = element_text(hjust = 0),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        legend.key.size = unit(3, "mm"),
        legend.text = element_text(size = 4),
        legend.title = element_text(size = 8),
        plot.title = element_text(
          face = "bold",
          hjust = 0,
          size = 11
        ),
        plot.caption = element_text(face = "italic", hjust = 0)
      )
  )

  return(pie)
}

################################################################################

# Nationality
getNationalityPlot <- function(res) {
  if (!require(RColorBrewer)) {
    install.packages("RColorBrewer")
  }
  if (!require(ggplot2)) {
    install.packages("ggplot2")
  }
  if (!require(psych)) {
    install.packages("psych")
  }
  if (!require(ggrepel)) {
    install.packages("ggrepel")
  }
  if (!require(tidyverse)) {
    install.packages("tidyverse")
  }
  library(RColorBrewer)
  library(ggplot2)
  library(psych)
  library(ggrepel)
  library(tidyverse)

  nres <- nrow(res)
  resNationality <- res$Nationality
  tableNationality <- table(resNationality)
  dfNationality <- data.frame(tableNationality)

  fillColorPalette <- colorRampPalette(colors = brewer.pal(9, "PuBu"))
  fillColors <- fillColorPalette(nrow(dfNationality))
  labelColors <- rep("black", nrow(dfNationality) * 2 / 3)
  index <- nrow(dfNationality) * 2 / 3

  while (index < nrow(dfNationality)) {
    labelColors <- append(labelColors, "white")
    index <- index + 1
  }

  pie <- (
    ggplot(dfNationality, aes(
      x = "", y = Freq, fill = resNationality
    )) +
      geom_bar(width = 1, stat = "identity") +
      coord_polar("y", start = 0) +
      scale_fill_manual(values = fillColors) +
      geom_text(
        aes(label = Freq),
        color = labelColors,
        position = position_stack(vjust = 0.5),
        size = 2.5
      ) +
      guides(fill = guide_legend(title = "Nationality", ncol = 2)) +
      labs(
        caption = paste("Note. n = ", nres, sep = ""),
        x = "",
        y = ""
      ) +
      theme(
        axis.text = element_blank(),
        axis.text.y = element_text(hjust = 0),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        legend.key.size = unit(3, "mm"),
        legend.text = element_text(size = 4),
        legend.title = element_text(size = 8),
        plot.title = element_text(
          face = "bold",
          hjust = 0,
          size = 11
        ),
        plot.caption = element_text(face = "italic", hjust = 0)
      )
  )

  return(pie)
}

################################################################################

# Handedness
getHandednessPlot <- function(res) {
  if (!require(RColorBrewer)) {
    install.packages("RColorBrewer")
  }
  if (!require(ggplot2)) {
    install.packages("ggplot2")
  }
  if (!require(psych)) {
    install.packages("psych")
  }
  if (!require(ggrepel)) {
    install.packages("ggrepel")
  }
  if (!require(tidyverse)) {
    install.packages("tidyverse")
  }
  library(RColorBrewer)
  library(ggplot2)
  library(psych)
  library(ggrepel)
  library(tidyverse)

  nres <- nrow(res)
  resHandedness <- res$Handedness
  tableHandedness <- table(resHandedness)
  dfHandedness <- data.frame(tableHandedness)

  fillColorPalette <- colorRampPalette(colors = brewer.pal(9, "PuBu"))
  fillColors <- fillColorPalette(nrow(dfHandedness))
  labelColors <- rep("black", nrow(dfHandedness) * 2 / 3)
  index <- nrow(dfHandedness) * 2 / 3

  while (index < nrow(dfHandedness)) {
    labelColors <- append(labelColors, "white")
    index <- index + 1
  }

  pie <- (
    ggplot(dfHandedness, aes(
      x = "", y = Freq, fill = resHandedness
    )) +
      geom_bar(width = 1, stat = "identity") +
      coord_polar("y", start = 0) +
      scale_fill_manual(values = fillColors) +
      geom_text(
        aes(label = Freq),
        color = labelColors,
        position = position_stack(vjust = 0.5),
        size = 2.5
      ) +
      guides(fill = guide_legend(title = "Handedness")) +
      labs(
        caption = paste("Note. n = ", nres, sep = ""),
        x = "",
        y = ""
      ) +
      theme(
        axis.text = element_blank(),
        axis.text.y = element_text(hjust = 0),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        legend.key.size = unit(3, "mm"),
        legend.text = element_text(size = 4),
        legend.title = element_text(size = 8),
        plot.title = element_text(
          face = "bold",
          hjust = 0,
          size = 11
        ),
        plot.caption = element_text(face = "italic", hjust = 0)
      )
  )

  return(pie)
}

################################################################################

# TimeOfDay
getTimeOfDayPlot <- function(res) {
  if (!require(RColorBrewer)) {
    install.packages("RColorBrewer")
  }
  if (!require(ggplot2)) {
    install.packages("ggplot2")
  }
  if (!require(psych)) {
    install.packages("psych")
  }
  if (!require(ggrepel)) {
    install.packages("ggrepel")
  }
  if (!require(tidyverse)) {
    install.packages("tidyverse")
  }
  library(RColorBrewer)
  library(ggplot2)
  library(psych)
  library(ggrepel)
  library(tidyverse)

  nres <- nrow(res)
  resTimeOfDay <- res$TimeOfDay
  tableTimeOfDay <- table(resTimeOfDay)
  dfTimeOfDay <- data.frame(tableTimeOfDay)

  fillColorPalette <- colorRampPalette(colors = brewer.pal(9, "PuBu"))
  fillColors <- fillColorPalette(nrow(dfTimeOfDay))
  labelColors <- rep("black", nrow(dfTimeOfDay) * 2 / 3)
  index <- nrow(dfTimeOfDay) * 2 / 3

  while (index < nrow(dfTimeOfDay)) {
    labelColors <- append(labelColors, "white")
    index <- index + 1
  }

  pie <- (
    ggplot(dfTimeOfDay, aes(
      x = "", y = Freq, fill = resTimeOfDay
    )) +
      geom_bar(width = 1, stat = "identity") +
      coord_polar("y", start = 0) +
      scale_fill_manual(values = fillColors) +
      geom_text(
        aes(label = Freq),
        color = labelColors,
        position = position_stack(vjust = 0.5),
        size = 2.5
      ) +
      guides(fill = guide_legend(title = "Time of Day")) +
      labs(
        caption = paste("Note. n = ", nres, sep = ""),
        x = "",
        y = ""
      ) +
      theme(
        axis.text = element_blank(),
        axis.text.y = element_text(hjust = 0),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        legend.key.size = unit(3, "mm"),
        legend.text = element_text(size = 4),
        legend.title = element_text(size = 8),
        plot.title = element_text(
          face = "bold",
          hjust = 0,
          size = 11
        ),
        plot.caption = element_text(face = "italic", hjust = 0)
      )
  )

  return(pie)
}

################################################################################

getGenderAndAgePlot_All <- function(res) {
  if (!require(ggpubr)) {
    install.packages("ggpubr")
  }
  library(ggpubr)

  res <- getResults_All()
  genderPlot <- getGenderPlot(res)
  agePlot <- getAgePlot(res)

  return(
    ggarrange(
      genderPlot,
      agePlot,
      labels = c("a)", "b)"),
      align = "hv",
      ncol = 2,
      nrow = 2,
      font.label = list(size = 11, face = "plain")
    )
  )
}

getEdNaHaToDPlot_All <- function(res) {
  if (!require(ggpubr)) {
    install.packages("ggpubr")
  }
  library(ggpubr)

  res <- getResults_All()
  educationPlot <- getEducationPlot(res)
  nationalityPlot <- getNationalityPlot(res)
  handednessPlot <- getHandednessPlot(res)
  todPlot <- getTimeOfDayPlot(res)

  return(
    ggarrange(
      educationPlot,
      nationalityPlot,
      handednessPlot,
      todPlot,
      labels = c("a)", "b)", "c)", "d)"),
      align = "hv",
      ncol = 2,
      nrow = 2,
      font.label = list(size = 11, face = "plain")
    )
  )
}

################################################################################

getQualityOfExperience <- function(res) {
  if (!require(likert)) {
    install.packages("likert")
  }

  library(likert)


  multiplier <- 100 / length(res$QoE_PQ)

  vote_PQ <- tabulate(res$QoE_PQ)
  vote_RQ <- tabulate(res$QoE_RQ)
  vote_TQ <- tabulate(res$QoE_TQ)
  vote_CQ <- tabulate(res$QoE_CQ)
  vote_IQ <- tabulate(res$QoE_IQ)
  vote_OQ <- tabulate(res$QoE_OQ)

  bad <- (c(vote_PQ[1], vote_RQ[1], vote_TQ[1], vote_CQ[1], vote_IQ[1], vote_OQ[1]) * multiplier)
  poor <- (c(vote_PQ[2], vote_RQ[2], vote_TQ[2], vote_CQ[2], vote_IQ[2], vote_OQ[2]) * multiplier)
  fair <- (c(vote_PQ[3], vote_RQ[3], vote_TQ[3], vote_CQ[3], vote_IQ[3], vote_OQ[3]) * multiplier)
  good <- (c(vote_PQ[4], vote_RQ[4], vote_TQ[4], vote_CQ[4], vote_IQ[4], vote_OQ[4]) * multiplier)
  excellent <- (c(vote_PQ[5], vote_RQ[5], vote_TQ[5], vote_CQ[5], vote_IQ[5], vote_OQ[5]) * multiplier)

  Item <- c(
    "How would you rate the picture quality?",
    "How would you rate the responsiveness of the system?",
    "How would you rate your ability to accomplish the VR attention task using the controllers?",
    "How would you rate your comfort?",
    "How would you rate the immersion of the experience?",
    "How would you rate your overall experience?"
  )

  qoe <- data.frame(Item, bad, poor, fair, good, excellent)

  plot(
    likert(summary = qoe),
    centered = FALSE,
    plot.percent.neutral = FALSE,
    plot.percent.low = FALSE,
    plot.percent.high = FALSE,
    legend.position = "right"
  ) +
    scale_fill_manual(values = gray.colors(n = 5), breaks = c("bad", "poor", "fair", "good", "excellent"), labels = function(x) {
      sapply(x, function(y) {
        paste0(toupper(substr(y, 1, 1)), substr(y, 2, nchar(y)))
      })
    }) +
    theme(axis.title = element_text(face = "bold")) +
    theme(text = element_text(family = "Times")) +
    guides(fill = guide_legend(title = "Responses", reverse = FALSE))
}

getQualityOfExperience_All <- function() {
  res <- getResults_All()
  getQualityOfExperience(res)
}

# Network and Interaction Effects
getNetworkAndInteractionEffects <- function(RT_Alerting,
                                            ACC_Alerting,
                                            RT_Validity,
                                            ACC_Validity,
                                            RT_Disengaging,
                                            ACC_Disengaging,
                                            RT_Moving_Engaging,
                                            ACC_Moving_Engaging,
                                            RT_OrientingTime,
                                            ACC_OrientingTime,
                                            RT_FlankerConflict,
                                            ACC_FlankerConflict,
                                            RT_LocationConflict,
                                            ACC_LocationConflict,
                                            RT_FlankerByLocation,
                                            ACC_FlankerByLocation,
                                            RT_AlertingByFlanker,
                                            ACC_AlertingByFlanker,
                                            RT_OrientingByFlanker,
                                            ACC_OrientingByFlanker,
                                            RT_ValidityByFlanker,
                                            ACC_ValidityByFlanker,
                                            RT_AlertingByLocation,
                                            ACC_AlertingByLocation,
                                            RT_OrientingByLocation,
                                            ACC_OrientingByLocation,
                                            RT_ValidityByLocation,
                                            ACC_ValidityByLocation,
                                            RT_IOR,
                                            ACC_IOR,
                                            RT,
                                            ACC,
                                            experimentName) {
  if (!require(dplyr)) {
    install.packages("dplyr")
  }
  if (!require(papaja)) {
    install.packages("papaja")
  }
  if (!require(psych)) {
    install.packages("psych")
  }
  library(dplyr)
  library(papaja)
  library(psych)

  alerting <- getNetworkAndInteractionEffect(RT_Alerting, ACC_Alerting)
  validity <- getNetworkAndInteractionEffect(RT_Validity, ACC_Validity)
  disengaging <- getNetworkAndInteractionEffect(RT_Disengaging, ACC_Disengaging)
  moving_engaging <- getNetworkAndInteractionEffect(RT_Moving_Engaging, ACC_Moving_Engaging)
  orientingTime <- getNetworkAndInteractionEffect(RT_OrientingTime, ACC_OrientingTime)
  flankerConflict <- getNetworkAndInteractionEffect(RT_FlankerConflict, ACC_FlankerConflict)
  locationConflict <- getNetworkAndInteractionEffect(RT_LocationConflict, ACC_LocationConflict)
  flankerByLocation <- getNetworkAndInteractionEffect(RT_FlankerByLocation, ACC_FlankerByLocation)
  alertingByFlanker <- getNetworkAndInteractionEffect(RT_AlertingByFlanker, ACC_AlertingByFlanker)
  orientingByFlanker <- getNetworkAndInteractionEffect(RT_OrientingByFlanker, ACC_OrientingByFlanker)
  validityByFlanker <- getNetworkAndInteractionEffect(RT_ValidityByFlanker, ACC_ValidityByFlanker)
  alertingByLocation <- getNetworkAndInteractionEffect(RT_AlertingByLocation, ACC_AlertingByLocation)
  orientingByLocation <- getNetworkAndInteractionEffect(RT_OrientingByLocation, ACC_OrientingByLocation)
  validityByLocation <- getNetworkAndInteractionEffect(RT_ValidityByLocation, ACC_ValidityByLocation)
  ior <- getNetworkAndInteractionEffect(RT_IOR, ACC_IOR)
  overall <- getNetworkAndInteractionEffect(RT, ACC)

  nies <- data.frame(
    RT_mean = character(),
    RT_sd = character(),
    RT_Tt = character(),
    RT_CohensD = character(),
    ACC_mean = character(),
    ACC_sd = character(),
    ACC_Tt = character(),
    ACC_CohensD = character(),
    stringsAsFactors = FALSE
  )
  nies <- rbind(nies, alerting)
  nies <- rbind(nies, validity)
  nies <- rbind(nies, disengaging)
  nies <- rbind(nies, moving_engaging)
  nies <- rbind(nies, orientingTime)
  nies <- rbind(nies, flankerConflict)
  nies <- rbind(nies, locationConflict)
  nies <- rbind(nies, flankerByLocation)
  nies <- rbind(nies, alertingByFlanker)
  nies <- rbind(nies, orientingByFlanker)
  nies <- rbind(nies, validityByFlanker)
  nies <- rbind(nies, alertingByLocation)
  nies <- rbind(nies, orientingByLocation)
  nies <- rbind(nies, validityByLocation)
  nies <- rbind(nies, ior)
  nies <- rbind(nies, overall)

  rownames(nies) <- c(
    "Alerting Benefit",
    "Validity Effect",
    "Disengaging Cost",
    "Moving + Engaging",
    "Orienting Time",
    "Flanker Conflict Effect",
    "Location Conflict Effect",
    "Flanker by Location Interaction",
    "Alerting by Flanker Conflict",
    "Orienting by Flanker Conflict",
    "Validity by Flanker Conflict",
    "Alerting by Location Conflict",
    "Orienting by Location Conflict",
    "Validity by Location Conflict",
    "Inhibition of Return Effect",
    "Overall"
  )
  colnames(nies) <- c("Mean", "SD", "t", "Cohen's D", "Mean", "SD", "t", "Cohen's D")

  papaja::apa_table(
    nies,
    align = c("l", "r", "r", "r", "r", "r", "r", "r", "r"),
    note = paste(
      "* indicates p < .05, ** indicates p < .01, *** indicates p < .001",
      sep = ""
    ),
    font_size = "footnotesize",
    col_spanners = list(
      "Reaction Time" = c(2, 5),
      "Accuracy" = c(6, 9)
    )
  )
}

getNetworkAndInteractionEffects_ANT_R <- function(res) {
  getNetworkAndInteractionEffects(
    res$R_RT_Alerting,
    res$R_ACC_Alerting,
    res$R_RT_Validity,
    res$R_ACC_Validity,
    res$R_RT_Disengaging,
    res$R_ACC_Disengaging,
    res$R_RT_Moving_Engaging,
    res$R_ACC_Moving_Engaging,
    res$R_RT_OrientingTime,
    res$R_ACC_OrientingTime,
    res$R_RT_FlankerConflict,
    res$R_ACC_FlankerConflict,
    res$R_RT_LocationConflict,
    res$R_ACC_LocationConflict,
    res$R_RT_FlankerByLocation,
    res$R_ACC_FlankerByLocation,
    res$R_RT_AlertingByFlanker,
    res$R_ACC_AlertingByFlanker,
    res$R_RT_OrientingByFlanker,
    res$R_ACC_OrientingByFlanker,
    res$R_RT_ValidityByFlanker,
    res$R_ACC_ValidityByFlanker,
    res$R_RT_AlertingByLocation,
    res$R_ACC_AlertingByLocation,
    res$R_RT_OrientingByLocation,
    res$R_ACC_OrientingByLocation,
    res$R_RT_ValidityByLocation,
    res$R_ACC_ValidityByLocation,
    res$R_RT_IOR,
    res$R_ACC_IOR,
    res$R_RT,
    res$R_ACC,
    "ANT-R"
  )
}

getNetworkAndInteractionEffects_ANT_R_All <- function() {
  res <- getResults_All()
  getNetworkAndInteractionEffects_ANT_R(res)
}

getNetworkAndInteractionEffects_ANT_VR <- function(res) {
  getNetworkAndInteractionEffects(
    res$VR_RT_Alerting,
    res$VR_ACC_Alerting,
    res$VR_RT_Validity,
    res$VR_ACC_Validity,
    res$VR_RT_Disengaging,
    res$VR_ACC_Disengaging,
    res$VR_RT_Moving_Engaging,
    res$VR_ACC_Moving_Engaging,
    res$VR_RT_OrientingTime,
    res$VR_ACC_OrientingTime,
    res$VR_RT_FlankerConflict,
    res$VR_ACC_FlankerConflict,
    res$VR_RT_LocationConflict,
    res$VR_ACC_LocationConflict,
    res$VR_RT_FlankerByLocation,
    res$VR_ACC_FlankerByLocation,
    res$VR_RT_AlertingByFlanker,
    res$VR_ACC_AlertingByFlanker,
    res$VR_RT_OrientingByFlanker,
    res$VR_ACC_OrientingByFlanker,
    res$VR_RT_ValidityByFlanker,
    res$VR_ACC_ValidityByFlanker,
    res$VR_RT_AlertingByLocation,
    res$VR_ACC_AlertingByLocation,
    res$VR_RT_OrientingByLocation,
    res$VR_ACC_OrientingByLocation,
    res$VR_RT_ValidityByLocation,
    res$VR_ACC_ValidityByLocation,
    res$VR_RT_IOR,
    res$VR_ACC_IOR,
    res$VR_RT,
    res$VR_ACC,
    "ANT-VR"
  )
}

getNetworkAndInteractionEffects_ANT_VR_All <- function() {
  res <- getResults_All()
  getNetworkAndInteractionEffects_ANT_VR(res)
}

getNetworkAndInteractionEffects_ANT_VR_B <- function(res) {
  getNetworkAndInteractionEffects(
    res$VR_B_RT_Alerting,
    res$VR_B_ACC_Alerting,
    res$VR_B_RT_Validity,
    res$VR_B_ACC_Validity,
    res$VR_B_RT_Disengaging,
    res$VR_B_ACC_Disengaging,
    res$VR_B_RT_Moving_Engaging,
    res$VR_B_ACC_Moving_Engaging,
    res$VR_B_RT_OrientingTime,
    res$VR_B_ACC_OrientingTime,
    res$VR_B_RT_FlankerConflict,
    res$VR_B_ACC_FlankerConflict,
    res$VR_B_RT_LocationConflict,
    res$VR_B_ACC_LocationConflict,
    res$VR_B_RT_FlankerByLocation,
    res$VR_B_ACC_FlankerByLocation,
    res$VR_B_RT_AlertingByFlanker,
    res$VR_B_ACC_AlertingByFlanker,
    res$VR_B_RT_OrientingByFlanker,
    res$VR_B_ACC_OrientingByFlanker,
    res$VR_B_RT_ValidityByFlanker,
    res$VR_B_ACC_ValidityByFlanker,
    res$VR_B_RT_AlertingByLocation,
    res$VR_B_ACC_AlertingByLocation,
    res$VR_B_RT_OrientingByLocation,
    res$VR_B_ACC_OrientingByLocation,
    res$VR_B_RT_ValidityByLocation,
    res$VR_B_ACC_ValidityByLocation,
    res$VR_B_RT_IOR,
    res$VR_B_ACC_IOR,
    res$VR_B_RT,
    res$VR_B_ACC,
    "ANT-VR Balanced"
  )
}

getNetworkAndInteractionEffects_ANT_VR_B_All <- function() {
  res <- getResults_All()
  getNetworkAndInteractionEffects_ANT_VR_B(res)
}

################################################################################

# Joint Network and Interaction Effects

extract_legend <- function(ggpObject) {
  if (!require(ggplot2)) {
    install.packages("ggplot2")
  }
  library(ggplot2)

  step1 <- ggplot_gtable(ggplot_build(ggpObject))
  step2 <- which(sapply(step1$grobs, function(x) {
    x$name
  }) == "guide-box")
  step3 <- step1$grobs[[step2]]
  return(step3)
}

getJointNetworkAndInteractionEffects <- function(R_Alerting,
                                                 VR_Alerting,
                                                 R_Validity,
                                                 VR_Validity,
                                                 R_Disengaging,
                                                 VR_Disengaging,
                                                 R_Moving_Engaging,
                                                 VR_Moving_Engaging,
                                                 R_OrientingTime,
                                                 VR_OrientingTime,
                                                 R_FlankerConflict,
                                                 VR_FlankerConflict,
                                                 R_LocationConflict,
                                                 VR_LocationConflict,
                                                 R_FlankerByLocation,
                                                 VR_FlankerByLocation,
                                                 R_AlertingByFlanker,
                                                 VR_AlertingByFlanker,
                                                 R_OrientingByFlanker,
                                                 VR_OrientingByFlanker,
                                                 R_ValidityByFlanker,
                                                 VR_ValidityByFlanker,
                                                 R_AlertingByLocation,
                                                 VR_AlertingByLocation,
                                                 R_OrientingByLocation,
                                                 VR_OrientingByLocation,
                                                 R_ValidityByLocation,
                                                 VR_ValidityByLocation,
                                                 R_IOR,
                                                 VR_IOR,
                                                 R_Overall,
                                                 VR_Overall) {
  if (!require(RColorBrewer)) {
    install.packages("RColorBrewer")
  }
  if (!require(ggplot2)) {
    install.packages("ggplot2")
  }
  if (!require(gg.gap)) {
    install.packages("gg.gap")
  }
  if (!require(patchwork)) {
    install.packages("patchwork")
  }
  if (!require(psych)) {
    install.packages("psych")
  }
  if (!require(ggrepel)) {
    install.packages("ggrepel")
  }
  if (!require(tidyverse)) {
    install.packages("tidyverse")
  }
  if (!require(forcats)) {
    install.packages("forcats")
  }
  if (!require(stringr)) {
    install.packages("stringr")
  }
  library(RColorBrewer)
  library(ggplot2)
  library(gg.gap)
  library(patchwork)
  library(psych)
  library(ggrepel)
  library(tidyverse)
  library(forcats)
  library(stringr)

  res_R_alerting <- getNetworkAndInteractionEffectForJointPlot(R_Alerting)
  res_R_validity <- getNetworkAndInteractionEffectForJointPlot(R_Validity)
  res_R_disengaging <- getNetworkAndInteractionEffectForJointPlot(R_Disengaging)
  res_R_moving_engaging <- getNetworkAndInteractionEffectForJointPlot(R_Moving_Engaging)
  res_R_orientingTime <- getNetworkAndInteractionEffectForJointPlot(R_OrientingTime)
  res_R_flankerConflict <- getNetworkAndInteractionEffectForJointPlot(R_FlankerConflict)
  res_R_locationConflict <- getNetworkAndInteractionEffectForJointPlot(R_LocationConflict)
  res_R_flankerByLocation <- getNetworkAndInteractionEffectForJointPlot(R_FlankerByLocation)
  res_R_alertingByFlanker <- getNetworkAndInteractionEffectForJointPlot(R_AlertingByFlanker)
  res_R_orientingByFlanker <- getNetworkAndInteractionEffectForJointPlot(R_OrientingByFlanker)
  res_R_validityByFlanker <- getNetworkAndInteractionEffectForJointPlot(R_ValidityByFlanker)
  res_R_alertingByLocation <- getNetworkAndInteractionEffectForJointPlot(R_AlertingByLocation)
  res_R_orientingByLocation <- getNetworkAndInteractionEffectForJointPlot(R_OrientingByLocation)
  res_R_validityByLocation <- getNetworkAndInteractionEffectForJointPlot(R_ValidityByLocation)
  res_R_ior <- getNetworkAndInteractionEffectForJointPlot(R_IOR)
  res_R_overall <- getNetworkAndInteractionEffectForJointPlot(R_Overall)

  res_VR_alerting <- getNetworkAndInteractionEffectForJointPlot(VR_Alerting)
  res_VR_validity <- getNetworkAndInteractionEffectForJointPlot(VR_Validity)
  res_VR_disengaging <- getNetworkAndInteractionEffectForJointPlot(VR_Disengaging)
  res_VR_moving_engaging <- getNetworkAndInteractionEffectForJointPlot(VR_Moving_Engaging)
  res_VR_orientingTime <- getNetworkAndInteractionEffectForJointPlot(VR_OrientingTime)
  res_VR_flankerConflict <- getNetworkAndInteractionEffectForJointPlot(VR_FlankerConflict)
  res_VR_locationConflict <- getNetworkAndInteractionEffectForJointPlot(VR_LocationConflict)
  res_VR_flankerByLocation <- getNetworkAndInteractionEffectForJointPlot(VR_FlankerByLocation)
  res_VR_alertingByFlanker <- getNetworkAndInteractionEffectForJointPlot(VR_AlertingByFlanker)
  res_VR_orientingByFlanker <- getNetworkAndInteractionEffectForJointPlot(VR_OrientingByFlanker)
  res_VR_validityByFlanker <- getNetworkAndInteractionEffectForJointPlot(VR_ValidityByFlanker)
  res_VR_alertingByLocation <- getNetworkAndInteractionEffectForJointPlot(VR_AlertingByLocation)
  res_VR_orientingByLocation <- getNetworkAndInteractionEffectForJointPlot(VR_OrientingByLocation)
  res_VR_validityByLocation <- getNetworkAndInteractionEffectForJointPlot(VR_ValidityByLocation)
  res_VR_ior <- getNetworkAndInteractionEffectForJointPlot(VR_IOR)
  res_VR_overall <- getNetworkAndInteractionEffectForJointPlot(VR_Overall)

  mean_values <- c(
    res_R_alerting[1],
    res_VR_alerting[1],
    res_R_validity[1],
    res_VR_validity[1],
    res_R_disengaging[1],
    res_VR_disengaging[1],
    res_R_moving_engaging[1],
    res_VR_moving_engaging[1],
    res_R_orientingTime[1],
    res_VR_orientingTime[1],
    res_R_flankerConflict[1],
    res_VR_flankerConflict[1],
    res_R_locationConflict[1],
    res_VR_locationConflict[1],
    res_R_flankerByLocation[1],
    res_VR_flankerByLocation[1],
    res_R_alertingByFlanker[1],
    res_VR_alertingByFlanker[1],
    res_R_orientingByFlanker[1],
    res_VR_orientingByFlanker[1],
    res_R_validityByFlanker[1],
    res_VR_validityByFlanker[1],
    res_R_alertingByLocation[1],
    res_VR_alertingByLocation[1],
    res_R_orientingByLocation[1],
    res_VR_orientingByLocation[1],
    res_R_validityByLocation[1],
    res_VR_validityByLocation[1],
    res_R_ior[1],
    res_VR_ior[1],
    res_R_overall[1],
    res_VR_overall[1]
  )

  sd_values <- c(
    res_R_alerting[2],
    res_VR_alerting[2],
    res_R_validity[2],
    res_VR_validity[2],
    res_R_disengaging[2],
    res_VR_disengaging[2],
    res_R_moving_engaging[2],
    res_VR_moving_engaging[2],
    res_R_orientingTime[2],
    res_VR_orientingTime[2],
    res_R_flankerConflict[2],
    res_VR_flankerConflict[2],
    res_R_locationConflict[2],
    res_VR_locationConflict[2],
    res_R_flankerByLocation[2],
    res_VR_flankerByLocation[2],
    res_R_alertingByFlanker[2],
    res_VR_alertingByFlanker[2],
    res_R_orientingByFlanker[2],
    res_VR_orientingByFlanker[2],
    res_R_validityByFlanker[2],
    res_VR_validityByFlanker[2],
    res_R_alertingByLocation[2],
    res_VR_alertingByLocation[2],
    res_R_orientingByLocation[2],
    res_VR_orientingByLocation[2],
    res_R_validityByLocation[2],
    res_VR_validityByLocation[2],
    res_R_ior[2],
    res_VR_ior[2],
    res_R_overall[2],
    res_VR_overall[2]
  )

  modalities <- c(
    "ANT-R",
    "ANT-VR",
    "ANT-R",
    "ANT-VR",
    "ANT-R",
    "ANT-VR",
    "ANT-R",
    "ANT-VR",
    "ANT-R",
    "ANT-VR",
    "ANT-R",
    "ANT-VR",
    "ANT-R",
    "ANT-VR",
    "ANT-R",
    "ANT-VR",
    "ANT-R",
    "ANT-VR",
    "ANT-R",
    "ANT-VR",
    "ANT-R",
    "ANT-VR",
    "ANT-R",
    "ANT-VR",
    "ANT-R",
    "ANT-VR",
    "ANT-R",
    "ANT-VR",
    "ANT-R",
    "ANT-VR",
    "ANT-R",
    "ANT-VR"
  )
  columnNames <- c(
    "Alerting Benefit",
    "Alerting Benefit",
    "Validity Effect",
    "Validity Effect",
    "Disengaging Cost",
    "Disengaging Cost",
    "Moving + Engaging",
    "Moving + Engaging",
    "Orienting Time",
    "Orienting Time",
    "Flanker Conflict Effect",
    "Flanker Conflict Effect",
    "Location Conflict Effect",
    "Location Conflict Effect",
    "Flanker by Location Interaction",
    "Flanker by Location Interaction",
    "Alerting by Flanker Conflict",
    "Alerting by Flanker Conflict",
    "Orienting by Flanker Conflict",
    "Orienting by Flanker Conflict",
    "Validity by Flanker Conflict",
    "Validity by Flanker Conflict",
    "Alerting by Location Conflict",
    "Alerting by Location Conflict",
    "Orienting by Location Conflict",
    "Orienting by Location Conflict",
    "Validity by Location Conflict",
    "Validity by Location Conflict",
    "Inhibition of Return Effect",
    "Inhibition of Return Effect",
    "Overall",
    "Overall"
  )

  df1 <- data.frame(mean_values, sd_values, modalities, columnNames)

  nres <- length(R_Alerting)

  allPaletteColors <- brewer.pal(9, "PuBu")
  fillColors <- c(allPaletteColors[5], allPaletteColors[8])

  bar <- (
    ggplot(df1, aes(
      x = fct_inorder(columnNames),
      y = mean_values,
      fill = modalities
    )) +
      geom_bar(stat = "identity", position = "dodge") +
      geom_errorbar(
        aes(
          x = fct_inorder(columnNames),
          ymin = mean_values - sd_values,
          ymax = mean_values + sd_values
        ),
        width = .8,
        position = position_dodge(.9)
      ) +
      scale_x_discrete(
        labels = function(x) {
          stringr::str_wrap(x, width = 20)
        }
      ) +
      scale_fill_manual(name = "Modality", values = fillColors) +
      labs(x = "", y = "") +
      theme(
        axis.text.x = element_text(
          size = 6,
          angle = 90,
          hjust = 1,
          vjust = 0.4
        ),
        axis.ticks = element_blank(),
        panel.grid = element_blank(),
        panel.background = element_blank(),
        panel.border = element_blank(),
        legend.key.size = unit(3, "mm"),
        legend.text = element_text(size = 5),
        legend.title = element_text(size = 8),
        legend.margin = unit(x = c(-15, 0, 0, 0), units = "mm"),
        plot.title = element_text(
          face = "bold",
          hjust = 0,
          vjust = 1,
          size = 11
        ),
        plot.caption = element_text(face = "italic", hjust = 0)
      )
  )
  legendObject <- extract_legend(bar)
  bar <- gg.gap(
    plot = bar,
    ylim = c(-150, 800),
    segments = list(c(150, 500)),
    tick_width = c(50, 100),
    rel_height = c(0.7, 0.0, 0.3)
  )
  bar <- (bar + inset_element(legendObject, 0.75, 0.8, 0.9, 0.9))
  return(bar)
}

getJointNetworkAndInteractionEffects_All <- function() {
  res <- getResults_All()
  barplot <- getJointNetworkAndInteractionEffects(
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
    res$VR_RT
  )

  return(barplot)
}

################################################################################

# Pearson Correlations
getCorrelationsOfNetworks <- function(pearsonCorrelations, degreesOfFreedom) {
  if (!require(dplyr)) {
    install.packages("dplyr")
  }
  if (!require(papaja)) {
    install.packages("papaja")
  }
  if (!require(psych)) {
    install.packages("psych")
  }
  library(dplyr)
  library(papaja)
  library(psych)

  pearsonCorrelations[is.na(pearsonCorrelations)] <- ""

  rownames(pearsonCorrelations) <- c(
    "Alerting*",
    "Validity",
    "Disengaging",
    "Mov + Eng",
    "Orien Time",
    "Flanker Conf",
    "Location Conf",
    "IOR",
    "Overall"
  )
  colnames(pearsonCorrelations) <- c(
    "Mean",
    "SD",
    "r",
    "p",
    "r",
    "p",
    "r",
    "p",
    "r",
    "p",
    "r",
    "p",
    "r",
    "p",
    "r",
    "p",
    "r",
    "p"
  )

  alignV <- c(
    "l",
    "r",
    "r",
    "r",
    "r",
    "r",
    "r",
    "r",
    "r",
    "r",
    "r",
    "r",
    "r",
    "r",
    "r",
    "r",
    "r",
    "r",
    "r"
  )
  colSpannersL <- list(
    "Alerting*" = c(4, 5),
    "Validity" = c(6, 7),
    "Disengaging" = c(8, 9),
    "Mov + Eng" = c(10, 11),
    "Orien Time" = c(12, 13),
    "Flanker Conf" = c(14, 15),
    "Location Conf" = c(16, 17),
    "IOR" = c(18, 19)
  )
  papaja::apa_table(
    pearsonCorrelations,
    align = alignV,
    note = paste(
      "df = ",
      degreesOfFreedom,
      ".*Alerting is Alerting Benefit, Validity is Validity Effect, Disengaging is Disengaging Cost, Mov + Eng is Moving and Engaging, Orien Time is Orienting Time, Flanker Conf is Flanker Conflict Effect, Location Conf is Location Conflict Effect, and IOR is Inhibition of Return Effect.",
      sep = ""
    ),
    col_spanners = colSpannersL,
    landscape = TRUE,
    font_size = "small",
    escape = FALSE
  )
}

getCorrelationsOfNetworks_ANT_R_RT <- function(res) {
  pc <- getPearsonCorrelationsForPlot(
    res$R_RT_Alerting,
    res$R_RT_Validity,
    res$R_RT_Disengaging,
    res$R_RT_Moving_Engaging,
    res$R_RT_OrientingTime,
    res$R_RT_FlankerConflict,
    res$R_RT_LocationConflict,
    res$R_RT_IOR,
    res$R_RT
  )

  getCorrelationsOfNetworks(pc[[1]], pc[[2]])
}

getCorrelationsOfNetworks_ANT_R_RT_All <- function() {
  res <- getResults_All()
  getCorrelationsOfNetworks_ANT_R_RT(res)
}

getCorrelationsOfNetworks_ANT_R_ACC <- function(res) {
  pc <- getPearsonCorrelationsForPlot(
    res$R_ACC_Alerting,
    res$R_ACC_Validity,
    res$R_ACC_Disengaging,
    res$R_ACC_Moving_Engaging,
    res$R_ACC_OrientingTime,
    res$R_ACC_FlankerConflict,
    res$R_ACC_LocationConflict,
    res$R_ACC_IOR,
    res$R_ACC
  )

  getCorrelationsOfNetworks(pc[[1]], pc[[2]])
}

getCorrelationsOfNetworks_ANT_R_ACC_All <- function() {
  res <- getResults_All()
  getCorrelationsOfNetworks_ANT_R_ACC(res)
}

getCorrelationsOfNetworks_ANT_VR_RT <- function(res) {
  pc <- getPearsonCorrelationsForPlot(
    res$VR_RT_Alerting,
    res$VR_RT_Validity,
    res$VR_RT_Disengaging,
    res$VR_RT_Moving_Engaging,
    res$VR_RT_OrientingTime,
    res$VR_RT_FlankerConflict,
    res$VR_RT_LocationConflict,
    res$VR_RT_IOR,
    res$VR_RT
  )

  getCorrelationsOfNetworks(pc[[1]], pc[[2]])
}

getCorrelationsOfNetworks_ANT_VR_RT_All <- function() {
  res <- getResults_All()
  getCorrelationsOfNetworks_ANT_VR_RT(res)
}

getCorrelationsOfNetworks_ANT_VR_ACC <- function(res) {
  pc <- getPearsonCorrelationsForPlot(
    res$VR_ACC_Alerting,
    res$VR_ACC_Validity,
    res$VR_ACC_Disengaging,
    res$VR_ACC_Moving_Engaging,
    res$VR_ACC_OrientingTime,
    res$VR_ACC_FlankerConflict,
    res$VR_ACC_LocationConflict,
    res$VR_ACC_IOR,
    res$VR_ACC
  )

  getCorrelationsOfNetworks(pc[[1]], pc[[2]])
}

getCorrelationsOfNetworks_ANT_VR_ACC_All <- function() {
  res <- getResults_All()
  getCorrelationsOfNetworks_ANT_VR_ACC(res)
}

getCorrelationsOfNetworks_ANT_VR_B_RT <- function(res) {
  pc <- getPearsonCorrelationsForPlot(
    res$VR_B_RT_Alerting,
    res$VR_B_RT_Validity,
    res$VR_B_RT_Disengaging,
    res$VR_B_RT_Moving_Engaging,
    res$VR_B_RT_OrientingTime,
    res$VR_B_RT_FlankerConflict,
    res$VR_B_RT_LocationConflict,
    res$VR_B_RT_IOR,
    res$VR_B_RT
  )

  getCorrelationsOfNetworks(pc[[1]], pc[[2]])
}

getCorrelationsOfNetworks_ANT_VR_B_RT_All <- function() {
  res <- getResults_All()
  getCorrelationsOfNetworks_ANT_VR_B_RT(res)
}

getCorrelationsOfNetworks_ANT_VR_B_ACC <- function(res) {
  pc <- getPearsonCorrelationsForPlot(
    res$VR_B_ACC_Alerting,
    res$VR_B_ACC_Validity,
    res$VR_B_ACC_Disengaging,
    res$VR_B_ACC_Moving_Engaging,
    res$VR_B_ACC_OrientingTime,
    res$VR_B_ACC_FlankerConflict,
    res$VR_B_ACC_LocationConflict,
    res$VR_B_ACC_IOR,
    res$VR_B_ACC
  )

  getCorrelationsOfNetworks(pc[[1]], pc[[2]])
}

getCorrelationsOfNetworks_ANT_VR_B_ACC_All <- function() {
  res <- getResults_All()
  getCorrelationsOfNetworks_ANT_VR_B_ACC(res)
}

################################################################################

# Figures/Charts

# Alerting by Flanker Conflict Interaction Plot
getAlertingByFlankerConflict <- function(id,
                                         nc_FC,
                                         nc_FIC,
                                         dc_0_FC,
                                         dc_0_FIC,
                                         dc_400_FC,
                                         dc_400_FIC,
                                         dc_800_FC,
                                         dc_800_FIC,
                                         experimentName,
                                         yAxisLabel,
                                         digits) {
  if (!require(tidyverse)) {
    install.packages("tidyverse")
  }
  if (!require(rstatix)) {
    install.packages("rstatix")
  }
  if (!require(FSA)) {
    install.packages("FSA")
  }
  if (!require(ggplot2)) {
    install.packages("ggplot2")
  }
  library(tidyverse)
  library(rstatix)
  library(FSA)
  library(ggplot2)

  resultSet <- data.frame(
    Id = integer(0),
    CueToTarget = character(0),
    FlankerCongruency = character(0),
    ValueCol = numeric(0)
  )

  for (row in 1:length(id)) {
    resultSet <- (
      resultSet %>% add_row(
        Id = id[row],
        CueToTarget = "no-cue",
        FlankerCongruency = "congruent",
        ValueCol = nc_FC[row]
      )
      %>% add_row(
          Id = id[row],
          CueToTarget = "no-cue",
          FlankerCongruency = "incongruent",
          ValueCol = nc_FIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "0",
          FlankerCongruency = "congruent",
          ValueCol = dc_0_FC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "0",
          FlankerCongruency = "incongruent",
          ValueCol = dc_0_FIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "400",
          FlankerCongruency = "congruent",
          ValueCol = dc_400_FC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "400",
          FlankerCongruency = "incongruent",
          ValueCol = dc_400_FIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "800",
          FlankerCongruency = "congruent",
          ValueCol = dc_800_FC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "800",
          FlankerCongruency = "incongruent",
          ValueCol = dc_800_FIC[row]
        )
    )
  }

  result <- Summarize(
    ValueCol ~ CueToTarget + FlankerCongruency + CueToTarget:FlankerCongruency,
    data = resultSet,
    digits = digits
  )

  result$se <- result$sd / sqrt(result$n)
  result$se <- signif(result$se, digits = digits)

  result$CueToTarget <- factor(result$CueToTarget, levels = c("no-cue", "0", "400", "800"))

  pd <- position_dodge(.0)

  ggplot(result, aes(x = CueToTarget, y = mean, group = FlankerCongruency)) +
    geom_errorbar(
      aes(ymin = mean - se, ymax = mean + se),
      width = .4,
      size = 0.7,
      position = pd
    ) +
    geom_point(
      shape = 15,
      size = 2,
      position = pd
    ) +
    geom_line(size = 0.8, aes(linetype = FlankerCongruency)) +
    scale_linetype_manual(values = c("solid", "dashed"), name = "Congruency", labels = function(x) {
      sapply(x, function(y) {
        paste0(toupper(substr(y, 1, 1)), substr(y, 2, nchar(y)))
      })
    }) +
    theme_apa() +
    theme(axis.title = element_text(face = "bold")) +
    theme(text = element_text(family = "Times")) +
    labs(x = "Cue-Target Interval (ms)", y = yAxisLabel, col = "Congruency")
}

getAlertingByFlankerConflict_ANT_R_RT <- function(res) {
  getAlertingByFlankerConflict(
    res$Id,
    res$R_RT_NC_FC,
    res$R_RT_NC_FIC,
    res$R_RT_DC_0_FC,
    res$R_RT_DC_0_FIC,
    res$R_RT_DC_400_FC,
    res$R_RT_DC_400_FIC,
    res$R_RT_DC_800_FC,
    res$R_RT_DC_800_FIC,
    "ANT-R",
    "Reaction Time (ms)",
    3
  )
}

getAlertingByFlankerConflict_ANT_R_RT_All <- function() {
  res <- getResults_All()
  getAlertingByFlankerConflict_ANT_R_RT(res)
}

getAlertingByFlankerConflict_ANT_R_ACC <- function(res) {
  getAlertingByFlankerConflict(
    res$Id,
    res$R_ACC_NC_FC,
    res$R_ACC_NC_FIC,
    res$R_ACC_DC_0_FC,
    res$R_ACC_DC_0_FIC,
    res$R_ACC_DC_400_FC,
    res$R_ACC_DC_400_FIC,
    res$R_ACC_DC_800_FC,
    res$R_ACC_DC_800_FIC,
    "ANT-R",
    "Accuracy (%)",
    5
  )
}

getAlertingByFlankerConflict_ANT_R_ACC_All <- function() {
  res <- getResults_All()
  getAlertingByFlankerConflict_ANT_R_ACC(res)
}

getAlertingByFlankerConflict_ANT_VR_RT <- function(res) {
  getAlertingByFlankerConflict(
    res$Id,
    res$VR_RT_NC_FC,
    res$VR_RT_NC_FIC,
    res$VR_RT_DC_0_FC,
    res$VR_RT_DC_0_FIC,
    res$VR_RT_DC_400_FC,
    res$VR_RT_DC_400_FIC,
    res$VR_RT_DC_800_FC,
    res$VR_RT_DC_800_FIC,
    "ANT-VR",
    "Reaction Time (ms)",
    3
  )
}

getAlertingByFlankerConflict_ANT_VR_RT_All <- function() {
  res <- getResults_All()
  getAlertingByFlankerConflict_ANT_VR_RT(res)
}

getAlertingByFlankerConflict_ANT_VR_ACC <- function(res) {
  getAlertingByFlankerConflict(
    res$Id,
    res$VR_ACC_NC_FC,
    res$VR_ACC_NC_FIC,
    res$VR_ACC_DC_0_FC,
    res$VR_ACC_DC_0_FIC,
    res$VR_ACC_DC_400_FC,
    res$VR_ACC_DC_400_FIC,
    res$VR_ACC_DC_800_FC,
    res$VR_ACC_DC_800_FIC,
    "ANT-VR",
    "Accuracy (%)",
    5
  )
}

getAlertingByFlankerConflict_ANT_VR_ACC_All <- function() {
  res <- getResults_All()
  getAlertingByFlankerConflict_ANT_VR_ACC(res)
}

getAlertingByFlankerConflict_ANT_VR_B_RT <- function(res) {
  getAlertingByFlankerConflict(
    res$Id,
    res$VR_B_RT_NC_FC,
    res$VR_B_RT_NC_FIC,
    res$VR_B_RT_DC_0_FC,
    res$VR_B_RT_DC_0_FIC,
    res$VR_B_RT_DC_400_FC,
    res$VR_B_RT_DC_400_FIC,
    res$VR_B_RT_DC_800_FC,
    res$VR_B_RT_DC_800_FIC,
    "ANT-VR Balanced",
    "Reaction Time (ms)",
    3
  )
}

getAlertingByFlankerConflict_ANT_VR_B_RT_All <- function() {
  res <- getResults_All()
  getAlertingByFlankerConflict_ANT_VR_B_RT(res)
}

getAlertingByFlankerConflict_ANT_VR_B_ACC <- function(res) {
  getAlertingByFlankerConflict(
    res$Id,
    res$VR_B_ACC_NC_FC,
    res$VR_B_ACC_NC_FIC,
    res$VR_B_ACC_DC_0_FC,
    res$VR_B_ACC_DC_0_FIC,
    res$VR_B_ACC_DC_400_FC,
    res$VR_B_ACC_DC_400_FIC,
    res$VR_B_ACC_DC_800_FC,
    res$VR_B_ACC_DC_800_FIC,
    "ANT-VR Balanced",
    "Accuracy (%)",
    5
  )
}

getAlertingByFlankerConflict_ANT_VR_B_ACC_All <- function() {
  res <- getResults_All()
  getAlertingByFlankerConflict_ANT_VR_B_ACC(res)
}

################################################################################

# Alerting by Flanker Conflict by Location Conflict Interaction Plot
getAlertingByFlankerConflictByLocationConflict <- function(id,
                                                           nc_FC_LC,
                                                           nc_FIC_LC,
                                                           dc_0_FC_LC,
                                                           dc_0_FIC_LC,
                                                           dc_400_FC_LC,
                                                           dc_400_FIC_LC,
                                                           dc_800_FC_LC,
                                                           dc_800_FIC_LC,
                                                           nc_FC_LIC,
                                                           nc_FIC_LIC,
                                                           dc_0_FC_LIC,
                                                           dc_0_FIC_LIC,
                                                           dc_400_FC_LIC,
                                                           dc_400_FIC_LIC,
                                                           dc_800_FC_LIC,
                                                           dc_800_FIC_LIC,
                                                           experimentName,
                                                           yAxisLabel,
                                                           digits) {
  if (!require(tidyverse)) {
    install.packages("tidyverse")
  }
  if (!require(rstatix)) {
    install.packages("rstatix")
  }
  if (!require(FSA)) {
    install.packages("FSA")
  }
  if (!require(ggplot2)) {
    install.packages("ggplot2")
  }
  library(tidyverse)
  library(rstatix)
  library(FSA)
  library(ggplot2)

  resultSet <- data.frame(
    Id = integer(0),
    CueToTarget = character(0),
    Congruencies = character(0),
    ValueCol = numeric(0)
  )

  for (row in 1:length(id)) {
    resultSet <- (
      resultSet
      %>% add_row(
          Id = id[row],
          CueToTarget = "no-cue",
          Congruencies = "flanker congruent,\nlocation congruent",
          ValueCol = nc_FC_LC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "no-cue",
          Congruencies = "flanker incongruent,\nlocation congruent",
          ValueCol = nc_FIC_LC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "0",
          Congruencies = "flanker congruent,\nlocation congruent",
          ValueCol = dc_0_FC_LC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "0",
          Congruencies = "flanker incongruent,\nlocation congruent",
          ValueCol = dc_0_FIC_LC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "400",
          Congruencies = "flanker congruent,\nlocation congruent",
          ValueCol = dc_400_FC_LC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "400",
          Congruencies = "flanker incongruent,\nlocation congruent",
          ValueCol = dc_400_FIC_LC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "800",
          Congruencies = "flanker congruent,\nlocation congruent",
          ValueCol = dc_800_FC_LC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "800",
          Congruencies = "flanker incongruent,\nlocation congruent",
          ValueCol = dc_800_FIC_LC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "no-cue",
          Congruencies = "flanker congruent,\nlocation incongruent",
          ValueCol = nc_FC_LIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "no-cue",
          Congruencies = "flanker incongruent,\nlocation incongruent",
          ValueCol = nc_FIC_LIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "0",
          Congruencies = "flanker congruent,\nlocation incongruent",
          ValueCol = dc_0_FC_LIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "0",
          Congruencies = "flanker incongruent,\nlocation incongruent",
          ValueCol = dc_0_FIC_LIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "400",
          Congruencies = "flanker congruent,\nlocation incongruent",
          ValueCol = dc_400_FC_LIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "400",
          Congruencies = "flanker incongruent,\nlocation incongruent",
          ValueCol = dc_400_FIC_LIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "800",
          Congruencies = "flanker congruent,\nlocation incongruent",
          ValueCol = dc_800_FC_LIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "800",
          Congruencies = "flanker incongruent,\nlocation incongruent",
          ValueCol = dc_800_FIC_LIC[row]
        )
    )
  }

  result <- Summarize(
    ValueCol ~ CueToTarget + Congruencies + CueToTarget:Congruencies,
    data = resultSet,
    digits = digits
  )

  result$se <- result$sd / sqrt(result$n)
  result$se <- signif(result$se, digits = digits)

  result$CueToTarget <- factor(result$CueToTarget, levels = c("no-cue", "0", "400", "800"))

  pd <- position_dodge(.0)

  ggplot(result, aes(x = CueToTarget, y = mean, group = Congruencies)) +
    geom_errorbar(
      aes(ymin = mean - se, ymax = mean + se),
      width = .4,
      size = 0.7,
      position = pd
    ) +
    geom_point(
      shape = 15,
      size = 2,
      position = pd
    ) +
    geom_line(size = 0.8, aes(linetype = Congruencies)) +
    scale_linetype_manual(
      values = c("solid", "dashed", "dotted", "dotdash"),
      name = "Congruency"
    ) +
    theme_apa() +
    theme(
      axis.title = element_text(face = "bold"),
      legend.key.size = unit(8, "mm"),
      legend.text = element_text(size = 10)
    ) +
    labs(x = "Cue-Target Interval (ms)", y = yAxisLabel, col = "Congruency")
}

getAlertingByFlankerConflictByLocationConflict_ANT_R_RT <- function(res) {
  getAlertingByFlankerConflictByLocationConflict(
    res$Id,
    res$R_RT_NC_FCLC,
    res$R_RT_NC_FICLC,
    res$R_RT_DC_0_FCLC,
    res$R_RT_DC_0_FICLC,
    res$R_RT_DC_400_FCLC,
    res$R_RT_DC_400_FICLC,
    res$R_RT_DC_800_FCLC,
    res$R_RT_DC_800_FICLC,
    res$R_RT_NC_FCLIC,
    res$R_RT_NC_FICLIC,
    res$R_RT_DC_0_FCLIC,
    res$R_RT_DC_0_FICLIC,
    res$R_RT_DC_400_FCLIC,
    res$R_RT_DC_400_FICLIC,
    res$R_RT_DC_800_FCLIC,
    res$R_RT_DC_800_FICLIC,
    "ANT-R",
    "Reaction Time (ms)",
    3
  )
}

getAlertingByFlankerConflictByLocationConflict_ANT_R_RT_All <- function() {
  res <- getResults_All()
  getAlertingByFlankerConflictByLocationConflict_ANT_R_RT(res)
}

getAlertingByFlankerConflictByLocationConflict_ANT_R_ACC <- function(res) {
  getAlertingByFlankerConflictByLocationConflict(
    res$Id,
    res$R_ACC_NC_FCLC,
    res$R_ACC_NC_FICLC,
    res$R_ACC_DC_0_FCLC,
    res$R_ACC_DC_0_FICLC,
    res$R_ACC_DC_400_FCLC,
    res$R_ACC_DC_400_FICLC,
    res$R_ACC_DC_800_FCLC,
    res$R_ACC_DC_800_FICLC,
    res$R_ACC_NC_FCLIC,
    res$R_ACC_NC_FICLIC,
    res$R_ACC_DC_0_FCLIC,
    res$R_ACC_DC_0_FICLIC,
    res$R_ACC_DC_400_FCLIC,
    res$R_ACC_DC_400_FICLIC,
    res$R_ACC_DC_800_FCLIC,
    res$R_ACC_DC_800_FICLIC,
    "ANT-R",
    "Accuracy (%)",
    5
  )
}

getAlertingByFlankerConflictByLocationConflict_ANT_R_ACC_All <- function() {
  res <- getResults_All()
  getAlertingByFlankerConflictByLocationConflict_ANT_R_ACC(res)
}

getAlertingByFlankerConflictByLocationConflict_ANT_VR_RT <- function(res) {
  getAlertingByFlankerConflictByLocationConflict(
    res$Id,
    res$VR_RT_NC_FCLC,
    res$VR_RT_NC_FICLC,
    res$VR_RT_DC_0_FCLC,
    res$VR_RT_DC_0_FICLC,
    res$VR_RT_DC_400_FCLC,
    res$VR_RT_DC_400_FICLC,
    res$VR_RT_DC_800_FCLC,
    res$VR_RT_DC_800_FICLC,
    res$VR_RT_NC_FCLIC,
    res$VR_RT_NC_FICLIC,
    res$VR_RT_DC_0_FCLIC,
    res$VR_RT_DC_0_FICLIC,
    res$VR_RT_DC_400_FCLIC,
    res$VR_RT_DC_400_FICLIC,
    res$VR_RT_DC_800_FCLIC,
    res$VR_RT_DC_800_FICLIC,
    "ANT-VR",
    "Reaction Time (ms)",
    3
  )
}

getAlertingByFlankerConflictByLocationConflict_ANT_VR_RT_All <- function() {
  res <- getResults_All()
  getAlertingByFlankerConflictByLocationConflict_ANT_VR_RT(res)
}

getAlertingByFlankerConflictByLocationConflict_ANT_VR_ACC <- function(res) {
  getAlertingByFlankerConflictByLocationConflict(
    res$Id,
    res$VR_ACC_NC_FCLC,
    res$VR_ACC_NC_FICLC,
    res$VR_ACC_DC_0_FCLC,
    res$VR_ACC_DC_0_FICLC,
    res$VR_ACC_DC_400_FCLC,
    res$VR_ACC_DC_400_FICLC,
    res$VR_ACC_DC_800_FCLC,
    res$VR_ACC_DC_800_FICLC,
    res$VR_ACC_NC_FCLIC,
    res$VR_ACC_NC_FICLIC,
    res$VR_ACC_DC_0_FCLIC,
    res$VR_ACC_DC_0_FICLIC,
    res$VR_ACC_DC_400_FCLIC,
    res$VR_ACC_DC_400_FICLIC,
    res$VR_ACC_DC_800_FCLIC,
    res$VR_ACC_DC_800_FICLIC,
    "ANT-VR",
    "Accuracy (%)",
    5
  )
}

getAlertingByFlankerConflictByLocationConflict_ANT_VR_ACC_All <- function() {
  res <- getResults_All()
  getAlertingByFlankerConflictByLocationConflict_ANT_VR_ACC(res)
}

getAlertingByFlankerConflictByLocationConflict_ANT_VR_B_RT <- function(res) {
  getAlertingByFlankerConflictByLocationConflict(
    res$Id,
    res$VR_B_RT_NC_FCLC,
    res$VR_B_RT_NC_FICLC,
    res$VR_B_RT_DC_0_FCLC,
    res$VR_B_RT_DC_0_FICLC,
    res$VR_B_RT_DC_400_FCLC,
    res$VR_B_RT_DC_400_FICLC,
    res$VR_B_RT_DC_800_FCLC,
    res$VR_B_RT_DC_800_FICLC,
    res$VR_B_RT_NC_FCLIC,
    res$VR_B_RT_NC_FICLIC,
    res$VR_B_RT_DC_0_FCLIC,
    res$VR_B_RT_DC_0_FICLIC,
    res$VR_B_RT_DC_400_FCLIC,
    res$VR_B_RT_DC_400_FICLIC,
    res$VR_B_RT_DC_800_FCLIC,
    res$VR_B_RT_DC_800_FICLIC,
    "ANT-VR Balanced",
    "Reaction Time (ms)",
    3
  )
}

getAlertingByFlankerConflictByLocationConflict_ANT_VR_B_RT_All <- function() {
  res <- getResults_All()
  getAlertingByFlankerConflictByLocationConflict_ANT_VR_B_RT(res)
}

getAlertingByFlankerConflictByLocationConflict_ANT_VR_B_ACC <- function(res) {
  getAlertingByFlankerConflictByLocationConflict(
    res$Id,
    res$VR_B_ACC_NC_FCLC,
    res$VR_B_ACC_NC_FICLC,
    res$VR_B_ACC_DC_0_FCLC,
    res$VR_B_ACC_DC_0_FICLC,
    res$VR_B_ACC_DC_400_FCLC,
    res$VR_B_ACC_DC_400_FICLC,
    res$VR_B_ACC_DC_800_FCLC,
    res$VR_B_ACC_DC_800_FICLC,
    res$VR_B_ACC_NC_FCLIC,
    res$VR_B_ACC_NC_FICLIC,
    res$VR_B_ACC_DC_0_FCLIC,
    res$VR_B_ACC_DC_0_FICLIC,
    res$VR_B_ACC_DC_400_FCLIC,
    res$VR_B_ACC_DC_400_FICLIC,
    res$VR_B_ACC_DC_800_FCLIC,
    res$VR_B_ACC_DC_800_FICLIC,
    "ANT-VR Balanced",
    "Accuracy (%)",
    5
  )
}

getAlertingByFlankerConflictByLocationConflict_ANT_VR_B_ACC_All <- function() {
  res <- getResults_All()
  getAlertingByFlankerConflictByLocationConflict_ANT_VR_B_ACC(res)
}

################################################################################

# Orienting by Flanker Conflict Interaction Plot
getOrientingByFlankerConflict <- function(id,
                                          dc_FC,
                                          dc_FIC,
                                          vc_FC,
                                          vc_FIC,
                                          experimentName,
                                          yAxisLabel,
                                          digits) {
  if (!require(tidyverse)) {
    install.packages("tidyverse")
  }
  if (!require(rstatix)) {
    install.packages("rstatix")
  }
  if (!require(FSA)) {
    install.packages("FSA")
  }
  if (!require(ggplot2)) {
    install.packages("ggplot2")
  }
  library(tidyverse)
  library(rstatix)
  library(FSA)
  library(ggplot2)

  resultSet <- data.frame(
    Id = integer(0),
    CueValidity = character(0),
    FlankerCongruency = character(0),
    ValueCol = numeric(0)
  )

  for (row in 1:length(id)) {
    resultSet <- (
      resultSet %>% add_row(
        Id = id[row],
        CueValidity = "double",
        FlankerCongruency = "congruent",
        ValueCol = dc_FC[row]
      )
      %>% add_row(
          Id = id[row],
          CueValidity = "double",
          FlankerCongruency = "incongruent",
          ValueCol = dc_FIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueValidity = "valid",
          FlankerCongruency = "congruent",
          ValueCol = vc_FC[row]
        )
        %>% add_row(
          Id = id[row],
          CueValidity = "valid",
          FlankerCongruency = "incongruent",
          ValueCol = vc_FIC[row]
        )
    )
  }

  result <- Summarize(
    ValueCol ~ CueValidity + FlankerCongruency + CueValidity:FlankerCongruency,
    data = resultSet,
    digits = digits
  )

  result$se <- result$sd / sqrt(result$n)
  result$se <- signif(result$se, digits = digits)

  result$CueValidity <- factor(result$CueValidity, levels = c("double", "valid"))

  pd <- position_dodge(.0)

  ggplot(result, aes(x = CueValidity, y = mean, group = FlankerCongruency)) +
    geom_errorbar(
      aes(ymin = mean - se, ymax = mean + se),
      width = .4,
      size = 0.7,
      position = pd
    ) +
    geom_point(
      shape = 15,
      size = 2,
      position = pd
    ) +
    geom_line(size = 0.8, aes(linetype = FlankerCongruency)) +
    scale_linetype_manual(values = c("solid", "dashed"), name = "Congruency", labels = function(x) {
      sapply(x, function(y) {
        paste0(toupper(substr(y, 1, 1)), substr(y, 2, nchar(y)))
      })
    }) +
    theme_apa() +
    theme(axis.title = element_text(face = "bold")) +
    theme(text = element_text(family = "Times")) +
    labs(x = "Cue Type", y = yAxisLabel, col = "Congruency")
}

getOrientingByFlankerConflict_ANT_R_RT <- function(res) {
  getOrientingByFlankerConflict(
    res$Id,
    res$R_RT_DC_FC,
    res$R_RT_DC_FIC,
    res$R_RT_VC_FC,
    res$R_RT_VC_FIC,
    "ANT-R",
    "Reaction Time (ms)",
    3
  )
}

getOrientingByFlankerConflict_ANT_R_RT_All <- function() {
  res <- getResults_All()
  getOrientingByFlankerConflict_ANT_R_RT(res)
}

getOrientingByFlankerConflict_ANT_R_ACC <- function(res) {
  getOrientingByFlankerConflict(
    res$Id,
    res$R_ACC_DC_FC,
    res$R_ACC_DC_FIC,
    res$R_ACC_VC_FC,
    res$R_ACC_VC_FIC,
    "ANT-R",
    "Accuracy (%)",
    5
  )
}

getOrientingByFlankerConflict_ANT_R_ACC_All <- function() {
  res <- getResults_All()
  getOrientingByFlankerConflict_ANT_R_ACC(res)
}

getOrientingByFlankerConflict_ANT_VR_RT <- function(res) {
  getOrientingByFlankerConflict(
    res$Id,
    res$VR_RT_DC_FC,
    res$VR_RT_DC_FIC,
    res$VR_RT_VC_FC,
    res$VR_RT_VC_FIC,
    "ANT-VR",
    "Reaction Time (ms)",
    3
  )
}

getOrientingByFlankerConflict_ANT_VR_RT_All <- function() {
  res <- getResults_All()
  getOrientingByFlankerConflict_ANT_VR_RT(res)
}

getOrientingByFlankerConflict_ANT_VR_ACC <- function(res) {
  getOrientingByFlankerConflict(
    res$Id,
    res$VR_ACC_DC_FC,
    res$VR_ACC_DC_FIC,
    res$VR_ACC_VC_FC,
    res$VR_ACC_VC_FIC,
    "ANT-VR",
    "Accuracy (%)",
    5
  )
}

getOrientingByFlankerConflict_ANT_VR_ACC_All <- function() {
  res <- getResults_All()
  getOrientingByFlankerConflict_ANT_VR_ACC(res)
}

getOrientingByFlankerConflict_ANT_VR_B_RT <- function(res) {
  getOrientingByFlankerConflict(
    res$Id,
    res$VR_B_RT_DC_FC,
    res$VR_B_RT_DC_FIC,
    res$VR_B_RT_VC_FC,
    res$VR_B_RT_VC_FIC,
    "ANT-VR Balanced",
    "Reaction Time (ms)",
    3
  )
}

getOrientingByFlankerConflict_ANT_VR_B_RT_All <- function() {
  res <- getResults_All()
  getOrientingByFlankerConflict_ANT_VR_B_RT(res)
}

getOrientingByFlankerConflict_ANT_VR_B_ACC <- function(res) {
  getOrientingByFlankerConflict(
    res$Id,
    res$VR_B_ACC_DC_FC,
    res$VR_B_ACC_DC_FIC,
    res$VR_B_ACC_VC_FC,
    res$VR_B_ACC_VC_FIC,
    "ANT-VR Balanced",
    "Accuracy (%)",
    5
  )
}

getOrientingByFlankerConflict_ANT_VR_B_ACC_All <- function() {
  res <- getResults_All()
  getOrientingByFlankerConflict_ANT_VR_B_ACC(res)
}

################################################################################

# Cue Validity by Flanker Conflict Interaction Plot
getCueValidityByFlankerConflict <- function(id,
                                            vc_FC,
                                            vc_FIC,
                                            ivc_FC,
                                            ivc_FIC,
                                            experimentName,
                                            yAxisLabel,
                                            digits) {
  if (!require(tidyverse)) {
    install.packages("tidyverse")
  }
  if (!require(rstatix)) {
    install.packages("rstatix")
  }
  if (!require(FSA)) {
    install.packages("FSA")
  }
  if (!require(ggplot2)) {
    install.packages("ggplot2")
  }
  library(tidyverse)
  library(rstatix)
  library(FSA)
  library(ggplot2)

  resultSet <- data.frame(
    Id = integer(0),
    CueValidity = character(0),
    FlankerCongruency = character(0),
    ValueCol = numeric(0)
  )

  for (row in 1:length(id)) {
    resultSet <- (
      resultSet %>% add_row(
        Id = id[row],
        CueValidity = "valid",
        FlankerCongruency = "congruent",
        ValueCol = vc_FC[row]
      )
      %>% add_row(
          Id = id[row],
          CueValidity = "valid",
          FlankerCongruency = "incongruent",
          ValueCol = vc_FIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueValidity = "invalid",
          FlankerCongruency = "congruent",
          ValueCol = ivc_FC[row]
        )
        %>% add_row(
          Id = id[row],
          CueValidity = "invalid",
          FlankerCongruency = "incongruent",
          ValueCol = ivc_FIC[row]
        )
    )
  }

  result <- Summarize(
    ValueCol ~ CueValidity + FlankerCongruency + CueValidity:FlankerCongruency,
    data = resultSet,
    digits = digits
  )

  result$se <- result$sd / sqrt(result$n)
  result$se <- signif(result$se, digits = digits)

  result$CueValidity <- factor(result$CueValidity, levels = c("valid", "invalid"))

  pd <- position_dodge(.0)

  ggplot(result, aes(x = CueValidity, y = mean, group = FlankerCongruency)) +
    geom_errorbar(
      aes(ymin = mean - se, ymax = mean + se),
      width = .4,
      size = 0.7,
      position = pd
    ) +
    geom_point(
      shape = 15,
      size = 2,
      position = pd
    ) +
    geom_line(size = 0.8, aes(linetype = FlankerCongruency)) +
    scale_linetype_manual(values = c("solid", "dashed"), name = "Congruency", labels = function(x) {
      sapply(x, function(y) {
        paste0(toupper(substr(y, 1, 1)), substr(y, 2, nchar(y)))
      })
    }) +
    theme_apa() +
    theme(axis.title = element_text(face = "bold")) +
    theme(text = element_text(family = "Times")) +
    labs(x = "Cue Type", y = yAxisLabel, col = "Congruency")
}

getCueValidityByFlankerConflict_ANT_R_RT <- function(res) {
  getCueValidityByFlankerConflict(
    res$Id,
    res$R_RT_VC_FC,
    res$R_RT_VC_FIC,
    res$R_RT_IVC_FC,
    res$R_RT_IVC_FIC,
    "ANT-R",
    "Reaction Time (ms)",
    3
  )
}

getCueValidityByFlankerConflict_ANT_R_RT_All <- function() {
  res <- getResults_All()
  getCueValidityByFlankerConflict_ANT_R_RT(res)
}

getCueValidityByFlankerConflict_ANT_R_ACC <- function(res) {
  getCueValidityByFlankerConflict(
    res$Id,
    res$R_ACC_VC_FC,
    res$R_ACC_VC_FIC,
    res$R_ACC_IVC_FC,
    res$R_ACC_IVC_FIC,
    "ANT-R",
    "Accuracy (%)",
    5
  )
}

getCueValidityByFlankerConflict_ANT_R_ACC_All <- function() {
  res <- getResults_All()
  getCueValidityByFlankerConflict_ANT_R_ACC(res)
}

getCueValidityByFlankerConflict_ANT_VR_RT <- function(res) {
  getCueValidityByFlankerConflict(
    res$Id,
    res$VR_RT_VC_FC,
    res$VR_RT_VC_FIC,
    res$VR_RT_IVC_FC,
    res$VR_RT_IVC_FIC,
    "ANT-VR",
    "Reaction Time (ms)",
    3
  )
}

getCueValidityByFlankerConflict_ANT_VR_RT_All <- function() {
  res <- getResults_All()
  getCueValidityByFlankerConflict_ANT_VR_RT(res)
}

getCueValidityByFlankerConflict_ANT_VR_ACC <- function(res) {
  getCueValidityByFlankerConflict(
    res$Id,
    res$VR_ACC_VC_FC,
    res$VR_ACC_VC_FIC,
    res$VR_ACC_IVC_FC,
    res$VR_ACC_IVC_FIC,
    "ANT-VR",
    "Accuracy (%)",
    5
  )
}

getCueValidityByFlankerConflict_ANT_VR_ACC_All <- function() {
  res <- getResults_All()
  getCueValidityByFlankerConflict_ANT_VR_ACC(res)
}

getCueValidityByFlankerConflict_ANT_VR_B_RT <- function(res) {
  getCueValidityByFlankerConflict(
    res$Id,
    res$VR_B_RT_VC_FC,
    res$VR_B_RT_VC_FIC,
    res$VR_B_RT_IVC_FC,
    res$VR_B_RT_IVC_FIC,
    "ANT-VR Balanced",
    "Reaction Time (ms)",
    3
  )
}

getCueValidityByFlankerConflict_ANT_VR_B_RT_All <- function() {
  res <- getResults_All()
  getCueValidityByFlankerConflict_ANT_VR_B_RT(res)
}

getCueValidityByFlankerConflict_ANT_VR_B_ACC <- function(res) {
  getCueValidityByFlankerConflict(
    res$Id,
    res$VR_B_ACC_VC_FC,
    res$VR_B_ACC_VC_FIC,
    res$VR_B_ACC_IVC_FC,
    res$VR_B_ACC_IVC_FIC,
    "ANT-VR Balanced",
    "Accuracy (%)",
    5
  )
}

getCueValidityByFlankerConflict_ANT_VR_B_ACC_All <- function() {
  res <- getResults_All()
  getCueValidityByFlankerConflict_ANT_VR_B_ACC(res)
}

################################################################################

# Flanker Congruency by Location Congruency
getFlankerCongruencyByLocationCongruency <- function(id,
                                                     fc_LC,
                                                     fc_LIC,
                                                     fic_LC,
                                                     fic_LIC,
                                                     experimentName,
                                                     yAxisLabel,
                                                     digits) {
  if (!require(tidyverse)) {
    install.packages("tidyverse")
  }
  if (!require(rstatix)) {
    install.packages("rstatix")
  }
  if (!require(FSA)) {
    install.packages("FSA")
  }
  if (!require(ggplot2)) {
    install.packages("ggplot2")
  }
  library(tidyverse)
  library(rstatix)
  library(FSA)
  library(ggplot2)

  resultSet <- data.frame(
    Id = integer(0),
    LocationCongruency = character(0),
    FlankerCongruency = character(0),
    ValueCol = numeric(0)
  )

  for (row in 1:length(id)) {
    resultSet <- (
      resultSet %>% add_row(
        Id = id[row],
        LocationCongruency = "congruent",
        FlankerCongruency = "congruent",
        ValueCol = fc_LC[row]
      )
      %>% add_row(
          Id = id[row],
          LocationCongruency = "congruent",
          FlankerCongruency = "incongruent",
          ValueCol = fic_LC[row]
        )
        %>% add_row(
          Id = id[row],
          LocationCongruency = "incongruent",
          FlankerCongruency = "congruent",
          ValueCol = fc_LIC[row]
        )
        %>% add_row(
          Id = id[row],
          LocationCongruency = "incongruent",
          FlankerCongruency = "incongruent",
          ValueCol = fic_LIC[row]
        )
    )
  }

  result <- Summarize(
    ValueCol ~ LocationCongruency + FlankerCongruency + LocationCongruency:FlankerCongruency,
    data = resultSet,
    digits = digits
  )

  result$se <- result$sd / sqrt(result$n)
  result$se <- signif(result$se, digits = digits)

  result$CueValidity <- factor(result$LocationCongruency,
    levels = c("congruent", "incongruent")
  )

  pd <- position_dodge(.0)

  ggplot(
    result,
    aes(x = LocationCongruency, y = mean, group = FlankerCongruency)
  ) +
    geom_errorbar(
      aes(ymin = mean - se, ymax = mean + se),
      width = .4,
      size = 0.7,
      position = pd
    ) +
    geom_point(
      shape = 15,
      size = 2,
      position = pd
    ) +
    geom_line(size = 0.8, aes(linetype = FlankerCongruency)) +
    scale_linetype_manual(values = c("solid", "dashed"), name = "Congruency") +
    theme_apa() +
    theme(axis.title = element_text(face = "bold")) +
    labs(x = "Location Congruency", y = yAxisLabel, col = "Congruency")
}

getFlankerCongruencyByLocationCongruency_ANT_R_RT <- function(res) {
  getFlankerCongruencyByLocationCongruency(
    res$Id,
    res$R_RT_FC_LC,
    res$R_RT_FC_LIC,
    res$R_RT_FIC_LC,
    res$R_RT_FIC_LIC,
    "ANT-R",
    "Reaction Time (ms)",
    3
  )
}

getFlankerCongruencyByLocationCongruency_ANT_R_RT_All <- function() {
  res <- getResults_All()
  getFlankerCongruencyByLocationCongruency_ANT_R_RT(res)
}

getFlankerCongruencyByLocationCongruency_ANT_R_ACC <- function(res) {
  getFlankerCongruencyByLocationCongruency(
    res$Id,
    res$R_ACC_FC_LC,
    res$R_ACC_FC_LIC,
    res$R_ACC_FIC_LC,
    res$R_ACC_FIC_LIC,
    "ANT-R",
    "Accuracy (%)",
    5
  )
}

getFlankerCongruencyByLocationCongruency_ANT_R_ACC_All <- function() {
  res <- getResults_All()
  getFlankerCongruencyByLocationCongruency_ANT_R_ACC(res)
}

getFlankerCongruencyByLocationCongruency_ANT_VR_RT <- function(res) {
  getFlankerCongruencyByLocationCongruency(
    res$Id,
    res$VR_RT_FC_LC,
    res$VR_RT_FC_LIC,
    res$VR_RT_FIC_LC,
    res$VR_RT_FIC_LIC,
    "ANT-VR",
    "Reaction Time (ms)",
    3
  )
}

getFlankerCongruencyByLocationCongruency_ANT_VR_RT_All <- function() {
  res <- getResults_All()
  getFlankerCongruencyByLocationCongruency_ANT_VR_RT(res)
}

getFlankerCongruencyByLocationCongruency_ANT_VR_ACC <- function(res) {
  getFlankerCongruencyByLocationCongruency(
    res$Id,
    res$VR_ACC_FC_LC,
    res$VR_ACC_FC_LIC,
    res$VR_ACC_FIC_LC,
    res$VR_ACC_FIC_LIC,
    "ANT-VR",
    "Accuracy (%)",
    5
  )
}

getFlankerCongruencyByLocationCongruency_ANT_VR_ACC_All <- function() {
  res <- getResults_All()
  getFlankerCongruencyByLocationCongruency_ANT_VR_ACC(res)
}

getFlankerCongruencyByLocationCongruency_ANT_VR_B_RT <- function(res) {
  getFlankerCongruencyByLocationCongruency(
    res$Id,
    res$VR_B_RT_FC_LC,
    res$VR_B_RT_FC_LIC,
    res$VR_B_RT_FIC_LC,
    res$VR_B_RT_FIC_LIC,
    "ANT-VR Balanced",
    "Reaction Time (ms)",
    3
  )
}

getFlankerCongruencyByLocationCongruency_ANT_VR_B_RT_All <- function() {
  res <- getResults_All()
  getFlankerCongruencyByLocationCongruency_ANT_VR_B_RT(res)
}

getFlankerCongruencyByLocationCongruency_ANT_VR_B_ACC <- function(res) {
  getFlankerCongruencyByLocationCongruency(
    res$Id,
    res$VR_B_ACC_FC_LC,
    res$VR_B_ACC_FC_LIC,
    res$VR_B_ACC_FIC_LC,
    res$VR_B_ACC_FIC_LIC,
    "ANT-VR Balanced",
    "Accuracy (%)",
    5
  )
}

getFlankerCongruencyByLocationCongruency_ANT_VR_B_ACC_All <- function() {
  res <- getResults_All()
  getFlankerCongruencyByLocationCongruency_ANT_VR_B_ACC(res)
}

################################################################################

# Alerting by Location Conflict Interaction Plot
getAlertingByLocationConflict <- function(id,
                                          nc_LC,
                                          nc_LIC,
                                          dc_0_LC,
                                          dc_0_LIC,
                                          dc_400_LC,
                                          dc_400_LIC,
                                          dc_800_LC,
                                          dc_800_LIC,
                                          experimentName,
                                          yAxisLabel,
                                          digits) {
  if (!require(tidyverse)) {
    install.packages("tidyverse")
  }
  if (!require(rstatix)) {
    install.packages("rstatix")
  }
  if (!require(FSA)) {
    install.packages("FSA")
  }
  if (!require(ggplot2)) {
    install.packages("ggplot2")
  }
  library(tidyverse)
  library(rstatix)
  library(FSA)
  library(ggplot2)

  resultSet <- data.frame(
    Id = integer(0),
    CueToTarget = character(0),
    LocationCongruency = character(0),
    ValueCol = numeric(0)
  )

  for (row in 1:length(id)) {
    resultSet <- (
      resultSet %>% add_row(
        Id = id[row],
        CueToTarget = "no-cue",
        LocationCongruency = "congruent",
        ValueCol = nc_LC[row]
      )
      %>% add_row(
          Id = id[row],
          CueToTarget = "no-cue",
          LocationCongruency = "incongruent",
          ValueCol = nc_LIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "0",
          LocationCongruency = "congruent",
          ValueCol = dc_0_LC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "0",
          LocationCongruency = "incongruent",
          ValueCol = dc_0_LIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "400",
          LocationCongruency = "congruent",
          ValueCol = dc_400_LC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "400",
          LocationCongruency = "incongruent",
          ValueCol = dc_400_LIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "800",
          LocationCongruency = "congruent",
          ValueCol = dc_800_LC[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "800",
          LocationCongruency = "incongruent",
          ValueCol = dc_800_LIC[row]
        )
    )
  }

  result <- Summarize(
    ValueCol ~ CueToTarget + LocationCongruency + CueToTarget:LocationCongruency,
    data = resultSet,
    digits = digits
  )

  result$se <- result$sd / sqrt(result$n)
  result$se <- signif(result$se, digits = digits)

  result$CueToTarget <- factor(result$CueToTarget, levels = c("no-cue", "0", "400", "800"))

  pd <- position_dodge(.0)

  ggplot(
    result,
    aes(x = CueToTarget, y = mean, group = LocationCongruency)
  ) +
    geom_errorbar(
      aes(ymin = mean - se, ymax = mean + se),
      width = .4,
      size = 0.7,
      position = pd
    ) +
    geom_point(
      shape = 15,
      size = 2,
      position = pd
    ) +
    geom_line(size = 0.8, aes(linetype = LocationCongruency)) +
    scale_linetype_manual(values = c("solid", "dashed"), name = "Congruency") +
    theme_apa() +
    theme(axis.title = element_text(face = "bold")) +
    labs(x = "Cue-Target Interval (ms)", y = yAxisLabel, col = "Congruency")
}

getAlertingByLocationConflict_ANT_R_RT <- function(res) {
  getAlertingByLocationConflict(
    res$Id,
    res$R_RT_NC_LC,
    res$R_RT_NC_LIC,
    res$R_RT_DC_0_LC,
    res$R_RT_DC_0_LIC,
    res$R_RT_DC_400_LC,
    res$R_RT_DC_400_LIC,
    res$R_RT_DC_800_LC,
    res$R_RT_DC_800_LIC,
    "ANT-R",
    "Reaction Time (ms)",
    3
  )
}

getAlertingByLocationConflict_ANT_R_RT_All <- function() {
  res <- getResults_All()
  getAlertingByLocationConflict_ANT_R_RT(res)
}

getAlertingByLocationConflict_ANT_R_ACC <- function(res) {
  getAlertingByLocationConflict(
    res$Id,
    res$R_ACC_NC_LC,
    res$R_ACC_NC_LIC,
    res$R_ACC_DC_0_LC,
    res$R_ACC_DC_0_LIC,
    res$R_ACC_DC_400_LC,
    res$R_ACC_DC_400_LIC,
    res$R_ACC_DC_800_LC,
    res$R_ACC_DC_800_LIC,
    "ANT-R",
    "Accuracy (%)",
    5
  )
}

getAlertingByLocationConflict_ANT_R_ACC_All <- function() {
  res <- getResults_All()
  getAlertingByLocationConflict_ANT_R_ACC(res)
}

getAlertingByLocationConflict_ANT_VR_RT <- function(res) {
  getAlertingByLocationConflict(
    res$Id,
    res$VR_RT_NC_LC,
    res$VR_RT_NC_LIC,
    res$VR_RT_DC_0_LC,
    res$VR_RT_DC_0_LIC,
    res$VR_RT_DC_400_LC,
    res$VR_RT_DC_400_LIC,
    res$VR_RT_DC_800_LC,
    res$VR_RT_DC_800_LIC,
    "ANT-VR",
    "Reaction Time (ms)",
    3
  )
}

getAlertingByLocationConflict_ANT_VR_RT_All <- function() {
  res <- getResults_All()
  getAlertingByLocationConflict_ANT_VR_RT(res)
}

getAlertingByLocationConflict_ANT_VR_ACC <- function(res) {
  getAlertingByLocationConflict(
    res$Id,
    res$VR_ACC_NC_LC,
    res$VR_ACC_NC_LIC,
    res$VR_ACC_DC_0_LC,
    res$VR_ACC_DC_0_LIC,
    res$VR_ACC_DC_400_LC,
    res$VR_ACC_DC_400_LIC,
    res$VR_ACC_DC_800_LC,
    res$VR_ACC_DC_800_LIC,
    "ANT-VR",
    "Accuracy (%)",
    5
  )
}

getAlertingByLocationConflict_ANT_VR_ACC_All <- function() {
  res <- getResults_All()
  getAlertingByLocationConflict_ANT_VR_ACC(res)
}

getAlertingByLocationConflict_ANT_VR_B_RT <- function(res) {
  getAlertingByLocationConflict(
    res$Id,
    res$VR_B_RT_NC_LC,
    res$VR_B_RT_NC_LIC,
    res$VR_B_RT_DC_0_LC,
    res$VR_B_RT_DC_0_LIC,
    res$VR_B_RT_DC_400_LC,
    res$VR_B_RT_DC_400_LIC,
    res$VR_B_RT_DC_800_LC,
    res$VR_B_RT_DC_800_LIC,
    "ANT-VR Balanced",
    "Reaction Time (ms)",
    3
  )
}

getAlertingByLocationConflict_ANT_VR_B_RT_All <- function() {
  res <- getResults_All()
  getAlertingByLocationConflict_ANT_VR_B_RT(res)
}

getAlertingByLocationConflict_ANT_VR_B_ACC <- function(res) {
  getAlertingByLocationConflict(
    res$Id,
    res$VR_B_ACC_NC_LC,
    res$VR_B_ACC_NC_LIC,
    res$VR_B_ACC_DC_0_LC,
    res$VR_B_ACC_DC_0_LIC,
    res$VR_B_ACC_DC_400_LC,
    res$VR_B_ACC_DC_400_LIC,
    res$VR_B_ACC_DC_800_LC,
    res$VR_B_ACC_DC_800_LIC,
    "ANT-VR Balanced",
    "Accuracy (%)",
    5
  )
}

getAlertingByLocationConflict_ANT_VR_B_ACC_All <- function() {
  res <- getResults_All()
  getAlertingByLocationConflict_ANT_VR_B_ACC(res)
}

################################################################################

# Orienting by Location Conflict Interaction Plot
getOrientingByLocationConflict <- function(id,
                                           dc_LC,
                                           dc_LIC,
                                           vc_LC,
                                           vc_LIC,
                                           experimentName,
                                           yAxisLabel,
                                           digits) {
  if (!require(tidyverse)) {
    install.packages("tidyverse")
  }
  if (!require(rstatix)) {
    install.packages("rstatix")
  }
  if (!require(FSA)) {
    install.packages("FSA")
  }
  if (!require(ggplot2)) {
    install.packages("ggplot2")
  }
  library(tidyverse)
  library(rstatix)
  library(FSA)
  library(ggplot2)

  resultSet <- data.frame(
    Id = integer(0),
    CueValidity = character(0),
    LocationCongruency = character(0),
    ValueCol = numeric(0)
  )

  for (row in 1:length(id)) {
    resultSet <- (
      resultSet %>% add_row(
        Id = id[row],
        CueValidity = "double",
        LocationCongruency = "congruent",
        ValueCol = dc_LC[row]
      )
      %>% add_row(
          Id = id[row],
          CueValidity = "double",
          LocationCongruency = "incongruent",
          ValueCol = dc_LIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueValidity = "valid",
          LocationCongruency = "congruent",
          ValueCol = vc_LC[row]
        )
        %>% add_row(
          Id = id[row],
          CueValidity = "valid",
          LocationCongruency = "incongruent",
          ValueCol = vc_LIC[row]
        )
    )
  }

  result <- Summarize(
    ValueCol ~ CueValidity + LocationCongruency + CueValidity:LocationCongruency,
    data = resultSet,
    digits = digits
  )

  result$se <- result$sd / sqrt(result$n)
  result$se <- signif(result$se, digits = digits)

  result$CueValidity <- factor(result$CueValidity, levels = c("double", "valid"))

  pd <- position_dodge(.0)

  ggplot(
    result,
    aes(x = CueValidity, y = mean, group = LocationCongruency)
  ) +
    geom_errorbar(
      aes(ymin = mean - se, ymax = mean + se),
      width = .4,
      size = 0.7,
      position = pd
    ) +
    geom_point(
      shape = 15,
      size = 2,
      position = pd
    ) +
    geom_line(size = 0.8, aes(linetype = LocationCongruency)) +
    scale_linetype_manual(values = c("solid", "dashed"), name = "Congruency") +
    theme_apa() +
    theme(axis.title = element_text(face = "bold")) +
    labs(x = "Cue Type", y = yAxisLabel, col = "Congruency")
}

getOrientingByLocationConflict_ANT_R_RT <- function(res) {
  getOrientingByLocationConflict(
    res$Id,
    res$R_RT_DC_LC,
    res$R_RT_DC_LIC,
    res$R_RT_VC_LC,
    res$R_RT_VC_LIC,
    "ANT-R",
    "Reaction Time (ms)",
    3
  )
}

getOrientingByLocationConflict_ANT_R_RT_All <- function() {
  res <- getResults_All()
  getOrientingByLocationConflict_ANT_R_RT(res)
}

getOrientingByLocationConflict_ANT_R_ACC <- function(res) {
  getOrientingByLocationConflict(
    res$Id,
    res$R_ACC_DC_LC,
    res$R_ACC_DC_LIC,
    res$R_ACC_VC_LC,
    res$R_ACC_VC_LIC,
    "ANT-R",
    "Accuracy (%)",
    5
  )
}

getOrientingByLocationConflict_ANT_R_ACC_All <- function() {
  res <- getResults_All()
  getOrientingByLocationConflict_ANT_R_ACC(res)
}

getOrientingByLocationConflict_ANT_VR_RT <- function(res) {
  getOrientingByLocationConflict(
    res$Id,
    res$VR_RT_DC_LC,
    res$VR_RT_DC_LIC,
    res$VR_RT_VC_LC,
    res$VR_RT_VC_LIC,
    "ANT-VR",
    "Reaction Time (ms)",
    3
  )
}

getOrientingByLocationConflict_ANT_VR_RT_All <- function() {
  res <- getResults_All()
  getOrientingByLocationConflict_ANT_VR_RT(res)
}

getOrientingByLocationConflict_ANT_VR_ACC <- function(res) {
  getOrientingByLocationConflict(
    res$Id,
    res$VR_ACC_DC_LC,
    res$VR_ACC_DC_LIC,
    res$VR_ACC_VC_LC,
    res$VR_ACC_VC_LIC,
    "ANT-VR",
    "Accuracy (%)",
    5
  )
}

getOrientingByLocationConflict_ANT_VR_ACC_All <- function() {
  res <- getResults_All()
  getOrientingByLocationConflict_ANT_VR_ACC(res)
}

getOrientingByLocationConflict_ANT_VR_B_RT <- function(res) {
  getOrientingByLocationConflict(
    res$Id,
    res$VR_B_RT_DC_LC,
    res$VR_B_RT_DC_LIC,
    res$VR_B_RT_VC_LC,
    res$VR_B_RT_VC_LIC,
    "ANT-VR Balanced",
    "Reaction Time (ms)",
    3
  )
}

getOrientingByLocationConflict_ANT_VR_B_RT_All <- function() {
  res <- getResults_All()
  getOrientingByLocationConflict_ANT_VR_B_RT(res)
}

getOrientingByLocationConflict_ANT_VR_B_ACC <- function(res) {
  getOrientingByLocationConflict(
    res$Id,
    res$VR_B_ACC_DC_LC,
    res$VR_B_ACC_DC_LIC,
    res$VR_B_ACC_VC_LC,
    res$VR_B_ACC_VC_LIC,
    "ANT-VR Balanced",
    "Accuracy (%)",
    5
  )
}

getOrientingByLocationConflict_ANT_VR_B_ACC_All <- function() {
  res <- getResults_All()
  getOrientingByLocationConflict_ANT_VR_B_ACC(res)
}

################################################################################

# Cue Validity by Location Conflict Interaction Plot
getCueValidityByLocationConflict <- function(id,
                                             vc_LC,
                                             vc_LIC,
                                             ivc_LC,
                                             ivc_LIC,
                                             experimentName,
                                             yAxisLabel,
                                             digits) {
  if (!require(tidyverse)) {
    install.packages("tidyverse")
  }
  if (!require(rstatix)) {
    install.packages("rstatix")
  }
  if (!require(FSA)) {
    install.packages("FSA")
  }
  if (!require(ggplot2)) {
    install.packages("ggplot2")
  }
  library(tidyverse)
  library(rstatix)
  library(FSA)
  library(ggplot2)

  resultSet <- data.frame(
    Id = integer(0),
    CueValidity = character(0),
    LocationCongruency = character(0),
    ValueCol = numeric(0)
  )

  for (row in 1:length(id)) {
    resultSet <- (
      resultSet %>% add_row(
        Id = id[row],
        CueValidity = "valid",
        LocationCongruency = "congruent",
        ValueCol = vc_LC[row]
      )
      %>% add_row(
          Id = id[row],
          CueValidity = "valid",
          LocationCongruency = "incongruent",
          ValueCol = vc_LIC[row]
        )
        %>% add_row(
          Id = id[row],
          CueValidity = "invalid",
          LocationCongruency = "congruent",
          ValueCol = ivc_LC[row]
        )
        %>% add_row(
          Id = id[row],
          CueValidity = "invalid",
          LocationCongruency = "incongruent",
          ValueCol = ivc_LIC[row]
        )
    )
  }

  result <- Summarize(
    ValueCol ~ CueValidity + LocationCongruency + CueValidity:LocationCongruency,
    data = resultSet,
    digits = digits
  )

  result$se <- result$sd / sqrt(result$n)
  result$se <- signif(result$se, digits = digits)

  result$CueValidity <- factor(result$CueValidity, levels = c("valid", "invalid"))

  pd <- position_dodge(.0)

  ggplot(
    result,
    aes(x = CueValidity, y = mean, group = LocationCongruency)
  ) +
    geom_errorbar(
      aes(ymin = mean - se, ymax = mean + se),
      width = .4,
      size = 0.7,
      position = pd
    ) +
    geom_point(
      shape = 15,
      size = 2,
      position = pd
    ) +
    geom_line(size = 0.8, aes(linetype = LocationCongruency)) +
    scale_linetype_manual(values = c("solid", "dashed"), name = "Congruency") +
    theme_apa() +
    theme(axis.title = element_text(face = "bold")) +
    labs(x = "Cue Validity", y = yAxisLabel, col = "Congruency")
}

getCueValidityByLocationConflict_ANT_R_RT <- function(res) {
  getCueValidityByLocationConflict(
    res$Id,
    res$R_RT_VC_LC,
    res$R_RT_VC_LIC,
    res$R_RT_IVC_LC,
    res$R_RT_IVC_LIC,
    "ANT-R",
    "Reaction Time (ms)",
    3
  )
}

getCueValidityByLocationConflict_ANT_R_RT_All <- function() {
  res <- getResults_All()
  getCueValidityByLocationConflict_ANT_R_RT(res)
}

getCueValidityByLocationConflict_ANT_R_ACC <- function(res) {
  getCueValidityByLocationConflict(
    res$Id,
    res$R_ACC_VC_LC,
    res$R_ACC_VC_LIC,
    res$R_ACC_IVC_LC,
    res$R_ACC_IVC_LIC,
    "ANT-R",
    "Accuracy (%)",
    5
  )
}

getCueValidityByLocationConflict_ANT_R_ACC_All <- function() {
  res <- getResults_All()
  getCueValidityByLocationConflict_ANT_R_ACC(res)
}

getCueValidityByLocationConflict_ANT_VR_RT <- function(res) {
  getCueValidityByLocationConflict(
    res$Id,
    res$VR_RT_VC_LC,
    res$VR_RT_VC_LIC,
    res$VR_RT_IVC_LC,
    res$VR_RT_IVC_LIC,
    "ANT-VR",
    "Reaction Time (ms)",
    3
  )
}

getCueValidityByLocationConflict_ANT_VR_RT_All <- function() {
  res <- getResults_All()
  getCueValidityByLocationConflict_ANT_VR_RT(res)
}

getCueValidityByLocationConflict_ANT_VR_ACC <- function(res) {
  getCueValidityByLocationConflict(
    res$Id,
    res$VR_ACC_VC_LC,
    res$VR_ACC_VC_LIC,
    res$VR_ACC_IVC_LC,
    res$VR_ACC_IVC_LIC,
    "ANT-VR",
    "Accuracy (%)",
    5
  )
}

getCueValidityByLocationConflict_ANT_VR_ACC_All <- function() {
  res <- getResults_All()
  getCueValidityByLocationConflict_ANT_VR_ACC(res)
}

getCueValidityByLocationConflict_ANT_VR_B_RT <- function(res) {
  getCueValidityByLocationConflict(
    res$Id,
    res$VR_B_RT_VC_LC,
    res$VR_B_RT_VC_LIC,
    res$VR_B_RT_IVC_LC,
    res$VR_B_RT_IVC_LIC,
    "ANT-VR Balanced",
    "Reaction Time (ms)",
    3
  )
}

getCueValidityByLocationConflict_ANT_VR_B_RT_All <- function() {
  res <- getResults_All()
  getCueValidityByLocationConflict_ANT_VR_B_RT(res)
}

getCueValidityByLocationConflict_ANT_VR_B_ACC <- function(res) {
  getCueValidityByLocationConflict(
    res$Id,
    res$VR_B_ACC_VC_LC,
    res$VR_B_ACC_VC_LIC,
    res$VR_B_ACC_IVC_LC,
    res$VR_B_ACC_IVC_LIC,
    "ANT-VR Balanced",
    "Accuracy (%)",
    5
  )
}

getCueValidityByLocationConflict_ANT_VR_B_ACC_All <- function() {
  res <- getResults_All()
  getCueValidityByLocationConflict_ANT_VR_B_ACC(res)
}

################################################################################

# Cue to Target Interval by Cue Validity Interaction Plot
getCueToTargetIntervalByCueValidity <- function(id,
                                                vc_0,
                                                vc_400,
                                                vc_800,
                                                ivc_0,
                                                ivc_400,
                                                ivc_800,
                                                experimentName,
                                                yAxisLabel,
                                                digits) {
  if (!require(tidyverse)) {
    install.packages("tidyverse")
  }
  if (!require(rstatix)) {
    install.packages("rstatix")
  }
  if (!require(FSA)) {
    install.packages("FSA")
  }
  if (!require(ggplot2)) {
    install.packages("ggplot2")
  }
  library(tidyverse)
  library(rstatix)
  library(FSA)
  library(ggplot2)

  resultSet <- data.frame(
    Id = integer(0),
    CueValidity = character(0),
    CueToTarget = character(0),
    ValueCol = numeric(0)
  )

  for (row in 1:length(id)) {
    resultSet <- (
      resultSet %>% add_row(
        Id = id[row],
        CueValidity = "valid",
        CueToTarget = "0",
        ValueCol = vc_0[row]
      )
      %>% add_row(
          Id = id[row],
          CueValidity = "valid",
          CueToTarget = "400",
          ValueCol = vc_400[row]
        )
        %>% add_row(
          Id = id[row],
          CueValidity = "valid",
          CueToTarget = "800",
          ValueCol = vc_800[row]
        )
        %>% add_row(
          Id = id[row],
          CueValidity = "invalid",
          CueToTarget = "0",
          ValueCol = ivc_0[row]
        )
        %>% add_row(
          Id = id[row],
          CueValidity = "invalid",
          CueToTarget = "400",
          ValueCol = ivc_400[row]
        )
        %>% add_row(
          Id = id[row],
          CueValidity = "invalid",
          CueToTarget = "800",
          ValueCol = ivc_800[row]
        )
    )
  }

  result <- Summarize(
    ValueCol ~ CueToTarget + CueValidity + CueToTarget:CueValidity,
    data = resultSet,
    digits = digits
  )

  result$se <- result$sd / sqrt(result$n)
  result$se <- signif(result$se, digits = digits)

  result$CueToTarget <- factor(result$CueToTarget, levels = c("0", "400", "800"))

  pd <- position_dodge(.0)

  ggplot(result, aes(x = CueToTarget, y = mean, group = CueValidity)) +
    geom_errorbar(
      aes(ymin = mean - se, ymax = mean + se),
      width = .4,
      size = 0.7,
      position = pd
    ) +
    geom_point(
      shape = 15,
      size = 2,
      position = pd
    ) +
    geom_line(size = 0.8, aes(linetype = CueValidity)) +
    scale_linetype_manual(values = c("dashed", "solid"), name = "Cue Validity") +
    theme_apa() +
    theme(axis.title = element_text(face = "bold")) +
    labs(x = "Cue-Target Interval (ms)", y = yAxisLabel, col = "Cue Validity")
}

getCueToTargetIntervalByCueValidity_ANT_R_RT <- function(res) {
  getCueToTargetIntervalByCueValidity(
    res$Id,
    res$R_RT_VC_0,
    res$R_RT_VC_400,
    res$R_RT_VC_800,
    res$R_RT_IVC_0,
    res$R_RT_IVC_400,
    res$R_RT_IVC_800,
    "ANT-R",
    "Reaction Time (ms)",
    3
  )
}

getCueToTargetIntervalByCueValidity_ANT_R_RT_All <- function() {
  res <- getResults_All()
  getCueToTargetIntervalByCueValidity_ANT_R_RT(res)
}

getCueToTargetIntervalByCueValidity_ANT_R_ACC <- function(res) {
  getCueToTargetIntervalByCueValidity(
    res$Id,
    res$R_ACC_VC_0,
    res$R_ACC_VC_400,
    res$R_ACC_VC_800,
    res$R_ACC_IVC_0,
    res$R_ACC_IVC_400,
    res$R_ACC_IVC_800,
    "ANT-R",
    "Accuracy (%)",
    5
  )
}

getCueToTargetIntervalByCueValidity_ANT_R_ACC_All <- function() {
  res <- getResults_All()
  getCueToTargetIntervalByCueValidity_ANT_R_ACC(res)
}

getCueToTargetIntervalByCueValidity_ANT_VR_RT <- function(res) {
  getCueToTargetIntervalByCueValidity(
    res$Id,
    res$VR_RT_VC_0,
    res$VR_RT_VC_400,
    res$VR_RT_VC_800,
    res$VR_RT_IVC_0,
    res$VR_RT_IVC_400,
    res$VR_RT_IVC_800,
    "ANT-VR",
    "Reaction Time (ms)",
    3
  )
}

getCueToTargetIntervalByCueValidity_ANT_VR_RT_All <- function() {
  res <- getResults_All()
  getCueToTargetIntervalByCueValidity_ANT_VR_RT(res)
}

getCueToTargetIntervalByCueValidity_ANT_VR_ACC <- function(res) {
  getCueToTargetIntervalByCueValidity(
    res$Id,
    res$VR_ACC_VC_0,
    res$VR_ACC_VC_400,
    res$VR_ACC_VC_800,
    res$VR_ACC_IVC_0,
    res$VR_ACC_IVC_400,
    res$VR_ACC_IVC_800,
    "ANT-VR",
    "Accuracy (%)",
    5
  )
}

getCueToTargetIntervalByCueValidity_ANT_VR_ACC_All <- function() {
  res <- getResults_All()
  getCueToTargetIntervalByCueValidity_ANT_VR_ACC(res)
}

getCueToTargetIntervalByCueValidity_ANT_VR_B_RT <- function(res) {
  getCueToTargetIntervalByCueValidity(
    res$Id,
    res$VR_B_RT_VC_0,
    res$VR_B_RT_VC_400,
    res$VR_B_RT_VC_800,
    res$VR_B_RT_IVC_0,
    res$VR_B_RT_IVC_400,
    res$VR_B_RT_IVC_800,
    "ANT-VR Balanced",
    "Reaction Time (ms)",
    3
  )
}

getCueToTargetIntervalByCueValidity_ANT_VR_B_RT_All <- function() {
  res <- getResults_All()
  getCueToTargetIntervalByCueValidity_ANT_VR_B_RT(res)
}

getCueToTargetIntervalByCueValidity_ANT_VR_B_ACC <- function(res) {
  getCueToTargetIntervalByCueValidity(
    res$Id,
    res$VR_B_ACC_VC_0,
    res$VR_B_ACC_VC_400,
    res$VR_B_ACC_VC_800,
    res$VR_B_ACC_IVC_0,
    res$VR_B_ACC_IVC_400,
    res$VR_B_ACC_IVC_800,
    "ANT-VR Balanced",
    "Accuracy (%)",
    5
  )
}

getCueToTargetIntervalByCueValidity_ANT_VR_B_ACC_All <- function() {
  res <- getResults_All()
  getCueToTargetIntervalByCueValidity_ANT_VR_B_ACC(res)
}

################################################################################

# Cue to Target Interval by Cue Type Interaction Plot
getCueToTargetIntervalByCueType <- function(id,
                                            dc_0,
                                            dc_400,
                                            dc_800,
                                            vc_0,
                                            vc_400,
                                            vc_800,
                                            experimentName,
                                            yAxisLabel,
                                            digits) {
  if (!require(tidyverse)) {
    install.packages("tidyverse")
  }
  if (!require(rstatix)) {
    install.packages("rstatix")
  }
  if (!require(FSA)) {
    install.packages("FSA")
  }
  if (!require(ggplot2)) {
    install.packages("ggplot2")
  }
  library(tidyverse)
  library(rstatix)
  library(FSA)
  library(ggplot2)

  resultSet <- data.frame(
    Id = integer(0),
    CueType = character(0),
    CueToTarget = character(0),
    ValueCol = numeric(0)
  )

  for (row in 1:length(id)) {
    resultSet <- (
      resultSet %>% add_row(
        Id = id[row],
        CueType = "double",
        CueToTarget = "0",
        ValueCol = dc_0[row]
      )
      %>% add_row(
          Id = id[row],
          CueType = "double",
          CueToTarget = "400",
          ValueCol = dc_400[row]
        )
        %>% add_row(
          Id = id[row],
          CueType = "double",
          CueToTarget = "800",
          ValueCol = dc_800[row]
        )
        %>% add_row(
          Id = id[row],
          CueType = "valid",
          CueToTarget = "0",
          ValueCol = vc_0[row]
        )
        %>% add_row(
          Id = id[row],
          CueType = "valid",
          CueToTarget = "400",
          ValueCol = vc_400[row]
        )
        %>% add_row(
          Id = id[row],
          CueType = "valid",
          CueToTarget = "800",
          ValueCol = vc_800[row]
        )
    )
  }

  result <- Summarize(
    ValueCol ~ CueToTarget + CueType + CueToTarget:CueType,
    data = resultSet,
    digits = digits
  )

  result$se <- result$sd / sqrt(result$n)
  result$se <- signif(result$se, digits = digits)

  result$CueToTarget <- factor(result$CueToTarget, levels = c("0", "400", "800"))

  pd <- position_dodge(.0)

  ggplot(result, aes(x = CueToTarget, y = mean, group = CueType)) +
    geom_errorbar(
      aes(ymin = mean - se, ymax = mean + se),
      width = .4,
      size = 0.7,
      position = pd
    ) +
    geom_point(
      shape = 15,
      size = 2,
      position = pd
    ) +
    geom_line(size = 0.8, aes(linetype = CueType)) +
    scale_linetype_manual(values = c("dashed", "solid"), name = "Cue Type") +
    theme_apa() +
    theme(axis.title = element_text(face = "bold")) +
    labs(x = "Cue-Target Interval (ms)", y = yAxisLabel, col = "Cue Type")
}

getCueToTargetIntervalByCueType_ANT_R_RT <- function(res) {
  getCueToTargetIntervalByCueType(
    res$Id,
    res$R_RT_DC_0,
    res$R_RT_DC_400,
    res$R_RT_DC_800,
    res$R_RT_VC_0,
    res$R_RT_VC_400,
    res$R_RT_VC_800,
    "ANT-R",
    "Reaction Time (ms)",
    3
  )
}

getCueToTargetIntervalByCueType_ANT_R_RT_All <- function() {
  res <- getResults_All()
  getCueToTargetIntervalByCueType_ANT_R_RT(res)
}

getCueToTargetIntervalByCueType_ANT_R_ACC <- function(res) {
  getCueToTargetIntervalByCueType(
    res$Id,
    res$R_ACC_DC_0,
    res$R_ACC_DC_400,
    res$R_ACC_DC_800,
    res$R_ACC_VC_0,
    res$R_ACC_VC_400,
    res$R_ACC_VC_800,
    "ANT-R",
    "Accuracy (%)",
    5
  )
}

getCueToTargetIntervalByCueType_ANT_R_ACC_All <- function() {
  res <- getResults_All()
  getCueToTargetIntervalByCueType_ANT_R_ACC(res)
}

getCueToTargetIntervalByCueType_ANT_VR_RT <- function(res) {
  getCueToTargetIntervalByCueType(
    res$Id,
    res$VR_RT_DC_0,
    res$VR_RT_DC_400,
    res$VR_RT_DC_800,
    res$VR_RT_VC_0,
    res$VR_RT_VC_400,
    res$VR_RT_VC_800,
    "ANT-VR",
    "Reaction Time (ms)",
    3
  )
}

getCueToTargetIntervalByCueType_ANT_VR_RT_All <- function() {
  res <- getResults_All()
  getCueToTargetIntervalByCueType_ANT_VR_RT(res)
}

getCueToTargetIntervalByCueType_ANT_VR_ACC <- function(res) {
  getCueToTargetIntervalByCueType(
    res$Id,
    res$VR_ACC_DC_0,
    res$VR_ACC_DC_400,
    res$VR_ACC_DC_800,
    res$VR_ACC_VC_0,
    res$VR_ACC_VC_400,
    res$VR_ACC_VC_800,
    "ANT-VR",
    "Accuracy (%)",
    5
  )
}

getCueToTargetIntervalByCueType_ANT_VR_ACC_All <- function() {
  res <- getResults_All()
  getCueToTargetIntervalByCueType_ANT_VR_ACC(res)
}

getCueToTargetIntervalByCueType_ANT_VR_B_RT <- function(res) {
  getCueToTargetIntervalByCueType(
    res$Id,
    res$VR_B_RT_DC_0,
    res$VR_B_RT_DC_400,
    res$VR_B_RT_DC_800,
    res$VR_B_RT_VC_0,
    res$VR_B_RT_VC_400,
    res$VR_B_RT_VC_800,
    "ANT-VR Balanced",
    "Reaction Time (ms)",
    3
  )
}

getCueToTargetIntervalByCueType_ANT_VR_B_RT_All <- function() {
  res <- getResults_All()
  getCueToTargetIntervalByCueType_ANT_VR_B_RT(res)
}

getCueToTargetIntervalByCueType_ANT_VR_B_ACC <- function(res) {
  getCueToTargetIntervalByCueType(
    res$Id,
    res$VR_B_ACC_DC_0,
    res$VR_B_ACC_DC_400,
    res$VR_B_ACC_DC_800,
    res$VR_B_ACC_VC_0,
    res$VR_B_ACC_VC_400,
    res$VR_B_ACC_VC_800,
    "ANT-VR Balanced",
    "Accuracy (%)",
    5
  )
}

getCueToTargetIntervalByCueType_ANT_VR_B_ACC_All <- function() {
  res <- getResults_All()
  getCueToTargetIntervalByCueType_ANT_VR_B_ACC(res)
}

################################################################################

# Cue to Target Interval by Flanker Conflict Interaction Plot
getCueToTargetIntervalByFlankerConflict <- function(id,
                                                    fc_0,
                                                    fc_400,
                                                    fc_800,
                                                    fic_0,
                                                    fic_400,
                                                    fic_800,
                                                    experimentName,
                                                    yAxisLabel,
                                                    digits) {
  if (!require(tidyverse)) {
    install.packages("tidyverse")
  }
  if (!require(rstatix)) {
    install.packages("rstatix")
  }
  if (!require(FSA)) {
    install.packages("FSA")
  }
  if (!require(ggplot2)) {
    install.packages("ggplot2")
  }
  library(tidyverse)
  library(rstatix)
  library(FSA)
  library(ggplot2)

  resultSet <- data.frame(
    Id = integer(0),
    CueToTarget = character(0),
    FlankerCongruency = character(0),
    ValueCol = numeric(0)
  )

  for (row in 1:length(id)) {
    resultSet <- (
      resultSet %>% add_row(
        Id = id[row],
        CueToTarget = "0",
        FlankerCongruency = "congruent",
        ValueCol = fc_0[row]
      )
      %>% add_row(
          Id = id[row],
          CueToTarget = "0",
          FlankerCongruency = "incongruent",
          ValueCol = fic_0[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "400",
          FlankerCongruency = "congruent",
          ValueCol = fc_400[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "400",
          FlankerCongruency = "incongruent",
          ValueCol = fic_400[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "800",
          FlankerCongruency = "congruent",
          ValueCol = fc_800[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "800",
          FlankerCongruency = "incongruent",
          ValueCol = fic_800[row]
        )
    )
  }

  result <- Summarize(
    ValueCol ~ CueToTarget + FlankerCongruency + CueToTarget:FlankerCongruency,
    data = resultSet,
    digits = digits
  )

  result$se <- result$sd / sqrt(result$n)
  result$se <- signif(result$se, digits = digits)

  result$CueToTarget <- factor(result$CueToTarget, levels = c("0", "400", "800"))

  pd <- position_dodge(.0)

  ggplot(result, aes(x = CueToTarget, y = mean, group = FlankerCongruency)) +
    geom_errorbar(
      aes(ymin = mean - se, ymax = mean + se),
      width = .4,
      size = 0.7,
      position = pd
    ) +
    geom_point(
      shape = 15,
      size = 2,
      position = pd
    ) +
    geom_line(size = 0.8, aes(linetype = FlankerCongruency)) +
    scale_linetype_manual(values = c("solid", "dashed"), name = "Congruency") +
    theme_apa() +
    theme(axis.title = element_text(face = "bold")) +
    labs(x = "Cue-Target Interval (ms)", y = yAxisLabel, col = "Congruency")
}

getCueToTargetIntervalByFlankerConflict_ANT_R_RT <- function(res) {
  getCueToTargetIntervalByFlankerConflict(
    res$Id,
    res$R_RT_FC_0,
    res$R_RT_FC_400,
    res$R_RT_FC_800,
    res$R_RT_FIC_0,
    res$R_RT_FIC_400,
    res$R_RT_FIC_800,
    "ANT-R",
    "Reaction Time (ms)",
    3
  )
}

getCueToTargetIntervalByFlankerConflict_ANT_R_RT_All <- function() {
  res <- getResults_All()
  getCueToTargetIntervalByFlankerConflict_ANT_R_RT(res)
}

getCueToTargetIntervalByFlankerConflict_ANT_R_ACC <- function(res) {
  getCueToTargetIntervalByFlankerConflict(
    res$Id,
    res$R_ACC_FC_0,
    res$R_ACC_FC_400,
    res$R_ACC_FC_800,
    res$R_ACC_FIC_0,
    res$R_ACC_FIC_400,
    res$R_ACC_FIC_800,
    "ANT-R",
    "Accuracy (%)",
    5
  )
}

getCueToTargetIntervalByFlankerConflict_ANT_R_ACC_All <- function() {
  res <- getResults_All()
  getCueToTargetIntervalByFlankerConflict_ANT_R_ACC(res)
}

getCueToTargetIntervalByFlankerConflict_ANT_VR_RT <- function(res) {
  getCueToTargetIntervalByFlankerConflict(
    res$Id,
    res$VR_RT_FC_0,
    res$VR_RT_FC_400,
    res$VR_RT_FC_800,
    res$VR_RT_FIC_0,
    res$VR_RT_FIC_400,
    res$VR_RT_FIC_800,
    "ANT-VR",
    "Reaction Time (ms)",
    3
  )
}

getCueToTargetIntervalByFlankerConflict_ANT_VR_RT_All <- function() {
  res <- getResults_All()
  getCueToTargetIntervalByFlankerConflict_ANT_VR_RT(res)
}

getCueToTargetIntervalByFlankerConflict_ANT_VR_ACC <- function(res) {
  getCueToTargetIntervalByFlankerConflict(
    res$Id,
    res$VR_ACC_FC_0,
    res$VR_ACC_FC_400,
    res$VR_ACC_FC_800,
    res$VR_ACC_FIC_0,
    res$VR_ACC_FIC_400,
    res$VR_ACC_FIC_800,
    "ANT-VR",
    "Accuracy (%)",
    5
  )
}

getCueToTargetIntervalByFlankerConflict_ANT_VR_ACC_All <- function() {
  res <- getResults_All()
  getCueToTargetIntervalByFlankerConflict_ANT_VR_ACC(res)
}

getCueToTargetIntervalByFlankerConflict_ANT_VR_B_RT <- function(res) {
  getCueToTargetIntervalByFlankerConflict(
    res$Id,
    res$VR_B_RT_FC_0,
    res$VR_B_RT_FC_400,
    res$VR_B_RT_FC_800,
    res$VR_B_RT_FIC_0,
    res$VR_B_RT_FIC_400,
    res$VR_B_RT_FIC_800,
    "ANT-VR Balanced",
    "Reaction Time (ms)",
    3
  )
}

getCueToTargetIntervalByFlankerConflict_ANT_VR_B_RT_All <- function() {
  res <- getResults_All()
  getCueToTargetIntervalByFlankerConflict_ANT_VR_B_RT(res)
}

getCueToTargetIntervalByFlankerConflict_ANT_VR_B_ACC <- function(res) {
  getCueToTargetIntervalByFlankerConflict(
    res$Id,
    res$VR_B_ACC_FC_0,
    res$VR_B_ACC_FC_400,
    res$VR_B_ACC_FC_800,
    res$VR_B_ACC_FIC_0,
    res$VR_B_ACC_FIC_400,
    res$VR_B_ACC_FIC_800,
    "ANT-VR Balanced",
    "Accuracy (%)",
    5
  )
}

getCueToTargetIntervalByFlankerConflict_ANT_VR_B_ACC_All <- function() {
  res <- getResults_All()
  getCueToTargetIntervalByFlankerConflict_ANT_VR_B_ACC(res)
}

################################################################################

# Cue to Target Interval by Location Conflict Interaction Plot
getCueToTargetIntervalByLocationConflict <- function(id,
                                                     lc_0,
                                                     lc_400,
                                                     lc_800,
                                                     lic_0,
                                                     lic_400,
                                                     lic_800,
                                                     experimentName,
                                                     yAxisLabel,
                                                     digits) {
  if (!require(tidyverse)) {
    install.packages("tidyverse")
  }
  if (!require(rstatix)) {
    install.packages("rstatix")
  }
  if (!require(FSA)) {
    install.packages("FSA")
  }
  if (!require(ggplot2)) {
    install.packages("ggplot2")
  }
  library(tidyverse)
  library(rstatix)
  library(FSA)
  library(ggplot2)

  resultSet <- data.frame(
    Id = integer(0),
    CueToTarget = character(0),
    LocationCongruency = character(0),
    ValueCol = numeric(0)
  )

  for (row in 1:length(id)) {
    resultSet <- (
      resultSet %>% add_row(
        Id = id[row],
        CueToTarget = "0",
        LocationCongruency = "congruent",
        ValueCol = lc_0[row]
      )
      %>% add_row(
          Id = id[row],
          CueToTarget = "0",
          LocationCongruency = "incongruent",
          ValueCol = lic_0[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "400",
          LocationCongruency = "congruent",
          ValueCol = lc_400[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "400",
          LocationCongruency = "incongruent",
          ValueCol = lic_400[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "800",
          LocationCongruency = "congruent",
          ValueCol = lc_800[row]
        )
        %>% add_row(
          Id = id[row],
          CueToTarget = "800",
          LocationCongruency = "incongruent",
          ValueCol = lic_800[row]
        )
    )
  }

  result <- Summarize(
    ValueCol ~ CueToTarget + LocationCongruency + CueToTarget:LocationCongruency,
    data = resultSet,
    digits = digits
  )

  result$se <- result$sd / sqrt(result$n)
  result$se <- signif(result$se, digits = digits)

  result$CueToTarget <- factor(result$CueToTarget, levels = c("0", "400", "800"))

  pd <- position_dodge(.0)

  ggplot(
    result,
    aes(x = CueToTarget, y = mean, group = LocationCongruency)
  ) +
    geom_errorbar(
      aes(ymin = mean - se, ymax = mean + se),
      width = .4,
      size = 0.7,
      position = pd
    ) +
    geom_point(
      shape = 15,
      size = 2,
      position = pd
    ) +
    geom_line(size = 0.8, aes(linetype = LocationCongruency)) +
    scale_linetype_manual(values = c("solid", "dashed"), name = "Congruency") +
    theme_apa() +
    theme(axis.title = element_text(face = "bold")) +
    labs(x = "Cue-Target Interval (ms)", y = yAxisLabel, col = "Congruency")
}

getCueToTargetIntervalByLocationConflict_ANT_R_RT <- function(res) {
  getCueToTargetIntervalByLocationConflict(
    res$Id,
    res$R_RT_LC_0,
    res$R_RT_LC_400,
    res$R_RT_LC_800,
    res$R_RT_LIC_0,
    res$R_RT_LIC_400,
    res$R_RT_LIC_800,
    "ANT-R",
    "Reaction Time (ms)",
    3
  )
}

getCueToTargetIntervalByLocationConflict_ANT_R_RT_All <- function() {
  res <- getResults_All()
  getCueToTargetIntervalByLocationConflict_ANT_R_RT(res)
}

getCueToTargetIntervalByLocationConflict_ANT_R_ACC <- function(res) {
  getCueToTargetIntervalByLocationConflict(
    res$Id,
    res$R_ACC_LC_0,
    res$R_ACC_LC_400,
    res$R_ACC_LC_800,
    res$R_ACC_LIC_0,
    res$R_ACC_LIC_400,
    res$R_ACC_LIC_800,
    "ANT-R",
    "Accuracy (%)",
    5
  )
}

getCueToTargetIntervalByLocationConflict_ANT_R_ACC_All <- function() {
  res <- getResults_All()
  getCueToTargetIntervalByLocationConflict_ANT_R_ACC(res)
}

getCueToTargetIntervalByLocationConflict_ANT_VR_RT <- function(res) {
  getCueToTargetIntervalByLocationConflict(
    res$Id,
    res$VR_RT_LC_0,
    res$VR_RT_LC_400,
    res$VR_RT_LC_800,
    res$VR_RT_LIC_0,
    res$VR_RT_LIC_400,
    res$VR_RT_LIC_800,
    "ANT-VR",
    "Reaction Time (ms)",
    3
  )
}

getCueToTargetIntervalByLocationConflict_ANT_VR_RT_All <- function() {
  res <- getResults_All()
  getCueToTargetIntervalByLocationConflict_ANT_VR_RT(res)
}

getCueToTargetIntervalByLocationConflict_ANT_VR_ACC <- function(res) {
  getCueToTargetIntervalByLocationConflict(
    res$Id,
    res$VR_ACC_LC_0,
    res$VR_ACC_LC_400,
    res$VR_ACC_LC_800,
    res$VR_ACC_LIC_0,
    res$VR_ACC_LIC_400,
    res$VR_ACC_LIC_800,
    "ANT-VR",
    "Accuracy (%)",
    5
  )
}

getCueToTargetIntervalByLocationConflict_ANT_VR_ACC_All <- function() {
  res <- getResults_All()
  getCueToTargetIntervalByLocationConflict_ANT_VR_ACC(res)
}

getCueToTargetIntervalByLocationConflict_ANT_VR_B_RT <- function(res) {
  getCueToTargetIntervalByLocationConflict(
    res$Id,
    res$VR_B_RT_LC_0,
    res$VR_B_RT_LC_400,
    res$VR_B_RT_LC_800,
    res$VR_B_RT_LIC_0,
    res$VR_B_RT_LIC_400,
    res$VR_B_RT_LIC_800,
    "ANT-VR Balanced",
    "Reaction Time (ms)",
    3
  )
}

getCueToTargetIntervalByLocationConflict_ANT_VR_B_RT_All <- function() {
  res <- getResults_All()
  getCueToTargetIntervalByLocationConflict_ANT_VR_B_RT(res)
}

getCueToTargetIntervalByLocationConflict_ANT_VR_B_ACC <- function(res) {
  getCueToTargetIntervalByLocationConflict(
    res$Id,
    res$VR_B_ACC_LC_0,
    res$VR_B_ACC_LC_400,
    res$VR_B_ACC_LC_800,
    res$VR_B_ACC_LIC_0,
    res$VR_B_ACC_LIC_400,
    res$VR_B_ACC_LIC_800,
    "ANT-VR Balanced",
    "Accuracy (%)",
    5
  )
}

getCueToTargetIntervalByLocationConflict_ANT_VR_B_ACC_All <- function() {
  res <- getResults_All()
  getCueToTargetIntervalByLocationConflict_ANT_VR_B_ACC(res)
}

################################################################################

# Comparison of Modalities
getPairwiseOneSampledTTest <- function(x, y, numberOfDigits) {
  tTest <- t.test(x, y, paired = TRUE, alternative = "two.sided")
  result <- c(
    getMonospacedRoundedValue(tTest[["statistic"]], numberOfDigits),
    getFormattedPValueForPlot(tTest[["p.value"]])
  )
}

getPairwisePearsonCorrelation <- function(x, y, numberOfDigits) {
  result <- c(
    getMonospacedRoundedValue(cor(x, y, use = "complete.obs"), numberOfDigits),
    getFormattedPValueForPlot(cor.test(x, y, use = "complete.obs")[["p.value"]])
  )
}

getPairwiseComparisons <- function(A_Alerting,
                                   B_Alerting,
                                   A_Validity,
                                   B_Validity,
                                   A_Disengaging,
                                   B_Disengaging,
                                   A_Moving_Engaging,
                                   B_Moving_Engaging,
                                   A_OrientingTime,
                                   B_OrientingTime,
                                   A_FlankerConflict,
                                   B_FlankerConflict,
                                   A_LocationConflict,
                                   B_LocationConflict,
                                   A_FlankerByLocation,
                                   B_FlankerByLocation,
                                   A_AlertingByFlanker,
                                   B_AlertingByFlanker,
                                   A_OrientingByFlanker,
                                   B_OrientingByFlanker,
                                   A_ValidityByFlanker,
                                   B_ValidityByFlanker,
                                   A_AlertingByLocation,
                                   B_AlertingByLocation,
                                   A_OrientingByLocation,
                                   B_OrientingByLocation,
                                   A_ValidityByLocation,
                                   B_ValidityByLocation,
                                   A_IOR,
                                   B_IOR,
                                   A_Overall,
                                   B_Overall) {
  alertingBenefit_MeanA <- getMonospacedRoundedValue(mean(A_Alerting), 2)
  alertingBenefit_MeanB <- getMonospacedRoundedValue(mean(B_Alerting), 2)
  alertingBenefit_TTestAndP <- getPairwiseOneSampledTTest(A_Alerting, B_Alerting, 2)
  alertingBenefit_CorAndP <- getPairwisePearsonCorrelation(A_Alerting, B_Alerting, 2)

  validity_MeanA <- getMonospacedRoundedValue(mean(A_Validity), 2)
  validity_MeanB <- getMonospacedRoundedValue(mean(B_Validity), 2)
  validity_TTestAndP <- getPairwiseOneSampledTTest(A_Validity, B_Validity, 2)
  validity_CorAndP <- getPairwisePearsonCorrelation(A_Validity, B_Validity, 2)

  disengagingCost_MeanA <- getMonospacedRoundedValue(mean(A_Disengaging), 2)
  disengagingCost_MeanB <- getMonospacedRoundedValue(mean(B_Disengaging), 2)
  disengagingCost_TTestAndP <- getPairwiseOneSampledTTest(A_Disengaging, B_Disengaging, 2)
  disengagingCost_CorAndP <- getPairwisePearsonCorrelation(A_Disengaging, B_Disengaging, 2)

  movingAndEngaging_MeanA <- getMonospacedRoundedValue(mean(A_Moving_Engaging), 2)
  movingAndEngaging_MeanB <- getMonospacedRoundedValue(mean(B_Moving_Engaging), 2)
  movingAndEngaging_TTestAndP <- getPairwiseOneSampledTTest(A_Moving_Engaging, B_Moving_Engaging, 2)
  movingAndEngaging_CorAndP <- getPairwisePearsonCorrelation(A_Moving_Engaging, B_Moving_Engaging, 2)

  orientingTime_MeanA <- getMonospacedRoundedValue(mean(A_OrientingTime), 2)
  orientingTime_MeanB <- getMonospacedRoundedValue(mean(B_OrientingTime), 2)
  orientingTime_TTestAndP <- getPairwiseOneSampledTTest(A_OrientingTime, B_OrientingTime, 2)
  orientingTime_CorAndP <- getPairwisePearsonCorrelation(A_OrientingTime, B_OrientingTime, 2)

  flankerConflict_MeanA <- getMonospacedRoundedValue(mean(A_FlankerConflict), 2)
  flankerConflict_MeanB <- getMonospacedRoundedValue(mean(B_FlankerConflict), 2)
  flankerConflict_TTestAndP <- getPairwiseOneSampledTTest(A_FlankerConflict, B_FlankerConflict, 2)
  flankerConflict_CorAndP <- getPairwisePearsonCorrelation(A_FlankerConflict, B_FlankerConflict, 2)

  locationConflict_MeanA <- getMonospacedRoundedValue(mean(A_LocationConflict), 2)
  locationConflict_MeanB <- getMonospacedRoundedValue(mean(B_LocationConflict), 2)
  locationConflict_TTestAndP <- getPairwiseOneSampledTTest(A_LocationConflict, B_LocationConflict, 2)
  locationConflict_CorAndP <- getPairwisePearsonCorrelation(A_LocationConflict, B_LocationConflict, 2)

  flankerByLocation_MeanA <- getMonospacedRoundedValue(mean(A_FlankerByLocation), 2)
  flankerByLocation_MeanB <- getMonospacedRoundedValue(mean(B_FlankerByLocation), 2)
  flankerByLocation_TTestAndP <- getPairwiseOneSampledTTest(A_FlankerByLocation, B_FlankerByLocation, 2)
  flankerByLocation_CorAndP <- getPairwisePearsonCorrelation(A_FlankerByLocation, B_FlankerByLocation, 2)

  alertingByFlanker_MeanA <- getMonospacedRoundedValue(mean(A_AlertingByFlanker), 2)
  alertingByFlanker_MeanB <- getMonospacedRoundedValue(mean(B_AlertingByFlanker), 2)
  alertingByFlanker_TTestAndP <- getPairwiseOneSampledTTest(A_AlertingByFlanker, B_AlertingByFlanker, 2)
  alertingByFlanker_CorAndP <- getPairwisePearsonCorrelation(A_AlertingByFlanker, B_AlertingByFlanker, 2)

  orientingByFlanker_MeanA <- getMonospacedRoundedValue(mean(A_OrientingByFlanker), 2)
  orientingByFlanker_MeanB <- getMonospacedRoundedValue(mean(B_OrientingByFlanker), 2)
  orientingByFlanker_TTestAndP <- getPairwiseOneSampledTTest(A_OrientingByFlanker, B_OrientingByFlanker, 2)
  orientingByFlanker_CorAndP <- getPairwisePearsonCorrelation(A_OrientingByFlanker, B_OrientingByFlanker, 2)

  validityByFlanker_MeanA <- getMonospacedRoundedValue(mean(A_ValidityByFlanker), 2)
  validityByFlanker_MeanB <- getMonospacedRoundedValue(mean(B_ValidityByFlanker), 2)
  validityByFlanker_TTestAndP <- getPairwiseOneSampledTTest(A_ValidityByFlanker, B_ValidityByFlanker, 2)
  validityByFlanker_CorAndP <- getPairwisePearsonCorrelation(A_ValidityByFlanker, B_ValidityByFlanker, 2)

  alertingByLocation_MeanA <- getMonospacedRoundedValue(mean(A_AlertingByLocation), 2)
  alertingByLocation_MeanB <- getMonospacedRoundedValue(mean(B_AlertingByLocation), 2)
  alertingByLocation_TTestAndP <- getPairwiseOneSampledTTest(A_AlertingByLocation, B_AlertingByLocation, 2)
  alertingByLocation_CorAndP <- getPairwisePearsonCorrelation(A_AlertingByLocation, B_AlertingByLocation, 2)

  orientingByLocation_MeanA <- getMonospacedRoundedValue(mean(A_OrientingByLocation), 2)
  orientingByLocation_MeanB <- getMonospacedRoundedValue(mean(B_OrientingByLocation), 2)
  orientingByLocation_TTestAndP <- getPairwiseOneSampledTTest(A_OrientingByLocation, B_OrientingByLocation, 2)
  orientingByLocation_CorAndP <- getPairwisePearsonCorrelation(A_OrientingByLocation, B_OrientingByLocation, 2)

  validityByLocation_MeanA <- getMonospacedRoundedValue(mean(A_ValidityByLocation), 2)
  validityByLocation_MeanB <- getMonospacedRoundedValue(mean(B_ValidityByLocation), 2)
  validityByLocation_TTestAndP <- getPairwiseOneSampledTTest(A_ValidityByLocation, B_ValidityByLocation, 2)
  validityByLocation_CorAndP <- getPairwisePearsonCorrelation(A_ValidityByLocation, B_ValidityByLocation, 2)

  inhibitionOfReturn_MeanA <- getMonospacedRoundedValue(mean(A_IOR), 2)
  inhibitionOfReturn_MeanB <- getMonospacedRoundedValue(mean(B_IOR), 2)
  inhibitionOfReturn_TTestAndP <- getPairwiseOneSampledTTest(A_IOR, B_IOR, 2)
  inhibitionOfReturn_CorAndP <- getPairwisePearsonCorrelation(A_IOR, B_IOR, 2)

  overall_MeanA <- getMonospacedRoundedValue(mean(A_Overall), 2)
  overall_MeanB <- getMonospacedRoundedValue(mean(B_Overall), 2)
  overall_TTestAndP <- getPairwiseOneSampledTTest(A_Overall, B_Overall, 2)
  overall_CorAndP <- getPairwisePearsonCorrelation(A_Overall, B_Overall, 2)

  meanA <- c(
    alertingBenefit_MeanA,
    validity_MeanA,
    disengagingCost_MeanA,
    movingAndEngaging_MeanA,
    orientingTime_MeanA,
    flankerConflict_MeanA,
    locationConflict_MeanA,
    flankerByLocation_MeanA,
    alertingByFlanker_MeanA,
    orientingByFlanker_MeanA,
    validityByFlanker_MeanA,
    alertingByLocation_MeanA,
    orientingByLocation_MeanA,
    validityByLocation_MeanA,
    inhibitionOfReturn_MeanA,
    overall_MeanA
  )

  meanB <- c(
    alertingBenefit_MeanB,
    validity_MeanB,
    disengagingCost_MeanB,
    movingAndEngaging_MeanB,
    orientingTime_MeanB,
    flankerConflict_MeanB,
    locationConflict_MeanB,
    flankerByLocation_MeanB,
    alertingByFlanker_MeanB,
    orientingByFlanker_MeanB,
    validityByFlanker_MeanB,
    alertingByLocation_MeanB,
    orientingByLocation_MeanB,
    validityByLocation_MeanB,
    inhibitionOfReturn_MeanB,
    overall_MeanB
  )

  tTestV <- c(
    alertingBenefit_TTestAndP[1],
    validity_TTestAndP[1],
    disengagingCost_TTestAndP[1],
    movingAndEngaging_TTestAndP[1],
    orientingTime_TTestAndP[1],
    flankerConflict_TTestAndP[1],
    locationConflict_TTestAndP[1],
    flankerByLocation_TTestAndP[1],
    alertingByFlanker_TTestAndP[1],
    orientingByFlanker_TTestAndP[1],
    validityByFlanker_TTestAndP[1],
    alertingByLocation_TTestAndP[1],
    orientingByLocation_TTestAndP[1],
    validityByLocation_TTestAndP[1],
    inhibitionOfReturn_TTestAndP[1],
    overall_TTestAndP[1]
  )

  tTestP <- c(
    alertingBenefit_TTestAndP[2],
    validity_TTestAndP[2],
    disengagingCost_TTestAndP[2],
    movingAndEngaging_TTestAndP[2],
    orientingTime_TTestAndP[2],
    flankerConflict_TTestAndP[2],
    locationConflict_TTestAndP[2],
    flankerByLocation_TTestAndP[2],
    alertingByFlanker_TTestAndP[2],
    orientingByFlanker_TTestAndP[2],
    validityByFlanker_TTestAndP[2],
    alertingByLocation_TTestAndP[2],
    orientingByLocation_TTestAndP[2],
    validityByLocation_TTestAndP[2],
    inhibitionOfReturn_TTestAndP[2],
    overall_TTestAndP[2]
  )

  corV <- c(
    alertingBenefit_CorAndP[1],
    validity_CorAndP[1],
    disengagingCost_CorAndP[1],
    movingAndEngaging_CorAndP[1],
    orientingTime_CorAndP[1],
    flankerConflict_CorAndP[1],
    locationConflict_CorAndP[1],
    flankerByLocation_CorAndP[1],
    alertingByFlanker_CorAndP[1],
    orientingByFlanker_CorAndP[1],
    validityByFlanker_CorAndP[1],
    alertingByLocation_CorAndP[1],
    orientingByLocation_CorAndP[1],
    validityByLocation_CorAndP[1],
    inhibitionOfReturn_CorAndP[1],
    overall_CorAndP[1]
  )

  corP <- c(
    alertingBenefit_CorAndP[2],
    validity_CorAndP[2],
    disengagingCost_CorAndP[2],
    movingAndEngaging_CorAndP[2],
    orientingTime_CorAndP[2],
    flankerConflict_CorAndP[2],
    locationConflict_CorAndP[2],
    flankerByLocation_CorAndP[2],
    alertingByFlanker_CorAndP[2],
    orientingByFlanker_CorAndP[2],
    validityByFlanker_CorAndP[2],
    alertingByLocation_CorAndP[2],
    orientingByLocation_CorAndP[2],
    validityByLocation_CorAndP[2],
    inhibitionOfReturn_CorAndP[2],
    overall_CorAndP[2]
  )


  result <- data.frame(meanA, meanB, tTestV, tTestP, corV, corP)
}

getPairwiseComparisonsTable <- function(pairwiseComparisons,
                                        experimentNameA,
                                        experimentNameB,
                                        variableName,
                                        optionalNote) {
  if (!require(dplyr)) {
    install.packages("dplyr")
  }
  if (!require(papaja)) {
    install.packages("papaja")
  }
  if (!require(psych)) {
    install.packages("psych")
  }
  library(dplyr)
  library(papaja)
  library(psych)

  colnames(pairwiseComparisons) <- c(experimentNameA, experimentNameB, "t", "p(t)", "r", "p(r)")
  rownames(pairwiseComparisons) <- c(
    "Alerting Benefit",
    "Validity Effect",
    "Disengaging Cost",
    "Moving + Engaging",
    "Orienting Time",
    "Flanker Conflict Effect",
    "Location Conflict Effect",
    "Flanker by Location Interaction",
    "Alerting by Flanker Conflict",
    "Orienting by Flanker Conflict",
    "Validity by Flanker Conflict",
    "Alerting by Location Conflict",
    "Orienting by Location Conflict",
    "Validity by Location Conflict",
    "Inhibition of Return Effect",
    "Overall"
  )

  papaja::apa_table(
    pairwiseComparisons,
    digits = c(2, 2, 2, 2, 3, 2, 3),
    align = c("l", "r", "r", "r", "r", "r", "r"),
    note = optionalNote
  )
}

getPairwiseComparisons_R_VR_RT <- function(res) {
  results <- getPairwiseComparisons(
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
    res$VR_RT
  )

  return(
    getPairwiseComparisonsTable(
      results,
      "ANT-R",
      "ANT-VR",
      "RT*",
      "*RT designates Reaction Time."
    )
  )
}

getPairwiseComparisons_R_VR_RT_All <- function() {
  res <- getResults_All()
  getPairwiseComparisons_R_VR_RT(res)
}

getPairwiseComparisons_R_VR_B_RT <- function(res) {
  results <- getPairwiseComparisons(
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
    res$VR_B_RT
  )

  return(
    getPairwiseComparisonsTable(
      results,
      "ANT-R",
      "ANT-VR B*",
      "RT**",
      "*ANT-VR B designates ANT-VR Balanced. **RT designates Reaction Time."
    )
  )
}

getPairwiseComparisons_R_VR_B_RT_All <- function() {
  res <- getResults_All()
  getPairwiseComparisons_R_VR_B_RT(res)
}

getPairwiseComparisons_VR_VR_B_RT <- function(res) {
  results <- getPairwiseComparisons(
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
    res$VR_B_RT
  )

  return(
    getPairwiseComparisonsTable(
      results,
      "ANT-VR",
      "ANT-VR B*",
      "RT**",
      "*ANT-VR B designates ANT-VR Balanced. **RT designates Reaction Time."
    )
  )
}

getPairwiseComparisons_VR_VR_B_RT_All <- function() {
  res <- getResults_All()
  getPairwiseComparisons_VR_VR_B_RT(res)
}

getPairwiseTTestsTable <- function(pairwiseComparisons,
                                   experimentNameA,
                                   experimentNameB,
                                   variableName,
                                   optionalNote) {
  if (!require(dplyr)) {
    install.packages("dplyr")
  }
  if (!require(papaja)) {
    install.packages("papaja")
  }
  if (!require(psych)) {
    install.packages("psych")
  }
  library(dplyr)
  library(papaja)
  library(psych)

  pairwiseComparisons <- pairwiseComparisons[, c("meanA", "meanB", "tTestV", "tTestP")]

  colnames(pairwiseComparisons) <- c(experimentNameA, experimentNameB, "t", "p")
  rownames(pairwiseComparisons) <- c(
    "Alerting Benefit",
    "Validity Effect",
    "Disengaging Cost",
    "Moving + Engaging",
    "Orienting Time",
    "Flanker Conflict Effect",
    "Location Conflict Effect",
    "Flanker by Location Interaction",
    "Alerting by Flanker Conflict",
    "Orienting by Flanker Conflict",
    "Validity by Flanker Conflict",
    "Alerting by Location Conflict",
    "Orienting by Location Conflict",
    "Validity by Location Conflict",
    "Inhibition of Return Effect",
    "Overall"
  )

  papaja::apa_table(
    pairwiseComparisons,
    digits = c(2, 2, 2, 2, 3),
    align = c("l", "r", "r", "r", "r"),
    note = optionalNote
  )
}

getPairwiseTTests_R_VR_RT <- function(res) {
  results <- getPairwiseComparisons(
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
    res$VR_RT
  )

  return(
    getPairwiseTTestsTable(
      results,
      "ANT-R",
      "ANT-VR",
      "RT*",
      "*RT designates Reaction Time."
    )
  )
}

getPairwiseTTests_R_VR_RT_All <- function() {
  res <- getResults_All()
  getPairwiseTTests_R_VR_RT(res)
}

getPairwiseTTests_R_VR_B_RT <- function(res) {
  results <- getPairwiseComparisons(
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
    res$VR_B_RT
  )

  return(
    getPairwiseTTestsTable(
      results,
      "ANT-R",
      "ANT-VR B*",
      "RT**",
      "*ANT-VR B designates ANT-VR Balanced. **RT designates Reaction Time."
    )
  )
}

getPairwiseTTests_R_VR_B_RT_All <- function() {
  res <- getResults_All()
  getPairwiseTTests_R_VR_B_RT(res)
}

getPairwiseTTests_VR_VR_B_RT <- function(res) {
  results <- getPairwiseComparisons(
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
    res$VR_B_RT
  )

  return(
    getPairwiseTTestsTable(
      results,
      "ANT-VR",
      "ANT-VR B*",
      "RT**",
      "*ANT-VR B designates ANT-VR Balanced. **RT designates Reaction Time."
    )
  )
}

getPairwiseTTests_VR_VR_B_RT_All <- function() {
  res <- getResults_All()
  getPairwiseTTests_VR_VR_B_RT(res)
}

################################################################################

# Plotting

################################################################################

plotDemographics_All <- function() {
  if (!require(rmarkdown)) {
    install.packages("rmarkdown")
  }
  if (!require(staplr)) {
    install.packages("staplr")
  }
  if (!require(knitr)) {
    install.packages("knitr")
  }
  library(rmarkdown)
  library(staplr)
  library(knitr)

  tryCatch({
    rmarkdown::render("./Demographics_All.Rmd")
  })
  remove_pages(
    rmpages = c(1, 2),
    "./Demographics_All.pdf",
    "./Demographics_All.pdf"
  )
  plot_crop("./Demographics_All.pdf")
  file.copy(
    "./Demographics_All.pdf",
    getPath("../../../Results/Tables/Demographics.pdf"),
    overwrite = TRUE
  )
  file.remove("./Demographics_All.pdf")
  file.remove("./Demographics_All.tex")
  file.remove("./Demographics_All.ttt")
}

################################################################################

plotGenderAndAge_All <- function() {
  if (!require(rmarkdown)) {
    install.packages("rmarkdown")
  }
  if (!require(staplr)) {
    install.packages("staplr")
  }
  if (!require(knitr)) {
    install.packages("knitr")
  }
  library(rmarkdown)
  library(staplr)
  library(knitr)

  tryCatch({
    rmarkdown::render("./GenderAndAge_All.Rmd")
  })
  file.remove(getPath("./GenderAndAge_All.pdf"))
  file.remove(getPath("./GenderAndAge_All.tex"))
  plot_crop("./GenderAndAge_All_files/figure-latex/plotting tables-1.pdf")
  file.copy(
    "./GenderAndAge_All_files/figure-latex/plotting tables-1.pdf",
    getPath("../../../Results/Diagrams/GenderAndAge.pdf"),
    overwrite = TRUE
  )
  unlink(getPath("./GenderAndAge_All_files"), recursive = TRUE)
}

################################################################################

plotEdNaHaToD_All <- function() {
  if (!require(rmarkdown)) {
    install.packages("rmarkdown")
  }
  if (!require(staplr)) {
    install.packages("staplr")
  }
  if (!require(knitr)) {
    install.packages("knitr")
  }
  library(rmarkdown)
  library(staplr)
  library(knitr)

  tryCatch({
    rmarkdown::render("./EdNaHaToD_All.Rmd")
  })
  file.remove(getPath("./EdNaHaToD_All.pdf"))
  file.remove(getPath("./EdNaHaToD_All.tex"))
  file.copy(
    "./EdNaHaToD_All_files/figure-latex/plotting tables-1.pdf",
    getPath("../../../Results/Diagrams/EdNaHaToD.pdf"),
    overwrite = TRUE
  )
  unlink(getPath("./EdNaHaToD_All_files"), recursive = TRUE)
}

################################################################################

plotJointNetworkAndInteractionEffects_All <- function() {
  if (!require(rmarkdown)) {
    install.packages("rmarkdown")
  }
  if (!require(staplr)) {
    install.packages("staplr")
  }
  if (!require(knitr)) {
    install.packages("knitr")
  }
  library(rmarkdown)
  library(staplr)
  library(knitr)

  tryCatch({
    rmarkdown::render("./JointNetworkAndInteractionEffects_All.Rmd")
  })
  file.remove(getPath("./JointNetworkAndInteractionEffects_All.pdf"))
  file.remove(getPath("./JointNetworkAndInteractionEffects_All.tex"))
  plot_crop(
    "./JointNetworkAndInteractionEffects_All_files/figure-latex/plotting tables-1.pdf"
  )
  file.copy(
    "./JointNetworkAndInteractionEffects_All_files/figure-latex/plotting tables-1.pdf",
    getPath(
      "../../../Results/Diagrams/JointNetworkAndInteractionEffects.pdf"
    ),
    overwrite = TRUE
  )
  unlink(getPath("./JointNetworkAndInteractionEffects_All_files"),
    recursive = TRUE
  )
}

################################################################################

plotQualityOfExperience_All <- function() {
  if (!require(rmarkdown)) {
    install.packages("rmarkdown")
  }
  if (!require(staplr)) {
    install.packages("staplr")
  }
  library(rmarkdown)
  library(staplr)

  tryCatch({
    rmarkdown::render("./QualityOfExperience_All.Rmd")
  })
  file.remove(getPath("./QualityOfExperience_All.pdf"))
  file.remove(getPath("./QualityOfExperience_All.tex"))
  file.copy(
    "./QualityOfExperience_All_files/figure-latex/plotting tables-1.pdf",
    getPath(
      "../../../Results/Diagrams/QualityOfExperience.pdf"
    ),
    overwrite = TRUE
  )
  unlink(getPath("./QualityOfExperience_All_files"), recursive = TRUE)
}

################################################################################

plotNetworkAndInteractionEffects_All <- function() {
  if (!require(rmarkdown)) {
    install.packages("rmarkdown")
  }
  if (!require(staplr)) {
    install.packages("staplr")
  }
  if (!require(knitr)) {
    install.packages("knitr")
  }
  library(rmarkdown)
  library(staplr)
  library(knitr)

  tryCatch({
    rmarkdown::render("./NetworkAndInteractionEffects_ANT_R_All.Rmd")
  })
  remove_pages(
    rmpages = c(1, 2),
    "./NetworkAndInteractionEffects_ANT_R_All.pdf",
    "./NetworkAndInteractionEffects_ANT_R_All.pdf"
  )
  plot_crop("./NetworkAndInteractionEffects_ANT_R_All.pdf")
  file.copy(
    "./NetworkAndInteractionEffects_ANT_R_All.pdf",
    getPath(
      "../../../Results/Tables/NetworkAndInteractionEffects_ANT_R.pdf"
    ),
    overwrite = TRUE
  )
  file.remove("./NetworkAndInteractionEffects_ANT_R_All.pdf")
  file.remove("./NetworkAndInteractionEffects_ANT_R_All.tex")
  file.remove("./NetworkAndInteractionEffects_ANT_R_All.ttt")

  tryCatch({
    rmarkdown::render("./NetworkAndInteractionEffects_ANT_VR_All.Rmd")
  })
  remove_pages(
    rmpages = c(1, 2),
    "./NetworkAndInteractionEffects_ANT_VR_All.pdf",
    "./NetworkAndInteractionEffects_ANT_VR_All.pdf"
  )
  plot_crop("./NetworkAndInteractionEffects_ANT_VR_All.pdf")
  file.copy(
    "./NetworkAndInteractionEffects_ANT_VR_All.pdf",
    getPath(
      "../../../Results/Tables/NetworkAndInteractionEffects_ANT_VR.pdf"
    ),
    overwrite = TRUE
  )
  file.remove("./NetworkAndInteractionEffects_ANT_VR_All.pdf")
  file.remove("./NetworkAndInteractionEffects_ANT_VR_All.tex")
  file.remove("./NetworkAndInteractionEffects_ANT_VR_All.ttt")

  tryCatch({
    rmarkdown::render("./NetworkAndInteractionEffects_ANT_VR_B_All.Rmd")
  })
  remove_pages(
    rmpages = c(1, 2),
    "./NetworkAndInteractionEffects_ANT_VR_B_All.pdf",
    "./NetworkAndInteractionEffects_ANT_VR_B_All.pdf"
  )
  plot_crop("./NetworkAndInteractionEffects_ANT_VR_B_All.pdf")
  file.copy(
    "./NetworkAndInteractionEffects_ANT_VR_B_All.pdf",
    getPath(
      "../../../Results/Tables/NetworkAndInteractionEffects_ANT_VR_B.pdf"
    ),
    overwrite = TRUE
  )
  file.remove("./NetworkAndInteractionEffects_ANT_VR_B_All.pdf")
  file.remove("./NetworkAndInteractionEffects_ANT_VR_B_All.tex")
  file.remove("./NetworkAndInteractionEffects_ANT_VR_B_All.ttt")
}

################################################################################

plotCorrelationsOfNetworks_All <- function() {
  if (!require(rmarkdown)) {
    install.packages("rmarkdown")
  }
  if (!require(staplr)) {
    install.packages("staplr")
  }
  if (!require(knitr)) {
    install.packages("knitr")
  }
  library(rmarkdown)
  library(staplr)
  library(knitr)

  tryCatch({
    rmarkdown::render("./CorrelationsOfNetworks_ANT_R_RT_All.Rmd")
  })
  remove_pages(
    rmpages = c(1, 2),
    "./CorrelationsOfNetworks_ANT_R_RT_All.pdf",
    "./CorrelationsOfNetworks_ANT_R_RT_All.pdf"
  )
  plot_crop("./CorrelationsOfNetworks_ANT_R_RT_All.pdf")
  file.copy(
    "./CorrelationsOfNetworks_ANT_R_RT_All.pdf",
    getPath(
      "../../../Results/Tables/CorrelationsOfNetworks_ANT_R_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.remove("./CorrelationsOfNetworks_ANT_R_RT_All.pdf")
  file.remove("./CorrelationsOfNetworks_ANT_R_RT_All.tex")
  file.remove("./CorrelationsOfNetworks_ANT_R_RT_All.ttt")

  tryCatch({
    rmarkdown::render("./CorrelationsOfNetworks_ANT_R_ACC_All.Rmd")
  })
  remove_pages(
    rmpages = c(1, 2),
    "./CorrelationsOfNetworks_ANT_R_ACC_All.pdf",
    "./CorrelationsOfNetworks_ANT_R_ACC_All.pdf"
  )
  plot_crop("./CorrelationsOfNetworks_ANT_R_ACC_All.pdf")
  file.copy(
    "./CorrelationsOfNetworks_ANT_R_ACC_All.pdf",
    getPath(
      "../../../Results/Tables/CorrelationsOfNetworks_ANT_R_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.remove("./CorrelationsOfNetworks_ANT_R_ACC_All.pdf")
  file.remove("./CorrelationsOfNetworks_ANT_R_ACC_All.tex")
  file.remove("./CorrelationsOfNetworks_ANT_R_ACC_All.ttt")

  tryCatch({
    rmarkdown::render("./CorrelationsOfNetworks_ANT_VR_RT_All.Rmd")
  })
  remove_pages(
    rmpages = c(1, 2),
    "./CorrelationsOfNetworks_ANT_VR_RT_All.pdf",
    "./CorrelationsOfNetworks_ANT_VR_RT_All.pdf"
  )
  plot_crop("./CorrelationsOfNetworks_ANT_VR_RT_All.pdf")
  file.copy(
    "./CorrelationsOfNetworks_ANT_VR_RT_All.pdf",
    getPath(
      "../../../Results/Tables/CorrelationsOfNetworks_ANT_VR_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.remove("./CorrelationsOfNetworks_ANT_VR_RT_All.pdf")
  file.remove("./CorrelationsOfNetworks_ANT_VR_RT_All.tex")
  file.remove("./CorrelationsOfNetworks_ANT_VR_RT_All.ttt")

  tryCatch({
    rmarkdown::render("./CorrelationsOfNetworks_ANT_VR_ACC_All.Rmd")
  })
  remove_pages(
    rmpages = c(1, 2),
    "./CorrelationsOfNetworks_ANT_VR_ACC_All.pdf",
    "./CorrelationsOfNetworks_ANT_VR_ACC_All.pdf"
  )
  plot_crop("./CorrelationsOfNetworks_ANT_VR_ACC_All.pdf")
  file.copy(
    "./CorrelationsOfNetworks_ANT_VR_ACC_All.pdf",
    getPath(
      "../../../Results/Tables/CorrelationsOfNetworks_ANT_VR_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.remove("./CorrelationsOfNetworks_ANT_VR_ACC_All.pdf")
  file.remove("./CorrelationsOfNetworks_ANT_VR_ACC_All.tex")
  file.remove("./CorrelationsOfNetworks_ANT_VR_ACC_All.ttt")

  tryCatch({
    rmarkdown::render("./CorrelationsOfNetworks_ANT_VR_B_RT_All.Rmd")
  })
  remove_pages(
    rmpages = c(1, 2),
    "./CorrelationsOfNetworks_ANT_VR_B_RT_All.pdf",
    "./CorrelationsOfNetworks_ANT_VR_B_RT_All.pdf"
  )
  plot_crop("./CorrelationsOfNetworks_ANT_VR_B_RT_All.pdf")
  file.copy(
    "./CorrelationsOfNetworks_ANT_VR_B_RT_All.pdf",
    getPath(
      "../../../Results/Tables/CorrelationsOfNetworks_ANT_VR_B_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.remove("./CorrelationsOfNetworks_ANT_VR_B_RT_All.pdf")
  file.remove("./CorrelationsOfNetworks_ANT_VR_B_RT_All.tex")
  file.remove("./CorrelationsOfNetworks_ANT_VR_B_RT_All.ttt")

  tryCatch({
    rmarkdown::render("./CorrelationsOfNetworks_ANT_VR_B_ACC_All.Rmd")
  })
  remove_pages(
    rmpages = c(1, 2),
    "./CorrelationsOfNetworks_ANT_VR_B_ACC_All.pdf",
    "./CorrelationsOfNetworks_ANT_VR_B_ACC_All.pdf"
  )
  plot_crop("./CorrelationsOfNetworks_ANT_VR_B_ACC_All.pdf")
  file.copy(
    "./CorrelationsOfNetworks_ANT_VR_B_ACC_All.pdf",
    getPath(
      "../../../Results/Tables/CorrelationsOfNetworks_ANT_VR_B_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.remove("./CorrelationsOfNetworks_ANT_VR_B_ACC_All.pdf")
  file.remove("./CorrelationsOfNetworks_ANT_VR_B_ACC_All.tex")
  file.remove("./CorrelationsOfNetworks_ANT_VR_B_ACC_All.ttt")
}

################################################################################

plotAlertingByFlankerConflict_All <- function() {
  if (!require(rmarkdown)) {
    install.packages("rmarkdown")
  }
  if (!require(staplr)) {
    install.packages("staplr")
  }
  library(rmarkdown)
  library(staplr)

  tryCatch({
    rmarkdown::render("./AlertingByFlankerConflict_All.Rmd")
  })
  file.remove(getPath("./AlertingByFlankerConflict_All.pdf"))
  file.remove(getPath("./AlertingByFlankerConflict_All.tex"))
  file.copy(
    "./AlertingByFlankerConflict_All_files/figure-latex/plotting tables-1.pdf",
    getPath(
      "../../../Results/Diagrams/AlertingByFlankerConflict_ANT_R_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./AlertingByFlankerConflict_All_files/figure-latex/plotting tables-2.pdf",
    getPath(
      "../../../Results/Diagrams/AlertingByFlankerConflict_ANT_R_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./AlertingByFlankerConflict_All_files/figure-latex/plotting tables-3.pdf",
    getPath(
      "../../../Results/Diagrams/AlertingByFlankerConflict_ANT_VR_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./AlertingByFlankerConflict_All_files/figure-latex/plotting tables-4.pdf",
    getPath(
      "../../../Results/Diagrams/AlertingByFlankerConflict_ANT_VR_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./AlertingByFlankerConflict_All_files/figure-latex/plotting tables-5.pdf",
    getPath(
      "../../../Results/Diagrams/AlertingByFlankerConflict_ANT_VR_B_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./AlertingByFlankerConflict_All_files/figure-latex/plotting tables-6.pdf",
    getPath(
      "../../../Results/Diagrams/AlertingByFlankerConflict_ANT_VR_B_ACC.pdf"
    ),
    overwrite = TRUE
  )
  unlink(getPath("./AlertingByFlankerConflict_All_files"),
    recursive = TRUE
  )
}

################################################################################

plotAlertingByFlankerConflictByLocationConflict_All <- function() {
  if (!require(rmarkdown)) {
    install.packages("rmarkdown")
  }
  if (!require(staplr)) {
    install.packages("staplr")
  }
  library(rmarkdown)
  library(staplr)

  tryCatch({
    rmarkdown::render("./AlertingByFlankerConflictByLocationConflict_All.Rmd")
  })
  file.remove(getPath("./AlertingByFlankerConflictByLocationConflict_All.pdf"))
  file.remove(getPath("./AlertingByFlankerConflictByLocationConflict_All.tex"))
  file.copy(
    "./AlertingByFlankerConflictByLocationConflict_All_files/figure-latex/plotting tables-1.pdf",
    getPath(
      "../../../Results/Diagrams/AlertingByFlankerConflictByLocationConflict_ANT_R_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./AlertingByFlankerConflictByLocationConflict_All_files/figure-latex/plotting tables-2.pdf",
    getPath(
      "../../../Results/Diagrams/AlertingByFlankerConflictByLocationConflict_ANT_R_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./AlertingByFlankerConflictByLocationConflict_All_files/figure-latex/plotting tables-3.pdf",
    getPath(
      "../../../Results/Diagrams/AlertingByFlankerConflictByLocationConflict_ANT_VR_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./AlertingByFlankerConflictByLocationConflict_All_files/figure-latex/plotting tables-4.pdf",
    getPath(
      "../../../Results/Diagrams/AlertingByFlankerConflictByLocationConflict_ANT_VR_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./AlertingByFlankerConflictByLocationConflict_All_files/figure-latex/plotting tables-5.pdf",
    getPath(
      "../../../Results/Diagrams/AlertingByFlankerConflictByLocationConflict_ANT_VR_B_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./AlertingByFlankerConflictByLocationConflict_All_files/figure-latex/plotting tables-6.pdf",
    getPath(
      "../../../Results/Diagrams/AlertingByFlankerConflictByLocationConflict_ANT_VR_B_ACC.pdf"
    ),
    overwrite = TRUE
  )
  unlink(
    getPath(
      "./AlertingByFlankerConflictByLocationConflict_All_files"
    ),
    recursive = TRUE
  )
}

################################################################################

plotOrientingByFlankerConflict_All <- function() {
  if (!require(rmarkdown)) {
    install.packages("rmarkdown")
  }
  if (!require(staplr)) {
    install.packages("staplr")
  }
  library(rmarkdown)
  library(staplr)

  tryCatch({
    rmarkdown::render("./OrientingByFlankerConflict_All.Rmd")
  })
  file.remove(getPath("./OrientingByFlankerConflict_All.pdf"))
  file.remove(getPath("./OrientingByFlankerConflict_All.tex"))
  file.copy(
    "./OrientingByFlankerConflict_All_files/figure-latex/plotting tables-1.pdf",
    getPath(
      "../../../Results/Diagrams/OrientingByFlankerConflict_ANT_R_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./OrientingByFlankerConflict_All_files/figure-latex/plotting tables-2.pdf",
    getPath(
      "../../../Results/Diagrams/OrientingByFlankerConflict_ANT_R_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./OrientingByFlankerConflict_All_files/figure-latex/plotting tables-3.pdf",
    getPath(
      "../../../Results/Diagrams/OrientingByFlankerConflict_ANT_VR_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./OrientingByFlankerConflict_All_files/figure-latex/plotting tables-4.pdf",
    getPath(
      "../../../Results/Diagrams/OrientingByFlankerConflict_ANT_VR_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./OrientingByFlankerConflict_All_files/figure-latex/plotting tables-5.pdf",
    getPath(
      "../../../Results/Diagrams/OrientingByFlankerConflict_ANT_VR_B_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./OrientingByFlankerConflict_All_files/figure-latex/plotting tables-6.pdf",
    getPath(
      "../../../Results/Diagrams/OrientingByFlankerConflict_ANT_VR_B_ACC.pdf"
    ),
    overwrite = TRUE
  )
  unlink(getPath("./OrientingByFlankerConflict_All_files"),
    recursive = TRUE
  )
}

################################################################################

plotCueValidityByFlankerConflict_All <- function() {
  if (!require(rmarkdown)) {
    install.packages("rmarkdown")
  }
  if (!require(staplr)) {
    install.packages("staplr")
  }
  library(rmarkdown)
  library(staplr)

  tryCatch({
    rmarkdown::render("./CueValidityByFlankerConflict_All.Rmd")
  })
  file.remove(getPath("./CueValidityByFlankerConflict_All.pdf"))
  file.remove(getPath("./CueValidityByFlankerConflict_All.tex"))
  file.copy(
    "./CueValidityByFlankerConflict_All_files/figure-latex/plotting tables-1.pdf",
    getPath(
      "../../../Results/Diagrams/CueValidityByFlankerConflict_ANT_R_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueValidityByFlankerConflict_All_files/figure-latex/plotting tables-2.pdf",
    getPath(
      "../../../Results/Diagrams/CueValidityByFlankerConflict_ANT_R_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueValidityByFlankerConflict_All_files/figure-latex/plotting tables-3.pdf",
    getPath(
      "../../../Results/Diagrams/CueValidityByFlankerConflict_ANT_VR_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueValidityByFlankerConflict_All_files/figure-latex/plotting tables-4.pdf",
    getPath(
      "../../../Results/Diagrams/CueValidityByFlankerConflict_ANT_VR_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueValidityByFlankerConflict_All_files/figure-latex/plotting tables-5.pdf",
    getPath(
      "../../../Results/Diagrams/CueValidityByFlankerConflict_ANT_VR_B_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueValidityByFlankerConflict_All_files/figure-latex/plotting tables-6.pdf",
    getPath(
      "../../../Results/Diagrams/CueValidityByFlankerConflict_ANT_VR_B_ACC.pdf"
    ),
    overwrite = TRUE
  )
  unlink(getPath("./CueValidityByFlankerConflict_All_files"),
    recursive = TRUE
  )
}

################################################################################

plotFlankerCongruencyByLocationCongruency_All <- function() {
  if (!require(rmarkdown)) {
    install.packages("rmarkdown")
  }
  if (!require(staplr)) {
    install.packages("staplr")
  }
  library(rmarkdown)
  library(staplr)

  tryCatch({
    rmarkdown::render("./FlankerCongruencyByLocationCongruency_All.Rmd")
  })
  file.remove(getPath("./FlankerCongruencyByLocationCongruency_All.pdf"))
  file.remove(getPath("./FlankerCongruencyByLocationCongruency_All.tex"))
  file.copy(
    "./FlankerCongruencyByLocationCongruency_All_files/figure-latex/plotting tables-1.pdf",
    getPath(
      "../../../Results/Diagrams/FlankerCongruencyByLocationCongruency_ANT_R_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./FlankerCongruencyByLocationCongruency_All_files/figure-latex/plotting tables-2.pdf",
    getPath(
      "../../../Results/Diagrams/FlankerCongruencyByLocationCongruency_ANT_R_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./FlankerCongruencyByLocationCongruency_All_files/figure-latex/plotting tables-3.pdf",
    getPath(
      "../../../Results/Diagrams/FlankerCongruencyByLocationCongruency_ANT_VR_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./FlankerCongruencyByLocationCongruency_All_files/figure-latex/plotting tables-4.pdf",
    getPath(
      "../../../Results/Diagrams/FlankerCongruencyByLocationCongruency_ANT_VR_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./FlankerCongruencyByLocationCongruency_All_files/figure-latex/plotting tables-5.pdf",
    getPath(
      "../../../Results/Diagrams/FlankerCongruencyByLocationCongruency_ANT_VR_B_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./FlankerCongruencyByLocationCongruency_All_files/figure-latex/plotting tables-6.pdf",
    getPath(
      "../../../Results/Diagrams/FlankerCongruencyByLocationCongruency_ANT_VR_B_ACC.pdf"
    ),
    overwrite = TRUE
  )
  unlink(getPath("./FlankerCongruencyByLocationCongruency_All_files"),
    recursive = TRUE
  )
}

################################################################################

plotAlertingByLocationConflict_All <- function() {
  if (!require(rmarkdown)) {
    install.packages("rmarkdown")
  }
  if (!require(staplr)) {
    install.packages("staplr")
  }
  library(rmarkdown)
  library(staplr)

  tryCatch({
    rmarkdown::render("./AlertingByLocationConflict_All.Rmd")
  })
  file.remove(getPath("./AlertingByLocationConflict_All.pdf"))
  file.remove(getPath("./AlertingByLocationConflict_All.tex"))
  file.copy(
    "./AlertingByLocationConflict_All_files/figure-latex/plotting tables-1.pdf",
    getPath(
      "../../../Results/Diagrams/AlertingByLocationConflict_ANT_R_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./AlertingByLocationConflict_All_files/figure-latex/plotting tables-2.pdf",
    getPath(
      "../../../Results/Diagrams/AlertingByLocationConflict_ANT_R_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./AlertingByLocationConflict_All_files/figure-latex/plotting tables-3.pdf",
    getPath(
      "../../../Results/Diagrams/AlertingByLocationConflict_ANT_VR_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./AlertingByLocationConflict_All_files/figure-latex/plotting tables-4.pdf",
    getPath(
      "../../../Results/Diagrams/AlertingByLocationConflict_ANT_VR_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./AlertingByLocationConflict_All_files/figure-latex/plotting tables-5.pdf",
    getPath(
      "../../../Results/Diagrams/AlertingByLocationConflict_ANT_VR_B_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./AlertingByLocationConflict_All_files/figure-latex/plotting tables-6.pdf",
    getPath(
      "../../../Results/Diagrams/AlertingByLocationConflict_ANT_VR_B_ACC.pdf"
    ),
    overwrite = TRUE
  )
  unlink(getPath("./AlertingByLocationConflict_All_files"),
    recursive = TRUE
  )
}

################################################################################

plotOrientingByLocationConflict_All <- function() {
  if (!require(rmarkdown)) {
    install.packages("rmarkdown")
  }
  if (!require(staplr)) {
    install.packages("staplr")
  }
  library(rmarkdown)
  library(staplr)

  tryCatch({
    rmarkdown::render("./OrientingByLocationConflict_All.Rmd")
  })
  file.remove(getPath("./OrientingByLocationConflict_All.pdf"))
  file.remove(getPath("./OrientingByLocationConflict_All.tex"))
  file.copy(
    "./OrientingByLocationConflict_All_files/figure-latex/plotting tables-1.pdf",
    getPath(
      "../../../Results/Diagrams/OrientingByLocationConflict_ANT_R_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./OrientingByLocationConflict_All_files/figure-latex/plotting tables-2.pdf",
    getPath(
      "../../../Results/Diagrams/OrientingByLocationConflict_ANT_R_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./OrientingByLocationConflict_All_files/figure-latex/plotting tables-3.pdf",
    getPath(
      "../../../Results/Diagrams/OrientingByLocationConflict_ANT_VR_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./OrientingByLocationConflict_All_files/figure-latex/plotting tables-4.pdf",
    getPath(
      "../../../Results/Diagrams/OrientingByLocationConflict_ANT_VR_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./OrientingByLocationConflict_All_files/figure-latex/plotting tables-5.pdf",
    getPath(
      "../../../Results/Diagrams/OrientingByLocationConflict_ANT_VR_B_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./OrientingByLocationConflict_All_files/figure-latex/plotting tables-6.pdf",
    getPath(
      "../../../Results/Diagrams/OrientingByLocationConflict_ANT_VR_B_ACC.pdf"
    ),
    overwrite = TRUE
  )
  unlink(getPath("./OrientingByLocationConflict_All_files"),
    recursive = TRUE
  )
}

################################################################################

plotCueValidityByLocationConflict_All <- function() {
  if (!require(rmarkdown)) {
    install.packages("rmarkdown")
  }
  if (!require(staplr)) {
    install.packages("staplr")
  }
  library(rmarkdown)
  library(staplr)

  tryCatch({
    rmarkdown::render("./CueValidityByLocationConflict_All.Rmd")
  })
  file.remove(getPath("./CueValidityByLocationConflict_All.pdf"))
  file.remove(getPath("./CueValidityByLocationConflict_All.tex"))
  file.copy(
    "./CueValidityByLocationConflict_All_files/figure-latex/plotting tables-1.pdf",
    getPath(
      "../../../Results/Diagrams/CueValidityByLocationConflict_ANT_R_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueValidityByLocationConflict_All_files/figure-latex/plotting tables-2.pdf",
    getPath(
      "../../../Results/Diagrams/CueValidityByLocationConflict_ANT_R_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueValidityByLocationConflict_All_files/figure-latex/plotting tables-3.pdf",
    getPath(
      "../../../Results/Diagrams/CueValidityByLocationConflict_ANT_VR_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueValidityByLocationConflict_All_files/figure-latex/plotting tables-4.pdf",
    getPath(
      "../../../Results/Diagrams/CueValidityByLocationConflict_ANT_VR_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueValidityByLocationConflict_All_files/figure-latex/plotting tables-5.pdf",
    getPath(
      "../../../Results/Diagrams/CueValidityByLocationConflict_ANT_VR_B_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueValidityByLocationConflict_All_files/figure-latex/plotting tables-6.pdf",
    getPath(
      "../../../Results/Diagrams/CueValidityByLocationConflict_ANT_VR_B_ACC.pdf"
    ),
    overwrite = TRUE
  )
  unlink(getPath("./CueValidityByLocationConflict_All_files"),
    recursive = TRUE
  )
}

################################################################################

plotCueToTargetIntervalByCueValidity_All <- function() {
  if (!require(rmarkdown)) {
    install.packages("rmarkdown")
  }
  if (!require(staplr)) {
    install.packages("staplr")
  }
  library(rmarkdown)
  library(staplr)

  tryCatch({
    rmarkdown::render("./CueToTargetIntervalByCueValidity_All.Rmd")
  })
  file.remove(getPath("./CueToTargetIntervalByCueValidity_All.pdf"))
  file.remove(getPath("./CueToTargetIntervalByCueValidity_All.tex"))
  file.copy(
    "./CueToTargetIntervalByCueValidity_All_files/figure-latex/plotting tables-1.pdf",
    getPath(
      "../../../Results/Diagrams/CueToTargetIntervalByCueValidity_ANT_R_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueToTargetIntervalByCueValidity_All_files/figure-latex/plotting tables-2.pdf",
    getPath(
      "../../../Results/Diagrams/CueToTargetIntervalByCueValidity_ANT_R_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueToTargetIntervalByCueValidity_All_files/figure-latex/plotting tables-3.pdf",
    getPath(
      "../../../Results/Diagrams/CueToTargetIntervalByCueValidity_ANT_VR_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueToTargetIntervalByCueValidity_All_files/figure-latex/plotting tables-4.pdf",
    getPath(
      "../../../Results/Diagrams/CueToTargetIntervalByCueValidity_ANT_VR_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueToTargetIntervalByCueValidity_All_files/figure-latex/plotting tables-5.pdf",
    getPath(
      "../../../Results/Diagrams/CueToTargetIntervalByCueValidity_ANT_VR_B_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueToTargetIntervalByCueValidity_All_files/figure-latex/plotting tables-6.pdf",
    getPath(
      "../../../Results/Diagrams/CueToTargetIntervalByCueValidity_ANT_VR_B_ACC.pdf"
    ),
    overwrite = TRUE
  )
  unlink(getPath("./CueToTargetIntervalByCueValidity_All_files"),
    recursive = TRUE
  )
}

################################################################################

plotCueToTargetIntervalByCueType_All <- function() {
  if (!require(rmarkdown)) {
    install.packages("rmarkdown")
  }
  if (!require(staplr)) {
    install.packages("staplr")
  }
  library(rmarkdown)
  library(staplr)

  tryCatch({
    rmarkdown::render("./CueToTargetIntervalByCueType_All.Rmd")
  })
  file.remove(getPath("./CueToTargetIntervalByCueType_All.pdf"))
  file.remove(getPath("./CueToTargetIntervalByCueType_All.tex"))
  file.copy(
    "./CueToTargetIntervalByCueType_All_files/figure-latex/plotting tables-1.pdf",
    getPath(
      "../../../Results/Diagrams/CueToTargetIntervalByCueType_ANT_R_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueToTargetIntervalByCueType_All_files/figure-latex/plotting tables-2.pdf",
    getPath(
      "../../../Results/Diagrams/CueToTargetIntervalByCueType_ANT_R_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueToTargetIntervalByCueType_All_files/figure-latex/plotting tables-3.pdf",
    getPath(
      "../../../Results/Diagrams/CueToTargetIntervalByCueType_ANT_VR_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueToTargetIntervalByCueType_All_files/figure-latex/plotting tables-4.pdf",
    getPath(
      "../../../Results/Diagrams/CueToTargetIntervalByCueType_ANT_VR_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueToTargetIntervalByCueType_All_files/figure-latex/plotting tables-5.pdf",
    getPath(
      "../../../Results/Diagrams/CueToTargetIntervalByCueType_ANT_VR_B_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueToTargetIntervalByCueType_All_files/figure-latex/plotting tables-6.pdf",
    getPath(
      "../../../Results/Diagrams/CueToTargetIntervalByCueType_ANT_VR_B_ACC.pdf"
    ),
    overwrite = TRUE
  )
  unlink(getPath("./CueToTargetIntervalByCueType_All_files"),
    recursive = TRUE
  )
}

################################################################################

plotCueToTargetIntervalByFlankerConflict_All <- function() {
  if (!require(rmarkdown)) {
    install.packages("rmarkdown")
  }
  if (!require(staplr)) {
    install.packages("staplr")
  }
  library(rmarkdown)
  library(staplr)

  tryCatch({
    rmarkdown::render("./CueToTargetIntervalByFlankerConflict_All.Rmd")
  })
  file.remove(getPath("./CueToTargetIntervalByFlankerConflict_All.pdf"))
  file.remove(getPath("./CueToTargetIntervalByFlankerConflict_All.tex"))
  file.copy(
    "./CueToTargetIntervalByFlankerConflict_All_files/figure-latex/plotting tables-1.pdf",
    getPath(
      "../../../Results/Diagrams/CueToTargetIntervalByFlankerConflict_ANT_R_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueToTargetIntervalByFlankerConflict_All_files/figure-latex/plotting tables-2.pdf",
    getPath(
      "../../../Results/Diagrams/CueToTargetIntervalByFlankerConflict_ANT_R_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueToTargetIntervalByFlankerConflict_All_files/figure-latex/plotting tables-3.pdf",
    getPath(
      "../../../Results/Diagrams/CueToTargetIntervalByFlankerConflict_ANT_VR_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueToTargetIntervalByFlankerConflict_All_files/figure-latex/plotting tables-4.pdf",
    getPath(
      "../../../Results/Diagrams/CueToTargetIntervalByFlankerConflict_ANT_VR_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueToTargetIntervalByFlankerConflict_All_files/figure-latex/plotting tables-5.pdf",
    getPath(
      "../../../Results/Diagrams/CueToTargetIntervalByFlankerConflict_ANT_VR_B_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueToTargetIntervalByFlankerConflict_All_files/figure-latex/plotting tables-6.pdf",
    getPath(
      "../../../Results/Diagrams/CueToTargetIntervalByFlankerConflict_ANT_VR_B_ACC.pdf"
    ),
    overwrite = TRUE
  )
  unlink(getPath("./CueToTargetIntervalByFlankerConflict_All_files"),
    recursive = TRUE
  )
}

################################################################################

plotCueToTargetIntervalByLocationConflict_All <- function() {
  if (!require(rmarkdown)) {
    install.packages("rmarkdown")
  }
  if (!require(staplr)) {
    install.packages("staplr")
  }
  library(rmarkdown)
  library(staplr)

  tryCatch({
    rmarkdown::render("./CueToTargetIntervalByLocationConflict_All.Rmd")
  })
  file.remove(getPath("./CueToTargetIntervalByLocationConflict_All.pdf"))
  file.remove(getPath("./CueToTargetIntervalByLocationConflict_All.tex"))
  file.copy(
    "./CueToTargetIntervalByLocationConflict_All_files/figure-latex/plotting tables-1.pdf",
    getPath(
      "../../../Results/Diagrams/CueToTargetIntervalByLocationConflict_ANT_R_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueToTargetIntervalByLocationConflict_All_files/figure-latex/plotting tables-2.pdf",
    getPath(
      "../../../Results/Diagrams/CueToTargetIntervalByLocationConflict_ANT_R_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueToTargetIntervalByLocationConflict_All_files/figure-latex/plotting tables-3.pdf",
    getPath(
      "../../../Results/Diagrams/CueToTargetIntervalByLocationConflict_ANT_VR_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueToTargetIntervalByLocationConflict_All_files/figure-latex/plotting tables-4.pdf",
    getPath(
      "../../../Results/Diagrams/CueToTargetIntervalByLocationConflict_ANT_VR_ACC.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueToTargetIntervalByLocationConflict_All_files/figure-latex/plotting tables-5.pdf",
    getPath(
      "../../../Results/Diagrams/CueToTargetIntervalByLocationConflict_ANT_VR_B_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.copy(
    "./CueToTargetIntervalByLocationConflict_All_files/figure-latex/plotting tables-6.pdf",
    getPath(
      "../../../Results/Diagrams/CueToTargetIntervalByLocationConflict_ANT_VR_B_ACC.pdf"
    ),
    overwrite = TRUE
  )
  unlink(getPath("./CueToTargetIntervalByLocationConflict_All_files"),
    recursive = TRUE
  )
}

################################################################################

plotPairwiseComparisons_All <- function(participantsFolder) {
  if (!require(rmarkdown)) {
    install.packages("rmarkdown")
  }
  if (!require(staplr)) {
    install.packages("staplr")
  }
  if (!require(knitr)) {
    install.packages("knitr")
  }
  library(rmarkdown)
  library(staplr)
  library(knitr)

  tryCatch({
    rmarkdown::render("./PairwiseComparisons_R_VR_RT_All.Rmd")
  })
  remove_pages(
    rmpages = c(1, 2),
    "./PairwiseComparisons_R_VR_RT_All.pdf",
    "./PairwiseComparisons_R_VR_RT_All.pdf"
  )
  plot_crop("./PairwiseComparisons_R_VR_RT_All.pdf")
  file.copy(
    "./PairwiseComparisons_R_VR_RT_All.pdf",
    getPath(
      "../../../Results/Tables/PairwiseComparisons_R_VR_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.remove("./PairwiseComparisons_R_VR_RT_All.pdf")
  file.remove("./PairwiseComparisons_R_VR_RT_All.tex")
  file.remove("./PairwiseComparisons_R_VR_RT_All.ttt")

  tryCatch({
    rmarkdown::render("./PairwiseComparisons_R_VR_B_RT_All.Rmd")
  })
  remove_pages(
    rmpages = c(1, 2),
    "./PairwiseComparisons_R_VR_B_RT_All.pdf",
    "./PairwiseComparisons_R_VR_B_RT_All.pdf"
  )
  plot_crop("./PairwiseComparisons_R_VR_B_RT_All.pdf")
  file.copy(
    "./PairwiseComparisons_R_VR_B_RT_All.pdf",
    getPath(
      "../../../Results/Tables/PairwiseComparisons_R_VR_B_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.remove("./PairwiseComparisons_R_VR_B_RT_All.pdf")
  file.remove("./PairwiseComparisons_R_VR_B_RT_All.tex")
  file.remove("./PairwiseComparisons_R_VR_B_RT_All.ttt")

  tryCatch({
    rmarkdown::render("./PairwiseComparisons_VR_VR_B_RT_All.Rmd")
  })
  remove_pages(
    rmpages = c(1, 2),
    "./PairwiseComparisons_VR_VR_B_RT_All.pdf",
    "./PairwiseComparisons_VR_VR_B_RT_All.pdf"
  )
  plot_crop("./PairwiseComparisons_VR_VR_B_RT_All.pdf")
  file.copy(
    "./PairwiseComparisons_VR_VR_B_RT_All.pdf",
    getPath(
      "../../../Results/Tables/PairwiseComparisons_VR_VR_B_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.remove("./PairwiseComparisons_VR_VR_B_RT_All.pdf")
  file.remove("./PairwiseComparisons_VR_VR_B_RT_All.tex")
  file.remove("./PairwiseComparisons_VR_VR_B_RT_All.ttt")
}

################################################################################

plotPairwiseTTests_All <- function(participantsFolder) {
  if (!require(rmarkdown)) {
    install.packages("rmarkdown")
  }
  if (!require(staplr)) {
    install.packages("staplr")
  }
  if (!require(knitr)) {
    install.packages("knitr")
  }
  library(rmarkdown)
  library(staplr)
  library(knitr)

  tryCatch({
    rmarkdown::render("./PairwiseTTests_R_VR_RT_All.Rmd")
  })
  remove_pages(
    rmpages = c(1, 2),
    "./PairwiseTTests_R_VR_RT_All.pdf",
    "./PairwiseTTests_R_VR_RT_All.pdf"
  )
  plot_crop("./PairwiseTTests_R_VR_RT_All.pdf")
  file.copy(
    "./PairwiseTTests_R_VR_RT_All.pdf",
    getPath(
      "../../../Results/Tables/PairwiseTTests_R_VR_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.remove("./PairwiseTTests_R_VR_RT_All.pdf")
  file.remove("./PairwiseTTests_R_VR_RT_All.tex")
  file.remove("./PairwiseTTests_R_VR_RT_All.ttt")

  tryCatch({
    rmarkdown::render("./PairwiseTTests_R_VR_B_RT_All.Rmd")
  })
  remove_pages(
    rmpages = c(1, 2),
    "./PairwiseTTests_R_VR_B_RT_All.pdf",
    "./PairwiseTTests_R_VR_B_RT_All.pdf"
  )
  plot_crop("./PairwiseTTests_R_VR_B_RT_All.pdf")
  file.copy(
    "./PairwiseTTests_R_VR_B_RT_All.pdf",
    getPath(
      "../../../Results/Tables/PairwiseTTests_R_VR_B_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.remove("./PairwiseTTests_R_VR_B_RT_All.pdf")
  file.remove("./PairwiseTTests_R_VR_B_RT_All.tex")
  file.remove("./PairwiseTTests_R_VR_B_RT_All.ttt")

  tryCatch({
    rmarkdown::render("./PairwiseTTests_VR_VR_B_RT_All.Rmd")
  })
  remove_pages(
    rmpages = c(1, 2),
    "./PairwiseTTests_VR_VR_B_RT_All.pdf",
    "./PairwiseTTests_VR_VR_B_RT_All.pdf"
  )
  plot_crop("./PairwiseTTests_VR_VR_B_RT_All.pdf")
  file.copy(
    "./PairwiseTTests_VR_VR_B_RT_All.pdf",
    getPath(
      "../../../Results/Tables/PairwiseTTests_VR_VR_B_RT.pdf"
    ),
    overwrite = TRUE
  )
  file.remove("./PairwiseTTests_VR_VR_B_RT_All.pdf")
  file.remove("./PairwiseTTests_VR_VR_B_RT_All.tex")
  file.remove("./PairwiseTTests_VR_VR_B_RT_All.ttt")
}

################################################################################

# Execution

plotDemographics_All()
plotGenderAndAge_All()
plotEdNaHaToD_All()
plotJointNetworkAndInteractionEffects_All()
plotQualityOfExperience_All()
plotNetworkAndInteractionEffects_All()
plotCorrelationsOfNetworks_All()
plotAlertingByFlankerConflict_All()
plotAlertingByFlankerConflictByLocationConflict_All()
plotOrientingByFlankerConflict_All()
plotCueValidityByFlankerConflict_All()
plotFlankerCongruencyByLocationCongruency_All()
plotAlertingByLocationConflict_All()
plotOrientingByLocationConflict_All()
plotCueValidityByLocationConflict_All()
plotCueToTargetIntervalByCueValidity_All()
plotCueToTargetIntervalByCueType_All()
plotCueToTargetIntervalByFlankerConflict_All()
plotCueToTargetIntervalByLocationConflict_All()
plotPairwiseComparisons_All()
plotPairwiseTTests_All()

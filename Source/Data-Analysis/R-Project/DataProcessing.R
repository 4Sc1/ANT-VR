options(scipen = 999)

getPath <- function(relativePath) {
  result <- toString(paste(getwd(), relativePath, sep = "/", collapse = NULL))
}

importDemographicsAndQoE_All <- function() {
  if (!require(readr)) {
    install.packages("readr")
  }
  library(readr)

  result <- read_csv(getPath("../../../Data/Demographics + QoE.txt"))
}

importANT_R_All <- function() {
  if (!require(readr)) {
    install.packages("readr")
  }
  library(readr)

  ANT_R_P02 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P2.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P03 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P3.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P04 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P4.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P05 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P5.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P07 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P7.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P08 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P8.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P09 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P9.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P11 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P11.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P12 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P12.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P13 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P13.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P14 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P14.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P15 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P15.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P16 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P16.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P17 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P17.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P18 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P18.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P19 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P19.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P20 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P20.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P21 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P21.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P22 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P22.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P24 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P24.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P25 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P25.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P27 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P27.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P28 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P28.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P29 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P29.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P30 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P30.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P31 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P31.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P33 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P33.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P34 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P34.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P35 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P35.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P36 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P36.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P37 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P37.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P38 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P38.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P39 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P39.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P40 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P40.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P41 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P41.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P42 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P42.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P43 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P43.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P44 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P44.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P45 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P45.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P46 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P46.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P47 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P47.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P48 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P48.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P49 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P49.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_R_P50 <- read_csv(
    getPath("../../../Data/ANT-R/ANT-R_P50.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  result <- list(
    ANT_R_P02,
    ANT_R_P03,
    ANT_R_P04,
    ANT_R_P05,
    ANT_R_P07,
    ANT_R_P08,
    ANT_R_P09,
    ANT_R_P11,
    ANT_R_P12,
    ANT_R_P13,
    ANT_R_P14,
    ANT_R_P15,
    ANT_R_P16,
    ANT_R_P17,
    ANT_R_P18,
    ANT_R_P19,
    ANT_R_P20,
    ANT_R_P21,
    ANT_R_P22,
    ANT_R_P24,
    ANT_R_P25,
    ANT_R_P27,
    ANT_R_P28,
    ANT_R_P29,
    ANT_R_P30,
    ANT_R_P31,
    ANT_R_P33,
    ANT_R_P34,
    ANT_R_P35,
    ANT_R_P36,
    ANT_R_P37,
    ANT_R_P38,
    ANT_R_P39,
    ANT_R_P40,
    ANT_R_P41,
    ANT_R_P42,
    ANT_R_P43,
    ANT_R_P44,
    ANT_R_P45,
    ANT_R_P46,
    ANT_R_P47,
    ANT_R_P48,
    ANT_R_P49,
    ANT_R_P50
  )
}

importANT_VR_All <- function() {
  if (!require(readr)) {
    install.packages("readr")
  }
  library(readr)


  ANT_VR_P02 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P2.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P03 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P3.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P04 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P4.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P05 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P5.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P07 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P7.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P08 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P8.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P09 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P9.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P11 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P11.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P12 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P12.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P13 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P13.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P14 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P14.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P15 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P15.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P16 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P16.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P17 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P17.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P18 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P18.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P19 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P19.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P20 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P20.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P21 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P21.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P22 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P22.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P24 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P24.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P25 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P25.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P27 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P27.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P28 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P28.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P29 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P29.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P30 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P30.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P31 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P31.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P33 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P33.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P34 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P34.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P35 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P35.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P36 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P36.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P37 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P37.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P38 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P38.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P39 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P39.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P40 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P40.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P41 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P41.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P42 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P42.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P43 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P43.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P44 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P44.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P45 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P45.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P46 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P46.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P47 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P47.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P48 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P48.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P49 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P49.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_P50 <- read_csv(
    getPath("../../../Data/ANT-VR/ANT-VR_P50.txt"),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  result <- list(
    ANT_VR_P02,
    ANT_VR_P03,
    ANT_VR_P04,
    ANT_VR_P05,
    ANT_VR_P07,
    ANT_VR_P08,
    ANT_VR_P09,
    ANT_VR_P11,
    ANT_VR_P12,
    ANT_VR_P13,
    ANT_VR_P14,
    ANT_VR_P15,
    ANT_VR_P16,
    ANT_VR_P17,
    ANT_VR_P18,
    ANT_VR_P19,
    ANT_VR_P20,
    ANT_VR_P21,
    ANT_VR_P22,
    ANT_VR_P24,
    ANT_VR_P25,
    ANT_VR_P27,
    ANT_VR_P28,
    ANT_VR_P29,
    ANT_VR_P30,
    ANT_VR_P31,
    ANT_VR_P33,
    ANT_VR_P34,
    ANT_VR_P35,
    ANT_VR_P36,
    ANT_VR_P37,
    ANT_VR_P38,
    ANT_VR_P39,
    ANT_VR_P40,
    ANT_VR_P41,
    ANT_VR_P42,
    ANT_VR_P43,
    ANT_VR_P44,
    ANT_VR_P45,
    ANT_VR_P46,
    ANT_VR_P47,
    ANT_VR_P48,
    ANT_VR_P49,
    ANT_VR_P50
  )
}

importANT_VR_B_All <- function() {
  if (!require(readr)) {
    install.packages("readr")
  }
  library(readr)

  ANT_VR_B_P02 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P2.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P03 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P3.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P04 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P4.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P05 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P5.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P07 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P7.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P08 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P8.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P09 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P9.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P11 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P11.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P12 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P12.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P13 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P13.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P14 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P14.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P15 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P15.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P16 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P16.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P17 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P17.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P18 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P18.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P19 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P19.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P20 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P20.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P21 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P21.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P22 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P22.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P24 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P24.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P25 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P25.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P27 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P27.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P28 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P28.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P29 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P29.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P30 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P30.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P31 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P31.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P33 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P33.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P34 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P34.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P35 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P35.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P36 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P36.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P37 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P37.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P38 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P38.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P39 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P39.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P40 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P40.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P41 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P41.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P42 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P42.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P43 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P43.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P44 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P44.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P45 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P45.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P46 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P46.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P47 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P47.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P48 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P48.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P49 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P49.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  ANT_VR_B_P50 <- read_csv(
    getPath(
      "../../../Data/ANT-VR Balanced/ANT-VR_Balanced_P50.txt"
    ),
    col_types = cols(
      IntervalBetweenCueAndTarget = col_character(),
      SlideTargetAndResponseCollection.RT = col_integer()
    )
  )

  result <- list(
    ANT_VR_B_P02,
    ANT_VR_B_P03,
    ANT_VR_B_P04,
    ANT_VR_B_P05,
    ANT_VR_B_P07,
    ANT_VR_B_P08,
    ANT_VR_B_P09,
    ANT_VR_B_P11,
    ANT_VR_B_P12,
    ANT_VR_B_P13,
    ANT_VR_B_P14,
    ANT_VR_B_P15,
    ANT_VR_B_P16,
    ANT_VR_B_P17,
    ANT_VR_B_P18,
    ANT_VR_B_P19,
    ANT_VR_B_P20,
    ANT_VR_B_P21,
    ANT_VR_B_P22,
    ANT_VR_B_P24,
    ANT_VR_B_P25,
    ANT_VR_B_P27,
    ANT_VR_B_P28,
    ANT_VR_B_P29,
    ANT_VR_B_P30,
    ANT_VR_B_P31,
    ANT_VR_B_P33,
    ANT_VR_B_P34,
    ANT_VR_B_P35,
    ANT_VR_B_P36,
    ANT_VR_B_P37,
    ANT_VR_B_P38,
    ANT_VR_B_P39,
    ANT_VR_B_P40,
    ANT_VR_B_P41,
    ANT_VR_B_P42,
    ANT_VR_B_P43,
    ANT_VR_B_P44,
    ANT_VR_B_P45,
    ANT_VR_B_P46,
    ANT_VR_B_P47,
    ANT_VR_B_P48,
    ANT_VR_B_P49,
    ANT_VR_B_P50
  )
}

getRoundedValue <- function(value) {
  if (!require(janitor)) {
    install.packages("janitor")
  }
  library(janitor)

  result <- formatC(round_half_up(value, digit = 2),
    format = "f",
    digits = 2
  )
}

filterByGender <- function(genderName, values) {
  result <- subset(values, Gender == genderName)
}

getGenderNumeric <- function(genderName) {
  if (genderName == "Non-binary") {
    return(2)
  }

  if (genderName == "Female") {
    return(1)
  }

  if (genderName == "Male") {
    return(0)
  }

  return(-1)
}

getEducationNumeric <- function(educationName) {
  if (educationName == "University or Higher") {
    return(3)
  }

  if (educationName == "College or Vocational") {
    return(2)
  }

  if (educationName == "Undergraduate") {
    return(1)
  }

  return(-1)
}

getNationalityNumeric <- function(nationalityName) {
  if (nationalityName == "Belgian") {
    return(1)
  }

  if (nationalityName == "Bulgarian") {
    return(2)
  }

  if (nationalityName == "Canadian") {
    return(3)
  }

  if (nationalityName == "Chinese") {
    return(4)
  }

  if (nationalityName == "Colombian") {
    return(5)
  }

  if (nationalityName == "Dutch") {
    return(6)
  }

  if (nationalityName == "Estonian") {
    return(7)
  }

  if (nationalityName == "Finnish") {
    return(8)
  }

  if (nationalityName == "German") {
    return(9)
  }

  if (nationalityName == "German-American") {
    return(10)
  }

  if (nationalityName == "Greek") {
    return(11)
  }

  if (nationalityName == "Greek-German") {
    return(12)
  }

  if (nationalityName == "Polish") {
    return(13)
  }

  if (nationalityName == "Spanish") {
    return(14)
  }

  if (nationalityName == "Thai") {
    return(15)
  }

  if (nationalityName == "Turkish") {
    return(16)
  }

  if (nationalityName == "Irish") {
    return(17)
  }

  return(-1)
}

getHandednessNumeric <- function(handednessName) {
  if (handednessName == "Right") {
    return(1)
  }

  if (handednessName == "Left") {
    return(0)
  }

  return(-1)
}

getTimeOfDayNumeric <- function(timeOfDayName) {
  if (timeOfDayName == "Evening") {
    return(1)
  }

  if (timeOfDayName == "Morning") {
    return(0)
  }

  return(-1)
}

getCorrectResult <- function(participantResults) {
  result <- subset(
    participantResults,
    SlideTargetAndResponseCollection.ACC == 1
  )
}

getIncorrectResult <- function(participantResults) {
  result <- subset(
    participantResults,
    SlideTargetAndResponseCollection.ACC == 0
  )
}

getNC <- function(participantResults) {
  result <- subset(participantResults, CueCondition == "no")
}

getDC <- function(participantResults) {
  result <- subset(participantResults, CueCondition == "double")
}

getDoubleOrNC <- function(participantResults) {
  result <- subset(
    participantResults,
    CueCondition == "double" | CueCondition == "no"
  )
}

getDoubleOrVC <- function(participantResults) {
  result <- subset(
    participantResults,
    CueValidity == "double" | CueValidity == "valid"
  )
}

getVC <- function(participantResults) {
  result <- subset(participantResults, CueValidity == "valid")
}

getValidOrIVC <- function(participantResults) {
  result <- subset(
    participantResults,
    CueValidity == "valid" | CueValidity == "invalid"
  )
}

getIVC <- function(participantResults) {
  result <- subset(participantResults, CueValidity == "invalid")
}

getCueToTarget0 <- function(participantResults) {
  result <- subset(participantResults, IntervalBetweenCueAndTarget == "0")
}

getCueToTarget400 <- function(participantResults) {
  result <- subset(participantResults, IntervalBetweenCueAndTarget == "400")
}

getCueToTarget800 <- function(participantResults) {
  result <- subset(participantResults, IntervalBetweenCueAndTarget == "800")
}

getCueToTargetNC <- function(participantResults) {
  result <- subset(participantResults, IntervalBetweenCueAndTarget == "no-cue")
}

getFlankersCongruent <- function(participantResults) {
  result <- subset(participantResults, FlankerCondition == "congruent")
}

getFlankersIncongruent <- function(participantResults) {
  result <- subset(participantResults, FlankerCondition == "incongruent")
}

getLocationCongruent <- function(participantResults) {
  result <- subset(participantResults, LocationCondition == "congruent")
}

getLocationIncongruent <- function(participantResults) {
  result <- subset(participantResults, LocationCondition == "incongruent")
}

getReactMean <- function(participantResults) {
  result <- mean(participantResults$SlideTargetAndResponseCollection.RT)
}

getAcc <- function(participantResults) {
  correctParticipantResults <- getCorrectResult(participantResults)
  result <- 100 * (nrow(correctParticipantResults) / nrow(participantResults))
}

# RT
getRT <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  result <- getReactMean(correctResults)
}

# RT_NC
getRT_NC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  noCueResults <- getNC(correctResults)
  result <- getReactMean(noCueResults)
}

# RT_DC
getRT_DC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleCueResults <- getDC(correctResults)
  result <- getReactMean(doubleCueResults)
}

# RT_DC_FC
getRT_DC_FC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleCueResults <- getDC(correctResults)
  fcResults <- getFlankersCongruent(doubleCueResults)

  result <- getReactMean(fcResults)
}

# RT_DC_FIC
getRT_DC_FIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleCueResults <- getDC(correctResults)
  ficResults <- getFlankersIncongruent(doubleCueResults)

  result <- getReactMean(ficResults)
}

# RT_VC
getRT_VC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  validCueResults <- getVC(correctResults)
  result <- getReactMean(validCueResults)
}

# RT_IVC
getRT_IVC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  invalidCueResults <- getIVC(correctResults)
  result <- getReactMean(invalidCueResults)
}

# RT_VC_0
getRT_VC_0 <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  validCueResults <- getVC(correctResults)
  cueToTarget0Results <- getCueToTarget0(validCueResults)
  result <- getReactMean(cueToTarget0Results)
}

# RT_VC_400
getRT_VC_400 <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  validCueResults <- getVC(correctResults)
  cueToTarget400Results <- getCueToTarget400(validCueResults)
  result <- getReactMean(cueToTarget400Results)
}

# RT_VC_800
getRT_VC_800 <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  validCueResults <- getVC(correctResults)
  cueToTarget800Results <- getCueToTarget800(validCueResults)
  result <- getReactMean(cueToTarget800Results)
}

# RT_IVC_0
getRT_IVC_0 <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  invalidCueResults <- getIVC(correctResults)
  cueToTarget0Results <- getCueToTarget0(invalidCueResults)
  result <- getReactMean(cueToTarget0Results)
}

# RT_IVC_400
getRT_IVC_400 <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  invalidCueResults <- getIVC(correctResults)
  cueToTarget400Results <- getCueToTarget400(invalidCueResults)
  result <- getReactMean(cueToTarget400Results)
}

# RT_IVC_800
getRT_IVC_800 <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  invalidCueResults <- getIVC(correctResults)
  cueToTarget800Results <- getCueToTarget800(invalidCueResults)
  result <- getReactMean(cueToTarget800Results)
}

# RT_FC
getRT_FC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  fcResults <- getFlankersCongruent(correctResults)
  result <- getReactMean(fcResults)
}

# RT_FC_0
getRT_FC_0 <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  fcResults <- getFlankersCongruent(correctResults)
  cueToTarget0Results <- getCueToTarget0(fcResults)
  result <- getReactMean(cueToTarget0Results)
}

# RT_FC_400
getRT_FC_400 <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  fcResults <- getFlankersCongruent(correctResults)
  cueToTarget400Results <- getCueToTarget400(fcResults)
  result <- getReactMean(cueToTarget400Results)
}

# RT_FC_800
getRT_FC_800 <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  fcResults <- getFlankersCongruent(correctResults)
  cueToTarget800Results <- getCueToTarget800(fcResults)
  result <- getReactMean(cueToTarget800Results)
}

# RT_FIC
getRT_FIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  ficResults <- getFlankersIncongruent(correctResults)
  result <- getReactMean(ficResults)
}

# RT_FIC_0
getRT_FIC_0 <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  ficResults <- getFlankersIncongruent(correctResults)
  cueToTarget0Results <- getCueToTarget0(ficResults)
  result <- getReactMean(cueToTarget0Results)
}

# RT_FIC_400
getRT_FIC_400 <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  ficResults <- getFlankersIncongruent(correctResults)
  cueToTarget400Results <- getCueToTarget400(ficResults)
  result <- getReactMean(cueToTarget400Results)
}

# RT_FIC_800
getRT_FIC_800 <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  ficResults <- getFlankersIncongruent(correctResults)
  cueToTarget800Results <- getCueToTarget800(ficResults)
  result <- getReactMean(cueToTarget800Results)
}

# RT_LC
getRT_LC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  lcResults <- getLocationCongruent(correctResults)
  result <- getReactMean(lcResults)
}

# RT_LC_0
getRT_LC_0 <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  lcResults <- getLocationCongruent(correctResults)
  cueToTarget0Results <- getCueToTarget0(lcResults)
  result <- getReactMean(cueToTarget0Results)
}

# RT_LC_400
getRT_LC_400 <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  lcResults <- getLocationCongruent(correctResults)
  cueToTarget400Results <- getCueToTarget400(lcResults)
  result <- getReactMean(cueToTarget400Results)
}

# RT_LC_800
getRT_LC_800 <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  lcResults <- getLocationCongruent(correctResults)
  cueToTarget800Results <- getCueToTarget800(lcResults)
  result <- getReactMean(cueToTarget800Results)
}

# RT_LIC
getRT_LIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  licResults <- getLocationIncongruent(correctResults)
  result <- getReactMean(licResults)
}

# RT_LIC_0
getRT_LIC_0 <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  licResults <- getLocationIncongruent(correctResults)
  cueToTarget0Results <- getCueToTarget0(licResults)
  result <- getReactMean(cueToTarget0Results)
}

# RT_LIC_400
getRT_LIC_400 <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  licResults <- getLocationIncongruent(correctResults)
  cueToTarget400Results <- getCueToTarget400(licResults)
  result <- getReactMean(cueToTarget400Results)
}

# RT_LIC_800
getRT_LIC_800 <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  licResults <- getLocationIncongruent(correctResults)
  cueToTarget800Results <- getCueToTarget800(licResults)
  result <- getReactMean(cueToTarget800Results)
}

# RT_FC_LC
getRT_FC_LC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  fcResults <- getFlankersCongruent(correctResults)
  lcResults <- getLocationCongruent(fcResults)

  result <- getReactMean(lcResults)
}

# RT_FC_LIC
getRT_FC_LIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  fcResults <- getFlankersCongruent(correctResults)
  licResults <- getLocationIncongruent(fcResults)

  result <- getReactMean(licResults)
}

# RT_FIC_LC
getRT_FIC_LC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  ficResults <- getFlankersIncongruent(correctResults)
  lcResults <- getLocationCongruent(ficResults)

  result <- getReactMean(lcResults)
}

# RT_FIC_LIC
getRT_FIC_LIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  ficResults <- getFlankersIncongruent(correctResults)
  licResults <- getLocationIncongruent(ficResults)

  result <- getReactMean(licResults)
}

# RT_VC_FC
getRT_VC_FC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  validCueResults <- getVC(correctResults)
  fcResults <- getFlankersCongruent(validCueResults)
  result <- getReactMean(fcResults)
}

# RT_VC_FIC
getRT_VC_FIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  validCueResults <- getVC(correctResults)
  ficResults <- getFlankersIncongruent(validCueResults)
  result <- getReactMean(ficResults)
}

# RT_IVC_FC
getRT_IVC_FC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  invalidCueResults <- getIVC(correctResults)
  fcResults <- getFlankersCongruent(invalidCueResults)
  result <- getReactMean(fcResults)
}

# RT_IVC_FIC
getRT_IVC_FIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  invalidCueResults <- getIVC(correctResults)
  ficResults <- getFlankersIncongruent(invalidCueResults)
  result <- getReactMean(ficResults)
}

# RT_NC_LC
getRT_NC_LC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  noCueResults <- getNC(correctResults)
  lcResults <- getLocationCongruent(noCueResults)
  result <- getReactMean(lcResults)
}

# RT_NC_LIC
getRT_NC_LIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  noCueResults <- getNC(correctResults)
  licResults <- getLocationIncongruent(noCueResults)
  result <- getReactMean(licResults)
}

# RT_DC_LC
getRT_DC_LC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleCueResults <- getDC(correctResults)
  lcResults <- getLocationCongruent(doubleCueResults)
  result <- getReactMean(lcResults)
}

# RT_DC_LIC
getRT_DC_LIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleCueResults <- getDC(correctResults)
  licResults <- getLocationIncongruent(doubleCueResults)
  result <- getReactMean(licResults)
}

# RT_VC_LC
getRT_VC_LC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  validCueResults <- getVC(correctResults)
  lcResults <- getLocationCongruent(validCueResults)
  result <- getReactMean(lcResults)
}

# RT_VC_LIC
getRT_VC_LIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  validCueResults <- getVC(correctResults)
  licResults <- getLocationIncongruent(validCueResults)
  result <- getReactMean(licResults)
}

# RT_IVC_LC
getRT_IVC_LC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  invalidCueResults <- getIVC(correctResults)
  lcResults <- getLocationCongruent(invalidCueResults)
  result <- getReactMean(lcResults)
}

# RT_IVC_LIC
getRT_IVC_LIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  invalidCueResults <- getIVC(correctResults)
  licResults <- getLocationIncongruent(invalidCueResults)
  result <- getReactMean(licResults)
}

# RT_DC_0
getRT_DC_0 <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleCueResults <- getDC(correctResults)
  cueToTarget0Results <- getCueToTarget0(doubleCueResults)
  result <- getReactMean(cueToTarget0Results)
}

# RT_DC_400
getRT_DC_400 <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleCueResults <- getDC(correctResults)
  cueToTarget400Results <- getCueToTarget400(doubleCueResults)
  result <- getReactMean(cueToTarget400Results)
}

# RT_DC_800
getRT_DC_800 <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleCueResults <- getDC(correctResults)
  cueToTarget800Results <- getCueToTarget800(doubleCueResults)
  result <- getReactMean(cueToTarget800Results)
}

# RT_Alerting
getRT_Alerting <- function(participantResults) {
  result <- (getRT_NC(participantResults) - getRT_DC(participantResults))
}

# RT_Validity
getRT_Validity <- function(participantResults) {
  result <- (getRT_IVC(participantResults) - getRT_VC(participantResults))
}

# RT_Disengaging
getRT_Disengaging <- function(participantResults) {
  result <- (getRT_IVC(participantResults) - getRT_DC(participantResults))
}

# RT_Moving_Engaging
getRT_Moving_Engaging <- function(participantResults) {
  result <- (getRT_DC(participantResults) - getRT_VC(participantResults))
}

# RT_OrientingTime
getRT_OrientingTime <- function(participantResults) {
  result <- (getRT_VC_0(participantResults) - getRT_VC_800(participantResults))
}

# RT_FlankerConflict
getRT_FlankerConflict <- function(participantResults) {
  result <- (getRT_FIC(participantResults) - getRT_FC(participantResults))
}

# RT_LocationConflict
getRT_LocationConflict <- function(participantResults) {
  result <- (getRT_LIC(participantResults) - getRT_LC(participantResults))
}

# RT_FlankerByLocation
getRT_FlankerByLocation <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  fcResults <- getFlankersCongruent(correctResults)
  ficResults <- getFlankersIncongruent(correctResults)
  lcfcMean <- getReactMean(getLocationCongruent(fcResults))
  lcficMean <- getReactMean(getLocationCongruent(ficResults))
  licfcMean <- getReactMean(getLocationIncongruent(fcResults))
  licficMean <- getReactMean(getLocationIncongruent(ficResults))

  result <- (lcfcMean + licficMean - licfcMean - lcficMean)
}

# RT_AlertingByFlanker
getRT_AlertingByFlanker <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  noCueResults <- getNC(correctResults)
  doubleCueResults <- getDC(correctResults)
  ncfcMean <- getReactMean(getFlankersCongruent(noCueResults))
  ncficMean <- getReactMean(getFlankersIncongruent(noCueResults))
  dcfcMean <- getReactMean(getFlankersCongruent(doubleCueResults))
  dcficMean <- getReactMean(getFlankersIncongruent(doubleCueResults))

  result <- (ncficMean + dcfcMean - ncfcMean - dcficMean)
}

# RT_OrientingByFlanker
getRT_OrientingByFlanker <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  validCueResults <- getVC(correctResults)
  doubleCueResults <- getDC(correctResults)
  vcfcResults <- getReactMean(getFlankersCongruent(validCueResults))
  vcficResults <- getReactMean(getFlankersIncongruent(validCueResults))
  dcfcResults <- getReactMean(getFlankersCongruent(doubleCueResults))
  dcficResults <- getReactMean(getFlankersIncongruent(doubleCueResults))

  result <- (dcficResults + vcfcResults - dcfcResults - vcficResults)
}

# RT_ValidityByFlanker
getRT_ValidityByFlanker <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  validCueResults <- getVC(correctResults)
  invalidCueResults <- getIVC(correctResults)
  vcfcResults <- getReactMean(getFlankersCongruent(validCueResults))
  vcficResults <- getReactMean(getFlankersIncongruent(validCueResults))
  icfcResults <- getReactMean(getFlankersCongruent(invalidCueResults))
  icficResults <- getReactMean(getFlankersIncongruent(invalidCueResults))

  result <- (icficResults + vcfcResults - icfcResults - vcficResults)
}

# RT_AlertingByLocation
getRT_AlertingByLocation <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  noCueResults <- getNC(correctResults)
  doubleCueResults <- getDC(correctResults)
  nclcResults <- getReactMean(getLocationCongruent(noCueResults))
  nclicResults <- getReactMean(getLocationIncongruent(noCueResults))
  dclcResults <- getReactMean(getLocationCongruent(doubleCueResults))
  dclicResults <- getReactMean(getLocationIncongruent(doubleCueResults))

  result <- (nclicResults + dclcResults - nclcResults - dclicResults)
}

# RT_OrientingByLocation
getRT_OrientingByLocation <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  validCueResults <- getVC(correctResults)
  doubleCueResults <- getDC(correctResults)
  vclcResults <- getReactMean(getLocationCongruent(validCueResults))
  vclicResults <- getReactMean(getLocationIncongruent(validCueResults))
  dclcResults <- getReactMean(getLocationCongruent(doubleCueResults))
  dclicResults <- getReactMean(getLocationIncongruent(doubleCueResults))

  result <- (dclicResults + vclcResults - dclcResults - vclicResults)
}

# RT_ValidityByLocation
getRT_ValidityByLocation <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  validCueResults <- getVC(correctResults)
  invalidCueResults <- getIVC(correctResults)
  vclcResults <- getReactMean(getLocationCongruent(validCueResults))
  vclicResults <- getReactMean(getLocationIncongruent(validCueResults))
  iclcResults <- getReactMean(getLocationCongruent(invalidCueResults))
  iclicResults <- getReactMean(getLocationIncongruent(invalidCueResults))

  result <- (iclicResults + vclcResults - iclcResults - vclicResults)
}

# RT_IOR
getRT_IOR <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  validCueResults <- getVC(correctResults)
  invalidCueResults <- getIVC(correctResults)
  vcct0Results <- getReactMean(getCueToTarget0(validCueResults))
  vcct400Results <- getReactMean(getCueToTarget400(validCueResults))
  icct0Results <- getReactMean(getCueToTarget0(invalidCueResults))
  icct400Results <- getReactMean(getCueToTarget400(invalidCueResults))

  result <- (icct0Results + vcct400Results - vcct0Results - icct400Results)
}

# RT_NC_FC
getRT_NC_FC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  noCueResults <- getNC(correctResults)
  fcResults <- getFlankersCongruent(noCueResults)

  result <- getReactMean(fcResults)
}

# RT_NC_FIC
getRT_NC_FIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  noCueResults <- getNC(correctResults)
  ficResults <- getFlankersIncongruent(noCueResults)

  result <- getReactMean(ficResults)
}

# RT_NC_FCLC
getRT_NC_FCLC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  noCueResults <- getNC(correctResults)
  fcResults <- getFlankersCongruent(noCueResults)
  lcResults <- getLocationCongruent(fcResults)

  result <- getReactMean(lcResults)
}

# RT_NC_FICLC
getRT_NC_FICLC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  noCueResults <- getNC(correctResults)
  ficResults <- getFlankersIncongruent(noCueResults)
  lcResults <- getLocationCongruent(ficResults)

  result <- getReactMean(lcResults)
}

# RT_NC_FCLIC
getRT_NC_FCLIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  noCueResults <- getNC(correctResults)
  fcResults <- getFlankersCongruent(noCueResults)
  licResults <- getLocationIncongruent(fcResults)

  result <- getReactMean(licResults)
}

# RT_NC_FICLIC
getRT_NC_FICLIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  noCueResults <- getNC(correctResults)
  ficResults <- getFlankersIncongruent(noCueResults)
  licResults <- getLocationIncongruent(ficResults)

  result <- getReactMean(licResults)
}

# RT_DC_0_FC
getRT_DC_0_FC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleResults <- getDC(correctResults)
  cueToTarget0Results <- getCueToTarget0(doubleResults)
  fcResults <- getFlankersCongruent(cueToTarget0Results)

  result <- getReactMean(fcResults)
}

# RT_DC_0_FIC
getRT_DC_0_FIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleResults <- getDC(correctResults)
  cueToTarget0Results <- getCueToTarget0(doubleResults)
  ficResults <- getFlankersIncongruent(cueToTarget0Results)

  result <- getReactMean(ficResults)
}

# RT_DC_0_LC
getRT_DC_0_LC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleResults <- getDC(correctResults)
  cueToTarget0Results <- getCueToTarget0(doubleResults)
  lcResults <- getLocationCongruent(cueToTarget0Results)

  result <- getReactMean(lcResults)
}

# RT_DC_0_LIC
getRT_DC_0_LIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleResults <- getDC(correctResults)
  cueToTarget0Results <- getCueToTarget0(doubleResults)
  licResults <- getLocationIncongruent(cueToTarget0Results)

  result <- getReactMean(licResults)
}

# RT_DC_0_FCLC
getRT_DC_0_FCLC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleResults <- getDC(correctResults)
  cueToTarget0Results <- getCueToTarget0(doubleResults)
  fcResults <- getFlankersCongruent(cueToTarget0Results)
  lcResults <- getLocationCongruent(fcResults)

  result <- getReactMean(lcResults)
}

# RT_DC_0_FICLC
getRT_DC_0_FICLC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleResults <- getDC(correctResults)
  cueToTarget0Results <- getCueToTarget0(doubleResults)
  ficResults <- getFlankersIncongruent(cueToTarget0Results)
  lcResults <- getLocationCongruent(ficResults)

  result <- getReactMean(lcResults)
}

# RT_DC_0_FCLIC
getRT_DC_0_FCLIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleResults <- getDC(correctResults)
  cueToTarget0Results <- getCueToTarget0(doubleResults)
  fcResults <- getFlankersCongruent(cueToTarget0Results)
  licResults <- getLocationIncongruent(fcResults)

  result <- getReactMean(licResults)
}

# RT_DC_0_FICLIC
getRT_DC_0_FICLIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleResults <- getDC(correctResults)
  cueToTarget0Results <- getCueToTarget0(doubleResults)
  ficResults <- getFlankersIncongruent(cueToTarget0Results)
  licResults <- getLocationIncongruent(ficResults)

  result <- getReactMean(licResults)
}

# RT_DC_400_FC
getRT_DC_400_FC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleResults <- getDC(correctResults)
  cueToTarget400Results <- getCueToTarget400(doubleResults)
  fcResults <- getFlankersCongruent(cueToTarget400Results)

  result <- getReactMean(fcResults)
}

# RT_DC_400_FIC
getRT_DC_400_FIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleResults <- getDC(correctResults)
  cueToTarget400Results <- getCueToTarget400(doubleResults)
  ficResults <- getFlankersIncongruent(cueToTarget400Results)

  result <- getReactMean(ficResults)
}

# RT_DC_400_LC
getRT_DC_400_LC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleResults <- getDC(correctResults)
  cueToTarget400Results <- getCueToTarget400(doubleResults)
  lcResults <- getLocationCongruent(cueToTarget400Results)

  result <- getReactMean(lcResults)
}

# RT_DC_400_LIC
getRT_DC_400_LIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleResults <- getDC(correctResults)
  cueToTarget400Results <- getCueToTarget400(doubleResults)
  licResults <- getLocationIncongruent(cueToTarget400Results)

  result <- getReactMean(licResults)
}

# RT_DC_400_FCLC
getRT_DC_400_FCLC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleResults <- getDC(correctResults)
  cueToTarget400Results <- getCueToTarget400(doubleResults)
  fcResults <- getFlankersCongruent(cueToTarget400Results)
  lcResults <- getLocationCongruent(fcResults)

  result <- getReactMean(lcResults)
}

# RT_DC_400_FICLC
getRT_DC_400_FICLC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleResults <- getDC(correctResults)
  cueToTarget400Results <- getCueToTarget400(doubleResults)
  ficResults <- getFlankersIncongruent(cueToTarget400Results)
  lcResults <- getLocationCongruent(ficResults)

  result <- getReactMean(lcResults)
}

# RT_DC_400_FCLIC
getRT_DC_400_FCLIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleResults <- getDC(correctResults)
  cueToTarget400Results <- getCueToTarget400(doubleResults)
  fcResults <- getFlankersCongruent(cueToTarget400Results)
  licResults <- getLocationIncongruent(fcResults)

  result <- getReactMean(licResults)
}

# RT_DC_400_FICLIC
getRT_DC_400_FICLIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleResults <- getDC(correctResults)
  cueToTarget400Results <- getCueToTarget400(doubleResults)
  ficResults <- getFlankersIncongruent(cueToTarget400Results)
  licResults <- getLocationIncongruent(ficResults)

  result <- getReactMean(licResults)
}

# RT_DC_800_FC
getRT_DC_800_FC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleResults <- getDC(correctResults)
  cueToTarget800Results <- getCueToTarget800(doubleResults)
  fcResults <- getFlankersCongruent(cueToTarget800Results)

  result <- getReactMean(fcResults)
}

# RT_DC_800_FIC
getRT_DC_800_FIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleResults <- getDC(correctResults)
  cueToTarget800Results <- getCueToTarget800(doubleResults)
  ficResults <- getFlankersIncongruent(cueToTarget800Results)

  result <- getReactMean(ficResults)
}

# RT_DC_800_LC
getRT_DC_800_LC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleResults <- getDC(correctResults)
  cueToTarget800Results <- getCueToTarget800(doubleResults)
  lcResults <- getLocationCongruent(cueToTarget800Results)

  result <- getReactMean(lcResults)
}

# RT_DC_800_LIC
getRT_DC_800_LIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleResults <- getDC(correctResults)
  cueToTarget800Results <- getCueToTarget800(doubleResults)
  licResults <- getLocationIncongruent(cueToTarget800Results)

  result <- getReactMean(licResults)
}

# RT_DC_800_FCLC
getRT_DC_800_FCLC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleResults <- getDC(correctResults)
  cueToTarget800Results <- getCueToTarget800(doubleResults)
  fcResults <- getFlankersCongruent(cueToTarget800Results)
  lcResults <- getLocationCongruent(fcResults)

  result <- getReactMean(lcResults)
}

# RT_DC_800_FICLC
getRT_DC_800_FICLC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleResults <- getDC(correctResults)
  cueToTarget800Results <- getCueToTarget800(doubleResults)
  ficResults <- getFlankersIncongruent(cueToTarget800Results)
  lcResults <- getLocationCongruent(ficResults)

  result <- getReactMean(lcResults)
}

# RT_DC_800_FCLIC
getRT_DC_800_FCLIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleResults <- getDC(correctResults)
  cueToTarget800Results <- getCueToTarget800(doubleResults)
  fcResults <- getFlankersCongruent(cueToTarget800Results)
  licResults <- getLocationIncongruent(fcResults)

  result <- getReactMean(licResults)
}

# RT_DC_800_FICLIC
getRT_DC_800_FICLIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  doubleResults <- getDC(correctResults)
  cueToTarget800Results <- getCueToTarget800(doubleResults)
  ficResults <- getFlankersIncongruent(cueToTarget800Results)
  licResults <- getLocationIncongruent(ficResults)

  result <- getReactMean(licResults)
}

# RT_VC_0_FCLC
getRT_VC_0_FCLC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  validResults <- getVC(correctResults)
  cueToTarget0Results <- getCueToTarget0(validResults)
  fcResults <- getFlankersCongruent(cueToTarget0Results)
  lcResults <- getLocationCongruent(fcResults)

  result <- getReactMean(lcResults)
}

# RT_VC_0_FICLC
getRT_VC_0_FICLC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  validResults <- getVC(correctResults)
  cueToTarget0Results <- getCueToTarget0(validResults)
  ficResults <- getFlankersIncongruent(cueToTarget0Results)
  lcResults <- getLocationCongruent(ficResults)

  result <- getReactMean(lcResults)
}

# RT_VC_0_FCLIC
getRT_VC_0_FCLIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  validResults <- getVC(correctResults)
  cueToTarget0Results <- getCueToTarget0(validResults)
  fcResults <- getFlankersCongruent(cueToTarget0Results)
  licResults <- getLocationIncongruent(fcResults)

  result <- getReactMean(licResults)
}

# RT_VC_0_FICLIC
getRT_VC_0_FICLIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  validResults <- getVC(correctResults)
  cueToTarget0Results <- getCueToTarget0(validResults)
  ficResults <- getFlankersIncongruent(cueToTarget0Results)
  licResults <- getLocationIncongruent(ficResults)

  result <- getReactMean(licResults)
}

# RT_VC_400_FCLC
getRT_VC_400_FCLC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  validResults <- getVC(correctResults)
  cueToTarget400Results <- getCueToTarget400(validResults)
  fcResults <- getFlankersCongruent(cueToTarget400Results)
  lcResults <- getLocationCongruent(fcResults)

  result <- getReactMean(lcResults)
}

# RT_VC_400_FICLC
getRT_VC_400_FICLC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  validResults <- getVC(correctResults)
  cueToTarget400Results <- getCueToTarget400(validResults)
  ficResults <- getFlankersIncongruent(cueToTarget400Results)
  lcResults <- getLocationCongruent(ficResults)

  result <- getReactMean(lcResults)
}

# RT_VC_400_FCLIC
getRT_VC_400_FCLIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  validResults <- getVC(correctResults)
  cueToTarget400Results <- getCueToTarget400(validResults)
  fcResults <- getFlankersCongruent(cueToTarget400Results)
  licResults <- getLocationIncongruent(fcResults)

  result <- getReactMean(licResults)
}

# RT_VC_400_FICLIC
getRT_VC_400_FICLIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  validResults <- getVC(correctResults)
  cueToTarget400Results <- getCueToTarget400(validResults)
  ficResults <- getFlankersIncongruent(cueToTarget400Results)
  licResults <- getLocationIncongruent(ficResults)

  result <- getReactMean(licResults)
}

# RT_VC_800_FCLC
getRT_VC_800_FCLC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  validResults <- getVC(correctResults)
  cueToTarget800Results <- getCueToTarget800(validResults)
  fcResults <- getFlankersCongruent(cueToTarget800Results)
  lcResults <- getLocationCongruent(fcResults)

  result <- getReactMean(lcResults)
}

# RT_VC_800_FICLC
getRT_VC_800_FICLC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  validResults <- getVC(correctResults)
  cueToTarget800Results <- getCueToTarget800(validResults)
  ficResults <- getFlankersIncongruent(cueToTarget800Results)
  lcResults <- getLocationCongruent(ficResults)

  result <- getReactMean(lcResults)
}

# RT_VC_800_FCLIC
getRT_VC_800_FCLIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  validResults <- getVC(correctResults)
  cueToTarget800Results <- getCueToTarget800(validResults)
  fcResults <- getFlankersCongruent(cueToTarget800Results)
  licResults <- getLocationIncongruent(fcResults)

  result <- getReactMean(licResults)
}

# RT_VC_800_FICLIC
getRT_VC_800_FICLIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  validResults <- getVC(correctResults)
  cueToTarget800Results <- getCueToTarget800(validResults)
  ficResults <- getFlankersIncongruent(cueToTarget800Results)
  licResults <- getLocationIncongruent(ficResults)

  result <- getReactMean(licResults)
}

# RT_IVC_0_FCLC
getRT_IVC_0_FCLC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  invalidResults <- getIVC(correctResults)
  cueToTarget0Results <- getCueToTarget0(invalidResults)
  fcResults <- getFlankersCongruent(cueToTarget0Results)
  lcResults <- getLocationCongruent(fcResults)

  result <- getReactMean(lcResults)
}

# RT_IVC_0_FICLC
getRT_IVC_0_FICLC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  invalidResults <- getIVC(correctResults)
  cueToTarget0Results <- getCueToTarget0(invalidResults)
  ficResults <- getFlankersIncongruent(cueToTarget0Results)
  lcResults <- getLocationCongruent(ficResults)

  result <- getReactMean(lcResults)
}

# RT_IVC_0_FCLIC
getRT_IVC_0_FCLIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  invalidResults <- getIVC(correctResults)
  cueToTarget0Results <- getCueToTarget0(invalidResults)
  fcResults <- getFlankersCongruent(cueToTarget0Results)
  licResults <- getLocationIncongruent(fcResults)

  result <- getReactMean(licResults)
}

# RT_IVC_0_FICLIC
getRT_IVC_0_FICLIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  invalidResults <- getIVC(correctResults)
  cueToTarget0Results <- getCueToTarget0(invalidResults)
  ficResults <- getFlankersIncongruent(cueToTarget0Results)
  licResults <- getLocationIncongruent(ficResults)

  result <- getReactMean(licResults)
}

# RT_IVC_400_FCLC
getRT_IVC_400_FCLC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  invalidResults <- getIVC(correctResults)
  cueToTarget400Results <- getCueToTarget400(invalidResults)
  fcResults <- getFlankersCongruent(cueToTarget400Results)
  lcResults <- getLocationCongruent(fcResults)

  result <- getReactMean(lcResults)
}

# RT_IVC_400_FICLC
getRT_IVC_400_FICLC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  invalidResults <- getIVC(correctResults)
  cueToTarget400Results <- getCueToTarget400(invalidResults)
  ficResults <- getFlankersIncongruent(cueToTarget400Results)
  lcResults <- getLocationCongruent(ficResults)

  result <- getReactMean(lcResults)
}

# RT_IVC_400_FCLIC
getRT_IVC_400_FCLIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  invalidResults <- getIVC(correctResults)
  cueToTarget400Results <- getCueToTarget400(invalidResults)
  fcResults <- getFlankersCongruent(cueToTarget400Results)
  licResults <- getLocationIncongruent(fcResults)

  result <- getReactMean(licResults)
}

# RT_IVC_400_FICLIC
getRT_IVC_400_FICLIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  invalidResults <- getIVC(correctResults)
  cueToTarget400Results <- getCueToTarget400(invalidResults)
  ficResults <- getFlankersIncongruent(cueToTarget400Results)
  licResults <- getLocationIncongruent(ficResults)

  result <- getReactMean(licResults)
}

# RT_IVC_800_FCLC
getRT_IVC_800_FCLC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  invalidResults <- getIVC(correctResults)
  cueToTarget800Results <- getCueToTarget800(invalidResults)
  fcResults <- getFlankersCongruent(cueToTarget800Results)
  lcResults <- getLocationCongruent(fcResults)

  result <- getReactMean(lcResults)
}

# RT_IVC_800_FICLC
getRT_IVC_800_FICLC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  invalidResults <- getIVC(correctResults)
  cueToTarget800Results <- getCueToTarget800(invalidResults)
  ficResults <- getFlankersIncongruent(cueToTarget800Results)
  lcResults <- getLocationCongruent(ficResults)

  result <- getReactMean(lcResults)
}

# RT_IVC_800_FCLIC
getRT_IVC_800_FCLIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  invalidResults <- getIVC(correctResults)
  cueToTarget800Results <- getCueToTarget800(invalidResults)
  fcResults <- getFlankersCongruent(cueToTarget800Results)
  licResults <- getLocationIncongruent(fcResults)

  result <- getReactMean(licResults)
}

# RT_IVC_800_FICLIC
getRT_IVC_800_FICLIC <- function(participantResults) {
  correctResults <- getCorrectResult(participantResults)
  invalidResults <- getIVC(correctResults)
  cueToTarget800Results <- getCueToTarget800(invalidResults)
  ficResults <- getFlankersIncongruent(cueToTarget800Results)
  licResults <- getLocationIncongruent(ficResults)

  result <- getReactMean(licResults)
}

# ACC_NC_FC
getACC_NC_FC <- function(participantResults) {
  noCueResults <- getNC(participantResults)
  fcResults <- getFlankersCongruent(noCueResults)

  result <- getAcc(fcResults)
}

# ACC_NC_FIC
getACC_NC_FIC <- function(participantResults) {
  noCueResults <- getNC(participantResults)
  ficResults <- getFlankersIncongruent(noCueResults)

  result <- getAcc(ficResults)
}

# ACC_NC_FCLC
getACC_NC_FCLC <- function(participantResults) {
  noCueResults <- getNC(participantResults)
  fcResults <- getFlankersCongruent(noCueResults)
  lcResults <- getLocationCongruent(fcResults)

  result <- getAcc(lcResults)
}

# ACC_NC_FICLC
getACC_NC_FICLC <- function(participantResults) {
  noCueResults <- getNC(participantResults)
  ficResults <- getFlankersIncongruent(noCueResults)
  lcResults <- getLocationCongruent(ficResults)

  result <- getAcc(lcResults)
}

# ACC_NC_FCLIC
getACC_NC_FCLIC <- function(participantResults) {
  noCueResults <- getNC(participantResults)
  fcResults <- getFlankersCongruent(noCueResults)
  licResults <- getLocationIncongruent(fcResults)

  result <- getAcc(licResults)
}

# ACC_NC_FICLIC
getACC_NC_FICLIC <- function(participantResults) {
  noCueResults <- getNC(participantResults)
  ficResults <- getFlankersIncongruent(noCueResults)
  licResults <- getLocationIncongruent(ficResults)

  result <- getAcc(licResults)
}

# ACC_DC_0_FC
getACC_DC_0_FC <- function(participantResults) {
  doubleResults <- getDC(participantResults)
  cueToTarget0Results <- getCueToTarget0(doubleResults)
  fcResults <- getFlankersCongruent(cueToTarget0Results)

  result <- getAcc(fcResults)
}

# ACC_DC_0_FIC
getACC_DC_0_FIC <- function(participantResults) {
  doubleResults <- getDC(participantResults)
  cueToTarget0Results <- getCueToTarget0(doubleResults)
  ficResults <- getFlankersIncongruent(cueToTarget0Results)

  result <- getAcc(ficResults)
}

# ACC_DC_0_LC
getACC_DC_0_LC <- function(participantResults) {
  doubleResults <- getDC(participantResults)
  cueToTarget0Results <- getCueToTarget0(doubleResults)
  lcResults <- getLocationCongruent(cueToTarget0Results)

  result <- getAcc(lcResults)
}

# ACC_DC_0_LIC
getACC_DC_0_LIC <- function(participantResults) {
  doubleResults <- getDC(participantResults)
  cueToTarget0Results <- getCueToTarget0(doubleResults)
  licResults <- getLocationIncongruent(cueToTarget0Results)

  result <- getAcc(licResults)
}

# ACC_DC_0_FCLC
getACC_DC_0_FCLC <- function(participantResults) {
  doubleResults <- getDC(participantResults)
  cueToTarget0Results <- getCueToTarget0(doubleResults)
  fcResults <- getFlankersCongruent(cueToTarget0Results)
  lcResults <- getLocationCongruent(fcResults)

  result <- getAcc(lcResults)
}

# ACC_DC_0_FICLC
getACC_DC_0_FICLC <- function(participantResults) {
  doubleResults <- getDC(participantResults)
  cueToTarget0Results <- getCueToTarget0(doubleResults)
  ficResults <- getFlankersIncongruent(cueToTarget0Results)
  lcResults <- getLocationCongruent(ficResults)

  result <- getAcc(lcResults)
}

# ACC_DC_0_FCLIC
getACC_DC_0_FCLIC <- function(participantResults) {
  doubleResults <- getDC(participantResults)
  cueToTarget0Results <- getCueToTarget0(doubleResults)
  fcResults <- getFlankersCongruent(cueToTarget0Results)
  licResults <- getLocationIncongruent(fcResults)

  result <- getAcc(licResults)
}

# ACC_DC_0_FICLIC
getACC_DC_0_FICLIC <- function(participantResults) {
  doubleResults <- getDC(participantResults)
  cueToTarget0Results <- getCueToTarget0(doubleResults)
  ficResults <- getFlankersIncongruent(cueToTarget0Results)
  licResults <- getLocationIncongruent(ficResults)

  result <- getAcc(licResults)
}

# ACC_DC_400_FC
getACC_DC_400_FC <- function(participantResults) {
  doubleResults <- getDC(participantResults)
  cueToTarget400Results <- getCueToTarget400(doubleResults)
  fcResults <- getFlankersCongruent(cueToTarget400Results)

  result <- getAcc(fcResults)
}

# ACC_DC_400_FIC
getACC_DC_400_FIC <- function(participantResults) {
  doubleResults <- getDC(participantResults)
  cueToTarget400Results <- getCueToTarget400(doubleResults)
  ficResults <- getFlankersIncongruent(cueToTarget400Results)

  result <- getAcc(ficResults)
}

# ACC_DC_400_LC
getACC_DC_400_LC <- function(participantResults) {
  doubleResults <- getDC(participantResults)
  cueToTarget400Results <- getCueToTarget400(doubleResults)
  lcResults <- getLocationCongruent(cueToTarget400Results)

  result <- getAcc(lcResults)
}

# ACC_DC_400_LIC
getACC_DC_400_LIC <- function(participantResults) {
  doubleResults <- getDC(participantResults)
  cueToTarget400Results <- getCueToTarget400(doubleResults)
  licResults <- getLocationIncongruent(cueToTarget400Results)

  result <- getAcc(licResults)
}

# ACC_DC_400_FCLC
getACC_DC_400_FCLC <- function(participantResults) {
  doubleResults <- getDC(participantResults)
  cueToTarget400Results <- getCueToTarget400(doubleResults)
  fcResults <- getFlankersCongruent(cueToTarget400Results)
  lcResults <- getLocationCongruent(fcResults)

  result <- getAcc(lcResults)
}

# ACC_DC_400_FICLC
getACC_DC_400_FICLC <- function(participantResults) {
  doubleResults <- getDC(participantResults)
  cueToTarget400Results <- getCueToTarget400(doubleResults)
  ficResults <- getFlankersIncongruent(cueToTarget400Results)
  lcResults <- getLocationCongruent(ficResults)

  result <- getAcc(lcResults)
}

# ACC_DC_400_FCLIC
getACC_DC_400_FCLIC <- function(participantResults) {
  doubleResults <- getDC(participantResults)
  cueToTarget400Results <- getCueToTarget400(doubleResults)
  fcResults <- getFlankersCongruent(cueToTarget400Results)
  licResults <- getLocationIncongruent(fcResults)

  result <- getAcc(licResults)
}

# ACC_DC_400_FICLIC
getACC_DC_400_FICLIC <- function(participantResults) {
  doubleResults <- getDC(participantResults)
  cueToTarget400Results <- getCueToTarget400(doubleResults)
  ficResults <- getFlankersIncongruent(cueToTarget400Results)
  licResults <- getLocationIncongruent(ficResults)

  result <- getAcc(licResults)
}

# ACC_DC_800_FC
getACC_DC_800_FC <- function(participantResults) {
  doubleResults <- getDC(participantResults)
  cueToTarget800Results <- getCueToTarget800(doubleResults)
  fcResults <- getFlankersCongruent(cueToTarget800Results)

  result <- getAcc(fcResults)
}

# ACC_DC_800_FIC
getACC_DC_800_FIC <- function(participantResults) {
  doubleResults <- getDC(participantResults)
  cueToTarget800Results <- getCueToTarget800(doubleResults)
  ficResults <- getFlankersIncongruent(cueToTarget800Results)

  result <- getAcc(ficResults)
}

# ACC_DC_800_LC
getACC_DC_800_LC <- function(participantResults) {
  doubleResults <- getDC(participantResults)
  cueToTarget800Results <- getCueToTarget800(doubleResults)
  lcResults <- getLocationCongruent(cueToTarget800Results)

  result <- getAcc(lcResults)
}

# ACC_DC_800_LIC
getACC_DC_800_LIC <- function(participantResults) {
  doubleResults <- getDC(participantResults)
  cueToTarget800Results <- getCueToTarget800(doubleResults)
  licResults <- getLocationIncongruent(cueToTarget800Results)

  result <- getAcc(licResults)
}

# ACC_DC_800_FCLC
getACC_DC_800_FCLC <- function(participantResults) {
  doubleResults <- getDC(participantResults)
  cueToTarget800Results <- getCueToTarget800(doubleResults)
  fcResults <- getFlankersCongruent(cueToTarget800Results)
  lcResults <- getLocationCongruent(fcResults)

  result <- getAcc(lcResults)
}

# ACC_DC_800_FICLC
getACC_DC_800_FICLC <- function(participantResults) {
  doubleResults <- getDC(participantResults)
  cueToTarget800Results <- getCueToTarget800(doubleResults)
  ficResults <- getFlankersIncongruent(cueToTarget800Results)
  lcResults <- getLocationCongruent(ficResults)

  result <- getAcc(lcResults)
}

# ACC_DC_800_FCLIC
getACC_DC_800_FCLIC <- function(participantResults) {
  doubleResults <- getDC(participantResults)
  cueToTarget800Results <- getCueToTarget800(doubleResults)
  fcResults <- getFlankersCongruent(cueToTarget800Results)
  licResults <- getLocationIncongruent(fcResults)

  result <- getAcc(licResults)
}

# ACC_DC_800_FICLIC
getACC_DC_800_FICLIC <- function(participantResults) {
  doubleResults <- getDC(participantResults)
  cueToTarget800Results <- getCueToTarget800(doubleResults)
  ficResults <- getFlankersIncongruent(cueToTarget800Results)
  licResults <- getLocationIncongruent(ficResults)

  result <- getAcc(licResults)
}

# ACC_VC_0_FCLC
getACC_VC_0_FCLC <- function(participantResults) {
  validResults <- getVC(participantResults)
  cueToTarget0Results <- getCueToTarget0(validResults)
  fcResults <- getFlankersCongruent(cueToTarget0Results)
  lcResults <- getLocationCongruent(fcResults)

  result <- getAcc(lcResults)
}

# ACC_VC_0_FICLC
getACC_VC_0_FICLC <- function(participantResults) {
  validResults <- getVC(participantResults)
  cueToTarget0Results <- getCueToTarget0(validResults)
  ficResults <- getFlankersIncongruent(cueToTarget0Results)
  lcResults <- getLocationCongruent(ficResults)

  result <- getAcc(lcResults)
}

# ACC_VC_0_FCLIC
getACC_VC_0_FCLIC <- function(participantResults) {
  validResults <- getVC(participantResults)
  cueToTarget0Results <- getCueToTarget0(validResults)
  fcResults <- getFlankersCongruent(cueToTarget0Results)
  licResults <- getLocationIncongruent(fcResults)

  result <- getAcc(licResults)
}

# ACC_VC_0_FICLIC
getACC_VC_0_FICLIC <- function(participantResults) {
  validResults <- getVC(participantResults)
  cueToTarget0Results <- getCueToTarget0(validResults)
  ficResults <- getFlankersIncongruent(cueToTarget0Results)
  licResults <- getLocationIncongruent(ficResults)

  result <- getAcc(licResults)
}

# ACC_VC_400_FCLC
getACC_VC_400_FCLC <- function(participantResults) {
  validResults <- getVC(participantResults)
  cueToTarget400Results <- getCueToTarget400(validResults)
  fcResults <- getFlankersCongruent(cueToTarget400Results)
  lcResults <- getLocationCongruent(fcResults)

  result <- getAcc(lcResults)
}

# ACC_VC_400_FICLC
getACC_VC_400_FICLC <- function(participantResults) {
  validResults <- getVC(participantResults)
  cueToTarget400Results <- getCueToTarget400(validResults)
  ficResults <- getFlankersIncongruent(cueToTarget400Results)
  lcResults <- getLocationCongruent(ficResults)

  result <- getAcc(lcResults)
}

# ACC_VC_400_FCLIC
getACC_VC_400_FCLIC <- function(participantResults) {
  validResults <- getVC(participantResults)
  cueToTarget400Results <- getCueToTarget400(validResults)
  fcResults <- getFlankersCongruent(cueToTarget400Results)
  licResults <- getLocationIncongruent(fcResults)

  result <- getAcc(licResults)
}

# ACC_VC_400_FICLIC
getACC_VC_400_FICLIC <- function(participantResults) {
  validResults <- getVC(participantResults)
  cueToTarget400Results <- getCueToTarget400(validResults)
  ficResults <- getFlankersIncongruent(cueToTarget400Results)
  licResults <- getLocationIncongruent(ficResults)

  result <- getAcc(licResults)
}

# ACC_VC_800_FCLC
getACC_VC_800_FCLC <- function(participantResults) {
  validResults <- getVC(participantResults)
  cueToTarget800Results <- getCueToTarget800(validResults)
  fcResults <- getFlankersCongruent(cueToTarget800Results)
  lcResults <- getLocationCongruent(fcResults)

  result <- getAcc(lcResults)
}

# ACC_VC_800_FICLC
getACC_VC_800_FICLC <- function(participantResults) {
  validResults <- getVC(participantResults)
  cueToTarget800Results <- getCueToTarget800(validResults)
  ficResults <- getFlankersIncongruent(cueToTarget800Results)
  lcResults <- getLocationCongruent(ficResults)

  result <- getAcc(lcResults)
}

# ACC_VC_800_FCLIC
getACC_VC_800_FCLIC <- function(participantResults) {
  validResults <- getVC(participantResults)
  cueToTarget800Results <- getCueToTarget800(validResults)
  fcResults <- getFlankersCongruent(cueToTarget800Results)
  licResults <- getLocationIncongruent(fcResults)

  result <- getAcc(licResults)
}

# ACC_VC_800_FICLIC
getACC_VC_800_FICLIC <- function(participantResults) {
  validResults <- getVC(participantResults)
  cueToTarget800Results <- getCueToTarget800(validResults)
  ficResults <- getFlankersIncongruent(cueToTarget800Results)
  licResults <- getLocationIncongruent(ficResults)

  result <- getAcc(licResults)
}

# ACC_IVC_0_FCLC
getACC_IVC_0_FCLC <- function(participantResults) {
  invalidResults <- getIVC(participantResults)
  cueToTarget0Results <- getCueToTarget0(invalidResults)
  fcResults <- getFlankersCongruent(cueToTarget0Results)
  lcResults <- getLocationCongruent(fcResults)

  result <- getAcc(lcResults)
}

# ACC_IVC_0_FICLC
getACC_IVC_0_FICLC <- function(participantResults) {
  invalidResults <- getIVC(participantResults)
  cueToTarget0Results <- getCueToTarget0(invalidResults)
  ficResults <- getFlankersIncongruent(cueToTarget0Results)
  lcResults <- getLocationCongruent(ficResults)

  result <- getAcc(lcResults)
}

# ACC_IVC_0_FCLIC
getACC_IVC_0_FCLIC <- function(participantResults) {
  invalidResults <- getIVC(participantResults)
  cueToTarget0Results <- getCueToTarget0(invalidResults)
  fcResults <- getFlankersCongruent(cueToTarget0Results)
  licResults <- getLocationIncongruent(fcResults)

  result <- getAcc(licResults)
}

# ACC_IVC_0_FICLIC
getACC_IVC_0_FICLIC <- function(participantResults) {
  invalidResults <- getIVC(participantResults)
  cueToTarget0Results <- getCueToTarget0(invalidResults)
  ficResults <- getFlankersIncongruent(cueToTarget0Results)
  licResults <- getLocationIncongruent(ficResults)

  result <- getAcc(licResults)
}

# ACC_IVC_400_FCLC
getACC_IVC_400_FCLC <- function(participantResults) {
  invalidResults <- getIVC(participantResults)
  cueToTarget400Results <- getCueToTarget400(invalidResults)
  fcResults <- getFlankersCongruent(cueToTarget400Results)
  lcResults <- getLocationCongruent(fcResults)

  result <- getAcc(lcResults)
}

# ACC_IVC_400_FICLC
getACC_IVC_400_FICLC <- function(participantResults) {
  invalidResults <- getIVC(participantResults)
  cueToTarget400Results <- getCueToTarget400(invalidResults)
  ficResults <- getFlankersIncongruent(cueToTarget400Results)
  lcResults <- getLocationCongruent(ficResults)

  result <- getAcc(lcResults)
}

# ACC_IVC_400_FCLIC
getACC_IVC_400_FCLIC <- function(participantResults) {
  invalidResults <- getIVC(participantResults)
  cueToTarget400Results <- getCueToTarget400(invalidResults)
  fcResults <- getFlankersCongruent(cueToTarget400Results)
  licResults <- getLocationIncongruent(fcResults)

  result <- getAcc(licResults)
}

# ACC_IVC_400_FICLIC
getACC_IVC_400_FICLIC <- function(participantResults) {
  invalidResults <- getIVC(participantResults)
  cueToTarget400Results <- getCueToTarget400(invalidResults)
  ficResults <- getFlankersIncongruent(cueToTarget400Results)
  licResults <- getLocationIncongruent(ficResults)

  result <- getAcc(licResults)
}

# ACC_IVC_800_FCLC
getACC_IVC_800_FCLC <- function(participantResults) {
  invalidResults <- getIVC(participantResults)
  cueToTarget800Results <- getCueToTarget800(invalidResults)
  fcResults <- getFlankersCongruent(cueToTarget800Results)
  lcResults <- getLocationCongruent(fcResults)

  result <- getAcc(lcResults)
}

# ACC_IVC_800_FICLC
getACC_IVC_800_FICLC <- function(participantResults) {
  invalidResults <- getIVC(participantResults)
  cueToTarget800Results <- getCueToTarget800(invalidResults)
  ficResults <- getFlankersIncongruent(cueToTarget800Results)
  lcResults <- getLocationCongruent(ficResults)

  result <- getAcc(lcResults)
}

# ACC_IVC_800_FCLIC
getACC_IVC_800_FCLIC <- function(participantResults) {
  invalidResults <- getIVC(participantResults)
  cueToTarget800Results <- getCueToTarget800(invalidResults)
  fcResults <- getFlankersCongruent(cueToTarget800Results)
  licResults <- getLocationIncongruent(fcResults)

  result <- getAcc(licResults)
}

# ACC_IVC_800_FICLIC
getACC_IVC_800_FICLIC <- function(participantResults) {
  invalidResults <- getIVC(participantResults)
  cueToTarget800Results <- getCueToTarget800(invalidResults)
  ficResults <- getFlankersIncongruent(cueToTarget800Results)
  licResults <- getLocationIncongruent(ficResults)

  result <- getAcc(licResults)
}

# ACC_NC
getACC_NC <- function(participantResults) {
  noCueResults <- getNC(participantResults)
  result <- getAcc(noCueResults)
}

# ACC_DC
getACC_DC <- function(participantResults) {
  doubleCueResults <- getDC(participantResults)
  result <- getAcc(doubleCueResults)
}

# ACC_DC_FC
getACC_DC_FC <- function(participantResults) {
  doubleCueResults <- getDC(participantResults)
  fcResults <- getFlankersCongruent(doubleCueResults)

  result <- getAcc(fcResults)
}

# ACC_DC_FIC
getACC_DC_FIC <- function(participantResults) {
  doubleCueResults <- getDC(participantResults)
  ficResults <- getFlankersIncongruent(doubleCueResults)

  result <- getAcc(ficResults)
}

# ACC_VC
getACC_VC <- function(participantResults) {
  validCueResults <- getVC(participantResults)
  result <- getAcc(validCueResults)
}

# ACC_IVC
getACC_IVC <- function(participantResults) {
  invalidCueResults <- getIVC(participantResults)
  result <- getAcc(invalidCueResults)
}

# ACC_VC_0
getACC_VC_0 <- function(participantResults) {
  validCueResults <- getVC(participantResults)
  cueToTarget0Results <- getCueToTarget0(validCueResults)
  result <- getAcc(cueToTarget0Results)
}

# ACC_VC_400
getACC_VC_400 <- function(participantResults) {
  validCueResults <- getVC(participantResults)
  cueToTarget400Results <- getCueToTarget400(validCueResults)
  result <- getAcc(cueToTarget400Results)
}

# ACC_VC_800
getACC_VC_800 <- function(participantResults) {
  validCueResults <- getVC(participantResults)
  cueToTarget800Results <- getCueToTarget800(validCueResults)
  result <- getAcc(cueToTarget800Results)
}

# ACC_IVC_0
getACC_IVC_0 <- function(participantResults) {
  invalidCueResults <- getIVC(participantResults)
  cueToTarget0Results <- getCueToTarget0(invalidCueResults)
  result <- getAcc(cueToTarget0Results)
}

# ACC_IVC_400
getACC_IVC_400 <- function(participantResults) {
  invalidCueResults <- getIVC(participantResults)
  cueToTarget400Results <- getCueToTarget400(invalidCueResults)
  result <- getAcc(cueToTarget400Results)
}

# ACC_IVC_800
getACC_IVC_800 <- function(participantResults) {
  invalidCueResults <- getIVC(participantResults)
  cueToTarget800Results <- getCueToTarget800(invalidCueResults)
  result <- getAcc(cueToTarget800Results)
}

# ACC_FC
getACC_FC <- function(participantResults) {
  fcResults <- getFlankersCongruent(participantResults)
  result <- getAcc(fcResults)
}

# ACC_FC_0
getACC_FC_0 <- function(participantResults) {
  fcResults <- getFlankersCongruent(participantResults)
  cueToTarget0Results <- getCueToTarget0(fcResults)
  result <- getAcc(cueToTarget0Results)
}

# ACC_FC_400
getACC_FC_400 <- function(participantResults) {
  fcResults <- getFlankersCongruent(participantResults)
  cueToTarget400Results <- getCueToTarget400(fcResults)
  result <- getAcc(cueToTarget400Results)
}

# ACC_FC_800
getACC_FC_800 <- function(participantResults) {
  fcResults <- getFlankersCongruent(participantResults)
  cueToTarget800Results <- getCueToTarget800(fcResults)
  result <- getAcc(cueToTarget800Results)
}

# ACC_FIC
getACC_FIC <- function(participantResults) {
  ficResults <- getFlankersIncongruent(participantResults)
  result <- getAcc(ficResults)
}

# ACC_FIC_0
getACC_FIC_0 <- function(participantResults) {
  ficResults <- getFlankersIncongruent(participantResults)
  cueToTarget0Results <- getCueToTarget0(ficResults)
  result <- getAcc(cueToTarget0Results)
}

# ACC_FIC_400
getACC_FIC_400 <- function(participantResults) {
  ficResults <- getFlankersIncongruent(participantResults)
  cueToTarget400Results <- getCueToTarget400(ficResults)
  result <- getAcc(cueToTarget400Results)
}

# ACC_FIC_800
getACC_FIC_800 <- function(participantResults) {
  ficResults <- getFlankersIncongruent(participantResults)
  cueToTarget800Results <- getCueToTarget800(ficResults)
  result <- getAcc(cueToTarget800Results)
}

# ACC_LC
getACC_LC <- function(participantResults) {
  lcResults <- getLocationCongruent(participantResults)
  result <- getAcc(lcResults)
}

# ACC_LC_0
getACC_LC_0 <- function(participantResults) {
  lcResults <- getLocationCongruent(participantResults)
  cueToTarget0Results <- getCueToTarget0(lcResults)
  result <- getAcc(cueToTarget0Results)
}

# ACC_LC_400
getACC_LC_400 <- function(participantResults) {
  lcResults <- getLocationCongruent(participantResults)
  cueToTarget400Results <- getCueToTarget400(lcResults)
  result <- getAcc(cueToTarget400Results)
}

# ACC_LC_800
getACC_LC_800 <- function(participantResults) {
  lcResults <- getLocationCongruent(participantResults)
  cueToTarget800Results <- getCueToTarget800(lcResults)
  result <- getAcc(cueToTarget800Results)
}

# ACC_LIC
getACC_LIC <- function(participantResults) {
  licResults <- getLocationIncongruent(participantResults)
  result <- getAcc(licResults)
}

# ACC_LIC_0
getACC_LIC_0 <- function(participantResults) {
  licResults <- getLocationIncongruent(participantResults)
  cueToTarget0Results <- getCueToTarget0(licResults)
  result <- getAcc(cueToTarget0Results)
}

# ACC_LIC_400
getACC_LIC_400 <- function(participantResults) {
  licResults <- getLocationIncongruent(participantResults)
  cueToTarget400Results <- getCueToTarget400(licResults)
  result <- getAcc(cueToTarget400Results)
}

# ACC_LIC_800
getACC_LIC_800 <- function(participantResults) {
  licResults <- getLocationIncongruent(participantResults)
  cueToTarget800Results <- getCueToTarget800(licResults)
  result <- getAcc(cueToTarget800Results)
}

# ACC_FC_LC
getACC_FC_LC <- function(participantResults) {
  fcResults <- getFlankersCongruent(participantResults)
  lcResults <- getLocationCongruent(fcResults)

  result <- getAcc(lcResults)
}

# ACC_FC_LIC
getACC_FC_LIC <- function(participantResults) {
  fcResults <- getFlankersCongruent(participantResults)
  licResults <- getLocationIncongruent(fcResults)

  result <- getAcc(licResults)
}

# ACC_FIC_LC
getACC_FIC_LC <- function(participantResults) {
  ficResults <- getFlankersIncongruent(participantResults)
  lcResults <- getLocationCongruent(ficResults)

  result <- getAcc(lcResults)
}

# ACC_FIC_LIC
getACC_FIC_LIC <- function(participantResults) {
  ficResults <- getFlankersIncongruent(participantResults)
  licResults <- getLocationIncongruent(ficResults)

  result <- getAcc(licResults)
}

# ACC_VC_FC
getACC_VC_FC <- function(participantResults) {
  validCueResults <- getVC(participantResults)
  fcResults <- getFlankersCongruent(validCueResults)
  result <- getAcc(fcResults)
}

# ACC_VC_FIC
getACC_VC_FIC <- function(participantResults) {
  validCueResults <- getVC(participantResults)
  ficResults <- getFlankersIncongruent(validCueResults)
  result <- getAcc(ficResults)
}

# ACC_IVC_FC
getACC_IVC_FC <- function(participantResults) {
  invalidCueResults <- getIVC(participantResults)
  fcResults <- getFlankersCongruent(invalidCueResults)
  result <- getAcc(fcResults)
}

# ACC_IVC_FIC
getACC_IVC_FIC <- function(participantResults) {
  invalidCueResults <- getIVC(participantResults)
  ficResults <- getFlankersIncongruent(invalidCueResults)
  result <- getAcc(ficResults)
}

# ACC_NC_LC
getACC_NC_LC <- function(participantResults) {
  noCueResults <- getNC(participantResults)
  lcResults <- getLocationCongruent(noCueResults)
  result <- getAcc(lcResults)
}

# ACC_NC_LIC
getACC_NC_LIC <- function(participantResults) {
  noCueResults <- getNC(participantResults)
  licResults <- getLocationIncongruent(noCueResults)
  result <- getAcc(licResults)
}

# ACC_DC_LC
getACC_DC_LC <- function(participantResults) {
  doubleCueResults <- getDC(participantResults)
  lcResults <- getLocationCongruent(doubleCueResults)
  result <- getAcc(lcResults)
}

# ACC_DC_LIC
getACC_DC_LIC <- function(participantResults) {
  doubleCueResults <- getDC(participantResults)
  licResults <- getLocationIncongruent(doubleCueResults)
  result <- getAcc(licResults)
}

# ACC_VC_LC
getACC_VC_LC <- function(participantResults) {
  validCueResults <- getVC(participantResults)
  lcResults <- getLocationCongruent(validCueResults)
  result <- getAcc(lcResults)
}

# ACC_VC_LIC
getACC_VC_LIC <- function(participantResults) {
  validCueResults <- getVC(participantResults)
  licResults <- getLocationIncongruent(validCueResults)
  result <- getAcc(licResults)
}

# ACC_IVC_LC
getACC_IVC_LC <- function(participantResults) {
  invalidCueResults <- getIVC(participantResults)
  lcResults <- getLocationCongruent(invalidCueResults)
  result <- getAcc(lcResults)
}

# ACC_IVC_LIC
getACC_IVC_LIC <- function(participantResults) {
  invalidCueResults <- getIVC(participantResults)
  licResults <- getLocationIncongruent(invalidCueResults)
  result <- getAcc(licResults)
}

# ACC_DC_0
getACC_DC_0 <- function(participantResults) {
  doubleCueResults <- getDC(participantResults)
  cueToTarget0Results <- getCueToTarget0(doubleCueResults)
  result <- getAcc(cueToTarget0Results)
}

# ACC_DC_400
getACC_DC_400 <- function(participantResults) {
  doubleCueResults <- getDC(participantResults)
  cueToTarget400Results <- getCueToTarget400(doubleCueResults)
  result <- getAcc(cueToTarget400Results)
}

# ACC_DC_800
getACC_DC_800 <- function(participantResults) {
  doubleCueResults <- getDC(participantResults)
  cueToTarget800Results <- getCueToTarget800(doubleCueResults)
  result <- getAcc(cueToTarget800Results)
}

# ACC_Alerting
getACC_Alerting <- function(participantResults) {
  result <- (getACC_NC(participantResults) - getACC_DC(participantResults))
}

# ACC_Validity
getACC_Validity <- function(participantResults) {
  result <- (getACC_IVC(participantResults) - getACC_VC(participantResults))
}

# ACC_Disengaging
getACC_Disengaging <- function(participantResults) {
  result <- (getACC_IVC(participantResults) - getACC_DC(participantResults))
}

# ACC_Moving_Engaging
getACC_Moving_Engaging <- function(participantResults) {
  result <- (getACC_DC(participantResults) - getACC_VC(participantResults))
}

# ACC_OrientingTime
getACC_OrientingTime <- function(participantResults) {
  result <- (getACC_VC_0(participantResults) - getACC_VC_800(participantResults))
}

# ACC_FlankerConflict
getACC_FlankerConflict <- function(participantResults) {
  result <- (getACC_FIC(participantResults) - getACC_FC(participantResults))
}

# ACC_LocationConflict
getACC_LocationConflict <- function(participantResults) {
  result <- (getACC_LIC(participantResults) - getACC_LC(participantResults))
}

# ACC_FlankerByLocation
getACC_FlankerByLocation <- function(participantResults) {
  fcResults <- getFlankersCongruent(participantResults)
  ficResults <- getFlankersIncongruent(participantResults)
  lcfcResults <- getAcc(getLocationCongruent(fcResults))
  lcficResults <- getAcc(getLocationCongruent(ficResults))
  licfcResults <- getAcc(getLocationIncongruent(fcResults))
  licficResults <- getAcc(getLocationIncongruent(ficResults))

  result <- (lcfcResults + licficResults - licfcResults - lcficResults)
}

# ACC_AlertingByFlanker
getACC_AlertingByFlanker <- function(participantResults) {
  noCueResults <- getNC(participantResults)
  doubleCueResults <- getDC(participantResults)
  ncfcResults <- getAcc(getFlankersCongruent(noCueResults))
  ncficResults <- getAcc(getFlankersIncongruent(noCueResults))
  dcfcResults <- getAcc(getFlankersCongruent(doubleCueResults))
  dcficResults <- getAcc(getFlankersIncongruent(doubleCueResults))

  result <- (ncficResults + dcfcResults - ncfcResults - dcficResults)
}

# ACC_OrientingByFlanker
getACC_OrientingByFlanker <- function(participantResults) {
  validCueResults <- getVC(participantResults)
  doubleCueResults <- getDC(participantResults)
  vcfcResults <- getAcc(getFlankersCongruent(validCueResults))
  vcficResults <- getAcc(getFlankersIncongruent(validCueResults))
  dcfcResults <- getAcc(getFlankersCongruent(doubleCueResults))
  dcficResults <- getAcc(getFlankersIncongruent(doubleCueResults))

  result <- (dcficResults + vcfcResults - dcfcResults - vcficResults)
}

# ACC_ValidityByFlanker
getACC_ValidityByFlanker <- function(participantResults) {
  validCueResults <- getVC(participantResults)
  invalidCueResults <- getIVC(participantResults)
  vcfcResults <- getAcc(getFlankersCongruent(validCueResults))
  vcficResults <- getAcc(getFlankersIncongruent(validCueResults))
  icfcResults <- getAcc(getFlankersCongruent(invalidCueResults))
  icficResults <- getAcc(getFlankersIncongruent(invalidCueResults))

  result <- (icficResults + vcfcResults - icfcResults - vcficResults)
}

# ACC_AlertingByLocation
getACC_AlertingByLocation <- function(participantResults) {
  noCueResults <- getNC(participantResults)
  doubleCueResults <- getDC(participantResults)
  nclcResults <- getAcc(getLocationCongruent(noCueResults))
  nclicResults <- getAcc(getLocationIncongruent(noCueResults))
  dclcResults <- getAcc(getLocationCongruent(doubleCueResults))
  dclicResults <- getAcc(getLocationIncongruent(doubleCueResults))

  result <- (nclicResults + dclcResults - nclcResults - dclicResults)
}

# ACC_OrientingByLocation
getACC_OrientingByLocation <- function(participantResults) {
  validCueResults <- getVC(participantResults)
  doubleCueResults <- getDC(participantResults)
  vclcResults <- getAcc(getLocationCongruent(validCueResults))
  vclicResults <- getAcc(getLocationIncongruent(validCueResults))
  dclcResults <- getAcc(getLocationCongruent(doubleCueResults))
  dclicResults <- getAcc(getLocationIncongruent(doubleCueResults))

  result <- (dclicResults + vclcResults - dclcResults - vclicResults)
}

# ACC_ValidityByLocation
getACC_ValidityByLocation <- function(participantResults) {
  validCueResults <- getVC(participantResults)
  invalidCueResults <- getIVC(participantResults)
  vclcResults <- getAcc(getLocationCongruent(validCueResults))
  vclicResults <- getAcc(getLocationIncongruent(validCueResults))
  iclcResults <- getAcc(getLocationCongruent(invalidCueResults))
  iclicResults <- getAcc(getLocationIncongruent(invalidCueResults))

  result <- (iclicResults + vclcResults - iclcResults - vclicResults)
}

# ACC_IOR
getACC_IOR <- function(participantResults) {
  validCueResults <- getVC(participantResults)
  invalidCueResults <- getIVC(participantResults)
  vcct0Results <- getAcc(getCueToTarget0(validCueResults))
  vcct400Results <- getAcc(getCueToTarget400(validCueResults))
  icct0Results <- getAcc(getCueToTarget0(invalidCueResults))
  icct400Results <- getAcc(getCueToTarget400(invalidCueResults))

  result <- (icct0Results + vcct400Results - vcct0Results - icct400Results)
}

getParticipantResultsVector <- function(pDemographicsAndQoE,
                                        pANT_R_Results,
                                        pANT_VR_Results,
                                        pANT_VR_B_Results) {
  Id <- pDemographicsAndQoE$Id
  Age <- pDemographicsAndQoE$Age
  Gender <- pDemographicsAndQoE$Gender
  GenderNumeric <- getGenderNumeric(pDemographicsAndQoE$Gender)
  Education <- pDemographicsAndQoE$Education
  EducationNumeric <- getEducationNumeric(pDemographicsAndQoE$Education)
  Nationality <- pDemographicsAndQoE$Nationality
  NationalityNumeric <- getNationalityNumeric(pDemographicsAndQoE$Nationality)
  Handedness <- pDemographicsAndQoE$Handedness
  HandednessNumeric <- getHandednessNumeric(pDemographicsAndQoE$Handedness)
  TimeOfDay <- pDemographicsAndQoE$TimeOfDay
  TimeOfDayNumeric <- getTimeOfDayNumeric(pDemographicsAndQoE$TimeOfDay)
  QoE_PQ <- pDemographicsAndQoE$QoE_PQ
  QoE_RQ <- pDemographicsAndQoE$QoE_RQ
  QoE_TQ <- pDemographicsAndQoE$QoE_TQ
  QoE_CQ <- pDemographicsAndQoE$QoE_CQ
  QoE_IQ <- pDemographicsAndQoE$QoE_IQ
  QoE_OQ <- pDemographicsAndQoE$QoE_OQ
  QoE_Sum <- pDemographicsAndQoE$QoE_Sum
  R_RT <- getRT(pANT_R_Results)
  R_RT_NC <- getRT_NC(pANT_R_Results)
  R_RT_DC <- getRT_DC(pANT_R_Results)
  R_RT_VC <- getRT_VC(pANT_R_Results)
  R_RT_IVC <- getRT_IVC(pANT_R_Results)
  R_RT_VC_0 <- getRT_VC_0(pANT_R_Results)
  R_RT_VC_400 <- getRT_VC_400(pANT_R_Results)
  R_RT_VC_800 <- getRT_VC_800(pANT_R_Results)
  R_RT_IVC_0 <- getRT_IVC_0(pANT_R_Results)
  R_RT_IVC_400 <- getRT_IVC_400(pANT_R_Results)
  R_RT_IVC_800 <- getRT_IVC_800(pANT_R_Results)
  R_RT_FC <- getRT_FC(pANT_R_Results)
  R_RT_FC_0 <- getRT_FC_0(pANT_R_Results)
  R_RT_FC_400 <- getRT_FC_400(pANT_R_Results)
  R_RT_FC_800 <- getRT_FC_800(pANT_R_Results)
  R_RT_FIC <- getRT_FIC(pANT_R_Results)
  R_RT_FIC_0 <- getRT_FIC_0(pANT_R_Results)
  R_RT_FIC_400 <- getRT_FIC_400(pANT_R_Results)
  R_RT_FIC_800 <- getRT_FIC_800(pANT_R_Results)
  R_RT_LC <- getRT_LC(pANT_R_Results)
  R_RT_LC_0 <- getRT_LC_0(pANT_R_Results)
  R_RT_LC_400 <- getRT_LC_400(pANT_R_Results)
  R_RT_LC_800 <- getRT_LC_800(pANT_R_Results)
  R_RT_LIC <- getRT_LIC(pANT_R_Results)
  R_RT_LIC_0 <- getRT_LIC_0(pANT_R_Results)
  R_RT_LIC_400 <- getRT_LIC_400(pANT_R_Results)
  R_RT_LIC_800 <- getRT_LIC_800(pANT_R_Results)
  R_RT_FC_LC <- getRT_FC_LC(pANT_R_Results)
  R_RT_FC_LIC <- getRT_FC_LIC(pANT_R_Results)
  R_RT_FIC_LC <- getRT_FIC_LC(pANT_R_Results)
  R_RT_FIC_LIC <- getRT_FIC_LIC(pANT_R_Results)
  R_RT_DC_FC <- getRT_DC_FC(pANT_R_Results)
  R_RT_DC_FIC <- getRT_DC_FIC(pANT_R_Results)
  R_RT_VC_FC <- getRT_VC_FC(pANT_R_Results)
  R_RT_VC_FIC <- getRT_VC_FIC(pANT_R_Results)
  R_RT_IVC_FC <- getRT_IVC_FC(pANT_R_Results)
  R_RT_IVC_FIC <- getRT_IVC_FIC(pANT_R_Results)
  R_RT_NC_FC <- getRT_NC_FC(pANT_R_Results)
  R_RT_NC_FIC <- getRT_NC_FIC(pANT_R_Results)
  R_RT_NC_LC <- getRT_NC_LC(pANT_R_Results)
  R_RT_NC_LIC <- getRT_NC_LIC(pANT_R_Results)
  R_RT_DC_LC <- getRT_DC_LC(pANT_R_Results)
  R_RT_DC_LIC <- getRT_DC_LIC(pANT_R_Results)
  R_RT_VC_LC <- getRT_VC_LC(pANT_R_Results)
  R_RT_VC_LIC <- getRT_VC_LIC(pANT_R_Results)
  R_RT_IVC_LC <- getRT_IVC_LC(pANT_R_Results)
  R_RT_IVC_LIC <- getRT_IVC_LIC(pANT_R_Results)
  R_RT_DC_0 <- getRT_DC_0(pANT_R_Results)
  R_RT_DC_0_FC <- getRT_DC_0_FC(pANT_R_Results)
  R_RT_DC_0_FIC <- getRT_DC_0_FIC(pANT_R_Results)
  R_RT_DC_0_LC <- getRT_DC_0_LC(pANT_R_Results)
  R_RT_DC_0_LIC <- getRT_DC_0_LIC(pANT_R_Results)
  R_RT_DC_400 <- getRT_DC_400(pANT_R_Results)
  R_RT_DC_400_FC <- getRT_DC_400_FC(pANT_R_Results)
  R_RT_DC_400_FIC <- getRT_DC_400_FIC(pANT_R_Results)
  R_RT_DC_400_LC <- getRT_DC_400_LC(pANT_R_Results)
  R_RT_DC_400_LIC <- getRT_DC_400_LIC(pANT_R_Results)
  R_RT_DC_800 <- getRT_DC_800(pANT_R_Results)
  R_RT_DC_800_FC <- getRT_DC_800_FC(pANT_R_Results)
  R_RT_DC_800_FIC <- getRT_DC_800_FIC(pANT_R_Results)
  R_RT_DC_800_LC <- getRT_DC_800_LC(pANT_R_Results)
  R_RT_DC_800_LIC <- getRT_DC_800_LIC(pANT_R_Results)
  R_RT_Alerting <- getRT_Alerting(pANT_R_Results)
  R_RT_Validity <- getRT_Validity(pANT_R_Results)
  R_RT_Disengaging <- getRT_Disengaging(pANT_R_Results)
  R_RT_Moving_Engaging <- getRT_Moving_Engaging(pANT_R_Results)
  R_RT_OrientingTime <- getRT_OrientingTime(pANT_R_Results)
  R_RT_FlankerConflict <- getRT_FlankerConflict(pANT_R_Results)
  R_RT_LocationConflict <- getRT_LocationConflict(pANT_R_Results)
  R_RT_FlankerByLocation <- getRT_FlankerByLocation(pANT_R_Results)
  R_RT_AlertingByFlanker <- getRT_AlertingByFlanker(pANT_R_Results)
  R_RT_OrientingByFlanker <- getRT_OrientingByFlanker(pANT_R_Results)
  R_RT_ValidityByFlanker <- getRT_ValidityByFlanker(pANT_R_Results)
  R_RT_AlertingByLocation <- getRT_AlertingByLocation(pANT_R_Results)
  R_RT_OrientingByLocation <- getRT_OrientingByLocation(pANT_R_Results)
  R_RT_ValidityByLocation <- getRT_ValidityByLocation(pANT_R_Results)
  R_RT_IOR <- getRT_IOR(pANT_R_Results)
  R_RT_NC_FCLC <- getRT_NC_FCLC(pANT_R_Results)
  R_RT_NC_FICLC <- getRT_NC_FICLC(pANT_R_Results)
  R_RT_NC_FCLIC <- getRT_NC_FCLIC(pANT_R_Results)
  R_RT_NC_FICLIC <- getRT_NC_FICLIC(pANT_R_Results)
  R_RT_DC_0_FCLC <- getRT_DC_0_FCLC(pANT_R_Results)
  R_RT_DC_0_FICLC <- getRT_DC_0_FICLC(pANT_R_Results)
  R_RT_DC_0_FCLIC <- getRT_DC_0_FCLIC(pANT_R_Results)
  R_RT_DC_0_FICLIC <- getRT_DC_0_FICLIC(pANT_R_Results)
  R_RT_DC_400_FCLC <- getRT_DC_400_FCLC(pANT_R_Results)
  R_RT_DC_400_FICLC <- getRT_DC_400_FICLC(pANT_R_Results)
  R_RT_DC_400_FCLIC <- getRT_DC_400_FCLIC(pANT_R_Results)
  R_RT_DC_400_FICLIC <- getRT_DC_400_FICLIC(pANT_R_Results)
  R_RT_DC_800_FCLC <- getRT_DC_800_FCLC(pANT_R_Results)
  R_RT_DC_800_FICLC <- getRT_DC_800_FICLC(pANT_R_Results)
  R_RT_DC_800_FCLIC <- getRT_DC_800_FCLIC(pANT_R_Results)
  R_RT_DC_800_FICLIC <- getRT_DC_800_FICLIC(pANT_R_Results)
  R_RT_VC_0_FCLC <- getRT_VC_0_FCLC(pANT_R_Results)
  R_RT_VC_0_FICLC <- getRT_VC_0_FICLC(pANT_R_Results)
  R_RT_VC_0_FCLIC <- getRT_VC_0_FCLIC(pANT_R_Results)
  R_RT_VC_0_FICLIC <- getRT_VC_0_FICLIC(pANT_R_Results)
  R_RT_VC_400_FCLC <- getRT_VC_400_FCLC(pANT_R_Results)
  R_RT_VC_400_FICLC <- getRT_VC_400_FICLC(pANT_R_Results)
  R_RT_VC_400_FCLIC <- getRT_VC_400_FCLIC(pANT_R_Results)
  R_RT_VC_400_FICLIC <- getRT_VC_400_FICLIC(pANT_R_Results)
  R_RT_VC_800_FCLC <- getRT_VC_800_FCLC(pANT_R_Results)
  R_RT_VC_800_FICLC <- getRT_VC_800_FICLC(pANT_R_Results)
  R_RT_VC_800_FCLIC <- getRT_VC_800_FCLIC(pANT_R_Results)
  R_RT_VC_800_FICLIC <- getRT_VC_800_FICLIC(pANT_R_Results)
  R_RT_IVC_0_FCLC <- getRT_IVC_0_FCLC(pANT_R_Results)
  R_RT_IVC_0_FICLC <- getRT_IVC_0_FICLC(pANT_R_Results)
  R_RT_IVC_0_FCLIC <- getRT_IVC_0_FCLIC(pANT_R_Results)
  R_RT_IVC_0_FICLIC <- getRT_IVC_0_FICLIC(pANT_R_Results)
  R_RT_IVC_400_FCLC <- getRT_IVC_400_FCLC(pANT_R_Results)
  R_RT_IVC_400_FICLC <- getRT_IVC_400_FICLC(pANT_R_Results)
  R_RT_IVC_400_FCLIC <- getRT_IVC_400_FCLIC(pANT_R_Results)
  R_RT_IVC_400_FICLIC <- getRT_IVC_400_FICLIC(pANT_R_Results)
  R_RT_IVC_800_FCLC <- getRT_IVC_800_FCLC(pANT_R_Results)
  R_RT_IVC_800_FICLC <- getRT_IVC_800_FICLC(pANT_R_Results)
  R_RT_IVC_800_FCLIC <- getRT_IVC_800_FCLIC(pANT_R_Results)
  R_RT_IVC_800_FICLIC <- getRT_IVC_800_FICLIC(pANT_R_Results)
  R_ACC <- getAcc(pANT_R_Results)
  R_ACC_NC <- getACC_NC(pANT_R_Results)
  R_ACC_DC <- getACC_DC(pANT_R_Results)
  R_ACC_VC <- getACC_VC(pANT_R_Results)
  R_ACC_IVC <- getACC_IVC(pANT_R_Results)
  R_ACC_VC_0 <- getACC_VC_0(pANT_R_Results)
  R_ACC_VC_400 <- getACC_VC_400(pANT_R_Results)
  R_ACC_VC_800 <- getACC_VC_800(pANT_R_Results)
  R_ACC_IVC_0 <- getACC_IVC_0(pANT_R_Results)
  R_ACC_IVC_400 <- getACC_IVC_400(pANT_R_Results)
  R_ACC_IVC_800 <- getACC_IVC_800(pANT_R_Results)
  R_ACC_FC <- getACC_FC(pANT_R_Results)
  R_ACC_FC_0 <- getACC_FC_0(pANT_R_Results)
  R_ACC_FC_400 <- getACC_FC_400(pANT_R_Results)
  R_ACC_FC_800 <- getACC_FC_800(pANT_R_Results)
  R_ACC_FIC <- getACC_FIC(pANT_R_Results)
  R_ACC_FIC_0 <- getACC_FIC_0(pANT_R_Results)
  R_ACC_FIC_400 <- getACC_FIC_400(pANT_R_Results)
  R_ACC_FIC_800 <- getACC_FIC_800(pANT_R_Results)
  R_ACC_LC <- getACC_LC(pANT_R_Results)
  R_ACC_LC_0 <- getACC_LC_0(pANT_R_Results)
  R_ACC_LC_400 <- getACC_LC_400(pANT_R_Results)
  R_ACC_LC_800 <- getACC_LC_800(pANT_R_Results)
  R_ACC_LIC <- getACC_LIC(pANT_R_Results)
  R_ACC_LIC_0 <- getACC_LIC_0(pANT_R_Results)
  R_ACC_LIC_400 <- getACC_LIC_400(pANT_R_Results)
  R_ACC_LIC_800 <- getACC_LIC_800(pANT_R_Results)
  R_ACC_FC_LC <- getACC_FC_LC(pANT_R_Results)
  R_ACC_FC_LIC <- getACC_FC_LIC(pANT_R_Results)
  R_ACC_FIC_LC <- getACC_FIC_LC(pANT_R_Results)
  R_ACC_FIC_LIC <- getACC_FIC_LIC(pANT_R_Results)
  R_ACC_DC_FC <- getACC_DC_FC(pANT_R_Results)
  R_ACC_DC_FIC <- getACC_DC_FIC(pANT_R_Results)
  R_ACC_VC_FC <- getACC_VC_FC(pANT_R_Results)
  R_ACC_VC_FIC <- getACC_VC_FIC(pANT_R_Results)
  R_ACC_IVC_FC <- getACC_IVC_FC(pANT_R_Results)
  R_ACC_IVC_FIC <- getACC_IVC_FIC(pANT_R_Results)
  R_ACC_NC_FC <- getACC_NC_FC(pANT_R_Results)
  R_ACC_NC_FIC <- getACC_NC_FIC(pANT_R_Results)
  R_ACC_NC_LC <- getACC_NC_LC(pANT_R_Results)
  R_ACC_NC_LIC <- getACC_NC_LIC(pANT_R_Results)
  R_ACC_DC_LC <- getACC_DC_LC(pANT_R_Results)
  R_ACC_DC_LIC <- getACC_DC_LIC(pANT_R_Results)
  R_ACC_VC_LC <- getACC_VC_LC(pANT_R_Results)
  R_ACC_VC_LIC <- getACC_VC_LIC(pANT_R_Results)
  R_ACC_IVC_LC <- getACC_IVC_LC(pANT_R_Results)
  R_ACC_IVC_LIC <- getACC_IVC_LIC(pANT_R_Results)
  R_ACC_DC_0 <- getACC_DC_0(pANT_R_Results)
  R_ACC_DC_0_FC <- getACC_DC_0_FC(pANT_R_Results)
  R_ACC_DC_0_FIC <- getACC_DC_0_FIC(pANT_R_Results)
  R_ACC_DC_0_LC <- getACC_DC_0_LC(pANT_R_Results)
  R_ACC_DC_0_LIC <- getACC_DC_0_LIC(pANT_R_Results)
  R_ACC_DC_400 <- getACC_DC_400(pANT_R_Results)
  R_ACC_DC_400_FC <- getACC_DC_400_FC(pANT_R_Results)
  R_ACC_DC_400_FIC <- getACC_DC_400_FIC(pANT_R_Results)
  R_ACC_DC_400_LC <- getACC_DC_400_LC(pANT_R_Results)
  R_ACC_DC_400_LIC <- getACC_DC_400_LIC(pANT_R_Results)
  R_ACC_DC_800 <- getACC_DC_800(pANT_R_Results)
  R_ACC_DC_800_FC <- getACC_DC_800_FC(pANT_R_Results)
  R_ACC_DC_800_FIC <- getACC_DC_800_FIC(pANT_R_Results)
  R_ACC_DC_800_LC <- getACC_DC_800_LC(pANT_R_Results)
  R_ACC_DC_800_LIC <- getACC_DC_800_LIC(pANT_R_Results)
  R_ACC_Alerting <- getACC_Alerting(pANT_R_Results)
  R_ACC_Validity <- getACC_Validity(pANT_R_Results)
  R_ACC_Disengaging <- getACC_Disengaging(pANT_R_Results)
  R_ACC_Moving_Engaging <- getACC_Moving_Engaging(pANT_R_Results)
  R_ACC_OrientingTime <- getACC_OrientingTime(pANT_R_Results)
  R_ACC_FlankerConflict <- getACC_FlankerConflict(pANT_R_Results)
  R_ACC_LocationConflict <- getACC_LocationConflict(pANT_R_Results)
  R_ACC_FlankerByLocation <- getACC_FlankerByLocation(pANT_R_Results)
  R_ACC_AlertingByFlanker <- getACC_AlertingByFlanker(pANT_R_Results)
  R_ACC_OrientingByFlanker <- getACC_OrientingByFlanker(pANT_R_Results)
  R_ACC_ValidityByFlanker <- getACC_ValidityByFlanker(pANT_R_Results)
  R_ACC_AlertingByLocation <- getACC_AlertingByLocation(pANT_R_Results)
  R_ACC_OrientingByLocation <- getACC_OrientingByLocation(pANT_R_Results)
  R_ACC_ValidityByLocation <- getACC_ValidityByLocation(pANT_R_Results)
  R_ACC_IOR <- getACC_IOR(pANT_R_Results)
  R_ACC_NC_FCLC <- getACC_NC_FCLC(pANT_R_Results)
  R_ACC_NC_FICLC <- getACC_NC_FICLC(pANT_R_Results)
  R_ACC_NC_FCLIC <- getACC_NC_FCLIC(pANT_R_Results)
  R_ACC_NC_FICLIC <- getACC_NC_FICLIC(pANT_R_Results)
  R_ACC_DC_0_FCLC <- getACC_DC_0_FCLC(pANT_R_Results)
  R_ACC_DC_0_FICLC <- getACC_DC_0_FICLC(pANT_R_Results)
  R_ACC_DC_0_FCLIC <- getACC_DC_0_FCLIC(pANT_R_Results)
  R_ACC_DC_0_FICLIC <- getACC_DC_0_FICLIC(pANT_R_Results)
  R_ACC_DC_400_FCLC <- getACC_DC_400_FCLC(pANT_R_Results)
  R_ACC_DC_400_FICLC <- getACC_DC_400_FICLC(pANT_R_Results)
  R_ACC_DC_400_FCLIC <- getACC_DC_400_FCLIC(pANT_R_Results)
  R_ACC_DC_400_FICLIC <- getACC_DC_400_FICLIC(pANT_R_Results)
  R_ACC_DC_800_FCLC <- getACC_DC_800_FCLC(pANT_R_Results)
  R_ACC_DC_800_FICLC <- getACC_DC_800_FICLC(pANT_R_Results)
  R_ACC_DC_800_FCLIC <- getACC_DC_800_FCLIC(pANT_R_Results)
  R_ACC_DC_800_FICLIC <- getACC_DC_800_FICLIC(pANT_R_Results)
  R_ACC_VC_0_FCLC <- getACC_VC_0_FCLC(pANT_R_Results)
  R_ACC_VC_0_FICLC <- getACC_VC_0_FICLC(pANT_R_Results)
  R_ACC_VC_0_FCLIC <- getACC_VC_0_FCLIC(pANT_R_Results)
  R_ACC_VC_0_FICLIC <- getACC_VC_0_FICLIC(pANT_R_Results)
  R_ACC_VC_400_FCLC <- getACC_VC_400_FCLC(pANT_R_Results)
  R_ACC_VC_400_FICLC <- getACC_VC_400_FICLC(pANT_R_Results)
  R_ACC_VC_400_FCLIC <- getACC_VC_400_FCLIC(pANT_R_Results)
  R_ACC_VC_400_FICLIC <- getACC_VC_400_FICLIC(pANT_R_Results)
  R_ACC_VC_800_FCLC <- getACC_VC_800_FCLC(pANT_R_Results)
  R_ACC_VC_800_FICLC <- getACC_VC_800_FICLC(pANT_R_Results)
  R_ACC_VC_800_FCLIC <- getACC_VC_800_FCLIC(pANT_R_Results)
  R_ACC_VC_800_FICLIC <- getACC_VC_800_FICLIC(pANT_R_Results)
  R_ACC_IVC_0_FCLC <- getACC_IVC_0_FCLC(pANT_R_Results)
  R_ACC_IVC_0_FICLC <- getACC_IVC_0_FICLC(pANT_R_Results)
  R_ACC_IVC_0_FCLIC <- getACC_IVC_0_FCLIC(pANT_R_Results)
  R_ACC_IVC_0_FICLIC <- getACC_IVC_0_FICLIC(pANT_R_Results)
  R_ACC_IVC_400_FCLC <- getACC_IVC_400_FCLC(pANT_R_Results)
  R_ACC_IVC_400_FICLC <- getACC_IVC_400_FICLC(pANT_R_Results)
  R_ACC_IVC_400_FCLIC <- getACC_IVC_400_FCLIC(pANT_R_Results)
  R_ACC_IVC_400_FICLIC <- getACC_IVC_400_FICLIC(pANT_R_Results)
  R_ACC_IVC_800_FCLC <- getACC_IVC_800_FCLC(pANT_R_Results)
  R_ACC_IVC_800_FICLC <- getACC_IVC_800_FICLC(pANT_R_Results)
  R_ACC_IVC_800_FCLIC <- getACC_IVC_800_FCLIC(pANT_R_Results)
  R_ACC_IVC_800_FICLIC <- getACC_IVC_800_FICLIC(pANT_R_Results)
  VR_RT <- getRT(pANT_VR_Results)
  VR_RT_NC <- getRT_NC(pANT_VR_Results)
  VR_RT_DC <- getRT_DC(pANT_VR_Results)
  VR_RT_VC <- getRT_VC(pANT_VR_Results)
  VR_RT_IVC <- getRT_IVC(pANT_VR_Results)
  VR_RT_VC_0 <- getRT_VC_0(pANT_VR_Results)
  VR_RT_VC_400 <- getRT_VC_400(pANT_VR_Results)
  VR_RT_VC_800 <- getRT_VC_800(pANT_VR_Results)
  VR_RT_IVC_0 <- getRT_IVC_0(pANT_VR_Results)
  VR_RT_IVC_400 <- getRT_IVC_400(pANT_VR_Results)
  VR_RT_IVC_800 <- getRT_IVC_800(pANT_VR_Results)
  VR_RT_FC <- getRT_FC(pANT_VR_Results)
  VR_RT_FC_0 <- getRT_FC_0(pANT_VR_Results)
  VR_RT_FC_400 <- getRT_FC_400(pANT_VR_Results)
  VR_RT_FC_800 <- getRT_FC_800(pANT_VR_Results)
  VR_RT_FIC <- getRT_FIC(pANT_VR_Results)
  VR_RT_FIC_0 <- getRT_FIC_0(pANT_VR_Results)
  VR_RT_FIC_400 <- getRT_FIC_400(pANT_VR_Results)
  VR_RT_FIC_800 <- getRT_FIC_800(pANT_VR_Results)
  VR_RT_LC <- getRT_LC(pANT_VR_Results)
  VR_RT_LC_0 <- getRT_LC_0(pANT_VR_Results)
  VR_RT_LC_400 <- getRT_LC_400(pANT_VR_Results)
  VR_RT_LC_800 <- getRT_LC_800(pANT_VR_Results)
  VR_RT_LIC <- getRT_LIC(pANT_VR_Results)
  VR_RT_LIC_0 <- getRT_LIC_0(pANT_VR_Results)
  VR_RT_LIC_400 <- getRT_LIC_400(pANT_VR_Results)
  VR_RT_LIC_800 <- getRT_LIC_800(pANT_VR_Results)
  VR_RT_FC_LC <- getRT_FC_LC(pANT_VR_Results)
  VR_RT_FC_LIC <- getRT_FC_LIC(pANT_VR_Results)
  VR_RT_FIC_LC <- getRT_FIC_LC(pANT_VR_Results)
  VR_RT_FIC_LIC <- getRT_FIC_LIC(pANT_VR_Results)
  VR_RT_DC_FC <- getRT_DC_FC(pANT_VR_Results)
  VR_RT_DC_FIC <- getRT_DC_FIC(pANT_VR_Results)
  VR_RT_VC_FC <- getRT_VC_FC(pANT_VR_Results)
  VR_RT_VC_FIC <- getRT_VC_FIC(pANT_VR_Results)
  VR_RT_IVC_FC <- getRT_IVC_FC(pANT_VR_Results)
  VR_RT_IVC_FIC <- getRT_IVC_FIC(pANT_VR_Results)
  VR_RT_NC_FC <- getRT_NC_FC(pANT_VR_Results)
  VR_RT_NC_FIC <- getRT_NC_FIC(pANT_VR_Results)
  VR_RT_NC_LC <- getRT_NC_LC(pANT_VR_Results)
  VR_RT_NC_LIC <- getRT_NC_LIC(pANT_VR_Results)
  VR_RT_DC_LC <- getRT_DC_LC(pANT_VR_Results)
  VR_RT_DC_LIC <- getRT_DC_LIC(pANT_VR_Results)
  VR_RT_VC_LC <- getRT_VC_LC(pANT_VR_Results)
  VR_RT_VC_LIC <- getRT_VC_LIC(pANT_VR_Results)
  VR_RT_IVC_LC <- getRT_IVC_LC(pANT_VR_Results)
  VR_RT_IVC_LIC <- getRT_IVC_LIC(pANT_VR_Results)
  VR_RT_DC_0 <- getRT_DC_0(pANT_VR_Results)
  VR_RT_DC_0_FC <- getRT_DC_0_FC(pANT_VR_Results)
  VR_RT_DC_0_FIC <- getRT_DC_0_FIC(pANT_VR_Results)
  VR_RT_DC_0_LC <- getRT_DC_0_LC(pANT_VR_Results)
  VR_RT_DC_0_LIC <- getRT_DC_0_LIC(pANT_VR_Results)
  VR_RT_DC_400 <- getRT_DC_400(pANT_VR_Results)
  VR_RT_DC_400_FC <- getRT_DC_400_FC(pANT_VR_Results)
  VR_RT_DC_400_FIC <- getRT_DC_400_FIC(pANT_VR_Results)
  VR_RT_DC_400_LC <- getRT_DC_400_LC(pANT_VR_Results)
  VR_RT_DC_400_LIC <- getRT_DC_400_LIC(pANT_VR_Results)
  VR_RT_DC_800 <- getRT_DC_800(pANT_VR_Results)
  VR_RT_DC_800_FC <- getRT_DC_800_FC(pANT_VR_Results)
  VR_RT_DC_800_FIC <- getRT_DC_800_FIC(pANT_VR_Results)
  VR_RT_DC_800_LC <- getRT_DC_800_LC(pANT_VR_Results)
  VR_RT_DC_800_LIC <- getRT_DC_800_LIC(pANT_VR_Results)
  VR_RT_Alerting <- getRT_Alerting(pANT_VR_Results)
  VR_RT_Validity <- getRT_Validity(pANT_VR_Results)
  VR_RT_Disengaging <- getRT_Disengaging(pANT_VR_Results)
  VR_RT_Moving_Engaging <- getRT_Moving_Engaging(pANT_VR_Results)
  VR_RT_OrientingTime <- getRT_OrientingTime(pANT_VR_Results)
  VR_RT_FlankerConflict <- getRT_FlankerConflict(pANT_VR_Results)
  VR_RT_LocationConflict <- getRT_LocationConflict(pANT_VR_Results)
  VR_RT_FlankerByLocation <- getRT_FlankerByLocation(pANT_VR_Results)
  VR_RT_AlertingByFlanker <- getRT_AlertingByFlanker(pANT_VR_Results)
  VR_RT_OrientingByFlanker <- getRT_OrientingByFlanker(pANT_VR_Results)
  VR_RT_ValidityByFlanker <- getRT_ValidityByFlanker(pANT_VR_Results)
  VR_RT_AlertingByLocation <- getRT_AlertingByLocation(pANT_VR_Results)
  VR_RT_OrientingByLocation <- getRT_OrientingByLocation(pANT_VR_Results)
  VR_RT_ValidityByLocation <- getRT_ValidityByLocation(pANT_VR_Results)
  VR_RT_IOR <- getRT_IOR(pANT_VR_Results)
  VR_RT_NC_FCLC <- getRT_NC_FCLC(pANT_VR_Results)
  VR_RT_NC_FICLC <- getRT_NC_FICLC(pANT_VR_Results)
  VR_RT_NC_FCLIC <- getRT_NC_FCLIC(pANT_VR_Results)
  VR_RT_NC_FICLIC <- getRT_NC_FICLIC(pANT_VR_Results)
  VR_RT_DC_0_FCLC <- getRT_DC_0_FCLC(pANT_VR_Results)
  VR_RT_DC_0_FICLC <- getRT_DC_0_FICLC(pANT_VR_Results)
  VR_RT_DC_0_FCLIC <- getRT_DC_0_FCLIC(pANT_VR_Results)
  VR_RT_DC_0_FICLIC <- getRT_DC_0_FICLIC(pANT_VR_Results)
  VR_RT_DC_400_FCLC <- getRT_DC_400_FCLC(pANT_VR_Results)
  VR_RT_DC_400_FICLC <- getRT_DC_400_FICLC(pANT_VR_Results)
  VR_RT_DC_400_FCLIC <- getRT_DC_400_FCLIC(pANT_VR_Results)
  VR_RT_DC_400_FICLIC <- getRT_DC_400_FICLIC(pANT_VR_Results)
  VR_RT_DC_800_FCLC <- getRT_DC_800_FCLC(pANT_VR_Results)
  VR_RT_DC_800_FICLC <- getRT_DC_800_FICLC(pANT_VR_Results)
  VR_RT_DC_800_FCLIC <- getRT_DC_800_FCLIC(pANT_VR_Results)
  VR_RT_DC_800_FICLIC <- getRT_DC_800_FICLIC(pANT_VR_Results)
  VR_RT_VC_0_FCLC <- getRT_VC_0_FCLC(pANT_VR_Results)
  VR_RT_VC_0_FICLC <- getRT_VC_0_FICLC(pANT_VR_Results)
  VR_RT_VC_0_FCLIC <- getRT_VC_0_FCLIC(pANT_VR_Results)
  VR_RT_VC_0_FICLIC <- getRT_VC_0_FICLIC(pANT_VR_Results)
  VR_RT_VC_400_FCLC <- getRT_VC_400_FCLC(pANT_VR_Results)
  VR_RT_VC_400_FICLC <- getRT_VC_400_FICLC(pANT_VR_Results)
  VR_RT_VC_400_FCLIC <- getRT_VC_400_FCLIC(pANT_VR_Results)
  VR_RT_VC_400_FICLIC <- getRT_VC_400_FICLIC(pANT_VR_Results)
  VR_RT_VC_800_FCLC <- getRT_VC_800_FCLC(pANT_VR_Results)
  VR_RT_VC_800_FICLC <- getRT_VC_800_FICLC(pANT_VR_Results)
  VR_RT_VC_800_FCLIC <- getRT_VC_800_FCLIC(pANT_VR_Results)
  VR_RT_VC_800_FICLIC <- getRT_VC_800_FICLIC(pANT_VR_Results)
  VR_RT_IVC_0_FCLC <- getRT_IVC_0_FCLC(pANT_VR_Results)
  VR_RT_IVC_0_FICLC <- getRT_IVC_0_FICLC(pANT_VR_Results)
  VR_RT_IVC_0_FCLIC <- getRT_IVC_0_FCLIC(pANT_VR_Results)
  VR_RT_IVC_0_FICLIC <- getRT_IVC_0_FICLIC(pANT_VR_Results)
  VR_RT_IVC_400_FCLC <- getRT_IVC_400_FCLC(pANT_VR_Results)
  VR_RT_IVC_400_FICLC <- getRT_IVC_400_FICLC(pANT_VR_Results)
  VR_RT_IVC_400_FCLIC <- getRT_IVC_400_FCLIC(pANT_VR_Results)
  VR_RT_IVC_400_FICLIC <- getRT_IVC_400_FICLIC(pANT_VR_Results)
  VR_RT_IVC_800_FCLC <- getRT_IVC_800_FCLC(pANT_VR_Results)
  VR_RT_IVC_800_FICLC <- getRT_IVC_800_FICLC(pANT_VR_Results)
  VR_RT_IVC_800_FCLIC <- getRT_IVC_800_FCLIC(pANT_VR_Results)
  VR_RT_IVC_800_FICLIC <- getRT_IVC_800_FICLIC(pANT_VR_Results)
  VR_ACC <- getAcc(pANT_VR_Results)
  VR_ACC_NC <- getACC_NC(pANT_VR_Results)
  VR_ACC_DC <- getACC_DC(pANT_VR_Results)
  VR_ACC_VC <- getACC_VC(pANT_VR_Results)
  VR_ACC_IVC <- getACC_IVC(pANT_VR_Results)
  VR_ACC_VC_0 <- getACC_VC_0(pANT_VR_Results)
  VR_ACC_VC_400 <- getACC_VC_400(pANT_VR_Results)
  VR_ACC_VC_800 <- getACC_VC_800(pANT_VR_Results)
  VR_ACC_IVC_0 <- getACC_IVC_0(pANT_VR_Results)
  VR_ACC_IVC_400 <- getACC_IVC_400(pANT_VR_Results)
  VR_ACC_IVC_800 <- getACC_IVC_800(pANT_VR_Results)
  VR_ACC_FC <- getACC_FC(pANT_VR_Results)
  VR_ACC_FC_0 <- getACC_FC_0(pANT_VR_Results)
  VR_ACC_FC_400 <- getACC_FC_400(pANT_VR_Results)
  VR_ACC_FC_800 <- getACC_FC_800(pANT_VR_Results)
  VR_ACC_FIC <- getACC_FIC(pANT_VR_Results)
  VR_ACC_FIC_0 <- getACC_FIC_0(pANT_VR_Results)
  VR_ACC_FIC_400 <- getACC_FIC_400(pANT_VR_Results)
  VR_ACC_FIC_800 <- getACC_FIC_800(pANT_VR_Results)
  VR_ACC_LC <- getACC_LC(pANT_VR_Results)
  VR_ACC_LC_0 <- getACC_LC_0(pANT_VR_Results)
  VR_ACC_LC_400 <- getACC_LC_400(pANT_VR_Results)
  VR_ACC_LC_800 <- getACC_LC_800(pANT_VR_Results)
  VR_ACC_LIC <- getACC_LIC(pANT_VR_Results)
  VR_ACC_LIC_0 <- getACC_LIC_0(pANT_VR_Results)
  VR_ACC_LIC_400 <- getACC_LIC_400(pANT_VR_Results)
  VR_ACC_LIC_800 <- getACC_LIC_800(pANT_VR_Results)
  VR_ACC_FC_LC <- getACC_FC_LC(pANT_VR_Results)
  VR_ACC_FC_LIC <- getACC_FC_LIC(pANT_VR_Results)
  VR_ACC_FIC_LC <- getACC_FIC_LC(pANT_VR_Results)
  VR_ACC_FIC_LIC <- getACC_FIC_LIC(pANT_VR_Results)
  VR_ACC_DC_FC <- getACC_DC_FC(pANT_VR_Results)
  VR_ACC_DC_FIC <- getACC_DC_FIC(pANT_VR_Results)
  VR_ACC_VC_FC <- getACC_VC_FC(pANT_VR_Results)
  VR_ACC_VC_FIC <- getACC_VC_FIC(pANT_VR_Results)
  VR_ACC_IVC_FC <- getACC_IVC_FC(pANT_VR_Results)
  VR_ACC_IVC_FIC <- getACC_IVC_FIC(pANT_VR_Results)
  VR_ACC_NC_FC <- getACC_NC_FC(pANT_VR_Results)
  VR_ACC_NC_FIC <- getACC_NC_FIC(pANT_VR_Results)
  VR_ACC_NC_LC <- getACC_NC_LC(pANT_VR_Results)
  VR_ACC_NC_LIC <- getACC_NC_LIC(pANT_VR_Results)
  VR_ACC_DC_LC <- getACC_DC_LC(pANT_VR_Results)
  VR_ACC_DC_LIC <- getACC_DC_LIC(pANT_VR_Results)
  VR_ACC_VC_LC <- getACC_VC_LC(pANT_VR_Results)
  VR_ACC_VC_LIC <- getACC_VC_LIC(pANT_VR_Results)
  VR_ACC_IVC_LC <- getACC_IVC_LC(pANT_VR_Results)
  VR_ACC_IVC_LIC <- getACC_IVC_LIC(pANT_VR_Results)
  VR_ACC_DC_0 <- getACC_DC_0(pANT_VR_Results)
  VR_ACC_DC_0_FC <- getACC_DC_0_FC(pANT_VR_Results)
  VR_ACC_DC_0_FIC <- getACC_DC_0_FIC(pANT_VR_Results)
  VR_ACC_DC_0_LC <- getACC_DC_0_LC(pANT_VR_Results)
  VR_ACC_DC_0_LIC <- getACC_DC_0_LIC(pANT_VR_Results)
  VR_ACC_DC_400 <- getACC_DC_400(pANT_VR_Results)
  VR_ACC_DC_400_FC <- getACC_DC_400_FC(pANT_VR_Results)
  VR_ACC_DC_400_FIC <- getACC_DC_400_FIC(pANT_VR_Results)
  VR_ACC_DC_400_LC <- getACC_DC_400_LC(pANT_VR_Results)
  VR_ACC_DC_400_LIC <- getACC_DC_400_LIC(pANT_VR_Results)
  VR_ACC_DC_800 <- getACC_DC_800(pANT_VR_Results)
  VR_ACC_DC_800_FC <- getACC_DC_800_FC(pANT_VR_Results)
  VR_ACC_DC_800_FIC <- getACC_DC_800_FIC(pANT_VR_Results)
  VR_ACC_DC_800_LC <- getACC_DC_800_LC(pANT_VR_Results)
  VR_ACC_DC_800_LIC <- getACC_DC_800_LIC(pANT_VR_Results)
  VR_ACC_Alerting <- getACC_Alerting(pANT_VR_Results)
  VR_ACC_Validity <- getACC_Validity(pANT_VR_Results)
  VR_ACC_Disengaging <- getACC_Disengaging(pANT_VR_Results)
  VR_ACC_Moving_Engaging <- getACC_Moving_Engaging(pANT_VR_Results)
  VR_ACC_OrientingTime <- getACC_OrientingTime(pANT_VR_Results)
  VR_ACC_FlankerConflict <- getACC_FlankerConflict(pANT_VR_Results)
  VR_ACC_LocationConflict <- getACC_LocationConflict(pANT_VR_Results)
  VR_ACC_FlankerByLocation <- getACC_FlankerByLocation(pANT_VR_Results)
  VR_ACC_AlertingByFlanker <- getACC_AlertingByFlanker(pANT_VR_Results)
  VR_ACC_OrientingByFlanker <- getACC_OrientingByFlanker(pANT_VR_Results)
  VR_ACC_ValidityByFlanker <- getACC_ValidityByFlanker(pANT_VR_Results)
  VR_ACC_AlertingByLocation <- getACC_AlertingByLocation(pANT_VR_Results)
  VR_ACC_OrientingByLocation <- getACC_OrientingByLocation(pANT_VR_Results)
  VR_ACC_ValidityByLocation <- getACC_ValidityByLocation(pANT_VR_Results)
  VR_ACC_IOR <- getACC_IOR(pANT_VR_Results)
  VR_ACC_NC_FCLC <- getACC_NC_FCLC(pANT_VR_Results)
  VR_ACC_NC_FICLC <- getACC_NC_FICLC(pANT_VR_Results)
  VR_ACC_NC_FCLIC <- getACC_NC_FCLIC(pANT_VR_Results)
  VR_ACC_NC_FICLIC <- getACC_NC_FICLIC(pANT_VR_Results)
  VR_ACC_DC_0_FCLC <- getACC_DC_0_FCLC(pANT_VR_Results)
  VR_ACC_DC_0_FICLC <- getACC_DC_0_FICLC(pANT_VR_Results)
  VR_ACC_DC_0_FCLIC <- getACC_DC_0_FCLIC(pANT_VR_Results)
  VR_ACC_DC_0_FICLIC <- getACC_DC_0_FICLIC(pANT_VR_Results)
  VR_ACC_DC_400_FCLC <- getACC_DC_400_FCLC(pANT_VR_Results)
  VR_ACC_DC_400_FICLC <- getACC_DC_400_FICLC(pANT_VR_Results)
  VR_ACC_DC_400_FCLIC <- getACC_DC_400_FCLIC(pANT_VR_Results)
  VR_ACC_DC_400_FICLIC <- getACC_DC_400_FICLIC(pANT_VR_Results)
  VR_ACC_DC_800_FCLC <- getACC_DC_800_FCLC(pANT_VR_Results)
  VR_ACC_DC_800_FICLC <- getACC_DC_800_FICLC(pANT_VR_Results)
  VR_ACC_DC_800_FCLIC <- getACC_DC_800_FCLIC(pANT_VR_Results)
  VR_ACC_DC_800_FICLIC <- getACC_DC_800_FICLIC(pANT_VR_Results)
  VR_ACC_VC_0_FCLC <- getACC_VC_0_FCLC(pANT_VR_Results)
  VR_ACC_VC_0_FICLC <- getACC_VC_0_FICLC(pANT_VR_Results)
  VR_ACC_VC_0_FCLIC <- getACC_VC_0_FCLIC(pANT_VR_Results)
  VR_ACC_VC_0_FICLIC <- getACC_VC_0_FICLIC(pANT_VR_Results)
  VR_ACC_VC_400_FCLC <- getACC_VC_400_FCLC(pANT_VR_Results)
  VR_ACC_VC_400_FICLC <- getACC_VC_400_FICLC(pANT_VR_Results)
  VR_ACC_VC_400_FCLIC <- getACC_VC_400_FCLIC(pANT_VR_Results)
  VR_ACC_VC_400_FICLIC <- getACC_VC_400_FICLIC(pANT_VR_Results)
  VR_ACC_VC_800_FCLC <- getACC_VC_800_FCLC(pANT_VR_Results)
  VR_ACC_VC_800_FICLC <- getACC_VC_800_FICLC(pANT_VR_Results)
  VR_ACC_VC_800_FCLIC <- getACC_VC_800_FCLIC(pANT_VR_Results)
  VR_ACC_VC_800_FICLIC <- getACC_VC_800_FICLIC(pANT_VR_Results)
  VR_ACC_IVC_0_FCLC <- getACC_IVC_0_FCLC(pANT_VR_Results)
  VR_ACC_IVC_0_FICLC <- getACC_IVC_0_FICLC(pANT_VR_Results)
  VR_ACC_IVC_0_FCLIC <- getACC_IVC_0_FCLIC(pANT_VR_Results)
  VR_ACC_IVC_0_FICLIC <- getACC_IVC_0_FICLIC(pANT_VR_Results)
  VR_ACC_IVC_400_FCLC <- getACC_IVC_400_FCLC(pANT_VR_Results)
  VR_ACC_IVC_400_FICLC <- getACC_IVC_400_FICLC(pANT_VR_Results)
  VR_ACC_IVC_400_FCLIC <- getACC_IVC_400_FCLIC(pANT_VR_Results)
  VR_ACC_IVC_400_FICLIC <- getACC_IVC_400_FICLIC(pANT_VR_Results)
  VR_ACC_IVC_800_FCLC <- getACC_IVC_800_FCLC(pANT_VR_Results)
  VR_ACC_IVC_800_FICLC <- getACC_IVC_800_FICLC(pANT_VR_Results)
  VR_ACC_IVC_800_FCLIC <- getACC_IVC_800_FCLIC(pANT_VR_Results)
  VR_ACC_IVC_800_FICLIC <- getACC_IVC_800_FICLIC(pANT_VR_Results)
  VR_B_RT <- getRT(pANT_VR_B_Results)
  VR_B_RT_NC <- getRT_NC(pANT_VR_B_Results)
  VR_B_RT_DC <- getRT_DC(pANT_VR_B_Results)
  VR_B_RT_VC <- getRT_VC(pANT_VR_B_Results)
  VR_B_RT_IVC <- getRT_IVC(pANT_VR_B_Results)
  VR_B_RT_VC_0 <- getRT_VC_0(pANT_VR_B_Results)
  VR_B_RT_VC_400 <- getRT_VC_400(pANT_VR_B_Results)
  VR_B_RT_VC_800 <- getRT_VC_800(pANT_VR_B_Results)
  VR_B_RT_IVC_0 <- getRT_IVC_0(pANT_VR_B_Results)
  VR_B_RT_IVC_400 <- getRT_IVC_400(pANT_VR_B_Results)
  VR_B_RT_IVC_800 <- getRT_IVC_800(pANT_VR_B_Results)
  VR_B_RT_FC <- getRT_FC(pANT_VR_B_Results)
  VR_B_RT_FC_0 <- getRT_FC_0(pANT_VR_B_Results)
  VR_B_RT_FC_400 <- getRT_FC_400(pANT_VR_B_Results)
  VR_B_RT_FC_800 <- getRT_FC_800(pANT_VR_B_Results)
  VR_B_RT_FIC <- getRT_FIC(pANT_VR_B_Results)
  VR_B_RT_FIC_0 <- getRT_FIC_0(pANT_VR_B_Results)
  VR_B_RT_FIC_400 <- getRT_FIC_400(pANT_VR_B_Results)
  VR_B_RT_FIC_800 <- getRT_FIC_800(pANT_VR_B_Results)
  VR_B_RT_LC <- getRT_LC(pANT_VR_B_Results)
  VR_B_RT_LC_0 <- getRT_LC_0(pANT_VR_B_Results)
  VR_B_RT_LC_400 <- getRT_LC_400(pANT_VR_B_Results)
  VR_B_RT_LC_800 <- getRT_LC_800(pANT_VR_B_Results)
  VR_B_RT_LIC <- getRT_LIC(pANT_VR_B_Results)
  VR_B_RT_LIC_0 <- getRT_LIC_0(pANT_VR_B_Results)
  VR_B_RT_LIC_400 <- getRT_LIC_400(pANT_VR_B_Results)
  VR_B_RT_LIC_800 <- getRT_LIC_800(pANT_VR_B_Results)
  VR_B_RT_FC_LC <- getRT_FC_LC(pANT_VR_B_Results)
  VR_B_RT_FC_LIC <- getRT_FC_LIC(pANT_VR_B_Results)
  VR_B_RT_FIC_LC <- getRT_FIC_LC(pANT_VR_B_Results)
  VR_B_RT_FIC_LIC <- getRT_FIC_LIC(pANT_VR_B_Results)
  VR_B_RT_DC_FC <- getRT_DC_FC(pANT_VR_B_Results)
  VR_B_RT_DC_FIC <- getRT_DC_FIC(pANT_VR_B_Results)
  VR_B_RT_VC_FC <- getRT_VC_FC(pANT_VR_B_Results)
  VR_B_RT_VC_FIC <- getRT_VC_FIC(pANT_VR_B_Results)
  VR_B_RT_IVC_FC <- getRT_IVC_FC(pANT_VR_B_Results)
  VR_B_RT_IVC_FIC <- getRT_IVC_FIC(pANT_VR_B_Results)
  VR_B_RT_NC_FC <- getRT_NC_FC(pANT_VR_B_Results)
  VR_B_RT_NC_FIC <- getRT_NC_FIC(pANT_VR_B_Results)
  VR_B_RT_NC_LC <- getRT_NC_LC(pANT_VR_B_Results)
  VR_B_RT_NC_LIC <- getRT_NC_LIC(pANT_VR_B_Results)
  VR_B_RT_DC_LC <- getRT_DC_LC(pANT_VR_B_Results)
  VR_B_RT_DC_LIC <- getRT_DC_LIC(pANT_VR_B_Results)
  VR_B_RT_VC_LC <- getRT_VC_LC(pANT_VR_B_Results)
  VR_B_RT_VC_LIC <- getRT_VC_LIC(pANT_VR_B_Results)
  VR_B_RT_IVC_LC <- getRT_IVC_LC(pANT_VR_B_Results)
  VR_B_RT_IVC_LIC <- getRT_IVC_LIC(pANT_VR_B_Results)
  VR_B_RT_DC_0 <- getRT_DC_0(pANT_VR_B_Results)
  VR_B_RT_DC_0_FC <- getRT_DC_0_FC(pANT_VR_B_Results)
  VR_B_RT_DC_0_FIC <- getRT_DC_0_FIC(pANT_VR_B_Results)
  VR_B_RT_DC_0_LC <- getRT_DC_0_LC(pANT_VR_B_Results)
  VR_B_RT_DC_0_LIC <- getRT_DC_0_LIC(pANT_VR_B_Results)
  VR_B_RT_DC_400 <- getRT_DC_400(pANT_VR_B_Results)
  VR_B_RT_DC_400_FC <- getRT_DC_400_FC(pANT_VR_B_Results)
  VR_B_RT_DC_400_FIC <- getRT_DC_400_FIC(pANT_VR_B_Results)
  VR_B_RT_DC_400_LC <- getRT_DC_400_LC(pANT_VR_B_Results)
  VR_B_RT_DC_400_LIC <- getRT_DC_400_LIC(pANT_VR_B_Results)
  VR_B_RT_DC_800 <- getRT_DC_800(pANT_VR_B_Results)
  VR_B_RT_DC_800_FC <- getRT_DC_800_FC(pANT_VR_B_Results)
  VR_B_RT_DC_800_FIC <- getRT_DC_800_FIC(pANT_VR_B_Results)
  VR_B_RT_DC_800_LC <- getRT_DC_800_LC(pANT_VR_B_Results)
  VR_B_RT_DC_800_LIC <- getRT_DC_800_LIC(pANT_VR_B_Results)
  VR_B_RT_Alerting <- getRT_Alerting(pANT_VR_B_Results)
  VR_B_RT_Validity <- getRT_Validity(pANT_VR_B_Results)
  VR_B_RT_Disengaging <- getRT_Disengaging(pANT_VR_B_Results)
  VR_B_RT_Moving_Engaging <- getRT_Moving_Engaging(pANT_VR_B_Results)
  VR_B_RT_OrientingTime <- getRT_OrientingTime(pANT_VR_B_Results)
  VR_B_RT_FlankerConflict <- getRT_FlankerConflict(pANT_VR_B_Results)
  VR_B_RT_LocationConflict <- getRT_LocationConflict(pANT_VR_B_Results)
  VR_B_RT_FlankerByLocation <- getRT_FlankerByLocation(pANT_VR_B_Results)
  VR_B_RT_AlertingByFlanker <- getRT_AlertingByFlanker(pANT_VR_B_Results)
  VR_B_RT_OrientingByFlanker <- getRT_OrientingByFlanker(pANT_VR_B_Results)
  VR_B_RT_ValidityByFlanker <- getRT_ValidityByFlanker(pANT_VR_B_Results)
  VR_B_RT_AlertingByLocation <- getRT_AlertingByLocation(pANT_VR_B_Results)
  VR_B_RT_OrientingByLocation <- getRT_OrientingByLocation(pANT_VR_B_Results)
  VR_B_RT_ValidityByLocation <- getRT_ValidityByLocation(pANT_VR_B_Results)
  VR_B_RT_IOR <- getRT_IOR(pANT_VR_B_Results)
  VR_B_RT_NC_FCLC <- getRT_NC_FCLC(pANT_VR_B_Results)
  VR_B_RT_NC_FICLC <- getRT_NC_FICLC(pANT_VR_B_Results)
  VR_B_RT_NC_FCLIC <- getRT_NC_FCLIC(pANT_VR_B_Results)
  VR_B_RT_NC_FICLIC <- getRT_NC_FICLIC(pANT_VR_B_Results)
  VR_B_RT_DC_0_FCLC <- getRT_DC_0_FCLC(pANT_VR_B_Results)
  VR_B_RT_DC_0_FICLC <- getRT_DC_0_FICLC(pANT_VR_B_Results)
  VR_B_RT_DC_0_FCLIC <- getRT_DC_0_FCLIC(pANT_VR_B_Results)
  VR_B_RT_DC_0_FICLIC <- getRT_DC_0_FICLIC(pANT_VR_B_Results)
  VR_B_RT_DC_400_FCLC <- getRT_DC_400_FCLC(pANT_VR_B_Results)
  VR_B_RT_DC_400_FICLC <- getRT_DC_400_FICLC(pANT_VR_B_Results)
  VR_B_RT_DC_400_FCLIC <- getRT_DC_400_FCLIC(pANT_VR_B_Results)
  VR_B_RT_DC_400_FICLIC <- getRT_DC_400_FICLIC(pANT_VR_B_Results)
  VR_B_RT_DC_800_FCLC <- getRT_DC_800_FCLC(pANT_VR_B_Results)
  VR_B_RT_DC_800_FICLC <- getRT_DC_800_FICLC(pANT_VR_B_Results)
  VR_B_RT_DC_800_FCLIC <- getRT_DC_800_FCLIC(pANT_VR_B_Results)
  VR_B_RT_DC_800_FICLIC <- getRT_DC_800_FICLIC(pANT_VR_B_Results)
  VR_B_RT_VC_0_FCLC <- getRT_VC_0_FCLC(pANT_VR_B_Results)
  VR_B_RT_VC_0_FICLC <- getRT_VC_0_FICLC(pANT_VR_B_Results)
  VR_B_RT_VC_0_FCLIC <- getRT_VC_0_FCLIC(pANT_VR_B_Results)
  VR_B_RT_VC_0_FICLIC <- getRT_VC_0_FICLIC(pANT_VR_B_Results)
  VR_B_RT_VC_400_FCLC <- getRT_VC_400_FCLC(pANT_VR_B_Results)
  VR_B_RT_VC_400_FICLC <- getRT_VC_400_FICLC(pANT_VR_B_Results)
  VR_B_RT_VC_400_FCLIC <- getRT_VC_400_FCLIC(pANT_VR_B_Results)
  VR_B_RT_VC_400_FICLIC <- getRT_VC_400_FICLIC(pANT_VR_B_Results)
  VR_B_RT_VC_800_FCLC <- getRT_VC_800_FCLC(pANT_VR_B_Results)
  VR_B_RT_VC_800_FICLC <- getRT_VC_800_FICLC(pANT_VR_B_Results)
  VR_B_RT_VC_800_FCLIC <- getRT_VC_800_FCLIC(pANT_VR_B_Results)
  VR_B_RT_VC_800_FICLIC <- getRT_VC_800_FICLIC(pANT_VR_B_Results)
  VR_B_RT_IVC_0_FCLC <- getRT_IVC_0_FCLC(pANT_VR_B_Results)
  VR_B_RT_IVC_0_FICLC <- getRT_IVC_0_FICLC(pANT_VR_B_Results)
  VR_B_RT_IVC_0_FCLIC <- getRT_IVC_0_FCLIC(pANT_VR_B_Results)
  VR_B_RT_IVC_0_FICLIC <- getRT_IVC_0_FICLIC(pANT_VR_B_Results)
  VR_B_RT_IVC_400_FCLC <- getRT_IVC_400_FCLC(pANT_VR_B_Results)
  VR_B_RT_IVC_400_FICLC <- getRT_IVC_400_FICLC(pANT_VR_B_Results)
  VR_B_RT_IVC_400_FCLIC <- getRT_IVC_400_FCLIC(pANT_VR_B_Results)
  VR_B_RT_IVC_400_FICLIC <- getRT_IVC_400_FICLIC(pANT_VR_B_Results)
  VR_B_RT_IVC_800_FCLC <- getRT_IVC_800_FCLC(pANT_VR_B_Results)
  VR_B_RT_IVC_800_FICLC <- getRT_IVC_800_FICLC(pANT_VR_B_Results)
  VR_B_RT_IVC_800_FCLIC <- getRT_IVC_800_FCLIC(pANT_VR_B_Results)
  VR_B_RT_IVC_800_FICLIC <- getRT_IVC_800_FICLIC(pANT_VR_B_Results)
  VR_B_ACC <- getAcc(pANT_VR_B_Results)
  VR_B_ACC_NC <- getACC_NC(pANT_VR_B_Results)
  VR_B_ACC_DC <- getACC_DC(pANT_VR_B_Results)
  VR_B_ACC_VC <- getACC_VC(pANT_VR_B_Results)
  VR_B_ACC_IVC <- getACC_IVC(pANT_VR_B_Results)
  VR_B_ACC_VC_0 <- getACC_VC_0(pANT_VR_B_Results)
  VR_B_ACC_VC_400 <- getACC_VC_400(pANT_VR_B_Results)
  VR_B_ACC_VC_800 <- getACC_VC_800(pANT_VR_B_Results)
  VR_B_ACC_IVC_0 <- getACC_IVC_0(pANT_VR_B_Results)
  VR_B_ACC_IVC_400 <- getACC_IVC_400(pANT_VR_B_Results)
  VR_B_ACC_IVC_800 <- getACC_IVC_800(pANT_VR_B_Results)
  VR_B_ACC_FC <- getACC_FC(pANT_VR_B_Results)
  VR_B_ACC_FC_0 <- getACC_FC_0(pANT_VR_B_Results)
  VR_B_ACC_FC_400 <- getACC_FC_400(pANT_VR_B_Results)
  VR_B_ACC_FC_800 <- getACC_FC_800(pANT_VR_B_Results)
  VR_B_ACC_FIC <- getACC_FIC(pANT_VR_B_Results)
  VR_B_ACC_FIC_0 <- getACC_FIC_0(pANT_VR_B_Results)
  VR_B_ACC_FIC_400 <- getACC_FIC_400(pANT_VR_B_Results)
  VR_B_ACC_FIC_800 <- getACC_FIC_800(pANT_VR_B_Results)
  VR_B_ACC_LC <- getACC_LC(pANT_VR_B_Results)
  VR_B_ACC_LC_0 <- getACC_LC_0(pANT_VR_B_Results)
  VR_B_ACC_LC_400 <- getACC_LC_400(pANT_VR_B_Results)
  VR_B_ACC_LC_800 <- getACC_LC_800(pANT_VR_B_Results)
  VR_B_ACC_LIC <- getACC_LIC(pANT_VR_B_Results)
  VR_B_ACC_LIC_0 <- getACC_LIC_0(pANT_VR_B_Results)
  VR_B_ACC_LIC_400 <- getACC_LIC_400(pANT_VR_B_Results)
  VR_B_ACC_LIC_800 <- getACC_LIC_800(pANT_VR_B_Results)
  VR_B_ACC_FC_LC <- getACC_FC_LC(pANT_VR_B_Results)
  VR_B_ACC_FC_LIC <- getACC_FC_LIC(pANT_VR_B_Results)
  VR_B_ACC_FIC_LC <- getACC_FIC_LC(pANT_VR_B_Results)
  VR_B_ACC_FIC_LIC <- getACC_FIC_LIC(pANT_VR_B_Results)
  VR_B_ACC_DC_FC <- getACC_DC_FC(pANT_VR_B_Results)
  VR_B_ACC_DC_FIC <- getACC_DC_FIC(pANT_VR_B_Results)
  VR_B_ACC_VC_FC <- getACC_VC_FC(pANT_VR_B_Results)
  VR_B_ACC_VC_FIC <- getACC_VC_FIC(pANT_VR_B_Results)
  VR_B_ACC_IVC_FC <- getACC_IVC_FC(pANT_VR_B_Results)
  VR_B_ACC_IVC_FIC <- getACC_IVC_FIC(pANT_VR_B_Results)
  VR_B_ACC_NC_FC <- getACC_NC_FC(pANT_VR_B_Results)
  VR_B_ACC_NC_FIC <- getACC_NC_FIC(pANT_VR_B_Results)
  VR_B_ACC_NC_LC <- getACC_NC_LC(pANT_VR_B_Results)
  VR_B_ACC_NC_LIC <- getACC_NC_LIC(pANT_VR_B_Results)
  VR_B_ACC_DC_LC <- getACC_DC_LC(pANT_VR_B_Results)
  VR_B_ACC_DC_LIC <- getACC_DC_LIC(pANT_VR_B_Results)
  VR_B_ACC_VC_LC <- getACC_VC_LC(pANT_VR_B_Results)
  VR_B_ACC_VC_LIC <- getACC_VC_LIC(pANT_VR_B_Results)
  VR_B_ACC_IVC_LC <- getACC_IVC_LC(pANT_VR_B_Results)
  VR_B_ACC_IVC_LIC <- getACC_IVC_LIC(pANT_VR_B_Results)
  VR_B_ACC_DC_0 <- getACC_DC_0(pANT_VR_B_Results)
  VR_B_ACC_DC_0_FC <- getACC_DC_0_FC(pANT_VR_B_Results)
  VR_B_ACC_DC_0_FIC <- getACC_DC_0_FIC(pANT_VR_B_Results)
  VR_B_ACC_DC_0_LC <- getACC_DC_0_LC(pANT_VR_B_Results)
  VR_B_ACC_DC_0_LIC <- getACC_DC_0_LIC(pANT_VR_B_Results)
  VR_B_ACC_DC_400 <- getACC_DC_400(pANT_VR_B_Results)
  VR_B_ACC_DC_400_FC <- getACC_DC_400_FC(pANT_VR_B_Results)
  VR_B_ACC_DC_400_FIC <- getACC_DC_400_FIC(pANT_VR_B_Results)
  VR_B_ACC_DC_400_LC <- getACC_DC_400_LC(pANT_VR_B_Results)
  VR_B_ACC_DC_400_LIC <- getACC_DC_400_LIC(pANT_VR_B_Results)
  VR_B_ACC_DC_800 <- getACC_DC_800(pANT_VR_B_Results)
  VR_B_ACC_DC_800_FC <- getACC_DC_800_FC(pANT_VR_B_Results)
  VR_B_ACC_DC_800_FIC <- getACC_DC_800_FIC(pANT_VR_B_Results)
  VR_B_ACC_DC_800_LC <- getACC_DC_800_LC(pANT_VR_B_Results)
  VR_B_ACC_DC_800_LIC <- getACC_DC_800_LIC(pANT_VR_B_Results)
  VR_B_ACC_Alerting <- getACC_Alerting(pANT_VR_B_Results)
  VR_B_ACC_Validity <- getACC_Validity(pANT_VR_B_Results)
  VR_B_ACC_Disengaging <- getACC_Disengaging(pANT_VR_B_Results)
  VR_B_ACC_Moving_Engaging <- getACC_Moving_Engaging(pANT_VR_B_Results)
  VR_B_ACC_OrientingTime <- getACC_OrientingTime(pANT_VR_B_Results)
  VR_B_ACC_FlankerConflict <- getACC_FlankerConflict(pANT_VR_B_Results)
  VR_B_ACC_LocationConflict <- getACC_LocationConflict(pANT_VR_B_Results)
  VR_B_ACC_FlankerByLocation <- getACC_FlankerByLocation(pANT_VR_B_Results)
  VR_B_ACC_AlertingByFlanker <- getACC_AlertingByFlanker(pANT_VR_B_Results)
  VR_B_ACC_OrientingByFlanker <- getACC_OrientingByFlanker(pANT_VR_B_Results)
  VR_B_ACC_ValidityByFlanker <- getACC_ValidityByFlanker(pANT_VR_B_Results)
  VR_B_ACC_AlertingByLocation <- getACC_AlertingByLocation(pANT_VR_B_Results)
  VR_B_ACC_OrientingByLocation <- getACC_OrientingByLocation(pANT_VR_B_Results)
  VR_B_ACC_ValidityByLocation <- getACC_ValidityByLocation(pANT_VR_B_Results)
  VR_B_ACC_IOR <- getACC_IOR(pANT_VR_B_Results)
  VR_B_ACC_NC_FCLC <- getACC_NC_FCLC(pANT_VR_B_Results)
  VR_B_ACC_NC_FICLC <- getACC_NC_FICLC(pANT_VR_B_Results)
  VR_B_ACC_NC_FCLIC <- getACC_NC_FCLIC(pANT_VR_B_Results)
  VR_B_ACC_NC_FICLIC <- getACC_NC_FICLIC(pANT_VR_B_Results)
  VR_B_ACC_DC_0_FCLC <- getACC_DC_0_FCLC(pANT_VR_B_Results)
  VR_B_ACC_DC_0_FICLC <- getACC_DC_0_FICLC(pANT_VR_B_Results)
  VR_B_ACC_DC_0_FCLIC <- getACC_DC_0_FCLIC(pANT_VR_B_Results)
  VR_B_ACC_DC_0_FICLIC <- getACC_DC_0_FICLIC(pANT_VR_B_Results)
  VR_B_ACC_DC_400_FCLC <- getACC_DC_400_FCLC(pANT_VR_B_Results)
  VR_B_ACC_DC_400_FICLC <- getACC_DC_400_FICLC(pANT_VR_B_Results)
  VR_B_ACC_DC_400_FCLIC <- getACC_DC_400_FCLIC(pANT_VR_B_Results)
  VR_B_ACC_DC_400_FICLIC <- getACC_DC_400_FICLIC(pANT_VR_B_Results)
  VR_B_ACC_DC_800_FCLC <- getACC_DC_800_FCLC(pANT_VR_B_Results)
  VR_B_ACC_DC_800_FICLC <- getACC_DC_800_FICLC(pANT_VR_B_Results)
  VR_B_ACC_DC_800_FCLIC <- getACC_DC_800_FCLIC(pANT_VR_B_Results)
  VR_B_ACC_DC_800_FICLIC <- getACC_DC_800_FICLIC(pANT_VR_B_Results)
  VR_B_ACC_VC_0_FCLC <- getACC_VC_0_FCLC(pANT_VR_B_Results)
  VR_B_ACC_VC_0_FICLC <- getACC_VC_0_FICLC(pANT_VR_B_Results)
  VR_B_ACC_VC_0_FCLIC <- getACC_VC_0_FCLIC(pANT_VR_B_Results)
  VR_B_ACC_VC_0_FICLIC <- getACC_VC_0_FICLIC(pANT_VR_B_Results)
  VR_B_ACC_VC_400_FCLC <- getACC_VC_400_FCLC(pANT_VR_B_Results)
  VR_B_ACC_VC_400_FICLC <- getACC_VC_400_FICLC(pANT_VR_B_Results)
  VR_B_ACC_VC_400_FCLIC <- getACC_VC_400_FCLIC(pANT_VR_B_Results)
  VR_B_ACC_VC_400_FICLIC <- getACC_VC_400_FICLIC(pANT_VR_B_Results)
  VR_B_ACC_VC_800_FCLC <- getACC_VC_800_FCLC(pANT_VR_B_Results)
  VR_B_ACC_VC_800_FICLC <- getACC_VC_800_FICLC(pANT_VR_B_Results)
  VR_B_ACC_VC_800_FCLIC <- getACC_VC_800_FCLIC(pANT_VR_B_Results)
  VR_B_ACC_VC_800_FICLIC <- getACC_VC_800_FICLIC(pANT_VR_B_Results)
  VR_B_ACC_IVC_0_FCLC <- getACC_IVC_0_FCLC(pANT_VR_B_Results)
  VR_B_ACC_IVC_0_FICLC <- getACC_IVC_0_FICLC(pANT_VR_B_Results)
  VR_B_ACC_IVC_0_FCLIC <- getACC_IVC_0_FCLIC(pANT_VR_B_Results)
  VR_B_ACC_IVC_0_FICLIC <- getACC_IVC_0_FICLIC(pANT_VR_B_Results)
  VR_B_ACC_IVC_400_FCLC <- getACC_IVC_400_FCLC(pANT_VR_B_Results)
  VR_B_ACC_IVC_400_FICLC <- getACC_IVC_400_FICLC(pANT_VR_B_Results)
  VR_B_ACC_IVC_400_FCLIC <- getACC_IVC_400_FCLIC(pANT_VR_B_Results)
  VR_B_ACC_IVC_400_FICLIC <- getACC_IVC_400_FICLIC(pANT_VR_B_Results)
  VR_B_ACC_IVC_800_FCLC <- getACC_IVC_800_FCLC(pANT_VR_B_Results)
  VR_B_ACC_IVC_800_FICLC <- getACC_IVC_800_FICLC(pANT_VR_B_Results)
  VR_B_ACC_IVC_800_FCLIC <- getACC_IVC_800_FCLIC(pANT_VR_B_Results)
  VR_B_ACC_IVC_800_FICLIC <- getACC_IVC_800_FICLIC(pANT_VR_B_Results)

  result <- c(
    Id,
    Age,
    Gender,
    GenderNumeric,
    Education,
    EducationNumeric,
    Nationality,
    NationalityNumeric,
    Handedness,
    HandednessNumeric,
    TimeOfDay,
    TimeOfDayNumeric,
    QoE_PQ,
    QoE_RQ,
    QoE_TQ,
    QoE_CQ,
    QoE_IQ,
    QoE_OQ,
    QoE_Sum,
    R_RT,
    R_RT_NC,
    R_RT_DC,
    R_RT_VC,
    R_RT_IVC,
    R_RT_VC_0,
    R_RT_VC_400,
    R_RT_VC_800,
    R_RT_IVC_0,
    R_RT_IVC_400,
    R_RT_IVC_800,
    R_RT_FC,
    R_RT_FC_0,
    R_RT_FC_400,
    R_RT_FC_800,
    R_RT_FIC,
    R_RT_FIC_0,
    R_RT_FIC_400,
    R_RT_FIC_800,
    R_RT_LC,
    R_RT_LC_0,
    R_RT_LC_400,
    R_RT_LC_800,
    R_RT_LIC,
    R_RT_LIC_0,
    R_RT_LIC_400,
    R_RT_LIC_800,
    R_RT_FC_LC,
    R_RT_FC_LIC,
    R_RT_FIC_LC,
    R_RT_FIC_LIC,
    R_RT_DC_FC,
    R_RT_DC_FIC,
    R_RT_VC_FC,
    R_RT_VC_FIC,
    R_RT_IVC_FC,
    R_RT_IVC_FIC,
    R_RT_NC_FC,
    R_RT_NC_FIC,
    R_RT_NC_LC,
    R_RT_NC_LIC,
    R_RT_DC_LC,
    R_RT_DC_LIC,
    R_RT_VC_LC,
    R_RT_VC_LIC,
    R_RT_IVC_LC,
    R_RT_IVC_LIC,
    R_RT_DC_0,
    R_RT_DC_0_FC,
    R_RT_DC_0_FIC,
    R_RT_DC_0_LC,
    R_RT_DC_0_LIC,
    R_RT_DC_400,
    R_RT_DC_400_FC,
    R_RT_DC_400_FIC,
    R_RT_DC_400_LC,
    R_RT_DC_400_LIC,
    R_RT_DC_800,
    R_RT_DC_800_FC,
    R_RT_DC_800_FIC,
    R_RT_DC_800_LC,
    R_RT_DC_800_LIC,
    R_RT_Alerting,
    R_RT_Validity,
    R_RT_Disengaging,
    R_RT_Moving_Engaging,
    R_RT_OrientingTime,
    R_RT_FlankerConflict,
    R_RT_LocationConflict,
    R_RT_FlankerByLocation,
    R_RT_AlertingByFlanker,
    R_RT_OrientingByFlanker,
    R_RT_ValidityByFlanker,
    R_RT_AlertingByLocation,
    R_RT_OrientingByLocation,
    R_RT_ValidityByLocation,
    R_RT_IOR,
    R_RT_NC_FCLC,
    R_RT_NC_FICLC,
    R_RT_NC_FCLIC,
    R_RT_NC_FICLIC,
    R_RT_DC_0_FCLC,
    R_RT_DC_0_FICLC,
    R_RT_DC_0_FCLIC,
    R_RT_DC_0_FICLIC,
    R_RT_DC_400_FCLC,
    R_RT_DC_400_FICLC,
    R_RT_DC_400_FCLIC,
    R_RT_DC_400_FICLIC,
    R_RT_DC_800_FCLC,
    R_RT_DC_800_FICLC,
    R_RT_DC_800_FCLIC,
    R_RT_DC_800_FICLIC,
    R_RT_VC_0_FCLC,
    R_RT_VC_0_FICLC,
    R_RT_VC_0_FCLIC,
    R_RT_VC_0_FICLIC,
    R_RT_VC_400_FCLC,
    R_RT_VC_400_FICLC,
    R_RT_VC_400_FCLIC,
    R_RT_VC_400_FICLIC,
    R_RT_VC_800_FCLC,
    R_RT_VC_800_FICLC,
    R_RT_VC_800_FCLIC,
    R_RT_VC_800_FICLIC,
    R_RT_IVC_0_FCLC,
    R_RT_IVC_0_FICLC,
    R_RT_IVC_0_FCLIC,
    R_RT_IVC_0_FICLIC,
    R_RT_IVC_400_FCLC,
    R_RT_IVC_400_FICLC,
    R_RT_IVC_400_FCLIC,
    R_RT_IVC_400_FICLIC,
    R_RT_IVC_800_FCLC,
    R_RT_IVC_800_FICLC,
    R_RT_IVC_800_FCLIC,
    R_RT_IVC_800_FICLIC,
    R_ACC,
    R_ACC_NC,
    R_ACC_DC,
    R_ACC_VC,
    R_ACC_IVC,
    R_ACC_VC_0,
    R_ACC_VC_400,
    R_ACC_VC_800,
    R_ACC_IVC_0,
    R_ACC_IVC_400,
    R_ACC_IVC_800,
    R_ACC_FC,
    R_ACC_FC_0,
    R_ACC_FC_400,
    R_ACC_FC_800,
    R_ACC_FIC,
    R_ACC_FIC_0,
    R_ACC_FIC_400,
    R_ACC_FIC_800,
    R_ACC_LC,
    R_ACC_LC_0,
    R_ACC_LC_400,
    R_ACC_LC_800,
    R_ACC_LIC,
    R_ACC_LIC_0,
    R_ACC_LIC_400,
    R_ACC_LIC_800,
    R_ACC_FC_LC,
    R_ACC_FC_LIC,
    R_ACC_FIC_LC,
    R_ACC_FIC_LIC,
    R_ACC_DC_FC,
    R_ACC_DC_FIC,
    R_ACC_VC_FC,
    R_ACC_VC_FIC,
    R_ACC_IVC_FC,
    R_ACC_IVC_FIC,
    R_ACC_NC_FC,
    R_ACC_NC_FIC,
    R_ACC_NC_LC,
    R_ACC_NC_LIC,
    R_ACC_DC_LC,
    R_ACC_DC_LIC,
    R_ACC_VC_LC,
    R_ACC_VC_LIC,
    R_ACC_IVC_LC,
    R_ACC_IVC_LIC,
    R_ACC_DC_0,
    R_ACC_DC_0_FC,
    R_ACC_DC_0_FIC,
    R_ACC_DC_0_LC,
    R_ACC_DC_0_LIC,
    R_ACC_DC_400,
    R_ACC_DC_400_FC,
    R_ACC_DC_400_FIC,
    R_ACC_DC_400_LC,
    R_ACC_DC_400_LIC,
    R_ACC_DC_800,
    R_ACC_DC_800_FC,
    R_ACC_DC_800_FIC,
    R_ACC_DC_800_LC,
    R_ACC_DC_800_LIC,
    R_ACC_Alerting,
    R_ACC_Validity,
    R_ACC_Disengaging,
    R_ACC_Moving_Engaging,
    R_ACC_OrientingTime,
    R_ACC_FlankerConflict,
    R_ACC_LocationConflict,
    R_ACC_FlankerByLocation,
    R_ACC_AlertingByFlanker,
    R_ACC_OrientingByFlanker,
    R_ACC_ValidityByFlanker,
    R_ACC_AlertingByLocation,
    R_ACC_OrientingByLocation,
    R_ACC_ValidityByLocation,
    R_ACC_IOR,
    R_ACC_NC_FCLC,
    R_ACC_NC_FICLC,
    R_ACC_NC_FCLIC,
    R_ACC_NC_FICLIC,
    R_ACC_DC_0_FCLC,
    R_ACC_DC_0_FICLC,
    R_ACC_DC_0_FCLIC,
    R_ACC_DC_0_FICLIC,
    R_ACC_DC_400_FCLC,
    R_ACC_DC_400_FICLC,
    R_ACC_DC_400_FCLIC,
    R_ACC_DC_400_FICLIC,
    R_ACC_DC_800_FCLC,
    R_ACC_DC_800_FICLC,
    R_ACC_DC_800_FCLIC,
    R_ACC_DC_800_FICLIC,
    R_ACC_VC_0_FCLC,
    R_ACC_VC_0_FICLC,
    R_ACC_VC_0_FCLIC,
    R_ACC_VC_0_FICLIC,
    R_ACC_VC_400_FCLC,
    R_ACC_VC_400_FICLC,
    R_ACC_VC_400_FCLIC,
    R_ACC_VC_400_FICLIC,
    R_ACC_VC_800_FCLC,
    R_ACC_VC_800_FICLC,
    R_ACC_VC_800_FCLIC,
    R_ACC_VC_800_FICLIC,
    R_ACC_IVC_0_FCLC,
    R_ACC_IVC_0_FICLC,
    R_ACC_IVC_0_FCLIC,
    R_ACC_IVC_0_FICLIC,
    R_ACC_IVC_400_FCLC,
    R_ACC_IVC_400_FICLC,
    R_ACC_IVC_400_FCLIC,
    R_ACC_IVC_400_FICLIC,
    R_ACC_IVC_800_FCLC,
    R_ACC_IVC_800_FICLC,
    R_ACC_IVC_800_FCLIC,
    R_ACC_IVC_800_FICLIC,
    VR_RT,
    VR_RT_NC,
    VR_RT_DC,
    VR_RT_VC,
    VR_RT_IVC,
    VR_RT_VC_0,
    VR_RT_VC_400,
    VR_RT_VC_800,
    VR_RT_IVC_0,
    VR_RT_IVC_400,
    VR_RT_IVC_800,
    VR_RT_FC,
    VR_RT_FC_0,
    VR_RT_FC_400,
    VR_RT_FC_800,
    VR_RT_FIC,
    VR_RT_FIC_0,
    VR_RT_FIC_400,
    VR_RT_FIC_800,
    VR_RT_LC,
    VR_RT_LC_0,
    VR_RT_LC_400,
    VR_RT_LC_800,
    VR_RT_LIC,
    VR_RT_LIC_0,
    VR_RT_LIC_400,
    VR_RT_LIC_800,
    VR_RT_FC_LC,
    VR_RT_FC_LIC,
    VR_RT_FIC_LC,
    VR_RT_FIC_LIC,
    VR_RT_DC_FC,
    VR_RT_DC_FIC,
    VR_RT_VC_FC,
    VR_RT_VC_FIC,
    VR_RT_IVC_FC,
    VR_RT_IVC_FIC,
    VR_RT_NC_FC,
    VR_RT_NC_FIC,
    VR_RT_NC_LC,
    VR_RT_NC_LIC,
    VR_RT_DC_LC,
    VR_RT_DC_LIC,
    VR_RT_VC_LC,
    VR_RT_VC_LIC,
    VR_RT_IVC_LC,
    VR_RT_IVC_LIC,
    VR_RT_DC_0,
    VR_RT_DC_0_FC,
    VR_RT_DC_0_FIC,
    VR_RT_DC_0_LC,
    VR_RT_DC_0_LIC,
    VR_RT_DC_400,
    VR_RT_DC_400_FC,
    VR_RT_DC_400_FIC,
    VR_RT_DC_400_LC,
    VR_RT_DC_400_LIC,
    VR_RT_DC_800,
    VR_RT_DC_800_FC,
    VR_RT_DC_800_FIC,
    VR_RT_DC_800_LC,
    VR_RT_DC_800_LIC,
    VR_RT_Alerting,
    VR_RT_Validity,
    VR_RT_Disengaging,
    VR_RT_Moving_Engaging,
    VR_RT_OrientingTime,
    VR_RT_FlankerConflict,
    VR_RT_LocationConflict,
    VR_RT_FlankerByLocation,
    VR_RT_AlertingByFlanker,
    VR_RT_OrientingByFlanker,
    VR_RT_ValidityByFlanker,
    VR_RT_AlertingByLocation,
    VR_RT_OrientingByLocation,
    VR_RT_ValidityByLocation,
    VR_RT_IOR,
    VR_RT_NC_FCLC,
    VR_RT_NC_FICLC,
    VR_RT_NC_FCLIC,
    VR_RT_NC_FICLIC,
    VR_RT_DC_0_FCLC,
    VR_RT_DC_0_FICLC,
    VR_RT_DC_0_FCLIC,
    VR_RT_DC_0_FICLIC,
    VR_RT_DC_400_FCLC,
    VR_RT_DC_400_FICLC,
    VR_RT_DC_400_FCLIC,
    VR_RT_DC_400_FICLIC,
    VR_RT_DC_800_FCLC,
    VR_RT_DC_800_FICLC,
    VR_RT_DC_800_FCLIC,
    VR_RT_DC_800_FICLIC,
    VR_RT_VC_0_FCLC,
    VR_RT_VC_0_FICLC,
    VR_RT_VC_0_FCLIC,
    VR_RT_VC_0_FICLIC,
    VR_RT_VC_400_FCLC,
    VR_RT_VC_400_FICLC,
    VR_RT_VC_400_FCLIC,
    VR_RT_VC_400_FICLIC,
    VR_RT_VC_800_FCLC,
    VR_RT_VC_800_FICLC,
    VR_RT_VC_800_FCLIC,
    VR_RT_VC_800_FICLIC,
    VR_RT_IVC_0_FCLC,
    VR_RT_IVC_0_FICLC,
    VR_RT_IVC_0_FCLIC,
    VR_RT_IVC_0_FICLIC,
    VR_RT_IVC_400_FCLC,
    VR_RT_IVC_400_FICLC,
    VR_RT_IVC_400_FCLIC,
    VR_RT_IVC_400_FICLIC,
    VR_RT_IVC_800_FCLC,
    VR_RT_IVC_800_FICLC,
    VR_RT_IVC_800_FCLIC,
    VR_RT_IVC_800_FICLIC,
    VR_ACC,
    VR_ACC_NC,
    VR_ACC_DC,
    VR_ACC_VC,
    VR_ACC_IVC,
    VR_ACC_VC_0,
    VR_ACC_VC_400,
    VR_ACC_VC_800,
    VR_ACC_IVC_0,
    VR_ACC_IVC_400,
    VR_ACC_IVC_800,
    VR_ACC_FC,
    VR_ACC_FC_0,
    VR_ACC_FC_400,
    VR_ACC_FC_800,
    VR_ACC_FIC,
    VR_ACC_FIC_0,
    VR_ACC_FIC_400,
    VR_ACC_FIC_800,
    VR_ACC_LC,
    VR_ACC_LC_0,
    VR_ACC_LC_400,
    VR_ACC_LC_800,
    VR_ACC_LIC,
    VR_ACC_LIC_0,
    VR_ACC_LIC_400,
    VR_ACC_LIC_800,
    VR_ACC_FC_LC,
    VR_ACC_FC_LIC,
    VR_ACC_FIC_LC,
    VR_ACC_FIC_LIC,
    VR_ACC_DC_FC,
    VR_ACC_DC_FIC,
    VR_ACC_VC_FC,
    VR_ACC_VC_FIC,
    VR_ACC_IVC_FC,
    VR_ACC_IVC_FIC,
    VR_ACC_NC_FC,
    VR_ACC_NC_FIC,
    VR_ACC_NC_LC,
    VR_ACC_NC_LIC,
    VR_ACC_DC_LC,
    VR_ACC_DC_LIC,
    VR_ACC_VC_LC,
    VR_ACC_VC_LIC,
    VR_ACC_IVC_LC,
    VR_ACC_IVC_LIC,
    VR_ACC_DC_0,
    VR_ACC_DC_0_FC,
    VR_ACC_DC_0_FIC,
    VR_ACC_DC_0_LC,
    VR_ACC_DC_0_LIC,
    VR_ACC_DC_400,
    VR_ACC_DC_400_FC,
    VR_ACC_DC_400_FIC,
    VR_ACC_DC_400_LC,
    VR_ACC_DC_400_LIC,
    VR_ACC_DC_800,
    VR_ACC_DC_800_FC,
    VR_ACC_DC_800_FIC,
    VR_ACC_DC_800_LC,
    VR_ACC_DC_800_LIC,
    VR_ACC_Alerting,
    VR_ACC_Validity,
    VR_ACC_Disengaging,
    VR_ACC_Moving_Engaging,
    VR_ACC_OrientingTime,
    VR_ACC_FlankerConflict,
    VR_ACC_LocationConflict,
    VR_ACC_FlankerByLocation,
    VR_ACC_AlertingByFlanker,
    VR_ACC_OrientingByFlanker,
    VR_ACC_ValidityByFlanker,
    VR_ACC_AlertingByLocation,
    VR_ACC_OrientingByLocation,
    VR_ACC_ValidityByLocation,
    VR_ACC_IOR,
    VR_ACC_NC_FCLC,
    VR_ACC_NC_FICLC,
    VR_ACC_NC_FCLIC,
    VR_ACC_NC_FICLIC,
    VR_ACC_DC_0_FCLC,
    VR_ACC_DC_0_FICLC,
    VR_ACC_DC_0_FCLIC,
    VR_ACC_DC_0_FICLIC,
    VR_ACC_DC_400_FCLC,
    VR_ACC_DC_400_FICLC,
    VR_ACC_DC_400_FCLIC,
    VR_ACC_DC_400_FICLIC,
    VR_ACC_DC_800_FCLC,
    VR_ACC_DC_800_FICLC,
    VR_ACC_DC_800_FCLIC,
    VR_ACC_DC_800_FICLIC,
    VR_ACC_VC_0_FCLC,
    VR_ACC_VC_0_FICLC,
    VR_ACC_VC_0_FCLIC,
    VR_ACC_VC_0_FICLIC,
    VR_ACC_VC_400_FCLC,
    VR_ACC_VC_400_FICLC,
    VR_ACC_VC_400_FCLIC,
    VR_ACC_VC_400_FICLIC,
    VR_ACC_VC_800_FCLC,
    VR_ACC_VC_800_FICLC,
    VR_ACC_VC_800_FCLIC,
    VR_ACC_VC_800_FICLIC,
    VR_ACC_IVC_0_FCLC,
    VR_ACC_IVC_0_FICLC,
    VR_ACC_IVC_0_FCLIC,
    VR_ACC_IVC_0_FICLIC,
    VR_ACC_IVC_400_FCLC,
    VR_ACC_IVC_400_FICLC,
    VR_ACC_IVC_400_FCLIC,
    VR_ACC_IVC_400_FICLIC,
    VR_ACC_IVC_800_FCLC,
    VR_ACC_IVC_800_FICLC,
    VR_ACC_IVC_800_FCLIC,
    VR_ACC_IVC_800_FICLIC,
    VR_B_RT,
    VR_B_RT_NC,
    VR_B_RT_DC,
    VR_B_RT_VC,
    VR_B_RT_IVC,
    VR_B_RT_VC_0,
    VR_B_RT_VC_400,
    VR_B_RT_VC_800,
    VR_B_RT_IVC_0,
    VR_B_RT_IVC_400,
    VR_B_RT_IVC_800,
    VR_B_RT_FC,
    VR_B_RT_FC_0,
    VR_B_RT_FC_400,
    VR_B_RT_FC_800,
    VR_B_RT_FIC,
    VR_B_RT_FIC_0,
    VR_B_RT_FIC_400,
    VR_B_RT_FIC_800,
    VR_B_RT_LC,
    VR_B_RT_LC_0,
    VR_B_RT_LC_400,
    VR_B_RT_LC_800,
    VR_B_RT_LIC,
    VR_B_RT_LIC_0,
    VR_B_RT_LIC_400,
    VR_B_RT_LIC_800,
    VR_B_RT_FC_LC,
    VR_B_RT_FC_LIC,
    VR_B_RT_FIC_LC,
    VR_B_RT_FIC_LIC,
    VR_B_RT_DC_FC,
    VR_B_RT_DC_FIC,
    VR_B_RT_VC_FC,
    VR_B_RT_VC_FIC,
    VR_B_RT_IVC_FC,
    VR_B_RT_IVC_FIC,
    VR_B_RT_NC_FC,
    VR_B_RT_NC_FIC,
    VR_B_RT_NC_LC,
    VR_B_RT_NC_LIC,
    VR_B_RT_DC_LC,
    VR_B_RT_DC_LIC,
    VR_B_RT_VC_LC,
    VR_B_RT_VC_LIC,
    VR_B_RT_IVC_LC,
    VR_B_RT_IVC_LIC,
    VR_B_RT_DC_0,
    VR_B_RT_DC_0_FC,
    VR_B_RT_DC_0_FIC,
    VR_B_RT_DC_0_LC,
    VR_B_RT_DC_0_LIC,
    VR_B_RT_DC_400,
    VR_B_RT_DC_400_FC,
    VR_B_RT_DC_400_FIC,
    VR_B_RT_DC_400_LC,
    VR_B_RT_DC_400_LIC,
    VR_B_RT_DC_800,
    VR_B_RT_DC_800_FC,
    VR_B_RT_DC_800_FIC,
    VR_B_RT_DC_800_LC,
    VR_B_RT_DC_800_LIC,
    VR_B_RT_Alerting,
    VR_B_RT_Validity,
    VR_B_RT_Disengaging,
    VR_B_RT_Moving_Engaging,
    VR_B_RT_OrientingTime,
    VR_B_RT_FlankerConflict,
    VR_B_RT_LocationConflict,
    VR_B_RT_FlankerByLocation,
    VR_B_RT_AlertingByFlanker,
    VR_B_RT_OrientingByFlanker,
    VR_B_RT_ValidityByFlanker,
    VR_B_RT_AlertingByLocation,
    VR_B_RT_OrientingByLocation,
    VR_B_RT_ValidityByLocation,
    VR_B_RT_IOR,
    VR_B_RT_NC_FCLC,
    VR_B_RT_NC_FICLC,
    VR_B_RT_NC_FCLIC,
    VR_B_RT_NC_FICLIC,
    VR_B_RT_DC_0_FCLC,
    VR_B_RT_DC_0_FICLC,
    VR_B_RT_DC_0_FCLIC,
    VR_B_RT_DC_0_FICLIC,
    VR_B_RT_DC_400_FCLC,
    VR_B_RT_DC_400_FICLC,
    VR_B_RT_DC_400_FCLIC,
    VR_B_RT_DC_400_FICLIC,
    VR_B_RT_DC_800_FCLC,
    VR_B_RT_DC_800_FICLC,
    VR_B_RT_DC_800_FCLIC,
    VR_B_RT_DC_800_FICLIC,
    VR_B_RT_VC_0_FCLC,
    VR_B_RT_VC_0_FICLC,
    VR_B_RT_VC_0_FCLIC,
    VR_B_RT_VC_0_FICLIC,
    VR_B_RT_VC_400_FCLC,
    VR_B_RT_VC_400_FICLC,
    VR_B_RT_VC_400_FCLIC,
    VR_B_RT_VC_400_FICLIC,
    VR_B_RT_VC_800_FCLC,
    VR_B_RT_VC_800_FICLC,
    VR_B_RT_VC_800_FCLIC,
    VR_B_RT_VC_800_FICLIC,
    VR_B_RT_IVC_0_FCLC,
    VR_B_RT_IVC_0_FICLC,
    VR_B_RT_IVC_0_FCLIC,
    VR_B_RT_IVC_0_FICLIC,
    VR_B_RT_IVC_400_FCLC,
    VR_B_RT_IVC_400_FICLC,
    VR_B_RT_IVC_400_FCLIC,
    VR_B_RT_IVC_400_FICLIC,
    VR_B_RT_IVC_800_FCLC,
    VR_B_RT_IVC_800_FICLC,
    VR_B_RT_IVC_800_FCLIC,
    VR_B_RT_IVC_800_FICLIC,
    VR_B_ACC,
    VR_B_ACC_NC,
    VR_B_ACC_DC,
    VR_B_ACC_VC,
    VR_B_ACC_IVC,
    VR_B_ACC_VC_0,
    VR_B_ACC_VC_400,
    VR_B_ACC_VC_800,
    VR_B_ACC_IVC_0,
    VR_B_ACC_IVC_400,
    VR_B_ACC_IVC_800,
    VR_B_ACC_FC,
    VR_B_ACC_FC_0,
    VR_B_ACC_FC_400,
    VR_B_ACC_FC_800,
    VR_B_ACC_FIC,
    VR_B_ACC_FIC_0,
    VR_B_ACC_FIC_400,
    VR_B_ACC_FIC_800,
    VR_B_ACC_LC,
    VR_B_ACC_LC_0,
    VR_B_ACC_LC_400,
    VR_B_ACC_LC_800,
    VR_B_ACC_LIC,
    VR_B_ACC_LIC_0,
    VR_B_ACC_LIC_400,
    VR_B_ACC_LIC_800,
    VR_B_ACC_FC_LC,
    VR_B_ACC_FC_LIC,
    VR_B_ACC_FIC_LC,
    VR_B_ACC_FIC_LIC,
    VR_B_ACC_DC_FC,
    VR_B_ACC_DC_FIC,
    VR_B_ACC_VC_FC,
    VR_B_ACC_VC_FIC,
    VR_B_ACC_IVC_FC,
    VR_B_ACC_IVC_FIC,
    VR_B_ACC_NC_FC,
    VR_B_ACC_NC_FIC,
    VR_B_ACC_NC_LC,
    VR_B_ACC_NC_LIC,
    VR_B_ACC_DC_LC,
    VR_B_ACC_DC_LIC,
    VR_B_ACC_VC_LC,
    VR_B_ACC_VC_LIC,
    VR_B_ACC_IVC_LC,
    VR_B_ACC_IVC_LIC,
    VR_B_ACC_DC_0,
    VR_B_ACC_DC_0_FC,
    VR_B_ACC_DC_0_FIC,
    VR_B_ACC_DC_0_LC,
    VR_B_ACC_DC_0_LIC,
    VR_B_ACC_DC_400,
    VR_B_ACC_DC_400_FC,
    VR_B_ACC_DC_400_FIC,
    VR_B_ACC_DC_400_LC,
    VR_B_ACC_DC_400_LIC,
    VR_B_ACC_DC_800,
    VR_B_ACC_DC_800_FC,
    VR_B_ACC_DC_800_FIC,
    VR_B_ACC_DC_800_LC,
    VR_B_ACC_DC_800_LIC,
    VR_B_ACC_Alerting,
    VR_B_ACC_Validity,
    VR_B_ACC_Disengaging,
    VR_B_ACC_Moving_Engaging,
    VR_B_ACC_OrientingTime,
    VR_B_ACC_FlankerConflict,
    VR_B_ACC_LocationConflict,
    VR_B_ACC_FlankerByLocation,
    VR_B_ACC_AlertingByFlanker,
    VR_B_ACC_OrientingByFlanker,
    VR_B_ACC_ValidityByFlanker,
    VR_B_ACC_AlertingByLocation,
    VR_B_ACC_OrientingByLocation,
    VR_B_ACC_ValidityByLocation,
    VR_B_ACC_IOR,
    VR_B_ACC_NC_FCLC,
    VR_B_ACC_NC_FICLC,
    VR_B_ACC_NC_FCLIC,
    VR_B_ACC_NC_FICLIC,
    VR_B_ACC_DC_0_FCLC,
    VR_B_ACC_DC_0_FICLC,
    VR_B_ACC_DC_0_FCLIC,
    VR_B_ACC_DC_0_FICLIC,
    VR_B_ACC_DC_400_FCLC,
    VR_B_ACC_DC_400_FICLC,
    VR_B_ACC_DC_400_FCLIC,
    VR_B_ACC_DC_400_FICLIC,
    VR_B_ACC_DC_800_FCLC,
    VR_B_ACC_DC_800_FICLC,
    VR_B_ACC_DC_800_FCLIC,
    VR_B_ACC_DC_800_FICLIC,
    VR_B_ACC_VC_0_FCLC,
    VR_B_ACC_VC_0_FICLC,
    VR_B_ACC_VC_0_FCLIC,
    VR_B_ACC_VC_0_FICLIC,
    VR_B_ACC_VC_400_FCLC,
    VR_B_ACC_VC_400_FICLC,
    VR_B_ACC_VC_400_FCLIC,
    VR_B_ACC_VC_400_FICLIC,
    VR_B_ACC_VC_800_FCLC,
    VR_B_ACC_VC_800_FICLC,
    VR_B_ACC_VC_800_FCLIC,
    VR_B_ACC_VC_800_FICLIC,
    VR_B_ACC_IVC_0_FCLC,
    VR_B_ACC_IVC_0_FICLC,
    VR_B_ACC_IVC_0_FCLIC,
    VR_B_ACC_IVC_0_FICLIC,
    VR_B_ACC_IVC_400_FCLC,
    VR_B_ACC_IVC_400_FICLC,
    VR_B_ACC_IVC_400_FCLIC,
    VR_B_ACC_IVC_400_FICLIC,
    VR_B_ACC_IVC_800_FCLC,
    VR_B_ACC_IVC_800_FICLC,
    VR_B_ACC_IVC_800_FCLIC,
    VR_B_ACC_IVC_800_FICLIC
  )
}

getResults <- function(demographicsAndQoE,
                       ANT_R_Results,
                       ANT_VR_Results,
                       ANT_VR_B_Results) {
  if (!require(dplyr)) {
    install.packages("dplyr")
  }
  library(dplyr)

  allResults <- data.frame()

  for (i in 1:nrow(demographicsAndQoE))
  {
    pResults <- getParticipantResultsVector(
      demographicsAndQoE[i, ],
      ANT_R_Results[[i]],
      ANT_VR_Results[[i]],
      ANT_VR_B_Results[[i]]
    )
    allResults <- rbind(allResults, pResults)
  }

  colnames(allResults) <- c(
    "Id",
    "Age",
    "Gender",
    "GenderNumeric",
    "Education",
    "EducationNumeric",
    "Nationality",
    "NationalityNumeric",
    "Handedness",
    "HandednessNumeric",
    "TimeOfDay",
    "TimeOfDayNumeric",
    "QoE_PQ",
    "QoE_RQ",
    "QoE_TQ",
    "QoE_CQ",
    "QoE_IQ",
    "QoE_OQ",
    "QoE_Sum",
    "R_RT",
    "R_RT_NC",
    "R_RT_DC",
    "R_RT_VC",
    "R_RT_IVC",
    "R_RT_VC_0",
    "R_RT_VC_400",
    "R_RT_VC_800",
    "R_RT_IVC_0",
    "R_RT_IVC_400",
    "R_RT_IVC_800",
    "R_RT_FC",
    "R_RT_FC_0",
    "R_RT_FC_400",
    "R_RT_FC_800",
    "R_RT_FIC",
    "R_RT_FIC_0",
    "R_RT_FIC_400",
    "R_RT_FIC_800",
    "R_RT_LC",
    "R_RT_LC_0",
    "R_RT_LC_400",
    "R_RT_LC_800",
    "R_RT_LIC",
    "R_RT_LIC_0",
    "R_RT_LIC_400",
    "R_RT_LIC_800",
    "R_RT_FC_LC",
    "R_RT_FC_LIC",
    "R_RT_FIC_LC",
    "R_RT_FIC_LIC",
    "R_RT_DC_FC",
    "R_RT_DC_FIC",
    "R_RT_VC_FC",
    "R_RT_VC_FIC",
    "R_RT_IVC_FC",
    "R_RT_IVC_FIC",
    "R_RT_NC_FC",
    "R_RT_NC_FIC",
    "R_RT_NC_LC",
    "R_RT_NC_LIC",
    "R_RT_DC_LC",
    "R_RT_DC_LIC",
    "R_RT_VC_LC",
    "R_RT_VC_LIC",
    "R_RT_IVC_LC",
    "R_RT_IVC_LIC",
    "R_RT_DC_0",
    "R_RT_DC_0_FC",
    "R_RT_DC_0_FIC",
    "R_RT_DC_0_LC",
    "R_RT_DC_0_LIC",
    "R_RT_DC_400",
    "R_RT_DC_400_FC",
    "R_RT_DC_400_FIC",
    "R_RT_DC_400_LC",
    "R_RT_DC_400_LIC",
    "R_RT_DC_800",
    "R_RT_DC_800_FC",
    "R_RT_DC_800_FIC",
    "R_RT_DC_800_LC",
    "R_RT_DC_800_LIC",
    "R_RT_Alerting",
    "R_RT_Validity",
    "R_RT_Disengaging",
    "R_RT_Moving_Engaging",
    "R_RT_OrientingTime",
    "R_RT_FlankerConflict",
    "R_RT_LocationConflict",
    "R_RT_FlankerByLocation",
    "R_RT_AlertingByFlanker",
    "R_RT_OrientingByFlanker",
    "R_RT_ValidityByFlanker",
    "R_RT_AlertingByLocation",
    "R_RT_OrientingByLocation",
    "R_RT_ValidityByLocation",
    "R_RT_IOR",
    "R_RT_NC_FCLC",
    "R_RT_NC_FICLC",
    "R_RT_NC_FCLIC",
    "R_RT_NC_FICLIC",
    "R_RT_DC_0_FCLC",
    "R_RT_DC_0_FICLC",
    "R_RT_DC_0_FCLIC",
    "R_RT_DC_0_FICLIC",
    "R_RT_DC_400_FCLC",
    "R_RT_DC_400_FICLC",
    "R_RT_DC_400_FCLIC",
    "R_RT_DC_400_FICLIC",
    "R_RT_DC_800_FCLC",
    "R_RT_DC_800_FICLC",
    "R_RT_DC_800_FCLIC",
    "R_RT_DC_800_FICLIC",
    "R_RT_VC_0_FCLC",
    "R_RT_VC_0_FICLC",
    "R_RT_VC_0_FCLIC",
    "R_RT_VC_0_FICLIC",
    "R_RT_VC_400_FCLC",
    "R_RT_VC_400_FICLC",
    "R_RT_VC_400_FCLIC",
    "R_RT_VC_400_FICLIC",
    "R_RT_VC_800_FCLC",
    "R_RT_VC_800_FICLC",
    "R_RT_VC_800_FCLIC",
    "R_RT_VC_800_FICLIC",
    "R_RT_IVC_0_FCLC",
    "R_RT_IVC_0_FICLC",
    "R_RT_IVC_0_FCLIC",
    "R_RT_IVC_0_FICLIC",
    "R_RT_IVC_400_FCLC",
    "R_RT_IVC_400_FICLC",
    "R_RT_IVC_400_FCLIC",
    "R_RT_IVC_400_FICLIC",
    "R_RT_IVC_800_FCLC",
    "R_RT_IVC_800_FICLC",
    "R_RT_IVC_800_FCLIC",
    "R_RT_IVC_800_FICLIC",
    "R_ACC",
    "R_ACC_NC",
    "R_ACC_DC",
    "R_ACC_VC",
    "R_ACC_IVC",
    "R_ACC_VC_0",
    "R_ACC_VC_400",
    "R_ACC_VC_800",
    "R_ACC_IVC_0",
    "R_ACC_IVC_400",
    "R_ACC_IVC_800",
    "R_ACC_FC",
    "R_ACC_FC_0",
    "R_ACC_FC_400",
    "R_ACC_FC_800",
    "R_ACC_FIC",
    "R_ACC_FIC_0",
    "R_ACC_FIC_400",
    "R_ACC_FIC_800",
    "R_ACC_LC",
    "R_ACC_LC_0",
    "R_ACC_LC_400",
    "R_ACC_LC_800",
    "R_ACC_LIC",
    "R_ACC_LIC_0",
    "R_ACC_LIC_400",
    "R_ACC_LIC_800",
    "R_ACC_FC_LC",
    "R_ACC_FC_LIC",
    "R_ACC_FIC_LC",
    "R_ACC_FIC_LIC",
    "R_ACC_DC_FC",
    "R_ACC_DC_FIC",
    "R_ACC_VC_FC",
    "R_ACC_VC_FIC",
    "R_ACC_IVC_FC",
    "R_ACC_IVC_FIC",
    "R_ACC_NC_FC",
    "R_ACC_NC_FIC",
    "R_ACC_NC_LC",
    "R_ACC_NC_LIC",
    "R_ACC_DC_LC",
    "R_ACC_DC_LIC",
    "R_ACC_VC_LC",
    "R_ACC_VC_LIC",
    "R_ACC_IVC_LC",
    "R_ACC_IVC_LIC",
    "R_ACC_DC_0",
    "R_ACC_DC_0_FC",
    "R_ACC_DC_0_FIC",
    "R_ACC_DC_0_LC",
    "R_ACC_DC_0_LIC",
    "R_ACC_DC_400",
    "R_ACC_DC_400_FC",
    "R_ACC_DC_400_FIC",
    "R_ACC_DC_400_LC",
    "R_ACC_DC_400_LIC",
    "R_ACC_DC_800",
    "R_ACC_DC_800_FC",
    "R_ACC_DC_800_FIC",
    "R_ACC_DC_800_LC",
    "R_ACC_DC_800_LIC",
    "R_ACC_Alerting",
    "R_ACC_Validity",
    "R_ACC_Disengaging",
    "R_ACC_Moving_Engaging",
    "R_ACC_OrientingTime",
    "R_ACC_FlankerConflict",
    "R_ACC_LocationConflict",
    "R_ACC_FlankerByLocation",
    "R_ACC_AlertingByFlanker",
    "R_ACC_OrientingByFlanker",
    "R_ACC_ValidityByFlanker",
    "R_ACC_AlertingByLocation",
    "R_ACC_OrientingByLocation",
    "R_ACC_ValidityByLocation",
    "R_ACC_IOR",
    "R_ACC_NC_FCLC",
    "R_ACC_NC_FICLC",
    "R_ACC_NC_FCLIC",
    "R_ACC_NC_FICLIC",
    "R_ACC_DC_0_FCLC",
    "R_ACC_DC_0_FICLC",
    "R_ACC_DC_0_FCLIC",
    "R_ACC_DC_0_FICLIC",
    "R_ACC_DC_400_FCLC",
    "R_ACC_DC_400_FICLC",
    "R_ACC_DC_400_FCLIC",
    "R_ACC_DC_400_FICLIC",
    "R_ACC_DC_800_FCLC",
    "R_ACC_DC_800_FICLC",
    "R_ACC_DC_800_FCLIC",
    "R_ACC_DC_800_FICLIC",
    "R_ACC_VC_0_FCLC",
    "R_ACC_VC_0_FICLC",
    "R_ACC_VC_0_FCLIC",
    "R_ACC_VC_0_FICLIC",
    "R_ACC_VC_400_FCLC",
    "R_ACC_VC_400_FICLC",
    "R_ACC_VC_400_FCLIC",
    "R_ACC_VC_400_FICLIC",
    "R_ACC_VC_800_FCLC",
    "R_ACC_VC_800_FICLC",
    "R_ACC_VC_800_FCLIC",
    "R_ACC_VC_800_FICLIC",
    "R_ACC_IVC_0_FCLC",
    "R_ACC_IVC_0_FICLC",
    "R_ACC_IVC_0_FCLIC",
    "R_ACC_IVC_0_FICLIC",
    "R_ACC_IVC_400_FCLC",
    "R_ACC_IVC_400_FICLC",
    "R_ACC_IVC_400_FCLIC",
    "R_ACC_IVC_400_FICLIC",
    "R_ACC_IVC_800_FCLC",
    "R_ACC_IVC_800_FICLC",
    "R_ACC_IVC_800_FCLIC",
    "R_ACC_IVC_800_FICLIC",
    "VR_RT",
    "VR_RT_NC",
    "VR_RT_DC",
    "VR_RT_VC",
    "VR_RT_IVC",
    "VR_RT_VC_0",
    "VR_RT_VC_400",
    "VR_RT_VC_800",
    "VR_RT_IVC_0",
    "VR_RT_IVC_400",
    "VR_RT_IVC_800",
    "VR_RT_FC",
    "VR_RT_FC_0",
    "VR_RT_FC_400",
    "VR_RT_FC_800",
    "VR_RT_FIC",
    "VR_RT_FIC_0",
    "VR_RT_FIC_400",
    "VR_RT_FIC_800",
    "VR_RT_LC",
    "VR_RT_LC_0",
    "VR_RT_LC_400",
    "VR_RT_LC_800",
    "VR_RT_LIC",
    "VR_RT_LIC_0",
    "VR_RT_LIC_400",
    "VR_RT_LIC_800",
    "VR_RT_FC_LC",
    "VR_RT_FC_LIC",
    "VR_RT_FIC_LC",
    "VR_RT_FIC_LIC",
    "VR_RT_DC_FC",
    "VR_RT_DC_FIC",
    "VR_RT_VC_FC",
    "VR_RT_VC_FIC",
    "VR_RT_IVC_FC",
    "VR_RT_IVC_FIC",
    "VR_RT_NC_FC",
    "VR_RT_NC_FIC",
    "VR_RT_NC_LC",
    "VR_RT_NC_LIC",
    "VR_RT_DC_LC",
    "VR_RT_DC_LIC",
    "VR_RT_VC_LC",
    "VR_RT_VC_LIC",
    "VR_RT_IVC_LC",
    "VR_RT_IVC_LIC",
    "VR_RT_DC_0",
    "VR_RT_DC_0_FC",
    "VR_RT_DC_0_FIC",
    "VR_RT_DC_0_LC",
    "VR_RT_DC_0_LIC",
    "VR_RT_DC_400",
    "VR_RT_DC_400_FC",
    "VR_RT_DC_400_FIC",
    "VR_RT_DC_400_LC",
    "VR_RT_DC_400_LIC",
    "VR_RT_DC_800",
    "VR_RT_DC_800_FC",
    "VR_RT_DC_800_FIC",
    "VR_RT_DC_800_LC",
    "VR_RT_DC_800_LIC",
    "VR_RT_Alerting",
    "VR_RT_Validity",
    "VR_RT_Disengaging",
    "VR_RT_Moving_Engaging",
    "VR_RT_OrientingTime",
    "VR_RT_FlankerConflict",
    "VR_RT_LocationConflict",
    "VR_RT_FlankerByLocation",
    "VR_RT_AlertingByFlanker",
    "VR_RT_OrientingByFlanker",
    "VR_RT_ValidityByFlanker",
    "VR_RT_AlertingByLocation",
    "VR_RT_OrientingByLocation",
    "VR_RT_ValidityByLocation",
    "VR_RT_IOR",
    "VR_RT_NC_FCLC",
    "VR_RT_NC_FICLC",
    "VR_RT_NC_FCLIC",
    "VR_RT_NC_FICLIC",
    "VR_RT_DC_0_FCLC",
    "VR_RT_DC_0_FICLC",
    "VR_RT_DC_0_FCLIC",
    "VR_RT_DC_0_FICLIC",
    "VR_RT_DC_400_FCLC",
    "VR_RT_DC_400_FICLC",
    "VR_RT_DC_400_FCLIC",
    "VR_RT_DC_400_FICLIC",
    "VR_RT_DC_800_FCLC",
    "VR_RT_DC_800_FICLC",
    "VR_RT_DC_800_FCLIC",
    "VR_RT_DC_800_FICLIC",
    "VR_RT_VC_0_FCLC",
    "VR_RT_VC_0_FICLC",
    "VR_RT_VC_0_FCLIC",
    "VR_RT_VC_0_FICLIC",
    "VR_RT_VC_400_FCLC",
    "VR_RT_VC_400_FICLC",
    "VR_RT_VC_400_FCLIC",
    "VR_RT_VC_400_FICLIC",
    "VR_RT_VC_800_FCLC",
    "VR_RT_VC_800_FICLC",
    "VR_RT_VC_800_FCLIC",
    "VR_RT_VC_800_FICLIC",
    "VR_RT_IVC_0_FCLC",
    "VR_RT_IVC_0_FICLC",
    "VR_RT_IVC_0_FCLIC",
    "VR_RT_IVC_0_FICLIC",
    "VR_RT_IVC_400_FCLC",
    "VR_RT_IVC_400_FICLC",
    "VR_RT_IVC_400_FCLIC",
    "VR_RT_IVC_400_FICLIC",
    "VR_RT_IVC_800_FCLC",
    "VR_RT_IVC_800_FICLC",
    "VR_RT_IVC_800_FCLIC",
    "VR_RT_IVC_800_FICLIC",
    "VR_ACC",
    "VR_ACC_NC",
    "VR_ACC_DC",
    "VR_ACC_VC",
    "VR_ACC_IVC",
    "VR_ACC_VC_0",
    "VR_ACC_VC_400",
    "VR_ACC_VC_800",
    "VR_ACC_IVC_0",
    "VR_ACC_IVC_400",
    "VR_ACC_IVC_800",
    "VR_ACC_FC",
    "VR_ACC_FC_0",
    "VR_ACC_FC_400",
    "VR_ACC_FC_800",
    "VR_ACC_FIC",
    "VR_ACC_FIC_0",
    "VR_ACC_FIC_400",
    "VR_ACC_FIC_800",
    "VR_ACC_LC",
    "VR_ACC_LC_0",
    "VR_ACC_LC_400",
    "VR_ACC_LC_800",
    "VR_ACC_LIC",
    "VR_ACC_LIC_0",
    "VR_ACC_LIC_400",
    "VR_ACC_LIC_800",
    "VR_ACC_FC_LC",
    "VR_ACC_FC_LIC",
    "VR_ACC_FIC_LC",
    "VR_ACC_FIC_LIC",
    "VR_ACC_DC_FC",
    "VR_ACC_DC_FIC",
    "VR_ACC_VC_FC",
    "VR_ACC_VC_FIC",
    "VR_ACC_IVC_FC",
    "VR_ACC_IVC_FIC",
    "VR_ACC_NC_FC",
    "VR_ACC_NC_FIC",
    "VR_ACC_NC_LC",
    "VR_ACC_NC_LIC",
    "VR_ACC_DC_LC",
    "VR_ACC_DC_LIC",
    "VR_ACC_VC_LC",
    "VR_ACC_VC_LIC",
    "VR_ACC_IVC_LC",
    "VR_ACC_IVC_LIC",
    "VR_ACC_DC_0",
    "VR_ACC_DC_0_FC",
    "VR_ACC_DC_0_FIC",
    "VR_ACC_DC_0_LC",
    "VR_ACC_DC_0_LIC",
    "VR_ACC_DC_400",
    "VR_ACC_DC_400_FC",
    "VR_ACC_DC_400_FIC",
    "VR_ACC_DC_400_LC",
    "VR_ACC_DC_400_LIC",
    "VR_ACC_DC_800",
    "VR_ACC_DC_800_FC",
    "VR_ACC_DC_800_FIC",
    "VR_ACC_DC_800_LC",
    "VR_ACC_DC_800_LIC",
    "VR_ACC_Alerting",
    "VR_ACC_Validity",
    "VR_ACC_Disengaging",
    "VR_ACC_Moving_Engaging",
    "VR_ACC_OrientingTime",
    "VR_ACC_FlankerConflict",
    "VR_ACC_LocationConflict",
    "VR_ACC_FlankerByLocation",
    "VR_ACC_AlertingByFlanker",
    "VR_ACC_OrientingByFlanker",
    "VR_ACC_ValidityByFlanker",
    "VR_ACC_AlertingByLocation",
    "VR_ACC_OrientingByLocation",
    "VR_ACC_ValidityByLocation",
    "VR_ACC_IOR",
    "VR_ACC_NC_FCLC",
    "VR_ACC_NC_FICLC",
    "VR_ACC_NC_FCLIC",
    "VR_ACC_NC_FICLIC",
    "VR_ACC_DC_0_FCLC",
    "VR_ACC_DC_0_FICLC",
    "VR_ACC_DC_0_FCLIC",
    "VR_ACC_DC_0_FICLIC",
    "VR_ACC_DC_400_FCLC",
    "VR_ACC_DC_400_FICLC",
    "VR_ACC_DC_400_FCLIC",
    "VR_ACC_DC_400_FICLIC",
    "VR_ACC_DC_800_FCLC",
    "VR_ACC_DC_800_FICLC",
    "VR_ACC_DC_800_FCLIC",
    "VR_ACC_DC_800_FICLIC",
    "VR_ACC_VC_0_FCLC",
    "VR_ACC_VC_0_FICLC",
    "VR_ACC_VC_0_FCLIC",
    "VR_ACC_VC_0_FICLIC",
    "VR_ACC_VC_400_FCLC",
    "VR_ACC_VC_400_FICLC",
    "VR_ACC_VC_400_FCLIC",
    "VR_ACC_VC_400_FICLIC",
    "VR_ACC_VC_800_FCLC",
    "VR_ACC_VC_800_FICLC",
    "VR_ACC_VC_800_FCLIC",
    "VR_ACC_VC_800_FICLIC",
    "VR_ACC_IVC_0_FCLC",
    "VR_ACC_IVC_0_FICLC",
    "VR_ACC_IVC_0_FCLIC",
    "VR_ACC_IVC_0_FICLIC",
    "VR_ACC_IVC_400_FCLC",
    "VR_ACC_IVC_400_FICLC",
    "VR_ACC_IVC_400_FCLIC",
    "VR_ACC_IVC_400_FICLIC",
    "VR_ACC_IVC_800_FCLC",
    "VR_ACC_IVC_800_FICLC",
    "VR_ACC_IVC_800_FCLIC",
    "VR_ACC_IVC_800_FICLIC",
    "VR_B_RT",
    "VR_B_RT_NC",
    "VR_B_RT_DC",
    "VR_B_RT_VC",
    "VR_B_RT_IVC",
    "VR_B_RT_VC_0",
    "VR_B_RT_VC_400",
    "VR_B_RT_VC_800",
    "VR_B_RT_IVC_0",
    "VR_B_RT_IVC_400",
    "VR_B_RT_IVC_800",
    "VR_B_RT_FC",
    "VR_B_RT_FC_0",
    "VR_B_RT_FC_400",
    "VR_B_RT_FC_800",
    "VR_B_RT_FIC",
    "VR_B_RT_FIC_0",
    "VR_B_RT_FIC_400",
    "VR_B_RT_FIC_800",
    "VR_B_RT_LC",
    "VR_B_RT_LC_0",
    "VR_B_RT_LC_400",
    "VR_B_RT_LC_800",
    "VR_B_RT_LIC",
    "VR_B_RT_LIC_0",
    "VR_B_RT_LIC_400",
    "VR_B_RT_LIC_800",
    "VR_B_RT_FC_LC",
    "VR_B_RT_FC_LIC",
    "VR_B_RT_FIC_LC",
    "VR_B_RT_FIC_LIC",
    "VR_B_RT_DC_FC",
    "VR_B_RT_DC_FIC",
    "VR_B_RT_VC_FC",
    "VR_B_RT_VC_FIC",
    "VR_B_RT_IVC_FC",
    "VR_B_RT_IVC_FIC",
    "VR_B_RT_NC_FC",
    "VR_B_RT_NC_FIC",
    "VR_B_RT_NC_LC",
    "VR_B_RT_NC_LIC",
    "VR_B_RT_DC_LC",
    "VR_B_RT_DC_LIC",
    "VR_B_RT_VC_LC",
    "VR_B_RT_VC_LIC",
    "VR_B_RT_IVC_LC",
    "VR_B_RT_IVC_LIC",
    "VR_B_RT_DC_0",
    "VR_B_RT_DC_0_FC",
    "VR_B_RT_DC_0_FIC",
    "VR_B_RT_DC_0_LC",
    "VR_B_RT_DC_0_LIC",
    "VR_B_RT_DC_400",
    "VR_B_RT_DC_400_FC",
    "VR_B_RT_DC_400_FIC",
    "VR_B_RT_DC_400_LC",
    "VR_B_RT_DC_400_LIC",
    "VR_B_RT_DC_800",
    "VR_B_RT_DC_800_FC",
    "VR_B_RT_DC_800_FIC",
    "VR_B_RT_DC_800_LC",
    "VR_B_RT_DC_800_LIC",
    "VR_B_RT_Alerting",
    "VR_B_RT_Validity",
    "VR_B_RT_Disengaging",
    "VR_B_RT_Moving_Engaging",
    "VR_B_RT_OrientingTime",
    "VR_B_RT_FlankerConflict",
    "VR_B_RT_LocationConflict",
    "VR_B_RT_FlankerByLocation",
    "VR_B_RT_AlertingByFlanker",
    "VR_B_RT_OrientingByFlanker",
    "VR_B_RT_ValidityByFlanker",
    "VR_B_RT_AlertingByLocation",
    "VR_B_RT_OrientingByLocation",
    "VR_B_RT_ValidityByLocation",
    "VR_B_RT_IOR",
    "VR_B_RT_NC_FCLC",
    "VR_B_RT_NC_FICLC",
    "VR_B_RT_NC_FCLIC",
    "VR_B_RT_NC_FICLIC",
    "VR_B_RT_DC_0_FCLC",
    "VR_B_RT_DC_0_FICLC",
    "VR_B_RT_DC_0_FCLIC",
    "VR_B_RT_DC_0_FICLIC",
    "VR_B_RT_DC_400_FCLC",
    "VR_B_RT_DC_400_FICLC",
    "VR_B_RT_DC_400_FCLIC",
    "VR_B_RT_DC_400_FICLIC",
    "VR_B_RT_DC_800_FCLC",
    "VR_B_RT_DC_800_FICLC",
    "VR_B_RT_DC_800_FCLIC",
    "VR_B_RT_DC_800_FICLIC",
    "VR_B_RT_VC_0_FCLC",
    "VR_B_RT_VC_0_FICLC",
    "VR_B_RT_VC_0_FCLIC",
    "VR_B_RT_VC_0_FICLIC",
    "VR_B_RT_VC_400_FCLC",
    "VR_B_RT_VC_400_FICLC",
    "VR_B_RT_VC_400_FCLIC",
    "VR_B_RT_VC_400_FICLIC",
    "VR_B_RT_VC_800_FCLC",
    "VR_B_RT_VC_800_FICLC",
    "VR_B_RT_VC_800_FCLIC",
    "VR_B_RT_VC_800_FICLIC",
    "VR_B_RT_IVC_0_FCLC",
    "VR_B_RT_IVC_0_FICLC",
    "VR_B_RT_IVC_0_FCLIC",
    "VR_B_RT_IVC_0_FICLIC",
    "VR_B_RT_IVC_400_FCLC",
    "VR_B_RT_IVC_400_FICLC",
    "VR_B_RT_IVC_400_FCLIC",
    "VR_B_RT_IVC_400_FICLIC",
    "VR_B_RT_IVC_800_FCLC",
    "VR_B_RT_IVC_800_FICLC",
    "VR_B_RT_IVC_800_FCLIC",
    "VR_B_RT_IVC_800_FICLIC",
    "VR_B_ACC",
    "VR_B_ACC_NC",
    "VR_B_ACC_DC",
    "VR_B_ACC_VC",
    "VR_B_ACC_IVC",
    "VR_B_ACC_VC_0",
    "VR_B_ACC_VC_400",
    "VR_B_ACC_VC_800",
    "VR_B_ACC_IVC_0",
    "VR_B_ACC_IVC_400",
    "VR_B_ACC_IVC_800",
    "VR_B_ACC_FC",
    "VR_B_ACC_FC_0",
    "VR_B_ACC_FC_400",
    "VR_B_ACC_FC_800",
    "VR_B_ACC_FIC",
    "VR_B_ACC_FIC_0",
    "VR_B_ACC_FIC_400",
    "VR_B_ACC_FIC_800",
    "VR_B_ACC_LC",
    "VR_B_ACC_LC_0",
    "VR_B_ACC_LC_400",
    "VR_B_ACC_LC_800",
    "VR_B_ACC_LIC",
    "VR_B_ACC_LIC_0",
    "VR_B_ACC_LIC_400",
    "VR_B_ACC_LIC_800",
    "VR_B_ACC_FC_LC",
    "VR_B_ACC_FC_LIC",
    "VR_B_ACC_FIC_LC",
    "VR_B_ACC_FIC_LIC",
    "VR_B_ACC_DC_FC",
    "VR_B_ACC_DC_FIC",
    "VR_B_ACC_VC_FC",
    "VR_B_ACC_VC_FIC",
    "VR_B_ACC_IVC_FC",
    "VR_B_ACC_IVC_FIC",
    "VR_B_ACC_NC_FC",
    "VR_B_ACC_NC_FIC",
    "VR_B_ACC_NC_LC",
    "VR_B_ACC_NC_LIC",
    "VR_B_ACC_DC_LC",
    "VR_B_ACC_DC_LIC",
    "VR_B_ACC_VC_LC",
    "VR_B_ACC_VC_LIC",
    "VR_B_ACC_IVC_LC",
    "VR_B_ACC_IVC_LIC",
    "VR_B_ACC_DC_0",
    "VR_B_ACC_DC_0_FC",
    "VR_B_ACC_DC_0_FIC",
    "VR_B_ACC_DC_0_LC",
    "VR_B_ACC_DC_0_LIC",
    "VR_B_ACC_DC_400",
    "VR_B_ACC_DC_400_FC",
    "VR_B_ACC_DC_400_FIC",
    "VR_B_ACC_DC_400_LC",
    "VR_B_ACC_DC_400_LIC",
    "VR_B_ACC_DC_800",
    "VR_B_ACC_DC_800_FC",
    "VR_B_ACC_DC_800_FIC",
    "VR_B_ACC_DC_800_LC",
    "VR_B_ACC_DC_800_LIC",
    "VR_B_ACC_Alerting",
    "VR_B_ACC_Validity",
    "VR_B_ACC_Disengaging",
    "VR_B_ACC_Moving_Engaging",
    "VR_B_ACC_OrientingTime",
    "VR_B_ACC_FlankerConflict",
    "VR_B_ACC_LocationConflict",
    "VR_B_ACC_FlankerByLocation",
    "VR_B_ACC_AlertingByFlanker",
    "VR_B_ACC_OrientingByFlanker",
    "VR_B_ACC_ValidityByFlanker",
    "VR_B_ACC_AlertingByLocation",
    "VR_B_ACC_OrientingByLocation",
    "VR_B_ACC_ValidityByLocation",
    "VR_B_ACC_IOR",
    "VR_B_ACC_NC_FCLC",
    "VR_B_ACC_NC_FICLC",
    "VR_B_ACC_NC_FCLIC",
    "VR_B_ACC_NC_FICLIC",
    "VR_B_ACC_DC_0_FCLC",
    "VR_B_ACC_DC_0_FICLC",
    "VR_B_ACC_DC_0_FCLIC",
    "VR_B_ACC_DC_0_FICLIC",
    "VR_B_ACC_DC_400_FCLC",
    "VR_B_ACC_DC_400_FICLC",
    "VR_B_ACC_DC_400_FCLIC",
    "VR_B_ACC_DC_400_FICLIC",
    "VR_B_ACC_DC_800_FCLC",
    "VR_B_ACC_DC_800_FICLC",
    "VR_B_ACC_DC_800_FCLIC",
    "VR_B_ACC_DC_800_FICLIC",
    "VR_B_ACC_VC_0_FCLC",
    "VR_B_ACC_VC_0_FICLC",
    "VR_B_ACC_VC_0_FCLIC",
    "VR_B_ACC_VC_0_FICLIC",
    "VR_B_ACC_VC_400_FCLC",
    "VR_B_ACC_VC_400_FICLC",
    "VR_B_ACC_VC_400_FCLIC",
    "VR_B_ACC_VC_400_FICLIC",
    "VR_B_ACC_VC_800_FCLC",
    "VR_B_ACC_VC_800_FICLC",
    "VR_B_ACC_VC_800_FCLIC",
    "VR_B_ACC_VC_800_FICLIC",
    "VR_B_ACC_IVC_0_FCLC",
    "VR_B_ACC_IVC_0_FICLC",
    "VR_B_ACC_IVC_0_FCLIC",
    "VR_B_ACC_IVC_0_FICLIC",
    "VR_B_ACC_IVC_400_FCLC",
    "VR_B_ACC_IVC_400_FICLC",
    "VR_B_ACC_IVC_400_FCLIC",
    "VR_B_ACC_IVC_400_FICLIC",
    "VR_B_ACC_IVC_800_FCLC",
    "VR_B_ACC_IVC_800_FICLC",
    "VR_B_ACC_IVC_800_FCLIC",
    "VR_B_ACC_IVC_800_FICLIC"
  )

  allResults[, c(1, 2, 4, 6, 8, 10, 12:ncol(allResults))] <- sapply(allResults[, c(1, 2, 4, 6, 8, 10, 12:ncol(allResults))], as.numeric)

  results <- allResults
}

getResults_All <- function() {
  demographicsAndQoE <- importDemographicsAndQoE_All()
  ANT_R_Results <- importANT_R_All()
  ANT_VR_Results <- importANT_VR_All()
  ANT_VR_B_Results <- importANT_VR_B_All()

  results <- getResults(
    demographicsAndQoE,
    ANT_R_Results,
    ANT_VR_Results,
    ANT_VR_B_Results
  )
}

exportResults_All <- function() {
  results <- getResults_All()
  write.csv(results,
    getPath("../../../Results/RawResults.csv"),
    row.names = FALSE
  )

  results[, c(20:ncol(results))] <- sapply(results[, c(20:ncol(results))], getRoundedValue)
  write.csv(results,
    getPath("../../../Results/RoundedResults.csv"),
    row.names = FALSE
  )
}


exportResults_All()

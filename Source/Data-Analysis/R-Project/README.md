# README: R Code Structure for Data Analysis

## Introduction
This README file provides an overview of the structure and usage instructions for the R code that has been developed for data analysis. The code is organized into three separate R scripts: DataProcessing.R, DataAnalysis.R, and Output.R. These scripts are designed to be executed in a specific order to perform data processing, analysis, and generate output results. Additionally, this code assumes that the data files are located in a "../../../Data" folder, and results will be written to subfolders within the "../../../Data" directory.

## Order of Execution
To successfully analyze the data, follow these steps in the specified order:

1. **DataProcessing.R**
    - This script is responsible for reading the data from files located in the "Data" folder and performing initial data processing tasks (download the folder from dataverse.nl).
    - It will generate two output CSV files, "RawResults.csv" and "RoundedResults.csv," which will also be placed in the "Data" folder.

2. **DataAnalysis.R**
    - This script is where the primary data analysis takes place. It reads the processed data from "RawResults.csv" and "RoundedResults.csv" in the "Data" folder.
    - The results of the analysis will be written to a subfolder named "Analysis" within the "Data" folder.

3. **Output.R**
    - This script is responsible for creating tables and diagrams based on the analysis results obtained in the previous step.
    - It will generate tables and diagrams and place them in subfolders named "Tables" and "Diagrams" within the "Analysis" subfolder of the "Data" folder.
    - **Note:** To run Output.R, you may need to install a PDF creation package. This code was developed and tested using RStudio on Windows.

## License
Before using or sharing any data in this folder, please read and adhere to the terms and conditions outlined in the "License.txt" file to ensure compliance with any licensing agreements or usage restrictions.

## Support and Contact
For inquiries, questions, or collaboration opportunities, please reach out to us through our GitHub repository or contact us via email at [davidtekampe@icloud.com](mailto:davidtekampe@icloud.com) or [tekampe@outlook.com](mailto:tekampe@outlook.com).

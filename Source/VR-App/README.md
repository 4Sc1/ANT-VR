# ANT-VR Application ReadMe

## Introduction

Welcome to ANT-VR, a Virtual Reality implementation of the Attention Network Test - Revised (ANT-R), designed to run on Meta Quest headsets. This ReadMe provides essential information about our scientific project, its development using the Unity 3D engine, and the guidelines we follow for sharing our work.

## About ANT-VR

ANT-VR represents a novel approach to cognitive assessment, utilizing Virtual Reality to investigate attention and cognitive functions. It builds upon the principles of the Attention Network Test - Revised (ANT-R) and leverages the immersive capabilities of Virtual Reality to provide a unique and ecologically valid assessment experience.

## Development for Meta Quest Headsets

ANT-VR has been developed with a focus on compatibility with Meta Quest headsets, including the Meta Quest 2, Meta Quest Pro, and Meta Quest 3. While it was initially designed for the Meta Quest 2, it runs even better on the Meta Quest Pro and Meta Quest 3.

## Development with Unity 3D Engine

ANT-VR was developed using the Unity 3D engine.

## Folder Structure and Assets

The folder structure with source code and assets was part of the assets folder of the Unity project. Here's a breakdown of the key folders:

1. **Helpers**: This folder contains classes that are used for basic tasks, not specific to the experiment.

2. **Plugins**: The "Plugins" folder contains a compiled version of the LabStreamingLayer library.

3. **Tasks**: Within the "Tasks" folder, you can find the source code and images (which were displayed on the screen in the virtual environment) of the ANT-VR experiment.

## Open Science Standards

Our commitment to Open Science principles means that we aim to make our scientific work as transparent and accessible as possible. In line with these standards, we are pleased to share the following components of ANT-VR:

1. **Source Code**: We provide the complete custom source code for ANT-VR, including scripts, logic, and any code developed by our team for the experiment.

   Where we have used code from third parties, the copyright and licensing information is provided within the source code files.
   
   To the remaining source code, the license stated in the LICENSE.txt file applies. Make sure you understand the terms and conditions of using this code.

2. **Custom Assets**: All assets created by our team and not subject to licensing restrictions are included in the distribution.

3. **Applications**: The three compiled ANT-VR applications ready to be used on Meta Quest headsets.

## Unity Engine and Licensing

Please note that while we adhere to Open Science standards, certain constraints exist:

1. **Unity Engine**: Unity 3D is proprietary software developed by Unity Technologies. We are unable to distribute it, so you will need to obtain it separately from the official Unity website (https://unity.com/).

2. **Third-Party Assets**: ANT-VR relies on third-party assets or libraries with their own licensing terms. We will not share these.

## Data Collection and Analysis

ANT-VR collects and saves assessment results in JSON files on the headset. To facilitate the analysis, copy them to a PC and follow these steps:

1. **Translation**: Run the unit test located in the `Data-Analysis\ResultTranslation` folder to translate the JSON result files into a format suitable for analysis.

2. **Analysis Scripts**: Utilize the analysis scripts provided in the R-project to process and analyze the translated results. These scripts are designed to assist researchers in gaining insights from the data collected during experiments.

## EEG Integration

ANT-VR supports LabStreamingLayer (LSL) and streams event markers. This functionality allows for seamless integration with EEG systems and the synchronization of event markers for enhanced analysis of ANT-VR data in conjunction with EEG results.

## Contribution and Collaboration

While we encourage collaboration and further development of ANT-VR within the scientific community, please respect ethical considerations, data privacy, and Open Science principles when using or modifying the software.

## Support and Contact

For inquiries, questions, or collaboration opportunities, please reach out to us through our GitHub repository or contact us via email at [davidtekampe@icloud.com](mailto:davidtekampe@icloud.com) or [tekampe@outlook.com](mailto:tekampe@outlook.com).

We appreciate your commitment to Open Science and hope that ANT-VR serves as a valuable tool for advancing research in the field of cognitive assessment within the Virtual Reality environment on standalone headsets. Thank you for your interest and support in adhering to Open Science standards.

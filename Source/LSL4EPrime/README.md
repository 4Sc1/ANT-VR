# LSL4EPrime README

Welcome to `LSL4EPrime`, a specialized software component designed to provide support for users with legacy E-Prime 2 licenses. We aim to assist those in need of streaming event markers seamlessly. This README outlines the purpose, features, availability, licensing, and our dedication to Open Science by sharing this software.

## Overview

`LSL4EPrime` is a valuable add-in for E-Prime 2.0, created to enhance EEG data capture and synchronization across diverse platforms. It resolves the issue of E-Prime 2.0's lack of native support for streaming event markers via LabStreamingLayer (LSL), which is essential for improving research accuracy and efficiency.

## Features

- **Event Marker Streaming via LSL:** Enables the seamless streaming of event markers through LabStreamingLayer, facilitating synchronized data recording.
- **Button Press Detection:** Detects button presses within E-Prime and utilizes them as triggers for event marker streaming.
- **ANT-R Script Compatibility:** Harmonizes effortlessly with modified ANT-R scripts provided by Jin Fan.
- **Network Functionality:** Capable of recording event markers on any network-connected PC.

## System Requirements

- **Programming Language:** C#
- **Framework:** .NET Framework
- **Development Environment:** Visual Studio 2019 or Visual Studio 2022

## Availability and Open Science Commitment

In the spirit of Open Science, we are sharing the source code of `LSL4EPrime` with the wider community. This decision is driven by several key motivations:

- **Support for E-Prime 2.0 Users:** Our source code offers assistance to teams still relying on E-Prime 2.0, aiding them in detecting various events, such as mouse clicks or button presses.
- **Enabling Custom Add-in Development:** The availability of our code empowers other researchers to create their own add-ins with personalized event markers tailored to their unique research requirements.
- **Compiled Version and Script Snippets:** We will provide a compiled version of `LSL4EPrime` along with script snippets for seamless integration within the ANT-R script. This package will also include comprehensive installation and usage instructions.

## Licensing and Third-Party Code

- **License Agreement:** We kindly request you to review the `LICENSE.txt` file before utilizing `LSL4EPrime`, as it contains crucial legal information pertaining to the software's use.
- **Third-Party Code Acknowledgment:** Any instances where third-party code is utilized are appropriately acknowledged within our source code, including specific licensing information. In all other cases, the terms outlined in `LICENSE.txt` will apply.

## Support and Contact

For inquiries, questions, or collaboration opportunities, please reach out to us through our GitHub repository or contact us via email at [David Tekampe](mailto:davidtekampe@icloud.com) or [Philipp Tekampe](mailto:tekampe@outlook.com).
Thank you for considering `LSL4EPrime` for your research needs. We hope to contribute to the field of EEG research with this tool and we take pride in our commitment to Open Science.

## Attribution

`LSL4EPrime` utilizes third-party software, and we are thankful for the contributions of their authors and maintainers. Their work significantly enhances our project.

- **Processing Global Mouse and Keyboard Hooks in C#**- License: CPOL 1.02. Author: George Mamaladze. (<https://www.codeproject.com/Articles/7294/Processing-Global-Mouse-and-Keyboard-Hooks-in-C>).
- **liblsl-C#** - License: MIT. Author: Christian Kothe. (<https://github.com/labstreaminglayer/liblsl-Csharp>).
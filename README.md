
<p align="center">
  <img src="Deliverable/Documentation/Image/LOGO.png" width="300" height="300" alt="Robotic Arm icon">
</p>
<h1 align="center">Compact Continuum Manipulator Platform</h1>
<h3 align="center"><i>Repository Status</i></h3>
<div align="center">

[![Docker Image](https://img.shields.io/badge/Docker%20Image-osrf/ros:noetic--desktop--full--focal-0080ff?logo=docker)](https://hub.docker.com/layers/osrf/ros/noetic-desktop-full-focal/images/sha256-70037dab062e8edf988261a1ab937182676a984036219ebac4b8ec2ce6d1159e?context=explore)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
![Python Version](https://img.shields.io/badge/Python-3.10+-0080ff?logo=python)
![PyTorch Version](https://img.shields.io/badge/PyTorch-2.1.2+-0080ff)

</div>
<h3 align="center"><i>Developed with tools and softwares below.</i></h3>
<div align="center">
<p align="center">
	<a href="https://skillicons.dev">
		<img src="https://skillicons.dev/icons?i=github,md,latex,py,docker,matlab,ros">
	</a></p>


  [![Proteus](https://img.shields.io/badge/Proteus-Arduino-blue?logo=proteus)](https://www.labcenter.com/)
  [![Ansys](https://img.shields.io/badge/ANSYS-Simulation-orange?logo=ANSYS)](https://www.ansys.com/)
  [![SolidWorks](https://img.shields.io/badge/SolidWorks-3D%20Design-orange?)](https://www.solidworks.com/)

</div>



## 🔗 Quick Links

> - [📍 Overview](#-overview)
> - [🤖 Achievement](#-achievement)
> - [🚀 Getting Started](#-getting-started)
>   - [⚙️ Installation](#️-installation)
>   - [👩‍💻 Running Tutorial](#-running-tutorial)
>   - [📋 Parameter Definations](#-parameter-definations)
> - [📁 Repository Structure](#-repository-structure)

## 📍 Overview

The project is proposed to develop a compact continuum robotic platform suitable for precisely manipulating ultrasonic transducers for laboratory experimental FUS studies. 

<details closed>
<summary>Objectives</summary>

The objective of the project aims to design a modular fishbone continuum manipulator constructed from commonly used materials, 
capable of carrying the FUS transducer. The workspace of manipulator is specified as 300x300x300 mm,  featuring a high level 
of precision with a permissible error margin of 0.02 mm. The manipulator is expected to be user-friendly, requiring a learning 
cost of less than two hours. Testing and validation will be conducted through simulations based on Ansys, MATLAB, and Arduino. 
The project commenced on 10th November 2023, and is scheduled to conclude on 15th March 2024.

</details>

<details closed>
<summary>Features</summary>

- [x] **Manipulator Workspace**: 300x300x300 mm
- [x] **Precision**: error = 0.05 mm 
- [x] **Manipulator Design**: CAD model and strength analysis 
- [x] **Kinematics Derivation**: forward and inverse kinematics, 
- [x] **Control System**: Arduino 
- [x] **Project Completion**: 15th March 2024.
- [x] **Open Source**

</details>

## 🤖 Achievement
#### Manipulator Design
<p align="center">
  <img src="Deliverable/Final-Report/Image/Design/main_component_of_manipulator.png" width="800" height="400" alt="design">
</p>

#### Strength Analysis
<p align="center">
  <img src="Deliverable/Final-Report/Image/Result/displacement.png" width="400" height="300" alt="displacement_analysis">
  <img src="Deliverable/Final-Report/Image/Result/stress.jpg" width="400" height="300" alt="stress_analysis">
</p>

#### Kinematics - Trajectory Replication  

https://github.com/yezehao/Compact-Continuum-Manipulator-Platform/assets/96078570/2f5e6fad-2410-4b58-8dbd-b24e27642233

#### Arduino Actuation Control

https://github.com/yezehao/Compact-Continuum-Manipulator-Platform/assets/96078570/7a86e21f-088d-4987-99d9-87eaa268f4df




## 🚀 Getting Started
**Requirements for Kinematics Simulation**
+ Python: 3.10+
+ Package manager or container runtime: `conda`, `pip` or `docker` recommended.

### ⚙️ Installation
#### Kinematics Simulation Programme
**`Conda` Installation**  
![conda](https://img.shields.io/badge/Anaconda-44A833.svg?style=flat&logo=Anaconda&logoColor=white) *RECOMMAND*    
+ Create conda environment and activation:
  ```
  conda create -n manipulator python=3.10  
  ```
  ```
  conda activate manipulator 
  ```
+ Install pytorch according to [Pytorch Official Turorial](https://pytorch.org/): 
  ```  
  conda install pytorch torchvision torchaudio pytorch-cuda=<your_version> -c pytorch -c nvidia   
  ```
+ Other Installation
  ```
  conda install jupyter notebook
  conda install ipykernel
  ```
  ```  
  pip install -r requirements.txt
  ```

**`Pip` Installation**  
![pip](https://img.shields.io/badge/PyPI-3775A9.svg?style=flat&logo=PyPI&logoColor=white)   
+ Create virtual environment (optional)
  ```
  python -m venv venv
  venv\Scripts\activate
  ```
+ Install pytorch according to [Pytorch Official Turorial](https://pytorch.org/)
  ```  
  pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu<your-version>   
  ```
+ Other Installation
  ```  
  pip install jupyter notebook
  pip install ipykernel
  pip install pandas
  pip install h5py
  pip install matplotlib
  ```


### 👩‍💻 Running Tutorial
#### Kinematics Simulation Programme
There are two versions of the kinematics about compact continuum manipulator platform. The python version (2.0) have robust performances in Machine Learning (ML) compared with the MATLAB version (1.0). The simulation about inverse kinematics will mainly contribute to the python programme to make further explanation. However, the MATLAB version (1.0) have better visualization, which can be utilized for parameter design and manipulator model displayment. The tutorials about the kinematics programmes are shown as follow: 
+ [MATLAB Version (1.0)](MATLAB/README.md) 
+ [Python Version (2.0)](Kinematics/README.md)

#### Further Improvement
The CAD model of the manipulator is designed in [Model](Modle). It can be exported into the ROS for further simulation. The docker env has been configurated in [.devcontainer](.devcontainer) and can be executed through VS Code.

### 📋 Parameter Definations
<details open>
<summary>Parameter Definations of Manipulator</summary>

|Parameter|Definition|Value (mm)|
|:--|:--|:--|
| $Sr_i$ | the length of elastic sheet in Module i | $Sr_{1,2,3,4} = 150$ |
| $d_i$ | the thickness of the cross-shaped connector | $d_{1,2,3,4,5} = 15$ |
| $N$ | the number of cross-shaped sheet in a module | $N = 0 \text{ textasciitilde} 15$ |
| $r_i$ | the distance between the centroid of connector and cable routing hole | $r_{1,2} = 17.5$, $r_{3,4} = 15$ |
| $\Delta S_i$ | the change volume of cable, cable$_{2i-1}$ and cable $_{2i}$ corresponds to Module i | |
| $\boldsymbol{\Delta S}$ | a series of change volume of cables | $\Delta S_1 \sim \Delta S_8$ |
| $\alpha_i$ | the bending angle of module i | |
| $\boldsymbol{\alpha}$ | a series of bending angles about four modules | $[\alpha_1,\ \alpha_2,\ \alpha_3,\ \alpha_4]$ |
| $\boldsymbol{\theta}$ | a series of inverse kinematics solutions | $[\theta_1,\ \theta_2,\ \theta_3,\ \theta_4]$ |
| $\boldsymbol{\epsilon}$ | threshold of the error in FABRIKc algorithm | $\boldsymbol{\epsilon} = 0.02$ |


</details>


## 📁 Repository Structure
```sh
📦 Compact Continuum Manipulator Platform
├── 📂 .devcontainer
├── 📂 Arduino-Simulation
│   ├── 📂 motor_control_final
│   │   └── motor_control_final.ino
│   ├── multiple_motor_control.ino
│   ├── multiple_motor_control.pdsprj
│   └── 📜 README.md
├── 📂 Deliverable
│   ├── 📂 Documentation
│   └── 📂 Final-Report
│       ├── 📂 Appendix
│       ├── 📂 config
│       ├── 📂 Image
│       ├── 📂 Section
│       ├── Main-Thesis-File.pdf
│       ├── Main-Thesis-File.tex
│       └── references.bib
├── 📂 Kinematics
│   ├── 📂 circle
│   ├── 📂 IK_NN
│   ├── conversion.py
│   ├── FABRIKc.py
│   ├── forward-kinematics.ipynb
│   ├── inverse_kinematics.py
│   ├── trajectory_replication.py
│   ├── work-space-simulation.py
│   └── 📜 README.md
├── 📂 MATLAB
│   ├── 📂 result
│   ├── draw_tdcr.m
│   ├── error_calculation.m
│   ├── FKD_geometry.m
│   ├── FKD_visual.m
│   ├── FK_matrix.m
│   ├── TR_display.m
│   ├── workspace_simulation.m
│   └── 📜 README.md
├── 📂 Model
│   └── Manipulator.SLDASM
├── 📄 LICENSE
├── 📋 requirements.txt
└── 📜 README.md
```

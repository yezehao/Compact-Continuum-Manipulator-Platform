# Compact-Continuum-Manipulator-Platform
## Gantt Chart
```mermaid
gantt
    dateFormat  YYYY-MM-DD
    title MECH0064 MSc Group Project Gantt Chart

    Mataining this Gantt Chart [Z. Ye] : 2023-10-16, 2024-03-22

    section Preliminary Preparation [Z. Ye]
    Literature Review: done, 2023-10-23, 2023-12-31
    Work Package Distrubution: done, 2023-11-13, 5d
    Literature Review: milestone, crit, done, 2023-12-31, 0d 

    section Environment Config [Z. Ye]
    GitHub Config: done, 2023-11-6, 10d
    LaTex Config: done, 2023-11-13, 10d
    Docker Container Config: done, 2023-11-20, 25d
    Environment Configuration: milestone, done, crit, 2023-12-15, 0d 

    section Manipulator Modelling [D. Xu, J. Wu & Y. Zhang] 
    CAD Modelling (2D): done, 2023-11-18, 25d
    UG/Solidwork Modelling (3D): done, 2023-11-23, 25d
    Strain Analysis Replication: done, 2023-12-15, 40d
    Manipulator Model Strain Analysis: active, 2023-12-25, 55d
    Manipulator Model Parameter Adjustment: 2024-02-01, 2024-03-01
    Model Physical Strength Verification: milestone, crit, 2024-03-01, 0d 

    section Electronic Components Control [Y. Li & Y. Zhang]
    Proteus & Arduino IDE Env Config: done, 2023-11-18, 12d
    Auctutor Control Simulation: done, 2023-11-30, 10d
    Arduino Programming of Kinematics: active, 2023-12-11, 60d
    Arduino Programme Testing: 2024-02-01, 30d
    Arduino Bench Inspection: milestone, crit, 2024-03-01, 0d 

    section Locomotion Model [Z. Ye & Y. Zhu]
    Manipulator Parameter Design: done, 2023-11-18, 14d
    Forward Kinematics Algorithm: done, 2023-12-01, 30d
    Inverse Kinematics Algorithm: active, 2024-01-01, 60d
    Locomotion Bench Inspection: milestone, crit, 2024-03-01, 0d 

    section GitHub Documentation [Z. Ye]
    README Maintanence: active, 2023-10-16, 2024-03-22
    Manipulator Model Strain Analysis Documentation: active, 2024-01-20, 2024-03-22
    Arduino Programme Documentation: active, 2024-01-20, 2024-03-22
    Kinematics Programme Documentation: active, 2024-01-20, 2024-03-22
    Documentation Inspection: milestone, 2024-03-22, 0d 

    section Deliverable
    Presentation 1 Preparation: done, 2023-12-06, 5d
    Presentation 1 [Week 16]: milestone, done, crit, 2023-12-11, 0d 
    Peer Assessment 1 [Week 16]: milestone, done, crit, 2023-12-18, 0d 
    Report Writting Preparation: 2024-02-26, 10d 
    Individual Contirbution [Week 28]: milestone, crit, 2024-03-04, 5d 
    Final Report [Week 28]: milestone, crit, 2024-03-04, 5d 
    Peer Assessment 2 [Week 28]: milestone, crit, 2024-03-04, 5d
    Presentation 2 preparation: 2024-03-07, 7d 
    Second Presentation [Week 29]: milestone, crit, 2024-03-11, 5d 
```


## Milestone & Deliverable
<details open>
<summary>Deadlines of project</summary>

|Assessment elements|Assessment Type|Contribution|Due Date|
|:--|:--|:--|:--|
|Presentation 1|Formative|Team|Week 16|
|Peer Assessment 1|Formative|Individual|Week 16|
|Final Report|Summative|Team|Week 28|
|Peer Assessment 2|Summative|Individual|Week 28|
|Individual Contribution|Summative|Individual|Week 28|
|Presentation 2|Summative|Team|Week 29|

```mermaid
gantt
    dateFormat  YYYY-MM-DD
    title Deadlines of the MECH0064 Group Project

    Mataining this Gantt Chart [Zehao Ye] : 2023-10-16, 2024-03-22

    section Team Tasks
    Presentation 1 [Week 16]: crit, 2023-12-11, 5d    
    Final Report [Week 28]: crit, 2024-03-04, 5d
    Second Presentation [Week 29]: crit, 2024-03-11, 5d 

    section Individual Tasks
    Peer Assessment 1 [Week 16]: 2023-12-11, 5d
    Peer Assessment 2 [Week 28]: 2024-03-04, 5d
    Individual Contirbution [Week 28]: 2024-03-04, 5d
```

</details>

## Description
The project is proposed to develop a compact continuum robotic platform suitable for precisely manipulating ultrasonic transducers for laboratory experimental FUS studies. 

<details closed>
<summary>Aim</summary>

The aim of the project is to develop a compact continuum robotic platform for precise manipulation of an *ultrasonic transducer* (`cylindrical`, `dimensions of 65x30 mm`, `weight < 0.8 kg`)

</details>


<details closed>
<summary>Main Features</summary>

The features of the compact continuum manipulator platform are as follow:   
`compact`, `versatile`, `cost-effective`, `programmable`, `open-source`, `6-DOF`

The product is ideally consist of a *continuum robot*, a *driving system* and a *control system* developed using Arduino.
</details>

<details closed>
<summary>Objectives</summary>

- [ ] Identify the most suitable design of tendon manipulators for this application,
- [ ] Design and simulate the kinetics and kinematics of the platform numerically,
- [ ] Optimise the design by minimising the dimensions of the platform,
- [ ] Propose suitable instrumentation and develop the required controller,
- [ ] Open-source project repository, including the codes, simulations and CAD files.

</details>

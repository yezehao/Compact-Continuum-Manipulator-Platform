# Compact-Continuum-Manipulator-Platform
## Gantt Chart
```mermaid
gantt
    dateFormat  YYYY-MM-DD
    title MECH0064 MSc Group Project Gantt Chart

    Mataining this Gantt Chart [Zehao Ye] : 2023-10-16, 2024-03-22

    section Preparation
    Literature Review: crit, active, LR, 2023-10-23, 2023-11-23
    Work Package Distrubution: done, 2023-11-13, 5d
    Literature Review: milestone, after LR, 0d 

    section Environment Config [Zehao Ye]
    GitHub Config: done, 2023-11-6, 2023-11-16
    LaTex Config: active, 2023-11-13, 2023-11-30
    Linux Config: 2023-11-23, 30d
    Simulation Env Config: SEC, 2023-11-30, 60d

    section Robot Modelling [Jiachen Wu] 
    CAD Modelling (2D): crit, CAD, after LR, 7d
    UG/Solidwork Modelling (3D): crit, 3D_MODEL, 2023-11-27, 7d

    section Model Strength Test (Dawei Xu) 
    Ansys: crit, ansys, after 3D_MODEL, 10d
    Model Validation: milestone, after ansys, 0d 

    section Electronic Components Simulation [Yuehan Zhang]
    Sensor Incorporation: model_sensor, after CAD, 14d
    Arduino Programming (electronic): ELEC_Arduino, after 3D_MODEL, 35d


    section Auctutor Control [Yuantong Li] 
    Auctutor Model Incorporation: model_motor, after CAD, 14d
    Arduino Programming (auctutors): crit, Auctutor_Arduino, after ansys, 35d
    Electronic Component Completion: milestone, after Auctutor_Arduino, 0d 

    section Dynamic Locomotion [Yuhao Zhu]
    Kinematics formula: Kinematics, after ansys, 25d
    Dynamic Locomotion: milestone, after Kinematics, 0d 

    section Simulation Test [Zehao Ye]
    Integration: crit, Integration, after Auctutor_Arduino, 7d
    Simulation Test: crit, after Integration, 2024-02-26
    Bench Inspection: milestone, 2024-02-26, 0d 

    section Deliverable
    Presentation 1 Preparation: 2023-12-09, 5d
    Presentation 1 [Week 16]: milestone, 2023-12-11, 5d 
    Peer Assessment 1 [Week 16]: milestone, 2023-12-11, 5d 
    Report Writting Preparation: crit, 2024-02-26, 10d 
    Individual Contirbution [Week 28]: milestone, 2024-03-04, 5d 
    Final Report [Week 28]: milestone, 2024-03-04, 5d 
    Peer Assessment 2 [Week 28]: milestone, 2024-03-04, 5d
    Presentation 2 preparation: 2024-03-07, 7d 
    Second Presentation [Week 29]: milestone, 2024-03-11, 5d 
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
|Individual Contirbution|Summative|Individual|Week 28|
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

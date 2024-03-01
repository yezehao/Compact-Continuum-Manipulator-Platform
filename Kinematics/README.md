# Python Kinematics Programme Tutorial
## 📁 Folder Description
```sh
├── conversion.py
├── FABRIKc.py
├── forward-kinematics.ipynb
├── IK_NN
│   ├── inverse-kinematics_homogeneous.ipynb
│   ├── inverse-kinematics.ipynb
│   └── model
├── inverse_kinematics_note.md
├── README.md
└── work-space-simulation.py
```

## 🐍 Python Library Usage
For the programme related to forward kinematics, `Pytorch` is used because the inverse kinematics programme is designed to use ANN at the very beginning. However, after the indeed research, the ANN was found out that unsuitable for the inverse kinematics. So the inverse kinematics programme use `Numpy`, which is simple and do not require to install `Pytorch` additionally. I do apologize for any inconvenience caused by this issue.
### ![PyTorch](https://img.shields.io/badge/PyTorch-%23EE4C2C.svg?style=for-the-badge&logo=PyTorch&logoColor=white)
The following programmes in this folder use `Pytorch`. The virtual environment created in [installation](https://github.com/yezehao/Compact-Continuum-Manipulator-Platform/tree/main?tab=readme-ov-file#%EF%B8%8F-installation) need to be activated while using the programmes. 
```sh
├── forward-kinematics.ipynb
├── IK_NN
│   ├── inverse-kinematics_homogeneous.ipynb
│   ├── inverse-kinematics.ipynb
│   └── model
└── work-space-simulation.py
```
### ![NumPy](https://img.shields.io/badge/numpy-%23013243.svg?style=for-the-badge&logo=numpy&logoColor=white)
The following programmes in this folder use `Numpy`. If there are `Numpy` and `Matplotlib` in your Python environment, you can directly use these programme.
```sh
├── conversion.py
└── FABRIKc.py
```

## 👩‍💻 Running Tutorial
+ `conversion.py`: this is the python programme used to convert angles of the segments into the change of the cables, which converts $\alpha$ to $\Delta S$.
+ `forward-kinematics.ipynb`: this is the juypter notebook about forward kinematics, the running tutorial is given in this notebook.
+ `IK_NN`: this is the folder about inverse kinematics by using data-driven method using ANN. However, this approach failed at the end.
+ `work-space-simulation.py`: this is the python programme used to randomly generate the positions of manipulator end effector. By fitting these positions, the workspace of the manipulator can be acquired. The programme can be run with the following command, `<number>` represents the number of random positions you want to generate.
    ```
    python work-space-simulation.py <number>
    ```
+ `FABRIKc.py`: this is the programme for inverse kinematics. It use the algorithn called [FABRIKc](https://ieeexplore.ieee.org/abstract/document/8452693) to make approximation about the inverse kinematics. Compared with other approximation algorithm, this is efficient without suffering from singularity problems.
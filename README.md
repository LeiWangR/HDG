# HDG

This repo contains the implementation for 'Analysis and Evaluation of Kinect-based Action Recognition Algorithms'. 

## Introduction

This repository contains the implementation of the model presented in the following paper:

[1] Lei Wang, 2017. **Analysis and Evaluation of Kinect-based Action Recognition Algorithms**. *Master's thesis*. School of Computer Science and Software Engineering, The University of Western Australia.

[2] Lei Wang, Du Q. Huynh, and Piotr Koniusz. **A Comparative Review of Recent Kinect-Based Action Recognition Algorithms**. *IEEE Transactions on Image Processing*, 29: 15-28, 2020.

## Other algorithms evaluated in TIP paper

You can download other algorithms we evaluated in *TIP* paper from the following links:

- [HON4D + MSRAction3D/3DActionPairs](https://drive.google.com/file/d/1qahLGmS137yCEf3KLXJMApj7MDgdwEUw/view?usp=sharing)
- [HOPC](https://drive.google.com/file/d/1La-9AFKWbJ4MfjnVB0FxBlmWFBlNhXx5/view?usp=sharing)
- [LARP-SE](https://drive.google.com/file/d/1XOd3bKDDqOJ1UHSdDBiVuAwlb3JGQYGw/view?usp=sharing)
- [LARP-SO]()
- [HPM](https://drive.google.com/file/d/1pyb-qE1nup4ai1mhYVeibaizV1jV-EvR/view?usp=sharing)


## Datasets

You can download the depth/skeleton sequences for the following datasets here: 

- [MSRAction3D](https://drive.google.com/file/d/1kTp_QK2uRvY4sx9cSfuoTi2saBpIeqP5/view?usp=sharing)
- [3DActionPairs](https://drive.google.com/file/d/1rjCqzFxZpF42YaPtvsaRokXAFuyz8Wbh/view?usp=sharing)
- [UWA3DActivity](https://drive.google.com/file/d/1VCCxLItHU3g2xGYs87r5TlooiicuO2Ak/view?usp=sharing)
- [UWA3D Multiview Activity](https://drive.google.com/file/d/1ni76DwhNZvmLqP011qKir7ZFsRbW3bFn/view?usp=sharing)
- [CAD60]()

For UWA3DActivity+UWA3D Multiview Activity depth only, you can use [this link](https://pan.baidu.com/s/1R5JRX8JnaFzEBAsZEtVUyQ)(extraction code: 172h). 

For CAD60 depth only, please use [this link](https://pan.baidu.com/s/1y11YieObi4H1GM6pe2P75g) (extraction code: 36wt)

## Run the codes of HDG

This is an implementation for Rahmani et al.’s paper ‘Real Time Action Recognition Using Histograms of Depth Gradients and Random Decision Forests’ (2014 WACV). To run the HDG algorithm:

### Data preparation

- Go to the 'Dataset' folder, then go to the 'depth' folder and copy all depth sequence in this folder (should be .mat format and the internal data has the same name 'inDepthVideo'). 

- After that go to the 'skeleton' folder, copy all skeleton sequence (the skeleton sequence should also be .mat format and each skeleton sequence has the following dimension: #jointsx3x#frames, here 3 represents x, y and d respectively), the internal data has the same name 'skeletonsequence'.

### Feature extraction and concatenation

- Go to the 'MATLAB_Codes' folder, run each 'main' in each algorithm folder(in the order of 00, 01, 02 and 03), and then run 'main' in 'feature_concatenating'. You can also run '02' and '03' first and then run '00' and '01', since '00' may need more time for segmenting the foreground (around 6 hours) and '01' is based on the results of '00'.

- For UWAMultiview dataset, remember to change the video sequence from uint16 to double using im2double before running each main in 00 and 01: in both 00 and 01 folders, in main function line 33 & 17, change `depthsequence=actionvolume;` to `depthsequence=im2double(actionvolume);`.

- For feature concatenating, you can select different combinations of features for classification. There are four features, which are hod(histogram of depth), hodg(histogram of depth gradients), jmv(joint movement volume features) and jpd(joint position differences features).

  - Remember to change the number of joints and the torso joint ID in the 'main' of '02' and '03' since different datasets have different number of joints and torso joint IDs. **

    - MSRPairs: 20 joints, torso joint ID is '2';

    - MSRAction3D: 20 joints, torso joint ID is '4';

    - CAD60: 15 joints, torso joint ID is '3';

    - UWA3D single view dataset: 15 joints, torso joint ID is '9';

    - UWA3D multi view dataset: 15 joints, torso joint ID is '3';

### Classification

- Run 'main' of random decision forests (Lei uses different 'main' for different datasets since different datasets should have different training and testing datasets). In Lei's implementation, half of data are used for training and the remaining half for testing.

  - MSRPairs: 'msrpairsmain.m'

  - MSRAction3D: 'msr3dmain.m'

  - CAD60: 'cad main.m'

  - UWA3D single view: 'uwasinglemain.m'

  - UWA3D multi view: 'uwamultimain.m'

### Visualization (i.e., confusion matrix)
- The results of the confusion matrix will be saved in the 'Results' folder, and the confusion matrix will be displayed. Moreover, the total accuracy will appear in the workspace of the MATLAB.


`saveTightFigure` function is downloaded from online resource, which can be used to save the confusion matrix plot as pdf files. The use of this function is: `saveTightFigure(gcf, 'uwamultiview.pdf');`


**Codes for parameters evaluation, running over all possible 252 combinations of selecting half subjects for training are not provided.**

For more information, please refer to my research report and journal paper.

## Citations

You can cite the following papers for this work:

```
@mastersthesis{lei_thesis_2017,
  author       = {Lei Wang}, 
  title        = {Analysis and Evaluation of {K}inect-based Action Recognition Algorithms},
  school       = {School of the Computer Science and Software Engineering, The University of Western Australia},
  year         = 2017,
  month        = {Nov}
}
```

```
@ARTICLE{lei_tip_2019,
author={Lei Wang and Du Q. Huynh and Piotr Koniusz},
journal={IEEE Transactions on Image Processing},
title={A Comparative Review of Recent Kinect-Based Action Recognition Algorithms},
year={2020},
volume={29},
number={},
pages={15-28},
doi={10.1109/TIP.2019.2925285},
ISSN={1941-0042},
month={},}
```


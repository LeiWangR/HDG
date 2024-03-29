# A Comparative Review of Recent Kinect-Based Action Recognition Algorithms

This repo contains: 

- the HDG implementation (Matlab codes) for 'Analysis and Evaluation of Kinect-based Action Recognition Algorithms', and 
- provides the links (google drive) for downloading the algorithms evaluated in our *TIP* journal and 
- provides direct links (google drive) to download 5 smaller datasets for action recognition research. 

## 1 Introduction

This repository contains the implementation of HDG presented in the following paper:

[1] Lei Wang, 2017. **Analysis and Evaluation of Kinect-based Action Recognition Algorithms**. *Master's thesis*. School of Computer Science and Software Engineering, The University of Western Australia. [[ArXiv]](https://arxiv.org/abs/2112.08626) [[BibTex]](#citation)

[2] Lei Wang, Du Q. Huynh, and Piotr Koniusz. **A Comparative Review of Recent Kinect-Based Action Recognition Algorithms**. *IEEE Transactions on Image Processing*, 29: 15-28, 2020. [[ArXiv]](https://arxiv.org/abs/1906.09955) [[BibTex]](#citation)

We also provide the links for downloading the algorithms/datasets used in our *TIP* paper.

## 2 Other algorithms compared in TIP paper

You can download other algorithms we evaluated in *TIP* paper from the following links:

- [HON4D + MSRAction3D/3DActionPairs](https://drive.google.com/file/d/1qahLGmS137yCEf3KLXJMApj7MDgdwEUw/view?usp=sharing) (CVPR2013)
- [HOPC](https://drive.google.com/file/d/1La-9AFKWbJ4MfjnVB0FxBlmWFBlNhXx5/view?usp=sharing) (TPAMI2016, Matlab codes)
- [LARP-SE](https://drive.google.com/file/d/1XOd3bKDDqOJ1UHSdDBiVuAwlb3JGQYGw/view?usp=sharing) (CVPR2014, Matlab codes)
- [LARP-SO](https://drive.google.com/drive/folders/1THaljmQ7m0uBQ5aW8TX8Yk81sEhluJep?usp=sharing) (CVPR2016, Matlab codes)
- [HPM](https://drive.google.com/file/d/1pyb-qE1nup4ai1mhYVeibaizV1jV-EvR/view?usp=sharing) (CVPR2016, Matlab codes)
- [IndRNN](https://github.com/Sunnydreamrain/IndRNN_pytorch) (CVPR2018, Python codes)
- [ST-GCN](https://github.com/yysijie/st-gcn) (AAAI2018, Python codes)


## 3 Datasets used in TIP paper

### 3.1 Five Smaller datasets 

#### 3.1.1 Depth+Skeleton

You can directly download the depth+skeleton sequences for the following smaller datasets here: 

- [MSRAction3D](https://drive.google.com/file/d/1kTp_QK2uRvY4sx9cSfuoTi2saBpIeqP5/view?usp=sharing)
- [3D Action Pairs](https://drive.google.com/file/d/1rjCqzFxZpF42YaPtvsaRokXAFuyz8Wbh/view?usp=sharing)
- [UWA3D Activity](https://drive.google.com/file/d/1VCCxLItHU3g2xGYs87r5TlooiicuO2Ak/view?usp=sharing)
- [UWA3D Multiview Activity II](https://drive.google.com/file/d/1ni76DwhNZvmLqP011qKir7ZFsRbW3bFn/view?usp=sharing)
- [CAD-60](https://drive.google.com/drive/folders/1VshMi77TuaDcd-x2s1zH9N-iDD7KIu7Z?usp=sharing)

The above 5 downloaded datasets contain depth + skeleton data, which you can directly use for HDG algorithm in this repo:
- unzip a dataset, and 
- put the Dataset folder into HDG folder, then 
- extract the features (refer to following sections for more details).

#### 3.1.2 Depth video only

For downloading the UWA3DActivity+UWA3D Multiview Activity II depth only, you can use [this link](https://pan.baidu.com/s/1R5JRX8JnaFzEBAsZEtVUyQ)(extraction code: 172h). 

For downloading the CAD-60 depth only, please use [this link](https://pan.baidu.com/s/1y11YieObi4H1GM6pe2P75g) (extraction code: 36wt)

### 3.2 Big datasets (NTU RGB+D)

For big datasets such as NTU-60 and NTU-120, please refer to [this link](https://github.com/shahroudy/NTURGB-D) for the request to download.


## 4 Run the codes of HDG

This is an implementation based on Rahmani et al.’s paper ‘Real Time Action Recognition Using Histograms of Depth Gradients and Random Decision Forests’ (WACV2014). 

To run our new HDG algorithm (which is analysed and compared in our *TIP*2020 paper):

### 4.0 A glance of skeleton configuration

To know more detailed information about the skeleton configuration/graph, please refer to the pdf file attached in this repo.

UWAS denotes the skeleton configuration for UWA3D Activity, and UWAW is for UWA3D Multiview Activity II.

### 4.1 Data preparation

- Go to the 'Dataset' folder, then go to the 'depth' folder and copy all depth sequence in this folder (should be .mat format and the internal data has the same name 'inDepthVideo'). 

- After that go to the 'skeleton' folder, copy all skeleton sequence (the skeleton sequence should also be .mat format and each skeleton sequence has the following dimension: #jointsx3x#frames, here 3 represents x, y and d respectively), the internal data has the same name 'skeletonsequence'.

### 4.2 Feature extraction and concatenation

- Go to the 'MATLAB_Codes' folder, run each 'main' in each algorithm folder(in the order of 00, 01, 02 and 03), and then run 'main' in 'feature_concatenating'. You can also run '02' and '03' first and then run '00' and '01', since '00' may need more time for segmenting the foreground (around 6 hours) and '01' is based on the results of '00'.

- For UWAMultiview dataset, remember to change the video sequence from uint16 to double using im2double before running each main in 00 and 01: in both 00 and 01 folders, in main function line 33 & 17, change `depthsequence=actionvolume;` to `depthsequence=im2double(actionvolume);`.

- For feature concatenating, you can select different combinations of features for classification. There are four features, which are:
  - hod(histogram of depth), 
  - hodg(histogram of depth gradients), 
  - jmv(joint movement volume features) and 
  - jpd(joint position differences features).

- Remember to change the number of joints and the torso joint ID in the 'main' of '02' and '03' since different datasets have different number of joints and torso joint IDs (refer to the pdf attached in this repo for the skeleton configuration). 

   - MSRPairs (3D Action Pairs): 20 joints, torso joint ID is '2';
   - MSRAction3D: 20 joints, torso joint ID is '4';
   - CAD-60: 15 joints, torso joint ID is '3';
   - UWA3D single view dataset (UWA3D Activity): 15 joints, torso joint ID is '9';
   - UWA3D multi view dataset (UWA3D Multiview Activity II): 15 joints, torso joint ID is '3';

### 4.3 Classification

- Run 'main' of random decision forests (Lei uses different 'main' for different datasets since different datasets should have different training and testing datasets). In Lei's implementation, half of data are used for training and the remaining half for testing.

  - MSRPairs (3D Action Pairs): `msrpairsmain.m`
  - MSRAction3D: `msr3dmain.m`
  - CAD-60: `cadmain.m`
  - UWA3D single view (UWA3D Activity): `uwasinglemain.m`
  - UWA3D multi view (UWA3D Multiview Activity II): `uwamultimain.m`

### 4.4 Visualization (i.e., confusion matrix)
- The results of the confusion matrix will be saved in the 'Results' folder, and the confusion matrix will be displayed. Moreover, the total accuracy will appear in the workspace of the MATLAB.

#### 4.4.1 Save figures to pdf format

- `saveTightFigure` function is downloaded from online resource, which can be used to save the confusion matrix plot as pdf files. The use of this function is, for example: `saveTightFigure(gcf, 'uwamultiview.pdf');`


**Codes for parameters evaluation, and running over all possible combinations of selecting half subjects (for training) are not provided in this repo.**

For more information, please refer to my research report and our journal paper, or contact me.


## 5 Citations
<a name="citation"></a>

You can cite the following papers for the use of this work:

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
@article{lei_tip_2019,
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

#### Acknowledgments

I am grateful to Associate Professor Du Huynh for her valuable suggestions and discussions. We would like to thank the authors of HON4D, HOPC, LARP-SO, HPM+TM, IndRNN and ST-GCN for making their codes publicly available. We thank the ROSE Lab of Nanyang Technological University(NTU), Singapore, for making the NTU RGB+D dataset freely accessible.


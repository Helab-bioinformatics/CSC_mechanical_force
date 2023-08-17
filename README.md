# CSC_mechanical_force

A collection of methods for extrcting and  visualizing cell lineage.

### Prerequisites
- GrapeBio Pre: Bio Image Preprocessing

  [GrapeBio Pre](https://sourceforge.net/projects/grapebio/files/) is our home-built C++ based image preprocessing pipeline to improve the quality of 4D bio images, consisting of adaptive background subtraction, median filter de-nosing, HDR, light balance and spatio-temporal alignment of image stacks. Coupled with TGMM 2.0 below, it can substantially improve the segmenting and tracking accuracies.

- TGMM 2.0: Cell Tracking with Gaussian Mixture Models

  [TGMM 2.0](https://bitbucket.org/fernandoamat/tgmm-paper/src/master/) performs cell segmentation and tracking for mining cell lineage, which employs a machine learning approach to division detection utilizing both lineage-based and image-based features.

### Extract-lineage

We have provided three MATLAB scripts to extract the cell lineage information from MaMuT file.
- Step1_Extract_cell_basicinfo.m: Extract the cell ID, timepoint, cell position(X, Y, Z) and parent cell ID into a .mat file.
- Step2_Caculate_cell_intensity.m: Caculate the fluorescence intensity of each cell points and count the cell lineage ID.
- Step3_LineageTree.m: Plot the lineage tree.

### Extract-lineage
We provided an  implementation of visualizing cell lineage. It provides 3D rendering presentation of color-coded cell centroids and moving trajectories, which are merged with fluorescence images.

```
### Citation
If you use [GrapeBio Pre](https://sourceforge.net/projects/grapebio/files/) for your research, please cite our [paper](https://doi.org/10.1038/s41556-020-0475-2).
```
@article{yue2020long,
  title={Long-term, in toto live imaging of cardiomyocyte behaviour during mouse ventricle chamber formation at single-cell resolution},
  author={Yue, Yanzhu and Zong, Weijian and Li, Xin and Li, Jinghang and Zhang, Youdong and Wu, Runlong and Liu, Yazui and Cui, Jiahao and Wang, Qianhao and Bian, Yunkun and others},
  journal={Nature cell biology},
  year={2020},
}
```
If you use [TGMM 2.0](https://bitbucket.org/fernandoamat/tgmm-paper/src/master/) mentioned in this repo, please cite the following [paper](https://doi.org/10.1016/j.cell.2018.09.031).
```
@article{mcdole2018toto,
  title={In toto imaging and reconstruction of post-implantation mouse development at the single-cell level},
  author={McDole, Katie and Guignard, L{\'e}o and Amat, Fernando and Berger, Andrew and Malandain, Gr{\'e}goire and Royer, Lo{\"\i}c A and Turaga, Srinivas C and Branson, Kristin and Keller, Philipp J},
  journal={Cell},
  year={2018},
}
```

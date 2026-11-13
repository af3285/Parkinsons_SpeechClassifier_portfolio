# Parkinson's Disease Speech Classification

## Overview

This project explores machine learning approaches for distinguishing individuals with Parkinson's disease from healthy controls using speech-derived features.

The analysis uses the **Parkinson's Disease Classification** dataset from the UCI Machine Learning Repository. The dataset contains quantitative features extracted from speech recordings and provides a binary classification target indicating Parkinson's disease status.

The primary focus of the project was evaluating neural-network classification alongside feature-selection and dimensionality-reduction techniques. In particular, a genetic algorithm was implemented to identify informative subsets of speech features, while principal component analysis (PCA) was used to examine the structure and variance of the dataset.

## Methods

### Neural-Network Classification

A feedforward neural network was implemented using MATLAB's `patternnet` function.

- Five-fold cross-validation is used to estimate classification accuracy.
- The network architecture is configurable through the number of hidden neurons.
- Classification predictions are generated using a 0.5 decision threshold.
- Training and evaluation time can also be recorded.

### Genetic-Algorithm Feature Selection

A genetic algorithm was implemented using MATLAB's `ga` function to identify subsets of features that maximize neural-network classification performance.

- Each candidate solution represents a binary feature-selection vector.
- Candidate subsets are evaluated using neural-network classification accuracy.
- The selected feature indices and corresponding feature names are returned.
- The implementation uses three generations by default, with population size supplied as an input parameter.

### Principal Component Analysis

PCA is used to investigate the structure of the speech-feature dataset and reduce its dimensionality.

- Principal components and their associated variances are calculated.
- The first two principal components are visualized to compare Parkinson's disease and healthy-control samples.
- Reconstruction error is calculated to examine how well the original data can be represented using a subset of principal components.

## Repository Structure

| File | Description |
|---|---|
| `loaddataset.m` | Downloads and loads the UCI speech-feature dataset. |
| `neuralnetwork.m` | Trains and evaluates a neural network using five-fold cross-validation. |
| `FeatureFitness.m` | Evaluates candidate feature subsets for genetic-algorithm optimization. |
| `genfeatureselect.m` | Performs genetic-algorithm-based feature selection. |
| `performPCA.m` | Performs PCA and visualizes samples in principal-component space. |
| `getReconstructionError.m` | Calculates reconstruction error using selected principal components. |
| `overall.mlx` | Main MATLAB Live Script for the project analysis. |
| `preliminaryanalysis.mlx` | Preliminary exploratory analysis. |
| `loaddataset_demo.mlx` | Demonstration of the dataset-loading workflow. |

## Requirements

This project was developed in MATLAB and uses functions from several MATLAB toolboxes.

Expected dependencies include:

- MATLAB
- Deep Learning Toolbox (`patternnet`, `train`, and `sim`)
- Global Optimization Toolbox (`ga` and `optimoptions`)
- Statistics and Machine Learning Toolbox (`pca` and `crossvalind`)
- Image Processing Toolbox (`immse`), if using the reconstruction-error function
- The external `bmes` helper functions used by the dataset-loading workflow
- 7-Zip, if required to extract the downloaded dataset archive

The `bmes` helper functions are not included in this repository and must be made available separately for the original dataset-loading function to work.

## Dataset

The project uses the [Parkinson's Disease Classification dataset](https://archive.ics.uci.edu/dataset/470/parkinson+s+disease+classification) from the UCI Machine Learning Repository.

The dataset is downloaded by `loaddataset.m`. The original research data and intermediate MATLAB workspace files are not included in this repository.

**Note:** `FeatureFitness.m` expects a `variablesforfitness.mat` file containing the training feature matrix (`X`) and target vector (`T`). This file is not included, so the genetic-algorithm feature-selection workflow requires that the workspace file be generated or otherwise supplied before execution.

## Notes and Limitations

This repository represents an academic machine-learning project and an exploratory investigation of speech-derived features for Parkinson's disease classification.

The reported cross-validation accuracy should be interpreted in the context of the original experimental design. Feature selection and model evaluation are not implemented as a fully nested cross-validation procedure, so the resulting estimates should not be interpreted as an unbiased estimate of performance on completely unseen data.

This project is intended for educational and research purposes and is **not a clinically validated diagnostic system**.

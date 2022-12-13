# Compskills-Final-Project

## Overview
This repository containes the Rscript and data file (tab delimited) that I used for the final project for this class. The data comes from Bruneaux et al. 2017 (https://besjournals.onlinelibrary.wiley.com/doi/10.1111/1365-2435.12701; data available here: https://datadryad.org/stash/dataset/doi:10.5061%2Fdryad.591d4), wherein the authors investigated physiological effects of a myxozoan parasite (Tetracapsuloida  that causes proliferative kidney disease (PKD) in brown trout (Salmo salar) in the context of climate change. The purpose of this analysis was to investigate further the factors associated with physiological changes in these fish using data reduction techniques (e.g., PCA), as the authors focused primarily on regression-based analyses for their paper. Given the number of metrics reported (e.g., stream of origin, morphometric data on fish, K/B ratio, etc.), I was curious whether I might be able to confirm their findings and/or detect any potential relationships that had not yet been explored.

## Files
* Final_Project.R -- This is the Rscript containing the reproducible code used to subset the data, perform data reduction via a PCA, and to generate my figures
* dataset-dryad-bruneaux-2016-FE.tsv -- This is the raw csv file containing the data from Bruneaux et al. 2017, in a tab-separated format.
* README_dataset-dryad-bruneaux-2016-FE.tsv -- This is the README file supplied by the authors which describes all of the metrics within the dataset.
* PKD_AS_corr.png -- This is the initial plot wherein I tested the aerobic scope data for multicolinearity. It does seem that the majority of the factors are correlated with each other to some degree.
* Aerobic_Scope_PCA.png -- This is the final PCA plot I've generated, containing the scaled and centered scatter of points in PC space color coded by their stream of origin, with the PC vectors on the right. From this plot, it seems evident to me that Mustoja fish were generally larger and had fewer parasites / kidney disease, while fish from Vainupea tended to be smaller and had more parasites and afflicted kidneys

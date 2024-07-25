# sierra-flammability

## A GitHub Repository for: 

## Towards predicting flammability: drought stress and fuel moisture are strongly linked in angiosperms but decoupled in gymnosperms

### Indra Boving, Joe Celebrezze, Leander Anderegg, and Max Moritz

--------------------------------

## Introductory Statement
This repository is meant for the storage and sharing of data, scripts, figures, and linear mixed effects model results tables related to the above paper. 


--------------------------------

## Breakdown of Folders

### Raw Data:
The **raw-data** folder includes 13 datasets in .csv format. Below are brief descriptions of each of these datasets and their use(s); however, for a more comprehensive breakdown of the data, see the metadata.

  *allcurves.csv*: PV Curve data for all species

  *czo.flam.curve.physiological.data.csv*: Contains mpa, lfm, and saturated WC from CZO flam trials. 

  *seki.flam.curve.physiological.data.csv*: Contains mpa, lfm, and saturated WC from SEKI flam trials. 
  
  *field.summer.2020.csv*: Field LFM and MPa data from Summer 2020
  
  *LFM_Sierra_AllDates.csv*: Just LFM from summer 2020
  
  *phenology_czo_2021.csv*: Phenological data collected in 2021 from Providence Creek Watershed CZO
  
  *r.flam.data.czo.2020.csv*: Flammability data collected in 2020 from Providence Creek Watershed CZO
  
  *r.flam.data.czo.2021.csv*: Flammability data collected in 2021 from Providence Creek Watershed CZO
  
  *SEKI_flammability.csv*: Flammability data collected in 2020 from SEKI satellite sites


### Processed Data:


### Scripts:
This folder includes four folders, each with scripts that we used to wrangle data, complete analyses, and design tables and figures for the main text, the supplementary index, and for exploratory analyses. The folders (**bold**) and the scripts inside each folder (*italicized*) are described briefly below, and we attempted to annotate the scripts and organize them by headings to make them easier for others to navigate.

#### Flammability

This folder includes scripts relating to tissue flammability of the Sierran species investigated in this paper. Due to the large number of scripts that belong in this folder, it was further divided into other folders, described below. It is also labelled by number, indicating the order that the scripts are meant to be run, although with all of the materials currently on the GitHub, the scripts should run in any order.

**1.data_wrangling**: This folder includes scripts to wrangle raw datasets into more usable formats and combine data from 2020 (CZO or SEKI) and 2021 (CZO only)
  
  *1.1_data_wrangling_2020_CZO.Rmd*:
    
  *1.1_data_wrangling_2021_CZO.Rmd*:
    
  *1.1_data_wrangling_SEKI.Rmd*:
    
  *1.2_data_wrangling_all_sites.Rmd*:
    
*2.PCA.Rmd*: Principle component analysis
  
**3.mixed_effects_models**: This folder includes scripts for running linear mixed effects models (MEMs)
    
  **3.1.MEM_flam_metrics**: Includes separate scripts to run each flammability metric analysis using LFM and MPa as predictors
    
  **3.2.RWC**: Includes separate scripts to run each flammability metric analysis using relative water content (RWC) as a predictor
    
  *3.3_top_MEM_models.Rmd*: Combined flammability metric top LFM/MPa models, combines into tables for easier analysis 

*4.flam_vs_water_content.Rmd*: Previous iterations of figures, (unused in main text)

*4.1_water_flam_figs.Rmd*: Predicted flammability and script for creating Fig. 5

#### Physiology

This folder relates to the side of the story regarding the relationship between LFM and water potential and how different drought strategies are involved in the six Sierran species.

*1.data_wrangling_and_PV_curves.Rmd*
  
*2.MEM_field_flam_PV.Rmd*: Mixed effects model comparing MPa~LFM from different methods. 
  
*3.FIGURES_variance_decompositions.Rmd*: Variance decompositions and code for making Fig. 3
  
*4.2.phenology_and_LFM_boxplots_UPDATED.Rmd*: Code for making Fig. 1
 
  
#### Extra Analyses

This folder serves as a place to put any scripts that (a) relate to exploratory analyses, (b) have since been overwritten but still may contain some chunks of code that we may use in the future, or (c) contain analyses that we decided against including in the main text

*field_data_exploratory_figures.Rmd*:
  
*trees_vs_shrubs.Rmd*:
  
*SEKI_figures.Rmd*:
  
**Flammability Segmented Regressions**: 
  
  **1.random_effects**:
  
  **2.bootstrapped**:
  
  *3.segmented_regressions_summary.Rmd*:
  
**Flam. vs. Water Content**:

  *4.1.1_grouped_scaled.Rmd*:
  
  *4.1.2_ungrouped_scaled.Rmd*:
  
  *4.1.3_ungrouped_scaled_by_species.Rmd*:
  
  *4.2_unscaled.Rmd*:
    
#### scripts_functions

This folder stores any source material or functions used in other scripts.

*figure_info_sierra_flammability.R*:
  
*outlierKD2.R*:
  
*plot_facet_flam.R*:
  
*plot_segmented_MEM.R*: 
  
*plotPercentBars_IB.R*:

### Figures: 
This folder contains all figures included in the main text (**main-figures** folder) and the supplementary index (**supp-figures** folder), as well as mixed effect model results tables (**MEM_figures** folder), segmented regression results tables (**segmented_tables** folder) and extra figures and tables that were not included in the main text or supplementary index but were a part of exploratory analyses or were different visualizations for main analyses (**extra-figures** folder). The figure labels describe the figure and, for main and supplementary figures, they are explicitly labelled matching the figures in the paper. 

--------------------------------

## Contact Information

This GitHub repository was worked on by Indra Boving and Joe Celebrezze.

Indra Boving*: bovingi@ucsb.edu

Joe Celebrezze: celebrezze@ucsb.edu

**correspondence*

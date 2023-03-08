# sierra-flammability

## A GitHub Repository for: 

## Pyro-ecophysiology of Sierra Nevada tree and shrub species: flammability, fuel moisture, and water relations mirror fire regime and drought-tolerance strategies (title pending)

### Indra Boving, Joe Celebrezze, and Max Moritz

--------------------------------

## Introductory Statement
This repository is meant for the storage and sharing of data, scripts, figures, and linear mixed effects model results tables related to the above paper. This paper looks at ...

--------------------------------

## Table of Contents

see methods or local papers for how to setup

--------------------------------

## Breakdown of Folders

### Raw Data:
The **raw-data** folder includes ___ datasets in .csv format. Below are brief descriptions of each of these datasets and their use(s); however, for a more comprehensive breakdown of the data, see the metadata.

  *allcurves.csv*:
  
  *CZO_alldata_compiled.csv*: 
  
  *CZO_October_StemsLeaves*: 

... etc.

### Processed Data:
This folder includes ...

### Scripts:
This folder includes four folders, each with scripts that we used to wrangle data, complete analyses, and design tables and figures for the main text, the supplementary index, and for exploratory analyses. The folders (**bold**) and the scripts inside each folder (*italicized*) are described briefly below, and we attempted to annotate the scripts and organize them by headings to make them easier for others to navigate.

#### Flammability

This folder includes scripts relating to tissue flammability of the Sierran species investigated in this paper. Due to the large number of scripts that belong in this folder, it was further divided into other folders, described below. It is also labelled by number, indicating the order that the scripts are meant to be run, although with all of the materials currently on the GitHub, the scripts should run in any order.

**1.data_wrangling**: This folder includes scripts to wrangle raw datasets into more usable formats and combine data from 2020 (CZO or SEKI) and 2021 (CZO only)
  
  *1.1_data_wrangling_2020_CZO.Rmd*:
    
  *1.1_data_wrangling_2021_CZO.Rmd*:
    
  *1.1_data_wrangling_SEKI.Rmd*:
    
  *1.2_data_wrangling_all_sites.Rmd*:
    
*2.PCA.Rmd*:
  
**3.mixed_effects_models**: This folder includes scripts for running linear mixed effects models
    
  **3.1.MEM_flam_metrics**: this includes
    
  **3.2.RWC**:
    
  *3.3_top_MEM_models.Rmd*:
  
**4.flam_vs_water_content**: This folder includes scripts investigating relationships between tissue flammability and hydration (water content or water status)

  *4.1.1_grouped_scaled.Rmd*:
  
  *4.1.2_ungrouped_scaled.Rmd*:
  
  *4.1.3_ungrouped_scaled_by_spp.Rmd*:
  
  *4.2_unscaled.Rmd*:
  
  *4.3_flam_vs_water_content_main.Rmd*: 

*5.flammability_in_context.Rmd*:

#### Physiology

This folder relates to the side of the story regarding the relationship between LFM and water potential and how different drought strategies are involved in the six Sierran species.

*1.data_wrangling_and_PV_curves.Rmd*:
  
*2.predicting_mpa.Rmd*:
  
*3.1.MEM_field_flam_PV.Rmd*:
  
*3.2.variance_decompositions.Rmd*:
  
*4.1.npn_data_access.Rmd*:
  
*4.2.phenology_and_LFM_boxplots.Rmd*:
  
*5.segmented_regressions.Rmd*:
  
#### Extra Analyses

This folder serves as a place to put any scripts that (a) relate to exploratory analyses, (b) have since been overwritten but still may contain some chunks of code that we may use in the future, or (c) contain analyses that we decided against including in the main text

*field_data_exploratory_figures.Rmd*:
  
*trees_vs_shrubs.Rmd*:
  
*SEKI_figures.Rmd*:
  
**Flammability Segmented Regressions**: 
  
  **1.random_effects**:
  
  **2.bootstrapped**:
  
  *3.segmented_regressions_summary.Rmd*:
    
#### scripts_functions

This folder stores any source material or functions used in other scripts.

*figure_info_sierra_flammability.R*:
  
*outlierKD2.R*:
  
*plot_facet_flam.R*:
  
*plot_segmented_MEM.R*: Note that there is also V2 -- delete one
  
*plotPercentBars_IB.R*:

### Figures: 
This folder contains all figures included in the main text (**main-figures** folder) and the supplementary index (**supp-figures** folder), as well as mixed effect model results tables (**MEM_figures** folder), segmented regression results tables (**segmented_tables** folder) and extra figures and tables that were not included in the main text or supplementary index but were a part of exploratory analyses or were different visualizations for main analyses (**extra-figures** folder). The figure labels describe the figure and, for main and supplementary figures, they are explicitly labelled matching the figures in the paper. 

--------------------------------

## Contact Information

This GitHub repository was worked on by Indra Boving and Joe Celebrezze.

Indra Boving*: bovingi@ucsb.edu

Joe Celebrezze: celebrezze@ucsb.edu

**correspondence*
# Correlation project

To run the project you must have the file for the gene expression data for E. coli from Colombos DB.

First, you must run [01_correlation](https://github.com/CamilaVillazon/correlation_project/blob/master/src/01_correlations.R). This R script must be run on a server, as it will take many hour to run (~12 hrs).
This script will create 4 large files, two of whish will be use by the next script.

Whith the [second script](https://github.com/CamilaVillazon/correlation_project/blob/master/src/02_one_col_df.py), two dataframes will be created. This is a python script. The files created hera will be used by the last script, [histograms](https://github.com/CamilaVillazon/correlation_project/blob/master/src/03_histograms.R), an R script that otputs four histograms with the the p-values of the correlations.

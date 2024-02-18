'''
This script creates a file with a single column of the p-values from the correlation
matrices (pearson and spearman) so the data can be used in further analysis
'''

#imports
import pandas as pd

# read pearson p-value csv file
pearson_one_col=[]
with pd.read_csv("pearson_p.csv") as pearson:
     #save values to vector
     for index,row in pearson.iterrows():
          for item in row:
               if item !="NA":
                    pearson_one_col.append(item)

#create one column csv
with open("pearson_one_col.csv", "w") as pear_file:
    for item in pearson_one_col:
        pear_file.write(item)


# read spearman p-value csv file
spearman_one_col=[]
with pd.read_csv("results/spearman_p.csv") as spearman:
     #save values to vector
     for index,row in spearman.iterrows():
          for item in row:
               if item !="NA":
                    spearman_one_col.append(item)
#create one column csv
with open("results/spearman_one_col.csv", "w") as spear_file:
    for item in spearman_one_col:
        pear_file.write(item)
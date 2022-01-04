# README for producing custom Nextstrain build and select C.1.2 figures.
These scripts were all run on a 2015 MacBook Pro, with the 10.14.6 Mojave OS.
These were run using python v3.7.14 (visualisation), python v3.8.10 64-bit (Nextstrain) and R v4.0.3
These have not been tested on other operating systems or software versions

1. Custom NextStrain build: requires files in the Nextstrain_files folder.
A full NextStrain tutorial can be found at https://docs.nextstrain.org/projects/ncov/en/latest/analysis/index.html
This tutorial is comprehensive and covers everything required to run this custom build.
To run this build, set up NextStrain as per the tutorial. 
The files used were:
	- All C.1.2 sequences with < 10% N content available on GISAID as of September 10th 2021
	- All South African sequences on GISAID submitted until Sep 10th 2021, filtered to complete high coverage sequences only with complete date information
	- The GISAID nextregion Africa and global downloads, downloaded September 10th 2021
	- All C.1 sequences on GISAID with < 5% N content, submitted up to September 10th 2021, excluding temporal outliers, outbreak investigation sequences, and 
	  a few potential mis-classifications
	- All C.1.1 sequences on GISAID as of September 10th 2021 (all had high coverage)
These files should all be located in the ncov-master/data/c_master folder (in formats matching what is expected in the builds.yaml inputs - i.e. tsv, fasta, .tar, or .tar.gz
Move the include.txt file to the defaults folder (within ncov-master). 
The include file should ensure that the majority, if not all, of the C.1.2 sequences are included.
Make a C_paper folder (or folder name of choice) in my_profiles and move builds.yaml, config.yaml and my_auspice_config.json to this file
To run the build, activate the nextstrain environment within the ncov folder and run the command: 
	snakemake --profile my_profiles/C_paper -p
Note that this build can take several hours to run.
The final tree can be found in the ncov-master/auspice folder, under the name ncov_c_publish.json and can be visualised with auspice.us
Note that due to the random nature of the sub-sampling scheme, it is unlikely that the exact same tree will be obtained.

2. Figure 1a: open tree JSON in auspice.us, save as SVG and further edit in SVG editor such as Inkscape.

3. Figure 1d: open tree JSON in auspice.us, zoom into the C.1.2 clade, and save as Newick.
Open Newick in FigTree and space as desired. Save. Open saved FigTree output in Inkscape and edit further.

4. Figure 2a: requires C12_heatmap.py.
Dependencies: python >= 3.6, pandas, matplotlib, numpy
Inputs: tsv (tab-separated) file with 4 columns: gene, count, mutation, frequency (example provided: C.1.2_mutation_profile_3sep.tsv)
To run this file, open in IDE of choice. Update line 7 (path) to reflect path where tsv file is stored.
Update line 8 (mutn_file) to name of tsv file.
Update line 10 (fig_path) to path where figure should be stored.
Update line 12 (spikepath) to the path where the spike amino acid file is stored.
Update line 13 (spikefile) to the name of the spike fasta file.
Run file. This should take a few seconds. 
The script will pop up a preview of the image and then save it in the desired outfile.
Output: PDF showing unique and shared C.1.2 mutations coloured by frequency.

5. Supplementary Figure 1a: requires world_c.1.2_map.R
Dependencies: R, maptools, ggplot2, tidyverse, sf, rnaturalearth, rnaturalearthdata, tmap
No inputs required.
To run this file, open in Rstudio/IDE of choice.
Update line 5 (setwd) to reflect the path to where the script is stored.
Update lines 19-21 to include all countries in which C.1.2 has been identified (all countries to be plotted)
Update line 22 to include the count for all countries on the preceding lines.
NB: counts must be in same order as countries.
Run the file. This may take up to a minute. The PDF of the world and Mauritius will be saved in the set working directory.
To produce the manuscript figure, these were combined and edited further in Inkscape.
Output: PDF of world with countries containing C.1.2 coloured various shades of purple, PDF of Mauritius in purple

6. Supplementary Figure 1b,c: requires SA_C.1.2_map.R
Dependencies: R, maptools, ggplot2, tidyverse
No inputs required.
To run this file, open in Rstudio/IDE of choice.
Update line 5 (setwd) to reflect the path to where the script is stored.
NB: the SA shape file should also be stored in this directory.
Update line 22 to include the C.1.2 count for each province in the preceding line.
NB: counts must be in same order as provinces.
Run the file. This may take up to a minute. The PDF of the South Africa will be saved in the set working directory.
Output: PDF of SA with provinces containing C.1.2 coloured various shades of purple
To produce the manuscript figure, these were combined and edited further in Inkscape.
To run this for figure c, replace the C.1.2 counts with total genome counts for the time period of interest.
In line 56, replace the low value with '#ffffff' and the high with '#000000'
In line 57, replace the scale limits, breaks and labels with appropriate values for the dataset.
Run the file as described above.
Output: PDF of SA with provinces coloured various shades of grey/black according to total number of genomes



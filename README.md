# Plot Sex Prediction
R script for plotting the sex based on bam file.

## Dependencies:

R 3.4.4

ggplot2 3.3.0

## Docker
https://hub.docker.com/r/vaktson/gin_plot_sex

## Running the script: 
```
./plot_sex.R input.csv 
``` 


## Output: 
``` 
plot.png
``` 

![ExamplePlot](/example/plot.png)


This script uses the output of the prediction script, taken from:
https://github.com/edawson/check-sex

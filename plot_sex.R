#!/usr/bin/env Rscript
library(ggplot2)

args = commandArgs(trailingOnly=TRUE)
if (length(args)==1) {
  input_file <- args[1]
} else  {
  stop("Please provide only one input file.n", call.=FALSE)
}

input_file = "test_sex.csv"
# expect output from: https://github.com/edawson/check-sex
# looks like: 
# X / Y ratio : 0.9917 
sex_table <- read.csv(input_file, header=FALSE, sep = " ")
sex_value <- sex_table$V3


d <- data.frame(gender =c(0,1,2,3,4,5,6,7,8),patient=Inf)

male <- data.frame(xmin=0.9, xmax=1.5, ymin=-Inf, ymax=Inf)
female <- data.frame(xmin=4.5, xmax=7.0, ymin=-Inf, ymax=Inf)


figure <- ggplot(d, aes(x=Inf, y=Inf))+
  geom_point(aes(x=sex_value, y=1), colour="black", size=5)+ 
  geom_rect(data=male,aes(xmin=xmin,xmax=xmax,ymin=ymin,ymax=ymax),alpha=0.1)+
  geom_rect(data=female,aes(xmin=xmin,xmax=xmax,ymin=ymin,ymax=ymax),alpha=0.1)+
  xlim(0,8)+
  xlab("sex prediction")+
  scale_y_continuous(name="male", breaks=NULL, sec.axis = sec_axis(~., name = "female", breaks=NULL))+
  theme_minimal()

ggsave("plot.png", width=100, height=25, units="mm")

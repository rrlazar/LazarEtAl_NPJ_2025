
# Preparing the environment------------------------------------------------------

#Clear existing data and graphics
rm(list=ls())
graphics.off()


#set up environment

#unload packages that were loaded before (run function twice to "catch" all pkgs)
#to prevent masking

lapply(names(sessionInfo()$otherPkgs), function(pkgs)
  detach(
    paste0('package:', pkgs),
    character.only = T,
    unload = T,
    force = T
  ))

lapply(names(sessionInfo()$otherPkgs), function(pkgs)
  detach(
    paste0('package:', pkgs),
    character.only = T,
    unload = T,
    force = T
  ))


# # Libraries
library(tidyverse)
library(ggthemes)
library(dplyr)
library(scales);
library(ggpmisc)
library(ggplot2)
library(ggpubr)
library(ggsignif)
library(drc)
library(gridExtra)
library(grid);
library(gridtext)
library(DescTools)
library(zoo)
library(cowplot)


block_cols <- c("#999999","darkslategray3", "#E69F00")

#laod data and source plotting functions

source("C:/Users/Rafael Lazar/Documents/Git Projects/TeenLight/06_planned_analysis/plotting_functions.r")

#Condition Spectra  -------------------------------------------------
spectra <- read.csv("./05_demographics/Light/Main_Table_Cond_vert_spectra_luox.csv") %>%
  rename(Wavelength= Wavelength..nm.)

spectra$Wavelength[which.max(spectra$Bright)]

spectra$Wavelength[which.max(spectra$Moderate)]

spectra$Wavelength[which.max(spectra$Dim)]




spectra_L <- spectra %>% pivot_longer(cols=c("Dim", "Moderate", "Bright"))
spectra_L$name <- factor(spectra_L$name, levels=c("Dim", "Moderate", "Bright"))


spectra_plot_log <- gg_light(spectra_L)
#+
 # scale_y_continuous()

spectra_plot_log

ggsave(spectra_plot_log, file = "./08_output/spectra_plot_log.svg", 
       width = 200, height = 110, units = "mm", dpi = 1000)

ggsave(spectra_plot_log, file = "./08_output/spectra_plot_log.tiff", 
       width = 200, height = 110, units = "mm", dpi = 1000)

  
  
spectra_plot<- gg_light(spectra_L)+
 scale_y_continuous()+
  labs(y=expression("Spectral Irradiance"~"["~W~m^{-2}~nm^{-1}*"]"),
       color = "Afternoon to evening light")


spectra_plot

ggsave(spectra_plot, file = "./08_output/spectra_plot.svg", 
       width = 200, height = 110, units = "mm", dpi = 1000)


# spectra Long table




#BlueBlocker transmission  -------------------------------------------------
bb <- read.csv("./05_demographics/Light/AugenLichtSchutz_redXD.csv") 

bb_int <- approx(x=bb$Wavelength, y=bb$value, xout=380:780, method = "linear")


bb_int <-as.data.frame(bb_int)

bb_int$y <- bb_int$y/100

bb_int <- round(bb_int,2)

colnames(bb_int) <- c("Wavelength", "transmission")

write.csv(bb_int, file="./05_demographics/Light/bb_filter_int.csv", row.names = F)



bb <- round(bb,0)

bb$name <- "Augenlichtschutz"

BB_plot <- gg_light(bb)+
  scale_y_continuous(limits=c(0,100),breaks = seq(0,100,25)) +
  labs(y="Transmission [%]")+
  scale_color_manual(legend_title, values ="black")+
  theme(legend.position = "none")

BB_plot

ggsave(BB_plot, file = "./08_output/BB_plot.svg", 
       width = 200, height = 110, units = "mm", dpi = 1000)

#Neutral Density filter -------------------------------------------------


nd <- read.csv("./05_demographics/Light/LeetfilterND_211_0.9_webplotdata_clean.csv") 

nd$value <- nd$value*100
nd <- round(nd,0)

nd$name <- "LeeFilter ND 0.9"

ND_plot <- gg_light(nd)+
  scale_y_continuous(limits=c(0,100),breaks = seq(0,100,25)) +
  labs(y="Transmission [%]")+
  scale_color_manual(legend_title, values ="black")+
  theme(legend.position = "none")
ND_plot

ggsave(ND_plot, file = "./08_output/ND_plot.svg", 
       width = 200, height = 110, units = "mm", dpi = 1000)

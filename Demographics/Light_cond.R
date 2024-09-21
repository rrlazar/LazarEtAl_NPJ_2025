
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

# Install and load pacman if not already installed
if (!require("pacman")) install.packages("pacman")

# Load all the necessary packages using pacman
pacman::p_load(
  tidyverse,  
  psych,       
  ggthemes,  
  scales,   
  ggplot2,         
  ggpubr,    
  gridExtra,
  grid,
  cowplot, 
  here
  
)






#source plotting functions--------------------------------------------------
ar<- 1/1
shape_datapoints = 21
size_datapoints = 1.5
stroke_datapoints = 0.5 # thickness of circles
block_cols <- c("#999999","darkslategray3", "#E69F00")
margins = unit(c(1, 0.5, 1, 1), 'mm')
pd <- ggplot2::position_dodge(0)
linetypes <- c(5,6,1)
linesize <- 0.6
legend_title <- "AEE light intervention"


gg_light <-function(dataset) {
  ggplot(dataset, aes(x=Wavelength, y=value, col=name,
  ))+
    
    #0 set specific colouring & types
    scale_color_manual(legend_title, values = block_cols)+
    scale_linetype_manual(legend_title, values = linetypes)+
    scale_fill_manual(legend_title, values = block_cols)+
    
    # 2 set up axes breaks
    scale_x_continuous(limits=c(380,780), 
                       breaks =c(seq(380,780,40)))+
    
    scale_y_log10()+
    labs(x="Wavelength [nm]", 
         y=expression("Spectral Irradiance"~"["*log[10]~(W~m^{-2}~nm^{-1})*"]"))+
    
    #3 set up line, points & errorbar 
    geom_line(position=pd, size=linesize, lwd=1)+
    # 4 Theme settings
    theme(aspect.ratio = ar)+
    theme(axis.title.x = element_blank())+    
    theme(axis.title.y = element_text(face="plain", size=12, vjust = 1))+                                 
    theme(plot.title = element_text(face="bold", size = 18, vjust=1.5))+
    theme(plot.subtitle = element_text(size = 12, vjust=1.5, face="bold"))+
    theme(legend.title = element_text(size = 12, face="bold"))+
    theme(legend.text = element_text(size = 12))+
    theme(axis.line.x = element_line(colour = "black"), 
          axis.line.y = element_line(colour = "black"),
          panel.grid.minor = element_blank(), 
          panel.grid.major = element_blank(),
          panel.border = element_blank(),
          panel.background = element_blank(),
          plot.margin= margins,
          legend.position = "bottom",
          legend.justification = "center",
          axis.ticks.length=unit(0.2,"cm"))+
    theme_classic()
  
}


#Condition Spectra  -------------------------------------------------

spectra <-  read.csv(file = here("Demographics/light data", "Main_Table_Cond_vert_spectra_luox.csv"))%>%
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

ggsave(spectra_plot_log, file = "./Demographics/light data/spectra_plot_log.svg", 
       width = 200, height = 110, units = "mm", dpi = 1000)
  
  
spectra_plot<- gg_light(spectra_L)+
 scale_y_continuous()+
  labs(y=expression("Spectral Irradiance"~"["~W~m^{-2}~nm^{-1}*"]"),
       color = "Afternoon to evening light")


spectra_plot

ggsave(spectra_plot, file = "./Demographics/light data/spectra_plot.svg", 
       width = 200, height = 110, units = "mm", dpi = 1000)


#BlueBlocker transmission  -------------------------------------------------
bb <-  read.csv(file = here("Demographics/light data", "AugenLichtSchutz_redXD.csv"))

bb <- round(bb,0)

bb$name <- "Augenlichtschutz"

BB_plot <- gg_light(bb)+
  scale_y_continuous(limits=c(0,100),breaks = seq(0,100,25)) +
  labs(y="Transmission [%]")+
  scale_color_manual(legend_title, values ="black")+
  theme(legend.position = "none")

BB_plot

ggsave(BB_plot, file = "./Demographics/light data/BB_plot.svg", 
       width = 200, height = 110, units = "mm", dpi = 1000)


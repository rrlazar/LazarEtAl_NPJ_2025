### Prepare environment -----------------------------------------
#Clear existing data and graphics
rm(list=ls())
graphics.off()



#unload packages that were loaded before (run function twice to "catch" all pkgs)
#this is a workaround to avoid masking problems when running the scripts successively
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
  tidyverse,   # Data manipulation and visualization
  psych,       # Psychological statistics functions
  lubridate,   # Date-time manipulation
  gtsummary,   # Summary tables
  gt,          # Advanced table formatting
  webshot2,    # Taking screenshots of HTML tables
  here         # Simplified file path management
)


# add a function for computing midpoint of scheduled sleep


# Function to calculate the midpoint
calculate_midpoint <- function(time1, time2) {
  # Calculate the total seconds in a day
  seconds_in_day <- 24 * 3600
  
  # Convert hms to seconds
  time1_seconds <- as.numeric(time1)
  time2_seconds <- as.numeric(time2)
  
  # Handle the transition over midnight
  if (time2_seconds >= time1_seconds) {
    midpoint_seconds <- time1_seconds + (time2_seconds - time1_seconds) / 2
  } else {
    midpoint_seconds <- time1_seconds + (time2_seconds + seconds_in_day - time1_seconds) / 2
    if (midpoint_seconds >= seconds_in_day) {
      midpoint_seconds <- midpoint_seconds - seconds_in_day
    }
  }
  
  # Convert back to hms
  midpoint_seconds/3600
}

### [1] Demographic data preparation -------------------------------------------
#Prepare data for demographic tables & figure

#load complete merged dataset
#load(file="./01_redcap_data/Covar_data.rda")

load(file = here("Datasets", "Covar_data.rda"))




#drop factor levels of dem_Data because they interfere with creating the 
#demographic table
dem_data <- Covar_data
  #droplevels(Covar_data)

#[2] Demographic table ---------------------------------------------------------
#create demographic table with gt summary:

#first categorize the data into data types.
#then include only varaibles needed for the table
#define decimal digits for continouus data
#relabel the variabes for the demographic table (Table 1)
#modify the header format

levels(dem_data$gh_medi_contr.factor)<- c("Yes", "No")
levels(dem_data$dem_sex.factor) <- c("Female", "Male","Intersexual" )
dem_data$pub_stage <- factor(dem_data$pub_stage, 
                             levels=c('Early pubertal', 'Midpubertal',
                                      'Late pubertal', 'Postpubertal'))
dem_data <- droplevels(dem_data)

dem_data$midpoint <- mapply(calculate_midpoint, dem_data$crf_inprs_hbt, dem_data$crf_inprs_hwt)
dem_data$crf_inprs_hbt <- as.numeric(dem_data$crf_inprs_hbt)/3600
dem_data$crf_inprs_hwt<- as.numeric(dem_data$crf_inprs_hwt)/3600

mean(dem_data$crf_inprs_hbt)
sd(dem_data$crf_inprs_hbt)

dem_data %>%
  tbl_summary(
    type = list(everything() ~ "continuous",
                     #"Cond_seq" ~ "categorical",
                    #"dem_age" ~ "categorical",
                    "dem_sex.factor" ~ "categorical",
                     "pub_stage" ~ "categorical",
                     #"crf_inprs_hbt" ~ "categorical",
                     #"crf_inprs_hwt" ~ "categorical",
                    #"gh_medi_contr.factor" ~ "dichotomous",
                    #"crf_inprs_iris.factor" ~ "categorical",
                    "season" ~ "categorical"#,
                    #"crf_date_exm_s2" ~ "categorical"
                    ),
  
    statistic = list(
       all_continuous() ~ "{mean} ({sd})",
       all_categorical() ~ "{n} ({p}%)"),
       by = dem_sex.factor,
        include = c(-record_id, -record_id, -crf_date_exm_s1, -crf_date_exm_s3,
                    -crf_date_exm_s2, -Cond_seq, #
                    -psqi_sc4_calc5_efficiency, -gh_medi_contr.factor, -midpoint#,- crf_inprs_hbt, -crf_inprs_hwt
                    ),
    digits = all_continuous() ~ 2,
    label = list(#Cond_seq ~ "Condition sequence",
                 dem_age ~ "Age [years]",
                 #dem_sex.factor ~ "Sex",
                 mctq_sc4_chronotype ~ "Chronotype (MSFsc)",
                 crf_inprs_hbt ~ "Agreed habitual bedtime [hours]",
                 crf_inprs_hwt ~ "Agreed habitual wake time [hours]",
                 mctq_outdoorsmin_fd ~ "Time outdoors on free days [hours]",
                 mctq_outdoorsmin_wd ~ "Time outdoors on school days [hours]",
                 crf_inprs_bmi ~ "Body Mass Index (BMI)",
                 #psqi_sc4_calc5_efficiency ~ "Sleep effiency (PSQI)",
                 psqi_sc0_total ~ "PSQI score",
                 #gh_medi_contr.factor ~ "Using hormonal contraceptives",
                 #crf_inprs_iris.factor ~ "Iris colour",
                 pub_stage ~ " Self-reported pubertal stage (Tanner) ",
                 season ~ "Season"
                 #crf_date_exm_s2 ~ "Date of first experiment"
                 ),
    missing = "no",
    missing_text = "(Missing)"
  ) %>%   
  bold_labels()  %>%
  #add_overall() %>% 
  modify_header(label ~ "**Variable**") -> desc_table 

desc_table

#format the table as gt object
desc_table  %>%   as_gt() -> desc_table_gt 
#set the font to Arial
desc_table_gt <- opt_table_font(data= desc_table_gt, font = "Arial")  %>%
  #adjust the cell bodies and footnotes to be fontsize 9
  tab_style(style=cell_text(size=px(11)), locations=list(cells_body(),
                                                            cells_footnotes()
                                                            )
  ) %>%
  #adjust the cell title to be fontsize 9.75
  tab_style(style=cell_text(size=px(13)),
                            locations=cells_column_labels()
            ) %>% tab_options(data_row.padding = px(4)) 


  gtsave(desc_table_gt,        # save table as pdf
    filename = "Demographics/dem_tab.pdf")

  
  

  # Notes-------------------------------------------------------------------
 # average midsleep of the fixed schedule data
  
  df <- Covar_data[,1:9] 
  
  
 # Function to calculate the midpoint
calculate_midpoint <- function(time1, time2) {
  # Calculate the total seconds in a day
  seconds_in_day <- 24 * 3600
  
  # Convert hms to seconds
  time1_seconds <- as.numeric(time1)
  time2_seconds <- as.numeric(time2)
  
  # Handle the transition over midnight
  if (time2_seconds >= time1_seconds) {
    midpoint_seconds <- time1_seconds + (time2_seconds - time1_seconds) / 2
  } else {
    midpoint_seconds <- time1_seconds + (time2_seconds + seconds_in_day - time1_seconds) / 2
    if (midpoint_seconds >= seconds_in_day) {
      midpoint_seconds <- midpoint_seconds - seconds_in_day
    }
  }
  
  # Convert back to hms
  midpoint_seconds/3600
}

# Apply the function to the data frame
df$midpoint <- mapply(calculate_midpoint, df$crf_inprs_hbt, df$crf_inprs_hwt)


mean(df$crf_inprs_hbt/3600)
sd(df$midpoint)

mean(df$midpoint)
sd(df$midpoint)


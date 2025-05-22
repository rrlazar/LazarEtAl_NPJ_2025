# Afternoon to early evening bright light exposure reduces later melatonin production in adolescents
Code and data for the Lazar et al 2025 manuscript.

# Licensing

This repository contains the datasets and analysis code of the manuscript "Afternoon to early evening bright light exposure reduces later melatonin production in adolescents". The datasets are licensed under CC BY-NC 4.0, while all R code is licensed under MIT.


## Light dataset names

- bbspectacles		= Dataset containing the transmission of short-wavelength filter glasses (applied out of the laboratory.

- vert_spectra		= Dataset containing the spectral irradiance distribution per AAE light interventions (Wavelength, Dim, Moderate Bright) during 			task-free periods (curtains closed). The vertical light measurements were taken with a spectroradiometer placed at the eye level 			of the seated participants (115 cm from the floor, 85 cm from the overhead light source, 80 cm from the white curtain, Spectraval 			1501, JETI Technische Instrumente GmbH, Jena, Germany, last calibration: 07.03.2023). 

## Statistics Dataset names:

- arvo_DPG		= Dataset containing the Distal-proximal skin temperature gradient (DPG) during the AEE light intervention - used for post-hoc 				hypothesis testing.
- arvo_KSS		= Dataset containing the Subjective sleepiness/alertness ratings (kss) assessed with the Karolinska Sleepiness Scale during the 			AEE light intervention - used for post-hoc hypothesis testing.
- arvo_PVT_stat		= Dataset containing the vigilance performance data (value) assessed with the auditory Psychomotor Vigilance Task (PVT) during the 			AEE light intervention - used for post-hoc hypothesis testing.
- Covar_data		= Demographic data for the participants, also including the data used as covariates.

- eve_DPG		= Dataset containing the Distal-proximal skin temperature gradient (DPG) during the later evening light - used for a-priori 				hypothesis testing.
- eve_KSS		= Dataset containing the Subjective sleepiness/alertness ratings (kss) assessed with the Karolinska Sleepiness Scale (KSS) during 			the later evening light - used for a-priori hypothesis testing.
- eve_PVT_stat		= Dataset containing the Vigilance performance data (value) assessed with the auditory Psychomotor Vigilance Task (PVT) during the 			later evening light - used for a-priori hypothesis testing.
- Mel_summary		= Dataset containing the primary outcome "Evening salivary melatonin AUC" (auc_mel_eve)  - used for a-priori hypothesis 				testing; and morning melatonin AUC (auc_mel_mor) - used for an exploratory analysis (see Supplementary information). 	
- merged_mel_timing_HS	= Dataset containing the melatonin onsets (HS_time).


## Statistics dataset variable names:

- auc_mel_eve 		= Evening melatonin AUC (pg/ml/h) [numeric]
- auc_mel_mor 		= Next morning melatonin AUC (pg/ml/h) - based on 2 morning samples each [numeric]
- Block 		= Afternoon to evening light intervention condition [factor]
- centered_time		= median centred time variable (“time=0” refers to the middle of each tested time period) [numeric]
- Cond_seq		= Sequence of the experimental conditions: D=Dim, M=Moderate, B=Bright; DMB means 1st dim, 2nd moderate, 3rd bright. [factor]
- D1_TAT1k		= Wrist-recorded bright light history from the day before the experiment until lab entry (~32 h span) [numeric]
- dem_age		= Age of the participant  [numeric]
- dem_sex.factor	= Sex assigned at birth of the participant [factor]
- Dist			= Distal skin temperature  [numeric]
- DPG			= Distal-proximal skin temperature gradient [numeric]
- Feet			= Skin temperature on the feet (ankle) [numeric]
- Hands			= Skin temperature on the hands (wrist) [numeric]
- HS_time		= Melatonin onset time given in decimal hours [numeric]
- hafterlight		= Time in hours after the afternoon light intervention started [numeric]
- hbeforehbt		= Time in hours before the scheduled habitual bedtime at home [numeric]
- kss			= Karolinska Sleepiness Scale rating (KSS) between 1 and 9 [numeric]
- mctq_sc4_chronotype 	= Self-report based chronotype - MSFsc midpoint of sleep on free days, corrected for oversleep. [numeric]
- minafterlight		= Time in minutes after the afternoon light intervention started [numeric]
- minbeforehbt		= Time in minutes before the scheduled habitual bedtime at home [numeric]
- Number		= Number of sample in the protocol (e.g. melatonin, kss).
- phase			= Phase of the experiment: baseline, transition, arvoli= afternoon light intervention, eveli= evening light condition [factor]
- Prox			= Proximal skin temperature  [numeric]
- pub_stage 		= Self-report based pubertal stage [factor]
- record_id 		= Participant identification number [factor]
- Value			= Temperature value of single iButtons (including room temperature) [numeric]


###  PVT variable names

#### These variable names are different in the PVT analysis, since previously existing code was utilized.

- cond			= Block (see above) [factor]
- pvt_no		= Number of the PVT in the protocol [numeric] 
- value			= numeric value of the respective PVT variable [numeric]
- variable		= PVT specific variables: mdn = median, mean, fast10per = Fastest 10 percent, mean_1divRT = Mean response speed (1/RT), 
			no_lapses = Number of lapses, slow10per_RT= Slowest 10% Reaction time, slow10per_1divRT= Response speed in the slowest 10%, 				lapse_prob= Lapse probability, no_falsestart= Number of false starts, lapse+falsestart= Number of lapses + false starts, 
			performance = PVT Performance Score [factor]
 
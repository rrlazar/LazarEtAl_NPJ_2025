# LazarEtAl_NatHumBehav_2024
Code and data for the Lazar et al 2024 publication


## Variable names:

- auc_mel_eve 		= Evening melatonin AUC (pg/ml/h) [numeric]
- auc_mel_mor 		= Next morning melatonin AUC (pg/ml/h) - based on 2 morning samples each [numeric]
- kss			= Karolinska Sleepiness Scale rating (KSS) between 1 and 9 [numeric]
- DPG			= Distal-proximal skin temperature gradient [numeric]
- Dist			= Distal skin temperature  [numeric]
- Prox			= Proximal skin temperature  [numeric]
- Hands			= Skin temperature on the hands (wrist) [numeric]
- Feet			= Skin temperature on the feet (ankle) [numeric]
- Value			= Temperature value of single iButtons (including room temperature) [numeric]


- phase			= Phase of the experiment: baseline, transition, arvoli= afternoon light intervention, eveli= evening light condition [factor]
- minafterlight		= Time in minutes after the afternoon light intervention started [numeric]
- minbeforehbt		= Time in minutes before the scheduled habitual bedtime at home [numeric]
- hafterlight		= Time in hours after the afternoon light intervention started [numeric]
- hbeforehbt		= Time in hours before the scheduled habitual bedtime at home [numeric]
- Number		= Number of sample in the protocol (e.g. melatonin, kss).
- centered_time		= median centred time variable (“time=0” refers to the middle of each tested time period) [numeric]
- record_id 		= Participant identification number [factor]
- Block 		= Afternoon to evening light intervention condition [factor]
- pub_stage 		= Self-report based pubertal stage [factor]
- mctq_sc4_chronotype 	= Self-report based chronotype - MSFsc midpoint of sleep on free days, corrected for oversleep. [numeric]
- D1_TAT1k		= Wrist-recorded bright light history from the day before the experiment until lab entry (~32 h span) [numeric]
- dem_age		= Age of the participant  [numeric]
- dem_sex.factor	= Sex assigned at birth of the participant [factor]
- Cond_seq		= Sequence of the experimental conditions: D=Dim, M=Moderate, H=Bright;  Thus DMH means first session dim, then moderate than 				bright. [factor]


###  PVT

#### These variable names are different in the PVT analysis, since previously existing code was utilized.

- cond			= Block (see above) [factor]
- pvt_no		= Number of the PVT in the protocol [numeric] 
- value			= numeric value of the respective PVT variable [numeric]
- variable		= PVT specific variables: mdn = median, mean, fast10per = Fastest 10 percent, mean_1divRT = Mean response speed (1/RT), 
			no_lapses = Number of lapses, slow10per_RT= Slowest 10% Reaction time, slow10per_1divRT= Response speed in the slowest 10%, 				lapse_prob= Lapse probability, no_falsestart= Number of false starts, lapse+falsestart= Number of lapses + false starts, 
			performance = PVT Performance Score [factor]
 
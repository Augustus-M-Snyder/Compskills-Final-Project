The dataset is a table with 104 rows corresponding to fish individuals
and 38 columns corresponding to variables.

Each variable is either a primary variable or a derived variable which
can be calculated from one or several primary variables. The minimum
dataset for reproducibility would consist only of the primary variables;
the derived variables are provided for convenience.

- fish_id (primary): Unique identifier for each individual
- month (primary): Date (month) of sampling ("july" or "september")
- origin (primary): River of origin ("mustoja" or "vainupea")
- length (primary): Fork length in mm, measured from snout to the end of
  the middle caudal fin
- mass (primary): Body mass in g
- body_depth (primary): Thickness of the body in cross-section
  photographies (cf. fig.1A)
- kidney_depth (primary): Thickness of the kidney in cross-section
  photographies (cf. fig.1A)
- KB_ratio (derived): Measure of kidney hyperplasia, calculated as
  kidney_depth/body_depth
- qPCR_ddCt (primary): Relative parasite load calculated from the qPCR
  experiments as 2.exp(-ΔΔCT)
- qPCR_sqrt (derived): Square-root transformed values of qPCR_ddCt
- haematocrit (primary): Mean haematocrit, representing the average
  haematocrit for one, two or three capillaries depending on the amount
  of blood collected for each fish
- leukocrit (primary): Mean leukokrit, representing the average
  leukokrit for one or two capillaries depending on the amount of blood
  collected for each fish
- lymphocyte_count (primary): Estimate of lymphocyte count per 10000 red
  blood cells
- monocyte_count (primary): Estimate of monocyte count per 10000 red
  blood cells
- granulocyte_count (primary): Estimate of granulocyte count per 10000
  red blood cells
- thrombocyte_count (primary): Estimate of thrombocyte count per 10000
  red blood cells
- lymphocyte_concentration_sqrt (derived): Proxy for lymphocyte blood
  concentration calculated as lymphocyte_count*haematocrit (obtained
  values are then square-root transformed)
- monocyte_concentration_sqrt (derived): Proxy for monocyte blood
  concentration calculated as monocyte_count*haematocrit (obtained
  values are then square-root transformed)
- granulocyte_concentration_sqrt (derived): Proxy for granulocyte blood
  concentration calculated as granulocyte_count*haematocrit (obtained
  values are then square-root transformed)
- thrombocyte_concentration_sqrt (derived): Proxy for thrombocyte blood
  concentration calculated as thrombocyte_count*haematocrit (obtained
  values are then square-root transformed)
- SMR_1, SMR_2, SMR_3 (primary): Standard metabolic rate (SMR) estimates
  (mol O2 per min) obtained during the respirometry experiment
- MMR_1, MMR_2, MMR_3 (primary): Maximum metabolic rate (MMR) estimates
  (mol O2 per min) obtained during the respirometry experiment
- SMR_mean (derived): Mean of SMR estimates (mol 02 per min), calculated
  from SMR_1, SMR_2 and SMR_3
- MMR_mean (derived): Mean of MMR estimates (mol O2 per min), calculated
  from MMR_1, MMR_2 and MMR_3
- AS (derived): Aerobic scope (AS) (mol O2 per min), calculated as
  MMR_mean-SMR_mean
- SMR_std (derived): Mass-specific standardised SMR (mol O2 per min per
  g), calculated from SMR_mean and weight (see Appendix S1 for details
  on the calculation)
- MMR_std (derived): Mass-specific standardised MMR (mol O2 per min per
  g), calculated from MMR_mean and weight (see Appendix S1 for details
  on the calculation)
- AS_std (derived): Mass-specific standardised AS (mol O2 per min per
  g), calculated from AS and weight (see Appendix S1 for details on the
  calculation)
- UTT_trial (primary): UTT trial identifier. Fish with the same
       UTT_trial underwent UTT measurement in the same trial.
- UTT_temperature (primary): Temperature when loss of righting response
  (LRR) occurred, in Celsius degrees
- UTT_rank (primary): Rank of LRR within an UTT trial. Fish with rank 1
  are the first ones to lose balance within their UTT trial batch.
- UTT_degree_sec (primary): UTT performance measured as the area under
  the curve representing water temperature as a function of time since
  the beginning of the trial until the loss of balance for each
  individual (in degree.seconds, using a baseline at 21.1°)
- UTT_degree_sec_centered (derived): UTT_degree_sec values centered
  within each UTT_trial batch

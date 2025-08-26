# ctcae5_grader
ctcae5_grader is a SAS macro package that automates the grading of laboratory tests according to CTCAE v5.0. It standardises grading rules for common laboratory parameters (e.g. haematology, biochemistry, electrolytes) and provides character and numeric grade outputs. DESCRIPTION END:

<img width="300" height="300" alt="Image" src="https://github.com/user-attachments/assets/078be8bd-3ff3-4359-b30e-1f8f53921685" />   

### Overview and image of usage
~~~sas
data lab_testcases;
  length PARAMCD $12 AVALU $16;
  infile datalines dsd truncover;
  input PARAMCD :$12. AVAL AVALU :$16. ANRLO ANRHI BASE MFRHI;
  datalines;
HGB,  14.5,g/dL,  12, 13.5, .,   .
HGB,  15.4,g/dL,  12, 14.0, .,   .
HGB,  17.0,g/dL,  12, 12.5, .,   .
HGB,   7.5,g/dL,  12, 13.5, .,   .
ALT,   70,  U/L,   .,  40,   30,  .
ALT,  900,  U/L,   .,  40,   60,  . 
NEUT,  0.8, 10^9/L, 1.5, .,  .,   .
NEUT,  0.45,10^9/L, 1.5, .,  .,   .
;
run;

data lab_checked;
  set lab_testcases;
  %CTCAE5_HGB()
  %CTCAE5_ALT()
  %CTCAE5_NEUT()
run;
~~~
<img width="1886" height="355" alt="Image" src="https://github.com/user-attachments/assets/6ec8ef37-da42-43c7-ba39-adec71379a5e" />

## `%ctcae5_alb()` macro <a name="ctcae5alb-macro-1"></a> ######
Parameters    :
~~~text
  PARAMCD = Variable name (expected "ALB")
  AVAL    = Observed value (Albumin result)
  AVALU   = Unit (expected "g/dL" or "g/L")
  ANRLO   = Lower limit of normal (LLN)
~~~
Grading Criteria (CTCAE v5.0 - Albumin):  
~~~text
  Units in "g/dL":
    - value < LLN and >= 3.0             -> Grade 1
    - 2.0 <= value < 3.0                 -> Grade 2
    - value < 2.0                       -> Grade 3

  Units in "g/L":
    - value < LLN and >= 30              -> Grade 1
    - 20 <= value < 30                   -> Grade 2
    - value < 20                        -> Grade 3
~~~  
---
 ## `%ctcae5_alp()` macro <a name="ctcae5alp-macro-2"></a> ######
Parameters    :  
~~~text
  PARAMCD = Variable name (expected "ALP")
  AVAL    = Observed value (ALP result, in U/L)
  BASE    = Baseline value
  ANRHI   = Upper limit of normal (ULN)
~~~
Grading Criteria (CTCAE v5.0 - Alkaline Phosphatase):  
~~~
  If baseline <= ULN:
    - ULN < value <= 2.5 * ULN          -> Grade 1
    - 2.5 * ULN < value <= 5 * ULN      -> Grade 2
    - 5 * ULN < value <= 20 * ULN       -> Grade 3
    - value > 20 * ULN                 -> Grade 4

  If baseline > ULN:
    - 2 * baseline < value <= 2.5 * baseline   -> Grade 1
    - 2.5 * baseline < value <= 5 * baseline  -> Grade 2
    - 5 * baseline < value <= 20 * baseline   -> Grade 3
    - value > 20 * baseline                  -> Grade 4
~~~
---
 ## `%ctcae5_alt()` macro <a name="ctcae5alt-macro-3"></a> ######
Parameters    :  
~~~text
  PARAMCD = Variable name (expected "ALT")
  AVAL    = Observed value (ALT result, in U/L)
  BASE    = Baseline value
  ANRHI   = Upper limit of normal (ULN)
~~~
Grading Criteria (CTCAE v5.0 - Alanine Aminotransferase):  
~~~text
  If baseline <= ULN:
    - ULN < value <= 3 * ULN            -> Grade 1
    - 3 * ULN < value <= 5 * ULN        -> Grade 2
    - 5 * ULN < value <= 20 * ULN       -> Grade 3
    - value > 20 * ULN                 -> Grade 4

  If baseline > ULN:
    - 1.5 * baseline < value <= 3 * baseline   -> Grade 1
    - 3 * baseline < value <= 5 * baseline     -> Grade 2
    - 5 * baseline < value <= 20 * baseline    -> Grade 3
    - value > 20 * baseline                   -> Grade 4
~~~
---
 ## `%ctcae5_aptt()` macro <a name="ctcae5aptt-macro-4"></a> ######
Parameters    :  
~~~text
  PARAMCD = Variable name (expected "APTT")
  AVAL    = Observed value (APTT result, in seconds)
  ANRHI   = Upper limit of normal (ULN)
~~~
Grading Criteria (CTCAE v5.0 - Activated Partial Thromboplastin Time):  
~~~text
  Prolonged (Above ULN)
    - ULN < value <= 1.5 * ULN          -> Grade 1
    - 1.5 * ULN < value <= 2.5 * ULN    -> Grade 2
    - value > 2.5 * ULN                -> Grade 3
~~~  
---
## `%ctcae5_ast()` macro <a name="ctcae5ast-macro-5"></a> ######
Parameters    :  
~~~text
  PARAMCD = Variable name (expected "AST")
  AVAL    = Observed value (AST result, in U/L)
  BASE    = Baseline value
  ANRHI   = Upper limit of normal (ULN)
~~~
Grading Criteria (CTCAE v5.0 - Aspartate Aminotransferase):
~~~text
  If baseline <= ULN:
    - ULN < value <= 3 * ULN            -> Grade 1
    - 3 * ULN < value <= 5 * ULN        -> Grade 2
    - 5 * ULN < value <= 20 * ULN       -> Grade 3
    - value > 20 * ULN                 -> Grade 4

  If baseline > ULN:
    - 1.5 * baseline < value <= 3 * baseline   -> Grade 1
    - 3 * baseline < value <= 5 * baseline     -> Grade 2
    - 5 * baseline < value <= 20 * baseline    -> Grade 3
    - value > 20 * baseline                   -> Grade 4
~~~  
---
## `%ctcae5_bili()` macro <a name="ctcae5bili-macro-6"></a> ###### 
Parameters    :  
~~~text
  PARAMCD = Variable name (expected "BILI")
  AVAL    = Observed value (Total Bilirubin result, in mg/dL)
  BASE    = Baseline value
  ANRHI   = Upper limit of normal (ULN)
~~~
Grading Criteria (CTCAE v5.0 - Total Bilirubin):  
~~~text
  If baseline <= ULN:
    - ULN < value <= 1.5 * ULN          -> Grade 1
    - 1.5 * ULN < value <= 3 * ULN      -> Grade 2
    - 3 * ULN < value <= 10 * ULN       -> Grade 3
    - value > 10 * ULN                 -> Grade 4

  If baseline > ULN:
    - baseline < value <= 1.5 * baseline   -> Grade 1
    - 1.5 * baseline < value <= 3 * baseline -> Grade 2
    - 3 * baseline < value <= 10 * baseline -> Grade 3
    - value > 10 * baseline                -> Grade 4
~~~  
---
## `%ctcae5_ca()` macro <a name="ctcae5ca-macro-7"></a> ######
Parameters    :  
~~~text
  PARAMCD = Variable name (expected "CA")
  AVAL    = Observed value (Calcium result)
  AVALU   = Unit (expected "mg/dL")
  ANRLO   = Lower limit of normal (LLN)
  ANRHI   = Upper limit of normal (ULN)
  TESTCD  = Lab test code (default "CA")
~~~
Grading Criteria (CTCAE v5.0 - Calcium):  
~~~text
  High (Hypercalcemia):
    - ULN < value <= 11.5                -> Grade 1
    - 11.5 < value <= 12.5               -> Grade 2
    - 12.5 < value <= 13.5               -> Grade 3
    - value > 13.5                      -> Grade 4

  Low (Hypocalcemia):
    - value < LLN and <= 8.0             -> Grade 1
    - 7.0 <= value < 8.0                 -> Grade 2
    - 6.0 <= value < 7.0                 -> Grade 3
    - value < 6.0                       -> Grade 4
~~~
---
## `%ctcae5_cd4()` macro <a name="ctcae5cd4-macro-8"></a> ######
Parameters    :  
~~~text
  PARAMCD = Variable name (expected "CD4")
  AVAL    = Observed value (CD4+ T-cell count)
  AVALU   = Unit (expected either per volume, e.g., "/mm3", "10^6/L", or "10^9/L")
  ANRLO   = Lower limit of normal (LLN)
~~~
Grading Criteria (CTCAE v5.0 - CD4 Count):  
~~~text
  Units in "/mm3", "10^6/L", "/uL", "10^3/mL", "M/L":
    - value < LLN and <= 500              -> Grade 1
    - 200 <= value < 500                  -> Grade 2
    - 50 <= value < 200                   -> Grade 3
    - value < 50                         -> Grade 4

  Units in "10^9/L", "/nL", "10^3/uL", "10^6/mL", "G/L":
    - value < LLN and <= 0.5              -> Grade 1
    - 0.2 <= value < 0.5                  -> Grade 2
    - 0.05 <= value < 0.2                 -> Grade 3
    - value < 0.05                       -> Grade 4
~~~
--- 
## `%ctcae5_chol()` macro <a name="ctcae5chol-macro-9"></a> ######
Parameters    :  
~~~text
  PARAMCD = Variable name (expected "CHOL")
  AVAL    = Observed value (Cholesterol result)
  AVALU   = Unit (expected "mg/dL" or "mmol/L")
  ANRHI   = Upper limit of normal (ULN)
~~~
Grading Criteria (CTCAE v5.0 - Cholesterol):  
~~~text
  Units in "mg/dL":
    - ULN < value <= 300                 -> Grade 1
    - 300 < value <= 400                 -> Grade 2
    - 400 < value <= 500                 -> Grade 3
    - value > 500                       -> Grade 4

  Units in "mmol/L":
    - ULN < value <= 7.75                -> Grade 1
    - 7.75 < value <= 10.34              -> Grade 2
    - 10.34 < value <= 12.92             -> Grade 3
    - value > 12.92                     -> Grade 4
~~~
---
## `%ctcae5_ck()` macro <a name="ctcae5ck-macro-10"></a> ######
Parameters    :  
~~~text
  PARAMCD = Variable name (expected "CK")
  AVAL    = Observed value (Creatine Kinase result, in U/L)
  ANRHI   = Upper limit of normal (ULN)
~~~
Grading Criteria (CTCAE v5.0 - Creatine Kinase):  
~~~text
  High (Above ULN)
    - ULN < value <= 2.5 * ULN           -> Grade 1
    - 2.5 * ULN < value <= 5 * ULN       -> Grade 2
    - 5 * ULN < value <= 10 * ULN        -> Grade 3
    - value > 10 * ULN                  -> Grade 4
~~~
---
## `%ctcae5_creat()` macro <a name="ctcae5creat-macro-11"></a> ######
Parameters    :  
~~~text
  PARAMCD = Variable name (expected "CREAT")
  AVAL    = Observed value (Creatinine result, e.g., mg/dL or ・ｽ・ｽmol/L)
  ANRHI   = Upper limit of normal (ULN)
~~~
Grading Criteria (CTCAE v5.0 - Creatinine):  
~~~text
  High (Above ULN)
    - ULN < value <= 1.5 * ULN           -> Grade 1
    - 1.5 * ULN < value <= 3 * ULN       -> Grade 2
    - 3 * ULN < value <= 6 * ULN         -> Grade 3
    - value > 6 * ULN                   -> Grade 4
~~~
---
## `%ctcae5_dlco()` macro <a name="ctcae5dlco-macro-12"></a> ######
Parameters    :  
~~~text
  PARAMCD = Variable name (expected "DLCO")
  AVAL    = Observed value (DLCO result)
  AVALU   = Unit (e.g., mL/min/mmHg or % predicted)
  BASE    = Baseline value
  ANRLO   = Lower limit of normal (LLN)
~~~
Grading Criteria (CTCAE v5.0 - DLCO):  
~~~text
  Compared with LLN:
    - 0 < (LLN - value) <= 3            -> Grade 1
    - 3 < (LLN - value) <= 5            -> Grade 2
    - 5 < (LLN - value) <= 8            -> Grade 3
    - (LLN - value) > 8                -> Grade 4

  Compared with Baseline:
    - 0 < (Baseline - value) <= 3       -> Grade 1
    - 3 < (Baseline - value) <= 5       -> Grade 2
    - 5 < (Baseline - value) <= 8       -> Grade 3
    - (Baseline - value) > 8           -> Grade 4
~~~  
---
## `%ctcae5_fev1()` macro <a name="ctcae5fev1-macro-13"></a> ######
Parameters    :  
~~~text
  PARAMCD = Variable name (expected "FEV1")
  AVAL    = Observed value (FEV1 result, % of predicted)
  AVALU   = Unit (expected "%")
~~~
Grading Criteria (CTCAE v5.0 - FEV1):  
~~~text
  - 70% <= value <= 99%                  -> Grade 1
  - 60% <= value < 70%                  -> Grade 2
  - 50% <= value < 60%                  -> Grade 3
  - value < 50%                        -> Grade 4
~~~
---
## `%ctcae5_fibrinog()` macro <a name="ctcae5fibrinog-macro-14"></a> ######
Parameters    :  
~~~text
  PARAMCD = Variable name (expected "FIBRINOG")
  AVAL    = Observed value (Fibrinogen result)
  BASE    = Baseline value
  ANRLO   = Lower limit of normal (LLN)
  AVALU   = Unit (expected "mg/dL" or "g/L")
~~~
Grading Criteria (CTCAE v5.0 - Fibrinogen):  
~~~text
  If baseline >= LLN:
    - 0.75 * LLN <= value < LLN          -> Grade 1
    - 0.50 * LLN <= value < 0.75 * LLN   -> Grade 2
    - 0.25 * LLN <= value < 0.50 * LLN   -> Grade 3
    - value < 0.25 * LLN                -> Grade 4

  If baseline < LLN (baseline abnormal):
    - decrease <= 0% and > -25%          -> Grade 1
    - -50% < decrease <= -25%            -> Grade 2
    - -75% < decrease <= -50%            -> Grade 3
    - decrease <= -75%                   -> Grade 4

  Absolute threshold:
    - value < 50 mg/dL (or < 0.5 g/L)   -> Grade 4
~~~  
---
 
## `%ctcae5_ggt()` macro <a name="ctcae5ggt-macro-15"></a> ######
Parameters    :  
~~~text
  PARAMCD = Variable name (expected "GGT")
  AVAL    = Observed value (GGT result, in U/L)
  BASE    = Baseline value
  ANRHI   = Upper limit of normal (ULN)
~~~
Grading Criteria (CTCAE v5.0 - Gamma-Glutamyl Transferase):  
~~~text
  If baseline ? ULN:
    - ULN < value <=2.5 * ULN          -> Grade 1
    - 2.5 * ULN < value ? 5 * ULN      -> Grade 2
    - 5 * ULN < value ? 20 * ULN       -> Grade 3
    - value > 20 * ULN                 -> Grade 4

  If baseline > ULN:
    - 2 * baseline < value <= 2.5 * baseline   -> Grade 1
    - 2.5 * baseline < value <= 5 * baseline   -> Grade 2
    - 5 * baseline < value <= 20 * baseline    -> Grade 3
    - value > 20 * baseline                   -> Grade 4
~~~
---
## `%ctcae5_gluc()` macro <a name="ctcae5gluc-macro-16"></a> ######
Parameters    :  
~~~text
  PARAMCD = Variable name (expected "GLUC")
  AVAL    = Observed value (Glucose result)
  AVALU   = Unit (expected "mg/dL" or "mmol/L")
  ANRLO   = Lower limit of normal (LLN)
~~~
Grading Criteria (CTCAE v5.0 - Glucose, Hypoglycemia):  
~~~text
  Units in "mg/dL":
    - value < LLN and ? 55              -> Grade 1
    - 40 <= value < 55                   -> Grade 2
    - 30 <= value < 40                   -> Grade 3
    - value < 30                        -> Grade 4

  Units in "mmol/L":
    - value < LLN and ? 3.0             -> Grade 1
    - 2.2 <= value < 3.0                 -> Grade 2
    - 1.7 <= value < 2.2                 -> Grade 3
    - value < 1.7                       -> Grade 4
~~~
---
## `%ctcae5_haptog()` macro <a name="ctcae5haptog-macro-17"></a> ######
Parameters    :  
~~~text
  PARAMCD = Variable name (expected "HAPTOG")
  AVAL    = Observed value (Haptoglobin result)
  ANRLO   = Lower limit of normal (LLN)
~~~
Grading Criteria (CTCAE v5.0 - Haptoglobin):  
~~~text
  Low (Below LLN)
    - value < LLN                      -> Grade 1
~~~
---
## `%ctcae5_hco3()` macro <a name="ctcae5hco3-macro-18"></a> ######
Parameters    :  
~~~text
  PARAMCD = Variable name (expected "HCO3")
  AVAL    = Observed value (Bicarbonate result)
  AVALU   = Unit (expected "mmol/L")
  ANRHI   = Upper limit of normal (ULN)
  ANRLO   = Lower limit of normal (LLN)
~~~
Grading Criteria (CTCAE v5.0 - Bicarbonate):  
~~~text
  Low (Below LLN)
    - value < LLN                      -> Grade 1
~~~
---
## `%ctcae5_hgb()` macro <a name="ctcae5hgb-macro-19"></a> ######
Parameters    :  
~~~text
  PARAMCD = Variable name (expected "HGB")
  AVAL    = Observed value (Hemoglobin result)
  AVALU   = Unit (expected "g/dL")
  ANRHI   = Upper limit of normal (ULN)
  ANRLO   = Lower limit of normal (LLN)
~~~
Grading Criteria (CTCAE v5.0 - Hemoglobin):  
~~~text
  High (Above ULN)
    - ULN < value <= ULN+2 g/dL         ->Grade 1
    - ULN+2 < value <= ULN+4 g/dL       ->Grade 2
    - value > ULN+4 g/dL               ->Grade 3

  Low (Below LLN)
    - 10 g/dL <= value < LLN            ->Grade 1
    - 8 g/dL <= value < 10 g/dL         ->Grade 2
    - value < 8 g/dL                   ->Grade 3
~~~
---
## `%ctcae5_k()` macro <a name="ctcae5k-macro-20"></a> ######
Parameters    :  
~~~text
  PARAMCD = Variable name (expected "K")
  AVAL    = Observed value (Potassium result)
  AVALU   = Unit (expected "mmol/L")
  ANRLO   = Lower limit of normal (LLN)
  ANRHI   = Upper limit of normal (ULN)
~~~
Grading Criteria (CTCAE v5.0 - Potassium):  
~~~text
  High (Hyperkalemia):
    - ULN < value <= 5.5                 -> Grade 1
    - 5.5 < value <= 6.0                 -> Grade 2
    - 6.0 < value <= 7.0                 -> Grade 3
    - value > 7.0                       -> Grade 4

  Low (Hypokalemia):
    - value < LLN and <= 3.0             -> Grade 2
    - 2.5 <= value < 3.0                 -> Grade 3
    - value < 2.5                       -> Grade 4
~~~  
---
## `%ctcae5_ldh()` macro <a name="ctcae5ldh-macro-21"></a> ######
Parameters    :  
~~~text
  PARAMCD = Variable name (expected "LDH")
  AVAL    = Observed value (LDH result, in U/L)
  ANRHI   = Upper limit of normal (ULN)
~~~
Grading Criteria (CTCAE v5.0 - Lactate Dehydrogenase):  
~~~text
  High (Above ULN)
    - value > ULN                      -> Grade 1
~~~  
---
## `%ctcae5_lvef()` macro <a name="ctcae5lvef-macro-22"></a> ######
Parameters    :
~~~text
  PARAMCD = Variable name (expected "LVEF")
  AVAL    = Observed value (Left Ventricular Ejection Fraction, in %)
  AVALU   = Unit (expected "%")
  BASE    = Baseline value (in %)
~~~
Grading Criteria (CTCAE v5.0 - LVEF):  
~~~text
  Absolute value:
    - 40% <= value < 50%                 -> Grade 2
    - 20% <= value < 40%                 -> Grade 3
    - value < 20%                       -> Grade 4

  Drop from baseline:
    - 10% <= decrease < 20%              -> Grade 2
    - decrease >= 20%                    -> Grade 3
~~~  
---
## `%ctcae5_lym()` macro <a name="ctcae5lym-macro-23"></a> ######
Parameters    :
~~~text
  PARAMCD = Variable name (expected "LYM")
  AVAL    = Observed value (Lymphocyte count)
  AVALU   = Unit (expected either per volume, e.g., "/mm3", "/uL" or "10^9/L")
  ANRLO   = Lower limit of normal (LLN)
~~~
Grading Criteria (CTCAE v5.0 - Lymphocytes):
~~~text
  High (Above ULN):
    Units in "/mm3", "/uL":
      - 4000 < value <= 20000            -> Grade 2
      - value > 20000                   -> Grade 3

    Units in "10^9/L":
      - 4 < value <= 20                  -> Grade 2
      - value > 20                      -> Grade 3

  Low (Below LLN):
    Units in "/mm3", "/uL":
      - value < LLN and <= 800           -> Grade 1
      - 500 <= value < 800               -> Grade 2
      - 200 <= value < 500               -> Grade 3
      - value < 200                     -> Grade 4

    Units in "10^9/L":
      - value < LLN and <= 0.8           -> Grade 1
      - 0.5 <= value < 0.8               -> Grade 2
      - 0.2 <= value < 0.5               -> Grade 3
      - value < 0.2                     -> Grade 4
~~~
---
## `%ctcae5_mg()` macro <a name="ctcae5mg-macro-24"></a> ######
Parameters    :
~~~text
  PARAMCD = Variable name (expected "MG")
  AVAL    = Observed value (Magnesium result)
  AVALU   = Unit (expected "mg/dL")
  ANRLO   = Lower limit of normal (LLN)
  ANRHI   = Upper limit of normal (ULN)
~~~
Grading Criteria (CTCAE v5.0 - Magnesium):  
~~~text
  High (Hypermagnesemia):
    - ULN < value <= 3.0                 -> Grade 1
    - 3.0 < value <= 8.0                 -> Grade 3
    - value > 8.0                       -> Grade 4

  Low (Hypomagnesemia):
    - value < LLN and <= 1.2             -> Grade 1
    - 0.9 <= value < 1.2                 -> Grade 2
    - 0.7 <= value < 0.9                 -> Grade 3
    - value < 0.7                       -> Grade 4
~~~
---
## `%ctcae5_na()` macro <a name="ctcae5na-macro-25"></a> ######
Parameters    :  
~~~text
  PARAMCD = Variable name (expected "NA")
  AVAL    = Observed value (Sodium result)
  AVALU   = Unit (expected "mmol/L")
  ANRLO   = Lower limit of normal (LLN)
  ANRHI   = Upper limit of normal (ULN)
~~~
Grading Criteria (CTCAE v5.0 - Sodium):
~~~text
  High (Hypernatremia):
    - ULN < value <= 150                 -> Grade 1
    - 150 < value <= 155                 -> Grade 2
    - 155 < value <= 160                 -> Grade 3
    - value > 160                       -> Grade 4

  Low (Hyponatremia):
    - value < LLN and >= 130             -> Grade 1
    - 125 <= value <= 129                 -> Grade 2
    - 120 <= value <= 124                 -> Grade 3
    - value < 120                       -> Grade 4
~~~  
---
## `%ctcae5_neut()` macro <a name="ctcae5neut-macro-26"></a> ######
Parameters    :
~~~text
  PARAMCD = Variable name (expected "NEUT")
  AVAL    = Observed value (Neutrophil count)
  AVALU   = Unit (expected either per volume, e.g., "/mm3", "/uL" or "10^9/L")
  ANRLO   = Lower limit of normal (LLN)
~~~
Grading Criteria (CTCAE v5.0 - Neutrophils):  
~~~text
  Units in "/mm3", "/uL":
    - value < LLN and <= 1500            -> Grade 1
    - 1000 <= value < 1500               -> Grade 2
    - 500 <= value < 1000                -> Grade 3
    - value < 500                       -> Grade 4

  Units in "10^9/L":
    - value < LLN and >= 1.5             -> Grade 1
    - 1.0 <= value < 1.5                 -> Grade 2
    - 0.5 <= value < 1.0                 -> Grade 3
    - value < 0.5                       -> Grade 4
~~~  
---
## `%ctcae5_plat()` macro <a name="ctcae5plat-macro-27"></a> ######
Parameters    :
~~~
  PARAMCD = Variable name (expected "PLAT")
  AVAL    = Observed value (Platelet count)
  AVALU   = Unit (expected either per volume, e.g., "/mm3", "/uL" or "10^9/L")
  ANRLO   = Lower limit of normal (LLN)
~~~
Grading Criteria (CTCAE v5.0 - Platelets):  
~~~text
  Units in "/mm3", "/uL":
    - value < LLN and >= 75,000          -> Grade 1
    - 50,000 <= value < 75,000           -> Grade 2
    - 25,000 <= value < 50,000           -> Grade 3
    - value < 25,000                    -> Grade 4

  Units in "10^9/L":
    - value < LLN and >= 75              -> Grade 1
    - 50 <= value < 75                   -> Grade 2
    - 25 <= value < 50                   -> Grade 3
    - value < 25                        -> Grade 4
~~~
---
## `%ctcae5_qtcf()` macro <a name="ctcae5qtcf-macro-28"></a> ######
Parameters    :
~~~text
  PARAMCD = Variable name (expected "QTCF")
  AVAL    = Observed value (QTcF interval, in milliseconds)
  AVALU   = Unit (expected "ms")
  BASE    = Baseline value (in ms)
~~~
Grading Criteria (CTCAE v5.0 - QTcF Interval):
~~~text
  Absolute value:
    - 450 ms <= value <= 480 ms           -> Grade 1
    - 480 ms < value <= 500 ms           -> Grade 2
    - value > 500 ms                    -> Grade 3

  Change from baseline:
    - 30 ms <= increase < 60 ms          -> Grade 1
    - increase >= 60 ms                  -> Grade 2
~~~
---
## `%ctcae5_tni()` macro <a name="ctcae5tni-macro-29"></a> ######
Parameters    :  
~~~text
  PARAMCD = Variable name (expected "TNI")
  AVAL    = Observed value (Troponin I result, e.g., ng/mL)
  ANRHI   = Upper limit of normal (ULN)
  MFRHI   = Medical decision limit (e.g., myocardial infarction reference high)
~~~
Grading Criteria (CTCAE v5.0 - Troponin I):  
~~~text
  If MFRHI is not provided:
    - value > ULN                      -> Grade 1

  If MFRHI is provided:
    - ULN < value < MFRHI              -> Grade 1
    - value <= MFRHI                    -> Grade 3
~~~
---
## `%ctcae5_trig()` macro <a name="ctcae5trig-macro-30"></a> ######
Parameters    :
~~~text
  PARAMCD = Variable name (expected "TRIG")
  AVAL    = Observed value (Triglycerides result)
  AVALU   = Unit (expected "mg/dL" or "mmol/L")
~~~
Grading Criteria (CTCAE v5.0 - Triglycerides):  
~~~text
  Units in "mg/dL":
    - 150 <= value <= 300                 -> Grade 1
    - 300 < value <= 500                 -> Grade 2
    - 500 < value <= 1000                -> Grade 3
    - value > 1000                      -> Grade 4

  Units in "mmol/L":
    - 1.71 <= value <= 3.42               -> Grade 1
    - 3.42 <= value <= 5.7                -> Grade 2
    - 5.7 < value <= 11.4                -> Grade 3
    - value > 11.4                      -> Grade 4
~~~  
---
## `%ctcae5_tropnt()` macro <a name="ctcae5tropnt-macro-31"></a> ######
Parameters    :  
~~~text
  PARAMCD = Variable name (expected "TROPNT")
  AVAL    = Observed value (Troponin T result, e.g., ng/mL)
  ANRHI   = Upper limit of normal (ULN)
  MFRHI   = Medical decision limit (e.g., myocardial infarction reference high)
~~~
Grading Criteria (CTCAE v5.0 - Troponin T):
~~~text
  If MFRHI is not provided:
    - value > ULN                      -> Grade 1

  If MFRHI is provided:
    - ULN < value < MFRHI              -> Grade 1
    - value <= MFRHI                    -> Grade 3
~~~  
---
## `%ctcae5_wbc()` macro <a name="ctcae5wbc-macro-32"></a> ######
Parameters    :
~~~text
  PARAMCD = Variable name (expected "WBC")
  AVAL    = Observed value (White Blood Cell count)
  AVALU   = Unit (expected either per volume, e.g., "/mm3", "/uL" or "10^9/L")
  ANRLO   = Lower limit of normal (LLN)
~~~
Grading Criteria (CTCAE v5.0 - White Blood Cells):
~~~text
  High (Leukocytosis):
    Units in "/mm3", "/uL":
      - value > 100,000                 -> Grade 3

    Units in "10^9/L":
      - value > 100                     -> Grade 3

  Low (Leukopenia):
    Units in "/mm3", "/uL":
      - value < LLN and ? 3000          -> Grade 1
      - 2000 <= value < 3000             -> Grade 2
      - 1000 <= value < 2000             -> Grade 3
      - value < 1000                    -> Grade 4

    Units in "10^9/L":
      - value < LLN and ? 3.0           -> Grade 1
      - 2.0 <= value < 3.0               -> Grade 2
      - 1.0 <= value < 2.0               -> Grade 3
      - value < 1.0                     -> Grade 4
~~~


 # version history
0.1.0(21August2025): Initial version


## What is SAS Packages?

The package is built on top of **SAS Packages Framework(SPF)** developed by Bartosz Jablonski.

For more information about the framework, see [SAS Packages Framework](https://github.com/yabwon/SAS_PACKAGES).

You can also find more SAS Packages (SASPacs) in the [SAS Packages Archive(SASPAC)](https://github.com/SASPAC).

## How to use SAS Packages? (quick start)

### 1. Set-up SAS Packages Framework

First, create a directory for your packages and assign a `packages` fileref to it.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
filename packages "\path\to\your\packages";
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Secondly, enable the SAS Packages Framework.
(If you don't have SAS Packages Framework installed, follow the instruction in 
[SPF documentation](https://github.com/yabwon/SAS_PACKAGES/tree/main/SPF/Documentation) 
to install SAS Packages Framework.)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
%include packages(SPFinit.sas)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


### 2. Install SAS package

Install SAS package you want to use with the SPF's `%installPackage()` macro.

- For packages located in **SAS Packages Archive(SASPAC)** run:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
  %installPackage(packageName)
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- For packages located in **PharmaForest** run:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
  %installPackage(packageName, mirror=PharmaForest)
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- For packages located at some network location run:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
  %installPackage(packageName, sourcePath=https://some/internet/location/for/packages)
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  (e.g. `%installPackage(ABC, sourcePath=https://github.com/SomeRepo/ABC/raw/main/)`)


### 3. Load SAS package

Load SAS package you want to use with the SPF's `%loadPackage()` macro.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas
%loadPackage(packageName)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


### Enjoy!

# ctcae5_grader
ctcae5_grader is a SAS macro package that automates the grading of laboratory tests according to CTCAE v5.0. It standardises grading rules for common laboratory parameters (e.g. haematology, biochemistry, electrolytes) and provides character and numeric grade outputs. DESCRIPTION END:

<img width="300" height="300" alt="Image" src="https://github.com/user-attachments/assets/078be8bd-3ff3-4359-b30e-1f8f53921685" />  

## `%ctcae5_alb()` macro <a name="ctcae5alb-macro-1"></a> ######

Program/Macro : CTCAE5_ALB

Parameters    :
  PARAMCD = Variable name (expected "ALB")
  AVAL    = Observed value (Albumin result)
  AVALU   = Unit (expected "g/dL" or "g/L")
  ANRLO   = Lower limit of normal (LLN)

Grading Criteria (CTCAE v5.0 - Albumin):

  Units in "g/dL":
    - value < LLN and >= 3.0             -> Grade 1
    - 2.0 <= value < 3.0                 -> Grade 2
    - value < 2.0                       -> Grade 3

  Units in "g/L":
    - value < LLN and >= 30              -> Grade 1
    - 20 <= value < 30                   -> Grade 2
    - value < 20                        -> Grade 3

  
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

Program/Macro : CTCAE5_ALT

Parameters    :
  PARAMCD = Variable name (expected "ALT")
  AVAL    = Observed value (ALT result, in U/L)
  BASE    = Baseline value
  ANRHI   = Upper limit of normal (ULN)

Grading Criteria (CTCAE v5.0 - Alanine Aminotransferase):
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

  
---
 
## `%ctcae5_aptt()` macro <a name="ctcae5aptt-macro-4"></a> ######

Program/Macro : CTCAE5_APTT

Parameters    :
  PARAMCD = Variable name (expected "APTT")
  AVAL    = Observed value (APTT result, in seconds)
  ANRHI   = Upper limit of normal (ULN)

Grading Criteria (CTCAE v5.0 - Activated Partial Thromboplastin Time):
  Prolonged (Above ULN)
    - ULN < value <= 1.5 * ULN          -> Grade 1
    - 1.5 * ULN < value <= 2.5 * ULN    -> Grade 2
    - value > 2.5 * ULN                -> Grade 3

  
---
 
## `%ctcae5_ast()` macro <a name="ctcae5ast-macro-5"></a> ######

Program/Macro : CTCAE5_AST

Parameters    :
  PARAMCD = Variable name (expected "AST")
  AVAL    = Observed value (AST result, in U/L)
  BASE    = Baseline value
  ANRHI   = Upper limit of normal (ULN)

Grading Criteria (CTCAE v5.0 - Aspartate Aminotransferase):
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

  
---
 
## `%ctcae5_bili()` macro <a name="ctcae5bili-macro-6"></a> ######

Program/Macro : CTCAE5_BILI

Parameters    :
  PARAMCD = Variable name (expected "BILI")
  AVAL    = Observed value (Total Bilirubin result, in mg/dL)
  BASE    = Baseline value
  ANRHI   = Upper limit of normal (ULN)

Grading Criteria (CTCAE v5.0 - Total Bilirubin):
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

  
---
 
## `%ctcae5_ca()` macro <a name="ctcae5ca-macro-7"></a> ######

Program/Macro : CTCAE5_CA

Parameters    :
  PARAMCD = Variable name (expected "CA")
  AVAL    = Observed value (Calcium result)
  AVALU   = Unit (expected "mg/dL")
  ANRLO   = Lower limit of normal (LLN)
  ANRHI   = Upper limit of normal (ULN)
  TESTCD  = Lab test code (default "CA")

Grading Criteria (CTCAE v5.0 - Calcium):

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

  
---
 
## `%ctcae5_cd4()` macro <a name="ctcae5cd4-macro-8"></a> ######

Program/Macro : CTCAE5_CD4

Parameters    :
  PARAMCD = Variable name (expected "CD4")
  AVAL    = Observed value (CD4+ T-cell count)
  AVALU   = Unit (expected either per volume, e.g., "/mm3", "10^6/L", or "10^9/L")
  ANRLO   = Lower limit of normal (LLN)

Grading Criteria (CTCAE v5.0 - CD4 Count):

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

  
---
 
## `%ctcae5_chol()` macro <a name="ctcae5chol-macro-9"></a> ######

Program/Macro : CTCAE5_CHOL

Parameters    :
  PARAMCD = Variable name (expected "CHOL")
  AVAL    = Observed value (Cholesterol result)
  AVALU   = Unit (expected "mg/dL" or "mmol/L")
  ANRHI   = Upper limit of normal (ULN)

Grading Criteria (CTCAE v5.0 - Cholesterol):

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

  
---
 
## `%ctcae5_ck()` macro <a name="ctcae5ck-macro-10"></a> ######

Program/Macro : CTCAE5_CK

Parameters    :
  PARAMCD = Variable name (expected "CK")
  AVAL    = Observed value (Creatine Kinase result, in U/L)
  ANRHI   = Upper limit of normal (ULN)

Grading Criteria (CTCAE v5.0 - Creatine Kinase):
  High (Above ULN)
    - ULN < value <= 2.5 * ULN           -> Grade 1
    - 2.5 * ULN < value <= 5 * ULN       -> Grade 2
    - 5 * ULN < value <= 10 * ULN        -> Grade 3
    - value > 10 * ULN                  -> Grade 4

  
---
 
## `%ctcae5_creat()` macro <a name="ctcae5creat-macro-11"></a> ######

Program/Macro : CTCAE5_CREAT

Parameters    :
  PARAMCD = Variable name (expected "CREAT")
  AVAL    = Observed value (Creatinine result, e.g., mg/dL or ・ｽ・ｽmol/L)
  ANRHI   = Upper limit of normal (ULN)

Grading Criteria (CTCAE v5.0 - Creatinine):
  High (Above ULN)
    - ULN < value <= 1.5 * ULN           -> Grade 1
    - 1.5 * ULN < value <= 3 * ULN       -> Grade 2
    - 3 * ULN < value <= 6 * ULN         -> Grade 3
    - value > 6 * ULN                   -> Grade 4

  
---
 
## `%ctcae5_dlco()` macro <a name="ctcae5dlco-macro-12"></a> ######

Program/Macro : CTCAE5_DLCO

Parameters    :
  PARAMCD = Variable name (expected "DLCO")
  AVAL    = Observed value (DLCO result)
  AVALU   = Unit (e.g., mL/min/mmHg or % predicted)
  BASE    = Baseline value
  ANRLO   = Lower limit of normal (LLN)

Grading Criteria (CTCAE v5.0 - DLCO):
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

  
---
 
## `%ctcae5_fev1()` macro <a name="ctcae5fev1-macro-13"></a> ######

Program/Macro : CTCAE5_FEV1

Parameters    :
  PARAMCD = Variable name (expected "FEV1")
  AVAL    = Observed value (FEV1 result, % of predicted)
  AVALU   = Unit (expected "%")

Grading Criteria (CTCAE v5.0 - FEV1):
  - 70% <= value <= 99%                  -> Grade 1
  - 60% <= value < 70%                  -> Grade 2
  - 50% <= value < 60%                  -> Grade 3
  - value < 50%                        -> Grade 4

  
---
 
## `%ctcae5_fibrinog()` macro <a name="ctcae5fibrinog-macro-14"></a> ######

Program/Macro : CTCAE5_FIBRINOG

Parameters    :
  PARAMCD = Variable name (expected "FIBRINOG")
  AVAL    = Observed value (Fibrinogen result)
  BASE    = Baseline value
  ANRLO   = Lower limit of normal (LLN)
  AVALU   = Unit (expected "mg/dL" or "g/L")

Grading Criteria (CTCAE v5.0 - Fibrinogen):

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

  
---
 
## `%ctcae5_ggt()` macro <a name="ctcae5ggt-macro-15"></a> ######

Program/Macro : CTCAE5_GGT

Parameters    :
  PARAMCD = Variable name (expected "GGT")
  AVAL    = Observed value (GGT result, in U/L)
  BASE    = Baseline value
  ANRHI   = Upper limit of normal (ULN)

Grading Criteria (CTCAE v5.0 - Gamma-Glutamyl Transferase):
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

  
---
 
## `%ctcae5_gluc()` macro <a name="ctcae5gluc-macro-16"></a> ######

Program/Macro : CTCAE5_GLUC

Parameters    :
  PARAMCD = Variable name (expected "GLUC")
  AVAL    = Observed value (Glucose result)
  AVALU   = Unit (expected "mg/dL" or "mmol/L")
  ANRLO   = Lower limit of normal (LLN)

Grading Criteria (CTCAE v5.0 - Glucose, Hypoglycemia):

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

  
---
 
## `%ctcae5_haptog()` macro <a name="ctcae5haptog-macro-17"></a> ######

Program/Macro : CTCAE5_HAPTOG

Parameters    :
  PARAMCD = Variable name (expected "HAPTOG")
  AVAL    = Observed value (Haptoglobin result)
  ANRLO   = Lower limit of normal (LLN)

Grading Criteria (CTCAE v5.0 - Haptoglobin):
  Low (Below LLN)
    - value < LLN                      -> Grade 1

  
---
 
## `%ctcae5_hco3()` macro <a name="ctcae5hco3-macro-18"></a> ######

Program/Macro : CTCAE5_HCO3

Parameters    :
  PARAMCD = Variable name (expected "HCO3")
  AVAL    = Observed value (Bicarbonate result)
  AVALU   = Unit (expected "mmol/L")
  ANRHI   = Upper limit of normal (ULN)
  ANRLO   = Lower limit of normal (LLN)

Grading Criteria (CTCAE v5.0 - Bicarbonate):
  Low (Below LLN)
    - value < LLN                      -> Grade 1

  
---
 
## `%ctcae5_hgb()` macro <a name="ctcae5hgb-macro-19"></a> ######

Program/Macro : CTCAE5_HGB

Parameters    :
  PARAMCD = Variable name (expected "HGB")
  AVAL    = Observed value (Hemoglobin result)
  AVALU   = Unit (expected "g/dL")
  ANRHI   = Upper limit of normal (ULN)
  ANRLO   = Lower limit of normal (LLN)

Grading Criteria (CTCAE v5.0 - Hemoglobin):
  High (Above ULN)
    - ULN < value <= ULN+2 g/dL         ->Grade 1
    - ULN+2 < value <= ULN+4 g/dL       ->Grade 2
    - value > ULN+4 g/dL               ->Grade 3

  Low (Below LLN)
    - 10 g/dL <= value < LLN            ->Grade 1
    - 8 g/dL <= value < 10 g/dL         ->Grade 2
    - value < 8 g/dL                   ->Grade 3

  
---
 
## `%ctcae5_k()` macro <a name="ctcae5k-macro-20"></a> ######

Program/Macro : CTCAE5_K

Parameters    :
  PARAMCD = Variable name (expected "K")
  AVAL    = Observed value (Potassium result)
  AVALU   = Unit (expected "mmol/L")
  ANRLO   = Lower limit of normal (LLN)
  ANRHI   = Upper limit of normal (ULN)

Grading Criteria (CTCAE v5.0 - Potassium):

  High (Hyperkalemia):
    - ULN < value <= 5.5                 -> Grade 1
    - 5.5 < value <= 6.0                 -> Grade 2
    - 6.0 < value <= 7.0                 -> Grade 3
    - value > 7.0                       -> Grade 4

  Low (Hypokalemia):
    - value < LLN and <= 3.0             -> Grade 2
    - 2.5 <= value < 3.0                 -> Grade 3
    - value < 2.5                       -> Grade 4

  
---
 
## `%ctcae5_ldh()` macro <a name="ctcae5ldh-macro-21"></a> ######

Program/Macro : CTCAE5_LDH

Parameters    :
  PARAMCD = Variable name (expected "LDH")
  AVAL    = Observed value (LDH result, in U/L)
  ANRHI   = Upper limit of normal (ULN)

Grading Criteria (CTCAE v5.0 - Lactate Dehydrogenase):
  High (Above ULN)
    - value > ULN                      -> Grade 1

  
---
 
## `%ctcae5_lvef()` macro <a name="ctcae5lvef-macro-22"></a> ######

Program/Macro : CTCAE5_LVEF

Parameters    :
  PARAMCD = Variable name (expected "LVEF")
  AVAL    = Observed value (Left Ventricular Ejection Fraction, in %)
  AVALU   = Unit (expected "%")
  BASE    = Baseline value (in %)

Grading Criteria (CTCAE v5.0 - LVEF):

  Absolute value:
    - 40% <= value < 50%                 -> Grade 2
    - 20% <= value < 40%                 -> Grade 3
    - value < 20%                       -> Grade 4

  Drop from baseline:
    - 10% <= decrease < 20%              -> Grade 2
    - decrease >= 20%                    -> Grade 3

  
---
 
## `%ctcae5_lym()` macro <a name="ctcae5lym-macro-23"></a> ######

Program/Macro : CTCAE5_LYM

Parameters    :
  PARAMCD = Variable name (expected "LYM")
  AVAL    = Observed value (Lymphocyte count)
  AVALU   = Unit (expected either per volume, e.g., "/mm3", "/uL" or "10^9/L")
  ANRLO   = Lower limit of normal (LLN)

Grading Criteria (CTCAE v5.0 - Lymphocytes):

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

  
---
 
## `%ctcae5_mg()` macro <a name="ctcae5mg-macro-24"></a> ######

Program/Macro : CTCAE5_MG

Parameters    :
  PARAMCD = Variable name (expected "MG")
  AVAL    = Observed value (Magnesium result)
  AVALU   = Unit (expected "mg/dL")
  ANRLO   = Lower limit of normal (LLN)
  ANRHI   = Upper limit of normal (ULN)

Grading Criteria (CTCAE v5.0 - Magnesium):

  High (Hypermagnesemia):
    - ULN < value <= 3.0                 -> Grade 1
    - 3.0 < value <= 8.0                 -> Grade 3
    - value > 8.0                       -> Grade 4

  Low (Hypomagnesemia):
    - value < LLN and <= 1.2             -> Grade 1
    - 0.9 <= value < 1.2                 -> Grade 2
    - 0.7 <= value < 0.9                 -> Grade 3
    - value < 0.7                       -> Grade 4

  
---
 
## `%ctcae5_na()` macro <a name="ctcae5na-macro-25"></a> ######

Program/Macro : CTCAE5_NA

Parameters    :
  PARAMCD = Variable name (expected "NA")
  AVAL    = Observed value (Sodium result)
  AVALU   = Unit (expected "mmol/L")
  ANRLO   = Lower limit of normal (LLN)
  ANRHI   = Upper limit of normal (ULN)

Grading Criteria (CTCAE v5.0 - Sodium):

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

  
---
 
## `%ctcae5_neut()` macro <a name="ctcae5neut-macro-26"></a> ######

Program/Macro : CTCAE5_NEUT

Parameters    :
  PARAMCD = Variable name (expected "NEUT")
  AVAL    = Observed value (Neutrophil count)
  AVALU   = Unit (expected either per volume, e.g., "/mm3", "/uL" or "10^9/L")
  ANRLO   = Lower limit of normal (LLN)

Grading Criteria (CTCAE v5.0 - Neutrophils):

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

  
---
 
## `%ctcae5_plat()` macro <a name="ctcae5plat-macro-27"></a> ######

Program/Macro : CTCAE5_PLAT

Parameters    :
  PARAMCD = Variable name (expected "PLAT")
  AVAL    = Observed value (Platelet count)
  AVALU   = Unit (expected either per volume, e.g., "/mm3", "/uL" or "10^9/L")
  ANRLO   = Lower limit of normal (LLN)

Grading Criteria (CTCAE v5.0 - Platelets):

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

  
---
 
## `%ctcae5_qtcf()` macro <a name="ctcae5qtcf-macro-28"></a> ######

Program/Macro : CTCAE5_QTCF

Parameters    :
  PARAMCD = Variable name (expected "QTCF")
  AVAL    = Observed value (QTcF interval, in milliseconds)
  AVALU   = Unit (expected "ms")
  BASE    = Baseline value (in ms)

Grading Criteria (CTCAE v5.0 - QTcF Interval):

  Absolute value:
    - 450 ms <= value <= 480 ms           -> Grade 1
    - 480 ms < value <= 500 ms           -> Grade 2
    - value > 500 ms                    -> Grade 3

  Change from baseline:
    - 30 ms <= increase < 60 ms          -> Grade 1
    - increase >= 60 ms                  -> Grade 2

  
---
 
## `%ctcae5_tni()` macro <a name="ctcae5tni-macro-29"></a> ######

Program/Macro : CTCAE5_TNI

Parameters    :
  PARAMCD = Variable name (expected "TNI")
  AVAL    = Observed value (Troponin I result, e.g., ng/mL)
  ANRHI   = Upper limit of normal (ULN)
  MFRHI   = Medical decision limit (e.g., myocardial infarction reference high)

Grading Criteria (CTCAE v5.0 - Troponin I):
  If MFRHI is not provided:
    - value > ULN                      -> Grade 1

  If MFRHI is provided:
    - ULN < value < MFRHI              -> Grade 1
    - value <= MFRHI                    -> Grade 3

  
---
 
## `%ctcae5_trig()` macro <a name="ctcae5trig-macro-30"></a> ######

Program/Macro : CTCAE5_TRIG

Parameters    :
  PARAMCD = Variable name (expected "TRIG")
  AVAL    = Observed value (Triglycerides result)
  AVALU   = Unit (expected "mg/dL" or "mmol/L")

Grading Criteria (CTCAE v5.0 - Triglycerides):

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

  
---
 
## `%ctcae5_tropnt()` macro <a name="ctcae5tropnt-macro-31"></a> ######

Program/Macro : CTCAE5_TROPNT

Parameters    :
  PARAMCD = Variable name (expected "TROPNT")
  AVAL    = Observed value (Troponin T result, e.g., ng/mL)
  ANRHI   = Upper limit of normal (ULN)
  MFRHI   = Medical decision limit (e.g., myocardial infarction reference high)

Grading Criteria (CTCAE v5.0 - Troponin T):
  If MFRHI is not provided:
    - value > ULN                      -> Grade 1

  If MFRHI is provided:
    - ULN < value < MFRHI              -> Grade 1
    - value <= MFRHI                    -> Grade 3

  
---
 
## `%ctcae5_wbc()` macro <a name="ctcae5wbc-macro-32"></a> ######

Program/Macro : CTCAE5_WBC

Parameters    :
  PARAMCD = Variable name (expected "WBC")
  AVAL    = Observed value (White Blood Cell count)
  AVALU   = Unit (expected either per volume, e.g., "/mm3", "/uL" or "10^9/L")
  ANRLO   = Lower limit of normal (LLN)

Grading Criteria (CTCAE v5.0 - White Blood Cells):

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

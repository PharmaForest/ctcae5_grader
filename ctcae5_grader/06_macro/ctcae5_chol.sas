/*** HELP START ***//*

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

*//*** HELP END ***/


%macro CTCAE5_CHOL(
  PARAMCD = PARAMCD
 ,AVAL    = AVAL
 ,AVALU   = AVALU      
 ,ANRHI   = ANRHI      
);

length ATOXGRH ATOXGRL ATOXGR $200.;
if &PARAMCD.="CHOL" then do;
  call missing(of ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN);

  if &PARAMCD.="CHOL" and not missing(&AVAL.) then do;
    ATOXGRH = 'Grade 0';

    if &AVALU. in ("mg/dL")  then do;
      if ^missing(&ANRHI.) then do;
        if round(&ANRHI.,1e-10) < &AVAL. <= 300 then ATOXGRH= 'Grade 1';
      end;
       if 300< &AVAL. <= 400 then ATOXGRH= 'Grade 2';
      else if 400 < &AVAL. <= 500 then ATOXGRH= 'Grade 3';
      else if 500 < &AVAL. then ATOXGRH = 'Grade 4';
    end;

    else if &AVALU. in ("mmol/L") then do;
      if ^missing(&ANRHI.)  then do;
        if round(&ANRHI.,1e-10) < &AVAL. <= 7.75 then ATOXGRH= 'Grade 1';
      end;
      if 7.75< &AVAL. <= 10.34 then ATOXGRH= 'Grade 2';
      else if 10.34 < &AVAL. <= 12.92 then ATOXGRH= 'Grade 3';
      else if 12.92 < &AVAL. then ATOXGRH = 'Grade 4';
    end;
    else do;
      put "WARNING:" &PARAMCD.= &AVALU.= "is not expected ('mg/dL' or 'mmol/L').";
    end;
  end;

  ATOXGRHN = input(compress(ATOXGRH,,"kd"),best.);
  ATOXGRLN = input(compress(ATOXGRL,,"kd"),best.);
  if 0 < n(of ATOXGRHN) then do;
    ATOXGRN = max(of ATOXGRHN);
    ATOXGR  = catx(" ","Grade",ATOXGRN);
  end;
end;
%mend;

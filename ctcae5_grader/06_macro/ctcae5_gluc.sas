/*** HELP START ***//*

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

*//*** HELP END ***/

%macro CTCAE5_GLUC(
 PARAMCD = PARAMCD
,AVAL = AVAL
,AVALU = AVALU
,ANRLO = ANRLO
);
length ATOXGRH ATOXGRL ATOXGR  $200.;
if &PARAMCD.="GLUC" then do;
  call missing(of  ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN);

  if &PARAMCD.="GLUC" and not missing(&AVAL.)  then do;
    ATOXGRL='Grade 0';
    if &AVALU. in ("mg/dL") then do;
      if not missing(&ANRLO.) then do;
        if &AVAL. < &ANRLO. and 55 <= &AVAL. then ATOXGRL = 'Grade 1';
      end;
      if 40 <= &AVAL. < 55 then ATOXGRL = 'Grade 2';
      else if 30 <= &AVAL. < 40 then ATOXGRL = 'Grade 3';
      else if &AVAL. < 30 then ATOXGRL = 'Grade 4';
    end;

    else if &AVALU. in ("mmol/L") then do;
      if not missing(&ANRLO.) then do;
        if &AVAL. < &ANRLO. and 3 <= &AVAL. then ATOXGRL = 'Grade 1';
      end;
      if 2.2 <= &AVAL. < 3 then ATOXGRL = 'Grade 2';
      else if 1.7 <= &AVAL. < 2.2 then ATOXGRL = 'Grade 3';
      else if &AVAL. < 1.7 then ATOXGRL = 'Grade 4';  
    end;
    else do;
      put "WARNING:" &PARAMCD.= &AVALU.= "is not expected ('mg/dL' or 'mmol/L').";
    end;
  end;


  ATOXGRHN = input(compress(ATOXGRH,,"kd"),best.);
  ATOXGRLN = input(compress(ATOXGRL,,"kd"),best.);
  if 0 < n(of ATOXGRHN ATOXGRLN) then do;
     ATOXGRN = max(of ATOXGRHN ATOXGRLN);
     ATOXGR = catx(" ","Grade",ATOXGRN);
  end;
end;
%mend;

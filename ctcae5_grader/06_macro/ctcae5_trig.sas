/*** HELP START ***//*

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

*//*** HELP END ***/

%macro CTCAE5_TRIG(
  PARAMCD = PARAMCD
 ,AVAL    = AVAL      
 ,AVALU   = AVALU   
);
length ATOXGRH ATOXGRL ATOXGR $200.;
if &PARAMCD.="TRIG" then do;
  call missing(of ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN);

  if &PARAMCD.="TRIG" and not missing(&AVAL.) then do;

    if &AVALU. notin ("mg/dL","mmol/L") then
      put "WARNING:" &PARAMCD.= &AVALU.= 'expected "mg/dL","mmol/L"';

    ATOXGRH = 'Grade 0';
    if &AVALU.  = "mg/dL" then do;
      if 150 <= &AVAL. <= 300 then ATOXGRH = 'Grade 1';
      else if 300 <  &AVAL. <= 500 then ATOXGRH = 'Grade 2';
      else if 500 <  &AVAL. <= 1000 then ATOXGRH = 'Grade 3';
      else if 1000 <  &AVAL.  then ATOXGRH = 'Grade 4';
    end;
    if &AVALU.  = "mmol/L" then do;
      if 1.71 <= &AVAL. <= 3.42 then ATOXGRH = 'Grade 1';
      else if 3.42 <  &AVAL. <= 5.7 then ATOXGRH = 'Grade 2';
      else if 5.7 <  &AVAL. <= 11.4 then ATOXGRH = 'Grade 3';
      else if 11.4 <  &AVAL.  then ATOXGRH = 'Grade 4';
    end;

   end;

  ATOXGRHN = input(compress(ATOXGRH,,"kd"),best.);
  if 0 < n(of ATOXGRHN) then do;
    ATOXGRN = ATOXGRHN;
    ATOXGR  = catx(" ","Grade",ATOXGRN);
  end;
end;
%mend;

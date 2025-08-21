/*** HELP START ***//*

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

*//*** HELP END ***/

%macro CTCAE5_CA(
 PARAMCD = PARAMCD
,AVAL = AVAL
,AVALU = AVALU
,ANRLO = ANRLO
,ANRHI = ANRHI
,TESTCD=CA
);
length ATOXGRH ATOXGRL ATOXGR  $200.;
if &PARAMCD.="&TESTCD." then do;
  call missing(of  ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN);
  if &PARAMCD.="&TESTCD." and not missing(&AVAL.) and &AVALU ="mg/dL" then do;
    ATOXGRH='Grade 0';
    if not missing(&ANRHI.) then do;
         if &ANRHI. < &AVAL.  <=11.5 then ATOXGRH= 'Grade 1';
     end;
     if 11.5 < &AVAL.  <=12.5 then ATOXGRH= 'Grade 2';
     else if 12.5 < &AVAL.  <=13.5 then ATOXGRH= 'Grade 3';
     else if 13.5 < &AVAL.   then ATOXGRH= 'Grade 4';
  end;

  if &PARAMCD.="&TESTCD." and not missing(&AVAL.)  and &AVALU ="mg/dL" then do;
    ATOXGRL='Grade 0';
      if not missing(&ANRLO.) then do;
        if &AVAL. < &ANRLO. and 8 <= &AVAL. then ATOXGRL = 'Grade 1';
      end;
      if 7 <= &AVAL. < 8 then ATOXGRL = 'Grade 2';
      else if 6 <= &AVAL. < 7 then ATOXGRL = 'Grade 3';
      else if &AVAL. < 6 then ATOXGRL = 'Grade 4';
  end;
  if &AVALU ne "mg/dL" then put "WARNING:" &PARAMCD.= &AVALU.= "is not expected ('mg/dL').";


  ATOXGRHN = input(compress(ATOXGRH,,"kd"),best.);
  ATOXGRLN = input(compress(ATOXGRL,,"kd"),best.);
  if 0 < n(of ATOXGRHN ATOXGRLN) then do;
     ATOXGRN = max(of ATOXGRHN ATOXGRLN);
     ATOXGR = catx(" ","Grade",ATOXGRN);
  end;
end;
%mend;

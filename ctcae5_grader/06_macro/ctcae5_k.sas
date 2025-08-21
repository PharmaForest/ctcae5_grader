/*** HELP START ***//*

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

*//*** HELP END ***/

%macro CTCAE5_K(
 PARAMCD = PARAMCD
,AVAL = AVAL
,AVALU = AVALU
,ANRLO = ANRLO
,ANRHI = ANRHI
);
length ATOXGRH ATOXGRL ATOXGR  $200.;
if &PARAMCD.="K" then do;
  call missing(of  ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN);
  if &PARAMCD.="K" and not missing(&AVAL.) and &AVALU ="mmol/L" then do;
    ATOXGRH='Grade 0';
    if not missing(&ANRHI.) then do;
         if &ANRHI. < &AVAL.  <=5.5 then ATOXGRH= 'Grade 1';
     end;
     if 5.5 < &AVAL.  <=6 then ATOXGRH= 'Grade 2';
     else if 6 < &AVAL.  <=7 then ATOXGRH= 'Grade 3';
     else if 7 < &AVAL.   then ATOXGRH= 'Grade 4';
  end;

  if &PARAMCD.="K" and not missing(&AVAL.)  and &AVALU ="mmol/L" then do;
    ATOXGRL='Grade 0';
      if not missing(&ANRLO.) then do;
        if &AVAL. < &ANRLO. and 3 <= &AVAL. then ATOXGRL = 'Grade 2';
      end;
      if 2.5 <= &AVAL. < 3 then ATOXGRL = 'Grade 3';
      else if &AVAL. < 2.5 then ATOXGRL = 'Grade 4';
  end;

  if &AVALU ne "mmol/L" then put "WARNING:" &PARAMCD.= &AVALU.= "is not expected ('mmol/L').";

  ATOXGRHN = input(compress(ATOXGRH,,"kd"),best.);
  ATOXGRLN = input(compress(ATOXGRL,,"kd"),best.);
  if 0 < n(of ATOXGRHN ATOXGRLN) then do;
     ATOXGRN = max(of ATOXGRHN ATOXGRLN);
     ATOXGR = catx(" ","Grade",ATOXGRN);
  end;
end;
%mend;

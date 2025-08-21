/*** HELP START ***//*

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

*//*** HELP END ***/

%macro CTCAE5_MG(
 PARAMCD = PARAMCD
,AVAL = AVAL
,AVALU = AVALU
,ANRLO = ANRLO
,ANRHI = ANRHI
);
length ATOXGRH ATOXGRL ATOXGR  $200.;
if &PARAMCD.="MG" then do;
  call missing(of  ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN);
  if &PARAMCD.="MG" and not missing(&AVAL.) and &AVALU ="mg/dL" then do;
    ATOXGRH='Grade 0';
    if not missing(&ANRHI.) then do;
         if &ANRHI. < &AVAL.  <=3 then ATOXGRH= 'Grade 1';
     end;
     if 3 < &AVAL.  <=8 then ATOXGRH= 'Grade 3';
     else if 8 < &AVAL.   then ATOXGRH= 'Grade 4';
  end;

  if &PARAMCD.="MG" and not missing(&AVAL.)  and &AVALU ="mg/dL" then do;
    ATOXGRL='Grade 0';
      if not missing(&ANRLO.) then do;
        if &AVAL. < &ANRLO. and 1.2 <= &AVAL. then ATOXGRL = 'Grade 1';
      end;
      if 0.9 <= &AVAL. < 1.2 then ATOXGRL = 'Grade 2';
      else if 0.7 <= &AVAL. < 0.9 then ATOXGRL = 'Grade 3';
      else if &AVAL. < 0.7 then ATOXGRL = 'Grade 4';
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

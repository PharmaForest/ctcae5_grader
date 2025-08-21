/*** HELP START ***//*

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

*//*** HELP END ***/

%macro CTCAE5_NA(
 PARAMCD = PARAMCD
,AVAL = AVAL
,AVALU = AVALU
,ANRLO = ANRLO
,ANRHI = ANRHI
);
length ATOXGRH ATOXGRL ATOXGR  $200.;
if &PARAMCD.="NA" then do;
call missing(of  ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN);
  if &PARAMCD.="NA" and not missing(&AVAL.) and &AVALU ="mmol/L" then do;
    ATOXGRH='Grade 0';
    if not missing(&ANRHI.) then do;
         if &ANRHI. < &AVAL.  <=150 then ATOXGRH= 'Grade 1';
     end;
     if 150 < &AVAL.  <=155 then ATOXGRH= 'Grade 2';
     else if 155 < &AVAL.  <=160 then ATOXGRH= 'Grade 3';
     else if 160 < &AVAL.   then ATOXGRH= 'Grade 4';
  end;

  if &PARAMCD.="NA" and not missing(&AVAL.)  and &AVALU ="mmol/L" then do;
    ATOXGRL='Grade 0';
      if not missing(&ANRLO.) then do;
        if &AVAL. < &ANRLO. and 130 <= &AVAL. then ATOXGRL = 'Grade 1';
      end;
      if 125 <= &AVAL. <= 129 then ATOXGRL = 'Grade 2';
      else if 120 <= &AVAL. <= 124 then ATOXGRL = 'Grade 3';
      else if &AVAL. < 120 then ATOXGRL = 'Grade 4';
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

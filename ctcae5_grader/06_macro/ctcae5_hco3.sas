/*** HELP START ***//*

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

*//*** HELP END ***/

%macro CTCAE5_HCO3(
 PARAMCD = PARAMCD
,AVAL = AVAL
,AVALU = AVALU
,ANRHI = ANRHI
,ANRLO = ANRLO
);
length ATOXGRH ATOXGRL ATOXGR $200.;
if &PARAMCD.="HCO3" then do;
  call missing(of  ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN);

  if &PARAMCD.="HCO3" and not missing(&AVAL.)  then do;
    ATOXGRL='Grade 0';
    if not missing(&ANRLO.) then do;
      if &AVAL. < &ANRLO. then ATOXGRL='Grade 1';
    end;
  end;

  ATOXGRHN = input(compress(ATOXGRH,,"kd"),best.);
  ATOXGRLN = input(compress(ATOXGRL,,"kd"),best.);
  if 0 < n(of  ATOXGRLN) then do;
     ATOXGRN = max(of  ATOXGRLN);
     ATOXGR = catx(" ","Grade",ATOXGRN);
  end;
end;
%mend;

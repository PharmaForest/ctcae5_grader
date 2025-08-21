/*** HELP START ***//*

Program/Macro : CTCAE5_HAPTOG

Parameters    :
  PARAMCD = Variable name (expected "HAPTOG")
  AVAL    = Observed value (Haptoglobin result)
  ANRLO   = Lower limit of normal (LLN)

Grading Criteria (CTCAE v5.0 - Haptoglobin):
  Low (Below LLN)
    - value < LLN                      -> Grade 1

*//*** HELP END ***/

%macro CTCAE5_HAPTOG(
  PARAMCD = PARAMCD
 ,AVAL    = AVAL
 ,ANRLO   = ANRLO     
);
length ATOXGRH ATOXGRL ATOXGR $200.;
if &PARAMCD.="HAPTOG" then do;
  call missing(of ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN);

  if &PARAMCD.="HAPTOG" and not missing(&AVAL.) then do;
    ATOXGRL = 'Grade 0';
    if not missing(&ANRLO.) then do;
      if &AVAL. < &ANRLO. then ATOXGRL = 'Grade 1';
    end;
  end;

  ATOXGRHN = input(compress(ATOXGRH,,"kd"),best.);
  ATOXGRLN = input(compress(ATOXGRL,,"kd"),best.);
  if 0 < n(of ATOXGRLN) then do;
    ATOXGRN = max(of ATOXGRLN);
    ATOXGR  = catx(" ","Grade", ATOXGRN);
  end;
end;
%mend;

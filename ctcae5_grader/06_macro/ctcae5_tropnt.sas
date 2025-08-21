/*** HELP START ***//*

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

*//*** HELP END ***/

%macro CTCAE5_TROPNT(
 PARAMCD = PARAMCD
,AVAL = AVAL
,ANRHI = ANRHI
,MFRHI   =
);
length ATOXGRH ATOXGRL ATOXGR $200.;
if &PARAMCD.="TROPNT" then do;
  call missing(of  ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN);
  if &PARAMCD.="TROPNT" and not missing(&AVAL.) then do;
    ATOXGRH='Grade 0';
    if not missing(&ANRHI.) then do;
      if &ANRHI. < &AVAL.  then ATOXGRH= 'Grade 1';
    end;
    %if %length(&MFRHI) ne 0 %then %do;
       if &ANRHI. < &AVAL. < &MFRHI.  then ATOXGRH= 'Grade 1';
        else if &MFRHI. <= &AVAL. then ATOXGRH= 'Grade 3';
    %end;
  end;

  ATOXGRHN = input(compress(ATOXGRH,,"kd"),best.);
  if 0 < n(of ATOXGRHN ) then do;
     ATOXGRN = max(of ATOXGRHN );
     ATOXGR = catx(" ","Grade",ATOXGRN);
  end;
end;
%mend;

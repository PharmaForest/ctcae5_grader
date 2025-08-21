/*** HELP START ***//*

Program/Macro : CTCAE5_APTT

Parameters    :
  PARAMCD = Variable name (expected "APTT")
  AVAL    = Observed value (APTT result, in seconds)
  ANRHI   = Upper limit of normal (ULN)

Grading Criteria (CTCAE v5.0 - Activated Partial Thromboplastin Time):
  Prolonged (Above ULN)
    - ULN < value <= 1.5 * ULN          -> Grade 1
    - 1.5 * ULN < value <= 2.5 * ULN    -> Grade 2
    - value > 2.5 * ULN                -> Grade 3

*//*** HELP END ***/

%macro CTCAE5_APTT(
 PARAMCD = PARAMCD
,AVAL = AVAL
,ANRHI = ANRHI
);
length ATOXGRH ATOXGRL ATOXGR $200.;
if &PARAMCD.="APTT" then do;
  call missing(of  ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN);
  if &PARAMCD.="APTT" and not missing(&AVAL.) then do;
    ATOXGRH='Grade 0';
    if not missing(&ANRHI.) then do;
      if &ANRHI. < &AVAL. <= round(&ANRHI. * 1.5,1e-10) then ATOXGRH= 'Grade 1';
      else if round( &ANRHI. * 1.5,1e-10) < &AVAL. <= round(&ANRHI. * 2.5,1e-10) then ATOXGRH= 'Grade 2';
      else if round( &ANRHI. * 2.5,1e-10) < &AVAL. then ATOXGRH= 'Grade 3';
    end;
  end;

  ATOXGRHN = input(compress(ATOXGRH,,"kd"),best.);
  if 0 < n(of ATOXGRHN ) then do;
     ATOXGRN = max(of ATOXGRHN );
     ATOXGR = catx(" ","Grade",ATOXGRN);
  end;
end;
%mend;

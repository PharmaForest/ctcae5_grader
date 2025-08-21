/*** HELP START ***//*

Program/Macro : CTCAE5_CREAT

Parameters    :
  PARAMCD = Variable name (expected "CREAT")
  AVAL    = Observed value (Creatinine result, e.g., mg/dL or ・ｽ・ｽmol/L)
  ANRHI   = Upper limit of normal (ULN)

Grading Criteria (CTCAE v5.0 - Creatinine):
  High (Above ULN)
    - ULN < value <= 1.5 * ULN           -> Grade 1
    - 1.5 * ULN < value <= 3 * ULN       -> Grade 2
    - 3 * ULN < value <= 6 * ULN         -> Grade 3
    - value > 6 * ULN                   -> Grade 4

*//*** HELP END ***/


%macro CTCAE5_CREAT(
 PARAMCD = PARAMCD
,AVAL = AVAL
,ANRHI = ANRHI
);
length ATOXGRH ATOXGRL ATOXGR $200.;
if &PARAMCD.="CREAT" then do;
  call missing(of  ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN);
  if &PARAMCD.="CREAT" and not missing(&AVAL.) then do;
    ATOXGRH='Grade 0';
    if not missing(&ANRHI.) then do;
      if &ANRHI. < &AVAL. <= round(&ANRHI. * 1.5,1e-10) then ATOXGRH= 'Grade 1';
      else if round( &ANRHI. * 1.5,1e-10) < &AVAL. <= round(&ANRHI. * 3,1e-10) then ATOXGRH= 'Grade 2';
      else if round( &ANRHI. * 3,1e-10) < &AVAL. <= round(&ANRHI. * 6,1e-10) then ATOXGRH= 'Grade 3';
      else if round( &ANRHI. * 6,1e-10) < &AVAL.  then ATOXGRH= 'Grade 4';
    end;
  end;

  ATOXGRHN = input(compress(ATOXGRH,,"kd"),best.);
  if 0 < n(of ATOXGRHN ) then do;
     ATOXGRN = max(of ATOXGRHN );
     ATOXGR = catx(" ","Grade",ATOXGRN);
  end;
end;
%mend;

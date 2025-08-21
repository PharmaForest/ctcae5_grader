/*** HELP START ***//*

Program/Macro : CTCAE5_BILI

Parameters    :
  PARAMCD = Variable name (expected "BILI")
  AVAL    = Observed value (Total Bilirubin result, in mg/dL)
  BASE    = Baseline value
  ANRHI   = Upper limit of normal (ULN)

Grading Criteria (CTCAE v5.0 - Total Bilirubin):
  If baseline <= ULN:
    - ULN < value <= 1.5 * ULN          -> Grade 1
    - 1.5 * ULN < value <= 3 * ULN      -> Grade 2
    - 3 * ULN < value <= 10 * ULN       -> Grade 3
    - value > 10 * ULN                 -> Grade 4

  If baseline > ULN:
    - baseline < value <= 1.5 * baseline   -> Grade 1
    - 1.5 * baseline < value <= 3 * baseline -> Grade 2
    - 3 * baseline < value <= 10 * baseline -> Grade 3
    - value > 10 * baseline                -> Grade 4

*//*** HELP END ***/


%macro CTCAE5_BILI(
 PARAMCD = PARAMCD
,AVAL = AVAL
,BASE = BASE
,ANRHI = ANRHI
);
length ATOXGRH ATOXGRL ATOXGR $200.;
if &PARAMCD.="BILI" then do;
  call missing(of  ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN);
  if &PARAMCD.="BILI" and not missing(&AVAL.) then do;
    if ^missing(&BASE.) and &BASE. >  &ANRHI. then do;
      BILI_BASEABFL = "Y";
   end;
    ATOXGRH='Grade 0';
    if not missing(&ANRHI.) and  BILI_BASEABFL ne "Y"  then do;
      if round(&ANRHI.,1e-10) < &AVAL. <= round(&ANRHI. * 1.5,1e-10) then ATOXGRH= 'Grade 1';
      else if round(&ANRHI. * 1.5,1e-10) < &AVAL. <= round(&ANRHI. * 3,1e-10) then ATOXGRH= 'Grade 2';
      else if round(&ANRHI. * 3,1e-10) < &AVAL. <= round(&ANRHI. * 10,1e-10) then ATOXGRH= 'Grade 3';
      else if round(&ANRHI. * 10,1e-10) < &AVAL.  then ATOXGRH= 'Grade 4';
    end;
    if BILI_BASEABFL = "Y" then do;
      if round(&BASE.,1e-10) < &AVAL. <= round(&BASE. * 1.5,1e-10) then ATOXGRH= 'Grade 1';
      else if round(&BASE. * 1.5,1e-10) < &AVAL. <= round(&BASE. * 3,1e-10) then ATOXGRH= 'Grade 2';
      else if round(&BASE. * 3,1e-10) < &AVAL. <= round(&BASE. * 10,1e-10) then ATOXGRH= 'Grade 3';
      else if round(&BASE. * 10,1e-10) < &AVAL.  then ATOXGRH= 'Grade 4';
    end;
  end;

  ATOXGRHN = input(compress(ATOXGRH,,"kd"),best.);
  if 0 < n(of ATOXGRHN ) then do;
     ATOXGRN = max(of ATOXGRHN );
     ATOXGR = catx(" ","Grade",ATOXGRN);
  end;
end;
%mend;

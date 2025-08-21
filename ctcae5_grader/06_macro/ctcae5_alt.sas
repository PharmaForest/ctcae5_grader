/*** HELP START ***//*

Program/Macro : CTCAE5_ALT

Parameters    :
  PARAMCD = Variable name (expected "ALT")
  AVAL    = Observed value (ALT result, in U/L)
  BASE    = Baseline value
  ANRHI   = Upper limit of normal (ULN)

Grading Criteria (CTCAE v5.0 - Alanine Aminotransferase):
  If baseline <= ULN:
    - ULN < value <= 3 * ULN            -> Grade 1
    - 3 * ULN < value <= 5 * ULN        -> Grade 2
    - 5 * ULN < value <= 20 * ULN       -> Grade 3
    - value > 20 * ULN                 -> Grade 4

  If baseline > ULN:
    - 1.5 * baseline < value <= 3 * baseline   -> Grade 1
    - 3 * baseline < value <= 5 * baseline     -> Grade 2
    - 5 * baseline < value <= 20 * baseline    -> Grade 3
    - value > 20 * baseline                   -> Grade 4

*//*** HELP END ***/


%macro CTCAE5_ALT(
 PARAMCD = PARAMCD
,AVAL = AVAL
,BASE = BASE
,ANRHI = ANRHI
);
length ATOXGRH ATOXGRL ATOXGR $200.;
if &PARAMCD.="ALT" then do;
call missing(of  ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN);
  if &PARAMCD.="ALT" and not missing(&AVAL.) then do;
    if ^missing(&BASE.) and &BASE. >  &ANRHI. then do;
      ALT_BASEABFL = "Y";
   end;
    ATOXGRH='Grade 0';
    if not missing(&ANRHI.) and  ALT_BASEABFL ne "Y"  then do;
      if round(&ANRHI.,1e-10) < &AVAL. <= round(&ANRHI. * 3,1e-10) then ATOXGRH= 'Grade 1';
      else if round(&ANRHI. * 3,1e-10) < &AVAL. <= round(&ANRHI. * 5,1e-10) then ATOXGRH= 'Grade 2';
      else if round(&ANRHI. * 5,1e-10) < &AVAL. <= round(&ANRHI. * 20,1e-10) then ATOXGRH= 'Grade 3';
      else if round(&ANRHI. * 20,1e-10) < &AVAL.  then ATOXGRH= 'Grade 4';
    end;
    if ALT_BASEABFL = "Y" then do;
      if round(&BASE. * 1.5,1e-10) < &AVAL. <= round(&BASE. * 3,1e-10) then ATOXGRH= 'Grade 1';
      else if round(&BASE. * 3,1e-10) < &AVAL. <= round(&BASE. * 5,1e-10) then ATOXGRH= 'Grade 2';
      else if round(&BASE. * 5,1e-10) < &AVAL. <= round(&BASE. * 20,1e-10) then ATOXGRH= 'Grade 3';
      else if round(&BASE. * 20,1e-10) < &AVAL.  then ATOXGRH= 'Grade 4';
    end;
  end;

  ATOXGRHN = input(compress(ATOXGRH,,"kd"),best.);
  if 0 < n(of ATOXGRHN ) then do;
     ATOXGRN = max(of ATOXGRHN );
     ATOXGR = catx(" ","Grade",ATOXGRN);
  end;
end;
%mend;

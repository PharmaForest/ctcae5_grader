/*** HELP START ***//*

Program/Macro : CTCAE5_GGT

Parameters    :
  PARAMCD = Variable name (expected "GGT")
  AVAL    = Observed value (GGT result, in U/L)
  BASE    = Baseline value
  ANRHI   = Upper limit of normal (ULN)

Grading Criteria (CTCAE v5.0 - Gamma-Glutamyl Transferase):
  If baseline ? ULN:
    - ULN < value <=2.5 * ULN          -> Grade 1
    - 2.5 * ULN < value ? 5 * ULN      -> Grade 2
    - 5 * ULN < value ? 20 * ULN       -> Grade 3
    - value > 20 * ULN                 -> Grade 4

  If baseline > ULN:
    - 2 * baseline < value <= 2.5 * baseline   -> Grade 1
    - 2.5 * baseline < value <= 5 * baseline   -> Grade 2
    - 5 * baseline < value <= 20 * baseline    -> Grade 3
    - value > 20 * baseline                   -> Grade 4

*//*** HELP END ***/

%macro CTCAE5_GGT(
 PARAMCD = PARAMCD
,AVAL = AVAL
,BASE = BASE
,ANRHI = ANRHI
);
length ATOXGRH ATOXGRL ATOXGR $200.;
if &PARAMCD.="GGT" then do;
  call missing(of  ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN);
  if &PARAMCD.="GGT" and not missing(&AVAL.) then do;
    if ^missing(&BASE.) and &BASE. >  &ANRHI. then do;
      GGT_BASEABFL = "Y";
   end;
    ATOXGRH='Grade 0';
    if not missing(&ANRHI.) and  GGT_BASEABFL ne "Y"  then do;
      if round(&ANRHI.,1e-10) < &AVAL. <= round(&ANRHI. * 2.5,1e-10) then ATOXGRH= 'Grade 1';
      else if round(&ANRHI. * 2.5,1e-10) < &AVAL. <= round(&ANRHI. * 5,1e-10) then ATOXGRH= 'Grade 2';
      else if round(&ANRHI. * 5,1e-10) < &AVAL. <= round(&ANRHI. * 20,1e-10) then ATOXGRH= 'Grade 3';
      else if round(&ANRHI. * 20,1e-10) < &AVAL.  then ATOXGRH= 'Grade 4';
    end;
    if GGT_BASEABFL = "Y" then do;
      if round(&BASE. * 2 ,1e-10) < &AVAL. <= round(&BASE. * 2.5,1e-10) then ATOXGRH= 'Grade 1';
      else if round(&BASE. * 2.5,1e-10) < &AVAL. <= round(&BASE. * 5,1e-10) then ATOXGRH= 'Grade 2';
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

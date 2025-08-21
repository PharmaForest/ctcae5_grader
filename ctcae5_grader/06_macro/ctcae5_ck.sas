/*** HELP START ***//*

Program/Macro : CTCAE5_CK

Parameters    :
  PARAMCD = Variable name (expected "CK")
  AVAL    = Observed value (Creatine Kinase result, in U/L)
  ANRHI   = Upper limit of normal (ULN)

Grading Criteria (CTCAE v5.0 - Creatine Kinase):
  High (Above ULN)
    - ULN < value <= 2.5 * ULN           -> Grade 1
    - 2.5 * ULN < value <= 5 * ULN       -> Grade 2
    - 5 * ULN < value <= 10 * ULN        -> Grade 3
    - value > 10 * ULN                  -> Grade 4

*//*** HELP END ***/


%macro CTCAE5_CK(
 PARAMCD = PARAMCD
,AVAL = AVAL
,ANRHI = ANRHI
);
length ATOXGRH ATOXGRL ATOXGR $200.;
if &PARAMCD.="CK" then do;
  call missing(of  ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN);
  if &PARAMCD.="CK" and not missing(&AVAL.) then do;
    ATOXGRH='Grade 0';
    if not missing(&ANRHI.) then do;
      if &ANRHI. < &AVAL. <= round(&ANRHI. * 2.5,1e-10) then ATOXGRH= 'Grade 1';
      else if round( &ANRHI. * 2.5,1e-10) < &AVAL. <= round(&ANRHI. * 5,1e-10) then ATOXGRH= 'Grade 2';
      else if round( &ANRHI. * 5,1e-10) < &AVAL. <= round(&ANRHI. * 10,1e-10) then ATOXGRH= 'Grade 3';
      else if round( &ANRHI. * 10,1e-10) < &AVAL.  then ATOXGRH= 'Grade 4';
    end;
  end;

  ATOXGRHN = input(compress(ATOXGRH,,"kd"),best.);
  if 0 < n(of ATOXGRHN ) then do;
     ATOXGRN = max(of ATOXGRHN );
     ATOXGR = catx(" ","Grade",ATOXGRN);
  end;
end;
%mend;

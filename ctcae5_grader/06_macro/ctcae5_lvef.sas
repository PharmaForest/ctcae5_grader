/*** HELP START ***//*

Program/Macro : CTCAE5_LVEF

Parameters    :
  PARAMCD = Variable name (expected "LVEF")
  AVAL    = Observed value (Left Ventricular Ejection Fraction, in %)
  AVALU   = Unit (expected "%")
  BASE    = Baseline value (in %)

Grading Criteria (CTCAE v5.0 - LVEF):

  Absolute value:
    - 40% <= value < 50%                 -> Grade 2
    - 20% <= value < 40%                 -> Grade 3
    - value < 20%                       -> Grade 4

  Drop from baseline:
    - 10% <= decrease < 20%              -> Grade 2
    - decrease >= 20%                    -> Grade 3

*//*** HELP END ***/

%macro CTCAE5_LVEF(
  PARAMCD = PARAMCD
 ,AVAL    = AVAL     
 ,AVALU   = AVALU     
 ,BASE    = BASE      
);

length ATOXGRH ATOXGRL ATOXGR $200.;
length _G_ABS _G_BASE $200.;
if &PARAMCD.="LVEF" then do;
  call missing(of ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN _G_ABS _G_BASE);

  if &PARAMCD.="LVEF" and not missing(&AVAL.) then do;

    if not missing(&AVALU.) and &AVALU. ne "%" then
      put "WARNING:" &PARAMCD.= &AVALU.= 'expected "%"';

    _G_ABS  = 'Grade 0';
    _G_BASE = 'Grade 0';

    if 40 <= &AVAL. < 50 then _G_ABS = 'Grade 2';
    else if 20 <= &AVAL. < 40 then _G_ABS = 'Grade 3';
    else if &AVAL. < 20       then _G_ABS = 'Grade 4';

    if not missing(&BASE.) then do;
      _drop = round(&BASE. - &AVAL., 1e-10);
      if 10 <= _drop < 20 then _G_BASE = 'Grade 2';
      else if 20 <= _drop then _G_BASE = 'Grade 3';
    end;

    _abs_n  = input(compress(_G_ABS ,,"kd"), best.);
    _base_n = input(compress(_G_BASE,,"kd"), best.);
    if n(_abs_n, _base_n) > 0 then do;
      ATOXGRLN = max(_abs_n, _base_n);
      ATOXGRL  = catx(" ","Grade", ATOXGRLN);
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

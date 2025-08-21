/*** HELP START ***//*

Program/Macro : CTCAE5_DLCO

Parameters    :
  PARAMCD = Variable name (expected "DLCO")
  AVAL    = Observed value (DLCO result)
  AVALU   = Unit (e.g., mL/min/mmHg or % predicted)
  BASE    = Baseline value
  ANRLO   = Lower limit of normal (LLN)

Grading Criteria (CTCAE v5.0 - DLCO):
  Compared with LLN:
    - 0 < (LLN - value) <= 3            -> Grade 1
    - 3 < (LLN - value) <= 5            -> Grade 2
    - 5 < (LLN - value) <= 8            -> Grade 3
    - (LLN - value) > 8                -> Grade 4

  Compared with Baseline:
    - 0 < (Baseline - value) <= 3       -> Grade 1
    - 3 < (Baseline - value) <= 5       -> Grade 2
    - 5 < (Baseline - value) <= 8       -> Grade 3
    - (Baseline - value) > 8           -> Grade 4

*//*** HELP END ***/

%macro CTCAE5_DLCO(
  PARAMCD = PARAMCD
 ,AVAL    = AVAL
 ,AVALU   = AVALU
 ,BASE    = BASE
 ,ANRLO   = ANRLO
);
length ATOXGRH ATOXGRL ATOXGR $200.;
length _G_LL _G_BASE $200.;
if &PARAMCD.="DLCO" then do;
  call missing(of ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN _G_LL _G_BASE);

  if &PARAMCD.="DLCO" and not missing(&AVAL.) then do;

    _G_LL   = 'Grade 0';
    _G_BASE = 'Grade 0';

    if not missing(&ANRLO.) then do;
      _dlco_diff_lln = round(&ANRLO. - &AVAL., 1e-10);
      if      0  < _dlco_diff_lln <= 3 then _G_LL = 'Grade 1';
      else if 3  < _dlco_diff_lln <= 5 then _G_LL = 'Grade 2';
      else if 5  < _dlco_diff_lln <= 8 then _G_LL = 'Grade 3';
      else if 8  < _dlco_diff_lln       then _G_LL = 'Grade 4';
    end;

    if not missing(&BASE.) then do;
      _dlco_diff_base = round(&BASE. - &AVAL., 1e-10);
      if      0  < _dlco_diff_base <= 3 then _G_BASE = 'Grade 1';
      else if 3  < _dlco_diff_base <= 5 then _G_BASE = 'Grade 2';
      else if 5  < _dlco_diff_base <= 8 then _G_BASE = 'Grade 3';
      else if 8  < _dlco_diff_base       then _G_BASE = 'Grade 4';
    end;

    ATOXGRL  = _G_LL;
    _g_ll_n   = input(compress(_G_LL  ,,"kd"), best.);
    _g_base_n = input(compress(_G_BASE,,"kd"), best.);
    if n(_g_ll_n, _g_base_n) > 0 then do;
      ATOXGRLN = max(_g_ll_n, _g_base_n);
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

/*** HELP START ***//*

Program/Macro : CTCAE5_QTCF

Parameters    :
  PARAMCD = Variable name (expected "QTCF")
  AVAL    = Observed value (QTcF interval, in milliseconds)
  AVALU   = Unit (expected "ms")
  BASE    = Baseline value (in ms)

Grading Criteria (CTCAE v5.0 - QTcF Interval):

  Absolute value:
    - 450 ms <= value <= 480 ms           -> Grade 1
    - 480 ms < value <= 500 ms           -> Grade 2
    - value > 500 ms                    -> Grade 3

  Change from baseline:
    - 30 ms <= increase < 60 ms          -> Grade 1
    - increase >= 60 ms                  -> Grade 2

*//*** HELP END ***/

%macro CTCAE5_QTCF(
  PARAMCD = PARAMCD     
 ,AVAL    = AVAL        
 ,AVALU   = AVALU     
 ,BASE    = BASE        
);

length ATOXGRH ATOXGRL ATOXGR $200.;
length _G_ABS _G_DELTA $200.;
if &PARAMCD. ="QTCF" then do;
  call missing(of ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN _G_ABS _G_DELTA);

  if &PARAMCD. ="QTCF"  and not missing(&AVAL.) then do;

    if not missing(&AVALU.) and upcase(&AVALU.) ne "MS" then
      put "WARNING:" &PARAMCD.= &AVALU.= 'expected "ms"';

    _G_ABS   = 'Grade 0';
    _G_DELTA = 'Grade 0';

    if 450 <= &AVAL. <= 480 then _G_ABS = 'Grade 1';
    else if 480 < &AVAL. <= 500 then _G_ABS = 'Grade 2';
    else if 500 < &AVAL.        then _G_ABS = 'Grade 3';

    if not missing(&BASE.) then do;
      _dqtc = round(&AVAL. - &BASE., 1e-10);
      if 30 <= _dqtc < 60 then _G_DELTA = 'Grade 1';
      else if 60 <= _dqtc then _G_DELTA = 'Grade 2';
    end;

    _abs_n   = input(compress(_G_ABS  ,,"kd"), best.);
    _delta_n = input(compress(_G_DELTA,,"kd"), best.);
    if n(_abs_n, _delta_n) > 0 then do;
      ATOXGRHN = max(_abs_n, _delta_n);
      ATOXGRH  = catx(" ","Grade", ATOXGRHN);
    end;
  end;

  if 0 < n(of ATOXGRHN) then do;
    ATOXGRN = ATOXGRHN;
    ATOXGR  = catx(" ","Grade", ATOXGRN);
  end;
end;
%mend;

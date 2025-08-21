/*** HELP START ***//*

Program/Macro : CTCAE5_FEV1

Parameters    :
  PARAMCD = Variable name (expected "FEV1")
  AVAL    = Observed value (FEV1 result, % of predicted)
  AVALU   = Unit (expected "%")

Grading Criteria (CTCAE v5.0 - FEV1):
  - 70% <= value <= 99%                  -> Grade 1
  - 60% <= value < 70%                  -> Grade 2
  - 50% <= value < 60%                  -> Grade 3
  - value < 50%                        -> Grade 4

*//*** HELP END ***/

%macro CTCAE5_FEV1(
  PARAMCD = PARAMCD
 ,AVAL    = AVAL      
 ,AVALU   = AVALU   
);
length ATOXGRH ATOXGRL ATOXGR $200.;
if &PARAMCD.="FEV1" then do;
  call missing(of ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN);

  if &PARAMCD.="FEV1" and not missing(&AVAL.) then do;

    if not missing(&AVALU.) and upcase(&AVALU.) ne "%" then
      put "WARNING:" &PARAMCD.= &AVALU.= 'expected "%"';

    ATOXGRL = 'Grade 0';
    if 70 <= &AVAL. <= 99 then ATOXGRL = 'Grade 1';
    else if 60 <= &AVAL. < 70 then ATOXGRL = 'Grade 2';
    else if 49 <  &AVAL. < 60 then ATOXGRL = 'Grade 3';
    else if        &AVAL. <= 49 then ATOXGRL = 'Grade 4';
  end;

  ATOXGRLN = input(compress(ATOXGRL,,"kd"),best.);
  if 0 < n(of ATOXGRLN) then do;
    ATOXGRN = ATOXGRLN;
    ATOXGR  = catx(" ","Grade",ATOXGRN);
  end;
end;
%mend;

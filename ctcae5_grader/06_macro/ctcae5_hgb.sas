/*** HELP START ***//*

Program/Macro : CTCAE5_HGB

Parameters    :
  PARAMCD = Variable name (expected "HGB")
  AVAL    = Observed value (Hemoglobin result)
  AVALU   = Unit (expected "g/dL")
  ANRHI   = Upper limit of normal (ULN)
  ANRLO   = Lower limit of normal (LLN)

Grading Criteria (CTCAE v5.0 - Hemoglobin):
  High (Above ULN)
    - ULN < value <= ULN+2 g/dL         ->Grade 1
    - ULN+2 < value <= ULN+4 g/dL       ->Grade 2
    - value > ULN+4 g/dL               ->Grade 3

  Low (Below LLN)
    - 10 g/dL <= value < LLN            ->Grade 1
    - 8 g/dL <= value < 10 g/dL         ->Grade 2
    - value < 8 g/dL                   ->Grade 3

*//*** HELP END ***/

%macro CTCAE5_HGB(
 PARAMCD = PARAMCD
,AVAL = AVAL
,AVALU = AVALU
,ANRHI = ANRHI
,ANRLO = ANRLO
);
length ATOXGRH ATOXGRL ATOXGR  $200.;
if &PARAMCD.="HGB" then do;
  call missing(of  ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN);
  if &PARAMCD.="HGB" and not missing(&AVAL.) then do;
    if &AVALU. notin ("g/dL","g%","Gram per Deciliter") then put "WARNING:" &PARAMCD.= &AVALU.=  'ne "g/dL"';
  end;
  if &PARAMCD.="HGB" and not missing(&AVAL.) and &AVALU.  ="g/dL" then do;
    ATOXGRH='Grade 0';
    if not missing(&ANRHI.) then do;
      HGB_diff_uln = round(&AVAL. - &ANRHI. ,1e-10);
      if 0 < HGB_diff_uln <= 2 then ATOXGRH='Grade 1';
      else if 2 < HGB_diff_uln <= 4 then ATOXGRH='Grade 2';
      else if HGB_diff_uln > 4 then ATOXGRH='Grade 3';
    end;
  end;

  if &PARAMCD.="HGB" and not missing(&AVAL.) and &AVALU.  ="g/dL"  then do;
    ATOXGRL='Grade 0';
    if not missing(&ANRLO.) then do;
      if 10 <= &AVAL. < &ANRLO. then ATOXGRL='Grade 1';
    end;
    if 8 <= &AVAL. < 10 then ATOXGRL='Grade 2';
    else if &AVAL. < 8 then ATOXGRL='Grade 3';
  end;

  ATOXGRHN = input(compress(ATOXGRH,,"kd"),best.);
  ATOXGRLN = input(compress(ATOXGRL,,"kd"),best.);
  if 0 < n(of ATOXGRHN ATOXGRLN) then do;
     ATOXGRN = max(of ATOXGRHN ATOXGRLN);
     ATOXGR = catx(" ","Grade",ATOXGRN);
  end;
end;
%mend;

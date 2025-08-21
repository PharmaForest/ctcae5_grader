/*** HELP START ***//*

Program/Macro : CTCAE5_ALB

Parameters    :
  PARAMCD = Variable name (expected "ALB")
  AVAL    = Observed value (Albumin result)
  AVALU   = Unit (expected "g/dL" or "g/L")
  ANRLO   = Lower limit of normal (LLN)

Grading Criteria (CTCAE v5.0 - Albumin):

  Units in "g/dL":
    - value < LLN and >= 3.0             -> Grade 1
    - 2.0 <= value < 3.0                 -> Grade 2
    - value < 2.0                       -> Grade 3

  Units in "g/L":
    - value < LLN and >= 30              -> Grade 1
    - 20 <= value < 30                   -> Grade 2
    - value < 20                        -> Grade 3

*//*** HELP END ***/


%macro CTCAE5_ALB(
 PARAMCD = PARAMCD
,AVAL = AVAL
,AVALU = AVALU
,ANRLO = ANRLO
);
length ATOXGRH ATOXGRL ATOXGR  $200.;
if &PARAMCD.="ALB" then do;
  call missing(of  ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN);

  if &PARAMCD.="ALB" and not missing(&AVAL.)  then do;
    ATOXGRL='Grade 0';
    if &AVALU. in ("g/dL") then do;
      if not missing(&ANRLO.) then do;
        if &AVAL. < &ANRLO. and 3 <= &AVAL. then ATOXGRL = 'Grade 1';
      end;
      if 2 <= &AVAL. < 3 then ATOXGRL = 'Grade 2';
      else if &AVAL. < 2 then ATOXGRL = 'Grade 3';
    end;

    else if &AVALU. in ("g/L") then do;
      if not missing(&ANRLO.) then do;
        if &AVAL. < &ANRLO. and 30 <= &AVAL. then ATOXGRL = 'Grade 1';
      end;
      if 20 <= &AVAL. < 30 then ATOXGRL = 'Grade 2';
      else if &AVAL. < 20 then ATOXGRL = 'Grade 3';  
    end;
    else do;
      put "WARNING:" &PARAMCD.= &AVALU.= "is not expected ('g/dL' or 'g/L').";
    end;
  end;


  ATOXGRHN = input(compress(ATOXGRH,,"kd"),best.);
  ATOXGRLN = input(compress(ATOXGRL,,"kd"),best.);
  if 0 < n(of ATOXGRHN ATOXGRLN) then do;
     ATOXGRN = max(of ATOXGRHN ATOXGRLN);
     ATOXGR = catx(" ","Grade",ATOXGRN);
  end;
end;
%mend;

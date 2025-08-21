/*** HELP START ***//*

Program/Macro : CTCAE5_FIBRINOG

Parameters    :
  PARAMCD = Variable name (expected "FIBRINOG")
  AVAL    = Observed value (Fibrinogen result)
  BASE    = Baseline value
  ANRLO   = Lower limit of normal (LLN)
  AVALU   = Unit (expected "mg/dL" or "g/L")

Grading Criteria (CTCAE v5.0 - Fibrinogen):

  If baseline >= LLN:
    - 0.75 * LLN <= value < LLN          -> Grade 1
    - 0.50 * LLN <= value < 0.75 * LLN   -> Grade 2
    - 0.25 * LLN <= value < 0.50 * LLN   -> Grade 3
    - value < 0.25 * LLN                -> Grade 4

  If baseline < LLN (baseline abnormal):
    - decrease <= 0% and > -25%          -> Grade 1
    - -50% < decrease <= -25%            -> Grade 2
    - -75% < decrease <= -50%            -> Grade 3
    - decrease <= -75%                   -> Grade 4

  Absolute threshold:
    - value < 50 mg/dL (or < 0.5 g/L)   -> Grade 4

*//*** HELP END ***/

%macro CTCAE5_FIBRINOG(
 PARAMCD = PARAMCD
,AVAL    = AVAL
,BASE    = BASE
,ANRLO   = ANRLO
,AVALU   = AVALU
);
length ATOXGRH ATOXGRL ATOXGR $200.;
if &PARAMCD.="FIBRINOG" then do;
  call missing(of ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN);

  if &PARAMCD.="FIBRINOG" and not missing(&AVAL.) then do;

    if ^missing(&BASE.) and &BASE. < &ANRLO. then FIBRINOG_BASEABFL = "Y";

    ATOXGRL = 'Grade 0';

    if not missing(&ANRLO.) and FIBRINOG_BASEABFL ne "Y" then do;
      if      round(&ANRLO.*0.75,1e-10) <= &AVAL. < round(&ANRLO.      ,1e-10) then ATOXGRL = 'Grade 1';
      else if round(&ANRLO.*0.50,1e-10) <= &AVAL. < round(&ANRLO.*0.75 ,1e-10) then ATOXGRL = 'Grade 2';
      else if round(&ANRLO.*0.25,1e-10) <= &AVAL. < round(&ANRLO.*0.50 ,1e-10) then ATOXGRL = 'Grade 3';
      else if                              &AVAL.  < round(&ANRLO.*0.25 ,1e-10) then ATOXGRL = 'Grade 4';
    end;

    if FIBRINOG_BASEABFL = "Y" then do;
      FIBRINOG_PCHG = round( (&AVAL. - &BASE.) / &BASE. * 100, 1e-10);  

      if      -25 <  FIBRINOG_PCHG <=   0 then ATOXGRL = 'Grade 1';   
      else if -50 <  FIBRINOG_PCHG <= -25 then ATOXGRL = 'Grade 2'; 
      else if -75 <  FIBRINOG_PCHG <= -50 then ATOXGRL = 'Grade 3'; 
      else if        FIBRINOG_PCHG <= -75 then ATOXGRL = 'Grade 4';   
    end;

    if not missing(&AVALU.) then do;
      if &AVALU. = "mg/dL" then do;
        if &AVAL. < 50 then ATOXGRL = 'Grade 4';
      end;
      else if &AVALU. = "g/L" then do;
        if &AVAL. < round(0.5,1e-10) then ATOXGRL = 'Grade 4';
      end;
      else do;
        put "WARNING:" &PARAMCD.= &AVALU.= "is not expected ('mg/dL' or 'g/L').";
      end;
    end;
  end;

  ATOXGRLN = input(compress(ATOXGRL,,"kd"), best.);
  if 0 < n(of ATOXGRLN) then do;
    ATOXGRN = max(of ATOXGRLN);
    ATOXGR  = catx(" ","Grade", ATOXGRN);
  end;
end;
%mend;

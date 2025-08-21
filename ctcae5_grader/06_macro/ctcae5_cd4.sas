/*** HELP START ***//*

Program/Macro : CTCAE5_CD4

Parameters    :
  PARAMCD = Variable name (expected "CD4")
  AVAL    = Observed value (CD4+ T-cell count)
  AVALU   = Unit (expected either per volume, e.g., "/mm3", "10^6/L", or "10^9/L")
  ANRLO   = Lower limit of normal (LLN)

Grading Criteria (CTCAE v5.0 - CD4 Count):

  Units in "/mm3", "10^6/L", "/uL", "10^3/mL", "M/L":
    - value < LLN and <= 500              -> Grade 1
    - 200 <= value < 500                  -> Grade 2
    - 50 <= value < 200                   -> Grade 3
    - value < 50                         -> Grade 4

  Units in "10^9/L", "/nL", "10^3/uL", "10^6/mL", "G/L":
    - value < LLN and <= 0.5              -> Grade 1
    - 0.2 <= value < 0.5                  -> Grade 2
    - 0.05 <= value < 0.2                 -> Grade 3
    - value < 0.05                       -> Grade 4

*//*** HELP END ***/


%macro CTCAE5_CD4(
  PARAMCD = PARAMCD
 ,AVAL    = AVAL
 ,AVALU   = AVALU      
 ,ANRLO   = ANRLO      
);

length ATOXGRH ATOXGRL ATOXGR $200.;
if &PARAMCD.="CD4" then do;
  call missing(of ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN);

  if &PARAMCD.="CD4" and not missing(&AVAL.) then do;
    ATOXGRL = 'Grade 0';

    if &AVALU. in ("/mm3","10^6/L"," /uL", "1/mm3", "1/uL", "10^3/mL", "M/L", "Mega/L") then do;
      if not missing(&ANRLO.) then do;
        if &AVAL. < &ANRLO. and 500 <= &AVAL. then ATOXGRL = 'Grade 1';
      end;
      if 200 <= &AVAL. < 500 then ATOXGRL = 'Grade 2';
      else if 50 <= &AVAL. < 200 then ATOXGRL = 'Grade 3';
      else if &AVAL. < 50 then ATOXGRL = 'Grade 4';
    end;

    else if &AVALU. in ("10^9/L","10E9/L","10e9/L","/nL", "1/nL", "10^3/mm3", "10^3/uL", "10^6/mL", "G/L", "GI/L", "Giga per Liter", "K/cumm", "Thou/mcL") then do;
      if not missing(&ANRLO.) then do;
        if &AVAL. < &ANRLO. and round(&AVAL.,1e-10) >= round(0.5,1e-10) then ATOXGRL = 'Grade 1';
      end;
      if round(0.2,1e-10) <= &AVAL. < round(0.5,1e-10) then ATOXGRL = 'Grade 2';
      else if round(0.05,1e-10) <= &AVAL. < round(0.2,1e-10) then ATOXGRL = 'Grade 3';
      else if &AVAL. < round(0.05,1e-10) then ATOXGRL = 'Grade 4';
    end;
    else do;
      put "WARNING:" &PARAMCD.= &AVALU.= "is not expected ('/mm3' or '10^9/L').";
    end;
  end;

  ATOXGRHN = input(compress(ATOXGRH,,"kd"),best.);
  ATOXGRLN = input(compress(ATOXGRL,,"kd"),best.);
  if 0 < n(of ATOXGRLN) then do;
    ATOXGRN = max(of ATOXGRLN);
    ATOXGR  = catx(" ","Grade",ATOXGRN);
  end;
end;
%mend;

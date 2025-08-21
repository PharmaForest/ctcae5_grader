/*** HELP START ***//*

Program/Macro : CTCAE5_LYM

Parameters    :
  PARAMCD = Variable name (expected "LYM")
  AVAL    = Observed value (Lymphocyte count)
  AVALU   = Unit (expected either per volume, e.g., "/mm3", "/uL" or "10^9/L")
  ANRLO   = Lower limit of normal (LLN)

Grading Criteria (CTCAE v5.0 - Lymphocytes):

  High (Above ULN):
    Units in "/mm3", "/uL":
      - 4000 < value <= 20000            -> Grade 2
      - value > 20000                   -> Grade 3

    Units in "10^9/L":
      - 4 < value <= 20                  -> Grade 2
      - value > 20                      -> Grade 3

  Low (Below LLN):
    Units in "/mm3", "/uL":
      - value < LLN and <= 800           -> Grade 1
      - 500 <= value < 800               -> Grade 2
      - 200 <= value < 500               -> Grade 3
      - value < 200                     -> Grade 4

    Units in "10^9/L":
      - value < LLN and <= 0.8           -> Grade 1
      - 0.5 <= value < 0.8               -> Grade 2
      - 0.2 <= value < 0.5               -> Grade 3
      - value < 0.2                     -> Grade 4

*//*** HELP END ***/


%macro CTCAE5_LYM(
 PARAMCD = PARAMCD
,AVAL = AVAL
,AVALU = AVALU
,ANRLO = ANRLO
);
length ATOXGRH ATOXGRL ATOXGR  $200.;
if &PARAMCD.="LYM" then do;
  call missing(of  ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN);
  if &PARAMCD.="LYM" and not missing(&AVAL.) then do;
    ATOXGRH='Grade 0';
    if &AVALU. in ("/mm3","10^6/L"," /uL", "1/mm3", "1/uL", "10^3/mL", "M/L", "Mega/L") then do;
       if 4000 < &AVAL. <= 20000 then ATOXGRH= 'Grade 2';
      else if 20000 < &AVAL.  then ATOXGRH= 'Grade 3';
    end;
    else if &AVALU. in ("10^9/L","10E9/L","10e9/L","/nL", "1/nL", "10^3/mm3", "10^3/uL", "10^6/mL", "G/L", "GI/L", "Giga per Liter", "K/cumm", "Thou/mcL") then do;
       if 4 < &AVAL. <= 20 then ATOXGRH= 'Grade 2';
      else if 20 < &AVAL.  then ATOXGRH= 'Grade 3';
    end;
  end;

  if &PARAMCD.="LYM" and not missing(&AVAL.)  then do;
    ATOXGRL='Grade 0';
    if &AVALU. in ("/mm3","10^6/L"," /uL", "1/mm3", "1/uL", "10^3/mL", "M/L", "Mega/L") then do;
      if not missing(&ANRLO.) then do;
        if &AVAL. < &ANRLO. and 800 <= &AVAL. then ATOXGRL = 'Grade 1';
      end;
      if 500 <= &AVAL. < 800 then ATOXGRL = 'Grade 2';
      else if 200 <= &AVAL. < 500 then ATOXGRL = 'Grade 3';
      else if &AVAL. < 200 then ATOXGRL = 'Grade 4';
    end;

    else if &AVALU. in ("10^9/L","10E9/L","10e9/L","/nL", "1/nL", "10^3/mm3", "10^3/uL", "10^6/mL", "G/L", "GI/L", "Giga per Liter", "K/cumm", "Thou/mcL") then do;
      if not missing(&ANRLO.) then do;
        if &AVAL. < &ANRLO. and round(&AVAL.,1e-10) >= round(0.8,1e-10) then ATOXGRL = 'Grade 1';
      end;
      if round(0.5,1e-10) <= &AVAL. < round(0.8,1e-10) then ATOXGRL = 'Grade 2';
      else if round(0.2,1e-10) <= &AVAL. < round(0.5,1e-10) then ATOXGRL = 'Grade 3';
      else if &AVAL. < round(0.2,1e-10) then ATOXGRL = 'Grade 4';
    end;
    else do;
      put "WARNING:" &PARAMCD.= &AVALU.= "is not expected ('/mm3' or '10^9/L').";
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

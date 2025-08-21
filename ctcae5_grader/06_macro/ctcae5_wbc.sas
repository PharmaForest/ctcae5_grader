/*** HELP START ***//*

Program/Macro : CTCAE5_WBC

Parameters    :
  PARAMCD = Variable name (expected "WBC")
  AVAL    = Observed value (White Blood Cell count)
  AVALU   = Unit (expected either per volume, e.g., "/mm3", "/uL" or "10^9/L")
  ANRLO   = Lower limit of normal (LLN)

Grading Criteria (CTCAE v5.0 - White Blood Cells):

  High (Leukocytosis):
    Units in "/mm3", "/uL":
      - value > 100,000                 -> Grade 3

    Units in "10^9/L":
      - value > 100                     -> Grade 3

  Low (Leukopenia):
    Units in "/mm3", "/uL":
      - value < LLN and ? 3000          -> Grade 1
      - 2000 <= value < 3000             -> Grade 2
      - 1000 <= value < 2000             -> Grade 3
      - value < 1000                    -> Grade 4

    Units in "10^9/L":
      - value < LLN and ? 3.0           -> Grade 1
      - 2.0 <= value < 3.0               -> Grade 2
      - 1.0 <= value < 2.0               -> Grade 3
      - value < 1.0                     -> Grade 4

*//*** HELP END ***/

%macro CTCAE5_WBC(
 PARAMCD = PARAMCD
,AVAL = AVAL
,AVALU = AVALU
,ANRLO = ANRLO
);
length ATOXGRH ATOXGRL ATOXGR  $200.;
if &PARAMCD.="WBC" then do;
  call missing(of  ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN);
  if &PARAMCD.="WBC" and not missing(&AVAL.) then do;
    ATOXGRH='Grade 0';
    if &AVALU. in ("/mm3","10^6/L"," /uL", "1/mm3", "1/uL", "10^3/mL", "M/L", "Mega/L") then do;
       if 100000 < &AVAL.  then ATOXGRH= 'Grade 3';
    end;
    else if &AVALU. in ("10^9/L","10E9/L","10e9/L","/nL", "1/nL", "10^3/mm3", "10^3/uL", "10^6/mL", "G/L", "GI/L", "Giga per Liter", "K/cumm", "Thou/mcL") then do;
       if 100 < &AVAL. then ATOXGRH= 'Grade 3';
    end;
  end;

  if &PARAMCD.="WBC" and not missing(&AVAL.)  then do;
    ATOXGRL='Grade 0';
    if &AVALU. in ("/mm3","10^6/L"," /uL", "1/mm3", "1/uL", "10^3/mL", "M/L", "Mega/L") then do;
      if not missing(&ANRLO.) then do;
        if &AVAL. < &ANRLO. and 3000 <= &AVAL. then ATOXGRL = 'Grade 1';
      end;
      if 2000 <= &AVAL. < 3000 then ATOXGRL = 'Grade 2';
      else if 1000 <= &AVAL. < 2000 then ATOXGRL = 'Grade 3';
      else if &AVAL. < 1000 then ATOXGRL = 'Grade 4';
    end;

    else if &AVALU. in ("10^9/L","10E9/L","10e9/L","/nL", "1/nL", "10^3/mm3", "10^3/uL", "10^6/mL", "G/L", "GI/L", "Giga per Liter", "K/cumm", "Thou/mcL") then do;
      if not missing(&ANRLO.) then do;
        if &AVAL. < &ANRLO. and round(&AVAL.,1e-10) >= round(3,1e-10) then ATOXGRL = 'Grade 1';
      end;
      if round(2,1e-10) <= &AVAL. < round(3,1e-10) then ATOXGRL = 'Grade 2';
      else if round(1,1e-10) <= &AVAL. < round(2,1e-10) then ATOXGRL = 'Grade 3';
      else if &AVAL. < round(1,1e-10) then ATOXGRL = 'Grade 4';
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

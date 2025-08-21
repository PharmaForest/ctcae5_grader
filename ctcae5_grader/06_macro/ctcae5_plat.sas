/*** HELP START ***//*

Program/Macro : CTCAE5_PLAT

Parameters    :
  PARAMCD = Variable name (expected "PLAT")
  AVAL    = Observed value (Platelet count)
  AVALU   = Unit (expected either per volume, e.g., "/mm3", "/uL" or "10^9/L")
  ANRLO   = Lower limit of normal (LLN)

Grading Criteria (CTCAE v5.0 - Platelets):

  Units in "/mm3", "/uL":
    - value < LLN and >= 75,000          -> Grade 1
    - 50,000 <= value < 75,000           -> Grade 2
    - 25,000 <= value < 50,000           -> Grade 3
    - value < 25,000                    -> Grade 4

  Units in "10^9/L":
    - value < LLN and >= 75              -> Grade 1
    - 50 <= value < 75                   -> Grade 2
    - 25 <= value < 50                   -> Grade 3
    - value < 25                        -> Grade 4

*//*** HELP END ***/

%macro CTCAE5_PLAT(
 PARAMCD = PARAMCD
,AVAL = AVAL
,AVALU = AVALU
,ANRLO = ANRLO
);
length ATOXGRH ATOXGRL ATOXGR  $200.;
if &PARAMCD.="PLAT" then do;
  call missing(of  ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN);

  if &PARAMCD.="PLAT" and not missing(&AVAL.)  then do;
    ATOXGRL='Grade 0';
    if &AVALU. in ("/mm3","10^6/L"," /uL", "1/mm3", "1/uL", "10^3/mL", "M/L", "Mega/L") then do;
      if not missing(&ANRLO.) then do;
        if &AVAL. < &ANRLO. and 75000 <= &AVAL. then ATOXGRL = 'Grade 1';
      end;
      if 50000 <= &AVAL. < 75000 then ATOXGRL = 'Grade 2';
      else if 25000 <= &AVAL. < 50000 then ATOXGRL = 'Grade 3';
      else if &AVAL. < 25000 then ATOXGRL = 'Grade 4';
    end;

    else if &AVALU. in ("10^9/L","10E9/L","10e9/L","/nL", "1/nL", "10^3/mm3", "10^3/uL", "10^6/mL", "G/L", "GI/L", "Giga per Liter", "K/cumm", "Thou/mcL") then do;
      if not missing(&ANRLO.) then do;
        if &AVAL. < &ANRLO. and round(&AVAL.,1e-10) >= round(75,1e-10) then ATOXGRL = 'Grade 1';
      end;
      if round(50,1e-10) <= &AVAL. < round(75,1e-10) then ATOXGRL = 'Grade 2';
      else if round(25,1e-10) <= &AVAL. < round(50,1e-10) then ATOXGRL = 'Grade 3';
      else if &AVAL. < round(25,1e-10) then ATOXGRL = 'Grade 4';
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

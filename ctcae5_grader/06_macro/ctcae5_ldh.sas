/*** HELP START ***//*

Program/Macro : CTCAE5_LDH

Parameters    :
  PARAMCD = Variable name (expected "LDH")
  AVAL    = Observed value (LDH result, in U/L)
  ANRHI   = Upper limit of normal (ULN)

Grading Criteria (CTCAE v5.0 - Lactate Dehydrogenase):
  High (Above ULN)
    - value > ULN                      -> Grade 1

*//*** HELP END ***/

%macro CTCAE5_LDH(
 PARAMCD = PARAMCD
,AVAL = AVAL
,ANRHI = ANRHI
);
length ATOXGRH ATOXGRL ATOXGR $200.;
if &PARAMCD.="LDH" then do;
call missing(of  ATOXGRH ATOXGRL ATOXGRHN ATOXGRLN ATOXGR ATOXGRN);
  if &PARAMCD.="LDH" and not missing(&AVAL.) then do;
    ATOXGRH='Grade 0';
    if not missing(&ANRHI.) then do;
      if &ANRHI. < &AVAL then ATOXGRH= 'Grade 1';
    end;
  end;

  ATOXGRHN = input(compress(ATOXGRH,,"kd"),best.);
  if 0 < n(of ATOXGRHN ) then do;
     ATOXGRN = max(of ATOXGRHN );
     ATOXGR = catx(" ","Grade",ATOXGRN);
  end;
end;
%mend;

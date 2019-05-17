"SUSPENSION for
			      SUSPENSION
	(c) Copyright 1982 Infocom, Inc.  All Rights Reserved.
"

<VERSION XZIP>

<SNAME "SUSPENDED">

<SETG STRS <IVECTOR 2000 "">>
<SETG TBLS <IVECTOR 400 ()>>
 ;<GC-MON T>
<COND (<GASSIGNED? ZILCH> <GC 0 T>)
      (T <GC 0 T 5>)>
<BLOAT 90000 0 0 3500 0 0 0 0 0 512>

<SET REDEFINE T>

<GLOBAL BIGFIX 10000>

<OR <GASSIGNED? ZILCH>
    <SETG WBREAKS <STRING !\" !\= !,WBREAKS>>>

<OR <GASSIGNED? INSERT-CRUFTY>
    <DEFINE INSERT-CRUFTY (STR) <IFILE .STR T>>>

<DEFINE IFILE (STR "OPTIONAL" (FLOAD? <>) "AUX" (TIM <TIME>))
	<INSERT-FILE .STR .FLOAD?>>

<PRINC "SUSPENDED: Interlogic Science Fiction
">

<COND (<GASSIGNED? PREDGEN>
       <ID 0>)>

<IFILE "macros" T>
<PROPDEF SIZE 5>
<PROPDEF CAPACITY 0>
<PROPDEF VALUE 0>

<IFILE "syntax" T>
<ENDLOAD>
<IFILE "globals" T>
<IFILE "clock" T>
<IFILE "main" T>
<IFILE "parser" T>
<INSERT-CRUFTY "crufty">
<IFILE "verbs" T>


;"MIKE: Add your files here, as with ROBOTS"


<IFILE "status" T>
<IFILE "robots" T>
<IFILE "rooms" T>
<IFILE "objects" T>
<IFILE "goal" T>
<IFILE "people" T>
<IFILE "setup" T>

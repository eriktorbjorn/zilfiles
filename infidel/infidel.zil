"
			      INFIDEL
	(c) Copyright 1983 Infocom, Inc.  All Rights Reserved.
"

<SNAME "INFIDEL">

<GC-MON <>>
;<COND (<GASSIGNED? ZILCH> <GC 0 T>)
      (T <GC 0 T 5>)>
<GC 0 T 5>

<BLOAT 90000 0 0 3500 0 0 0 0 0 512>

;<SETG SHORT-STRINGS 2>

<SET REDEFINE T>

<GLOBAL BIGFIX 10000>

<OR <GASSIGNED? ZILCH>
    <SETG WBREAKS <STRING !\" !\= !,WBREAKS>>>

<OR <GASSIGNED? INSERT-CRUFTY>
    <DEFINE INSERT-CRUFTY (STR) <IFILE .STR T>>>

<DEFINE IFILE (STR "OPTIONAL" (FLOAD? <>) "AUX" (TIM <TIME>))
	<INSERT-FILE .STR .FLOAD?>>

<PRINC "INFIDEL: Interlogic Adventure Fiction
">

<COND (<GASSIGNED? PREDGEN>
       <ID 0>)>

<IFILE "macros" T>

<IFILE "globals" T>
<PROPDEF SIZE 5>
<PROPDEF CAPACITY 0>
<PROPDEF VALUE 0>

<IFILE "syntax" T>
<ENDLOAD>

<IFILE "clock" T>
<IFILE "main" T>
<IFILE "parser" T>
<INSERT-CRUFTY "crufty">
<IFILE "verbs" T>



;"MIKE: Add your files here, as with ROBOTS"

<IFILE "interrupts" T>
<IFILE "ra" T>
<IFILE "ante" T>
<IFILE "diamond" T>
<IFILE "barge" T>
<IFILE "cube" T>
<IFILE "camp" T>
<IFILE "temple" T>

<PRINC "INFIDEL: Interlogic Adventure Fiction







Get ready!">
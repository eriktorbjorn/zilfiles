"COMPILE FILE for
			    DEADLINE
	Copyright 1982 Infocom, Inc.  All rights reserved.
"
<VERSION ZIP TIME>

;<SNAME "INFOCOM.DEADLINE">

<COND (<GASSIGNED? PREDGEN>
       <PRINC "Compiling">
       <ID 0>)
      (T <PRINC "Loading">)>

<PRINC " DEADLINE: An INTERLOGIC Mystery
">

<BLOAT 90000 0 0 3500 0 0 0 0 0 512>

<SET REDEFINE T>

<GLOBAL BIGFIX 10000>

<OR <GASSIGNED? ZILCH>
    <SETG WBREAKS <STRING !\" !,WBREAKS>>>

<OR <GASSIGNED? INSERT-CRUFTY>
    <DEFINE INSERT-CRUFTY (STR) <IFILE .STR T>>>

<DEFINE IFILE (STR "OPTIONAL" (FLOAD? <>) "AUX" (TIM <TIME>))
	<INSERT-FILE .STR .FLOAD?>>

<IFILE "dungeon" T>

<PROPDEF SIZE 5>
<PROPDEF CAPACITY 0>

<IFILE "syntax" T>
<ENDLOAD>
<IFILE "macros" T>
<IFILE "clock" T>
<IFILE "main" T>
<IFILE "parser" T>
<INSERT-CRUFTY "crufty">
<IFILE "verbs" T>
<IFILE "actions" T>
<IFILE "goal" T>

<GC-MON T>
<GC 0 T 5>

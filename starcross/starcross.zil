"SF for
			      Zork SF Game
	(c) Copyright 1981 Infocom, Inc.  All Rights Reserved.
"

<SNAME "STARCROSS">

<BLOAT 70000 0 0 2700 0 0 0 0 0 256>

<SET REDEFINE T>

<GLOBAL BIGFIX 10000>

<OR <GASSIGNED? ZILCH>
    <SETG WBREAKS <STRING !\" !\= !,WBREAKS>>>

<OR <GASSIGNED? INSERT-CRUFTY>
    <DEFINE INSERT-CRUFTY (STR) <IFILE .STR T>>>

<DEFINE IFILE (STR "OPTIONAL" (FLOAD? <>) "AUX" (TIM <TIME>))
	<INSERT-FILE .STR .FLOAD?>>

<PRINC "Starcross: Interlogic Science Fiction
">

<COND (<GASSIGNED? PREDGEN>
       <ID 0>)>

<IFILE "dungeon" T>

<PROPDEF SIZE 5>
<PROPDEF CAPACITY 0>
<PROPDEF VALUE 0>

<IFILE "syntax" T>
<ENDLOAD>
<IFILE "macros" T>
<IFILE "clock" T>
<IFILE "parser" T>
<IFILE "main" T>
;<INSERT-CRUFTY "CRUFTY">
<IFILE "verbs" T>
<IFILE "actions" T>
<IFILE "emerg" T>

<GC 0 T>

<DEFINE CNT (STR OBL)
	<PRINC .STR>
	<PRIN1 <MAPF ,+ ,LENGTH .OBL>>
	<CRLF>>

<IMAGE 7><IMAGE 7><IMAGE 7>
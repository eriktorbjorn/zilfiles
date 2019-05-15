"DEMO for
				SAMPLER
	(c) Copyright 1984 Infocom, Inc.  All Rights Reserved."

<GC 0 T 5>

<BLOAT 70000 0 0 2700 0 0 0 0 0 256>

<SET REDEFINE T>

;<GLOBAL BIGFIX 10000>

<OR <GASSIGNED? ZILCH>
    <SETG WBREAKS <STRING !\" !,WBREAKS>>>

<DEFINE IFILE (STR "OPTIONAL" (FLOAD? <>) "AUX" (TIM <TIME>))
	<INSERT-FILE .STR .FLOAD?>>

<PRINC "Sampler ZORK I: The Great Underground Empire
">

<OR <GASSIGNED? INSERT-CRUFTY>
    <DEFINE INSERT-CRUFTY (STR) <INSERT-FILE .STR T>>>

<COND (<GASSIGNED? PREDGEN>
       <ID 0>)>

<IFILE "misc" T>
<IFILE "syntax" T>
<IFILE "dungeon" T>
<IFILE "globals" T>
<IFILE "parser" T>
<IFILE "verbs" T>
<IFILE "actions" T>
<IFILE "tutorial" T>
<IFILE "planetfall" T>
<IFILE "infidel" T>

<PROPDEF SIZE 5>
<PROPDEF CAPACITY 0>
<PROPDEF VALUE 0>
<PROPDEF TVALUE 0>

<GC 0 T>

<DEFINE CNT (STR OBL)
	<PRINC .STR>
	<PRIN1 <MAPF ,+ ,LENGTH .OBL>>
	<CRLF>>

<COND (<NOT <GASSIGNED? PREDGEN>>
       <GC-MON T>)>
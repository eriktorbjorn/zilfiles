"MINI2 for
	        Mini-Zork II: The Wizard of Frobozz
	(c) Copyright 1988 Infocom, Inc.  All Rights Reserved."

ON!-INITIAL
OFF!-INITIAL

<SET REDEFINE T>

<OR <GASSIGNED? ZILCH>
    <SETG WBREAKS <STRING !\" !,WBREAKS>>>

<PRINC "Mini-Zork II
">

<COND (<GASSIGNED? PREDGEN>
       <ID 0>)>

<SETG COMPACT-SYNTAXES? T>

<FREQUENT-WORDS?>

<INSERT-FILE "misc" T>
<INSERT-FILE "parser" T>
<INSERT-FILE "syntax" T>
<INSERT-FILE "verbs" T>
<INSERT-FILE "globals" T>
<INSERT-FILE "wizard" T>
<INSERT-FILE "dungeon" T>
<INSERT-FILE "princess" T>
<INSERT-FILE "alice" T>
<INSERT-FILE "volcano" T>

<PROPDEF SIZE 5>
<PROPDEF CAPACITY 0>
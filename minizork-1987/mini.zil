"ZORK1 for
			     Mini-Zork '87
	  (c) Copyright 1987 Infocom, Inc. All Rights Reserved"

<VERSION ZIP>

<SET REDEFINE T>

<OR <GASSIGNED? ZILCH>
    <SETG WBREAKS <STRING !\" !,WBREAKS>>>

<PRINC "Mini-Zork '87
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
<INSERT-FILE "thief" T>
<INSERT-FILE "above-ground" T>
<INSERT-FILE "south-of-res" T>
<INSERT-FILE "north-of-res" T>
<INSERT-FILE "maze" T>

<PROPDEF SIZE 5>
<PROPDEF CAPACITY 0>
<PROPDEF VALUE 0>
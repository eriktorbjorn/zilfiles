
"EXTENDED for
			       BORDER ZONE
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

<VERSION XZIP>

<SET ZREDEFINE T>
<SET REDEFINE T>
<FREQUENT-WORDS?>
;<FUNNY-GLOBALS?>

<PRINC "
 *** Border Zone: A Game of Intrigue ***

">

<SNAME "MARC.SPY">

<INSERT-FILE "misc" T>

<INSERT-FILE "realtime" T>
<INSERT-FILE "parser" T>
<INSERT-FILE "syntax" T>
<INSERT-FILE "scenario" T>
<INSERT-FILE "desc" T>
<PUT-PURE-HERE>
<INSERT-FILE "verbs" T>
<INSERT-FILE "globals" T>
<INSERT-FILE "hints" T>

;"Chapter 2 - GOOD"

<INSERT-FILE "good" T>
<INSERT-FILE "border" T>

;"Chapter 1 - BYSTANDER"

<INSERT-FILE "bystander" T>

;"Chapter 3 - BAD"

<INSERT-FILE "bad" T>

<INSERT-FILE "once" T>

<PROPDEF SIZE 5>
<PROPDEF CAPACITY 0>

<COND (<NOT <GASSIGNED? VALUE>> <SETG VALUE ,GVAL>)>
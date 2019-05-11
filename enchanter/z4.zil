"ENCHANTER for
				ENCHANTER
	(c) Copyright 1983 Infocom, Inc.  All Rights Reserved.
"

<PRINC "
 *** ENCHANTER: Interlogic Fantasy ***

">

<SETG ZORK-NUMBER 4>

<SNAME "ENCHANTER">

<SET REDEFINE T>

<CONSTANT SERIAL 0>

<OR <GASSIGNED? ZILCH>
    <SETG WBREAKS <STRING !\" !,WBREAKS>>>

<COND (<GASSIGNED? ORDER-TREE?>
       <ORDER-TREE? REVERSE-DEFINED>)>

<COND (<GASSIGNED? PREDGEN>
       <ID 0>)>

<INSERT-FILE "syntax" T>

<INSERT-FILE "macros" T>
<INSERT-FILE "clock" T>
<INSERT-FILE "main" T>
<INSERT-FILE "gparser" T>
<INSERT-FILE "verbs" T>
<INSERT-FILE "record" T>
<INSERT-FILE "globals" T>
<INSERT-FILE "terror" T>
<INSERT-FILE "stair" T>
<INSERT-FILE "magic" T>
<INSERT-FILE "knot" T>
<INSERT-FILE "purloined" T>
<INSERT-FILE "castle" T>
<INSERT-FILE "temple" T>
<INSERT-FILE "gallery" T>
<INSERT-FILE "egg" T>
<INSERT-FILE "sleep" T>
<INSERT-FILE "gears" T>
<INSERT-FILE "outside" T>

<PROPDEF SIZE 5>
<PROPDEF CAPACITY 0>



"X1 for
		      LEATHER GODDESSES OF PHOBOS
	(c) Copyright 1986 Infocom, Inc.  All Rights Reserved."

<PRINC "
 *** X1: Leather Goddesses of Phobos ***
">

ON!-INITIAL
OFF!-INITIAL	;"makes debugging possible -- pdl"

;<COND (<GASSIGNED? MUDDLE>
       <GC 0 T 5>
       <BLOAT 90000 0 0 3300 0 0 0 0 0 256>)>

<SET REDEFINE T>

<OR <GASSIGNED? ZILCH>
    <SETG WBREAKS <STRING !\" !,WBREAKS>>>

<COND (<GASSIGNED? ZILCH>
       <ID 0>)>

<SETG NEW-VOC? T>

<INSERT-FILE "misc" T>
<INSERT-FILE "parser" T>
<INSERT-FILE "syntax" T>
<INSERT-FILE "verbs" T>
<INSERT-FILE "globals" T>
<INSERT-FILE "earth" T>
<INSERT-FILE "mars" T>
<INSERT-FILE "venus" T>
<INSERT-FILE "cleveland" T>
<INSERT-FILE "spaceship" T>
<INSERT-FILE "phobos" T>

<PROPDEF SIZE 5>
<PROPDEF CAPACITY 5>
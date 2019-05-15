"R1
 for
		      PLUNDERED HEARTS
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

<PRINC "
 *** R1: PLUNDERED HEARTS ***
">

ON!-INITIAL
OFF!-INITIAL	;"makes debugging possible -- pdl"

<FREQUENT-WORDS?>

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
<INSERT-FILE "ship" T>
<INSERT-FILE "hero" T>
<INSERT-FILE "island" T>
<INSERT-FILE "clothes" T>
<INSERT-FILE "extras" T>

<PROPDEF SIZE 5>
<PROPDEF CAPACITY 5>
<PROPDEF CONTENTS 0>
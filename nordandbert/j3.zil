"J3 for
		             NORD AND BERT
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."
 
;<SETG PLUS-MODE T>

<PRINC "
 *** F1: Nord and Bert ***
">

ON!-INITIIAL
OFF!-INITIAL	;"makes debugging possible -- pdl"

<VERSION EZIP>
<FREQUENT-WORDS?>

<COND (<GASSIGNED? MUDDLE>
       <BLOAT 90000 0 0 3300 0 0 0 0 0 256>)>

<SET REDEFINE T>

<OR <GASSIGNED? ZILCH>
    <SETG WBREAKS <STRING !\" !,WBREAKS>>>

<COND (<GASSIGNED? PREDGEN>
       <SETG ZSTR-ON <SETG ZSTR-OFF ,TIME>>
       <ID 0>)>

<SETG NEW-VOC? T>

<INSERT-FILE "tells" T>
<INSERT-FILE "parser" T>
<INSERT-FILE "syntax" T>
<INSERT-FILE "verbs" T>
<PUT-PURE-HERE>
<INSERT-FILE "globals" T>
<INSERT-FILE "invis" T>
<INSERT-FILE "hazing" T>
<INSERT-FILE "dueling" T>
<INSERT-FILE "aisle" T>
<INSERT-FILE "north" T>
<INSERT-FILE "farm" T>
<INSERT-FILE "restaurant" T>
<INSERT-FILE "comedy" T>
<INSERT-FILE "eight" T>

<PROPDEF SIZE 5>
<PROPDEF CAPACITY 5>
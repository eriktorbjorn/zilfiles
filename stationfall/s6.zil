"S6 for
			      STATIONFALL
	(c) Copyright 1987 Infocom, Inc.  All Rights Reserved."

<PRINC "
 *** S6: Stationfall ***
">

ON!-INITIAL
OFF!-INITIAL	;"makes debugging possible -- pdl"

<SET REDEFINE T>

<SETG NEW-VOC? T>

<FREQUENT-WORDS?>

<INSERT-FILE "misc" T>
<INSERT-FILE "parser" T>
<INSERT-FILE "interrupts" T>
<INSERT-FILE "syntax" T>
<INSERT-FILE "verbs" T>
<INSERT-FILE "globals" T>
<INSERT-FILE "ship" T>
<INSERT-FILE "station" T>
<INSERT-FILE "village" T>

<PROPDEF SIZE 5>
<PROPDEF CAPACITY 5>
"S4 for
		  THE HITCHHIKER'S GUIDE TO THE GALAXY
	(c) Copyright 1984 Infocom, Inc.  All Rights Reserved."

<PRINC "
 *** THE HITCHHIKER'S GUIDE TO THE GALAXY: Interactive Science Fiction ***

">

<SNAME "S4">

<SET REDEFINE T>

;<OR <GASSIGNED? INSERT-CRUFTY>
    <DEFINE INSERT-CRUFTY (STR) <INSERT-FILE .STR T>>>

<INSERT-FILE "misc" T>
<INSERT-FILE "heart" T>
<INSERT-FILE "parser" T>
<INSERT-FILE "syntax" T>
<INSERT-FILE "verbs" T>
<INSERT-FILE "earth" T>
<INSERT-FILE "vogon" T>
<INSERT-FILE "unearth" T>
<INSERT-FILE "globals" T>

<PROPDEF SIZE 5>
<PROPDEF CAPACITY 0>
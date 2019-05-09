"ZORK1 for
	        Zork I: The Great Underground Empire
	(c) Copyright 1983 Infocom, Inc.  All Rights Reserved."

<VERSION ZIP>

<SETG ZORK-NUMBER 1>

<SET REDEFINE T>

<OR <GASSIGNED? ZILCH>
    <SETG WBREAKS <STRING !\" !,WBREAKS>>>

<PRINC "Renovated ZORK I: The Great Underground Empire
">

<FREQUENT-WORDS?>

<INSERT-FILE "../zorklib/gmacros" T>
<INSERT-FILE "../zorklib/gsyntax" T>
<INSERT-FILE "1dungeon" T>
<INSERT-FILE "../zorklib/gglobals" T>

<PROPDEF SIZE 5>
<PROPDEF CAPACITY 0>
<PROPDEF VALUE 0>
<PROPDEF TVALUE 0>

<INSERT-FILE "../zorklib/gclock" T>
<INSERT-FILE "../zorklib/gmain" T>
<INSERT-FILE "../zorklib/gparser" T>
<INSERT-FILE "../zorklib/gverbs" T>
<INSERT-FILE "1actions" T>

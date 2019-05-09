"ZORK2 for
	        Zork II: The Wizard of Frobozz
	(c) Copyright 1983 Infocom, Inc.  All Rights Reserved."

ON!-INITIAL
OFF!-INITIAL

<SETG ZORK-NUMBER 2>

<SET REDEFINE T>

<OR <GASSIGNED? ZILCH>
    <SETG WBREAKS <STRING !\" !,WBREAKS>>>

<PRINC "Renovated ZORK II: The Wizard of Frobozz
">

<COND (<GASSIGNED? PREDGEN>
       <ID 0>)>

<FREQUENT-WORDS?>

<INSERT-FILE "../zorklib/gmacros" T>
<INSERT-FILE "../zorklib/gsyntax" T>
<INSERT-FILE "2dungeon" T>
<INSERT-FILE "../zorklib/gglobals" T>

<PROPDEF SIZE 5>
<PROPDEF CAPACITY 0>
<PROPDEF VALUE 0>

<INSERT-FILE "../zorklib/gclock" T>
<INSERT-FILE "../zorklib/gmain" T>
<INSERT-FILE "../zorklib/gparser" T>
<INSERT-FILE "../zorklib/gverbs" T>
<INSERT-FILE "2actions" T>

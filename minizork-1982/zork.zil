"ZORK1 for
			     Mini-Zork '82
	  (c) Copyright 1982 Infocom, Inc. All Rights Reserved"

<VERSION ZIP>

<SET REDEFINE T>

<OR <GASSIGNED? ZILCH>
    <SETG WBREAKS <STRING !\" !,WBREAKS>>>

<PRINC "Mini-Zork '82
">

<COND (<GASSIGNED? PREDGEN>
       <ID 0>)>

"Define these temporarily to allow the game to compile."
<CONSTANT F-BUSY? <>>
<CONSTANT F-CONSCIOUS <>>
<CONSTANT UNCONSCIOUS <>>

<FREQUENT-WORDS?>

<INSERT-FILE "actions" T>
<INSERT-FILE "clock" T>
<INSERT-FILE "crufty" T>
<INSERT-FILE "demons" T>
<INSERT-FILE "dungeon" T>
<INSERT-FILE "fights" T>
<INSERT-FILE "macros" T>
<INSERT-FILE "main" T>
<INSERT-FILE "melee" T>
<INSERT-FILE "parser" T>
<INSERT-FILE "syntax" T>
<INSERT-FILE "verbs" T>

<GLOBAL LIT T>
<GLOBAL P-WON <>>

<PROPDEF SIZE 5>
<PROPDEF CAPACITY 0>
<PROPDEF VALUE 0>

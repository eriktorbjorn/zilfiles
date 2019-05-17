"COMPILE/LOAD FILE for MOONMIST
Copyright (C) 1986 Infocom, Inc.  All rights reserved."

<SETG ZDEBUGGING? <>>
<DEFINE DEBUG-CODE ('X "OPTIONAL" ('Y T))
	<COND (,ZDEBUGGING? .X) (ELSE .Y)>>

<SETG NEW-VOC? T>
<FREQUENT-WORDS?>
<VERSION ZIP TIME>

<COND (<GASSIGNED? ORDER-TREE?>
       <ORDER-TREE? REVERSE-DEFINED>)>

<COND (<GASSIGNED? PREDGEN>
       <PRINC "Compiling">
       <ID 0>)
      (T <PRINC "Loading">)>

<PRINC " MOONMIST: interactive fiction from Infocom!
">

ON!-INITIAL	"for DEBUGR"
OFF!-INITIAL
ENABLE!-INITIAL
DISABLE!-INITIAL

<SET REDEFINE T>

<OR <GASSIGNED? ZILCH>
    <SETG WBREAKS <STRING !\" !,WBREAKS>>>

<DIRECTIONS ;"Do not change the order of the first eight
	      without consulting Marc! -- per ENCHANTER"
 	    NORTH NE EAST SE SOUTH SW WEST NW UP DOWN IN OUT>

<INSERT-FILE "macros">
<INSERT-FILE "misc">
<INSERT-FILE "syntax">
<INSERT-FILE "parser">
<INSERT-FILE "verbs">
<INSERT-FILE "goal">
<INSERT-FILE "people">
<INSERT-FILE "castle">
<INSERT-FILE "tower">
<INSERT-FILE "things">
<INSERT-FILE "places">
<INSERT-FILE "global">
<INSERT-FILE "colors">

<PROPDEF SIZE 5>

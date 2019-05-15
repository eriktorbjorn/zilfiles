"COMPILE/LOAD FILE for MILLIWAYS
Copyright (C) 1988 Infocom, Inc.  All rights reserved."

<SETG ZDEBUGGING? T>
<DEFINE DEBUG-CODE ('X "OPTIONAL" ('Y T))
	<COND (,ZDEBUGGING? .X) (ELSE .Y)>>

<SETG NEW-PARSER? T>
;<FREQUENT-WORDS?>
;<LONG-WORDS?>
<NEVER-ZAP-TO-SOURCE-DIRECTORY?>
<ZIP-OPTIONS UNDO>
<VERSION YZIP>

<IFFLAG (IN-ZILCH
	 <PRINC "Compiling">)
	(T <PRINC "Loading">)>

<PRINC " MILLIWAYS: interactive fiction from Infocom!
">

ON!-INITIAL	"for ZIL debugging"
OFF!-INITIAL
ENABLE!-INITIAL
DISABLE!-INITIAL

<SET REDEFINE T>

<INSERT-FILE "defs">

<XFLOAD "parser.h2">

<INSERT-FILE "macros">
<INSERT-FILE "misc">
<INSERT-FILE "syntax">
<INSERT-FILE "verbs">
<INSERT-FILE "things">
<INSERT-FILE "places">
<INSERT-FILE "magrathea">
<INSERT-FILE "people">
<INSERT-FILE "global">

<PROPDEF SIZE 5>

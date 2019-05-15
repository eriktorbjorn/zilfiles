;"***************************************************************************"
; "game : Abyss"
; "file : ABYSS.ZIL"
; "auth :   $Author:   RAB  $"
; "date :     $Date:   16 Mar 1989 17:36:40  $"
; "rev  : $Revision:   1.9  $"
; "vers : 1.0"
;"---------------------------------------------------------------------------"
; "Compile/Load file"
; "Copyright (C) 1988 Infocom, Inc.  All rights reserved."
;"***************************************************************************"
 
<SETG ZDEBUGGING? T>
<DEFINE DEBUG-CODE ('X "OPTIONAL" ('Y T))
	<COND
		(,ZDEBUGGING?
			.X
		)
		(ELSE
			.Y
		)
	>
>
 
<SETG NEW-PARSER? T>
<FREQUENT-WORDS?>
<LONG-WORDS?>
<ZIP-OPTIONS UNDO COLOR MOUSE>
<ORDER-OBJECTS? ROOMS-FIRST>
<NEVER-ZAP-TO-SOURCE-DIRECTORY?>
 
<VERSION YZIP>
 
<IFFLAG
	(IN-ZILCH
		<PRINC "Compiling">
	)
	(T
		<PRINC "Loading">
	)
>
 
<PRINC ": Abyss by Challenge, Inc.
">
 
ON!-INITIAL	"for DEBUGR"
OFF!-INITIAL
ENABLE!-INITIAL
DISABLE!-INITIAL
 
<SET REDEFINE T>
 
<COMPILATION-FLAG P-BE-VERB T>
 
;<SETG L-SEARCH-PATH (["~PARSER" ""] !,L-SEARCH-PATH)>
 
<INSERT-FILE "defs">
 
<XFLOAD ;"~parser/" "parser.rest">
 
<INSERT-FILE "macros">
<INSERT-FILE "misc">
<INSERT-FILE "gas-mix">
<INSERT-FILE "syntax">
<INSERT-FILE "verbs">
<IF-P-BE-VERB!- <INSERT-FILE "be">>
<INSERT-FILE "sub-bay">
<INSERT-FILE "command">
<INSERT-FILE "montana">
<INSERT-FILE "return1">
<INSERT-FILE "return2">
<INSERT-FILE "ocean">
<INSERT-FILE "crane">
<INSERT-FILE "global">
<INSERT-FILE "util">
<INSERT-FILE "stopper">
<INSERT-FILE "alien">
<INSERT-FILE "endgame">
 
;"***************************************************************************"
; "end of file"
;"***************************************************************************"
 

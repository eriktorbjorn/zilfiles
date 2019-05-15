;"***************************************************************************"
; "game : Arthur"
; "file : ARTHUR.ZIL"
; "auth :   $Author:   DEB  $"
; "date :     $Date:   11 May 1989  3:46:30  $"
; "rev  : $Revision:   1.9  $"
; "vers : 1.0"
;"---------------------------------------------------------------------------"
; "Compile/Load file"
; "Copyright (C) 1989 Infocom, Inc.  All rights reserved."
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

<PICFILE "ARTHUR.MAC.1">

<SETG NEW-PARSER? T>
<FREQUENT-WORDS?>
<LONG-WORDS?>
<ZIP-OPTIONS UNDO COLOR MOUSE DISPLAY>
<ORDER-OBJECTS? ROOMS-FIRST>

<VERSION YZIP>

<IFFLAG
	(IN-ZILCH
		<PRINC "Compiling">
	)
	(T
		<PRINC "Loading">
	)
>

<PRINC ": King Arthur, by Challenge, Inc.
">

ON!-INITIAL	"for DEBUGR"
OFF!-INITIAL
ENABLE!-INITIAL
DISABLE!-INITIAL

<SET REDEFINE T>

<COMPILATION-FLAG P-BE-VERB T>

;<SETG L-SEARCH-PATH (["~PARSER" ""] !,L-SEARCH-PATH)>

<INSERT-FILE "defs">

<XFLOAD "parser.rest">

<INSERT-FILE "picdef">
<INSERT-FILE "macros">
<INSERT-FILE "misc">
<INSERT-FILE "syntax">
<INSERT-FILE "utils">
<INSERT-FILE "verbs">
<INSERT-FILE "transfrm">
<IF-P-BE-VERB <INSERT-FILE "be">>
<INSERT-FILE "food">
<INSERT-FILE "cell">
<INSERT-FILE "boar">
<INSERT-FILE "window">
<INSERT-FILE "sword">
<INSERT-FILE "password">
<INSERT-FILE "endgame">
<INSERT-FILE "eel">
<INSERT-FILE "badger">
<INSERT-FILE "basil">
<INSERT-FILE "dragon">
<INSERT-FILE "raven">
<INSERT-FILE "castle">
<INSERT-FILE "rednite">
<INSERT-FILE "lady">
<INSERT-FILE "forest">
<INSERT-FILE "joust">
<INSERT-FILE "demon">
<INSERT-FILE "ice-hot">
<INSERT-FILE "chestnut">
<INSERT-FILE "tower">
<INSERT-FILE "bog">
<INSERT-FILE "leprchan">
<INSERT-FILE "merlin">
<INSERT-FILE "tavern">
<INSERT-FILE "kitchen">
<INSERT-FILE "iknight">
<INSERT-FILE "town">
<INSERT-FILE "idiot">
<INSERT-FILE "church">
<INSERT-FILE "places">
<INSERT-FILE "global">
<INSERT-FILE "clues">
<INSERT-FILE "hints">

;"***************************************************************************"
; "end of file"
;"***************************************************************************"


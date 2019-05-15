"GLOBALS for GENERIC: (C)1985 Infocom, Inc. All Rights Reserved."

<DIRECTIONS NORTH NE EAST SE SOUTH SW WEST NW UP DOWN IN OUT>

<GLOBAL HERE <>>

<GLOBAL LIT T>

<GLOBAL MOVES 0>
<GLOBAL SCORE 0>

; <GLOBAL INDENTS
	  <PTABLE ""
	          "  "
	          "    "
	          "      "
	          "        "
	          "          ">>

<OBJECT GLOBAL-OBJECTS
	(FLAGS RMUNGBIT INVISIBLE TOUCHBIT SURFACEBIT
	       TRYTAKEBIT OPENBIT SEARCHBIT TRANSBIT
	       WEARBIT VOWELBIT ONBIT RLANDBIT
	       ACTORBIT TAKEBIT NDESCBIT NARTICLEBIT
	       TOOLBIT LOCKEDBIT WORNBIT VEHBIT
	       INDOORSBIT)>

<OBJECT LOCAL-GLOBALS
	%<IN/LOC GLOBAL-OBJECTS>
	(SYNONYM ZZZP)
	(DESCFCN 0)
        (GLOBAL GLOBAL-OBJECTS)
	(ADVFCN 0)
	(FDESC "F")
	(LDESC "L")
	(PSEUDO "FOOBAR" V-WALK)
	(CONTFCN 0)
	(SIZE 0)
	;(TEXT "")
	(CAPACITY 0)>

<OBJECT ROOMS
	(IN TO ROOMS)>

<OBJECT INTNUM
	%<IN/LOC GLOBAL-OBJECTS>
	(SYNONYM INTNUM)
	(DESC "number")>

<OBJECT PSEUDO-OBJECT
	(DESC "pseudo")
	(ACTION ME-F)>

<OBJECT IT
	%<IN/LOC GLOBAL-OBJECTS>
	(SYNONYM IT THAT)
	(DESC "it")
	(FLAGS VOWELBIT NARTICLEBIT NDESCBIT TOUCHBIT)>

<ROUTINE BE-SPECIFIC ()
	 <TELL "(Be specific: what do you want to ">>

<ROUTINE TO-DO-THING-USE (STR1 STR2)
	 <TELL "(To " .STR1 " something, use the command: " 
	       .STR2 " THING.)" CR>>

<ROUTINE CANT-USE (PTR "AUX" BUF) 
	;#DECL ((PTR BUF) FIX)
	<SETG QUOTE-FLAG <>>
	<SETG P-OFLAG <>>
	<TELL "(This story can't understand the word \"">
	<WORD-PRINT <GETB <REST ,P-LEXV <SET BUF <* .PTR 2>>> 2>
	<GETB <REST ,P-LEXV .BUF> 3>>
	<TELL "\" when you use it that way.)" CR>>

<ROUTINE DONT-UNDERSTAND ()
	<TELL "(That sentence didn't make sense. Please reword it or try something else.)" CR>>

<ROUTINE NOT-IN-SENTENCE (STR)
	 <TELL "(There aren't " .STR " in that sentence!)" CR>>

<OBJECT WALLS
	%<IN/LOC GLOBAL-OBJECTS>
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "wall")
	(SYNONYM WALL WALLS)
	(ACTION WALLS-F)>
	 
<ROUTINE WALLS-F ()
	 <COND (<NOT <FSET? ,HERE ,INDOORSBIT>>
		<CANT-SEE-ANY ,WALLS>
		<RFATAL>)
	       (<OR <GETTING-INTO?>
		    <VERB? LOOK-BEHIND>>
		<TELL <PICK-ONE ,YUKS> CR>)
	       (<VERB? LOOK-UNDER>
		<TELL "There's a floor there." CR>)
	       (<OR <HURT? ,WALLS>
		    <MOVING? ,WALLS>>
		<SAY-THE ,WALLS>
		<TELL " is not affected." CR>)
	       (<OR <TALKING-TO? ,WALLS>
		    <VERB? YELL>>
		<TELL "Talking to walls">
		<SIGN-OF-COLLAPSE>
		<RFATAL>)
	       (T
		<YOU-DONT-NEED ,WALLS>
		<RFATAL>)>
	 <RTRUE>>
		
<OBJECT CEILING
	%<IN/LOC GLOBAL-OBJECTS>
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "ceiling")
	(SYNONYM CEILING)
	(ACTION CEILING-F)>

<ROUTINE CEILING-F ()
	 <COND (<NOT <FSET? ,HERE ,INDOORSBIT>>
		<CANT-SEE-ANY ,CEILING>
		<RFATAL>)
	       (<VERB? LOOK-UNDER>
		<V-LOOK>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT HANDS
	%<IN/LOC GLOBAL-OBJECTS>
	(DESC "your hand")
	(SYNONYM HAND HANDS)
	(ADJECTIVE MY BARE)
	(FLAGS NDESCBIT TOOLBIT TOUCHBIT NARTICLEBIT)>

<OBJECT PROTAGONIST
	%<IN/LOC THE-ROOM>
	(SYNONYM PROTAG)
	(DESC "yourself")
	(FLAGS NDESCBIT NARTICLEBIT INVISIBLE)
	(ACTION 0)
	(SIZE 0)>

<OBJECT ME
	%<IN/LOC GLOBAL-OBJECTS>
	(SYNONYM I ME MYSELF)
	(DESC "yourself")
	(FLAGS ACTORBIT TOUCHBIT NARTICLEBIT)
	(ACTION ME-F)>

<ROUTINE ME-F ("OPTIONAL" (CONTEXT <>) "AUX" OLIT) 
	 <COND (<VERB? ALARM>
		<TELL "You're already wide awake." CR>
		<RTRUE>)
	       (<OR <TALKING-TO? ,ME>
		    <VERB? YELL>>
		<TALK-TO-SELF>
		<RFATAL>)
	       (<VERB? LISTEN>
		<TELL ,CANT " help doing that." CR>
		<RTRUE>)
	       (<AND <VERB? GIVE>
		     <EQUAL? ,PRSI ,ME>>
		<COND (<HELD? ,PRSO>
		       <TELL "You already have it." CR>)
		      (T
		       <PERFORM ,V?TAKE ,PRSO>)>
		<RTRUE>)
	       (<VERB? KILL>
		<TELL "Desperate? Call the Samaritans." CR>
		<RTRUE>)
	       (<VERB? FIND>
		<TELL "You're right here!" CR>
		<RTRUE>)
	       (<HURT? ,ME>
		<TELL "Punishing yourself that way won't help matters." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE TALK-TO-SELF ()
	 <TELL "Talking to yourself">
	 <SIGN-OF-COLLAPSE>
	 <PCLEAR>>

<ROUTINE SIGN-OF-COLLAPSE ()
	 <TELL " is said to be a sign of impending mental collapse." CR>>

<OBJECT GLOBAL-ROOM
	%<IN/LOC GLOBAL-OBJECTS>
	(DESC "room")
	(SYNONYM ROOM AREA PLACE)
	(ACTION GLOBAL-ROOM-F)>

<ROUTINE GLOBAL-ROOM-F ()
	 <COND (<VERB? LOOK EXAMINE LOOK-INSIDE>
		<V-LOOK>
		<RTRUE>)
	       (<VERB? ENTER THROUGH DROP EXIT>
		<V-WALK-AROUND>
		<RFATAL>)
	       (<VERB? WALK-AROUND>
		<TELL
"Walking around the area reveals nothing new.|
|
(If you want to go somewhere, just type a direction.)" CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>
	       
; <ROUTINE ALREADY-IN (PLACE "OPTIONAL" (NOT? <>))
	 <TELL "But you're ">
	 <COND (.NOT?
		<TELL "not">)
	       (T
		<TELL "already">)>
	 <TELL " in ">
	 <ARTICLE .PLACE T>
	 <TELL D .PLACE "!" CR>>
	      
; <ROUTINE CANT-MAKE-OUT-ANYTHING ()
	 <TELL ,CANT " make out anything inside." CR>>

<ROUTINE OBJECT-IS-LOCKED ()
	 <TELL ,CANT " do that. It's locked." CR>>

<ROUTINE CANT-SEE-ANY ("OPTIONAL" (THING <>) (STRING? <>))
	 <YOU-CANT-SEE>
	 <COND (.STRING?
		<TELL .THING>)
	       (.THING
		<COND (<NOT <FSET? .THING ,NARTICLEBIT>>
		       <TELL "any ">)>
		<TELL D .THING>)
	       (T
		<TELL "that">)>
	 <TELL " here!" CR>>

<ROUTINE YOU-CANT-SEE ()
	 <SETG CLOCK-WAIT T>
	 <PCLEAR>
	 <TELL ,CANT " see ">>

; <ROUTINE NOTHING-EXCITING ()
	 <TELL "Nothing exciting happens." CR>>

<ROUTINE HOW? ()
	 <TELL "How do you intend to do that?" CR>>

<ROUTINE PRESUMABLY-YOU-WANT-TO (STR "OPTIONAL" (THING <>))
	 <TELL ,I-ASSUME " " .STR " ">
	 <COND (.THING
		<ARTICLE .THING T>
	        <TELL D .THING>)
	       (T
		<TELL "it">)>
	 <TELL ".)" CR>>
	 
; <ROUTINE TOO-LARGE (THING "OPTIONAL" (SMALL? <>))
	 <BUT-THE .THING>
	 <TELL "is much too ">
	 <COND (.SMALL?
		<TELL "small">)
	       (T
		<TELL "large">)>
	 <TELL "!" CR>>
			      
<ROUTINE NOT-LIKELY (THING STR)
	 <TELL "It" <PICK-ONE ,LIKELIES> " that ">
	 <ARTICLE .THING T>
	 <TELL D .THING " " .STR "." CR>>

<GLOBAL LIKELIES 
	<LTABLE 0
	 " isn't likely"
	 " seems doubtful"
	 " seems unlikely"
	 "'s unlikely"
	 "'s not likely"
	 "'s doubtful">>

<ROUTINE YOUD-HAVE-TO (STR THING)
	 <TELL "You'd have to " .STR " ">
	 <ARTICLE .THING T>
	 <TELL D .THING " to do that." CR>>

; <ROUTINE CLOSED-AND-LOCKED ()
	 <TELL " closed and locked." CR>>

<ROUTINE DO-TO ()
	 <TELL " do that to ">>

; <ROUTINE VPRINT ("AUX" TMP)
	 <SET TMP <GET ,P-OTBL ,P-VERBN>>
	 <COND (<==? .TMP 0> <TELL "tell">)
	       (<ZERO? <GETB ,P-VTBL 2>>
		<PRINTB <GET .TMP 0>>)
	       (T
		<WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>)>>

; <ROUTINE NOT-HERE (OBJ)
	 <SETG CLOCK-WAIT T>
	 <TELL ,CANT " see ">
	 <COND (<NOT <FSET? .OBJ ,NARTICLEBIT>> <TELL "any ">)>
	 <TELL D .OBJ " here." CR>>

<OBJECT HER
	%<IN/LOC GLOBAL-OBJECTS>
	(SYNONYM SHE HER ; WOMAN ; GIRL ; LADY)
	(DESC "her")
	(FLAGS NARTICLEBIT)>

<OBJECT HIM
	%<IN/LOC GLOBAL-OBJECTS>
	(SYNONYM HE HIM ; MAN ;BOY)
	(DESC "him")
	(FLAGS NARTICLEBIT)>

<OBJECT THEM
	%<IN/LOC GLOBAL-OBJECTS>
	(SYNONYM THEY THEM)
	(DESC "them")
	(FLAGS NARTICLEBIT)>

<GLOBAL I-ASSUME "(Presumably, you mean">
<GLOBAL CANT "You can't">

<OBJECT INTDIR
	%<IN/LOC GLOBAL-OBJECTS>
	(DESC "direction")
	(SYNONYM DIRECTION)
	(ADJECTIVE NORTH EAST SOUTH WEST ; "UP DOWN" ; "NE NW SE SW")
    ;  "(NE 0)
	(SE 0)
	(SW 0)
	(NW 0)" >






"GLOBALS for
				   S4
	(c) Copyright 1984 Infocom, Inc.  All Rights Reserved."

<DIRECTIONS ;"Do not change the order of the first eight
	      without consulting MARC!"
 	    NORTH NE EAST SE SOUTH SW WEST NW UP DOWN IN OUT>

<GLOBAL HERE <>>

<GLOBAL LOAD-ALLOWED 100>

<GLOBAL LOAD-MAX 100>

<GLOBAL LIT T>

<GLOBAL MOVES 0>

<GLOBAL SCORE 0>

<GLOBAL INDENTS
	<PTABLE ""
	       "  "
	       "    "
	       "      "
	       "        "
	       "          ">>

;"global objects and associated routines"

<OBJECT GLOBAL-OBJECTS
	(FLAGS RMUNGBIT INVISIBLE TOUCHBIT SURFACEBIT TRYTAKEBIT OPENBIT
	       SEARCHBIT TRANSBIT WEARBIT VOWELBIT ONBIT RLANDBIT)>

<OBJECT LOCAL-GLOBALS
	(IN GLOBAL-OBJECTS)
	(SYNONYM ZZMGCK)
	(DESCFCN 0)
        (GLOBAL GLOBAL-OBJECTS)
	(ADVFCN 0)
	(FDESC "F")
	(LDESC "F")
	(PSEUDO "FOOBAR" V-WALK)
	(CONTFCN 0)
	(SIZE 0)
	(TEXT "")
	(CAPACITY 0)>
;"Yes, this synonym for LOCAL-GLOBALS needs to exist... sigh"

<OBJECT ROOMS
	(IN TO ROOMS)>

<OBJECT INTNUM
	(IN GLOBAL-OBJECTS)
	(SYNONYM INTNUM)
	(DESC "number")>

<OBJECT PSEUDO-OBJECT
	(DESC "pseudo")
	(ACTION ME-F)>

<OBJECT IT
	(IN GLOBAL-OBJECTS)
	(SYNONYM IT THAT HER HIM)
	(DESC "it")
	(FLAGS VOWELBIT NARTICLEBIT NDESCBIT TOUCHBIT)>

<OBJECT NOT-HERE-OBJECT
	(DESC "something")
	(FLAGS NARTICLEBIT)
	(ACTION NOT-HERE-OBJECT-F)>

<ROUTINE NOT-HERE-OBJECT-F ("AUX" TBL (PRSO? T) OBJ (X <>))
	 ;"This COND is game independent (except the TELL)"
	 <COND (<AND <EQUAL? ,PRSO ,NOT-HERE-OBJECT>
		     <EQUAL? ,PRSI ,NOT-HERE-OBJECT>>
		<TELL "Those things aren't here!" CR>
		<RTRUE>)
	       (<EQUAL? ,PRSO ,NOT-HERE-OBJECT>
		<SET TBL ,P-PRSO>)
	       (T
		<SET TBL ,P-PRSI>
		<SET PRSO? <>>)>
	 <COND (.PRSO?
		<COND (<OR <EQUAL? ,PRSA ,V?FIND ,V?FOLLOW ,V?ASK-ABOUT>
			   <EQUAL? ,PRSA ,V?WHAT ,V?WHERE ,V?WHO>
			   <EQUAL? ,PRSA ,V?WAIT-FOR ,V?SEND ,V?WALK-TO>
			   <EQUAL? ,PRSA ,V?WHAT-ABOUT>>
		       <SET X T>
		       <COND (<SET OBJ <FIND-NOT-HERE .TBL .PRSO?>>
			      <COND (<NOT <EQUAL? .OBJ ,NOT-HERE-OBJECT>>
				     <RTRUE>)>)
			     (T
			      <RFALSE>)>)>)>
	 ;"Here is the default 'cant see any' printer"
	 <COND (.X
		<TELL "You'll have to be more specific, I'm afraid." CR>)
	       (<EQUAL? ,WINNER ,PROTAGONIST>
		<TELL "You can't see any"> 
		<NOT-HERE-PRINT .PRSO?>
		<TELL " here!" CR>)
	       (T
		<TELL "Looking confused, ">
		<ARTICLE ,WINNER T>
		<TELL D ,WINNER " says, \"I don't see any">
		<NOT-HERE-PRINT .PRSO?>
		<TELL " here!\"" CR>)>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

<ROUTINE FIND-NOT-HERE (TBL PRSO? "AUX" M-F OBJ)
	;"Here is where special-case code goes. <MOBY-FIND .TBL> returns
	   number of matches. If 1, then P-MOBY-FOUND is it. One may treat
	   the 0 and >1 cases alike or different. It doesn't matter. Always
	   return RFALSE (not handled) if you have resolved the problem."
	<SET M-F <MOBY-FIND .TBL>>
	<COND (,DEBUG
	       <TELL "[Found " N .M-F " obj]" CR>)>
	;<COND (<AND <G? .M-F 1>
		    <SET OBJ <GETP <1 .TBL> ,P?GLOBAL>>>
	       <SET M-F 1>
	       <SETG P-MOBY-FOUND .OBJ>)>
	<COND (<EQUAL? 1 .M-F>
	       <COND (,DEBUG <TELL "[Namely: " D ,P-MOBY-FOUND "]" CR>)>
	       <COND (.PRSO?
		      <SETG PRSO ,P-MOBY-FOUND>)
		     (T
		      <SETG PRSI ,P-MOBY-FOUND>)>
	       <RFALSE>)
	      (<NOT .PRSO?>
	       <TELL "You wouldn't find any">
	       <NOT-HERE-PRINT .PRSO?>
	       <TELL " there." CR>
	       <RTRUE>)
	      (T ,NOT-HERE-OBJECT)>>

<ROUTINE GLOBAL-NOT-HERE-PRINT (OBJ)
	 ;<COND (,P-MULT <SETG P-NOT-HERE <+ ,P-NOT-HERE 1>>)>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <TELL "You can't see any">
	 <COND (<EQUAL? .OBJ ,PRSO>
		<PRSO-PRINT>)
	       (T
		<PRSI-PRINT>)>
	 <TELL " here." CR>>

<ROUTINE NOT-HERE-PRINT (PRSO?)
	 <COND (,P-OFLAG
	        <COND (,P-XADJ <TELL " "> <PRINTB ,P-XADJN>)>
	        <COND (,P-XNAM <TELL " "> <PRINTB ,P-XNAM>)>)
               (.PRSO?
	        <BUFFER-PRINT <GET ,P-ITBL ,P-NC1> <GET ,P-ITBL ,P-NC1L> <>>)
               (T
	        <BUFFER-PRINT <GET ,P-ITBL ,P-NC2> <GET ,P-ITBL ,P-NC2L> <>>)>>

<OBJECT GROUND
	(IN GLOBAL-OBJECTS)
	(SYNONYM FLOOR GROUND MUD)
	(DESC "ground")
	(ACTION GROUND-F)>

<ROUTINE GROUND-F ()
	 <COND (<VERB? CLIMB-UP CLIMB-ON CLIMB-FOO BOARD LIE-DOWN>
		<V-SIT>)
	       (<VERB? LOOK-UNDER>
		<TELL "Huh?" CR>)>>

<OBJECT WALLS
	(IN GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "wall")
	(SYNONYM WALL WALLS)>

<OBJECT CEILING
	(IN GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "ceiling")
	(SYNONYM CEILIN ROOF)
	(ACTION CEILING-F)>

<ROUTINE CEILING-F ()
	 <COND (<VERB? LOOK-UNDER>
		<PERFORM ,V?LOOK>
		<RTRUE>)>>

<OBJECT STAIRS
	(IN LOCAL-GLOBALS)
	(DESC "stairs")
	(SYNONYM STAIR STAIRS STAIRW STAIRC)
	(ADJECTIVE MARBLE WIDE NARROW STEEP WINDIN SPIRAL)
	(FLAGS NARTICLEBIT NDESCBIT CLIMBBIT)
	(ACTION STAIRS-F)>

<ROUTINE STAIRS-F ()
	 <COND (<VERB? CLIMB-UP CLIMB-FOO>
		<DO-WALK ,P?UP>)
	       (<VERB? CLIMB-DOWN>
		<DO-WALK ,P?DOWN>)>>

<OBJECT HANDS
	(IN GLOBAL-OBJECTS)
	(SYNONYM HANDS)
	(ADJECTIVE BARE)
	(DESC "your hand")
	(FLAGS NDESCBIT TOOLBIT TOUCHBIT NARTICLEBIT)>

<OBJECT PROTAGONIST
	(IN THE-ROOM)
	(SYNONYM PROTAG)
	(DESC "protagonist")
	(FLAGS NDESCBIT INVISIBLE)
	(ACTION 0)>

<OBJECT ME
	(IN GLOBAL-OBJECTS)
	(SYNONYM I ME MYSELF)
	(DESC "yourself")
	(FLAGS ACTORBIT TOUCHBIT NARTICLEBIT)
	(ACTION ME-F)>

<ROUTINE ME-F ("AUX" OLIT) 
	 <COND (<VERB? TELL>
		<TELL
"Talking to yourself is said to be a sign of impending mental collapse." CR>
		<SETG P-CONT <>>
		<SETG QUOTE-FLAG <>>
		<RFATAL>)
	       (<VERB? LISTEN>
		<TELL "Yes?" CR>)
	       (<VERB? ALARM>
		<TELL "You are obviously awake already." CR>)
	       (<AND <VERB? GIVE>
		     <EQUAL? ,PRSI ,ME>>
		<COND (<HELD? ,PRSO>
		       <TELL "You already have it." CR>)
		      (T
		       <PERFORM ,V?TAKE ,PRSO>
		       <RTRUE>)>)
	       (<VERB? KILL MUNG>
		<COND (<FSET? ,PRSI ,WEAPONBIT>
		       <JIGS-UP "Done.">)
		      (T
		       <TELL "You don't need my help to do that!" CR>)>)
	       (<VERB? FIND>
		<TELL "You're right here!" CR>)>>

<OBJECT GLOBAL-ROOM
	(IN GLOBAL-OBJECTS)
	(DESC "room")
	(SYNONYM ROOM AREA PLACE HALL)
	(ACTION GLOBAL-ROOM-F)>

<ROUTINE GLOBAL-ROOM-F ()
	 <COND (<VERB? LOOK EXAMINE LOOK-INSIDE>
		<V-LOOK>
		<RTRUE>)
	       (<VERB? THROUGH DROP EXIT>
		<V-WALK-AROUND>)
	       (<VERB? WALK-AROUND>
		<TELL
"Walking around the room reveals nothing new. If you want to move elsewhere,
simply indicate the desired direction." CR>)>>

<OBJECT THE-ROOM
	(IN ROOMS)
	(DESC "The Room")
	(LDESC "This is a room with no exits.")
	(FLAGS ONBIT RLANDBIT)
	(NORTH TO THE-ROOM)
	(SOUTH TO THE-ROOM)
	(EAST TO THE-ROOM)
	(WEST TO THE-ROOM)
	(NE TO THE-ROOM)
	(SE TO THE-ROOM)
	(NW TO THE-ROOM)
	(SW TO THE-ROOM)
	(UP TO THE-ROOM)
	(DOWN TO THE-ROOM)
	(OUT TO THE-ROOM)
	(IN TO THE-ROOM)>
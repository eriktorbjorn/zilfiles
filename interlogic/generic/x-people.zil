"PEOPLE for RAGER
Copyright (C) 1988 Infocom, Inc.  All rights reserved."

"Constants used as table offsets for each character, including the player:"
<CONSTANT PLAYER-C 0>
<CONSTANT BERLYN-C 1>
<CONSTANT CHARACTER-MAX 1>

<OBJECT PLAYER
	(DESC "yourself")
	(LOC THE-ROOM)
	(SYNONYM ;"I" ME MYSELF SELF)
	(FLAGS NDESCBIT NARTICLEBIT SEARCHBIT ACTORBIT SEENBIT TOUCHBIT ;FEMALE
		;TRANSBIT OPENBIT ;"see GET-OBJECT")
	(CHARACTER 0)
	(ACTION PLAYER-F)>

<ROUTINE PLAYER-F ("OPTIONAL" (ARG <>) "AUX" (L <>))
 <COND (<NOT <==? .ARG ,M-WINNER>>
	<COND (<DOBJ? PLAYER>
	       <COND (<VERB? ;DANCE ;GOODBYE HELLO SORRY THANK>
		      <HAR-HAR>
		      <RTRUE>)
		     (<VERB? ALARM>
		      <TELL ,YOU-ARE CR>
		      <RTRUE>)
		     ;(<VERB? EXAMINE>
		      <TELL "You are wearing">
		      <COND (<ZERO? ,NOW-WEARING> <TELL " nothing">)
			    (T <TELL THE ,NOW-WEARING>)>
		      <SET L <FIRST? ,PLAYER>>
		      <REPEAT ()
			      <COND (<ZERO? .L>
				     <RETURN>)
				    (<AND <FSET? .L ,WORNBIT>
					  <NOT <==? .L ,NOW-WEARING>>>
				     <TELL " and" THE .L>)>
			      <SET L <NEXT? .L>>>
		      <TELL "." CR>
		      <RTRUE>)
		     (<VERB? FIND>
		      <TELL "You're right here, ">
		      <TELL-LOCATION>
		      <CRLF>
		      <RTRUE>)
		     (<VERB? FOLLOW>
		      <TELL
"I'd like to, but like most computers I don't have legs." CR>
		      <RTRUE>)
		     (<OR <VERB? KILL MUNG>
			  ;<AND <VERB? SHOOT>
				<IOBJ? BLASTER>>>
		      <JIGS-UP "Done.">
		      <RTRUE>)
		     (<VERB? LISTEN>
		      <TELL "Yes?" CR>
		      <RTRUE>)
		     (<VERB? MOVE>
		      <V-WALK-AROUND>
		      <RTRUE>)
		     (<VERB? PULL-TOGETHER>
		      <TELL ,ZEN CR>
		      <RTRUE>)
		     (<VERB? SEARCH>
		      <V-INVENTORY>
		      <RTRUE>)
		     ;(<VERB? SMELL>
		      <TELL "You smell ">
		      <COND (<T? ,WASHED> <TELL "clean and fresh." CR>)
			    (T <TELL "as if you need washing." CR>)>
		      <RTRUE>)
		     (<VERB? TELL>
		      <FUCKING-CLEAR>
		      <TELL
"Talking to yourself is a sign of impending mental collapse." CR>
		      <RTRUE>)>)
	      (<IOBJ? PLAYER>
	       <COND (<VERB? GIVE>
		      <COND (<IN? ,PRSO ,PLAYER>
			     <PRE-TAKE>
			     <RTRUE>)
			    (T
			     <PERFORM ,V?TAKE ,PRSO>
			     <RTRUE>)>)>)
	      (T <RFALSE>)>)
       ;(<DIVESTMENT? ,NOW-WEARING>
	<COND (<NO-CHANGING?> <RTRUE>)
	      (T
	       <COND (<AND <NOT <ZERO? ,NOW-WEARING>>
			   <NOT <VERB? DISEMBARK REMOVE>>>
		      ;<MOVE ,NOW-WEARING ,WINNER>
		      <FIRST-YOU "remove" ,NOW-WEARING>
		      <FCLEAR ,NOW-WEARING ,WORNBIT>
		      <SETG NOW-WEARING <>>)>
	       <RFALSE>)>)
       (<AND <T? ,PRSI>
	     <NOT <VERB? SEARCH-FOR>>
	     <FSET? ,PRSI ,SECRETBIT>
	     <NOT <FSET? ,PRSI ,SEENBIT>>>
	<NOT-FOUND ,PRSI>
	<RTRUE>)
       (<AND <T? ,PRSO>
	     <NOT <VERB? FIND WALK>>
	     <FSET? ,PRSO ,SECRETBIT>
	     <NOT <FSET? ,PRSO ,SEENBIT>>>
	<NOT-FOUND ,PRSO>
	<RTRUE>)
       ;(<AND <T? ,AWAITING-REPLY>
	     <VERB? FOLLOW THROUGH WALK WALK-TO>>
	<SETG CLOCK-WAIT T>
	<PLEASE-ANSWER>
	<RTRUE>)
       (<AND <EQUAL? <SET L <LOC ,PLAYER>> ,HERE ;,CAR>
	     ;<NOT ,PLAYER-SEATED>
	     ;<NOT ,PLAYER-HIDING>>
	<RFALSE>)
       (<T? ,P-WALK-DIR>		<TOO-BAD-SIT-HIDE>)
       (<EQUAL? ,PRSO <> ,ROOMS .L>
					<RFALSE>)
       ;(<EQUAL? ,PRSO ,PLAYER-SEATED <- 0 ,PLAYER-SEATED>>
					<RFALSE>)
       (<VERB? WALK-TO SEARCH SEARCH-FOR FIND>
	<COND (<DOBJ? SLEEP-GLOBAL>	<RFALSE>)
	      (T			<TOO-BAD-SIT-HIDE>)>)
       (<SPEAKING-VERB?>		<RFALSE>)
       (<GAME-VERB?>			<RFALSE>)
       (<REMOTE-VERB?>			<RFALSE>)
       (<VERB? AIM FAINT LISTEN LOOK-ON NOD SHOOT SMILE>
					<RFALSE>)
       (<HELD? ,PRSO>			<RFALSE>)
       (<HELD? ,PRSO ,GLOBAL-OBJECTS>	<RFALSE>)
       ;(<AND <EQUAL? .L ,CHAIR-DINING>
	     <IN? ,PRSO ,TABLE-DINING>>
					<RFALSE>)
       (<VERB? EXAMINE>			<RFALSE>)
       (<NOT <HELD? ,PRSO .L ;,PLAYER-SEATED>>	<TOO-BAD-SIT-HIDE>)
       (<NOT ,PRSI>			<RFALSE>)
       (<HELD? ,PRSI>			<RFALSE>)
       (<HELD? ,PRSI ,GLOBAL-OBJECTS>	<RFALSE>)
       (<NOT <HELD? ,PRSI .L ;,PLAYER-SEATED>>	<TOO-BAD-SIT-HIDE>)>>

<ROUTINE TOO-BAD-SIT-HIDE ()
	<MOVE ,WINNER ,HERE>
	<FIRST-YOU "stand up">
	<RFALSE>>

<ROUTINE NOT-FOUND (OBJ "AUX" (WT <>))
	<COND (<VERB? WALK-TO>
	       <SET WT T>)>
	<COND (<ZERO? .WT>
	       <SETG CLOCK-WAIT T>
	       <TELL "(Y">)
	      (T <TELL "But y">)>
	<TELL "ou haven't found" HIM .OBJ " yet!">
	<COND (<ZERO? .WT>
	       <TELL !\)>)>
	<CRLF>
	<RTRUE>>

<ROUTINE FUCKING-CLEAR ()
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RFATAL>>

<CONSTANT YOU-ARE "You already are!">

;<ROUTINE PLEASE-ANSWER ("AUX" (P <GETB ,QUESTIONERS ,AWAITING-REPLY>))
	<TELL D .P " says, \"">
	<COND (<EQUAL? .P ,BUTLER ,DOCTOR>
	       <TELL "Pardon me, "TN", but">)
	      (T <TELL "Wait a mo'.">)>
	<TELL " I asked you a question.\"" CR>>

<OBJECT BERLYN
	(LOC THE-ROOM)
	(DESC "Berlyn")
	(ADJECTIVE MR MICHAEL MS MUFFY)
	(SYNONYM BERLYN)
	(FLAGS NARTICLEBIT ACTORBIT MUNGBIT NDESCBIT)
	(LDESC 18 ;"deep in thought")
	(WEST SORRY "thinking")
	(CHARACTER 1)
	(DESCFCN BERLYN-D)
	(ACTION BERLYN-F)>

<ROUTINE BERLYN-D ("OPTIONAL" (ARG <>))
	<DESCRIBE-PERSON ,BERLYN>
	<RTRUE>>

<ROUTINE BERLYN-F ("OPTIONAL" (ARG <>) "AUX" OBJ X)
 <COND (<==? .ARG ,M-WINNER>
	<COND (<NOT <GRAB-ATTENTION ,BERLYN>> <RFATAL>)
	      (<SET X <COM-CHECK ,BERLYN>>
	       <COND (<==? .X ,M-FATAL> <RFALSE>)
		     (<==? .X ,M-OTHER> <RFATAL>)
		     (T <RTRUE>)>)
	      (T
	       <FUCKING-CLEAR>
	       <TELL
"\"I think you ought to know I'm feeling very depressed.\"" CR>)>)
       (<SET OBJ <ASKING-ABOUT? ,BERLYN>>
	<COND (<NOT <GRAB-ATTENTION ,BERLYN .OBJ>>
	       <RFATAL>)
	      (<EQUAL? .OBJ ,OBJECT-OF-GAME>
	       <TELL
"\"Being clever doesn't always make you happy, you know. Look at me, brain
the size of a planet, how many points do you think I've got? Minus thirty
zillion at the last count.\"" CR>)
	      (<SET X <COMMON-ASK-ABOUT ,BERLYN .OBJ>>
	       <COND (<==? .X ,M-FATAL> <RFALSE>) (T <RTRUE>)>)
	      (T <TELL "\"I don't know.\"" CR>)>)
       (<AND <VERB? ALARM SHAKE>
	     <EQUAL? <GETP ,BERLYN ,P?LDESC> 14 ;"asleep" 19 ;"out cold">>
	<TELL "Rather like trying to wake the dead." CR>)
       (T <PERSON-F ,BERLYN .ARG>)>>

<ADJ-SYNONYM MR MISTER>
<ADJ-SYNONYM MS MISS>

<ROUTINE ASKING-ABOUT? (WHO "AUX" DR)
	<COND (<VERB? ASK-ABOUT ;CONFRONT SHOW>
	       <COND (<EQUAL? .WHO ,PRSO>
		      <RETURN ,PRSI>)>)
	      ;(<VERB? FIND ;WHAT>
	       <COND (<EQUAL? .WHO ,WINNER>
		      <RETURN ,PRSO>)>)
	      (T <RFALSE>)>>

<CONSTANT CHARACTER-TABLE
	<PTABLE PLAYER BERLYN>>

<CONSTANT FOLLOW-LOC	<TABLE 0 0 0 0 0>>

<CONSTANT TOUCHED-LDESCS<TABLE 0 0 0 0 0>>

;<ROUTINE WHY-ME ()
 <COND (<1? <RANDOM 2>>
	<TELL "\"You could do that " 'PLAYER ", you know.\"" CR>
	;<TELL "\"If you think that will help, do it!\"" CR>)
       (T <TELL "\"I think you can do that better " 'PLAYER ".\"" CR>)>>

<ROUTINE DESCRIBE-PERSON (PER "AUX" (STR <>))
	<SET STR <GETP .PER ,P?LDESC>>
	<COND (<AND .STR ;<NOT <==? .STR 6 ;"walking along">>>
	       <PUT ,TOUCHED-LDESCS <GETP .PER ,P?CHARACTER> .STR>
	       ;<TELL <GET ,LDESC-STRINGS .STR>>
	       <RFALSE>)>
	<TELL CTHE .PER " is ">
	<COND (<AND <SET STR <GETPT .PER ,P?WEST>>
		    <SET STR <GET .STR ,NEXITSTR>>>
	       <TELL .STR>)
	      ;(T
	       <TELL "looking just as you want">)>
	<TELL ".">
	<COND (<==? .STR 6 ;"walking along"> <PRINTC 32>)
	      (T <CRLF>)>
	<RTRUE>>

<CONSTANT LDESC-STRINGS
 <PLTABLE	"dancing"
		"sipping sherry"
	;3	"watching you" ;"talking quietly"
		"looking at you with suspicion"
		0 ;"gazing out the window"
	;6	"walking along"
		"sobbing quietly"
		"poised to attack"
	;9	"waiting patiently"
		"eating with relish"
		"preparing dinner"
	;12	"listening to you"
		"lounging and chatting"
		"asleep"
	;15	0 ;"reading a note"
		"listening"
		"preparing to leave"
	;18	"deep in thought"
		"out cold"
		"ignoring you"
	;21	"searching"
		"playing the piano"
		"following you"
	;24	"brushing her hair"
		"looking sleepy">>

;<ROUTINE TELL-ABOUT-OBJECT (PER OBJ GL "AUX" C)
	<COND (<T? <GET .GL ,PLAYER-C>>
	       <SET C <GETP .PER ,P?CHARACTER>>
	       <COND (<ZERO? <GET .GL .C>>
		      <PUT .GL .C T>
		      ;<COND (<NOT <==? .C ,VARIATION>>
			     <PUTP .PER ,P?LINE 0>)>
		      <RETURN <GOOD-SHOW .PER .OBJ>>)
		     (T <TELL"\"I know that you found a " D .OBJ ".\"" CR>)>)>>

;<ROUTINE GOOD-SHOW (PER OBJ)
 <TELL !\">
 <COND ;(<==? ,VARIATION <GETP .PER ,P?CHARACTER>>
	<TELL "How nice">)
       (<1? <RANDOM 2>>
	<TELL "Well done">)
       (T <TELL "Good show">)>
 <TELL "! You found " A .OBJ "!\" says " D .PER "." CR>>

<ROUTINE PERSON-F (PER ARG "AUX" OBJ X L C N)
 <SET L <LOC .PER>>
 <SET C <GETP .PER ,P?CHARACTER>>
 <COND ;(<==? .ARG ,M-WINNER>
	<COND (<NOT <GRAB-ATTENTION .PER>> <RFATAL>)
	      (<SET X <COM-CHECK .PER>>
	       <COND (<==? .X ,M-FATAL> <RFALSE>)
		     (<==? .X ,M-OTHER> <RFATAL>)
		     (T <RTRUE>)>)
	      (T <WHY-ME> <RFATAL>)>)
       (<VERB? ALARM SHAKE>
	<COND (<==? ,PRSO .PER>
	       <COND ;(<AND <QUEUED? ,I-COME-TO>
			   <EQUAL? .PER ,VILLAIN-PER ,GHOST-NEW>>
		      <QUEUE I-COME-TO 1>	;"will respond"
		      <RTRUE>)
		     (<UNSNOOZE .PER T>
		      <TELL CHE .PER " gasps to see you so close!" CR>
		      <RTRUE>)
		     (T ;<VERB? SHAKE>
		      <TELL CHE+V .PER "is" " still ">
		      <COND (<SET X <GETP .PER ,P?LDESC>>
			     <TELL <GET ,LDESC-STRINGS .X>>)
			    (<SET X <GETPT .PER ,P?WEST>>
			     <TELL <GET .X ,NEXITSTR>>)>
		      <TELL "." CR>)>)>)
       (<VERB? GIVE>
	<COND (<AND <EQUAL? ,PRSI .PER> <HELD? ,PRSO>>
	       <COND (<NOT <GRAB-ATTENTION .PER>> <RFATAL>)>
	       <RFALSE>)>)
       ;(<VERB? LISTEN>		;"moved to PRE-LISTEN"
	<COND (<==? <GETP .PER ,P?LDESC> 22 ;"playing the piano">
	       <TELL "The music sounds lovely." CR>
	       <RTRUE>)>)
       (<VERB? LAMP-OFF>
	<COND ;(<T? <GETP .PER ,P?LINE>>
	       <TELL "Seems you've already done that." CR>)
	      (T <WONT-HELP>)>)
       (<VERB? MUNG SEARCH SEARCH-FOR>
	<COND (<AND <==? .PER ,PRSO>
		    ;<OR <NOT <==? .PER ,FRIEND>>
			<EQUAL? ,VARIATION ,FRIEND-C>>
		    <FSET? .PER ,ACTORBIT>
		    <NOT <FSET? .PER ,MUNGBIT>>>
	       ;<PUTP .PER ,P?LINE <+ 1 <GETP .PER ,P?LINE>>>
	       <COND (<NOT <EQUAL? <GETP .PER ,P?LDESC>
				   4 ;"looking at you with suspicion">>
		      ;<EQUAL? .PER ,FRIEND>
		      <PUTP .PER ,P?LDESC 20 ;"ignoring you">)>
	       <TELL
CHE .PER " pushes you away and mutters, \"I don't think that's
called for.\"" CR>
	       <RTRUE>)>)
       (<VERB? SHOW>
	<COND (<==? .PER ,PRSO>
	       <COND (<AND ;<NOT <EQUAL? ,PRSI ,PASSAGE>>
			   <NOT <GRAB-ATTENTION .PER>>>
		      <RFATAL>)
		     ;(<EQUAL? ,PRSI ,LOVER>
		      <TELL "\"She's alive! That's incredible!\"" CR>
		      <RTRUE>)
		     (T
		      <PERFORM ,V?TELL-ABOUT ,PRSO ,PRSI>
		      <RTRUE>)>)>)
       (<VERB? SMILE>
	<COND (<==? .PER ,PRSO>
	       <COND (<NOT <GRAB-ATTENTION .PER>>
		      <RFATAL>)
		     (T
		      <TELL CHE+V ,PRSO "smile" " back at you." CR>
		      <RTRUE>)>)>)
       (<VERB? TELL-ABOUT>
	<COND (<==? .PER ,PRSO>
	       <COND (<NOT <GRAB-ATTENTION .PER>>
		      <RFATAL>)>
	       <PUTP .PER ,P?LDESC 12 ;"listening to you">
	       ;<COND (<SECRET-PASSAGE-OR-DOOR? ,PRSI>
		      <TELL-ABOUT-OBJECT ,PRSO ,PASSAGE ,FOUND-PASSAGES>
		      <RTRUE>)>
	       <TELL "\"I don't know what you mean.\"" CR>)>)
       (<VERB? THROW-AT>
	<COND (<AND <==? .PER ,PRSI>
		    <FSET? .PER ,ACTORBIT>
		    <NOT <FSET? .PER ,MUNGBIT>>>
	       <MOVE ,PRSO ,PRSI>
	       <TELL CHE .PER " catches" THE ,PRSO " with" HIS .PER !\ >
	       <COND ;(<EQUAL? .PER ,DEB ,DOCTOR> <TELL "lef">)
		     (T <TELL "righ">)>
	       <TELL "t hand." CR>
	       <RTRUE>)>)
       ;(<SET OBJ <ASKING-ABOUT? .PER>>
	<COND (<NOT <GRAB-ATTENTION .PER>>
	       <RFATAL>)
	      ;(<SET X <COMMON-ASK-ABOUT .PER .OBJ>>
	       <COND (<==? .X ,M-FATAL> <RFALSE>) (T <RTRUE>)>)
	      (T <DONT-KNOW .PER .OBJ>)>)
       (T <COMMON-OTHER .PER>)>>

"People Functions"

<ROUTINE CARRY-CHECK (PER)
 <COND (<FIRST? .PER>
	<TELL CHE+V .PER "is" " holding">
	<PRINT-CONTENTS .PER>
	<TELL "." CR>)>>

<ROUTINE TRANSIT-TEST (PER)
	<COND (<OR <VERB? DISEMBARK LEAVE TAKE-TO THROUGH WALK WALK-TO>
		   ;<AND <VERB? FOLLOW>
			<DOBJ? PLAYER>>>
	       T ;<WILLING? .PER>)>>

<ROUTINE COM-CHECK (PER "AUX" N)
 	 ;<SET N <GETP .PER ,P?LINE>>
;"First section is w/o fawning."
	 <COND (<VERB? $CALL>	;"e.g. TAMARA, LOVE ME"
		<DONT-UNDERSTAND>
		<RETURN ,M-OTHER>)
	       (<TRANSIT-TEST .PER>
		;<COND (<OR <EQUAL? ,HERE ,DINING-ROOM>
			   <QUEUED? ,I-TOUR>>
		       <TELL "\"Not just now.\"" CR>
		       <RTRUE>)>
		<RFATAL>)
	       (<VERB? ALARM HELLO SORRY>
		<COND (<OR <DOBJ? ROOMS> <==? ,PRSO .PER>>
		       <SETG WINNER ,PLAYER>
		       <PERFORM ,PRSA .PER>
		       <RTRUE>)
		      (T <RFALSE>)>)
	       ;(<AND <L? 0 .N>
		     ;<OR <NOT <==? .PER ,FRIEND>>
			 <EQUAL? ,VARIATION ,FRIEND-C>>>
		<TELL "\"I'm too ">
		<COND (<1? .N> <TELL "peeved">) (T <TELL "angry">)>
		<TELL " with you now.\"" CR>
		<RTRUE>)
	       (<VERB? NO THANK YES>
		<RFATAL>		;"let thru to next handler")
	       (<VERB? FOLLOW WALK-TO>
		<COND ;(<==? .PER ,BUTLER>
		       <RFALSE>)
		      (<AND <VERB? WALK-TO>
			    <DOBJ? SLEEP-GLOBAL ;BED>>
		       <RFATAL>)
		      (T
		       <TELL
"\"I will go where I please, thank you very much.\"" CR>
		       <RTRUE>)>)
	       (<VERB? INVENTORY>
		<COND (<NOT <CARRY-CHECK .PER>>
		       <TELL CHE+V .PER "is" "n't holding anything." CR>)>
		<RTRUE>)
	       (<VERB? LISTEN>
		<COND (<OR <DOBJ? PLAYER ;PLAYER-NAME>
			   <NOT <IN? ,PRSO ,GLOBAL-OBJECTS>>>
		       <TELL "\"I'm trying to!\"" CR>
		       <RTRUE>)
		      (T <RFALSE>)>)
	       (<VERB? RUB>
		<FACE-RED>
		<RTRUE>)>
	 <COND ;(<AND <VERB? DANCE> <DOBJ? PLAYER>>
		<SETG WINNER ,PLAYER>
		<PERFORM ,PRSA .PER>
		<RTRUE>)
	       (<OR ;<VERB? DANCE>
		    <AND <VERB? WALK>
			 <DOBJ? P?OUT>>>
		<COND ;(<==? .PER ,GHOST-NEW>
		       <TELL "\"Don't be silly.\"" CR>
		       <RTRUE>)
		      (T
		       ;<TELL "\"As you wish.\"" CR>
		       <RFATAL>	;"let thru to next handler")>)
	       ;(<VERB? SIGN>
		<TELL "You notice that" HE .PER " is ">
		<COND ;(<EQUAL? .PER ,DEB ,DOCTOR> <TELL "lef">)
		      (T <TELL "righ">)>
		<TELL "t-handed." CR>)
	       (<VERB? KISS>
		<UNSNOOZE .PER>
		<TELL
"\"I really don't think this is the proper time or place.\"" CR>)
	       ;(<VERB? WALK-TO>
		<COND (<DOBJ? HERE GLOBAL-HERE>
		       <TELL "\"I am here, "TN"!\"" CR>)>)
	       (<VERB? TAKE ;"GET SEND SEND-TO BRING">
		<COND (<IN? ,PRSO ,PLAYER>
		       <SETG WINNER ,PLAYER>
		       <PERFORM ,V?GIVE ,PRSO .PER>
		       <RTRUE>)>)
	       (<VERB? EXAMINE LOOK-INSIDE READ>
		<COND (<IN? ,PRSO ,PLAYER>
		       <SETG WINNER ,PLAYER>
		       <PERFORM ,V?SHOW .PER ,PRSO>
		       <RTRUE>)>)
	       (<AND <VERB? GIVE THROW-AT> <FSET? ,PRSI ,ACTORBIT>>
		<SETG WINNER ,PRSI>
		<PERFORM ,V?ASK-FOR .PER ,PRSO>
		<RTRUE>)
	       (<AND <VERB? SGIVE> <FSET? ,PRSO ,ACTORBIT>>
		<SETG WINNER ,PRSO>
		<PERFORM ,V?ASK-FOR .PER ,PRSI>
		<RTRUE>)
	       (<VERB? HELP>
		<COND (<EQUAL? ,PRSO <> ,PLAYER ;,PLAYER-NAME>
		       <SETG WINNER ,PLAYER>
		       <PERFORM ,V?ASK .PER>
		       <RTRUE>)
		      (T <RFATAL>)>)
	       (<VERB? FIND SHOW SSHOW>
		<COND (<VERB? SHOW>
		       <SETG PRSA ,V?SSHOW>
		       <SET N ,PRSI>
		       <SETG PRSI ,PRSO>
		       <SETG PRSO .N>)>
		<COND (<IN? ,PRSO ,ROOMS>	;"SHOW ME MY ROOM"
		       <SETG WINNER ,PLAYER>
		       <PERFORM ,V?WALK-TO ,PRSO>
		       <RTRUE>)
		      (<IN? ,PRSO .PER>
		       <COND (<==? <ITAKE> T>
			      <TELL
CHE .PER " fumbles in" HIS .PER " pocket and produces" HIM ,PRSO "." CR>)>
		       <RTRUE>)
		      (<VERB? FIND>
		       ;<SETG WINNER ,PLAYER>
		       ;<PERFORM ,PRSA ,PRSO>
		       <RFATAL>)>)
	       ;(<VERB? PLAY>
		<COND (<DOBJ? PIANO>
		       <TELL
"\"I'm not very good at this sort of thing, but...\"|">
		       <RFATAL>)
		      (T <RFALSE>)>)
	       (<VERB? TELL>
		<COND (<DOBJ? PLAYER ;PLAYER-NAME>
		       <SETG WINNER ,PLAYER>
		       <PERFORM ,V?ASK .PER>
		       <RTRUE>)>)
	       (<VERB? TELL-ABOUT>
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <SETG WINNER ,PLAYER>
		       <PERFORM ,V?ASK-ABOUT .PER ,PRSI>
		       ;<SETG WINNER .PER>
		       <RTRUE>)>)
	       (<VERB? STOP WAIT-FOR>
		<COND (<DOBJ? HERE GLOBAL-HERE PLAYER ;PLAYER-NAME ROOMS>
		       <COND (<==? .PER ,FOLLOWER>
			      <SETG FOLLOWER 0>
			      <TELL "\"As you wish.\"" CR>)
			     (T
			      <SETG WINNER ,PLAYER>
			      <PERFORM ,V?$CALL .PER>
			      <RTRUE>)>)>)
	       (<VERB? ;WHAT TALK-ABOUT>
		<SETG WINNER ,PLAYER>
	        <PERFORM ,V?ASK-ABOUT .PER ,PRSO>
		<RTRUE>)>>

<ROUTINE COMMON-ASK-ABOUT (PER OBJ)
 %<DEBUG-CODE <COND (,DBUG <TELL "{CAB: " D .PER !\/ D .OBJ "}|">)>>
 <COND (<EQUAL? .OBJ .PER>
	<TELL "\"I have no secrets. Anyone can see what I am.\"" CR>)
       (<EQUAL? .OBJ ,PLAYER ;,PLAYER-NAME>
	<TELL "\"You're Muffy or Michael Berlyn.\"" CR>)
       (<FSET? .OBJ ,ACTORBIT>
	<RFALSE>)
       (<EQUAL? .OBJ ,OBJECT-OF-GAME>
	<TELL
"\"Oh...you're trying to figure that out also? The
manual's not much help, is it? By the way, do you know your score? I don't.
My computer doesn't have a status line.\"" CR>)
       (<IN? .OBJ .PER>
	<TELL "\"I have it right here.\"" CR>)>>

<ROUTINE COMMON-OTHER (PER "AUX" (X <>) N)
 <COND (<VERB? ASK> <RFALSE>)
       (<VERB? EXAMINE>
	<COND ;(<OR <EQUAL? .PER ,DOCTOR>
		   <EQUAL? .PER ,LORD ,OFFICER ,DEALER>>
	       <COMMON-DESC .PER>)
	      (T
	       <TELL <GETP .PER ,P?TEXT> CR>)>
	;<THIS-IS-IT .PER>
	<COND (<AND <IN? .PER ,HERE>
		    <SET N <FIRST? .PER>>
		    <NOT <FSET? .N ,NDESCBIT>>>
	       <COND (<CARRY-CHECK .PER>
		      <SET X T>)>)>
	<COND (<FSET? .PER ,MUNGBIT>
	       <COND (<NOT <ZERO? .X>> <TELL "And">)>
	       <HE-SHE-IT .PER <NOT .X> "is">
	       ;<SET X T>
	       <PRINTC 32>
	       <TELL <GET ,LDESC-STRINGS <GETP .PER ,P?LDESC>> "." CR>)
	      ;(<NOT <FSET? .PER ,ACTORBIT>>
	       <COND (<NOT <ZERO? .X>> <TELL "And">)>
	       <FSET .PER ,ACTORBIT>
	       <HE-SHE-IT .PER <NOT .X> "is">
	       <FCLEAR .PER ,ACTORBIT>
	       <SET X T>
	       <TELL " dead." CR>)>
	<RTRUE>)
       (<AND <EQUAL? ,PRSO .PER> <VERB? SHOW>>
	<PERFORM ,V?ASK-ABOUT ,PRSO ,PRSI>
	<RTRUE>)>>

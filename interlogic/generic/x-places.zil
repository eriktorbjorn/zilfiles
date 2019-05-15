"PLACES for RAGER
Copyright (C) 1988 Infocom, Inc.  All rights reserved."

"The usual globals"

<OBJECT ROOMS
	(DESC "that")
	(FLAGS NARTICLEBIT)>

<ROUTINE NULL-F ("OPTIONAL" A1 A2)
	<RFALSE>>

<ROUTINE DOOR-ROOM (RM DR "AUX" (P 0) TBL)
	 <REPEAT ()
		 <COND (<OR <0? <SET P <NEXTP .RM .P>>>
			    <L? .P ,LOW-DIRECTION>>
			<RFALSE>)
		       (<AND <==? ,DEXIT <PTSIZE <SET TBL <GETPT .RM .P>>>>
			     <==? .DR <GET/B .TBL ,DEXITOBJ>>>
			<RETURN <GET/B .TBL ,REXIT>>)>>>

<ROUTINE FIND-IN (RM FLAG "OPTIONAL" (EXCLUDED <>) "AUX" O)
	<SET O <FIRST? .RM>>
	<REPEAT ()
	 <COND (<NOT .O> <RFALSE>)
	       (<AND <FSET? .O .FLAG>
		     <NOT <FSET? .O ,INVISIBLE>>
		     <NOT <==? .O .EXCLUDED>>>
		<RETURN .O>)
	       (T <SET O <NEXT? .O>>)>>>

<ROUTINE FIND-FLAG-NOT (RM FLAG ;"OPTIONAL" ;(EXCLUDED <>) "AUX" O)
	<SET O <FIRST? .RM>>
	<REPEAT ()
	 <COND (<NOT .O> <RFALSE>)
	       (<AND <NOT <FSET? .O .FLAG>>
		     <NOT <FSET? .O ,INVISIBLE>>
		     ;<NOT <==? .O .EXCLUDED>>>
		<RETURN .O>)
	       (T <SET O <NEXT? .O>>)>>>

<ROUTINE FIND-FLAG-LG (RM FLAG "OPTIONAL" (FLAG2 0) "AUX" TBL O (CNT 0) SIZE)
	 <COND (<SET TBL <GETPT .RM ,P?GLOBAL>>
		<SET SIZE <RMGL-SIZE .TBL>>
		<REPEAT ()
			<SET O <GET/B .TBL .CNT>>
			<COND (<AND <FSET? .O .FLAG>
				    <NOT <FSET? .O ,INVISIBLE>>
				    <OR <0? .FLAG2> <FSET? .O .FLAG2>>>
			       <RETURN .O>)
			      (<IGRTR? CNT .SIZE> <RFALSE>)>>)>>

<ROUTINE FIND-FLAG-HERE (FLAG "OPTIONAL" (NOT1 <>) (NOT2 <>) "AUX" O)
	<SET O <FIRST? ,HERE>>
	<REPEAT ()
	 <COND (<NOT .O> <RFALSE>)
	       (<AND <FSET? .O .FLAG>
		     <NOT <FSET? .O ,INVISIBLE>>
		     <NOT <EQUAL? .O .NOT1 .NOT2>>>
		<RETURN .O>)
	       (T <SET O <NEXT? .O>>)>>>

;<ROUTINE FIND-FLAG-HERE-BOTH (FLAG FLAG2 "OPTIONAL" (NOT2 <>) "AUX" O)
	<SET O <FIRST? ,HERE>>
	<REPEAT ()
	 <COND (<NOT .O> <RFALSE>)
	       (<AND <FSET? .O .FLAG>
		     <FSET? .O .FLAG2>
		     <NOT <FSET? .O ,INVISIBLE>>
		     <NOT <EQUAL? .O .NOT2>>>
		<RETURN .O>)
	       (T <SET O <NEXT? .O>>)>>>

<ROUTINE FIND-FLAG-HERE-NOT (FLAG NFLAG "OPTIONAL" (NOT2 <>) "AUX" O)
	<SET O <FIRST? ,HERE>>
	<REPEAT ()
	 <COND (<NOT .O> <RFALSE>)
	       (<AND <FSET? .O .FLAG>
		     <NOT <FSET? .O .NFLAG>>
		     <NOT <FSET? .O ,INVISIBLE>>
		     <NOT <EQUAL? .O .NOT2>>>
		<RETURN .O>)
	       (T <SET O <NEXT? .O>>)>>>

;<ROUTINE OPEN-CLOSE (DR "OPTIONAL" (SAY-NAME T) X)
	<COND (.SAY-NAME
	       <TELL CTHE .DR>)>
	<TELL " creaks ">
	<COND (<FSET? .DR ,OPENBIT>
	       <FCLEAR .DR ,OPENBIT>
	       <THIS-IS-IT .DR>
	       <TELL "closed.|">
	       <REMOVE-CAREFULLY>
	       <RTRUE>)
	      (<SET X <DOOR-ROOM ,HERE .DR>>
	       <FSET .DR ,OPENBIT>
	       <THIS-IS-IT .X>
	       <TELL "open, revealing">
	       <COND (T ;<FSET? ,HERE ,SECRETBIT>
		      <TELL THE .X>)>
	       <FSET .DR ,SEENBIT>
	       <FSET .X ,SEENBIT>
	       <TELL "!" CR>)>>

<ROUTINE OUTSIDE? (RM) <GLOBAL-IN? ,SKY .RM>>

;<ROUTINE UNIMPORTANT-THING-F ()
	 <TELL "That's not important; leave it alone." CR>>

;<OBJECT CAR-WINDOW
	(LOC CAR ;LOCAL-GLOBALS)
	(DESC "car window")
	(ADJECTIVE CAR)
	(SYNONYM WINDOW WINDSHIELD WINDSCREEN DOOR)
	;(GENERIC GENERIC-WINDOW)
	(FLAGS SEENBIT NDESCBIT)
	(ACTION WINDOW-F)>

<OBJECT WINDOW
	(LOC LOCAL-GLOBALS)
	(DESC "window")
	(SYNONYM WINDOW WINDSHIELD WINDSCREEN DOOR)
	;(GENERIC GENERIC-WINDOW)
	(FLAGS SEENBIT NDESCBIT)
	(ACTION WINDOW-F)>

<ROUTINE WINDOW-F ()
 <COND (<VERB? OPEN CLOSE LOCK UNLOCK>
	<COND (<VERB? OPEN>
	       <TELL "The night air is too damp and chilly." CR>)
	      (T ;<VERB? CLOSE>
	       <ALREADY ,WINDOW "closed">
	       <RTRUE>)>)
       (<VERB? DISEMBARK ;"CLIMB OUT" LEAVE THROUGH>
	<TELL "It's closed tight against the mist." CR>)
       (<VERB? LOOK-INSIDE LOOK-THROUGH LOOK-OUTSIDE>
	<TELL "All you can see are grey shapes in the moonlight." CR>)>>

<ROOM THE-ROOM
      (DESC "The Room")
      (LOC ROOMS)
      (SYNONYM ROOM)
      (LDESC "Wherever you go, there you are.")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL WINDOW)
      (THINGS <PSEUDO ( GREEN DOOR	NULL-F)>)>

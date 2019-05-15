"VERBS for GENERIC
(c) Copyright 1984 Infocom, Inc.  All Rights Reserved."

;"subtitle game commands"

<GLOBAL VERBOSE <>>

<GLOBAL SUPER-BRIEF <>>

<GDECL (VERBOSE SUPER-BRIEF) <OR ATOM FALSE>>

<ROUTINE V-VERBOSE ()
	 <SETG VERBOSE T>
	 <SETG SUPER-BRIEF <>>
	 <TELL "Maximum verbosity." CR CR>
	 <V-LOOK>>

<ROUTINE V-BRIEF ()
	 <SETG VERBOSE <>>
	 <SETG SUPER-BRIEF <>>
	 <TELL "Brief descriptions." CR>>

<ROUTINE V-SUPER-BRIEF ()
	 <SETG SUPER-BRIEF T>
	 <TELL "Super-brief descriptions." CR>>

<ROUTINE V-DIAGNOSE ()
	 <TELL "You are in good-health." CR>>

<ROUTINE V-INVENTORY ()
	 <COND (<NOT <FIRST? ,PROTAGONIST>>
		<TELL "You are empty-handed." CR>)
	       (T
		<TELL "You are carrying:" CR>
	        <PRINT-CONT ,PROTAGONIST>)>>

<ROUTINE V-QUIT ("OPTIONAL" (ASK? T) "AUX" SCOR)
	 #DECL ((ASK?) <OR ATOM <PRIMTYPE LIST>> (SCOR) FIX)
	 <V-SCORE>
	 <COND (<OR <AND .ASK?
			 <TELL
"Do you wish to leave the game? (Y is affirmative): ">
			 <YES?>>
		    <NOT .ASK?>>
		<QUIT>)
	       (T
		<TELL "Ok." CR>)>>

<ROUTINE V-RESTART ()
	 <V-SCORE T>
	 <TELL "Do you wish to restart? (Y is affirmative): ">
	 <COND (<YES?>
		<TELL "Restarting." CR>
		<RESTART>
		<TELL "Failed." CR>)>>

<ROUTINE FINISH ("OPTIONAL" (REPEATING <>))
	 <CRLF>
	 <COND (<NOT .REPEATING>
		<V-SCORE>
		<CRLF>)>
	 <TELL
"Would you like to restart the game from the beginning, restore a saved
game position, or end this session of the game? (Type RESTART, RESTORE,
or QUIT): >">
	 <READ ,P-INBUF ,P-LEXV>
	 <COND (<EQUAL? <GET ,P-LEXV 1> ,W?RESTAR>
	        <RESTART>
		<TELL "Failed." CR>
		<FINISH T>)
	       (<EQUAL? <GET ,P-LEXV 1> ,W?RESTOR>
		<COND (<RESTORE>
		       <TELL "Ok." CR>)
		      (T
		       <TELL "Failed." CR>
		       <FINISH T>)>)
	       (T
		<QUIT>)>>

<GLOBAL YES-INBUF <ITABLE BYTE 12>>
<GLOBAL YES-LEXV  <ITABLE BYTE 10>>

<ROUTINE YES? ()
	 <PRINTI ">">
	 <READ ,YES-INBUF ,YES-LEXV>
	 <COND (<EQUAL? <GET ,YES-LEXV ,P-LEXSTART> ,W?YES ,W?Y>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-RESTORE ()
	 <COND (<RESTORE>
		<TELL "Ok." CR>)
	       (T
		<TELL "Failed." CR>)>>

<ROUTINE V-SAVE ()
	 <COND (<SAVE>
	        <TELL "Ok." CR>)
	       (T
		<TELL "Failed." CR>)>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
	 #DECL ((ASK?) <OR ATOM FALSE>)
	 <TELL "Your score is " N ,SCORE " of a possible 400, in " N ,MOVES>
	 <COND (<1? ,MOVES>
		<TELL " move.">)
	       (T
		<TELL " moves.">)>
	 ,SCORE>

<ROUTINE V-SCRIPT ()
	<PUT 0 8 <BOR <GET 0 8> 1>>
	<TELL "Here begins" ,COPR-NOTICE CR>
	<V-VERSION>>

<ROUTINE V-UNSCRIPT ()
	<TELL "Here ends" ,COPR-NOTICE CR>
	<V-VERSION>
	<PUT 0 8 <BAND <GET 0 8> -2>>
	<RTRUE>>

<GLOBAL COPR-NOTICE
" a transcript of interaction with Generic.">

<ROUTINE V-VERSION ("AUX" (CNT 17))
	 <TELL
"Generic Interactive Fiction|
Copyright (c) 1984 by Infocom, Inc. All rights reserved.|
Generic is a trademark of Infocom, Inc.|
Release ">
	 <PRINTN <BAND <GET 0 1> *3777*>>
	 <TELL " / Serial number ">
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> 23>
			<RETURN>)
		       (T
			<PRINTC <GETB 0 .CNT>>)>>
	 <CRLF>>

<ROUTINE V-$VERIFY ()
	 <TELL "Verifying disk..." CR>
	 <COND (<VERIFY>
		<TELL "Disk correct." CR>)
	       (T
		<TELL CR "** Bad **" CR>)>>

<GLOBAL DEBUG <>>

<ROUTINE V-$DEBUG ()
	 <COND (,DEBUG
		<SETG DEBUG <>>
		<TELL "Debugging off." CR>)
	       (T
		<SETG DEBUG T>
		<TELL "Debugging on." CR>)>>

^\L

;"subtitle real verbs"

<ROUTINE V-AGAIN ("AUX" OBJ)
	 <COND (<NOT ,L-PRSA>
		<ANYMORE>)
	       (<AND <NOT <EQUAL? ,HERE ,L-HERE>>
		     <EQUAL? ,PSEUDO-OBJECT ,L-PRSO ,L-PRSI>>
		<SETG L-PRSA <>>
		<ANYMORE>)
	       (<EQUAL? ,L-PRSA ,V?WALK>
		<DO-WALK ,L-PRSO>)
	       (T
	        <SET OBJ
		     <COND (<AND ,L-PRSO
				 <EQUAL? <LOC ,L-PRSO> ,ROOMS>>
			    ,L-PRSO)
			   (<AND ,L-PRSI
				 <EQUAL? <LOC ,L-PRSI> ,ROOMS>>
			    ,L-PRSI)>>
		<COND (<AND .OBJ 
			    <NOT <EQUAL? .OBJ ,PSEUDO-OBJECT ,ROOMS>>>
		       <TELL "You can't see ">
		       <ARTICLE .OBJ T>
		       <TELL D .OBJ " anymore." CR>
		       <RFATAL>)
		      (T
		       <PERFORM ,L-PRSA ,L-PRSO ,L-PRSI>)>)>>

<GLOBAL LAST-HERE <>>

<ROUTINE I-AGAIN-LOC ()
	 <SETG L-HERE ,LAST-HERE>
	 <SETG LAST-HERE ,HERE>
	 <RFALSE>>

<ROUTINE V-ALARM ()
	 <COND (<EQUAL? ,PRSO ,ROOMS>
		<PERFORM ,V?ALARM ,ME>
		<RTRUE>)
	       (T
		<TELL "I don't think that ">
	        <ARTICLE ,PRSO T>
	        <TELL D ,PRSO " is sleeping." CR>)>>

<ROUTINE V-ANSWER ()
	 <TELL "Nobody seems to be awaiting your answer." CR>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RFATAL>>

<ROUTINE V-ASK-ABOUT ()
	 <COND (<EQUAL? ,PRSO ,ME>
		<PERFORM ,V?TELL ,ME>
		<RTRUE>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<TELL "After a moment's thought, ">
		<ARTICLE ,PRSO T>
		<TELL D ,PRSO " denies any knowledge of ">
		<ARTICLE ,PRSI T>
		<TELL D ,PRSI ".">
		<COND (<EQUAL? ,PRSO ,PRSI>
		       <TELL " (Rather disingenuous, if you ask me.)">)>
		<CRLF>)
	       (T
		<PERFORM ,V?TELL ,PRSO>
		<RTRUE>)>>

<ROUTINE V-ASK-FOR ()
	 <TELL "Unsurprisingly, ">
	 <ARTICLE ,PRSO T>
	 <TELL D ,PRSO " is not likely to oblige." CR>>

<ROUTINE V-BACK ()
	 <V-WALK-AROUND>>

<ROUTINE V-BITE ()
	 <HACK-HACK "Biting">>

<ROUTINE PRE-BOARD ("AUX" AV)
	 <SET AV <LOC ,WINNER>>
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<COND (<FSET? .AV ,VEHBIT>
		       <TELL "You are already in ">
		       <ARTICLE ,PRSO T>
		       <TELL D .AV "!" CR>)
		      (T
		       <RFALSE>)>)
	       (T
		<TELL "You can't get into ">
		<ARTICLE ,PRSO T>
		<TELL D ,PRSO "!" CR>)>
	 <RFATAL>>

<ROUTINE V-BOARD ("AUX" AV)
	 #DECL ((AV) OBJECT)
	 <TELL "You are now in ">
	 <ARTICLE ,PRSO T>
	 <TELL D ,PRSO "." CR>
	 <MOVE ,WINNER ,PRSO>
	 <APPLY <GETP ,PRSO ,P?ACTION> ,M-ENTER>
	 <RTRUE>>

<ROUTINE V-BURN ()
	 <COND (<NOT ,PRSI>
		<TELL "Your blazing gaze is insufficient." CR>)
	       (T
		<TELL "With ">
		<ARTICLE ,PRSI>
		<TELL D ,PRSI "??!?" CR>)>>

<ROUTINE V-CHASTISE ()
	 <TELL
"Use prepositions to indicate precisely what you want to do: LOOK AT the
object, LOOK INSIDE it, LOOK UNDER it, etc." CR>>

<ROUTINE V-CLIMB-DOWN ()
	 <COND (<EQUAL? ,PRSO ,ROOMS>
		<DO-WALK ,P?DOWN>)
	       (T
		<V-DEFLATE>)>>

<ROUTINE V-CLIMB-FOO ()
	 <COND (<EQUAL? ,PRSO ,ROOMS>
		<DO-WALK ,P?UP>)
	       (T
		<V-DEFLATE>)>>

<ROUTINE V-CLIMB-ON ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)
	       (T
		<TELL "You can't climb onto ">
		<ARTICLE ,PRSO T>
		<TELL D ,PRSO "." CR>)>>

<ROUTINE V-CLIMB-OVER ()
	 <TELL "You can't." CR>>

<ROUTINE V-CLIMB-UP ()
	 <COND (<EQUAL? ,PRSO ,ROOMS>
		<DO-WALK ,P?UP>)
	       (T
		<V-DEFLATE>)>>

<ROUTINE V-CLOSE ()
	 <COND (<FSET? ,PRSO ,SURFACEBIT>
		<TELL "There's no way to close ">
		<ARTICLE ,PRSO>
		<TELL D ,PRSO "." CR>)
	       (<AND <NOT <FSET? ,PRSO ,CONTBIT>>
		     <NOT <FSET? ,PRSO ,DOORBIT>>>
		<PERFORM ,V?OPEN ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<TELL "Huh?" CR>)
	       (<AND <NOT <FSET? ,PRSO ,SURFACEBIT>>
		     <NOT <EQUAL? <GETP ,PRSO ,P?CAPACITY> 0>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL "Closed.">
		       <SETG LIT <LIT? ,HERE>>
		       <COND (<NOT ,LIT>
			      <TELL " ">
			      <NOW-BLACK>)>
		       <CRLF>)
		      (T
		       <ALREADY-CLOSED>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "Okay, ">
		       <ARTICLE ,PRSO T>
		       <TELL D ,PRSO " is now closed." CR>
		       <FCLEAR ,PRSO ,OPENBIT>)
		      (T
		       <ALREADY-CLOSED>)>)
	       (T
		<TELL "You cannot close that." CR>)>>

<ROUTINE V-COMPARE ()
	 <V-SIT>>

<ROUTINE V-COUNT ()
	 <TELL "You have lost your mind." CR>>

<ROUTINE V-CROSS ()
	 <TELL "You can't cross that!" CR>>

<ROUTINE V-CURSE ()
	 <TELL "Such language!" CR>>

<ROUTINE V-CUT ()
	 <COND (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<TELL "I doubt that the \"cutting edge\" of ">
		<ARTICLE ,PRSI>
		<TELL D ,PRSI " is adequate." CR>)>>

<ROUTINE V-DEFLATE ()
	 <TELL "Bizarre." CR>>

<ROUTINE V-DIG ()
	 <V-SIT>>

<ROUTINE V-DISEMBARK ()
	 <COND (<NOT <EQUAL? <LOC ,WINNER> ,PRSO>>
		<LOOK-AROUND>
		<RFATAL>)
	       (T
		<TELL "You are now on your feet." CR>
		<MOVE ,WINNER ,HERE>)>>

<ROUTINE V-DRINK ("AUX" S)
	 <TELL "You can't drink that!" CR>>

<ROUTINE V-DRINK-FROM ()
	 <TELL "How peculiar!" CR>>

<ROUTINE PRE-DROP ()
	 <COND (<EQUAL? ,PRSO <LOC ,WINNER>>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)>>

<ROUTINE V-DROP ()
	 <COND (<IDROP>
		<TELL "Dropped." CR>)>>

<ROUTINE V-EAT ()
	 <TELL "It seems unlikely that ">
	 <ARTICLE ,PRSO T>
	 <TELL D ,PRSO " would agree with you." CR>>

<ROUTINE V-ENTER ("AUX" VEHICLE)
	 <COND (<SET VEHICLE <FIND-IN ,HERE ,VEHBIT>>
		<PERFORM ,V?BOARD .VEHICLE>
		<RTRUE>)
	       (T
		<DO-WALK ,P?IN>)>>

<ROUTINE PRE-EXAMINE ()
	 <COND (<NOT ,LIT>
		<TOO-DARK>)>>

<ROUTINE V-EXAMINE ()
	 <COND (<GETP ,PRSO ,P?TEXT>
		<PERFORM ,V?READ ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSO ,DOORBIT>
		<V-LOOK-INSIDE>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <V-LOOK-INSIDE>)
		      (T
		       <TELL "It's closed." CR>)>)
	       (T
		<TELL "You see nothing special about ">
		<ARTICLE ,PRSO T>
		<TELL D ,PRSO "." CR>)>>

<ROUTINE V-EXIT ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (T
		<DO-WALK ,P?OUT>)>>

<ROUTINE V-FILL ()
	 <COND (<NOT ,PRSI>
		<TELL "There's nothing to fill it with." CR>)
	       (T 
		<TELL "Huh?" CR>)>>

<ROUTINE V-FIND ("OPTIONAL" (WHERE <>) "AUX" (L <LOC ,PRSO>))
	 <COND (<EQUAL? ,PRSO ,HANDS>
		<TELL
"Within six feet of your head, assuming you haven't left that somewhere." CR>)
	       (<EQUAL? ,PRSO ,ME>
		<TELL "You're around here somewhere..." CR>)
	       (<IN? ,PRSO ,PROTAGONIST>
		<TELL "You have it!" CR>)
	       (<OR <IN? ,PRSO ,HERE>
		    <EQUAL? ,PRSO ,PSEUDO-OBJECT>>
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <TELL "He's">)
		      (T
		       <TELL "It's">)>
		<TELL " right in front of you." CR>)
	       (<IN? ,PRSO ,LOCAL-GLOBALS>
		<TELL "You're the adventurer!" CR>)
	       (<AND <FSET? .L ,ACTORBIT>
		     <VISIBLE? .L>>
		<TELL "As far as you can tell, ">
		<ARTICLE .L T>
		<TELL D .L " has it." CR>)
	       (<AND <FSET? .L ,CONTBIT>
		     <VISIBLE? .L>>
		<TELL "It's in ">
		<ARTICLE .L T>
		<TELL D .L "." CR>)
	       (.WHERE
		<TELL "Beats me." CR>)
	       (T
		<TELL "You'll have to do that yourself." CR>)>>

<ROUTINE V-FIRST-LOOK ()
	 <COND (<DESCRIBE-ROOM>
		<COND (<NOT ,SUPER-BRIEF>
		       <DESCRIBE-OBJECTS>)>)>>

<ROUTINE V-FOLLOW ()
	 <COND (<IN? ,PRSO ,HERE>
		<TELL "But ">
		<ARTICLE ,PRSO T>
		<TELL D ,PRSO " is right here!" CR>)
	       (T
		<V-SIT>)>>

<ROUTINE PRE-GIVE ()
	 <COND (<NOT <HELD? ,PRSO>>
		<TELL 
"That's easy for you to say since you don't even have it." CR>)>>

<ROUTINE V-GIVE ()
	 <COND (<FSET? ,PRSI ,ACTORBIT>
		<TELL "Politely, ">
		<ARTICLE ,PRSI T>
		<TELL D ,PRSI " refuses your offer." CR>)
	       (T
		<TELL "You can't give ">
		<ARTICLE ,PRSO>
		<TELL D ,PRSO " to ">
		<ARTICLE ,PRSI>
		<TELL D ,PRSI "!" CR>)>>

<ROUTINE V-HELLO ()
       <COND (,PRSO
	      <COND (<FSET? ,PRSO ,ACTORBIT>
		     <TELL "Silently, ">
		     <ARTICLE ,PRSO T>
		     <TELL D ,PRSO " bows his head to you in greeting." CR>)
		    (T
		     <TELL "Only schizophrenics say \"Hello\" to ">
		     <ARTICLE ,PRSO>
		     <TELL D ,PRSO "." CR>)>)
	     (T
	      <TELL <PICK-ONE ,HELLOS> CR>)>>

<GLOBAL HELLOS
	<PLTABLE
	 "Hello."
	 "Nice weather we've been having lately."
	 "Good-bye.">>

<ROUTINE V-HELP ()
	 <TELL
"If you're really stuck, maps and InvisiClues hint booklets are available.
If you have misplaced the order form that came in your package, send us a 
note at:|
    P.O. Box 620|
    Garden City, NY 11530|
and we'll be happy to send you an order form." CR>>

<ROUTINE V-HIDE ()
	 <COND (<NOT ,PRSO>
		<TELL "There's no place to hide here." CR>
		<RFATAL>)
	       (<AND ,PRSI <FSET? ,PRSI ,ACTORBIT>>
		<TELL "Why hide it when ">
		<ARTICLE ,PRSI T>
		<TELL D ,PRSI " isn't interested in it." CR>)
	       (<NOT ,PRSI>
		<TELL "From what? From whom? Why?" CR>)>>

<ROUTINE V-INFLATE ()
	 <TELL "How can you inflate that?" CR>>

<ROUTINE V-KICK ()
	 <HACK-HACK "Kicking">>

<ROUTINE V-KILL ()
	 <COND (<NOT <FSET? ,PRSO ,ACTORBIT>>
		<TELL "I've known strange people, but fighting ">
		<ARTICLE ,PRSO>
		<TELL D ,PRSO "?" CR>)
	       (<OR <NOT ,PRSI>
		    <EQUAL? ,PRSI ,HANDS>>
		<TELL "Attacking ">
		<ARTICLE ,PRSO>
		<TELL D ,PRSO " with your bare hands is suicidal." CR>)
	       (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<TELL "Attacking ">
		<ARTICLE ,PRSO>
		<TELL D ,PRSO " with ">
		<ARTICLE ,PRSI>
		<TELL D ,PRSI " is suicidal." CR>)
	       (T
	        <TELL "Agilely, ">
		<ARTICLE ,PRSO T>
		<TELL D ,PRSO " dodges your blow." CR>)>>

<ROUTINE V-KNOCK ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<TELL "Nobody's home." CR>)
	       (T
		<TELL "Why knock on ">
		<ARTICLE ,PRSO>
		<TELL D ,PRSO "?" CR>)>>

<ROUTINE V-KISS ()
	 <TELL "I'd sooner kiss a pig." CR>>

<ROUTINE V-LAMP-OFF ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<NOT <FSET? ,PRSO ,ONBIT>>
		       <TELL "It is already off." CR>)
		      (T
		       <FCLEAR ,PRSO ,ONBIT>
		       <COND (,LIT
			      <SETG LIT <LIT? ,HERE>>)>
		       <TELL "Okay, ">
		       <ARTICLE ,PRSO T>
		       <TELL D ,PRSO " is now off." CR>
		       <COND (<NOT <SETG LIT <LIT? ,HERE>>>
			      <NOW-BLACK>
			      <CRLF>)>)>)
	       (T
		<TELL "You can't turn that off." CR>)>
	 <RTRUE>>

<ROUTINE V-LAMP-ON ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<FSET? ,PRSO ,ONBIT>
		       <TELL "It is already on." CR>)
		      (T
		       <FSET ,PRSO ,ONBIT>
		       <TELL "Okay, ">
		       <ARTICLE ,PRSO T>
		       <TELL D ,PRSO " is now on." CR>
		       <COND (<NOT ,LIT>
			      <SETG LIT <LIT? ,HERE>>
			      <CRLF>
			      <V-LOOK>)>)>)
	       (T
		<TELL "You can't turn that on." CR>)>
	 <RTRUE>>

<ROUTINE V-LAND ()
	 <TELL "You can't land that." CR>>

<ROUTINE V-LAUNCH ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<TELL "You can't launch that by saying \"launch\"!" CR>)
	       (T
		<TELL "Huh?" CR>)>>

<ROUTINE V-LEAP ()
	 <COND (,PRSO
		<COND (<IN? ,PRSO ,HERE>
		       <V-SKIP>)
		      (T
		       <TELL "That would be a good trick." CR>)>)
	       (<EQUAL? ,HERE ,THE-ROOM>
		<JIGS-UP
"This was not a safe place to try jumping. You should have looked
before you leaped.">)
	       (T
		<V-SKIP>)>>

<ROUTINE V-LEAVE ()
	 <DO-WALK ,P?OUT>>

<ROUTINE V-LIE-DOWN ()
	 <PERFORM ,V?LIE-DOWN ,GROUND>
	 <RTRUE>>

<ROUTINE V-LISTEN ()
	 <TELL "At the moment, ">
	 <ARTICLE ,PRSO T>
	 <TELL D ,PRSO " makes no sound." CR>>

<ROUTINE V-LOCK ()
	 <TELL <PICK-ONE ,YUKS> CR>>

<ROUTINE V-LOOK ()
	 <COND (<DESCRIBE-ROOM T>
		<DESCRIBE-OBJECTS T>)>>

<ROUTINE V-LOOK-BEHIND ()
	 <TELL "There is nothing behind ">
	 <ARTICLE ,PRSO T>
	 <TELL D ,PRSO "." CR>>

<ROUTINE V-LOOK-DOWN ()
	 <COND (<NOT ,LIT>
		<TOO-DARK>)
	       (<EQUAL? ,PRSO ,ROOMS>
		<PERFORM ,V?EXAMINE ,GROUND>
		<RTRUE>)
	       (T
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LOOK-INSIDE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "There is nothing special to be seen." CR>)
	       (<FSET? ,PRSO ,SURFACEBIT>
		<COND (<FIRST? ,PRSO>
		       <PRINT-CONT ,PRSO>)
		      (T
		       <TELL "There is nothing on ">
		       <ARTICLE ,PRSO T>
		       <TELL D ,PRSO "." CR>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<TELL "All you can tell is that ">
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <ARTICLE ,PRSO T>
		       <TELL D ,PRSO " is open.">)
		      (T
		       <ARTICLE ,PRSO T>
		       <TELL D ,PRSO " is closed.">)>
		<CRLF>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<EQUAL? ,PRSO <LOC ,WINNER>>
		       <MOVE ,PROTAGONIST ,ROOMS>
		       <COND (<FIRST? ,PRSO>
			      <PRINT-CONT ,PRSO>)
			     (T
			      <TELL "It's empty (not counting you)." CR>)>
		       <MOVE ,PROTAGONIST ,PRSO>)
		      (<SEE-INSIDE? ,PRSO>
		       <COND (<FIRST? ,PRSO>
			      <PRINT-CONT ,PRSO>)
			     (T
			      <TELL "It's empty." CR>)>)
		      (<AND <NOT <FSET? ,PRSO ,OPENBIT>>
			    <FIRST? ,PRSO>>
		       <PERFORM ,V?OPEN ,PRSO>
		       <RTRUE>)
		      (T
		       <TELL "It seems that ">
		       <ARTICLE ,PRSO T>
		       <TELL D ,PRSO " is closed." CR>)>)
	       (T
		<TELL "You can't look inside ">
		<ARTICLE ,PRSO>
		<TELL D ,PRSO "." CR>)>>

<ROUTINE V-LOOK-UNDER ()
	 <COND (<HELD? ,PRSO>
		<COND (<FSET? ,PRSO ,WORNBIT>
		       <TELL "You're wearing it!" CR>)
		      (T
		       <TELL "You're holding it!" CR>)>)
	       (T
		<TELL "There is nothing but dust there." CR>)>>

<ROUTINE V-LOWER ()
	 <V-RAISE>>

<ROUTINE V-MELT ()
	 <TELL "I'm not sure that ">
	 <ARTICLE ,PRSO>
	 <TELL D ,PRSO " can be melted." CR>>

<ROUTINE V-MOVE ()
	 <COND (<HELD? ,PRSO>
		<TELL "Why juggle objects?" CR>)
	       (<FSET? ,PRSO ,TAKEBIT>
		<TELL "Moving ">
		<ARTICLE ,PRSO T>
		<TELL D ,PRSO " reveals nothing." CR>)
	       (T
		<TELL "You can't move ">
		<ARTICLE ,PRSO T>
		<TELL D ,PRSO "." CR>)>>

<ROUTINE V-MUNG ()
	 <HACK-HACK "Trying to break">>

<ROUTINE V-OPEN ("AUX" F STR)
	 <COND (<AND <NOT <FSET? ,PRSO ,CONTBIT>>
		     <NOT <FSET? ,PRSO ,DOORBIT>>>
		<TELL "You must tell me how to do that to ">
		<ARTICLE ,PRSO>
		<TELL D ,PRSO "." CR>)
	       (<EQUAL? ,PRSO ,ACTORBIT>
		<TELL "Huh?" CR>)
	       (<NOT <EQUAL? <GETP ,PRSO ,P?CAPACITY> 0>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <ALREADY-OPEN>)
		      (T
		       <FSET ,PRSO ,OPENBIT>
		       <FSET ,PRSO ,TOUCHBIT>
		       <COND (<OR <NOT <FIRST? ,PRSO>>
				  <FSET? ,PRSO ,TRANSBIT>>
			      <TELL "Opened." CR>)
			     (<AND <SET F <FIRST? ,PRSO>>
				   <NOT <NEXT? .F>>
				   <SET STR <GETP .F ,P?FDESC>>>
			      <TELL "Okay, ">
			      <ARTICLE ,PRSO T>
			      <TELL D ,PRSO " is now open." CR>
			      <TELL .STR CR>)
			     (T
			      <TELL "Opening ">
			      <ARTICLE ,PRSO T>
			      <TELL D ,PRSO " reveals ">
			      <PRINT-CONTENTS ,PRSO>
			      <TELL "." CR>)>)>)
	       (T ;"door"
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <ALREADY-OPEN>)
		      (T
		       <TELL "Okay, ">
		       <ARTICLE ,PRSO T>
		       <TELL D ,PRSO " is now open." CR>
		       <FSET ,PRSO ,OPENBIT>)>)>>

<ROUTINE V-PICK ()
	 <TELL "You can't pick that!" CR>>

<ROUTINE V-PLUG ()
	 <TELL "This has no effect." CR>>

<ROUTINE V-POINT ()
	 <TELL "It's usually impolite to point." CR>>

<ROUTINE V-POUR ()
	 <TELL "You can't pour that!" CR>>

<ROUTINE V-PUSH ()
	 <HACK-HACK "Pushing">>

<ROUTINE V-PUSH-TO ()
	 <TELL "You can't push things to that." CR>>

<ROUTINE PRE-PUT ()
	 <COND (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
		    <NOT <FSET? ,PRSO ,TAKEBIT>>>
		<TELL "Nice try." CR>)>>

<ROUTINE V-PUT ()
	 <COND (<AND <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,DOORBIT>>
		     <NOT <FSET? ,PRSI ,CONTBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>
		     <NOT <FSET? ,PRSI ,VEHBIT>>>
		<TELL "You can't do that." CR>
		<RTRUE>)
	       (<AND <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>>
		<TELL "Inspection reveals that ">
		<ARTICLE ,PRSI T>
		<TELL D ,PRSI " isn't open." CR>
		<THIS-IS-IT ,PRSI>)
	       (<EQUAL? ,PRSI ,PRSO>
		<TELL "How can you do that?" CR>)
	       (<IN? ,PRSO ,PRSI>
		<TELL "I think ">
		<ARTICLE ,PRSO T>
		<TELL D ,PRSO " is already in ">
		<ARTICLE ,PRSI T>
		<TELL D ,PRSI "." CR>)
	       (<G? <- <+ <WEIGHT ,PRSI> <WEIGHT ,PRSO>>
		       <GETP ,PRSI ,P?SIZE>>
		    <GETP ,PRSI ,P?CAPACITY>>
		<TELL "There's no room." CR>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <EQUAL? <ITAKE> ,M-FATAL <>>>
		<RTRUE>)
	       (T
		<MOVE ,PRSO ,PRSI>
		<FSET ,PRSO ,TOUCHBIT>
		<TELL "Done." CR>)>>

<ROUTINE V-PUT-BEHIND ()
	 <TELL "That hiding place is too obvious." CR>>

<ROUTINE V-PUT-ON ()
	 <COND (<EQUAL? ,PRSI ,ME>
		<PERFORM ,V?WEAR ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSI ,SURFACEBIT>
		<V-PUT>)
	       (T
		<TELL "There's no good surface on ">
		<ARTICLE ,PRSI T>
		<TELL D ,PRSI "." CR>)>>

<ROUTINE V-PUT-UNDER ()
         <TELL "You can't put anything under that." CR>>

<ROUTINE V-RAPE ()
	 <TELL "What a (ahem!) strange idea." CR>>

<ROUTINE V-RAISE ()
	 <HACK-HACK "Playing in this way with">>

<ROUTINE V-REACH-IN ("AUX" OBJ)
	 <COND (<OR <NOT <FSET? ,PRSO ,CONTBIT>>
		    <FSET? ,PRSO ,ACTORBIT>>
		<TELL "What a maroon!" CR>)
	       (<NOT <FSET? ,PRSO ,OPENBIT>>
		<TELL "It's not open." CR>)
	       (<OR <NOT <SET OBJ <FIRST? ,PRSO>>>
		    <FSET? .OBJ ,INVISIBLE>
		    <NOT <FSET? .OBJ ,TAKEBIT>>>
		<TELL "It's empty." CR>)
	       (T
		<TELL "You reach into ">
		<ARTICLE ,PRSO T>
		<TELL D ,PRSO " and feel something." CR>
		<RTRUE>)>>

<ROUTINE PRE-READ ()
	 <COND (<NOT ,LIT>
		<TELL "It is impossible to read in the dark." CR>)
	       (<AND ,PRSI <NOT <FSET? ,PRSI ,TRANSBIT>>>
		<TELL "How does one look through ">
		<ARTICLE ,PRSI>
		<TELL D ,PRSI "?" CR>)>>

<ROUTINE V-READ ()
	 <COND (<FSET? ,PRSO ,READBIT>
		<TELL <GETP ,PRSO ,P?TEXT> CR>)
               (T
                <TELL "How can you read ">
		<ARTICLE ,PRSO>
		<TELL D ,PRSO "?" CR>)>>

<ROUTINE V-REPLACE ()
	 <TELL "It's not in need of replacement." CR>>

<ROUTINE V-REPLY ()
	 <TELL "It is hardly likely that ">
	 <ARTICLE ,PRSO T>
	 <TELL D ,PRSO " is interested." CR>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RFATAL>>

<ROUTINE V-RUB ()
	 <HACK-HACK "Fiddling with">>

<ROUTINE V-SAY ("AUX" V)
	 <COND (<SET V <FIND-IN ,HERE ,ACTORBIT>>
		<SETG QUOTE-FLAG <>>
		<SETG P-CONT <>>
		<TELL "You must address ">
		<ARTICLE .V T>
		<TELL D .V " directly." CR>
		<RFATAL>)
	       (<EQUAL? <GET ,P-LEXV ,P-CONT> ,W?HELLO>
		<SETG QUOTE-FLAG <>>
		<RTRUE>)
	       (T
		<SETG QUOTE-FLAG <>>
		<SETG P-CONT <>>
		<PERFORM ,V?TELL ,ME>
		<RTRUE>)>>

<ROUTINE V-SEARCH ()
	 <COND (<FSET? ,PRSO ,CONTBIT>
		<COND (<NOT <FSET? ,PRSO ,OPENBIT>>
		       <TELL "You'll have to open it, first." CR>)
		      (<FIRST? ,PRSO>
		       <PRINT-CONT ,PRSO>)>)
	       (T
		<TELL "You find nothing unusual." CR>)>>

<ROUTINE V-SEND ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "Why would you send for ">
		<ARTICLE ,PRSO T>
		<TELL D ,PRSO "?" CR>)
	       (T
		<TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE V-SGIVE ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SHAKE ("AUX" X)
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "Be real." CR>)
	       (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<TELL "You can't take it; thus, you can't shake it!" CR>)
	       (T
		<TELL "There's no point in shaking that." CR>)>>

<ROUTINE V-SHARPEN ()
	 <TELL "You'll never sharpen anything with that!" CR>>

<ROUTINE V-SHOOT ()
	 <TELL
"Don't ever bother applying for a job as an armaments expert." CR>>

<ROUTINE V-SHOW ()
	 <TELL "I doubt ">
	 <ARTICLE ,PRSI T>
	 <TELL D ,PRSI " is interested." CR>>

<ROUTINE V-SIT ()
	 <TELL "That would be a waste of time." CR>>

<ROUTINE V-SKIP ()
	 <TELL "Wasn't that fun?" CR>>

<ROUTINE V-SLEEP ("OPTIONAL" (TOLD? <>))
	 <TELL "You're not tired." CR>>

<ROUTINE V-SMELL ()
	 <TELL "It smells just like ">
	 <ARTICLE ,PRSO>
	 <TELL D ,PRSO "." CR>>

<ROUTINE V-SPIN ()
	 <TELL "You can't spin that!" CR>>

<ROUTINE V-SQUEEZE ()
	 <TELL "How singularly useless." CR>>

<ROUTINE PRE-SSHOW ()
	 <PERFORM ,V?SHOW ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SSHOW ()
	 <V-SGIVE>>

<ROUTINE V-STAND ()
	 <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
		<PERFORM ,V?DISEMBARK <LOC ,WINNER>>
		<RTRUE>)
	       (T
		<TELL "You are already standing." CR>)>>

<ROUTINE V-STAND-ON ()
	 <V-SIT>>

<ROUTINE V-STRIKE ()
	 <PERFORM ,V?KILL ,PRSO>
	 <RTRUE>>

<ROUTINE V-SWING ()
	 <COND (<NOT ,PRSI>
		<TELL "Whoosh!" CR>)
	       (T
		<PERFORM ,V?KILL ,PRSI ,PRSO>
		<RTRUE>)>>

<ROUTINE V-SWIM ()
	 <COND (,PRSO
		<PERFORM ,V?THROUGH ,PRSO>
		<RTRUE>)
	       (T
		<TELL "There's nothing to swim in!" CR>)>>

<ROUTINE PRE-TAKE ()
	 <COND (<IN? ,PRSO ,WINNER>
		<COND (<FSET? ,PRSO ,WORNBIT>
		       <TELL "You are already wearing it." CR>)
		      (T
		       <TELL "You already have it." CR>)>)
	       (<AND <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL "You can't reach inside a closed container." CR>
		<RTRUE>)
	       (,PRSI
		<COND (<EQUAL? ,PRSO ,ME>
		       <PERFORM ,V?DROP ,PRSI>
		       <RTRUE>)
		      (<NOT <EQUAL? ,PRSI <LOC ,PRSO>>>
		       <TELL "But ">
		       <ARTICLE ,PRSO T>
		       <TELL D ,PRSO " isn't in ">
		       <ARTICLE ,PRSI T>
		       <TELL D ,PRSI "." CR>)
		      (T
		       <SETG PRSI <>>
		       <RFALSE>)>)
	       (<EQUAL? ,PRSO <LOC ,WINNER>>
		<TELL "You are in it!" CR>)>>

<ROUTINE V-TAKE ()
	 <COND (<EQUAL? <ITAKE> T>
		<TELL "Taken." CR>)>>

<ROUTINE V-TAKE-OFF ()
	 <COND (<FSET? ,PRSO ,WORNBIT>
		<FCLEAR ,PRSO ,WORNBIT>
		<TELL "Okay, you're no longer wearing ">
		<ARTICLE ,PRSO T>
		<TELL D ,PRSO "." CR>)
	       (T
		<TELL "You aren't wearing that!" CR>)>>

<ROUTINE V-TASTE ()
	 <TELL "You can't do that, at least not in this game." CR>>

<ROUTINE V-TELL ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<COND (<NOT <ZERO? ,P-CONT>>
		       <SETG WINNER ,PRSO>
		       <SETG HERE <LOC ,WINNER>>)
		      (T
		       <TELL "Hmmm ... ">
		       <ARTICLE ,PRSO T>
		       <TELL D, PRSO " looks at you
expectantly, as though he thought you were about to talk." CR>)>)
	       (T
		<TELL "You can't talk to ">
		<ARTICLE ,PRSO>
		<TELL D ,PRSO "!" CR>
		<SETG QUOTE-FLAG <>>
		<SETG P-CONT <>>
		<RFATAL>)>>

<ROUTINE V-THANK ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "You do so, but ">
		<ARTICLE ,PRSO T>
		<TELL D ,PRSO " seems less than overjoyed." CR>)
	       (T
		<TELL "You're loony." CR>)>>

<ROUTINE V-THROUGH ("AUX" M)
	<COND (<FSET? ,PRSO ,DOORBIT>
	       <DO-WALK <OTHER-SIDE ,PRSO>>
	       <RTRUE>)
	      (<FSET? ,PRSO ,VEHBIT>
	       <PERFORM ,V?BOARD ,PRSO>
	       <RTRUE>)
	      (<NOT <FSET? ,PRSO ,TAKEBIT>>
	       <TELL "You hit your head against ">
	       <ARTICLE ,PRSO T>
	       <TELL D ,PRSO " as you attempt this feat." CR>)
	      (<IN? ,PRSO ,WINNER>
	       <TELL "That would involve quite a contortion!" CR>)
	      (T
	       <TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE V-THROW ()
	 <COND (<IDROP>
		<TELL "Thrown." CR>)>>

<ROUTINE V-THROW-OFF ()
	 <TELL "You can't throw anything off that!" CR>>

<ROUTINE V-TIE ()
	 <TELL "You can't tie ">
	 <ARTICLE ,PRSO T>
	 <TELL D ,PRSO " to that." CR>>

<ROUTINE V-TIE-UP ()
	 <TELL "You could certainly never tie it with that!" CR>>

<ROUTINE V-TURN ()
	 <TELL "This has no effect." CR>>

<ROUTINE V-UNLOCK ()
	 <V-LOCK>>

<ROUTINE V-UNTIE ()
	 <TELL "This cannot be tied, so it cannot be untied!" CR>>

<ROUTINE V-WALK ("AUX" PT PTS STR OBJ RM)
	 #DECL ((PT) <OR FALSE TABLE> (PTS) FIX (STR) <OR STRING FALSE>
		(OBJ) OBJECT (RM) <OR FALSE OBJECT>)
	 <COND (<NOT ,P-WALK-DIR>
		<PERFORM ,V?WALK-TO ,PRSO>
		<RTRUE>)
	       (<SET PT <GETPT ,HERE ,PRSO>>
		<COND (<EQUAL? <SET PTS <PTSIZE .PT>> ,UEXIT>
		       <GOTO <GETB .PT ,REXIT>>)
		      (<EQUAL? .PTS ,NEXIT>
		       <TELL <GET .PT ,NEXITSTR> CR>
		       <RFATAL>)
		      (<EQUAL? .PTS ,FEXIT>
		       <COND (<SET RM <APPLY <GET .PT ,FEXITFCN>>>
			      <GOTO .RM>)
			     (T
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,CEXIT>
		       <COND (<VALUE <GETB .PT ,CEXITFLAG>>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,CEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <CANT-GO>
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,DEXIT>
		       <COND (<FSET? <SET OBJ <GETB .PT ,DEXITOBJ>> ,OPENBIT>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,DEXITSTR>>
			      <TELL .STR CR>
			      <THIS-IS-IT .OBJ>
			      <RFATAL>)
			     (T
			      <TELL "The " D .OBJ " is closed." CR>
			      <THIS-IS-IT .OBJ>
			      <RFATAL>)>)>)
	       (T
		<CANT-GO>
		<RFATAL>)>>

<ROUTINE V-WALK-AROUND ()
	 <TELL "Did you have any particular direction in mind?" CR>>

<ROUTINE V-WALK-TO ()
	 <COND (<OR <IN? ,PRSO ,HERE>
		    <GLOBAL-IN? ,PRSO ,HERE>>
		<TELL "It's here!" CR>)
	       (T
		<V-WALK-AROUND>)>>

<ROUTINE V-WAIT ("OPTIONAL" (NUM 3))
	 #DECL ((NUM) FIX)
	 <TELL "Time passes..." CR>
	 <REPEAT ()
		 <COND (<L? <SET NUM <- .NUM 1>> 0>
			<RETURN>)
		       (<CLOCKER>
			<RETURN>)>>
	 <SETG CLOCK-WAIT T>>

<ROUTINE V-WAIT-FOR ()
	 <COND (<EQUAL? <LOC ,PRSO> ,HERE ,WINNER>
		<TELL "It's already here!" CR>)
	       (T
		<TELL "You will probably be waiting quite a while." CR>)>>

<ROUTINE V-WAVE ()
	 <HACK-HACK "Waving">>

<ROUTINE V-WAVE-AT ()
	 <TELL "Despite your friendly nature, ">
	 <ARTICLE ,PRSO T>
	 <TELL D ,PRSO " isn't likely to respond." CR>>

<ROUTINE V-WEAR ()
	 <COND (<NOT <FSET? ,PRSO ,WEARBIT>>
		<TELL "You can't wear ">
		<ARTICLE ,PRSO T>
		<TELL D ,PRSO "." CR>)
	       (<FSET? ,PRSO ,WORNBIT>
		<TELL "You're already wearing ">
		<ARTICLE ,PRSO T>
		<TELL D ,PRSO "!" CR>)
	       (T
		<MOVE ,PRSO ,PROTAGONIST>
		<FSET ,PRSO ,WORNBIT>
		<TELL "You are now wearing ">
		<ARTICLE ,PRSO T>
		<TELL D, PRSO "!" CR>)>>

<ROUTINE V-WHAT ()
	 <TELL "Good question." CR>>

<ROUTINE V-WHAT-ABOUT ()
	 <TELL "Well, what about it?" CR>>

<ROUTINE V-WHERE ()
	 <V-FIND T>>

<ROUTINE V-WHO ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?WHAT ,PRSO>
		<RTRUE>)
	       (T
		<TELL "That's not a person!" CR>)>>

<ROUTINE V-WHY ()
	 <COND (<PROB 50>
		<TELL "Why not?" CR>)
	       (T
		<TELL "Because." CR>)>>

<ROUTINE V-YELL ()
	 <TELL "You begin to get a sore throat." CR>>

^\L

;"subtitle object manipulation"

<GLOBAL FUMBLE-NUMBER 7>

<GLOBAL FUMBLE-PROB 8>

<ROUTINE ITAKE ("OPTIONAL" (VB T) "AUX" CNT OBJ)
	 #DECL ((VB) <OR ATOM FALSE> (CNT) FIX (OBJ) OBJECT)
	 <COND (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<COND (.VB
		       <TELL <PICK-ONE ,YUKS> CR>)>
		<RFALSE>)
	       (<AND <NOT <IN? <LOC ,PRSO> ,WINNER>>
		     <G? <+ <WEIGHT ,PRSO> <WEIGHT ,WINNER>> ,LOAD-ALLOWED>>
		<COND (.VB
		       <COND (<FIRST? ,PROTAGONIST>
			      <TELL "Your load is too heavy">)
			     (T
			      <TELL "It's a little too heavy">)>
		       <COND (<L? ,LOAD-ALLOWED ,LOAD-MAX>
			      <TELL
", especially in light of your exhaustion.">)
			     (T
			      <TELL ".">)>
		       <CRLF>)>
		<RFATAL>)
	       (<AND <G? <SET CNT <CCOUNT ,WINNER>> ,FUMBLE-NUMBER>
		     <PROB <* .CNT ,FUMBLE-PROB>>>
		<COND (.VB
		       <TELL "You're holding too many things already." CR>)>
		<RFATAL>)
	       (T
		<MOVE ,PRSO ,WINNER>
		<FSET ,PRSO ,TOUCHBIT>
		<RTRUE>)>>

<ROUTINE IDROP ()
	 <COND (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <IN? <LOC ,PRSO> ,WINNER>>>
		<TELL "You're not carrying ">
		<ARTICLE ,PRSO T>
		<TELL D ,PRSO "." CR>
		<RFALSE>)
	       (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL "Impossible since ">
		<ARTICLE ,PRSO T>
		<TELL D ,PRSO " is closed." CR>
		<RFALSE>)
	       (T
		<MOVE ,PRSO <LOC ,WINNER>>
		<RTRUE>)>>

<ROUTINE CCOUNT (OBJ "AUX" (CNT 0) X)
	 <COND (<SET X <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<NOT <FSET? .X ,WORNBIT>>
			       <SET CNT <+ .CNT 1>>)>
			<COND (<NOT <SET X <NEXT? .X>>>
			       <RETURN>)>>)>
	 .CNT>

;"WEIGHT: Gets sum of SIZEs of supplied object, recursing to nth level."

<ROUTINE WEIGHT (OBJ "AUX" CONT (WT 0))
	 #DECL ((OBJ) OBJECT (CONT) <OR FALSE OBJECT> (WT) FIX)
	 <COND (<SET CONT <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<AND <EQUAL? .OBJ ,PLAYER>
				    <FSET? .CONT ,WORNBIT>>
			       <SET WT <+ .WT 1>>)
			      (T <SET WT <+ .WT <WEIGHT .CONT>>>)>
			<COND (<NOT <SET CONT <NEXT? .CONT>>> <RETURN>)>>)>
	 <+ .WT <GETP .OBJ ,P?SIZE>>>

^\L

;"subtitle describers"

<ROUTINE DESCRIBE-ROOM ("OPTIONAL" (LOOK? <>) "AUX" V? STR AV)
	 <SET V? <OR .LOOK? ,VERBOSE>>
	 <COND (<NOT ,LIT>
		<TELL "It is pitch black.">
		<CRLF>
		<RETURN <>>)>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<FSET ,HERE ,TOUCHBIT>
		<SET V? T>)>
	 <COND (<IN? ,HERE ,ROOMS>
		<TELL D ,HERE>
		<COND (<NOT <FSET? <LOC ,PROTAGONIST> ,VEHBIT>>
		       <CRLF>)>)>
	 <COND (<OR .LOOK?
		    <NOT ,SUPER-BRIEF>>
		<SET AV <LOC ,WINNER>>
		<COND (<FSET? .AV ,VEHBIT>
		       <TELL ", in the " D .AV CR>)>
		<COND (<AND .V? <APPLY <GETP ,HERE ,P?ACTION> ,M-LOOK>>
		       <RTRUE>)
		      (<AND .V? <SET STR <GETP ,HERE ,P?LDESC>>>
		       <TELL .STR CR>)
		      (T
		       <APPLY <GETP ,HERE ,P?ACTION> ,M-FLASH>)>
		<COND (<AND <NOT <EQUAL? ,HERE .AV>>
			    <FSET? .AV ,VEHBIT>>
		       <APPLY <GETP .AV ,P?ACTION> ,M-LOOK>)>)>
	 T>

<ROUTINE DESCRIBE-OBJECTS ("OPTIONAL" (V? <>))
	 <COND (,LIT
		<COND (<FIRST? ,HERE>
		       <PRINT-CONT ,HERE <SET V? <OR .V? ,VERBOSE>> -1>)>)
	       (T
		<TOO-DARK>)>>

"DESCRIBE-OBJECT -- takes object and flag.  if flag is true will print a
long description (fdesc or ldesc), otherwise will print short."

<GLOBAL DESC-OBJECT <>>

<ROUTINE DESCRIBE-OBJECT (OBJ V? LEVEL "AUX" (STR <>) AV)
	 <SETG DESC-OBJECT .OBJ>
	 <COND (<AND <0? .LEVEL>
		     <APPLY <GETP .OBJ ,P?DESCFCN> ,M-OBJDESC>>
		<RTRUE>)
	       (<AND <0? .LEVEL>
		     <OR <AND <NOT <FSET? .OBJ ,TOUCHBIT>>
			      <SET STR <GETP .OBJ ,P?FDESC>>>
			 <SET STR <GETP .OBJ ,P?LDESC>>>>
		<TELL .STR>)
	       (<0? .LEVEL>
		<TELL "There is ">
		<ARTICLE .OBJ>
		<TELL D .OBJ " here">
		<COND (<FSET? .OBJ ,ONBIT>
		       <TELL " (providing light)">)>
		<TELL ".">)
	       (T
		<TELL <GET ,INDENTS .LEVEL>>
		<ARTICLE .OBJ>
		<TELL D .OBJ>)>
	 <COND (<AND <0? .LEVEL>
		     <SET AV <LOC ,WINNER>>
		     <FSET? .AV ,VEHBIT>>
		<TELL " (outside the " D .AV ")">)>
	 <CRLF>
	 <COND (<AND <SEE-INSIDE? .OBJ> <FIRST? .OBJ>>
		<PRINT-CONT .OBJ .V? .LEVEL>)>>

<ROUTINE PRINT-CONT (OBJ "OPTIONAL" (V? <>) (LEVEL 0)
		     "AUX" Y 1ST? AV STR (PV? <>) (INV? <>))
	 #DECL ((OBJ) OBJECT (LEVEL) FIX)
	 <COND (<NOT <SET Y <FIRST? .OBJ>>>
		<RTRUE>)>
	 <COND (<AND <SET AV <LOC ,WINNER>>
		     <FSET? .AV ,VEHBIT>>
		T)
	       (T
		<SET AV <>>)>
	 <SET 1ST? T>
	 <COND (<EQUAL? ,WINNER .OBJ <LOC .OBJ>>
		<SET INV? T>)
	       (T
		<REPEAT ()
			<COND (<NOT .Y>
			       <RETURN <NOT .1ST?>>)
			      (<EQUAL? .Y .AV>
			       <SET PV? T>)
			      (<EQUAL? .Y ,WINNER>)
			      (<AND <NOT <FSET? .Y ,INVISIBLE>>
				    <NOT <FSET? .Y ,TOUCHBIT>>
				    <SET STR <GETP .Y ,P?FDESC>>>
			       <COND (<NOT <FSET? .Y ,NDESCBIT>>
				      <TELL .STR CR>)>
			       <COND (<AND <SEE-INSIDE? .Y>
					   <NOT <GETP <LOC .Y> ,P?DESCFCN>>
					   <FIRST? .Y>>
				      <PRINT-CONT .Y .V? 0>)>)>
			<SET Y <NEXT? .Y>>>)>
	 <SET Y <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .Y>
			<COND (<AND .PV? .AV <FIRST? .AV>>
			       <PRINT-CONT .AV .V? .LEVEL>)>
			<RETURN <NOT .1ST?>>)
		       (<EQUAL? .Y .AV ,PROTAGONIST>)
		       (<AND <NOT <FSET? .Y ,INVISIBLE>>
			     <OR .INV?
				 <FSET? .Y ,TOUCHBIT>
				 <NOT <GETP .Y ,P?FDESC>>>>
			<COND (<NOT <FSET? .Y ,NDESCBIT>>
			       <COND (.1ST?
				      <COND (<FIRSTER .OBJ .LEVEL>
					     <COND (<L? .LEVEL 0>
						    <SET LEVEL 0>)>)>
				      <SET LEVEL <+ 1 .LEVEL>>
				      <SET 1ST? <>>)>
			       <DESCRIBE-OBJECT .Y .V? .LEVEL>)
			      (<AND <FIRST? .Y> <SEE-INSIDE? .Y>>
			       <PRINT-CONT .Y .V? .LEVEL>)>)>
		 <SET Y <NEXT? .Y>>>>

<ROUTINE PRINT-CONTENTS (OBJ "AUX" F N (1ST? T) (IT? <>) (TWO? <>))
	 <COND (<SET F <FIRST? .OBJ>>
		<REPEAT ()
			<SET N <NEXT? .F>>
			<COND (.1ST? <SET 1ST? <>>)
			      (T
			       <TELL ", ">
			       <COND (<NOT .N>
				      <TELL "and ">)>)>
			<ARTICLE .F>
			<TELL D .F>
			<COND (<AND <NOT .IT?>
				    <NOT .TWO?>>
			       <SET IT? .F>)
			      (T
			       <SET TWO? T>
			       <SET IT? <>>)>
			<SET F .N>
			<COND (<NOT .F>
			       <COND (<AND .IT? <NOT .TWO?>>
				      <THIS-IS-IT .IT?>)>
			       <RTRUE>)>>)>>

<ROUTINE FIRSTER (OBJ LEVEL)
	 <COND (<EQUAL? .OBJ ,WINNER>
		<RTRUE>)
	       (<NOT <IN? .OBJ ,ROOMS>>
		<COND (<G? .LEVEL 0>
		       <TELL <GET ,INDENTS .LEVEL>>)>
		<COND (<FSET? .OBJ ,SURFACEBIT>
		       <TELL "Sitting on the " D .OBJ " is:" CR>)
		      (<FSET? .OBJ ,ACTORBIT>
		       <TELL "It looks like ">
		       <ARTICLE .OBJ T>
		       <TELL D .OBJ " is holding:" CR>)
		      (T
		       <TELL "The " D .OBJ " contains:" CR>)>)>>

^\L

;"subtitle movement"

<CONSTANT REXIT 0>
<CONSTANT UEXIT 1>
<CONSTANT NEXIT 2>
<CONSTANT FEXIT 3>
<CONSTANT CEXIT 4>
<CONSTANT DEXIT 5>

<CONSTANT NEXITSTR 0>
<CONSTANT FEXITFCN 0>
<CONSTANT CEXITFLAG 1>
<CONSTANT CEXITSTR 1>
<CONSTANT DEXITOBJ 1>
<CONSTANT DEXITSTR 1>

<ROUTINE GO-NEXT (TBL "AUX" VAL)
	 #DECL ((TBL) TABLE (VAL) ANY)
	 <COND (<SET VAL <LKP ,HERE .TBL>>
		<GOTO .VAL>)>>

<ROUTINE LKP (ITM TBL "AUX" (CNT 0) (LEN <GET .TBL 0>))
	 #DECL ((ITM) ANY (TBL) TABLE (CNT LEN) FIX)
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> .LEN>
			<RFALSE>)
		       (<EQUAL? <GET .TBL .CNT> .ITM>
			<COND (<EQUAL? .CNT .LEN> <RFALSE>)
			      (T
			       <RETURN <GET .TBL <+ .CNT 1>>>)>)>>>

<ROUTINE GOTO (RM "OPTIONAL" (V? T) "AUX" OLIT OHERE)
	 <SET OHERE ,HERE>
	 <SET OLIT ,LIT>
	 <MOVE ,WINNER .RM>
	 <SETG HERE .RM>
	 <SETG LIT <LIT? ,HERE>>
	 <COND (<AND <NOT .OLIT>
		     <NOT ,LIT>
		     <PROB 80>>
		<JIGS-UP
"Oh, no! Something lurked up and devoured you!">
		<RTRUE>)>
	 <APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>
	 <COND (<NOT <EQUAL? ,HERE .RM>>
		<RTRUE>)
	       (.V?
		<V-FIRST-LOOK>)>
	 <RTRUE>>

\

;"subtitle death and stuff"

<GLOBAL MOVES 0>

<GLOBAL DEATHS 0>

<GLOBAL LUCKY 1>

<ROUTINE JIGS-UP (DESC "OPTIONAL" (STARVED <>))
	 <COND (.DESC 
		<TELL .DESC CR>)>
	 <KILL-INTERRUPTS>	       
	 <TELL "
|
    ****  You have died  ****|
|">
	 <FINISH>>

<ROUTINE RANDOMIZE-OBJECTS ("AUX" (F <FIRST? ,WINNER>) N)
	 <REPEAT ()
		 <COND (.F
			<SET N <NEXT? .F>>
			<MOVE .F ,HERE>
			<SET F .N>)
		       (T
			<RETURN>)>>
	 <RTRUE>>

<ROUTINE KILL-INTERRUPTS ()
	 <RTRUE>>

^\L

;"subtitle useful utility routines"

<ROUTINE THIS-IS-IT (OBJ)
	 <SETG P-IT-OBJECT .OBJ>
	 ;<SETG P-IT-LOC ,HERE>>

<ROUTINE IN-HERE? (OBJ)
	 <OR <IN? .OBJ ,HERE>
	     <GLOBAL-IN? .OBJ ,HERE>>>

<ROUTINE OTHER-SIDE (DOBJ "AUX" (P 0) T) ;"finds room on others side of door"
	 <REPEAT ()
		 <COND (<L? <SET P <NEXTP ,HERE .P>> ,LOW-DIRECTION>
			<RETURN <>>)
		       (T
			<SET T <GETPT ,HERE .P>>
			<COND (<AND <EQUAL? <PTSIZE .T> ,DEXIT>
				    <EQUAL? <GETB .T ,DEXITOBJ> .DOBJ>>
			       <RETURN .P>)>)>>>

<ROUTINE NOTHING-HELD? ("AUX" X N)
	 <SET X <FIRST? ,PROTAGONIST>>
	 <REPEAT ()
		 <COND (.X
			<COND (<NOT <FSET? .X ,WORNBIT>>
			       <RFALSE>)>
			<SET X <NEXT? .X>>)
		       (T
			<RTRUE>)>>>

<ROUTINE HELD? (OBJ)
	 <COND (<NOT .OBJ> <RFALSE>)
	       (<IN? .OBJ ,WINNER> <RTRUE>)
	       (<IN? .OBJ ,ROOMS> <RFALSE>)
	       (<IN? .OBJ ,GLOBAL-OBJECTS> <RFALSE>)
	       (T <HELD? <LOC .OBJ>>)>>

<ROUTINE SEE-INSIDE? (OBJ)
	 <AND <NOT <FSET? .OBJ ,INVISIBLE>>
	      <OR <FSET? .OBJ ,TRANSBIT>
	          <FSET? .OBJ ,OPENBIT>>>>

<ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" T)
	 #DECL ((OBJ1 OBJ2) OBJECT (T) <OR FALSE TABLE>)
	 <COND (<SET T <GETPT .OBJ2 ,P?GLOBAL>>
		<ZMEMQB .OBJ1 .T <- <PTSIZE .T> 1>>)>>

<ROUTINE FIND-IN (WHERE WHAT "AUX" W)
	 <SET W <FIRST? .WHERE>>
	 <COND (<NOT .W>
		<RFALSE>)>
	 <REPEAT ()
		 <COND (<FSET? .W .WHAT>
			<RETURN .W>)
		       (<NOT <SET W <NEXT? .W>>>
			<RETURN <>>)>>>

<ROUTINE DO-WALK (DIR)
	 <SETG P-WALK-DIR .DIR>
	 <PERFORM ,V?WALK .DIR>>

<ROUTINE 2OBJS? ()
	 <COND (<NOT <EQUAL? <GET ,P-PRSO 0> 2>>
		<PUT ,P-PRSO 0 1>
		<TELL "That sentence doesn't make sense." CR>
		<RFALSE>)
	       (T <RTRUE>)>>

<ROUTINE ROB (WHO "OPTIONAL" (WHERE <>) (HIDE? <>) "AUX" N X (ROBBED? <>))
	 <SET X <FIRST? .WHO>>
	 <REPEAT ()
		 <COND (<NOT .X>
			<RETURN .ROBBED?>)>
		 <SET N <NEXT? .X>>
		 <COND (<RIPOFF .X .WHERE>
			<COND (.HIDE? <FSET .X ,NDESCBIT>)>
			<SET ROBBED? .X>)>
		 <SET X .N>>>

<ROUTINE BLT (WHO WHERE "AUX" N X (CNT 0))
	 <SET X <FIRST? .WHO>>
	 <REPEAT ()
		 <COND (<NOT .X> <RETURN .CNT>)>
		 <SET N <NEXT? .X>>
		 <MOVE .X .WHERE>
		 <SET CNT <+ .CNT 1>>
		 <SET X .N>>>

<ROUTINE RIPOFF (X WHERE)
	 <COND (<AND <NOT <IN? .X .WHERE>>
		     <NOT <FSET? .X ,INVISIBLE>>
		     <FSET? .X ,TOUCHBIT>
		     <FSET? .X ,TAKEBIT>>
		<COND (.WHERE <MOVE .X .WHERE>)
		      (T <MOVE .X ,ROOMS>)>
		<RTRUE>)>>

<ROUTINE WORD-TYPE (OBJ WORD "AUX" SYNS)
	 #DECL ((OBJ) OBJECT (WORD SYNS) TABLE)
	 <ZMEMQ .WORD
		<SET SYNS <GETPT .OBJ ,P?SYNONYM>>
		<- </ <PTSIZE .SYNS> 2> 1>>>

<ROUTINE HACK-HACK (STR)
	 #DECL ((STR) STRING)
	 <TELL .STR " ">
	 <ARTICLE ,PRSO T>
	 <TELL D ,PRSO <PICK-ONE ,HO-HUM> CR>>

<GLOBAL HO-HUM
	<PLTABLE
	 " doesn't do anything."
	 " accomplishes nothing."
	 " has no desirable effect.">>		 

<GLOBAL YUKS
	<PLTABLE
	 "No spell would help with that!"
	 "It would take more magic than you've got!"
	 "You can't be serious."
	 "You must have had a silliness spell cast upon you.">>

<ROUTINE OPEN-CLOSE ()
	 <COND (<AND <VERB? OPEN>
		     <FSET? ,PRSO ,OPENBIT>>
		<ALREADY-OPEN>
		<RTRUE>)
	       (<AND <VERB? CLOSE>
		     <NOT <FSET? ,PRSO ,OPENBIT>>>
		<ALREADY-CLOSED>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ARTICLE (OBJ "OPTIONAL" (THE <>))
	 <COND (<FSET? .OBJ ,NARTICLEBIT>
		<RFALSE>)
	       (.THE
		<TELL "the ">)
	       (<FSET? .OBJ ,VOWELBIT>
		<TELL "an ">)
	       (T
		<TELL "a ">)>>

<ROUTINE CANT-ENTER (LOC "OPTIONAL" (LEAVE <>))
	 <TELL "You can't ">
	 <COND (.LEAVE
		<TELL "leave ">)
	       (T
		<TELL "enter ">)>
	 <ARTICLE .LOC T>
	 <TELL D .LOC " from here." CR>>

<ROUTINE NOT-GOING-ANYWHERE (VEHICLE)
	 <TELL
"You're not going anywhere until you get out of the " D .VEHICLE "." CR>>

<ROUTINE SPLASH ()
	 <TELL "With a splash, ">
	 <ARTICLE ,PRSO T>
	 <TELL D ,PRSO " plunges into the water." CR>>

<ROUTINE LOOK-AROUND ()
	 <TELL "Look around you." CR>>

<ROUTINE TOO-DARK ()
	 <TELL "It's too dark to see!" CR>>

<ROUTINE CANT-GO ()
	 <TELL "You can't go that way." CR>>

<ROUTINE NOW-BLACK ()
	 <TELL "It is now pitch black." CR>>

<ROUTINE ALREADY-OPEN ()
	 <TELL "It is already open." CR>>

<ROUTINE ALREADY-CLOSED ()
	 <TELL "It is already closed." CR>>

<ROUTINE REFERRING ()
	 <TELL "I don't see what you're referring to." CR>>

<ROUTINE ANYMORE ()
	 <TELL "You can't see that anymore." CR>>
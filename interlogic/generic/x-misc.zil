"MISC for RAGER
Copyright (c) 1988 Infocom, Inc.  All rights reserved."

<ROUTINE GO () 
       	 <SETG MIDSCREEN </ <LOWCORE SCRH> 2>>
	 <INC MIDSCREEN>
	 <COND (<L? ,MIDSCREEN 32>
		<TELL "[Screen too narrow.]" CR>
		<QUIT>)>
	 <CLEAR -1>
	 <INIT-STATUS-LINE>
	 <CRLF>
	<V-VERSION>
	;<INTRO>
	<MAIN-LOOP>
	<AGAIN>>

<ROUTINE PRINT-THE (OBJ)	;"THE"
	<COND (<AND <EQUAL? .OBJ ,TURN> <L? 1 ,P-NUMBER>>
	       <TELL !\  N ,P-NUMBER " minutes">)
	      (<EQUAL? .OBJ ,WINDOW>
	       <TELL " the window">)
	      ;(<AND <EQUAL? .OBJ ,P-IT-OBJECT>
		    <FSET? ,IT ,TOUCHBIT>>
	       <TELL " it">
	       <RTRUE>)
	      (T
	       <THE? .OBJ>
	       <TELL !\  D .OBJ>)>
	;<THIS-IS-IT .OBJ>>

<ROUTINE THE? (OBJ)
	<COND (<NOT <FSET? .OBJ ,NARTICLEBIT>>
	       <COND (<OR ;<NOT <FSET? .OBJ ,ACTORBIT>>
			  <IN? .OBJ ,ROOMS>
			  <FSET? .OBJ ,SEENBIT>>
		      <TELL " the">)
		     (<FSET? .OBJ ,VOWELBIT>
		      <TELL " an">)
		     (T <TELL " a">)>)>
	<COND (T ;<FSET? .OBJ ,ACTORBIT>
	       <FSET .OBJ ,SEENBIT>)>>

<ROUTINE START-SENTENCE (OBJ)	;"CTHE"
	<THIS-IS-IT .OBJ>
	<COND (<EQUAL? .OBJ ,PLAYER>	<TELL "You">		<RTRUE>)
	      (<EQUAL? .OBJ ,HANDS>	<TELL "Your hand">	<RTRUE>)
	      (<EQUAL? .OBJ ,HEAD>	<TELL "Your head">	<RTRUE>)
	      (<EQUAL? .OBJ ,EYES>	<TELL "Your eyes">	<RTRUE>)
	      (<EQUAL? .OBJ ,TEETH>	<TELL "Your teeth">	<RTRUE>)
	      (<EQUAL? .OBJ ,EARS>	<TELL "Your ears">	<RTRUE>)>
	<COND (<NOT <FSET? .OBJ ,NARTICLEBIT>>
	       <COND (<OR ;<NOT <FSET? .OBJ ,ACTORBIT>>
			  <FSET? .OBJ ,SEENBIT>>
		      <TELL "The ">)
		     (<FSET? .OBJ ,VOWELBIT>
		      <TELL "An ">)
		     (T <TELL "A ">)>)>
	<COND (T ;<FSET? .OBJ ,ACTORBIT>
	       <FSET .OBJ ,SEENBIT>)>
	<TELL D .OBJ>>

<ROUTINE PRINTA (O)	;"A"
	 <COND (<OR ;<FSET? .O ,ACTORBIT> <FSET? .O ,NARTICLEBIT>> T)
	       (<FSET? .O ,VOWELBIT> <TELL "an ">)
	       (T <TELL "a ">)>
	 <TELL D .O>>

<CONSTANT P-IT-WORDS <TABLE 0 0>>	"adj & noun for IT"

<ROUTINE THIS-IS-IT (OBJ)
 <COND (<EQUAL? .OBJ <> ,NOT-HERE-OBJECT ,PLAYER>
	<RTRUE>)
       (<EQUAL? .OBJ ,INTDIR ,GLOBAL-HERE ,ROOMS>
	<RTRUE>)
       (<AND <VERB? WALK ;"WALK-TO FACE"> <==? .OBJ ,PRSO>>
	<RTRUE>)>
 <COND (<NOT <FSET? .OBJ ,ACTORBIT>>
	<PUT ,P-IT-WORDS 0 <GET ,P-ADJW ,NOW-PRSI>>
	<PUT ,P-IT-WORDS 1 <GET ,P-NAMW ,NOW-PRSI>>
	<FSET ,IT ,TOUCHBIT>	;"to cause pronoun 'it' in output"
	<SETG P-IT-OBJECT .OBJ>)
       (<FSET? .OBJ ,FEMALE>
	<FSET ,HER ,TOUCHBIT>
	<SETG P-HER-OBJECT .OBJ>)
       ;(<FSET? .OBJ ,PLURALBIT>
	<FSET ,THEM ,TOUCHBIT>
	<SETG P-THEM-OBJECT .OBJ>)
       (T
	<FSET ,HIM ,TOUCHBIT>
	<SETG P-HIM-OBJECT .OBJ>)>
 <RTRUE>>

<ROUTINE NO-PRONOUN? (OBJ "OPTIONAL" (CAP 0))
	<COND (<EQUAL? .OBJ ,PLAYER>
	       <RFALSE>)
	      (<NOT <FSET? .OBJ ,ACTORBIT>>
	       <COND (<AND <EQUAL? .OBJ ,P-IT-OBJECT>
			   <FSET? ,IT ,TOUCHBIT>>
		      <RFALSE>)>)
	      (<FSET? .OBJ ,FEMALE>
	       <COND (<AND <EQUAL? .OBJ ,P-HER-OBJECT>
			   <FSET? ,HER ,TOUCHBIT>>
		      <RFALSE>)>)
	      ;(<FSET? .OBJ ,PLURALBIT>
	       <COND (<AND <EQUAL? .OBJ ,P-THEM-OBJECT>
			   <FSET? ,THEM ,TOUCHBIT>>
		      <RFALSE>)>)
	      (T
	       <COND (<AND <EQUAL? .OBJ ,P-HIM-OBJECT>
			   <FSET? ,HIM ,TOUCHBIT>>
		      <RFALSE>)>)>
	<COND (<ZERO? .CAP> <PRINT-THE .OBJ>)
	      (<ONE? .CAP> <TELL CTHE .OBJ>)>
	<THIS-IS-IT .OBJ>
	<RTRUE>>

<ROUTINE HE-SHE-IT (OBJ "OPTIONAL" (CAP 0) (VERB <>))	;"C/HE"
	<COND (<NO-PRONOUN? .OBJ .CAP>
	       T)
	      (<NOT <FSET? .OBJ ,ACTORBIT>>
	       <COND (<ZERO? .CAP> <TELL " it">)
		     (<ONE? .CAP> <TELL "It">)>)
	      (<==? .OBJ ,PLAYER>
	       <COND (<ZERO? .CAP> <TELL " you">)
		     (<ONE? .CAP> <TELL "You">)>)
	      (<FSET? .OBJ ,FEMALE>
	       <COND (<ZERO? .CAP> <TELL " she">)
		     (<ONE? .CAP> <TELL "She">)>)
	      ;(<FSET? .OBJ ,PLURALBIT>
	       <COND (<ZERO? .CAP> <TELL " they">)
		     (<ONE? .CAP> <TELL "They">)>)
	      (T
	       <COND (<ZERO? .CAP> <TELL " he">)
		     (<ONE? .CAP> <TELL "He">)>)>
	<COND (<NOT <ZERO? .VERB>>
	       <PRINTC 32>
	       <COND (<OR <EQUAL? .OBJ ,PLAYER>
			  ;<FSET? .OBJ ,PLURALBIT>>
		      <COND (<=? .VERB "is"> <TELL "are">)
			    (<=? .VERB "has"><TELL "have">)
			    (<=? .VERB "tri"><TELL "try">)
			    (<=? .VERB "empti"><TELL "empty">)
			    (T <TELL .VERB>)>)
		     (T
		      <TELL .VERB>
		      <COND (<OR <EQUAL? .VERB "do" "kiss" "push">
				 <EQUAL? .VERB "tri" "empti">>
			     <TELL !\e>)>
		      <COND (<NOT <EQUAL? .VERB "is" "has">>
			     <TELL !\s>)>)>)>>

<ROUTINE HIM-HER-IT (OBJ "OPTIONAL" (CAP 0) (POSSESS? <>))	;"C/HIS/M"
 <COND (<NO-PRONOUN? .OBJ .CAP>
	<COND (<NOT <ZERO? .POSSESS?>> <TELL "'s">)>)
       (<NOT <FSET? .OBJ ,ACTORBIT>>
	<COND (<ZERO? .CAP> <TELL " it">) (T <TELL "It">)>
	<COND (<NOT <ZERO? .POSSESS?>> <TELL !\s>)>)
       (<==? .OBJ ,PLAYER>
	<COND (<ZERO? .CAP> <TELL " you">) (T <TELL "You">)>
	<COND (<NOT <ZERO? .POSSESS?>> <TELL !\r>)>)
       ;(<FSET? .OBJ ,PLURALBIT>
	<COND (<NOT <ZERO? .POSSESS?>>
	       <COND (<ZERO? .CAP> <TELL " their">)
		     (T <TELL "Their">)>)
	      (T
	       <COND (<ZERO? .CAP> <TELL " them">)
		     (T <TELL "Them">)>)>)
       (<FSET? .OBJ ,FEMALE>
	<COND (<ZERO? .CAP> <TELL " her">) (T <TELL "Her">)>)
       (T
	<COND (<NOT <ZERO? .POSSESS?>>
	       <COND (<ZERO? .CAP> <TELL " his">)
		     (T <TELL "His">)>)
	      (T
	       <COND (<ZERO? .CAP> <TELL " him">)
		     (T <TELL "Him">)>)>)>
 <RTRUE>>

"CLOCK for RAGER
Copyright (C) 1988 Infocom, Inc.  All rights reserved."

"List of queued routines:
"

<GLOBAL SCORE:NUMBER 0>
<GLOBAL MOVES:NUMBER 0>
<GLOBAL HERE:OBJECT THE-ROOM>
<GLOBAL OHERE:OBJECT 0>

<GLOBAL CLOCKER-RUNNING:NUMBER 0>

<CONSTANT C-TABLELEN 138>	;"and one for good measure"

<CONSTANT C-TABLE
 <TABLE 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
	0 0 I-REPLY
	1 1 I-PROMPT	;"last to run">>

<GLOBAL C-INTS:NUMBER <- 138 <* 0 6>>>
<CONSTANT C-INTLEN 6>
<CONSTANT C-ENABLED? 0>
<CONSTANT C-TICK 1>
<CONSTANT C-RTN 2>

<ROUTINE QUEUE (RTN TICK "AUX" CINT)
	 ;#DECL ((RTN) ATOM (TICK) FIX (CINT) <PRIMTYPE VECTOR>)
	 <PUT <SET CINT <INT .RTN>> ,C-TICK .TICK>
	 <PUT .CINT ,C-ENABLED? 1>
	 .CINT>

<ROUTINE INT (RTN "OPTIONAL" (DEMON <>) "AUX" E C INT)
	 ;#DECL ((RTN) ATOM (DEMON) <OR ATOM FALSE> (E C INT) <PRIMTYPE
							      VECTOR>)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<==? .C .E>
			<SETG C-INTS <- ,C-INTS ,C-INTLEN>>
			;<AND .DEMON <SETG C-DEMONS <- ,C-DEMONS ,C-INTLEN>>>
			<SET INT <REST ,C-TABLE ,C-INTS>>
			<PUT .INT ,C-RTN .RTN>
			<RETURN .INT>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN> <RETURN .C>)>
		 <SET C <REST .C ,C-INTLEN>>>>

;<ROUTINE ENABLED? (RTN)
	<NOT <ZERO? <GET <INT .RTN> ,C-ENABLED?>>>>

;<ROUTINE QUEUED? (RTN "AUX" C)
	<SET C <INT .RTN>>
	<COND (<ZERO? <GET .C ,C-ENABLED?>> <RFALSE>)
	      (T <GET .C ,C-TICK>)>>

<GLOBAL CLOCK-WAIT:FLAG <>>

<ROUTINE CLOCKER ("AUX" C E TICK (FLG <>) VAL)
	 ;#DECL ((C E) <PRIMTYPE VECTOR> (TICK) FIX ;(FLG) ;<OR FALSE ATOM>)
	 <COND (,CLOCK-WAIT <SETG CLOCK-WAIT <>> <RFALSE>)>
	 <SETG MOVES <+ ,MOVES 1>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <REPEAT ()
		 <COND (<==? .C .E>
			<RETURN .FLG>)
		       (<NOT <ZERO? <GET .C ,C-ENABLED?>>>
			<SET TICK <GET .C ,C-TICK>>
			<COND (<NOT <ZERO? .TICK>>
			       <PUT .C ,C-TICK <- .TICK 1>>
			       <COND (<AND <NOT <G? .TICK 1>>
				           <SET VAL <APPLY <GET .C ,C-RTN>>>>
				      <COND (<OR <ZERO? .FLG>
						 <==? .VAL ,M-FATAL>>
					     <SET FLG .VAL>)>)>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>

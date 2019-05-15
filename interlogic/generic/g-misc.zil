"MISC for GENERIC: (C)1985 Infocom, Inc. All Rights Reserved."

<SETG C-ENABLED? 0>

<SETG C-ENABLED 1>

<SETG C-DISABLED 0>

<ZSTR-OFF>

<DEFMAC TELL ("ARGS" A)
	<FORM PROG ()
	      !<MAPF ,LIST
		     <FUNCTION ("AUX" E P O)
			  <COND (<EMPTY? .A> <MAPSTOP>)
				(<SET E <NTH .A 1>>
				 <SET A <REST .A>>)>
			  <COND (<TYPE? .E ATOM>
				 <COND (<OR <=? <SET P <SPNAME .E>>
						"CRLF">
					    <=? .P "CR">>
					<MAPRET '<CRLF>>)
				       (<EMPTY? .A>
					<ERROR INDICATOR-AT-END? .E>)
				       (ELSE
					<SET O <NTH .A 1>>
					<SET A <REST .A>>
					<COND (<OR <=? <SET P <SPNAME .E>>
						       "DESC">
						   <=? .P "D">
						   <=? .P "OBJ">
						   <=? .P "O">>
					       <MAPRET <FORM PRINTD .O>>)
					      (<OR <=? .P "NUM">
						   <=? .P "N">>
					       <MAPRET <FORM PRINTN .O>>)
					      (<OR <=? .P "CHAR">
						   <=? .P "CHR">
						   <=? .P "C">>
					       <MAPRET <FORM PRINTC .O>>)
					      (ELSE
					       <MAPRET
						 <FORM PRINT
						       <FORM GETP .O .E>>>)>)>)
				(<TYPE? .E STRING ZSTRING>
				 <MAPRET <FORM PRINTI .E>>)
				(<TYPE? .E FORM LVAL GVAL>
				 <MAPRET <FORM PRINT .E>>)
				(ELSE <ERROR UNKNOWN-TYPE .E>)>>>>>

<DEFMAC VERB? ("ARGS" ATMS)
	<MULTIFROB PRSA .ATMS>>

<DEFMAC PRSO? ("ARGS" ATMS)
	<MULTIFROB PRSO .ATMS>>

<DEFMAC PRSI? ("ARGS" ATMS)
	<MULTIFROB PRSI .ATMS>>

<DEFMAC ROOM? ("ARGS" ATMS)
	<MULTIFROB HERE .ATMS>>

<DEFINE MULTIFROB (X ATMS "AUX" (OO (OR)) (O .OO) (L ()) ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .OO 1> <ERROR .X>)
				       (<LENGTH? .OO 2> <NTH .OO 2>)
				       (ELSE <CHTYPE .OO FORM>)>>)>
		<REPEAT ()
			<COND (<EMPTY? .ATMS> <RETURN!->)>
			<SET ATM <NTH .ATMS 1>>
			<SET L
			     (<COND (<TYPE? .ATM ATOM>
				     <CHTYPE
					   <COND (<==? .X PRSA>
						  <PARSE
						    <STRING "V?"
							    <SPNAME .ATM>>>)
						 (ELSE .ATM)> GVAL>)
				    (ELSE .ATM)>
			      !.L)>
			<SET ATMS <REST .ATMS>>
			<COND (<==? <LENGTH .L> 3> <RETURN!->)>>
		<SET O <REST <PUTREST .O
				      (<FORM EQUAL? <CHTYPE .X GVAL> !.L>)>>>
		<SET L ()>>>

<DEFMAC BSET ('OBJ "ARGS" BITS)
	<MULTIBITS FSET .OBJ .BITS>>

<DEFMAC BCLEAR ('OBJ "ARGS" BITS)
	<MULTIBITS FCLEAR .OBJ .BITS>>

<DEFMAC BSET? ('OBJ "ARGS" BITS)
	<MULTIBITS FSET? .OBJ .BITS>>

<DEFINE MULTIBITS (X OBJ ATMS "AUX" (O ()) ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .O 1> <NTH .O 1>)
				       (<EQUAL? .X FSET?> <FORM OR !.O>)
				       (ELSE <FORM PROG () !.O>)>>)>
		<SET ATM <NTH .ATMS 1>>
		<SET ATMS <REST .ATMS>>
		<SET O
		     (<FORM .X
			    .OBJ
			    <COND (<TYPE? .ATM FORM> .ATM)
				  (ELSE <CHTYPE .ATM GVAL>)>>
		      !.O)>>>

<DEFMAC RFATAL ()
	'<PROG () <PUSH 2> <RSTACK>>>

<DEFMAC PROB ('BASE?)
	<FORM NOT <FORM L? .BASE? '<RANDOM 100>>>>

; <DEFMAC PROB ('BASE? "OPTIONAL" 'LOSER?)
	<COND (<ASSIGNED? LOSER?> <FORM ZPROB .BASE?>)
	      (ELSE <FORM G? .BASE? '<RANDOM 100>>)>>

<DEFMAC ENABLE ('INT) <FORM PUT .INT ,C-ENABLED? 1>>

<DEFMAC DISABLE ('INT) <FORM PUT .INT ,C-ENABLED? 0>>

<DEFMAC OPENABLE? ('OBJ)
	<FORM OR <FORM FSET? .OBJ ',DOORBIT>
	         <FORM FSET? .OBJ ',CONTBIT>>> 

<DEFMAC ABS ('NUM)
	<FORM COND (<FORM L? .NUM 0> <FORM - 0 .NUM>)
	           (T .NUM)>>

<DEFMAC GET-REXIT-ROOM ('PT)
	<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
	       <FORM GET .PT ',REXIT>)
	      (T <FORM GETB .PT ',REXIT>)>>

<DEFMAC GET-DOOR-OBJ ('PT)
	<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
	       <FORM GET .PT ',DEXITOBJ>)
	      (T <FORM GETB .PT ',DEXITOBJ>)>>

<DEFMAC GET/B ('TBL 'PTR)
	<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
	       <FORM GET .TBL .PTR>)
	      (T <FORM GETB .TBL .PTR>)>>

<DEFMAC RMGL-SIZE ('TBL)
	<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
	       <FORM - <FORM / <FORM PTSIZE .TBL> 2> 1>)
	      (T <FORM - <FORM PTSIZE .TBL> 1>)>>

<DEFMAC IN/LOC ('LOC)
	<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
	       <LIST LOC .LOC>)
	      (T
	       <LIST IN .LOC>)>>

<DEFMAC MAKE ('OBJ 'FLAG)
	<FORM FSET .OBJ .FLAG>>

<DEFMAC IS? ('OBJ 'FLAG)
	<FORM FSET? .OBJ .FLAG>>

<DEFMAC UNMAKE ('OBJ 'FLAG)
	<FORM FCLEAR .OBJ .FLAG>>

<CONSTANT CONNECT 32>

<DEFMAC GROTCH ('FCN "OPT" ('LEN 1))
	<FORM TABLE (BYTE) <+ ,CONNECT .LEN>
	      		   </ .FCN 256>
			   <BAND .FCN 255>>>

<ZSTR-ON>

"*** ZCODE STARTS HERE ***"

"NOTE: This object MUST be the FIRST one defined (for MOBY-FIND)!"

<OBJECT DUMMY-OBJECT>

<ROUTINE FOO-F ()
	 <TELL "Hello." CR>
	 <RFALSE>>

<OBJECT FOO
	(LOC THE-ROOM)
	(DESC "foo")
	(FLAGS TAKEABLE)
	(SYNONYM FOO)
	(SIZE <GROTCH FOO-F>)>

<ROUTINE GO () 
	 %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
		 '<PROG ()
			<INIT-STATUS-LINE>
			<SETG LIT T>>)
		(T '<SETG LIT T>)>
	 <SETG WINNER ,PROTAGONIST>
	 <SETG HERE ,THE-ROOM>
	 <RESET-THEM>
	 <ENABLE <QUEUE I-PROMPT 1>>
	 <V-VERSION>
	 <CRLF>
	 <V-LOOK>
	 <DO-MAIN-LOOP>
	 <AGAIN>>

%<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
<GLOBAL SL-TABLE <ITABLE NONE 30>>	"enough for 30 characters"

<DEFINE ISL () <INIT-STATUS-LINE>>

<ROUTINE INIT-STATUS-LINE ()
	 <CLEAR -1>	;"Clear whole screen."
	 <SPLIT 1> ;"split the screen, creating a one-line window"
	 <SCREEN 1> ;"move the cursor into the window"
	 <BUFOUT <>> ;"henceforth, print everything character by character"
	 <INVERSE-LINE 1> ;"paint the status line white"
	 <HLIGHT ,H-INVERSE> ;"set the print mode to inverse video"
	 <CURSET 1 1> ;"move the cursor to the first line, first column"
	 <TELL "Location:">
	 <CURSET 1 50> ;"move the cursor to the first line, fiftieth column"
	 <TELL "Score:">
	 <CURSET 1 65> ;"move the cursor to the first line, sixty-fifth column"
	 <TELL "Turns:">
	 <BUFOUT T> ;"return to normal mode of printing things line by line"
	 <HLIGHT ,H-NORMAL> ;"return to normal print mode"
	 <SCREEN 0>>

<ROUTINE USL ("AUX" LEN)
	 <BUFOUT <>>
	 <SCREEN 1>
	 <CURSET 1 12>
	 <HLIGHT 1> ;"everything up to here should be old hat"
	 <DIROUT 1 ,SL-TABLE> ;"print stuff to that table, not the screen"
	 <TELL D ,HERE> ;"that's getting put in the table"
	 <SET LEN <GET ,SL-TABLE 0>> ;"LEN is now the # of chars. in D ,HERE"
	 <DIROUT 0> ;"return to normal mode of printing to the screen"
	 <TELL D ,HERE> ;"this time printing to the screen, not the table"
	 <PRINT-SPACES <- 24 .LEN>> ;"see routine below. This wipes out
any possible left-over characters. The longest room name is 24 characters."
	 <CURSET 1 57>
	 <TELL N ,SCORE "  "> ;"a few blanks in case the score got smaller"
	 <CURSET 1 72>
	 <TELL N ,MOVES "  "> ;"ditto"
	 <BUFOUT T>
	 <HLIGHT 0>
	 <SCREEN 0>	;"now back to normal text window"
	 ;<CURSET <- <GETB 0 32> 1> 1>>

<CONSTANT H-NORMAL 0>
<CONSTANT H-INVERSE 1>

<ROUTINE INVERSE-LINE (LIN "AUX" (CNT 79))
	 <CURSET .LIN 1>
	 <HLIGHT ,H-INVERSE>
	 <PRINT-SPACES .CNT>
	 <HLIGHT ,H-NORMAL>>

<ROUTINE PRINT-SPACES (N) ;"called by STATUS-LINE, just prints N characters."
	 <REPEAT ()
		 <COND (<L? <SET N <- .N 1>> 0>
			<RETURN>)
		       (T
			<PRINTC 32>)>>>
)>

<ROUTINE RESET-THEM ()
	 <PCLEAR>
         <SETG P-HIM-OBJECT ,NOT-HERE-OBJECT>
         <SETG P-HER-OBJECT ,NOT-HERE-OBJECT>
         <SETG P-THEM-OBJECT ,NOT-HERE-OBJECT>>

<ROUTINE PCLEAR ()
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>>

<ROUTINE DO-MAIN-LOOP ("AUX" X)
	 <REPEAT ()
		 <SET X <MAIN-LOOP>>>>

<ROUTINE MAIN-LOOP ("AUX" ICNT OCNT NUM CNT OBJ TBL V PTBL OBJ1 TMP X)
   ;#DECL((CNT OCNT ICNT NUM) FIX (V) <OR 'T FIX FALSE> (OBJ)<OR FALSE OBJECT>
	  (OBJ1) OBJECT (TBL) TABLE (PTBL) <OR FALSE ATOM>)
   <REPEAT ()
     <SET CNT 0>
     <SET OBJ <>>
     <SET PTBL T>
     <COND (<NOT <EQUAL? ,QCONTEXT-ROOM ,HERE>>
	    <SETG QCONTEXT <>>)>
     <COND (<SETG P-WON <PARSER>>
	    <SET ICNT <GET ,P-PRSI ,P-MATCHLEN>>
	    <SET OCNT <GET ,P-PRSO ,P-MATCHLEN>>
	    <COND (<AND ,P-IT-OBJECT
			<ACCESSIBLE? ,P-IT-OBJECT>>
		   <SET TMP <>>
		   <REPEAT ()
			   <COND (<G? <SET CNT <+ .CNT 1>> .ICNT>
				  <RETURN>)
				 (T
				  <COND (<EQUAL? <GET ,P-PRSI .CNT> ,IT>
					 <PUT ,P-PRSI .CNT ,P-IT-OBJECT>
					 <SET TMP T>
					 <RETURN>)>)>>
		   <COND (<NOT .TMP>
			  <SET CNT 0>
			  <REPEAT ()
			   <COND (<G? <SET CNT <+ .CNT 1>> .OCNT>
				  <RETURN>)
				 (T
				  <COND (<EQUAL? <GET ,P-PRSO .CNT> ,IT>
					 <PUT ,P-PRSO .CNT ,P-IT-OBJECT>
					 <RETURN>)>)>>)>
		   <SET CNT 0>)>
	    <SET NUM
		 <COND (<ZERO? .OCNT>
			.OCNT)
		       (<G? .OCNT 1>
			<SET TBL ,P-PRSO>
			<COND (<ZERO? .ICNT>
			       <SET OBJ <>>)
			      (T
			       <SET OBJ <GET ,P-PRSI 1>>)>
			.OCNT)
		       (<G? .ICNT 1>
			<SET PTBL <>>
			<SET TBL ,P-PRSI>
			<SET OBJ <GET ,P-PRSO 1>>
			.ICNT)
		       (T
			1)>>
	    <COND (<AND <NOT .OBJ>
			<1? .ICNT>>
		   <SET OBJ <GET ,P-PRSI 1>>)>
	    <COND (<EQUAL? ,PRSA ,V?WALK>
		   <SET V <PERFORM ,PRSA ,PRSO>>)
		  (<ZERO? .NUM>
		   <COND (<ZERO? <BAND <GETB ,P-SYNTAX ,P-SBITS> ,P-SONUMS>>
			  <SET V <PERFORM ,PRSA>>
			  <SETG PRSO <>>)
			 (<NOT ,LIT>
			  <PCLEAR>
			  <TOO-DARK>)
			 (T
			  <PCLEAR>
			  <TELL "(There isn't anything to ">
			  <SET TMP <GET ,P-ITBL ,P-VERBN>>
			  <COND (<VERB? TELL>
				 <TELL "talk to">)
				(<OR ,P-MERGED ,P-OFLAG>
				 <PRINTB <GET .TMP 0>>)
				(T
				 <SET V <WORD-PRINT <GETB .TMP 2>
						    <GETB .TMP 3>>>)>
			  <TELL "!)" CR>
			  <SET V <>>)>)
		; (<AND .PTBL <G? .NUM 1> <VERB? COMPARE>>
		   <SET V <PERFORM ,PRSA ,OBJECT-PAIR>>)
		  (T
		   <SET X 0>
		   ;"<SETG P-MULT <>>
		   <COND (<G? .NUM 1> <SETG P-MULT T>)>"
		   <SET TMP 0>
		   <REPEAT ()
		    <COND (<G? <SET CNT <+ .CNT 1>> .NUM>
			   <COND (<G? .X 0>
				  <TELL "(The ">
				  <COND (<NOT <EQUAL? .X .NUM>>
					 <TELL "other ">)>
				  <TELL "object">
				  <COND (<NOT <EQUAL? .X 1>>
					 <TELL "s">)>
				  <TELL " that you mentioned ">
				  <COND (<NOT <EQUAL? .X 1>>
					 <TELL "are">)
					(T <TELL "is">)>
				  <TELL "n't here!)" CR>)
				 (<NOT .TMP>
				  <REFERRING>)>
			   <RETURN>)
			  (T
			   <COND (.PTBL
				  <SET OBJ1 <GET ,P-PRSO .CNT>>)
				 (T
				  <SET OBJ1 <GET ,P-PRSI .CNT>>)>
	<COND (<OR <G? .NUM 1>
		   <EQUAL? <GET <GET ,P-ITBL ,P-NC1> 0> ,W?ALL ,W?EVERYTHING>>
	       <COND (<EQUAL? .OBJ1 ,NOT-HERE-OBJECT>
		      <SET X <+ .X 1>>
		      <AGAIN>)
		   
		     (<AND <EQUAL? ,P-GETFLAGS ,P-ALL>
			   <DONT-ALL? .OBJ1 .OBJ>>
		      <AGAIN>)

		   ; (<AND <EQUAL? ,P-GETFLAGS ,P-ALL>
			   <VERB-ALL-TEST .OBJ1 .OBJ>>
		      <AGAIN>)
		   
		   ; (<AND <EQUAL? ,P-GETFLAGS ,P-ALL>
			   <VERB? TAKE>
		           <OR <AND <NOT <EQUAL? <LOC .OBJ1> ,WINNER ,HERE>>
				    <NOT <FSET? <LOC .OBJ1> ,SURFACEBIT>>>
			       <NOT <OR <FSET? .OBJ1 ,TAKEBIT>
				        <FSET? .OBJ1 ,TRYTAKEBIT>>>>>
		      <AGAIN>)
		   ; (<AND <EQUAL? ,P-GETFLAGS ,P-ALL>
			   <VERB? DROP PUT GIVE PUT-ON PUT-UNDER
				  PUT-BEHIND THROW>
			   <NOT <IN? .OBJ1 ,WINNER>>
			   <NOT <IN? ,P-IT-OBJECT ,WINNER>>>
		      <AGAIN>)
		     
		     (<NOT <ACCESSIBLE? .OBJ1>>
		      <AGAIN>)
		     (<EQUAL? .OBJ1 ,PROTAGONIST ; ,POCKET>
		      <AGAIN>)
		     (T
		      <COND (<EQUAL? .OBJ1 ,IT>
			     <COND (<NOT <FSET? ,P-IT-OBJECT ,NARTICLEBIT>>
				    <TELL "The ">)>
			     <PRINTD ,P-IT-OBJECT>)
			    (T
			     <COND (<NOT <FSET? .OBJ1 ,NARTICLEBIT>>
				    <TELL "The ">)>
			     <PRINTD .OBJ1>)>
		      <TELL ": ">)>)>
			   <SET TMP T>
			   <SET V <QCONTEXT-CHECK <COND (.PTBL
							 .OBJ1)
							(T
							 .OBJ)>>>
			   <SETG PRSO <COND (.PTBL
					     .OBJ1)
					    (T
					     .OBJ)>>
			   <SETG PRSI <COND (.PTBL
					     .OBJ)
					    (T
					     .OBJ1)>>
		   <SET V <PERFORM ,PRSA ,PRSO ,PRSI>>
		   <COND (<EQUAL? .V ,M-FATAL>
			  <RETURN>)>)>>)>
	    ;<COND (<NOT <EQUAL? .V ,M-FATAL>>
		   <COND (<GAME-VERB?>
			  T)
			 (T
			  <SET V <APPLY <GETP <LOC ,WINNER> ,P?ACTION>
					,M-END>>)>)>
	    ;<COND (<GAME-VERB?>
		   T)
		  (<VERB? AGAIN>
		   T)
		  (,P-OFLAG
		   T)
		  (T
		   <SETG L-PRSA ,PRSA>
		   <SETG L-PRSO ,PRSO>
		   <SETG L-PRSI ,PRSI>)>
	    <COND (<EQUAL? .V ,M-FATAL>
		   <SETG P-CONT <>>)>)
	   (T
	    <SETG P-CONT <>>)>
     <COND (,P-WON
	    <COND (<GAME-VERB?>
		   T)
		  ;(<AND <VERB? AGAIN>
			<GAME-VERB? ,L-PRSA>>
		   T)
		  (T
		   <SET V <CLOCKER>>)>)>
     <SETG PRSA <>>
     <SETG PRSO <>>
     <SETG PRSI <>>>>

<ROUTINE DONT-ALL? (O I "AUX" L)
	 <SET L <LOC .O>>
	 <COND (<EQUAL? .O .I>
		<RTRUE>)
	       (<VERB? TAKE>
		<COND (<EQUAL? .L ,PROTAGONIST ,WINNER>
		       <RTRUE>)
		      (<AND <NOT <FSET? .O ,TAKEBIT>>
			    <NOT <FSET? .O ,TRYTAKEBIT>>>
		       <RTRUE>)
		      (.I
		       <COND (<NOT <EQUAL? .L .I>>
			      <RTRUE>)
			     (<SEE-INSIDE? .I>
			      <RFALSE>)
			     (T
			      <RTRUE>)>)
		      (<EQUAL? .L ,HERE>
		       <RFALSE>)
		      (<FSET? .L ,SURFACEBIT>
		       <RFALSE>)
		      (<FSET? .L ,ACTORBIT>
		       <RFALSE>)
		      (T
		       <RTRUE>)>)
	       (<OR <EQUAL? ,PRSA ,V?DROP ,V?PUT ,V?PUT-ON>
		    <EQUAL? ,PRSA ,V?THROW>>
		<COND (<EQUAL? .L ,PROTAGONIST ,WINNER>
		       <RFALSE>)
		      (T
		       <RTRUE>)>)
	       (T
		<RFALSE>)>>

; <ROUTINE ENABLED? (RTN "AUX" C E)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<==? .C .E> <RFALSE>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<COND (<ZERO? <GET .C ,C-ENABLED?>> <RFALSE>)
			      (T <RTRUE>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>

; <ROUTINE QUEUED? (RTN "AUX" C E)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<==? .C .E> <RFALSE>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN>
			<COND (<OR <ZERO? <GET .C ,C-ENABLED?>>
				   <ZERO? <GET .C ,C-TICK>>>
			       <RFALSE>)
			      (T <RTRUE>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>

<ROUTINE GAME-VERB? ("OPTIONAL" (V <>))
	<COND (<NOT .V>
	       <SET V ,PRSA>)>
	<COND (<OR <EQUAL? .V ,V?BRIEF ,V?SCORE ,V?VERBOSE>
	           <EQUAL? .V ,V?QUIT ,V?RESTART ,V?RESTORE>
	           <EQUAL? .V ,V?SAVE ,V?SCRIPT ,V?SUPER-BRIEF>
	           <EQUAL? .V ,V?TELL ,V?UNSCRIPT ,V?VERSION>
		   <EQUAL? .V ,V?TIME ; ,V?INVENTORY>>
	       <RTRUE>)
	      (T
	       <RFALSE>)>>

<ROUTINE QCONTEXT-CHECK (PRSO "AUX" OTHER (WHO <>) (N 0))
	 <COND (<OR <VERB? HELP ; FIND ; WHAT>
		    <AND <VERB? TELL ;SHOW>
			 <==? .PRSO ,PROTAGONIST>>> ;"? more?"
		<SET OTHER <FIRST? ,HERE>>
		<REPEAT ()
			<COND (<NOT .OTHER>
			       <RETURN>)
			      (<AND <FSET? .OTHER ,ACTORBIT>
				  ; <NOT <FSET? .OTHER ,INVISIBLE>>
				    <NOT <==? .OTHER ,PROTAGONIST>>>
			       <SET N <+ 1 .N>>
			       <SET WHO .OTHER>)>
			<SET OTHER <NEXT? .OTHER>>>
		<COND (<AND <==? 1 .N>
			    <NOT ,QCONTEXT>>
		       <SAID-TO .WHO>)>
		<COND (<AND <QCONTEXT-GOOD?>
			    <==? ,WINNER ,PROTAGONIST>> ;"? more?"
		       ;<SETG L-WINNER ,WINNER>
		       <SETG WINNER ,QCONTEXT>
		     ; <TELL "(said to " D ,QCONTEXT ")" CR>
		       <SPOKEN-TO ,QCONTEXT>)>)>>

<ROUTINE SAID-TO (WHO)
	<SETG QCONTEXT .WHO>
	<SETG QCONTEXT-ROOM <LOC .WHO>>>

<ROUTINE SPOKEN-TO (WHO)
         <PCLEAR>
	 <TELL "(spoken to ">
	 <ARTICLE .WHO T>
	 <TELL D .WHO ")" CR>>

<ROUTINE QCONTEXT-GOOD? ()
         <COND (<AND <NOT <ZERO? ,QCONTEXT>>
	             <FSET? ,QCONTEXT ,ACTORBIT>
	           ; <NOT <FSET? ,QCONTEXT ,INVISIBLE>>
	             <==? ,HERE ,QCONTEXT-ROOM>
	             <==? ,HERE <META-LOC ,QCONTEXT>>>
	        <RTRUE>)>>

<ROUTINE ACCESSIBLE? (OBJ)
         <COND (<FSET? .OBJ ,INVISIBLE>
		<RFALSE>)
	       (<EQUAL? <META-LOC .OBJ> ,WINNER ,HERE ,GLOBAL-OBJECTS>
	        <RTRUE>)
	       (<VISIBLE? .OBJ>
	        <RTRUE>)
	       (T 
		<RFALSE>)>>

<ROUTINE VISIBLE? (OBJ "AUX" L)
         <SET L <LOC .OBJ>>
	 <COND (<NOT .L> 
		<RFALSE>)
               (<FSET? .OBJ ,INVISIBLE>
	        <RFALSE>)
               (<EQUAL? .L ,GLOBAL-OBJECTS>
	        <RFALSE>)
               (<EQUAL? .L ,PROTAGONIST ,HERE ,WINNER>
	        <RTRUE>)
               (<AND <EQUAL? .L ,LOCAL-GLOBALS>
		     <GLOBAL-IN? .OBJ ,HERE>>
		<RTRUE>)
               (<AND <SEE-INSIDE? .L>
		     <VISIBLE? .L>>
	        <RTRUE>)
               (T
	        <RFALSE>)>>

<ROUTINE SEE-INSIDE? (CONTAINER)
	 <COND (,P-MOBY-FLAG
		<RTRUE>)
	       (<FSET? .CONTAINER ,SURFACEBIT>
		<RTRUE>)
	       (<FSET? .CONTAINER ,CONTBIT>
		<COND (<OR <FSET? .CONTAINER ,OPENBIT>
		           <FSET? .CONTAINER ,TRANSBIT>>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<AND <FSET? .CONTAINER ,ACTORBIT>
		     <NOT <EQUAL? .CONTAINER ,PROTAGONIST>>>
		<RTRUE>)
	       (T
	    	<RFALSE>)>>

<ROUTINE META-LOC (OBJ)
	 <REPEAT ()
		 <COND (<NOT .OBJ>
			<RFALSE>)
		       (<IN? .OBJ ,GLOBAL-OBJECTS>
			<RETURN ,GLOBAL-OBJECTS>)
		       (<IN? .OBJ ,ROOMS>
			<RETURN .OBJ>)
		       (<FSET? .OBJ ,INVISIBLE>
			<RFALSE>)
		       (T
			<SET OBJ <LOC .OBJ>>)>>>

<CONSTANT C-TABLELEN 330>

; <GLOBAL C-TABLE <ITABLE NONE 300>>

<GLOBAL C-TABLE %<COND (<GASSIGNED? PREDGEN>
			'<ITABLE NONE 165>)
		       (T
			'<ITABLE NONE 330>)>>

<GLOBAL C-DEMONS 330>
<GLOBAL C-INTS 330>

<CONSTANT C-INTLEN 6>
<CONSTANT C-ENABLED? 0>
<CONSTANT C-TICK 1>
<CONSTANT C-RTN 2>

; <ROUTINE DEMON (RTN TICK "AUX" CINT)
	 #DECL ((RTN) ATOM (TICK) FIX (CINT) <PRIMTYPE VECTOR>)
	 <PUT <SET CINT <INT .RTN T>> ,C-TICK .TICK>
	 .CINT>

<ROUTINE QUEUE (RTN TICK "AUX" CINT)
	 #DECL ((RTN) ATOM (TICK) FIX (CINT) <PRIMTYPE VECTOR>)
	 <PUT <SET CINT <INT .RTN>> ,C-TICK .TICK>
	 .CINT>

<ROUTINE INT (RTN "OPTIONAL" (DEMON <>) E C INT)
	 #DECL ((RTN) ATOM (DEMON) <OR ATOM FALSE> (E C INT) <PRIMTYPE
							      VECTOR>)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E>
			<SETG C-INTS <- ,C-INTS ,C-INTLEN>>
			<AND .DEMON <SETG C-DEMONS <- ,C-DEMONS ,C-INTLEN>>>
			<SET INT <REST ,C-TABLE ,C-INTS>>
			<PUT .INT ,C-RTN .RTN>
			<RETURN .INT>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN> <RETURN .C>)>
		 <SET C <REST .C ,C-INTLEN>>>>

<GLOBAL CLOCK-WAIT <>>

<ROUTINE CLOCKER ("AUX" C E I TICK (FLG <>))
	 #DECL ((C E) <PRIMTYPE VECTOR> (TICK) FIX (FLG) <OR FALSE ATOM>)
	 <COND (,CLOCK-WAIT
		<SETG CLOCK-WAIT <>>
		<RFALSE>)>
	 <SET C <REST ,C-TABLE <COND (,P-WON ,C-INTS) (T ,C-DEMONS)>>>
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <REPEAT ()
		 <COND (<EQUAL? .C .E>
			<SETG MOVES <+ ,MOVES 1>>
	                <COND (<G? ,MOVES 59>
		               <SETG MOVES 0>
		               <SETG SCORE <+ ,SCORE 1>>
		               <COND (<G? ,SCORE 23>
		                      <SETG SCORE 0>)>)>
			<RETURN .FLG>)
		       (<NOT <ZERO? <GET .C ,C-ENABLED?>>>
			<SET TICK <GET .C ,C-TICK>>
			<COND (<ZERO? .TICK>)
			      (T
			       <PUT .C ,C-TICK <- .TICK 1>>
			       <COND (<AND <NOT <G? .TICK 1>>
					   <APPLY <GET .C ,C-RTN>>>
				      <SET FLG T>)>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>

; <ROUTINE MACINTOSH? ("AUX" MODE)
	 <SET MODE <GETB 0 1>>
	 <COND (<OR <ZERO? <BAND .MODE 32>>
	            <NOT <ZERO? <BAND .MODE 64>>>>
	        <RTRUE>)
	       (T
		<RFALSE>)>>

; <ROUTINE CARRIAGE-RETURNS ("AUX" (CNT 22))
	 <RESET-THEM>
	 <REPEAT ()
		 <CRLF>
	         <SET CNT <- .CNT 1>>
		 <COND (<ZERO? .CNT>
			<RTRUE>)>>>



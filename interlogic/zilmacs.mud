;"MAGIC MACROS"

"<CASE expression
      (value1 statement ...)
      (value2 statement ...)
      ...
      (ELSE statement ...)>"

<DEFMAC ZCASE ('EXPR "ARGS" STATEMENTS:LIST)
	<FORM COND
	      !<MAPF ,LIST
		     <FUNCTION (S:LIST "AUX" (TOK <1 .S>))
			  (<COND (<OR <==? .TOK T> <==? .TOK ELSE>>
				  .TOK)
				 (<TYPE? .TOK LIST>
				  <FORM EQUAL? .EXPR !.TOK>)
				 (ELSE
				  <FORM EQUAL? .EXPR .TOK>)>
			   !<REST .S>)>
		     .STATEMENTS>>>

"<DO (var start end {increment}) statement1 ... statementn>"

<DEFMAC DO ('INCLIST:LIST "ARGS" STATEMENTS
	    "AUX" (ENDSTUFF <LIST <FORM RETURN>>) FTOP FF E (INCS:LIST (T))
	    (TESTS:LIST (T)) (II:LIST .INCS) (TT:LIST .TESTS))
	<COND (<AND <NOT <EMPTY? .INCLIST>>
		    <TYPE? <1 .INCLIST> ATOM>>
	       <SET INCLIST <LIST .INCLIST>>)>
	<MAPR <>
	      <FUNCTION (L:LIST
			 "AUX" (E <1 .L>) START END INC)
		   <COND (<AND <TYPE? .E LIST>
			       <NOT <LENGTH? .E 2>>>
			  <SET START <2 .E>>
			  <SET END <3 .E>>
			  <COND (<LENGTH? .E 3>
				 <SET E
				      <LIST !.E
					    <SET INC
						 <COND (<AND <TYPE? .START FIX>
							     <TYPE? .END FIX>
							     <G? .START .END>>
							-1)
						       (ELSE 1)>>>>)
				(ELSE <SET INC <4 .E>>)>
			  <1 .L
			     (<OR <TYPE? .END FALSE> ;"can test go at end?"
				  <AND <TYPE? .END FORM> <EMPTY? .END>>
				  <AND <TYPE? .START FIX>
				       <TYPE? .END FIX>
				       <TYPE? .INC FIX>
				       <OR <AND <G? .END .START>
						<G? .INC 0>>
					   <AND <L? .END .START>
						<L? .INC 0>>>>>
			      !.E)>)
			 (ELSE
			  <ERROR BAD-DO-LIST .INCLIST>)>>
	      .INCLIST>
	<COND (<AND <NOT <EMPTY? .STATEMENTS>>
		    <TYPE? <1 .STATEMENTS> LIST>>
	       <SET ENDSTUFF (!<1 .STATEMENTS> !.ENDSTUFF)>
	       <SET STATEMENTS <REST .STATEMENTS>>)>
	<SET FTOP
	     <FORM REPEAT
		   <MAPF ,LIST
			 <FUNCTION (V:LIST)
			      (<2 .V> <3 .V>)>
			 .INCLIST>>>
	<SET FF <REST .FTOP>>
	<SET E
	     <MAPF ,LIST
	      <FUNCTION (V:LIST
			 "AUX" (END <4 .V>) (INC <5 .V>))
		   <COND (<OR <1 .V>
			      <NOT .END>
			      <==? .END '<>>>
			  <MAPRET>)
			 (<TYPE? .END FORM>
			  .END)
			 (ELSE
			  <FORM
			   <COND (<AND <TYPE? .INC FIX>
				       <L? .INC 0>>
				  L?)
				 (ELSE G?)>
			   <CHTYPE <2 .V> LVAL>
			   .END>)>>
	      .INCLIST>>
	<COND (<NOT <EMPTY? .E>>
	       <PUTREST .FF
			<SET FF (<FORM COND
				       (<COND (<EMPTY? <REST .E>> <1 .E>)
					      (ELSE <FORM OR !.E>)>
					!.ENDSTUFF)>)>>)>
	<PUTREST .FF .STATEMENTS>
	<SET FF <REST .FF <- <LENGTH .FF> 1>>>
	<MAPF <>
	      <FUNCTION (V:LIST "AUX" F:FORM (VAR <2 .V>)
			 (END? <1 .V>)
			 (END <4 .V>) (INC <5 .V>))
		   <SET F
			<FORM
			 SET .VAR
			 <COND (<TYPE? .INC FORM>
				.INC)
			       (ELSE
				<FORM
				 <COND (<TYPE? .INC FIX>
					<COND (<G? .INC 0> +)
					      (ELSE -)>)
				       (ELSE +)>
				 <CHTYPE .VAR LVAL>
				 <COND
				  (<TYPE? .INC FIX>
				   <COND
				    (<G? .INC 0> .INC)
				    (ELSE <- .INC>)>)
				  (ELSE .INC)>>)>>>
		   <COND (<OR <NOT .END?>
			      <NOT .END>
			      <AND <TYPE? .END FORM>
				   <EMPTY? .END>>>
			  <PUTREST .II <SET II (.F)>>)
			 (ELSE
			  <PUTREST .TT
				   <SET TT
					(<FORM
					  <COND (<AND <TYPE? .INC FIX>
						      <L? .INC 0>>
						 L?)
						(ELSE G?)>
					  .F
					  .END>)>>)>>
	      .INCLIST>
	<SET TESTS <REST .TESTS>>
	<SET INCS <REST .INCS>>
	<COND (<NOT <EMPTY? .TESTS>>
	       <SET INCS
		    (<FORM COND
			   (<COND (<EMPTY? <REST .TESTS>>
				   <1 .TESTS>)
				  (ELSE <FORM OR !.TESTS>)>
			    !.ENDSTUFF)>
		     !.INCS)>)>
	<COND (<NOT <EMPTY? .INCS>> <PUTREST .FF .INCS>)>
	.FTOP>

"<MAP-CONTENTS (variable {remove} object) <statement1> ... <statementN>>"

<DEFMAC MAP-CONTENTS ('VARLIST "ARGS" STATEMENTS
		      "AUX" VL:FIX VAR:ATOM OBJ:ANY (REMOVE? <>)
		      (END <LIST <FORM RETURN>>))
	<COND (<OR <NOT <TYPE? .VARLIST LIST>>
		   <NOT <TYPE? <1 .VARLIST> ATOM>>
		   <==? <SET VL <LENGTH .VARLIST>> 1>
		   <AND <==? .VL 2>
			<NOT <TYPE? <2 .VARLIST> LVAL GVAL>>>
		   <AND <==? .VL 3>
			<NOT <TYPE? <3 .VARLIST> LVAL GVAL>>>
		   <G? .VL 3>>
	       <ERROR BAD-VARLIST MAP-CONTENTS .VARLIST>)
	      (ELSE
	       <COND (<TYPE? <1 .STATEMENTS> LIST>
		      <SET END (!<1 .STATEMENTS> !.END)>
		      <SET STATEMENTS <REST .STATEMENTS>>)>
	       <SET VAR <1 .VARLIST>>
	       <COND (<NOT <LENGTH? .VARLIST 2>>
		      <SET REMOVE? <2 .VARLIST>>
		      <SET OBJ <3 .VARLIST>>)
		     (ELSE <SET OBJ <2 .VARLIST>>)>
	       <COND (.REMOVE?
		      <FORM PROG (.VAR .REMOVE?)
			    <FORM SET .VAR <FORM FIRST? .OBJ>>
			    <FORM REPEAT ()
				  <FORM COND (<FORM NOT <CHTYPE .VAR LVAL>>
					      !.END)>
				  <FORM SET .REMOVE?
					<FORM NEXT? <CHTYPE .VAR LVAL>>>
				  !.STATEMENTS
				  <FORM SET .VAR
					<CHTYPE .REMOVE? LVAL>>>>)
		     (ELSE
		      <FORM
		       PROG (.VAR)
			    <FORM
			     COND (<FORM SET .VAR <FORM FIRST? .OBJ>>
				   <FORM
				    REPEAT ()
				    !.STATEMENTS
				    <FORM COND
					  (<FORM
					    NOT <FORM SET .VAR
						      <FORM
						       NEXT?
						       <CHTYPE .VAR LVAL>>>>
					   !.END)>>)>>)>)>>

"<MAP-DIRECTIONS (dir getpt room) <statement1> ... <statementN>>"

<DEFMAC MAP-DIRECTIONS ('VARLIST "ARGS" STATEMENTS
			"AUX" DIR:ATOM VAL:ATOM ROOM:ANY
			(END <LIST <FORM RETURN>>))
	<COND (<OR <NOT <TYPE? .VARLIST LIST>>
		   <N==? <LENGTH .VARLIST> 3>
		   <NOT <TYPE? <1 .VARLIST> ATOM>>
		   <NOT <TYPE? <2 .VARLIST> ATOM>>
		   <NOT <TYPE? <3 .VARLIST> LVAL GVAL>>>
	       <ERROR BAD-VARLIST MAP-DIRECTIONS .VARLIST>)
	      (ELSE
	       <COND (<TYPE? <1 .STATEMENTS> LIST>
		      <SET END (!<1 .STATEMENTS> !.END)>
		      <SET STATEMENTS <REST .STATEMENTS>>)>
	       <SET DIR <1 .VARLIST>>
	       <SET VAL <2 .VARLIST>>
	       <SET ROOM <3 .VARLIST>>
	       <FORM REPEAT ((.DIR <COND (,EXTENDED? 65) (ELSE 33)>)
			     .VAL)
		     <FORM COND
			   (<FORM DLESS? .DIR ',LOW-DIRECTION>
			    !.END)
			   (<FORM SET
				  .VAL
				  <FORM GETPT
					.ROOM
					<CHTYPE .DIR LVAL>>>
			    !.STATEMENTS)>>)>>


<SETG GOBL <MOBLIST G>>

"First arg is the name of the table to use.  Remaining args are atoms,
 adecls, or lists:
 (global-name:<OR ATOM ADECL> {BYTE} {initial-value}).  The ONLY way to
 give a decl is by making the first element be an ADECL."
<DEFMAC DEFINE-GLOBALS DG (TABNAME:ATOM "ARGS" STUFF "AUX" ST ATM
			   (INIT-LIST:LIST (T)) (IL:LIST .INIT-LIST))
  <COND (<AND <GASSIGNED? DO-FUNNY-GLOBALS?>
	      ,DO-FUNNY-GLOBALS?>
	 <MAPF <>
	   <FUNCTION (L:<OR ATOM ADECL LIST> "AUX" (BYTE? <>)
		      (DECL <>) (INIT <>) G ATM)
	     <COND (<TYPE? .L ADECL>
		    <SET G <1 .L>>
		    <SET DECL <2 .L>>)
		   (<TYPE? .L ATOM> <SET G .L>)
		   (T
		    <COND (<TYPE? <1 .L> ADECL>
			   <SET DECL <2 <1 .L>>>
			   <SET G <1 <1 .L>>>)
			  (T
			   <SET G <1 .L>>)>
		    <COND (<AND <NOT <EMPTY? <REST .L>>>
				<OR <AND <TYPE? <2 .L> ATOM>
					 <=? <SPNAME <2 .L>> "BYTE">>
				    <AND <NOT <EMPTY? <REST .L 2>>>
					 <TYPE? <3 .L> ATOM>
					 <=? <SPNAME <3 .L>> "BYTE">>>>
			   <SET BYTE? T>)>
		    <COND (<NOT <EMPTY? <REST .L>>>
			   <COND (<OR <NOT <TYPE? <2 .L> ATOM>>
				      <N=? <SPNAME <2 .L>> "BYTE">>
				  <SET INIT <2 .L>>)
				 (<NOT <EMPTY? <REST .L 2>>>
				  <COND (<OR <NOT <TYPE? <3 .L> ATOM>>
					     <N=? <SPNAME <3 .L>> "BYTE">>
					 <SET INIT <3 .L>>)>)>)>)>
	     <SET ATM <STRING <SPNAME .G> "-GVAL">>
	     <SET ATM <OR <LOOKUP .ATM <OBLIST? .G>>
			  <INSERT .ATM <OBLIST? .G>>>>
	     <EVAL <FORM GLOBAL .ATM .INIT .DECL
			 <COND (.BYTE? BYTE) (T WORD)>>>
	     <EVAL <FORM DEFMAC .G ("OPT" ''NEW)
			 <FORM COND (<FORM ASSIGNED? NEW>
				     <FORM FORM SETG .ATM '.NEW>)
			       (T <FORM CHTYPE .ATM GVAL>)>>>>
	   .STUFF>
	 <RETURN T .DG>)>
  <PROG ((CBO 0))
    ; "Find out if this name has already been used..."
    <BIND ((OBLIST:<SPECIAL LIST> ()))
      <COND (<SET ATM <LOOKUP <SET ST <UNPARSE .TABNAME>> ,GOBL>>
	     <COND (<NOT <ERROR ALREADY-DEFINED!-ERRORS .TABNAME
				ERRET-T-TO-REDEFINE!-ERRORS>>
		    <RETURN <>>)>)
	    (T
	     <SET ATM <INSERT .ST ,GOBL>>)>>
    ; "First let's allocate all the byte-sized ones"
    <MAPF <>
      <FUNCTION (L)
        <COND (<AND <TYPE? .L LIST>
		    <NOT <EMPTY? <REST .L>>>
		    <OR <AND <TYPE? <2 .L> ATOM>
			     <=? <SPNAME <2 .L>> "BYTE">>
			<AND <NOT <EMPTY? <REST .L 2>>>
			     <TYPE? <3 .L> ATOM>
			     <=? <SPNAME <3 .L>> "BYTE">>>>
	       ; "We're defining a byte global"
	       <DEFGLOBAL .TABNAME .CBO .L .IL T>
	       <SET CBO <+ .CBO 1>>
	       <SET IL <REST .IL>>)>>
      .STUFF>
    ; "Allow for one byte of slop"
    <COND (<NOT <0? <MOD .CBO 2>>>
	   <SET IL <REST <PUTREST .IL (<FORM BYTE 0>)>>>
	   <SET CBO <+ .CBO 1>>)>
    <MAPF <>
      <FUNCTION (L)
        <COND (<OR <NOT <TYPE? .L LIST>>
		   <EMPTY? <REST .L>>
		   <NOT <OR <AND <TYPE? <2 .L> ATOM>
				 <=? <SPNAME <2 .L>> "BYTE">>
			    <AND <NOT <EMPTY? <REST .L 2>>>
				 <TYPE? <3 .L> ATOM>
				 <=? <SPNAME <3 .L>> "BYTE">>>>>
	      <DEFGLOBAL .TABNAME .CBO .L .IL <>>
	      <SET CBO <+ .CBO 2>>
	      <SET IL <REST .IL>>)>>
      .STUFF>
    <FORM GLOBAL <CHTYPE [.TABNAME TABLE] ADECL>
	  <FORM TABLE !<REST .INIT-LIST>>>>>

<DEFINE DEFGLOBAL (TABNAME:ATOM OFFS:FIX L IL:LIST BYTE?:<OR ATOM FALSE>
		   "AUX" NAME:<OR ADECL ATOM>
			 (INIT 0) (DECL <>))
  <COND (<TYPE? .L LIST>
	 <SET NAME <1 .L>>
	 <SET L <REST .L>>)
	(T
	 <SET NAME .L>
	 <SET L ()>)>
  <COND (<NOT .BYTE?>
	 <SET OFFS </ .OFFS 2>>)>
  <COND (<TYPE? .NAME ADECL>
	 <SET DECL <2 .NAME>>
	 <SET NAME <1 .NAME>>)>
  <COND (<NOT <EMPTY? .L>>
	 <COND (<OR <NOT <TYPE? <1 .L> ATOM>>
		    <N=? <SPNAME <1 .L>> "BYTE">>
		<SET INIT <1 .L>>)
	       (<NOT <EMPTY? <SET L <REST .L>>>>
		<COND (<OR <NOT <TYPE? <1 .L> ATOM>>
			   <N=? <SPNAME <1 .L>> "BYTE">>
		       <SET INIT <1 .L>>)>)>)>
  <PUTREST .IL (<COND (.BYTE? <FORM BYTE .INIT>)
		      (T .INIT)>)>
  <EVAL <FORM DEFMAC .NAME '("OPT" 'NEW)
	      <FORM COND (<FORM ASSIGNED? NEW>
			  <FORM FORM <COND (.BYTE? PUTB)
					   (T ZPUT)>
				<FORM CHTYPE .TABNAME GVAL>
				.OFFS
				<COND (.DECL
				       <FORM CHTYPE
					     <FORM VECTOR '.NEW
						   <FORM QUOTE .DECL>>
					     ADECL>)
				      (T
				       '.NEW)>>)
		    (T
		     <COND (.DECL
			    <FORM CHTYPE
				  <FORM VECTOR
					<FORM FORM <COND (.BYTE? GETB)
							 (T ZGET)>
					      <FORM CHTYPE .TABNAME GVAL>
					      .OFFS>
					<FORM QUOTE .DECL>>
				  ADECL>)
			   (T
			    <FORM FORM <COND (.BYTE? GETB)
					     (T ZGET)>
				  <FORM CHTYPE .TABNAME GVAL>
				  .OFFS>)>)>>>>

<SETG NO-INIT ''NONE>
<GDECL (EXCT OARGS) FIX>

<DEFMAC LROUTINE ('NAME "ARGS" STUFF "AUX" (HATM <>)
		  (RSTUFF .STUFF) ARGL:LIST BODY (REAL-AUXES ())
		  (REQUIRED (T)) (RL .REQUIRED)
		  (OPT (T)) (OL .OPT) (TUPLE <>)
		  (STATE ,LR-STATE-REQUIRED) MIN-ARGS:FIX
		  MAX-ARGS:FIX)
  <SETG EXCT 0>
  <COND (<TYPE? <1 .STUFF> ATOM>
	 <SET HATM <1 .STUFF>>
	 <SET RSTUFF <REST .STUFF>>)>
  <SET ARGL <1 .RSTUFF>>
  <SET BODY <REST .RSTUFF>>
  <MAPR <>
    <FUNCTION (L "AUX" (OBJ <1 .L>) VAR INIT)
      <COND (<TYPE? .OBJ STRING>
	     <COND (<=? .OBJ "AUX">
		    <SET REAL-AUXES <REST .L>>
		    <MAPLEAVE>)
		   (<OR <=? .OBJ "OPT">
			<=? .OBJ "OPTIONAL">>
		    <COND (<N==? .STATE ,LR-STATE-REQUIRED>
			   <ERROR OPTIONAL-WHERE-NOT-ALLOWED!-ERRORS
				  .L
				  LROUTINE>)>
		    <SET STATE ,LR-STATE-OPTIONAL>)
		   (<=? .OBJ "TUPLE">
		    <COND (<G=? .STATE ,LR-STATE-TUPLE>
			   <ERROR TUPLE-WHERE-NOT-ALLOWED!-ERRORS
				  .L
				  LROUTINE>)>
		    <SET STATE ,LR-STATE-TUPLE>)
		   (T
		    <ERROR BAD-TOKEN-IN-ARG-LIST!-ERRORS
			   .OBJ
			   LROUTINE>)>)
	    (<AND <TYPE? .OBJ LIST>
		  <N==? .STATE ,LR-STATE-OPTIONAL>>
	     <ERROR INVALID-LIST-IN-ARG-LIST!-ERRORS
		    .L
		    LROUTINE>)
	    (<OR <NOT <TYPE? .OBJ LIST ATOM ADECL>>
		 <AND <TYPE? .OBJ LIST>
		      <OR <N==? <LENGTH .OBJ> 2>
			  <NOT <TYPE? <1 .OBJ> ATOM ADECL>>>>>
	     <ERROR BAD-OBJECT-IN-ARG-LIST!-ERRORS
		    .OBJ
		    LROUTINE>)
	    (T
	     <COND (<TYPE? .OBJ LIST>
		    <SET VAR <1 .OBJ>>
		    <SET INIT <2 .OBJ>>)
		   (T
		    <SET VAR .OBJ>
		    <SET INIT ,NO-INIT>)>
	     <COND (<==? .STATE ,LR-STATE-REQUIRED>
		    <SET RL <REST <PUTREST .RL (.VAR)>>>)
		   (<==? .STATE ,LR-STATE-OPTIONAL>
		    <SET OL <REST <PUTREST .OL
					   (<COND (<N==? .INIT ,NO-INIT>
						   (.VAR .INIT))
						  (T
						   .VAR)>)>>>)
		   (<==? .STATE ,LR-STATE-TUPLE>
		    <COND (.TUPLE
			   <ERROR TWO-TUPLE-ATOMS-IN-ARG-LIST!-ERRORS
				  .VAR
				  LROUTINE>)>
		    <SET TUPLE .VAR>)>)>>
    .ARGL>
  <SET MIN-ARGS <LENGTH <REST .REQUIRED>>>
  <COND (.TUPLE <SET MAX-ARGS <MIN>>)
	(T
	 <SET MAX-ARGS <+ .MIN-ARGS <LENGTH <REST .OPT>>>>)>
  <COND (<L=? .MAX-ARGS <MAX-FCN-ARGS>>
	 ; "No need to bother, because frob doesn't take too many args.
	    We subtract 2 to account for the dummies on the front of the
	    lists."
	 <FORM ROUTINE .NAME !.STUFF>)
	(T
	 <PROG ((NEW-ARGL ('NARGS:FIX)) (NL .NEW-ARGL) (N 1)
		(STATE ,LR-STATE-REQUIRED) (INIT-TABLE (T)) (IT .INIT-TABLE)
		F1 F2 (CALL-LIST (<FORM LENGTH '.MACRO-ARGS>)) (CL .CALL-LIST)
		(PASS-COUNT? <>))
	   ; "NEW-ARGL becomes the argument list for the generated function
	      called by the macro.  INIT-TABLE is included in the macro
	      to initialize the table used for passing extra args."
	   <COND (<AND .OPT <NOT <EMPTY? <REST .OPT>>>>
		  <SET PASS-COUNT? T>)
		 (T
		  <SET N 0>)>
	   <SETG OARGS 0>
	   <REPEAT ((TARG <REST .REQUIRED>))
	     <COND (<EMPTY? .TARG>
		    <COND (<G? <SET STATE <+ .STATE 1>> ,LR-STATE-OPTIONAL>
			   ; "All done with everything but TUPLE..."
			   <RETURN>)
			  (T
			   ; "Try optionals next"
			   <COND (<NOT <EMPTY? <SET TARG <REST .OPT>>>>
				  ; "We actually have some optionals"
				  <COND (<L? .N <MAX-FCN-ARGS>>
					 ; "And there'll be room for one
					    in the arg list, so add the string"
					 <SET NL <REST
						  <PUTREST .NL
							   ("OPTIONAL")>>>)>)
				 (T
				  <RETURN>)>)>)>
	     <COND (<G? <SET N <+ .N 1>> <MAX-FCN-ARGS>>
		    ; "Have enough args, so the rest go in the aux list"
		    <SETG OARGS <COND (.PASS-COUNT? <- .N 1>) (T .N)>>
		    <SET NL <INITIAL-AUXES
			     <COND (<L? .STATE ,LR-STATE-OPTIONAL>
				    .TARG)>
			     <COND (<==? .STATE ,LR-STATE-OPTIONAL>
				    .TARG)
				   (T
				    <REST .OPT>)>
			     .NL
			     .IT>>
		    ; "Then we'll go deal with the tuple and the real
		       aux list"
		    <RETURN>)>
	     <SET NL <REST <PUTREST .NL (<1 .TARG>)>>>
	     <SET CL
		  <REST <PUTREST .CL (<FORM NTH '.MACRO-ARGS
					    <COND (.PASS-COUNT? <- .N 1>)
						  (T .N)>>)>>>
	     <SET TARG <REST .TARG>>>
	   <COND (<AND <G? .STATE ,LR-STATE-OPTIONAL>
		       <OR .TUPLE
			   <NOT <EMPTY? .REAL-AUXES>>>>
		  ; "Don't already have AUX in the list, and will need it"
		  <SET NL <REST <PUTREST .NL ("AUX")>>>)>
	   <COND (.TUPLE
		  ; "Bind the tuple to rest of the arg-table"
		  <SET NL <REST <PUTREST .NL (<LIST .TUPLE
						    <FORM ZREST ',ARG-TABLE
							  <* ,EXCT 2>>>)>>>
		  ; "And make sure it has a length arg"
		  <SET IT
		       <REST <PUTREST .IT
			      (<FORM FORM ZPUT '',ARG-TABLE
				     ,EXCT
				     <FORM MIN 0
					   <FORM - '.ARGCT ,OARGS>>>)>>>
		  <SETG EXCT <+ ,EXCT 1>>
		  <SET IT
		   <REST
		    <PUTREST .IT
		     (<CHTYPE
		       <FORM PROG ((EXCT ,EXCT))
		         <FORM MAPF ',LIST
			   <FORM FUNCTION (X)
			     <FORM SET EXCT <FORM + '.EXCT 1>>
			     <FORM FORM ZPUT '',ARG-TABLE
				   <FORM - '.EXCT 1>
				   '.X>>
			   <FORM REST '.MACRO-ARGS
				 <FORM MIN '.ARGCT ,OARGS>>>>
		       SEGMENT>)>>>)>
	   <SET NL <REST <PUTREST .NL .REAL-AUXES>>>
	   <COND (.HATM
		  <SET F1 <FORM ROUTINE <LOWERCASE .NAME> .HATM
				<COND (.PASS-COUNT? .NEW-ARGL)
				      (T <REST .NEW-ARGL>)>
				!.BODY>>)
		 (T
		  <SET F1 <FORM ROUTINE <LOWERCASE .NAME>
				<COND (.PASS-COUNT? .NEW-ARGL)
				      (T <REST .NEW-ARGL>)>
				!.BODY>>)>
	   <SET F2 <FORM FORM
			 <LOWERCASE .NAME>
			 <CHTYPE <FORM SUBSTRUC
				       <COND (.PASS-COUNT? .CALL-LIST)
					     (T <REST .CALL-LIST>)>
				       0 <FORM MIN
					       <FORM LENGTH '.MACRO-ARGS>
					       <MAX-FCN-ARGS>>>
				 SEGMENT>>>
	   <SET F2 <FORM DEFMAC .NAME ("ARGS" MACRO-ARGS "AUX" INIT-TABLE
				       (ARGCT <FORM LENGTH '.MACRO-ARGS>))
		      <FORM COND (<FORM OR <FORM L? '.ARGCT .MIN-ARGS>
					<FORM G? '.ARGCT .MAX-ARGS>>
				  <FORM ERROR WRONG-NUMBER-OF-ARGS!-ERRORS
					.NAME>)>
		      <FORM SET INIT-TABLE
			    <FORM SUBSTRUC <REST .INIT-TABLE>
				  0 <FORM - '.ARGCT <MAX-FCN-ARGS>
					  <COND (.PASS-COUNT? -1)
						(T 0)>>>>
		      <FORM COND (<FORM EMPTY? '.INIT-TABLE>
				  .F2)
			    (T
			     <FORM FORM PROG ()
			       '!.INIT-TABLE
			       .F2>)>>>
	   <EVAL .F2>
	   .F1>)>>

<DEFINE LOWERCASE (ATM:ATOM "AUX" (OBL <OBLIST? .ATM>) (NM <SPNAME .ATM>)
		   NS)
  <SET NS
       <MAPF ,STRING
         <FUNCTION (CHR)
	   <COND (<AND <G=? <ASCII .CHR> <ASCII !\A>>
		       <L=? <ASCII .CHR> <ASCII !\Z>>>
		  <ASCII <+ <ASCII .CHR> <- <ASCII !\a> <ASCII !\A>>>>)
		 (T .CHR)>>
	 .NM>>
  <OR <LOOKUP .NS .OBL>
      <INSERT .NS .OBL>>>

<DEFINE INITIAL-AUXES (REQ:<OR LIST FALSE> OPT:<OR LIST FALSE> NL:LIST
		       IT:LIST "AUX" (ILL (T)) (IL .ILL))
  <SET NL <REST <PUTREST .NL ("AUX")>>>
  <COND (.REQ
	 ; "Required arguments left over"
	 <MAPF <>
	   <FUNCTION (FROB "AUX" ATM (DECL <>))
	     ; "Put in something to get the argument out of the table"
	     <COND (<TYPE? .FROB ADECL>
		    <SET ATM <1 .FROB>>
		    <SET DECL <2 .FROB>>)
		   (T <SET ATM .FROB>)>
	     <SET NL <REST <PUTREST .NL (<LIST .FROB
					       <FORM ZGET ',ARG-TABLE
						     ,EXCT>>)>>>
	     <SET IT <REST <PUTREST .IT (<FORM FORM ZPUT '',ARG-TABLE
					       ,EXCT
					       <COND
						(.DECL
						 <FORM CHTYPE
						  [<FORM NTH '.MACRO-ARGS
							 ,OARGS>
						   <FORM QUOTE .DECL>]
						  ADECL>)
						(T
						 <FORM NTH '.MACRO-ARGS
						     ,OARGS>)>>)>>>
	     <SETG EXCT <+ ,EXCT 1>>
	     <SETG OARGS <+ ,OARGS 1>>>
	   .REQ>)>
  <COND (.OPT
	 <MAPF <>
	   <FUNCTION (FROB "AUX" ATM (DECL <>))
	     <COND (<TYPE? .FROB LIST>
		    <SET ATM <1 .FROB>>
		    <SET NL
		     <REST <PUTREST .NL
			    (<LIST .ATM
				   <FORM COND
					 (<FORM G=? '.NARGS ,OARGS>
					  <FORM ZGET ',ARG-TABLE ,EXCT>)
					 (T
					  <2 .FROB>)>>)>>>)
		   (T
		    <SET ATM .FROB>
		    <SET NL
		     <REST <PUTREST .NL
			    (<LIST .ATM
				   <FORM COND (<FORM G? '.NARGS ,OARGS>
					       <FORM ZGET ',ARG-TABLE
						     ,EXCT>)>>)>>>)>
	     <COND (<TYPE? .ATM ADECL>
		    <SET DECL <2 .ATM>>)>
	     <SET IT
	       <REST <PUTREST .IT
		      (<FORM COND (<FORM G=? <FORM LENGTH '.MACRO-ARGS>
					 ,OARGS>
				   <FORM FORM ZPUT '',ARG-TABLE
					 ,EXCT
					 <COND (.DECL
						<FORM CHTYPE
						 [<FORM NTH '.MACRO-ARGS
							,OARGS>
						  <FORM QUOTE .DECL>]
						 ADECL>)
					       (<FORM NTH '.MACRO-ARGS
						     ,OARGS>)>>)>)>>>
	     <SETG OARGS <+ ,OARGS 1>>
	     <SETG EXCT <+ ,EXCT 1>>>
	   .OPT>)>
  .NL>

<DEFINE MAX-FCN-ARGS ()
	<COND (,EXTENDED? 7)
	      (T 3)>>

<MSETG LR-STATE-REQUIRED 1>
<MSETG LR-STATE-OPTIONAL 2>
<MSETG LR-STATE-TUPLE 3>
<MSETG LR-STATE-AUX 4>


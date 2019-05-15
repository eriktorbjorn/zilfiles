<MAPF <>
      <FUNCTION (LST "AUX" (NAM <SPNAME <1 .LST>>))
	   <SETG <OR <LOOKUP .NAM ,CNV>
		     <INSERT .NAM ,CNV>>
		 <2 .LST>>>
      [[==? EQUAL?]
       [=? EQUAL?]
       [L? LESS?]
       [G? GRTR?]
       [APPLY CALL]
       ;[SETG SET]
       [0? ZERO?]
       [* MUL]
       [/ DIV]
       [REST ADD]
       [BACK SUB]
       [+ ADD]
       [- SUB]
       [ASH ASHIFT]
       [LSH SHIFT]
       [NTH GET]
       [NTHB GETB]
       [ANDB BAND]
       [ORB BOR]
       [XORB BCOM]
;"OVERWRITES"
       [ZBUFOUT	BUFOUT]
       [ZCRLF	CRLF]
       [ZREST	REST]
       [ZBACK	BACK]
       [ZGET	GET] 
       [ZPUT	PUT]
       [ZREMOVE	REMOVE] 
       [ZREAD 	READ]
       [ZRETURN	RETURN]
       [ZAGAIN	AGAIN]
       [ZSAVE	SAVE]
       [ZRESTORE	RESTORE]
       [ZPRINT	PRINT]
       [ZPRINTB	PRINTB]
       [ZAPPLY	APPLY]
       [ZRANDOM	RANDOM]
       [ZCASE	CASE]]>

<SETG PREDS
      [#INS EQUAL?
	#INS LESS?
	#INS GRTR?
	#INS DLESS?
	#INS IGRTR?
	#INS IN?
	#INS FSET?
	#INS ZERO?
	#INS NEXT?
	#INS FIRST?
	#INS LOC
	#INS INTBL?
	#INS READY?
	#INS XPUSH]>

;<ADD-OP name min max pred? val? "opt" (side-effect? <>)>

<ADD-OP EQUAL? 2 4 T <>>
<ADD-OP LESS? 2 2 T <>>
<ADD-OP GRTR? 2 2 T <>>
<ADD-OP DLESS? 2 2 T <> T>
<ADD-OP IGRTR? 2 2 T <> T>
<ADD-OP IN? 2 2 T <>>
<ADD-OP BTST 2 2 T <>>
<ADD-OP BAND 2 2 <> T>
<ADD-OP BOR 2 2 <> T>
<ADD-OP BCOM 1 1 <> T>
<ADD-OP SHIFT 2 2 <> T>
<ADD-OP ASHIFT 2 2 <> T>
<ADD-OP FSET? 2 2 T <>>
<ADD-OP FSET 2 2 <> <> T>
<ADD-OP FCLEAR 2 2 <> <> T>
<ADD-OP SET 2 2 <> <> T>
<ADD-OP MOVE 2 2 <> <> T>
<ADD-OP GET 2 2 <> T>
<ADD-OP GETB 2 2 <> T>
<ADD-OP GETP 2 2 <> T>
<ADD-OP GETPT 2 2 <> T>
<ADD-OP NEXTP 2 2 <> T>
<ADD-OP ADD 2 2 <> T>
<ADD-OP SUB 2 2 <> T>
<ADD-OP MUL 2 2 <> T>
<ADD-OP DIV 2 2 <> T>
<ADD-OP MOD 2 2 <> T>
<ADD-OP NOT 1 1 <> <> T>
<ADD-OP ZERO? 1 1 T <>>
<ADD-OP NEXT? 1 1 T T>
<ADD-OP FIRST? 1 1 T T>
<ADD-OP LOC 1 1 <> T>
<ADD-OP PTSIZE 1 1 <> T>
<ADD-OP INC 1 1 <> <> T>
<ADD-OP DEC 1 1 <> <> T>
<ADD-OP PUSH 1 1 <> <> T>
<ADD-OP POP 0 1 <> T T>
<ADD-OP REMOVE 1 1 <> <> T>
<ADD-OP CALL 1 8 <> T T>
<ADD-OP CALL1 1 1 <> T T>
<ADD-OP CALL2 2 2 <> T T>
<ADD-OP RETURN 1 2 <> <> T>
<ADD-OP JUMP 1 1 <> <> T>
<ADD-OP PRINT 1 1 <> <> T>
<ADD-OP RTRUE 0 0 <> <> T>
<ADD-OP RFALSE 0 0 <> <> T>
<ADD-OP PRINTI 1 1 <> <> T>
<ADD-OP PRINTR 1 1 <> <> T>
<ADD-OP CRLF 0 0 <> <> T>
<ADD-OP NOOP 0 0 <> <>>
<ADD-OP SAVE 0 3 <> T T>
<ADD-OP VERIFY 0 0 T <> T>
<ADD-OP RESTORE 0 3 <> T T>
<ADD-OP RESTART 0 0 <> <> T>
<ADD-OP QUIT 0 0 <> <> T>
<ADD-OP USL 0 0 <> <> T>
<ADD-OP RSTACK 0 0 <> <> T>
<ADD-OP FSTACK 1 2 <> <> T>
<ADD-OP PUT 3 3 <> <> T>
<ADD-OP PUTB 3 3 <> <> T>
<ADD-OP PUTP 3 3 <> <> T>
<ADD-OP READ 2 4 <> T T>
<ADD-OP PRINTC 1 1 <> <> T>
<ADD-OP PRINTN 1 1 <> <> T>
<ADD-OP PRINTB 1 1 <> <> T>
<ADD-OP PRINTD 1 1 <> <> T>
<ADD-OP VALUE 1 1 <> T>
<ADD-OP RANDOM 1 1 <> T T>
<ADD-OP SCREEN 1 1 <> <> T>
<ADD-OP SPLIT 1 1 <> <> T>
<ADD-OP CLEAR 1 1 <> <> T>
<ADD-OP SOUND 1 4 <> <> T>
<ADD-OP INPUT 1 4 <> T T>
<ADD-OP ERASE 1 1 <> <> T>
<ADD-OP CURSET 2 3 <> <> T>
<ADD-OP HLIGHT 1 1 <> <> T>
<ADD-OP CURGET 1 1 <> <> T>
<ADD-OP BUFOUT 1 1 <> <> T>
<ADD-OP DIROUT 1 3 <> <> T>
<ADD-OP DIRIN 1 2 <> <> T>
<ADD-OP AND 1 100 <> <> T>
<ADD-OP OR 1 100 <> <> T>
<ADD-OP INTBL? 3 4 T T>

<ADD-OP DO 1 100 <> <>>

<SETG OPRED [AND OR NOT]>

;"NEW XZIP OPCODES"
<ADD-OP EXTOP 0 0 <> <>>
<ADD-OP LEX 2 4 <> <> T>
<ADD-OP ZWSTR 4 4 <> <> T>
<ADD-OP ICALL1 1 1 <> <> T>
<ADD-OP ICALL2 2 2 <> <> T>
<ADD-OP ICALL 1 8 <> <> T>
<ADD-OP ORIGINAL? 0 0 T <>>
<ADD-OP COPYT 3 3 <> <> T>
<ADD-OP PRINTT 2 4 <> <> T>
<ADD-OP COLOR 2 3 <> <> T>
<ADD-OP CATCH 0 0 <> T>
<ADD-OP THROW 2 2 <> <> T>
<ADD-OP ASSIGNED? 1 1 T <>>
<ADD-OP FONT 1 2 <> T T>
<ADD-OP DISPLAY 3 3 <> <> T>
<ADD-OP PICINF 2 2 T <> T>
<ADD-OP MARGIN 2 3 <> <> T>
<ADD-OP DCLEAR 3 3 <> <> T>
;<ADD-OP XARITH 2 2 <> <>>
;<ADD-OP READY? 1 1 T <>>
<ADD-OP ISAVE 0 0 <> T T>
<ADD-OP IRESTORE 0 0 <> T T>
; "New multi-player opcodes"
<ADD-OP RTIME 1 1 <> T T>
<ADD-OP SERVER 1 1 <> T T>
<ADD-OP SEND 1 1 <> T T>
<ADD-OP PRINTMOVE 0 0 <> T T>
<ADD-OP ENDMOVE 1 1 <> T T>

; "New Yzip opcodes"
<ADD-OP WINPOS 3 3 <> <> T>
<ADD-OP WINSIZE 3 3 <> <> T>
<ADD-OP WINATTR 2 3 <> <> T>
<ADD-OP WINGET 2 2 <> T <>>
<ADD-OP WINPUT 3 3 <> <> T>
<ADD-OP SCROLL 1 2 <> <> T>
<ADD-OP XPUSH 2 2 T <> T>
<ADD-OP MOUSE-INFO 1 1 <> <> T>
<ADD-OP MOUSE-LIMIT 1 1 <> <> T>
<ADD-OP PRINTF 1 1 <> <> T>
<ADD-OP MENU 2 2 T <> T>
<ADD-OP PICSET 1 1 <> <> T>

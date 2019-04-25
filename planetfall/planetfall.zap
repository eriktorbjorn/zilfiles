	.INSERT "planetfall_freq"
	.INSERT "planetfall_data"

	.FUNCT PICK-ONE,FROB
	GET FROB,0 >STACK
	RANDOM STACK >STACK
	GET FROB,STACK >STACK
	RSTACK

	.FUNCT GO
START::
?L0:	PUTB P-LEXV,0,59
	CALL QUEUE,I-BLATHER,-1 >STACK
	PUT STACK,0,1
	CALL QUEUE,I-AMBASSADOR,-1 >STACK
	PUT STACK,0,1
	CALL QUEUE,I-RANDOM-INTERRUPTS,1 >STACK
	PUT STACK,0,1
	CALL QUEUE,I-SLEEP-WARNINGS,3600 >STACK
	PUT STACK,0,1
	CALL QUEUE,I-HUNGER-WARNINGS,2000 >STACK
	PUT STACK,0,1
	CALL QUEUE,I-SICKNESS-WARNINGS,1000 >STACK
	PUT STACK,0,1
	SET 'SPOUT-PLACED,GROUND
	RANDOM 180 >STACK
	ADD 4450,STACK >INTERNAL-MOVES
	SET 'LIT,1
	SET 'WINNER,ADVENTURER
	SET 'HERE,DECK-NINE
	SET 'P-IT-LOC,DECK-NINE
	SET 'P-IT-OBJECT,POD-DOOR
	FSET? HERE,TOUCHBIT /?L1
	CALL V-VERSION
	CRLF
	PRINTI "Another routine day of drudgery aboard the Stellar Patrol Ship Feinstein. This morning's assignment for a certain lowly Ensign Seventh Class: scrubbing the filthy metal deck at the port end of Level Nine. With your Patrol-issue self-contained multi-purpose all-weather scrub brush you shine the floor with a diligence born of the knowledge that at any moment dreaded Ensign First Class Blather, the bane of your shipboard existence, could appear."
	CRLF
	CRLF
?L1:	CALL V-LOOK
	CALL MAIN-LOOP
	JUMP ?L0

	.FUNCT I-RANDOM-INTERRUPTS
	RANDOM 90 >STACK
	ADD STACK,240 >STACK
	CALL QUEUE,I-BLOWUP-FEINSTEIN,STACK >STACK
	PUT STACK,0,1
	CALL COMM-SETUP
	RANDOM 1000 >NUMBER-NEEDED
	RETURN NUMBER-NEEDED

	.FUNCT MAIN-LOOP,ICNT,OCNT,NUM,CNT,OBJ,TBL,V,PTBL,OBJ1,TMP
?L1:	SET 'C-ELAPSED,C-ELAPSED-DEFAULT
	SET 'CNT,0
	SET 'OBJ,0
	SET 'PTBL,1
	CALL PARSER >P-WON
	ZERO? P-WON /?L3
	GET P-PRSI,P-MATCHLEN >ICNT
	GET P-PRSO,P-MATCHLEN >OCNT
	ZERO? P-IT-OBJECT /?L5
	CALL ACCESSIBLE?,P-IT-OBJECT >STACK
	ZERO? STACK /?L5
	SET 'TMP,0
?L7:	IGRTR? 'CNT,ICNT /?L8
	GET P-PRSI,CNT >STACK
	EQUAL? STACK,IT \?L7
	PUT P-PRSI,CNT,P-IT-OBJECT
	SET 'TMP,1
?L8:	ZERO? TMP \?L18
	SET 'CNT,0
?L17:	IGRTR? 'CNT,OCNT /?L18
	GET P-PRSO,CNT >STACK
	EQUAL? STACK,IT \?L17
	PUT P-PRSO,CNT,P-IT-OBJECT
?L18:	SET 'CNT,0
?L5:	ZERO? OCNT \?L27
	SET 'NUM,OCNT
	JUMP ?L34
?L27:	GRTR? OCNT,1 \?L29
	SET 'TBL,P-PRSO
	ZERO? ICNT \?L30
	SET 'OBJ,0
	JUMP ?L32
?L30:	GET P-PRSI,1 >OBJ
?L32:	SET 'NUM,OCNT
	JUMP ?L34
?L29:	GRTR? ICNT,1 \?L33
	SET 'PTBL,0
	SET 'TBL,P-PRSI
	GET P-PRSO,1 >OBJ
	SET 'NUM,ICNT
	JUMP ?L34
?L33:	SET 'NUM,1
?L34:	ZERO? OBJ \?L35
	EQUAL? ICNT,1 \?L35
	GET P-PRSI,1 >OBJ
?L35:	EQUAL? PRSA,V?WALK \?L38
	CALL PERFORM,PRSA,PRSO >V
	JUMP ?L54
?L38:	ZERO? NUM \?L40
	GETB P-SYNTAX,P-SBITS >STACK
	BAND STACK,P-SONUMS >STACK
	ZERO? STACK \?L41
	CALL PERFORM,PRSA >V
	SET 'PRSO,0
	JUMP ?L54
?L41:	PRINTI "There isn't anything to "
	GET P-ITBL,P-VERBN >TMP
	ZERO? P-OFLAG \?L48
	ZERO? P-MERGED /?L46
?L48:	GET TMP,0 >STACK
	PRINTB STACK
	JUMP ?L49
?L46:	GETB TMP,3 >STACK
	GETB TMP,2 >STACK
	CALL WORD-PRINT,STACK,STACK
?L49:	PRINTI "!"
	CRLF
	SET 'V,0
	JUMP ?L54
?L40:	SET 'TMP,0
	SET 'ICNT,0
?L53:	IGRTR? 'CNT,NUM \?L55
	GRTR? TMP,0 \?L57
	PRINTI "The "
	EQUAL? TMP,NUM /?L61
	PRINTI "other "
?L61:	PRINTI "object"
	EQUAL? TMP,1 /?L68
	PRINTI "s"
?L68:	PRINTI " that you mentioned "
	EQUAL? TMP,1 /?L75
	PRINTI "are"
	JUMP ?L79
?L75:	PRINTI "is"
?L79:	PRINTI "n't here."
	CRLF
	JUMP ?L54
?L57:	ZERO? ICNT \?L54
	PRINTI "There's nothing there."
	CRLF
	JUMP ?L54
?L55:	ZERO? PTBL /?L89
	GET P-PRSO,CNT >OBJ1
	JUMP ?L91
?L89:	GET P-PRSI,CNT >OBJ1
?L91:	ZERO? PTBL /?L92
	SET 'PRSO,OBJ1
	JUMP ?L94
?L92:	SET 'PRSO,OBJ
?L94:	ZERO? PTBL /?L95
	SET 'PRSI,OBJ
	JUMP ?L97
?L95:	SET 'PRSI,OBJ1
?L97:	GRTR? NUM,1 /?L100
	GET P-ITBL,P-NC1 >STACK
	GET STACK,0 >STACK
	EQUAL? STACK,W?ALL \?L105
?L100:	EQUAL? OBJ1,NOT-HERE-OBJECT \?L101
	INC 'TMP
	JUMP ?L53
?L101:	EQUAL? PRSA,V?TAKE \?L103
	ZERO? PRSI /?L103
	GET P-ITBL,P-NC1 >STACK
	GET STACK,0 >STACK
	EQUAL? STACK,W?ALL \?L103
	IN? PRSO,PRSI \?L53
?L103:	EQUAL? P-GETFLAGS,P-ALL \?L104
	EQUAL? PRSA,V?TAKE \?L104
	LOC OBJ1 >STACK
	EQUAL? STACK,WINNER,HERE \?L53
?L104:	EQUAL? OBJ1,IT \?L106
	PRINTD P-IT-OBJECT
	JUMP ?L108
?L106:	PRINTD OBJ1
?L108:	PRINTI ": "
?L105:	SET 'ICNT,1
	CALL PERFORM,PRSA,PRSO,PRSI >V
	EQUAL? V,M-FATAL \?L53
?L54:	EQUAL? V,M-FATAL /?L115
	LOC WINNER >STACK
	GETP STACK,P?ACTION >STACK
	CALL STACK,M-END >V
?L115:	EQUAL? PRSA,V?AGAIN /?L118
	SET 'L-PRSA,PRSA
	SET 'L-PRSO,PRSO
	SET 'L-PRSI,PRSI
?L118:	CALL INT,I-POD-TRIP >STACK
	GET STACK,C-ENABLED? >STACK
	ZERO? STACK /?L121
	SET 'C-ELAPSED,54
	JUMP ?L126
?L121:	GRTR? SHUTTLE-VELOCITY,0 \?L123
	DIV 600,SHUTTLE-VELOCITY >C-ELAPSED
	JUMP ?L126
?L123:	EQUAL? PRSA,V?TELL /?L125
	CALL TIMELESS-VERB?,PRSA >STACK
	ZERO? STACK /?L124
?L125:	SET 'C-ELAPSED,0
	JUMP ?L126
?L124:	EQUAL? PRSA,V?AGAIN \?L126
	CALL TIMELESS-VERB?,L-PRSA >STACK
	ZERO? STACK /?L126
	SET 'C-ELAPSED,0
?L126:	ADD INTERNAL-MOVES,C-ELAPSED >INTERNAL-MOVES
	EQUAL? V,M-FATAL \?L131
	SET 'P-CONT,0
	JUMP ?L131
?L3:	SET 'P-CONT,0
?L131:	IN? CHRONOMETER,ADVENTURER \?L134
	FSET? CHRONOMETER,MUNGEDBIT \?L134
?L134:	ZERO? P-WON /?L1
	ZERO? C-ELAPSED /?L1
	CALL CLOCKER >V
	JUMP ?L1

	.FUNCT TIMELESS-VERB?,VRB
	EQUAL? VRB,V?BRIEF,V?SUPER-BRIEF,V?VERBOSE /TRUE
	EQUAL? VRB,V?SAVE,V?RESTORE,V?SCORE /TRUE
	EQUAL? VRB,V?SCRIPT,V?UNSCRIPT,V?TIME /TRUE
	EQUAL? VRB,V?QUIT,V?RESTART,V?VERSION /TRUE
	EQUAL? VRB,V?$0024RANDOM,V?$0024RECORD,V?$0024UNRECORD /TRUE
	EQUAL? VRB,V?$0024COMMAND \FALSE
	RTRUE

	.FUNCT PERFORM,A,O=0,I=0,V,OA,OO,OI
	SET 'OA,PRSA
	SET 'OO,PRSO
	SET 'OI,PRSI
	EQUAL? IT,I,O \?L1
	PRINTI "I don't see what you are referring to."
	CRLF
	SET 'P-IT-OBJECT,0
	RETURN 2
?L1:	SET 'PRSA,A
	SET 'PRSO,O
	ZERO? PRSO /?L8
	EQUAL? PRSA,V?WALK /?L8
	SET 'P-IT-OBJECT,PRSO
	SET 'P-IT-LOC,HERE
?L8:	SET 'PRSI,I
	EQUAL? NOT-HERE-OBJECT,PRSO,PRSI \?L11
	CALL NOT-HERE-OBJECT-F >V
	ZERO? V /?L11
	SET 'P-WON,0
	JUMP ?L21
?L11:	SET 'O,PRSO
	ZERO? O /?L13
	SET 'I,PRSI
	ZERO? I /?L13
	CALL NULL-F >STACK
	ZERO? STACK /?L13
	PRINTI "[in case last clause changed PRSx]"
	JUMP ?L21
?L13:	GETP WINNER,P?ACTION >STACK
	CALL STACK >V
	ZERO? V \?L21
	LOC WINNER >STACK
	GETP STACK,P?ACTION >STACK
	CALL STACK,M-BEG >V
	ZERO? V \?L21
	GET PREACTIONS,A >STACK
	CALL STACK >V
	ZERO? V \?L21
	ZERO? I /?L19
	GETP I,P?ACTION >STACK
	CALL STACK >V
	ZERO? V \?L21
?L19:	ZERO? O /?L20
	EQUAL? A,V?WALK /?L20
	GETP O,P?ACTION >STACK
	CALL STACK >V
	ZERO? V \?L21
?L20:	GET ACTIONS,A >STACK
	CALL STACK >V
	ZERO? V /?L21
?L21:	SET 'PRSA,OA
	SET 'PRSO,OO
	SET 'PRSI,OI
	RETURN V

	.FUNCT META-LOC,OBJ
?L1:	ZERO? OBJ /FALSE
	IN? OBJ,GLOBAL-OBJECTS \?L5
	RETURN GLOBAL-OBJECTS
?L5:	IN? OBJ,ROOMS \?L7
	RETURN OBJ
?L7:	LOC OBJ >OBJ
	JUMP ?L1

	.FUNCT QUEUE,RTN,TICK,CINT
	CALL INT,RTN >CINT
	PUT CINT,C-TICK,TICK
	RETURN CINT

	.FUNCT INT,RTN,DEMON=0,E,C,INT?1
	ADD C-TABLE,C-TABLELEN >E
	ADD C-TABLE,C-INTS >C
?L1:	EQUAL? C,E \?L3
	SUB C-INTS,C-INTLEN >C-INTS
	ZERO? DEMON /?L5
	SUB C-DEMONS,C-INTLEN >C-DEMONS
?L5:	ADD C-TABLE,C-INTS >INT?1
	PUT INT?1,C-RTN,RTN
	RETURN INT?1
?L3:	GET C,C-RTN >STACK
	EQUAL? STACK,RTN \?L7
	RETURN C
?L7:	ADD C,C-INTLEN >C
	JUMP ?L1

	.FUNCT CLOCKER,C,E,TICK,FLG=0
	ZERO? P-WON /?L1
	PUSH C-INTS
	JUMP ?L3
?L1:	PUSH C-DEMONS
?L3:	ADD C-TABLE,STACK >C
	ADD C-TABLE,C-TABLELEN >E
?L4:	EQUAL? C,E \?L6
	RETURN FLG
?L6:	GET C,C-ENABLED? >STACK
	ZERO? STACK /?L18
	GET C,C-TICK >TICK
	ZERO? TICK /?L18
	EQUAL? TICK,-1 \?L11
	GET C,C-RTN >STACK
	CALL STACK >STACK
	ZERO? STACK /?L18
	SET 'FLG,1
	JUMP ?L18
?L11:	SUB TICK,C-ELAPSED >TICK
	PUT C,C-TICK,TICK
	GRTR? TICK,1 /?L18
	PUT C,C-TICK,0
	GET C,C-RTN >STACK
	CALL STACK >STACK
	ZERO? STACK /?L18
	SET 'FLG,1
?L18:	ADD C,C-INTLEN >C
	JUMP ?L4

	.FUNCT NULL-F,A1,A2
	RFALSE

	.FUNCT GROUND-F
	EQUAL? PRSA,V?PUT \?L1
	EQUAL? PRSI,GROUND \?L1
	CALL PERFORM,V?DROP,PRSO
	RTRUE
?L1:	EQUAL? PRSA,V?BOARD,V?CLIMB-ON \?L3
	SET 'C-ELAPSED,28
	PRINTR "You sit down on the floor. After a brief rest, you stand again."
?L3:	EQUAL? PRSA,V?EXAMINE \FALSE
	EQUAL? HERE,ADMIN-CORRIDOR-S \FALSE
	PRINTR "A narrow, jagged crevice runs across the floor."

	.FUNCT WINDOW-F
	EQUAL? PRSA,V?LOOK-INSIDE \?L1
	EQUAL? HERE,BIO-LOCK-EAST \?L3
	PRINTI "You can see a large laboratory, dimly illuminated. A blue glow comes from a crack in the northern wall of the lab. Shadowy, ominous shapes move about within the room."
	FSET? MINI-CARD,TOUCHBIT /?L7
	PRINTI " On the floor, just inside the door, you can see a magnetic-striped card."
?L7:	CRLF
	RTRUE
?L3:	EQUAL? HERE,BIO-LAB \?L12
	PRINTR "You see the Bio Lock."
?L12:	EQUAL? HERE,ALFIE-CONTROL-EAST,ALFIE-CONTROL-WEST /?L16
	EQUAL? HERE,BETTY-CONTROL-EAST,BETTY-CONTROL-WEST \?L15
?L16:	PRINTI "You see "
	CALL DESCRIBE-VIEW
	CRLF
	RTRUE
?L15:	EQUAL? HERE,BALCONY \?L21
	PRINTR "Water. Lots and lots of water."
?L21:	EQUAL? HERE,HELICOPTER \?L24
	PRINTR "You see the helipad and the ocean beyond."
?L24:	EQUAL? HERE,ESCAPE-POD \?L27
	LESS? TRIP-COUNTER,2 \?L28
	PRINTR "You can see debris from the exploding Feinstein."
?L28:	GRTR? TRIP-COUNTER,8 \?L32
	PRINTR "You can see a planet, hopefully a hospitable one."
?L32:	PRINTR "The window has polarized to blackness."
?L27:	EQUAL? HERE,LARGE-OFFICE \FALSE
	PRINTR "You can see the dormitories and other parts of the complex in the distance. Water is visible in every direction."
?L1:	EQUAL? PRSA,V?THROUGH \?L42
	EQUAL? HERE,BALCONY \?L42
	CALL JIGS-UP,STR?53 >STACK
	RSTACK
?L42:	EQUAL? PRSA,V?OPEN \?L43
	PRINTR "This window doesn't open."
?L43:	EQUAL? PRSA,V?EXAMINE \?L46
	EQUAL? HERE,BALCONY \?L46
	PRINTR "They're shattered."
?L46:	EQUAL? PRSA,V?MUNG \FALSE
	EQUAL? HERE,BALCONY \?L50
	PRINTR "They're already broken."
?L50:	PRINTR "It's made of tough Zynoid plastic."

	.FUNCT CLIFF-F
	EQUAL? HERE,WEST-WING \?L1
	EQUAL? PRSA,V?LEAP \?L3
	CALL JIGS-UP,STR?54 >STACK
	RSTACK
?L3:	EQUAL? PRSA,V?THROW-OFF \FALSE
	EQUAL? PRSO,LASER \?L6
	CALL INT,I-WARMTH >STACK
	PUT STACK,0,0
?L6:	REMOVE PRSO
	PRINTI "The "
	PRINTD PRSO
	PRINTR " falls into the ocean below."
?L1:	EQUAL? PRSA,V?CLIMB-FOO,V?CLIMB-UP \?L13
	CALL DO-WALK,P?UP >STACK
	RSTACK
?L13:	EQUAL? PRSA,V?CLIMB-DOWN \FALSE
	CALL DO-WALK,P?DOWN >STACK
	RSTACK

	.FUNCT OCEAN-F
	EQUAL? PRSA,V?RUB,V?THROUGH,V?TAKE \?L1
	PRINTR "You can't reach the ocean from here."
?L1:	EQUAL? PRSA,V?EXAMINE \FALSE
	PRINTR "It stretches as far as you can see."

	.FUNCT TABLES-F
	EQUAL? PRSA,V?LOOK-UNDER \?L1
	EQUAL? HERE,MESS-HALL \?L1
	PRINTR "Wow!!! Under the table are three keys, a sack of food, a reactor elevator access pass, one hundred gold pieces ... Just kidding. Actually, there's nothing there."
?L1:	EQUAL? PRSA,V?PUT-ON \FALSE
	EQUAL? PRSI,TABLES \FALSE
	PRINTR "That would accomplish nothing useful."

	.FUNCT SHELVES-F
	EQUAL? PRSA,V?EXAMINE \?L1
	PRINTR "The shelves are pretty dusty."
?L1:	EQUAL? PRSA,V?PUT-ON \FALSE
	EQUAL? PRSI,SHELVES \FALSE
	PRINTR "That would be a waste of time."

	.FUNCT LIGHTS-F
	EQUAL? PRSA,V?EXAMINE \FALSE
	EQUAL? HERE,COMPUTER-ROOM \FALSE
	PRINTR "The red light would seem to indicate a malfunction in the computer."

	.FUNCT GLOBAL-DOORWAY-F
	EQUAL? PRSA,V?THROUGH \?L1
	CALL USE-DIRECTIONS >STACK
	RSTACK
?L1:	EQUAL? PRSA,V?CLOSE,V?OPEN \?L3
	PRINTR "It's just an opening; you can't open or close it."
?L3:	EQUAL? PRSA,V?LOOK-INSIDE \FALSE
	PRINTR "Can't see much from here. Try going there."

	.FUNCT USE-DIRECTIONS
	PRINTR "Use compass directions for movement."

	.FUNCT NO-CLOSE
	PRINTR "There's no way to close it."

	.FUNCT CONTROLS-F
	EQUAL? HERE,UPPER-ELEVATOR,LOWER-ELEVATOR,BOOTH-1 /?L3
	EQUAL? HERE,REACTOR-ELEVATOR,BOOTH-2,BOOTH-3 \?L1
?L3:	EQUAL? PRSA,V?EXAMINE \FALSE
	PRINTR "The control panel is a simple one, as described. Just a small slot and two buttons."
?L1:	EQUAL? PRSA,V?PULL,V?PUSH,V?EXAMINE /?L10
	EQUAL? PRSA,V?TAKE,V?SET /?L10
	EQUAL? PRSA,V?TURN,V?MOVE,V?RUB \?L9
?L10:	EQUAL? HERE,HELICOPTER \?L11
	PRINTR "The controls are covered and locked."
?L11:	EQUAL? HERE,ESCAPE-POD \?L15
	PRINTR "The controls are entirely automated."
?L15:	PRINTR "The controls are incredibly complicated and you shouldn't even be thinking about touching them."
?L9:	EQUAL? HERE,HELICOPTER \FALSE
	EQUAL? PRSA,V?UNLOCK,V?OPEN \FALSE
	PRINTR "You don't even have the orange key!"

	.FUNCT GLOBAL-GAMES-F
	EQUAL? PRSA,V?PLAY \FALSE
	IN? FLOYD,HERE \?L3
	CALL PERFORM,V?PLAY-WITH,FLOYD
	RTRUE
?L3:	PRINTR "Okay. Gee, that was fun."

	.FUNCT HANDS-F
	EQUAL? PRSA,V?SHAKE \FALSE
	IN? AMBASSADOR,HERE \?L3
	PRINTR "A repulsive idea."
?L3:	IN? BLATHER,HERE \?L7
	PRINTR "Saluting might be a better idea."
?L7:	IN? FLOYD,HERE \?L10
	FSET? FLOYD,RLANDBIT \?L10
	PRINTR "You shake one of Floyd's grasping extensions."
?L10:	PRINTR "There's no one to shake hands with."

	.FUNCT SLEEP-F
	EQUAL? PRSA,V?WALK-TO \FALSE
	CALL V-SLEEP >STACK
	RSTACK

	.FUNCT CRETIN-F
	EQUAL? PRSA,V?GIVE \?L1
	CALL PERFORM,V?TAKE,PRSO
	RTRUE
?L1:	EQUAL? PRSA,V?SCRUB \?L3
	PRINTR "If only you'd done that before the last inspection, you wouldn't have gotten 300 demerits."
?L3:	EQUAL? PRSA,V?DROP \?L6
	PRINTR "Huh?"
?L6:	EQUAL? PRSA,V?SMELL \?L9
	PRINTR "Phew!"
?L9:	EQUAL? PRSA,V?FOLLOW \?L12
	PRINTR "It would be hard not to."
?L12:	EQUAL? PRSA,V?EAT \?L15
	PRINTR "Auto-cannibalism is not the answer."
?L15:	EQUAL? PRSA,V?MUNG,V?ATTACK \?L18
	EQUAL? PRSO,ME \?L19
	CALL JIGS-UP,STR?55 >STACK
	RSTACK
?L19:	PRINTR "What a silly idea!"
?L18:	EQUAL? PRSA,V?TAKE \?L24
	PRINTR "How romantic!"
?L24:	EQUAL? PRSA,V?DISEMBARK \?L27
	PRINTR "You'll have to do that on your own."
?L27:	EQUAL? PRSA,V?EXAMINE \FALSE
	PRINTR "That's difficult unless your eyes are prehensile."

	.FUNCT DDESC,DOOR
	FSET? DOOR,OPENBIT \?L1
	PRINTI "open"
	RTRUE
?L1:	PRINTI "closed"
	RTRUE

	.FUNCT ALREADY-OPEN
	PRINTR "It's already open!"

	.FUNCT IS-CLOSED
	PRINTR "It is closed!"

	.FUNCT V-THROUGH,OBJ=0,M
	ZERO? OBJ \?L7
	FSET? PRSO,VEHBIT \?L1
	CALL PERFORM,V?BOARD,PRSO
	RTRUE
?L1:	ZERO? OBJ \?L7
	FSET? PRSO,TAKEBIT /?L3
	PRINTI "You hit your head against the "
	PRINTD PRSO
	PRINTR " as you attempt this feat."
?L3:	ZERO? OBJ /?L6
?L7:	PRINTR "You can't do that!"
?L6:	IN? PRSO,WINNER \?L9
	PRINTR "That would involve quite a contortion!"
?L9:	CALL PICK-ONE,YUKS >STACK
	PRINT STACK
	CRLF
	RTRUE

	.FUNCT FIND-IN,WHERE,WHAT,W
	FIRST? WHERE >W \FALSE
?L2:	FSET? W,WHAT \?L7
	RETURN W
?L7:	NEXT? W >W /?L2
	RFALSE

	.FUNCT NOT-HERE-OBJECT-F,TBL,PRSO?=1,OBJ
	EQUAL? PRSO,NOT-HERE-OBJECT \?L5
	EQUAL? PRSI,NOT-HERE-OBJECT \?L1
	PRINTR "Those things aren't here!"
?L1:	EQUAL? PRSO,NOT-HERE-OBJECT \?L5
	SET 'TBL,P-PRSO
	JUMP ?L6
?L5:	SET 'TBL,P-PRSI
	SET 'PRSO?,0
?L6:	ZERO? PRSO? /?L18
	EQUAL? PRSA,V?TYPE \?L9
	CALL PERFORM,V?TYPE,FLOYD
	RTRUE
?L9:	EQUAL? PRSA,V?EXAMINE /?L12
	EQUAL? WINNER,FLOYD \?L18
	EQUAL? PRSA,V?FIND,V?TAKE \?L18
?L12:	CALL FIND-NOT-HERE,TBL,PRSO? >OBJ
	ZERO? OBJ /FALSE
	EQUAL? OBJ,NOT-HERE-OBJECT \TRUE
?L18:	EQUAL? WINNER,ADVENTURER \?L21
	PRINTI "You can't see any"
	CALL NOT-HERE-PRINT,PRSO?
	PRINTI " here!"
	CRLF
	EQUAL? PRSA,V?TELL \TRUE
	SET 'P-CONT,0
	SET 'QUOTE-FLAG,0
	RETURN 2
?L21:	PRINTI "The "
	PRINTD WINNER
	PRINTI " seems confused. ""I don't see any"
	CALL NOT-HERE-PRINT,PRSO?
	PRINTR " here!"""

	.FUNCT FIND-NOT-HERE,TBL,PRSO?,M-F,OBJ
	CALL MOBY-FIND,TBL >M-F
	EQUAL? 1,M-F \?L1
	ZERO? PRSO? /?L3
	SET 'PRSO,P-MOBY-FOUND
	RFALSE
?L3:	SET 'PRSI,P-MOBY-FOUND
	RFALSE
?L1:	ZERO? PRSO? \?L6
	PRINTI "You wouldn't find any"
	CALL NOT-HERE-PRINT,PRSO?
	PRINTR " there."
?L6:	RETURN NOT-HERE-OBJECT

	.FUNCT NOT-HERE-PRINT,PRSO?
	ZERO? P-OFLAG \?L3
	ZERO? P-MERGED /?L1
?L3:	ZERO? P-XADJ /?L4
	PRINTI " "
	PRINTB P-XADJN
?L4:	ZERO? P-XNAM /FALSE
	PRINTI " "
	PRINTB P-XNAM
	RTRUE
?L1:	ZERO? PRSO? /?L14
	GET P-ITBL,P-NC1L >STACK
	GET P-ITBL,P-NC1 >STACK
	CALL BUFFER-PRINT,STACK,STACK,0 >STACK
	RSTACK
?L14:	GET P-ITBL,P-NC2L >STACK
	GET P-ITBL,P-NC2 >STACK
	CALL BUFFER-PRINT,STACK,STACK,0 >STACK
	RSTACK

	.FUNCT DECK-NINE-F,RARG
	EQUAL? RARG,M-LOOK \FALSE
	PRINTI "This is a featureless corridor similar to every other corridor on the ship. It curves away to starboard, and a gangway leads up"
	FSET? GANGWAY-DOOR,OPENBIT \?L5
	PRINTI "."
	JUMP ?L9
?L5:	PRINTI ", but both of these are blocked by closed bulkheads."
?L9:	PRINTI " To port is the entrance to one of the ship's primary escape pods. The pod bulkhead is "
	CALL DDESC,POD-DOOR
	PRINTR "."

	.FUNCT CHRONOMETER-F
	EQUAL? PRSA,V?READ,V?EXAMINE \FALSE
	PRINTI "It is a standard wrist chronometer with a digital display. "
	CALL TELL-TIME
	PRINTR " The back is engraved with the message ""Good luck in the Patrol! Love, Mom and Dad."""

	.FUNCT TELL-TIME
	PRINTI "According to the chronometer, the current time is "
	FSET? CHRONOMETER,MUNGEDBIT \?L3
	PRINTN MUNGED-TIME
	JUMP ?L7
?L3:	PRINTN INTERNAL-MOVES
?L7:	PRINTI "."
	RTRUE

	.FUNCT PATROL-UNIFORM-F
	EQUAL? PRSA,V?EXAMINE \?L1
	PRINTI "It is a standard-issue one-pocket Stellar Patrol uniform, a miracle of modern technology. It will keep its owner warm in cold climates and cool in warm locales. It provides protection against mild radiation, repels all insects, absorbs sweat, promotes healthy skin tone, and on top of everything else, it is super-comfy."
	EQUAL? TRIP-COUNTER,15 \?L5
	PRINTI " There are definitely worse things to find yourself wearing when stranded on a strange planet."
?L5:	CRLF
	RTRUE
?L1:	EQUAL? PRSA,V?WEAR \?L12
	FSET? LAB-UNIFORM,WORNBIT \?L12
	PRINTR "It won't fit over the lab uniform."
?L12:	EQUAL? PRSA,V?TAKE-OFF \?L15
	FSET? PATROL-UNIFORM,WORNBIT \?L15
	FCLEAR PATROL-UNIFORM,WORNBIT
	PRINTI "You have removed your Patrol uniform."
	EQUAL? TRIP-COUNTER,15 \?L18
	PRINTI " You suddenly realize how warm it is. You also feel naked and vulnerable."
?L18:	IN? BLATHER,HERE \?L23
	PRINTR " ""Removing your uniform while on duty? Five hundred demerits!"""
?L23:	IN? FLOYD,HERE \?L27
	PRINTI " Floyd giggles. ""You look funny without any clothes on."""
?L27:	CRLF
	RTRUE
?L15:	EQUAL? PRSA,V?CLOSE,V?OPEN \FALSE
	PRINTI "There's no way to open or close the pocket of the "
	PRINTD PRSO
	PRINTR "."

	.FUNCT GANGWAY-F,RARG
	EQUAL? RARG,M-END \FALSE
	RANDOM 100 >STACK
	LESS? 15,STACK /FALSE
	ZERO? BLOWUP-COUNTER \FALSE
	PRINTR "You hear a distant bellowing ... something about an Ensign Seventh Class whose life is in danger."

	.FUNCT I-BLATHER
	EQUAL? HERE,DECK-EIGHT,REACTOR-LOBBY \?L1
	IN? BLATHER,HERE \?L3
	IGRTR? 'BRIGS-UP,3 \?L5
	CRLF
	PRINTI "Blather loses his last vestige of patience and drags you to the Feinstein's brig. He throws you in, and the door clangs shut behind you."
	CRLF
	CRLF
	CALL GOTO,BRIG
	CALL ROB,ADVENTURER,CRAG
	MOVE PADLOCK,HERE
	FCLEAR PADLOCK,TAKEBIT
	RTRUE
?L5:	CRLF
	PRINTR """I said to return to your post, Ensign Seventh Class!"" bellows Blather, turning a deepening shade of crimson."
?L3:	ZERO? BLOWUP-COUNTER \FALSE
	MOVE BLATHER,HERE
	CALL THIS-IS-IT,BLATHER
	CRLF
	PRINTR "Ensign Blather, his uniform immaculate, enters and notices you are away from your post. ""Twenty demerits, Ensign Seventh Class!"" bellows Blather. ""Forty if you're not back on Deck Nine in five seconds!"" He curls his face into a hideous mask of disgust at your unbelievable negligence."
?L1:	EQUAL? HERE,DECK-NINE \FALSE
	EQUAL? BLATHER-LEAVE,3 \?L17
	IN? BLATHER,HERE \?L17
	SET 'BLATHER-LEAVE,0
	REMOVE BLATHER
	CRLF
	PRINTR "Blather, adding fifty more demerits for good measure, moves off in search of more young ensigns to terrorize."
?L17:	IN? BLATHER,DECK-NINE \?L21
	INC 'BLATHER-LEAVE
	RFALSE
?L21:	IN? AMBASSADOR,HERE /FALSE
	ZERO? BLOWUP-COUNTER \FALSE
	RANDOM 100 >STACK
	LESS? 5,STACK /FALSE
	MOVE BLATHER,HERE
	CALL THIS-IS-IT,BLATHER
	CRLF
	PRINTI "Ensign First Class Blather swaggers in. He studies your work with half-closed eyes. ""You call this polishing, Ensign Seventh Class?"" he sneers. ""We have a position for an Ensign Ninth Class in the toilet-scrubbing division, you know. Thirty demerits."
	FSET? PATROL-UNIFORM,WORNBIT /?L25
	PRINTI " And another sixty for improper dress!"
?L25:	PRINTR """ He glares at you, his arms crossed."

	.FUNCT BLATHER-F
	EQUAL? PRSA,V?HELLO,V?TELL,V?TALK \?L1
	PRINTI "Blather shouts ""Speak when you're spoken to, Ensign Seventh Class!"" He breaks three pencil points in a frenzied rush to give you more demerits."
	CRLF
	SET 'P-CONT,0
	SET 'QUOTE-FLAG,0
	RETURN 2
?L1:	EQUAL? PRSA,V?KICK,V?ATTACK \?L7
	CALL JIGS-UP,STR?56 >STACK
	RSTACK
?L7:	EQUAL? PRSA,V?SALUTE \?L8
	PRINTR "Blather's sneer softens a bit. ""First right thing you've done today. Only five demerits."""
?L8:	EQUAL? PRSA,V?THROW \?L11
	EQUAL? BLATHER,PRSI \?L11
	MOVE PRSO,HERE
	PRINTI "The "
	PRINTD PRSO
	PRINTR " bounces off Blather's bulbous nose. He becomes livid, orders you to do five hundred push-ups, gives you ten thousand demerits, and assigns you five years of extra galley duty."
?L11:	EQUAL? PRSA,V?EXAMINE \?L14
	PRINTR "Ensign Blather is a tall, beefy officer with a tremendous, misshapen nose. His uniform is perfect in every respect, and the crease in his trousers could probably slice diamonds in half."
?L14:	EQUAL? PRSA,V?TAKE \FALSE
	PRINTR "Blather brushes you away, muttering about suspended shore leave."

	.FUNCT CELERY-F
	EQUAL? PRSA,V?EAT \?L1
	CALL JIGS-UP,STR?57 >STACK
	RSTACK
?L1:	EQUAL? PRSA,V?TAKE \FALSE
	PRINTR "The ambassador seems perturbed by your lack of normal protocol."

	.FUNCT I-AMBASSADOR
	GRTR? AMBASSADOR-LEAVE,2 \?L1
	IN? AMBASSADOR,HERE \?L1
	REMOVE AMBASSADOR
	REMOVE CELERY
	EQUAL? HERE,DECK-NINE \?L3
	CRLF
	PRINTI "The ambassador grunts a polite farewell, and disappears up the gangway, leaving a trail of dripping slime."
	CRLF
?L3:	CALL INT,I-AMBASSADOR >STACK
	PUT STACK,0,0
	RTRUE
?L1:	IN? AMBASSADOR,DECK-NINE \?L8
	INC 'AMBASSADOR-LEAVE
	EQUAL? HERE,DECK-NINE \FALSE
	CRLF
	PRINTI "The ambassador "
	CALL PICK-ONE,AMBASSADOR-QUOTES >STACK
	PRINT STACK
	CRLF
	RTRUE
?L8:	EQUAL? HERE,DECK-NINE \FALSE
	IN? AMBASSADOR,HERE /FALSE
	IN? BLATHER,HERE /FALSE
	ZERO? BLOWUP-COUNTER \FALSE
	RANDOM 100 >STACK
	LESS? 15,STACK /FALSE
	MOVE AMBASSADOR,HERE
	MOVE CELERY,HERE
	CALL THIS-IS-IT,AMBASSADOR
	MOVE BROCHURE,ADVENTURER
	CRLF
	PRINTR "The alien ambassador from the planet Blow'k-bibben-Gordo ambles toward you from down the corridor. He is munching on something resembling an enormous stalk of celery, and he leaves a trail of green slime on the deck. He stops nearby, and you wince as a pool of slime begins forming beneath him on your newly-polished deck. The ambassador wheezes loudly and hands you a brochure outlining his planet's major exports."

	.FUNCT AMBASSADOR-F
	EQUAL? PRSA,V?HELLO,V?TELL,V?TALK \?L1
	PRINTI "The ambassador taps his translator, and then touches his center knee to his left ear (the Blow'k-bibben-Gordoan equivalent of shrugging)."
	CRLF
	SET 'P-CONT,0
	SET 'QUOTE-FLAG,0
	RETURN 2
?L1:	EQUAL? PRSA,V?ASK-FOR \?L7
	EQUAL? PRSI,CELERY \?L7
	PRINTR "The ambassador seems willing to let you eat some of it, but I doubt he wants to part with the entire stalk."
?L7:	EQUAL? PRSA,V?KICK,V?ATTACK \?L10
	PRINTR "The ambassador is startled, and emits an amazing quantity of slime which spreads across the section of the deck you just polished."
?L10:	EQUAL? PRSA,V?EXAMINE \?L13
	PRINTR "The ambassador has around twenty eyes, seven of which are currently open. Half of his six legs are retracted. Green slime oozes from multiple orifices in his scaly skin. He speaks through a mechanical translator slung around his neck."
?L13:	EQUAL? PRSA,V?LISTEN \FALSE
	PRINTR "The alien makes a wheezing noise as he breathes."

	.FUNCT GLOBAL-POD-F
	EQUAL? PRSA,V?WALK-TO,V?BOARD,V?THROUGH \?L1
	EQUAL? HERE,ESCAPE-POD \?L3
	PRINTR "You're already in it!"
?L3:	CALL DO-WALK,P?WEST
	RTRUE
?L1:	EQUAL? PRSA,V?DROP,V?DISEMBARK,V?EXIT \?L8
	EQUAL? HERE,DECK-NINE \?L9
	PRINTR "You're not in it!"
?L9:	CALL DO-WALK,P?OUT
	RTRUE
?L8:	EQUAL? PRSA,V?OPEN \FALSE
	CALL PERFORM,V?OPEN,POD-DOOR
	RTRUE

	.FUNCT POD-EXIT-F
	GRTR? BLOWUP-COUNTER,4 \?L1
	EQUAL? PRSO,P?EAST \?L3
	PRINT CANT-GO
	CRLF
	RFALSE
?L3:	FSET? POD-DOOR,OPENBIT /?L7
	PRINTI "The pod door is closed."
	CRLF
	RFALSE
?L7:	SET 'C-ELAPSED,30
	RETURN UNDERWATER
?L1:	EQUAL? PRSO,P?UP \?L12
	PRINT CANT-GO
	CRLF
	RFALSE
?L12:	FSET? POD-DOOR,OPENBIT /?L16
	PRINTI "The pod door is closed."
	CRLF
	RFALSE
?L16:	RETURN DECK-NINE

	.FUNCT SAFETY-WEB-F,RARG=M-OBJECT
	EQUAL? PRSA,V?EXAMINE \?L1
	EQUAL? RARG,M-OBJECT \?L1
	PRINTR "The safety webbing fills most of the pod. It could accomodate from one to, perhaps, twenty people."
?L1:	EQUAL? PRSA,V?TAKE \?L5
	EQUAL? RARG,M-OBJECT \?L5
	PRINTR "The safety web seems to be more intended for getting into than grabbing onto."
?L5:	EQUAL? PRSA,V?CLIMB-ON,V?BOARD \?L8
	EQUAL? RARG,M-OBJECT \?L8
	MOVE ADVENTURER,SAFETY-WEB
	PRINTR "You are now safely cushioned within the web."
?L8:	EQUAL? PRSA,V?TAKE,V?OPEN \?L11
	EQUAL? RARG,M-BEG \?L11
	EQUAL? PRSO,SAFETY-WEB \?L12
	PRINTR "You're in it!"
?L12:	PRINTR "You can't reach it from here."
?L11:	EQUAL? PRSA,V?WALK \?L19
	EQUAL? RARG,M-BEG \?L19
	PRINTR "You'll have to stand up, first."
?L19:	EQUAL? PRSA,V?STAND /?L23
	EQUAL? PRSA,V?DROP,V?DISEMBARK,V?EXIT \FALSE
?L23:	EQUAL? RARG,M-OBJECT \FALSE
	IN? ADVENTURER,SAFETY-WEB \FALSE
	MOVE ADVENTURER,HERE
	GRTR? TRIP-COUNTER,14 \?L24
	CALL INT,I-SINK-POD >STACK
	GET STACK,C-ENABLED? >STACK
	ZERO? STACK \?L24
	CALL QUEUE,I-SINK-POD,-1 >STACK
	PUT STACK,0,1
	PRINTR "As you stand, the pod shifts slightly and you feel it falling. A moment later, the fall stops with a shock, and you see water rising past the viewport."
?L24:	PRINTR "You are standing again."

	.FUNCT TOWEL-F
	EQUAL? PRSA,V?EXAMINE \FALSE
	PRINTR "A pretty ordinary towel. Something is written in its corner."

	.FUNCT FOOD-KIT-F
	EQUAL? PRSA,V?EMPTY \FALSE
	FSET? FOOD-KIT,OPENBIT /?L3
	PRINTR "The kit is closed!"
?L3:	FIRST? PRSO >STACK \FALSE
	PRINTR "The goo, being gooey, sticks to the inside of the kit. You would probably have to shake the kit to get the goo out."

	.FUNCT GOO-F
	EQUAL? PRSA,V?EAT \?L1
	ZERO? HUNGER-LEVEL \?L3
	PRINT NOT-HUNGRY
	CRLF
	RTRUE
?L3:	IN? FOOD-KIT,ADVENTURER /?L7
	SET 'PRSO,FOOD-KIT
	CALL NOT-HOLDING
	CALL THIS-IS-IT,FOOD-KIT >STACK
	RSTACK
?L7:	REMOVE PRSO
	SET 'C-ELAPSED,15
	SET 'HUNGER-LEVEL,0
	CALL QUEUE,I-HUNGER-WARNINGS,1450 >STACK
	PUT STACK,0,1
	PRINTI "Mmmm...that tasted just like "
	EQUAL? PRSO,BROWN-GOO \?L11
	PRINTI "delicious Nebulan fungus pudding"
	JUMP ?L18
?L11:	EQUAL? PRSO,RED-GOO \?L15
	PRINTI "scrumptious cherry pie"
	JUMP ?L18
?L15:	PRINTI "yummy lima beans"
?L18:	PRINTR "."
?L1:	EQUAL? PRSA,V?DROP,V?TAKE \FALSE
	EQUAL? PRSA,V?DROP \?L24
	PRINTI "The goo, being gooey, sticks where it is"
	JUMP ?L28
?L24:	EQUAL? PRSA,V?TAKE \?L28
	PRINTI "It would ooze through your fingers"
?L28:	PRINTR ". You'll have to eat it right from the survival kit."

	.FUNCT ESCAPE-POD-F,RARG
	EQUAL? RARG,M-LOOK \FALSE
	PRINTI "This is one of the Feinstein's primary escape pods, for use in extreme emergencies. A mass of safety webbing, large enough to hold several dozen people, fills half the pod. The controls are entirely automated. The bulkhead leading out is "
	CALL DDESC,POD-DOOR
	PRINTR "."

	.FUNCT POD-DOOR-F
	EQUAL? PRSA,V?OPEN \?L1
	FSET? POD-DOOR,OPENBIT \?L3
	CALL ALREADY-OPEN >STACK
	RSTACK
?L3:	GRTR? TRIP-COUNTER,14 \?L5
	FSET POD-DOOR,OPENBIT
	PRINTR "The bulkhead opens and cold ocean water rushes in!"
?L5:	GRTR? BLOWUP-COUNTER,0 \?L8
	EQUAL? HERE,DECK-NINE \?L9
	PRINTR "Too late. The pod's launching procedure has already begun."
?L9:	PRINTR "Opening the door now would be a phenomenally stupid idea."
?L8:	PRINTR "Why open the door to the emergency escape pod if there's no emergency?"
?L1:	EQUAL? PRSA,V?CLOSE \?L19
	FSET? POD-DOOR,OPENBIT /?L20
	CALL IS-CLOSED >STACK
	RSTACK
?L20:	PRINTR "You can't close it yourself."
?L19:	EQUAL? PRSA,V?THROUGH \FALSE
	EQUAL? HERE,DECK-NINE \?L26
	CALL DO-WALK,P?WEST >STACK
	RSTACK
?L26:	CALL DO-WALK,P?OUT >STACK
	RSTACK

	.FUNCT GANGWAY-DOOR-F
	EQUAL? PRSA,V?OPEN \?L1
	FSET? PRSO,OPENBIT \?L3
	CALL ALREADY-OPEN >STACK
	RSTACK
?L3:	PRINTR "There doesn't seem to be any way to open it."
?L1:	EQUAL? PRSA,V?CLOSE \FALSE
	FSET? PRSO,OPENBIT \?L9
	PRINTR "You can't close it yourself."
?L9:	CALL IS-CLOSED >STACK
	RSTACK

	.FUNCT I-BLOWUP-FEINSTEIN
	CALL QUEUE,I-BLOWUP-FEINSTEIN,-1 >STACK
	PUT STACK,0,1
	INC 'BLOWUP-COUNTER
	EQUAL? BLOWUP-COUNTER,5 \?L1
	EQUAL? HERE,DECK-NINE \?L3
	CALL JIGS-UP,STR?58 >STACK
	RSTACK
?L3:	CRLF
	PRINTI "Through the viewport of the pod you see the Feinstein dwindle as you head away. Bursts of light dot its hull. Suddenly, a huge explosion blows the Feinstein into tiny pieces, sending the escape pod tumbling away! "
	CRLF
	CALL QUEUE,I-POD-TRIP,-1 >STACK
	PUT STACK,0,1
	CALL INT,I-BLOWUP-FEINSTEIN >STACK
	PUT STACK,0,0
	IN? WINNER,SAFETY-WEB /FALSE
	RANDOM 100 >STACK
	LESS? 20,STACK /?L8
	CALL JIGS-UP,STR?59 >STACK
	RSTACK
?L8:	IN? WINNER,SAFETY-WEB /FALSE
	CRLF
	PRINTR "You are thrown against the bulkhead, bruising a few limbs. The safety webbing might have offered a bit more protection."
?L1:	EQUAL? BLOWUP-COUNTER,4 \?L14
	CALL INT,I-BLATHER >STACK
	PUT STACK,0,0
	CALL INT,I-AMBASSADOR >STACK
	PUT STACK,0,0
	EQUAL? HERE,DECK-NINE \?L15
	CRLF
	PRINTR "Explosions continue to rock the ship."
?L15:	CRLF
	PRINTR "You feel the pod begin to slide down its ejection tube as explosions shake the mother ship."
?L14:	EQUAL? BLOWUP-COUNTER,3 \?L22
	FCLEAR POD-DOOR,OPENBIT
	EQUAL? HERE,DECK-NINE \?L23
	CRLF
	PRINTR "More powerful explosions buffet the ship. The lights flicker madly, and the escape-pod bulkhead clangs shut."
?L23:	EQUAL? HERE,ESCAPE-POD \?L27
	CRLF
	PRINTR "The pod door clangs shut as heavy explosions continue to buffet the Feinstein."
?L27:	CALL JIGS-UP,STR?60 >STACK
	RSTACK
?L22:	EQUAL? BLOWUP-COUNTER,2 \?L31
	FCLEAR CORRIDOR-DOOR,OPENBIT
	FCLEAR CORRIDOR-DOOR,INVISIBLE
	FCLEAR GANGWAY-DOOR,OPENBIT
	FCLEAR GANGWAY-DOOR,INVISIBLE
	EQUAL? HERE,DECK-NINE \?L32
	CRLF
	PRINTR "More distant explosions! A narrow emergency bulkhead at the base of the gangway and a wider one along the corridor to starboard both crash shut!"
?L32:	EQUAL? HERE,ESCAPE-POD,BRIG \?L36
	CRLF
	PRINTR "The ship shakes again. You hear, from close by, the sounds of emergency bulkheads closing."
?L36:	EQUAL? HERE,GANGWAY \?L39
	CRLF
	PRINTR "Another explosion. A narrow bulkhead at the base of the gangway slams shut!"
?L39:	CRLF
	PRINTI "You are deafened by more explosions and by the sound of emergency bulkheads slamming closed. "
	IN? BLATHER,HERE \?L45
	PRINTI "Blather, foaming slightly at the mouth, screams at you to swab the decks"
	JUMP ?L49
?L45:	MOVE BLATHER,HERE
	PRINTI "Blather enters, looking confused, and begins ranting madly at you"
?L49:	PRINTR "."
?L31:	EQUAL? BLOWUP-COUNTER,1 \FALSE
	SET 'BRIGS-UP,0
	FSET POD-DOOR,OPENBIT
	CRLF
	PRINTI "A massive explosion rocks the ship. Echoes from the explosion resound deafeningly down the halls. "
	EQUAL? HERE,DECK-NINE \?L57
	PRINTI "The door to port slides open. "
	IN? AMBASSADOR,HERE \?L61
	REMOVE AMBASSADOR
	REMOVE CELERY
	PRINTR "The ambassador squawks frantically, evacuates a massive load of gooey slime, and rushes away."
?L61:	IN? BLATHER,HERE \?L65
	REMOVE BLATHER
	PRINTR "Blather, confused by this non-routine occurrence, orders you to continue scrubbing the floor, and then dashes off."
?L65:	CRLF
	RTRUE
?L57:	EQUAL? HERE,ESCAPE-POD,GANGWAY,BRIG \?L71
	CRLF
	RTRUE
?L71:	PRINTR "Blather, looking slightly disoriented, barks at you to resume your assigned duties."

	.FUNCT I-POD-TRIP
	INC 'TRIP-COUNTER
	EQUAL? TRIP-COUNTER,1 \?L1
	CRLF
	PRINTR "As the escape pod tumbles away from the former location of the Feinstein, its gyroscopes whine. The pod slowly stops tumbling. Lights on the control panel blink furiously as the autopilot searches for a reasonable destination."
?L1:	EQUAL? TRIP-COUNTER,2 \?L5
	CRLF
	PRINTR "The auxiliary rockets fire briefly, and a nearby planet swings into view through the port. It appears to be almost entirely ocean, with just a few visible islands and an unusually small polar ice cap. A moment later, the system's sun swings into view, and the viewport polarizes into a featureless black rectangle."
?L5:	EQUAL? TRIP-COUNTER,3 \?L8
	CRLF
	PRINTR "The main thrusters fire a long, gentle burst. A monotonic voice issues from the control panel. ""Approaching planet...human-habitable."""
?L8:	EQUAL? TRIP-COUNTER,7 \?L11
	CRLF
	PRINTR "The pod is buffeted as it enters the planet's atmosphere."
?L11:	EQUAL? TRIP-COUNTER,8 \?L14
	CRLF
	PRINTR "You feel the temperature begin to rise, and the pod's climate control system roars as it labors to compensate."
?L14:	EQUAL? TRIP-COUNTER,9 \?L17
	CRLF
	PRINTR "The viewport suddenly becomes transparent again, giving you a view of endless ocean below. The lights on the control panel flash madly as the pod's computer searches for a suitable landing site. The thrusters fire long and hard, slowing the pod's descent."
?L17:	EQUAL? TRIP-COUNTER,10 \?L20
	CRLF
	PRINTR "The pod is now approaching the closer of a pair of islands. It appears to be surrounded by sheer cliffs rising from the water, and is topped by a wide plateau. The plateau seems to be covered by a sprawling complex of buildings."
?L20:	EQUAL? TRIP-COUNTER,11 \FALSE
	IN? WINNER,SAFETY-WEB \?L24
	MOVE FOOD-KIT,HERE
	MOVE TOWEL,HERE
	CRLF
	PRINTI "The pod lands with a thud. Through the viewport you can see a rocky cleft and some water below. The pod rocks gently back and forth as if it was precariously balanced. A previously unseen panel slides open, revealing some emergency provisions, including a survival kit and a towel."
	CRLF
	SET 'TRIP-COUNTER,15
	CALL INT,I-POD-TRIP >STACK
	PUT STACK,0,0
	RTRUE
?L24:	CALL JIGS-UP,STR?61 >STACK
	RSTACK

	.FUNCT I-SINK-POD
	INC 'SINK-COUNTER
	EQUAL? SINK-COUNTER,3 \?L1
	EQUAL? HERE,ESCAPE-POD \?L1
	CRLF
	PRINTR "The pod is now completely submerged, and you feel it smash against underwater rocks. Bubbles streaming upward past the window indicate that the pod is continuing to sink."
?L1:	EQUAL? SINK-COUNTER,4 \?L5
	EQUAL? HERE,ESCAPE-POD \?L5
	FSET? POD-DOOR,OPENBIT /?L5
	CRLF
	PRINTR "The pod creaks ominously from the increasing pressure."
?L5:	EQUAL? SINK-COUNTER,5 \FALSE
	EQUAL? HERE,ESCAPE-POD \FALSE
	FSET? POD-DOOR,OPENBIT \?L9
	CALL JIGS-UP,STR?62 >STACK
	RSTACK
?L9:	CALL JIGS-UP,STR?63 >STACK
	RSTACK

	.FUNCT SLOT-F
	EQUAL? PRSA,V?PUT \?L1
	EQUAL? SLOT,PRSI \?L1
	PRINTR "The slot is shallow, so you can't put anything in it. It may be possible to slide something through the slot, though."
?L1:	EQUAL? PRSA,V?EXAMINE \?L5
	PRINTR "The slot is about ten centimeters wide, but only about two centimeters deep. It is surrounded on its long sides by parallel ridges of metal."
?L5:	EQUAL? PRSA,V?SLIDE \FALSE
	EQUAL? SLOT,PRSI \FALSE
	MOVE PRSO,ADVENTURER
	FSET? PRSO,SCRAMBLEDBIT \?L9
	PRINTR "A sign flashes ""Magnetik striip randumiizd...konsult Prajekt Handbuk abowt propur kaar uv awtharazaashun kardz."""
?L9:	EQUAL? PRSO,KITCHEN-CARD \?L13
	EQUAL? HERE,MESS-HALL \?L14
	FSET? KITCHEN-DOOR,OPENBIT \?L16
	PRINTR "Nothing happens."
?L16:	FSET KITCHEN-DOOR,OPENBIT
	CALL QUEUE,I-KITCHEN-DOOR-CLOSES,50 >STACK
	PUT STACK,0,1
	PRINTI "The kitchen door quietly slides open."
	CRLF
	CALL FLOYD-REVEAL-CARD-F
	RTRUE
?L14:	PRINT WRONG-CARD
	CRLF
	RTRUE
?L13:	EQUAL? PRSO,UPPER-ELEVATOR-CARD \?L26
	EQUAL? HERE,UPPER-ELEVATOR \?L27
	SET 'UPPER-ELEVATOR-ON,1
	CALL QUEUE,I-TURNOFF-UPPER-ELEVATOR,180 >STACK
	PUT STACK,0,1
	PRINT ELEVATOR-ENABLED
	CRLF
	CALL FLOYD-REVEAL-CARD-F
	RTRUE
?L27:	PRINT WRONG-CARD
	CRLF
	RTRUE
?L26:	EQUAL? PRSO,LOWER-ELEVATOR-CARD \?L34
	EQUAL? HERE,LOWER-ELEVATOR \?L35
	SET 'LOWER-ELEVATOR-ON,1
	CALL QUEUE,I-TURNOFF-LOWER-ELEVATOR,200 >STACK
	PUT STACK,0,1
	PRINT ELEVATOR-ENABLED
	CRLF
	RTRUE
?L35:	PRINT WRONG-CARD
	CRLF
	RTRUE
?L34:	EQUAL? PRSO,TELEPORTATION-CARD \?L42
	EQUAL? HERE,BOOTH-1,BOOTH-2,BOOTH-3 \?L43
	SET 'TELEPORTATION-ON,1
	CALL QUEUE,I-TURNOFF-TELEPORTATION,30 >STACK
	PUT STACK,0,1
	PRINTR "Nothing happens for a moment. Then a light flashes ""Redee."""
?L43:	PRINT WRONG-CARD
	CRLF
	RTRUE
?L42:	EQUAL? PRSO,SHUTTLE-CARD \?L50
	CALL SHUTTLE-ACTIVATE >STACK
	RSTACK
?L50:	EQUAL? PRSO,MINI-CARD \?L51
	EQUAL? HERE,MINI-BOOTH \?L52
	SET 'MINI-ACTIVATED,1
	CALL QUEUE,I-TURNOFF-MINI,30 >STACK
	PUT STACK,0,1
	PRINTR "A melodic high-pitched voice says ""Miniaturization and teleportation booth activated. Please type in damaged sector number."""
?L52:	PRINT WRONG-CARD
	CRLF
	RTRUE
?L51:	EQUAL? PRSO,ID-CARD \FALSE
	PRINT WRONG-CARD
	CRLF
	RTRUE

	.FUNCT FLOYD-REVEAL-CARD-F
	IN? FLOYD,HERE \FALSE
	ZERO? CARD-REVEALED \FALSE
	EQUAL? DAY,2 \?L5
	LESS? INTERNAL-MOVES,5000 \?L4
	RANDOM 100 >STACK
	LESS? 5,STACK \?L3
?L4:	EQUAL? DAY,2 \?L5
	GRTR? INTERNAL-MOVES,4999 \?L5
	RANDOM 100 >STACK
	LESS? 10,STACK \?L3
?L5:	EQUAL? DAY,3 \?L7
	LESS? INTERNAL-MOVES,5000 \?L6
	RANDOM 100 >STACK
	LESS? 20,STACK \?L3
?L6:	EQUAL? DAY,3 \?L7
	GRTR? INTERNAL-MOVES,4999 \?L7
	RANDOM 100 >STACK
	LESS? 40,STACK \?L3
?L7:	GRTR? DAY,3 \FALSE
?L3:	SET 'CARD-REVEALED,1
	SET 'FLOYD-SPOKE,1
	ZERO? CARD-STOLEN \?L8
	MOVE LOWER-ELEVATOR-CARD,FLOYD
	PRINTR "Floyd claps his hands with excitement. ""Those cards are really neat, huh? Floyd has one for himself--see?"" He reaches behind one of his panels and retrieves a magnetic-striped card. He waves it exuberantly in the air."
?L8:	PRINTR "Floyd bobs up and down with excitement. ""Those cards are really neat! Floyd has one, too."" He begins searching through his compartments, but finds nothing. He scratches his head and looks confused."

	.FUNCT I-KITCHEN-DOOR-CLOSES
	EQUAL? HERE,KITCHEN \?L1
	CALL QUEUE,I-KITCHEN-DOOR-CLOSES,-1 >STACK
	PUT STACK,0,1
	RFALSE
?L1:	FCLEAR KITCHEN-DOOR,OPENBIT
	CALL INT,I-KITCHEN-DOOR-CLOSES >STACK
	PUT STACK,0,0
	EQUAL? HERE,MESS-HALL \FALSE
	CRLF
	PRINTR "The kitchen door slides quietly closed."

	.FUNCT TELEPORT,BOOTH
	EQUAL? PRSA,V?PUSH \FALSE
	EQUAL? TELEPORTATION-ON,1 \?L3
	PRINTI "You experience a strange feeling in the pit of your stomach."
	CRLF
	IN? FLOYD,HERE \?L7
	PRINTI "Floyd gives a terrified squeal, and clutches at his guidance mechanism."
	CRLF
	SET 'FLOYD-SPOKE,1
	CALL QUEUE,I-FLOYD,1 >STACK
	PUT STACK,0,1
?L7:	CALL ROB,HERE,BOOTH
	CALL GOTO,BOOTH,0
	CALL INT,I-TURNOFF-TELEPORTATION >STACK
	PUT STACK,0,0
	SET 'TELEPORTATION-ON,0
	RTRUE
?L3:	PRINTR "A sign flashes ""Teleportaashun buux not aktivaatid."""

	.FUNCT TELEPORTATION-BUTTON-1-F
	CALL TELEPORT,BOOTH-1 >STACK
	RSTACK

	.FUNCT TELEPORTATION-BUTTON-2-F
	CALL TELEPORT,BOOTH-2 >STACK
	RSTACK

	.FUNCT TELEPORTATION-BUTTON-3-F
	CALL TELEPORT,BOOTH-3 >STACK
	RSTACK

	.FUNCT I-TURNOFF-TELEPORTATION
	SET 'TELEPORTATION-ON,0
	EQUAL? HERE,BOOTH-1,BOOTH-2,BOOTH-3 \FALSE
	CRLF
	PRINTR "The ready light goes dark."

	.FUNCT GLOBAL-SHUTTLE-F
	EQUAL? PRSA,V?BOARD /?L3
	EQUAL? PRSA,V?WALK-TO,V?THROUGH,V?ENTER \?L1
?L3:	EQUAL? HERE,SHUTTLE-CAR-ALFIE,ALFIE-CONTROL-EAST,ALFIE-CONTROL-WEST /?L6
	EQUAL? HERE,SHUTTLE-CAR-BETTY,BETTY-CONTROL-EAST,BETTY-CONTROL-WEST \?L4
?L6:	PRINTR "You ARE in the shuttle car."
?L4:	PRINTR "Use 'north' or 'south'."
?L1:	EQUAL? PRSA,V?DROP,V?DISEMBARK,V?EXIT \FALSE
	EQUAL? HERE,SHUTTLE-CAR-ALFIE \?L13
	CALL DO-WALK,P?NORTH >STACK
	RSTACK
?L13:	EQUAL? HERE,SHUTTLE-CAR-BETTY \?L15
	CALL DO-WALK,P?SOUTH >STACK
	RSTACK
?L15:	EQUAL? HERE,BETTY-CONTROL-EAST,BETTY-CONTROL-WEST /?L17
	EQUAL? HERE,ALFIE-CONTROL-EAST,ALFIE-CONTROL-WEST \?L16
?L17:	PRINTR "You can't exit the shuttle car from here."
?L16:	PRINTR "You're not in the shuttle car!"

	.FUNCT SHUTTLE-CAR-F,RARG
	EQUAL? RARG,M-LOOK \FALSE
	PRINTI "This is the cabin of a large transport, with seating for around 20 people plus space for freight. There are open doors at the eastern and western ends of the cabin, and a doorway leads out to a wide platform to the "
	EQUAL? HERE,SHUTTLE-CAR-ALFIE \?L5
	PRINTI "north"
	JUMP ?L9
?L5:	PRINTI "south"
?L9:	PRINTR "."

	.FUNCT CONTROL-CABIN-F,RARG
	EQUAL? RARG,M-LOOK \FALSE
	PRINTI "This is a small control cabin. A control panel contains a slot, a lever, and a display. The lever can be set at a central position, or it could be pushed up to a position labelled ""+"", or pulled down to a position labelled ""-"". It is currently at the "
	ZERO? LEVER-SETTING \?L5
	PRINTI "center"
	JUMP ?L12
?L5:	EQUAL? LEVER-SETTING,1 \?L9
	PRINTI "upper"
	JUMP ?L12
?L9:	PRINTI "lower"
?L12:	PRINTI " setting. The display, a digital readout, currently reads "
	PRINTN SHUTTLE-VELOCITY
	PRINTI ". Through the cabin window you can see "
	CALL DESCRIBE-VIEW
	CRLF
	RTRUE

	.FUNCT DESCRIBE-VIEW
	EQUAL? HERE,ALFIE-CONTROL-WEST \?L4
	ZERO? ALFIE-AT-KALAMONTEE \?L3
?L4:	EQUAL? HERE,BETTY-CONTROL-WEST \?L5
	ZERO? BETTY-AT-KALAMONTEE \?L3
?L5:	EQUAL? HERE,ALFIE-CONTROL-EAST \?L6
	ZERO? ALFIE-AT-KALAMONTEE /?L3
?L6:	EQUAL? HERE,BETTY-CONTROL-EAST \?L1
	ZERO? BETTY-AT-KALAMONTEE \?L1
?L3:	PRINTI "a featureless concrete wall."
	RTRUE
?L1:	ZERO? SHUTTLE-MOVING /?L9
	EQUAL? SHUTTLE-COUNTER,23 \?L9
	PRINTI "parallel rails ending at a brightly-lit station ahead."
	RTRUE
?L9:	PRINTI "parallel rails running along the floor of a long tunnel, vanishing in the distance."
	RTRUE

	.FUNCT SHUTTLE-DOOR-F
	EQUAL? PRSA,V?OPEN \FALSE
	ZERO? SHUTTLE-MOVING /?L3
	PRINTR "A recorded voice says ""Operator should remain in control cabin while shuttle car is between stations."""
?L3:	PRINTR "Are you sure it isn't?"

	.FUNCT SHUTTLE-ENTER-F
	EQUAL? HERE,KALAMONTEE-PLATFORM \?L1
	EQUAL? PRSO,P?NORTH \?L3
	ZERO? BETTY-AT-KALAMONTEE /?L5
	RETURN SHUTTLE-CAR-BETTY
?L5:	PRINT CANT-GO
	CRLF
	RFALSE
?L3:	EQUAL? PRSO,P?SOUTH \FALSE
	ZERO? ALFIE-AT-KALAMONTEE /?L11
	RETURN SHUTTLE-CAR-ALFIE
?L11:	PRINT CANT-GO
	CRLF
	RFALSE
?L1:	EQUAL? HERE,LAWANDA-PLATFORM \FALSE
	EQUAL? PRSO,P?NORTH \?L18
	ZERO? BETTY-AT-KALAMONTEE /?L20
	PRINT CANT-GO
	CRLF
	RFALSE
?L20:	RETURN SHUTTLE-CAR-BETTY
?L18:	EQUAL? PRSO,P?SOUTH \FALSE
	ZERO? ALFIE-AT-KALAMONTEE /?L26
	PRINT CANT-GO
	CRLF
	RFALSE
?L26:	RETURN SHUTTLE-CAR-ALFIE

	.FUNCT SHUTTLE-EXIT-F
	EQUAL? HERE,SHUTTLE-CAR-ALFIE \?L1
	ZERO? ALFIE-AT-KALAMONTEE /?L3
	RETURN KALAMONTEE-PLATFORM
?L3:	RETURN LAWANDA-PLATFORM
?L1:	EQUAL? HERE,SHUTTLE-CAR-BETTY \FALSE
	ZERO? BETTY-AT-KALAMONTEE /?L7
	RETURN KALAMONTEE-PLATFORM
?L7:	RETURN LAWANDA-PLATFORM

	.FUNCT SHUTTLE-ACTIVATE
	EQUAL? HERE,ALFIE-CONTROL-EAST,ALFIE-CONTROL-WEST,BETTY-CONTROL-EAST /?L1
	EQUAL? HERE,BETTY-CONTROL-WEST /?L1
	PRINT WRONG-CARD
	CRLF
	RTRUE
?L1:	ZERO? ALFIE-BROKEN /?L7
	EQUAL? HERE,ALFIE-CONTROL-EAST,ALFIE-CONTROL-WEST /?L6
?L7:	ZERO? BETTY-BROKEN /?L5
	EQUAL? HERE,BETTY-CONTROL-EAST,BETTY-CONTROL-WEST \?L5
?L6:	PRINTR "A garbled recording mentions that the shuttle car has undergone some damage and that the repair robot has been summoned."
?L5:	GRTR? INTERNAL-MOVES,6000 \?L10
	PRINTR "A recorded voice explains that using the shuttle car during the evening hours requires special authorization."
?L10:	EQUAL? HERE,ALFIE-CONTROL-EAST \?L14
	ZERO? SHUTTLE-ON /?L16
	PRINT SHUTTLE-RECORDING-1
	CRLF
	RTRUE
?L16:	ZERO? ALFIE-AT-KALAMONTEE \?L20
	PRINT SHUTTLE-RECORDING-2
	CRLF
	RTRUE
?L20:	SET 'SHUTTLE-ON,1
	CALL QUEUE,I-TURNOFF-SHUTTLE,80 >STACK
	PUT STACK,0,1
	PRINT SHUTTLE-RECORDING-3
	CRLF
	RTRUE
?L14:	EQUAL? HERE,ALFIE-CONTROL-WEST \?L26
	ZERO? SHUTTLE-ON /?L27
	PRINT SHUTTLE-RECORDING-1
	CRLF
	RTRUE
?L27:	ZERO? ALFIE-AT-KALAMONTEE /?L31
	PRINT SHUTTLE-RECORDING-2
	CRLF
	RTRUE
?L31:	SET 'SHUTTLE-ON,1
	CALL QUEUE,I-TURNOFF-SHUTTLE,80 >STACK
	PUT STACK,0,1
	PRINT SHUTTLE-RECORDING-3
	CRLF
	RTRUE
?L26:	EQUAL? HERE,BETTY-CONTROL-EAST \?L37
	ZERO? SHUTTLE-ON /?L38
	PRINT SHUTTLE-RECORDING-1
	CRLF
	RTRUE
?L38:	ZERO? BETTY-AT-KALAMONTEE \?L42
	PRINT SHUTTLE-RECORDING-2
	CRLF
	RTRUE
?L42:	SET 'SHUTTLE-ON,1
	CALL QUEUE,I-TURNOFF-SHUTTLE,80 >STACK
	PUT STACK,0,1
	PRINT SHUTTLE-RECORDING-3
	CRLF
	RTRUE
?L37:	EQUAL? HERE,BETTY-CONTROL-WEST \?L48
	ZERO? SHUTTLE-ON /?L49
	PRINT SHUTTLE-RECORDING-1
	CRLF
	RTRUE
?L49:	ZERO? BETTY-AT-KALAMONTEE /?L53
	PRINT SHUTTLE-RECORDING-2
	CRLF
	RTRUE
?L53:	SET 'SHUTTLE-ON,1
	CALL QUEUE,I-TURNOFF-SHUTTLE,80 >STACK
	PUT STACK,0,1
	PRINT SHUTTLE-RECORDING-3
	CRLF
	RTRUE
?L48:	PRINT WRONG-CARD
	CRLF
	RTRUE

	.FUNCT I-TURNOFF-SHUTTLE
	ZERO? SHUTTLE-MOVING /?L1
	CALL QUEUE,I-TURNOFF-SHUTTLE,80 >STACK
	PUT STACK,0,1
	RFALSE
?L1:	SET 'SHUTTLE-ON,0
	RFALSE

	.FUNCT LEVER-F
	EQUAL? PRSA,V?PUSH-UP,V?PUSH \?L1
	ZERO? SHUTTLE-ON /?L3
	EQUAL? LEVER-SETTING,1 \?L5
	PRINTR "The lever is already in the upper position."
?L5:	ZERO? LEVER-SETTING \?L9
	SET 'LEVER-SETTING,1
	CALL QUEUE,I-SHUTTLE,1 >STACK
	PUT STACK,0,1
	PRINTR "The lever is now in the upper position."
?L9:	SET 'LEVER-SETTING,0
	PRINTR "The lever is now in the central position."
?L3:	PRINT SHUTTLE-RECORDING-4
	CRLF
	RTRUE
?L1:	EQUAL? PRSA,V?PUSH-DOWN,V?PULL \FALSE
	ZERO? SHUTTLE-ON /?L19
	EQUAL? LEVER-SETTING,1 \?L21
	SET 'LEVER-SETTING,0
	PRINTR "The lever is now in the central position."
?L21:	ZERO? LEVER-SETTING \?L25
	ZERO? SHUTTLE-VELOCITY \?L26
	PRINTR "The lever immediately pops back to the central position."
?L26:	SET 'LEVER-SETTING,-1
	CALL QUEUE,I-SHUTTLE,1 >STACK
	PUT STACK,0,1
	PRINTR "The lever is now in the lower position."
?L25:	PRINTR "The lever is already in the lower position."
?L19:	PRINT SHUTTLE-RECORDING-4
	CRLF
	RTRUE

	.FUNCT I-SHUTTLE
	CALL QUEUE,I-SHUTTLE,-1 >STACK
	PUT STACK,0,1
	ZERO? SHUTTLE-MOVING \?L1
	SET 'SHUTTLE-MOVING,1
	FCLEAR SHUTTLE-DOOR,OPENBIT
	FCLEAR SHUTTLE-DOOR,INVISIBLE
	PRINTI "The control cabin door slides shut and the shuttle car begins to move "
	EQUAL? LEVER-SETTING,1 \FALSE
	ADD SHUTTLE-VELOCITY,5 >SHUTTLE-VELOCITY
	PRINTR "forward! The display changes to 5."
?L1:	GRTR? SHUTTLE-VELOCITY,0 \?L11
	INC 'SHUTTLE-COUNTER
?L11:	EQUAL? LEVER-SETTING,1 \?L14
	ADD SHUTTLE-VELOCITY,5 >SHUTTLE-VELOCITY
	JUMP ?L19
?L14:	EQUAL? LEVER-SETTING,-1 \?L19
	GRTR? SHUTTLE-VELOCITY,0 \?L17
	SUB SHUTTLE-VELOCITY,5 >SHUTTLE-VELOCITY
	JUMP ?L19
?L17:	SET 'LEVER-SETTING,0
	PRINTI "The shuttle car comes to a stop and the lever pops back to the central position."
	CRLF
?L19:	EQUAL? SHUTTLE-COUNTER,24 \?L23
	CALL DESCRIBE-SHUTTLE-ARRIVE >STACK
	RSTACK
?L23:	GRTR? SHUTTLE-VELOCITY,0 \FALSE
	CALL DESCRIBE-SHUTTLE-TRIP
	RTRUE

	.FUNCT DESCRIBE-SHUTTLE-TRIP
	PRINTI "The shuttle car continues to move. The display "
	ZERO? LEVER-SETTING \?L3
	PRINTI "still reads "
	JUMP ?L7
?L3:	PRINTI "blinks, and now reads "
?L7:	PRINTN SHUTTLE-VELOCITY
	PRINTI "."
	CRLF
	EQUAL? SHUTTLE-COUNTER,2 \?L14
	PRINTI "You pass a sign which says ""Limit 45."""
	CRLF
?L14:	EQUAL? SHUTTLE-COUNTER,12 \?L19
	PRINTI "The tunnel levels out and begins to slope upward. A sign flashes by which reads ""Hafwaa Mark -- Beegin Deeseluraashun."""
	CRLF
?L19:	EQUAL? SHUTTLE-COUNTER,20 \?L24
	PRINT SIGN-PASS
	PRINTI """15."""
	CRLF
?L24:	EQUAL? SHUTTLE-COUNTER,21 \?L31
	PRINT SIGN-PASS
	PRINTI """10."""
	CRLF
?L31:	EQUAL? SHUTTLE-COUNTER,22 \?L38
	PRINT SIGN-PASS
	PRINTI """5."""
	CRLF
?L38:	EQUAL? SHUTTLE-COUNTER,23 \FALSE
	PRINTR "The shuttle car is approaching a brightly-lit area. As you near it, you make out the concrete platforms of a shuttle station."

	.FUNCT DESCRIBE-SHUTTLE-ARRIVE
	EQUAL? SHUTTLE-COUNTER,24 \FALSE
	ZERO? SHUTTLE-VELOCITY \?L3
	PRINTI "The shuttle car glides into the station and comes to rest at the concrete platform. You hear the cabin doors slide open."
	CRLF
	JUMP ?L13
?L3:	LESS? SHUTTLE-VELOCITY,20 \?L7
	EQUAL? HERE,ALFIE-CONTROL-EAST,ALFIE-CONTROL-WEST \?L8
	SET 'ALFIE-BROKEN,1
	JUMP ?L10
?L8:	SET 'BETTY-BROKEN,1
?L10:	PRINTI "The shuttle car rumbles through the station and smashes into the wall at the far end. You are thrown forward into the control panel. Both you and the shuttle car produce unhealthy crunching sounds as the cabin doors creak slowly open."
	CRLF
	JUMP ?L13
?L7:	CALL JIGS-UP,STR?64
?L13:	SET 'SHUTTLE-VELOCITY,0
	SET 'SHUTTLE-MOVING,0
	SET 'SHUTTLE-COUNTER,0
	SET 'LEVER-SETTING,0
	SET 'SHUTTLE-ON,0
	FSET SHUTTLE-DOOR,INVISIBLE
	FSET SHUTTLE-DOOR,OPENBIT
	CALL INT,I-SHUTTLE >STACK
	PUT STACK,0,0
	EQUAL? HERE,ALFIE-CONTROL-EAST,ALFIE-CONTROL-WEST \?L14
	ZERO? ALFIE-AT-KALAMONTEE /?L16
	SET 'ALFIE-AT-KALAMONTEE,0
	RETURN ALFIE-AT-KALAMONTEE
?L16:	SET 'ALFIE-AT-KALAMONTEE,1
	RETURN ALFIE-AT-KALAMONTEE
?L14:	ZERO? BETTY-AT-KALAMONTEE /?L20
	SET 'BETTY-AT-KALAMONTEE,0
	RETURN BETTY-AT-KALAMONTEE
?L20:	SET 'BETTY-AT-KALAMONTEE,1
	RETURN BETTY-AT-KALAMONTEE

	.FUNCT I-SLEEP-WARNINGS
	INC 'SLEEPY-LEVEL
	IN? ADVENTURER,BED \?L1
	CRLF
	PRINTI "You suddenly realize how tired you were and how comfortable the bed is. You should be asleep in no time."
	CRLF
	CALL INT,I-SLEEP-WARNINGS >STACK
	PUT STACK,0,0
	CALL QUEUE,I-FALL-ASLEEP,16 >STACK
	PUT STACK,0,1
	RTRUE
?L1:	EQUAL? SLEEPY-LEVEL,1 \?L6
	CRLF
	PRINTI "You begin to feel weary. It might be time to think about finding a nice safe place to sleep."
	CRLF
	CALL QUEUE,I-SLEEP-WARNINGS,400 >STACK
	PUT STACK,0,1
	RTRUE
?L6:	EQUAL? SLEEPY-LEVEL,2 \?L10
	CRLF
	PRINTI "You're really tired now. You'd better find a place to sleep real soon."
	CRLF
	CALL QUEUE,I-SLEEP-WARNINGS,135 >STACK
	PUT STACK,0,1
	RTRUE
?L10:	EQUAL? SLEEPY-LEVEL,3 \?L13
	CRLF
	PRINTI "If you don't get some sleep soon you'll probably drop."
	CRLF
	CALL QUEUE,I-SLEEP-WARNINGS,60 >STACK
	PUT STACK,0,1
	RTRUE
?L13:	EQUAL? SLEEPY-LEVEL,4 \?L16
	CRLF
	PRINTI "You can barely keep your eyes open."
	CRLF
	CALL QUEUE,I-SLEEP-WARNINGS,50 >STACK
	PUT STACK,0,1
	RTRUE
?L16:	EQUAL? SLEEPY-LEVEL,5 \FALSE
	EQUAL? HERE,BED \?L20
	CRLF
	PRINTI "You slowly sink into a deep and blissful sleep."
	CRLF
	CALL DREAMING >STACK
	RSTACK
?L20:	EQUAL? HERE,DORM-A,DORM-B /?L25
	EQUAL? HERE,DORM-C,DORM-D \?L24
?L25:	CRLF
	PRINTI "You climb into one of the bunk beds and immediately fall asleep."
	CRLF
	MOVE ADVENTURER,BED
	CALL DREAMING >STACK
	RSTACK
?L24:	CRLF
	PRINTI "You can't stay awake a moment longer. You drop to the ground and fall into a deep but fitful sleep."
	CRLF
	EQUAL? DAY,1 \?L34
	EQUAL? HERE,CRAG /?L33
?L34:	EQUAL? DAY,3 \?L35
	EQUAL? HERE,BALCONY /?L33
?L35:	EQUAL? DAY,5 \?L31
	EQUAL? HERE,WINDING-STAIR \?L31
?L33:	CALL JIGS-UP,STR?65 >STACK
	RSTACK
?L31:	RANDOM 100 >STACK
	LESS? 30,STACK /?L36
	CALL JIGS-UP,STR?66 >STACK
	RSTACK
?L36:	CALL DREAMING >STACK
	RSTACK

	.FUNCT BED-F,RARG=M-OBJECT
	EQUAL? PRSA,V?WALK \?L1
	EQUAL? RARG,M-BEG \?L1
	PRINTR "You'll have to stand up, first."
?L1:	EQUAL? PRSA,V?RUB /?L6
	EQUAL? PRSA,V?CLOSE,V?OPEN,V?TAKE \?L5
?L6:	EQUAL? RARG,M-BEG \?L5
	EQUAL? PRSO,BED /?L5
	PRINTR "You can't reach it from here."
?L5:	ZERO? RARG \FALSE
	EQUAL? PRSA,V?WALK-TO,V?BOARD,V?THROUGH \?L10
	EQUAL? HERE,INFIRMARY \?L11
	CALL JIGS-UP,STR?67 >STACK
	RSTACK
?L11:	GRTR? SLEEPY-LEVEL,0 \?L13
	MOVE ADVENTURER,BED
	CALL QUEUE,I-FALL-ASLEEP,16 >STACK
	PUT STACK,0,1
	CALL INT,I-SLEEP-WARNINGS >STACK
	PUT STACK,0,0
	PRINTR "Ahhh...the bed is soft and comfortable. You should be asleep in short order."
?L13:	MOVE ADVENTURER,BED
	PRINTR "You are now in bed."
?L10:	EQUAL? PRSA,V?DROP /?L20
	EQUAL? PRSA,V?EXIT,V?STAND,V?DISEMBARK \?L19
?L20:	CALL INT,I-FALL-ASLEEP >STACK
	GET STACK,C-TICK >STACK
	ZERO? STACK /?L19
	PRINTR "How could you suggest such a thing when you're so tired and this bed is so comfy?"
?L19:	EQUAL? PRSA,V?DROP,V?EXIT,V?LEAVE \?L23
	CALL PERFORM,V?DISEMBARK,BED
	RTRUE
?L23:	EQUAL? PRSA,V?PUT \FALSE
	EQUAL? BED,PRSI \FALSE
	MOVE PRSO,HERE
	PRINTI "The "
	PRINTD PRSO
	PRINTR " bounces off the bed and lands on the floor."

	.FUNCT I-FALL-ASLEEP
	CRLF
	PRINTI "You slowly sink into a deep and restful sleep."
	CRLF
	CALL INT,I-FALL-ASLEEP >STACK
	PUT STACK,0,0
	CALL DREAMING >STACK
	RSTACK

	.FUNCT DREAMING
	FSET? FORK,TOUCHBIT \?L1
	RANDOM 100 >STACK
	LESS? 13,STACK /?L1
	PRINTI "You are in a busy office crowded with people. The only one you recognize is Floyd. He rushes back and forth between the desks, carrying papers and delivering coffee. He notices you, and asks how your project is coming, and whether you have time to tell him a story. You look into his deep, trusting eyes..."
	CRLF
	JUMP ?L5
?L1:	RANDOM 100 >STACK
	LESS? 60,STACK /?L5
	CRLF
	CALL PICK-ONE,DREAMS >STACK
	PRINT STACK
	CRLF
?L5:	CALL WAKING-UP >STACK
	RSTACK

	.FUNCT WAKING-UP,X,N
	INC 'DAY
	SET 'SICKNESS-WARNING-FLAG,1
	SET 'SLEEPY-LEVEL,0
	CALL RESET-TIME
	FIRST? ADVENTURER >X /?L47
	JUMP ?L3
?L1:	ZERO? X /?L3
?L47:	NEXT? X >N /?L6
?L6:	FSET? X,WORNBIT /?L7
	MOVE X,HERE
?L7:	EQUAL? X,CANTEEN \?L10
	IN? HIGH-PROTEIN,CANTEEN \?L10
	FSET? CANTEEN,OPENBIT \?L10
	REMOVE HIGH-PROTEIN
?L10:	EQUAL? X,FLASK \?L13
	IN? CHEMICAL-FLUID,FLASK \?L13
	REMOVE CHEMICAL-FLUID
?L13:	SET 'X,N
	JUMP ?L1
?L3:	PRINTI "
***** SEPTEM "
	ADD DAY,5 >STACK
	PRINTN STACK
	PRINTI ", 11344 *****

"
	IN? ADVENTURER,BED /?L19
	PRINTI "You wake and slowly stand up, feeling stiff from your night on the floor."
	JUMP ?L29
?L19:	LESS? SICKNESS-LEVEL,3 \?L23
	PRINTI "You wake up feeling refreshed and ready to face the challenges of this mysterious world."
	JUMP ?L29
?L23:	LESS? SICKNESS-LEVEL,6 \?L26
	PRINTI "You wake after sleeping restlessly. You feel weak and listless."
	JUMP ?L29
?L26:	PRINTI "You wake feeling weak and worn-out. It will be an effort just to stand up."
?L29:	GRTR? HUNGER-LEVEL,0 \?L32
	SET 'HUNGER-LEVEL,4
	CALL QUEUE,I-HUNGER-WARNINGS,100 >STACK
	PUT STACK,0,1
	PRINTI " You are also incredibly famished. Better get some breakfast!"
	JUMP ?L36
?L32:	CALL QUEUE,I-HUNGER-WARNINGS,400 >STACK
	PUT STACK,0,1
?L36:	CRLF
	FSET? FLOYD,RLANDBIT \FALSE
	ZERO? FLOYD-INTRODUCED /FALSE
	MOVE FLOYD,HERE
	SET 'FLOYD-SPOKE,1
	IN? ADVENTURER,BED \?L39
	PRINTR "Floyd bounces impatiently at the foot of the bed. ""About time you woke up, you lazy bones! Let's explore around some more!"""
?L39:	PRINTR "Floyd gives you a nudge with his foot and giggles. ""You sure look silly sleeping on the floor,"" he says."

	.FUNCT RESET-TIME
	EQUAL? DAY,2 \?L1
	FCLEAR BALCONY,TOUCHBIT
	RANDOM 80 >STACK
	ADD 1600,STACK >INTERNAL-MOVES
	CALL QUEUE,I-SLEEP-WARNINGS,5800 >STACK
	PUT STACK,0,1
	RTRUE
?L1:	EQUAL? DAY,3 \?L3
	FCLEAR BALCONY,TOUCHBIT
	RANDOM 80 >STACK
	ADD 1750,STACK >INTERNAL-MOVES
	CALL QUEUE,I-SLEEP-WARNINGS,5550 >STACK
	PUT STACK,0,1
	RTRUE
?L3:	EQUAL? DAY,4 \?L4
	FCLEAR WINDING-STAIR,TOUCHBIT
	RANDOM 80 >STACK
	ADD 1950,STACK >INTERNAL-MOVES
	CALL QUEUE,I-SLEEP-WARNINGS,5200 >STACK
	PUT STACK,0,1
	RTRUE
?L4:	EQUAL? DAY,5 \?L5
	FCLEAR WINDING-STAIR,TOUCHBIT
	RANDOM 80 >STACK
	ADD 2150,STACK >INTERNAL-MOVES
	CALL QUEUE,I-SLEEP-WARNINGS,4800 >STACK
	PUT STACK,0,1
	RTRUE
?L5:	EQUAL? DAY,6 \?L6
	FCLEAR COURTYARD,TOUCHBIT
	RANDOM 80 >STACK
	ADD 2450,STACK >INTERNAL-MOVES
	CALL QUEUE,I-SLEEP-WARNINGS,4300 >STACK
	PUT STACK,0,1
	RTRUE
?L6:	EQUAL? DAY,7 \?L7
	FCLEAR COURTYARD,TOUCHBIT
	RANDOM 80 >STACK
	ADD 2800,STACK >INTERNAL-MOVES
	CALL QUEUE,I-SLEEP-WARNINGS,3700 >STACK
	PUT STACK,0,1
	RTRUE
?L7:	EQUAL? DAY,8 \?L8
	RANDOM 80 >STACK
	ADD 3200,STACK >INTERNAL-MOVES
	CALL QUEUE,I-SLEEP-WARNINGS,3000 >STACK
	PUT STACK,0,1
	RTRUE
?L8:	EQUAL? DAY,9 \FALSE
	CALL JIGS-UP,STR?68 >STACK
	RSTACK

	.FUNCT I-HUNGER-WARNINGS
	INC 'HUNGER-LEVEL
	EQUAL? HUNGER-LEVEL,1 \?L1
	CALL QUEUE,I-HUNGER-WARNINGS,450 >STACK
	PUT STACK,0,1
	CRLF
	PRINTR "A growl from your stomach warns that you're getting pretty hungry and thirsty."
?L1:	EQUAL? HUNGER-LEVEL,2 \?L5
	CALL QUEUE,I-HUNGER-WARNINGS,150 >STACK
	PUT STACK,0,1
	CRLF
	PRINTR "You're now really ravenous and your lips are quite parched."
?L5:	EQUAL? HUNGER-LEVEL,3 \?L8
	CALL QUEUE,I-HUNGER-WARNINGS,100 >STACK
	PUT STACK,0,1
	CRLF
	PRINTR "You're starting to feel faint from lack of food and liquid."
?L8:	EQUAL? HUNGER-LEVEL,4 \?L11
	CALL QUEUE,I-HUNGER-WARNINGS,50 >STACK
	PUT STACK,0,1
	CRLF
	PRINTR "If you don't eat or drink something in a few millichrons, you'll probably pass out."
?L11:	EQUAL? HUNGER-LEVEL,5 \FALSE
	CALL JIGS-UP,STR?69 >STACK
	RSTACK

	.FUNCT I-SICKNESS-WARNINGS
	CALL QUEUE,I-SICKNESS-WARNINGS,700 >STACK
	PUT STACK,0,1
	ZERO? SICKNESS-WARNING-FLAG /FALSE
	SET 'SICKNESS-WARNING-FLAG,0
	SUB LOAD-ALLOWED,10 >LOAD-ALLOWED
	INC 'SICKNESS-LEVEL
	EQUAL? SICKNESS-LEVEL,1 \?L3
	CRLF
	PRINTR "You notice that you feel a bit weak and slightly flushed, but you're not sure why."
?L3:	EQUAL? SICKNESS-LEVEL,2 \?L7
	CRLF
	PRINTR "You notice that you feel unusually weak, and you suspect that you have a fever."
?L7:	EQUAL? SICKNESS-LEVEL,3 \?L10
	CRLF
	PRINTR "You are now feeling quite under the weather, not unlike a bad flu."
?L10:	EQUAL? SICKNESS-LEVEL,4 \?L13
	CRLF
	PRINTR "Your fever seems to have gotten worse, and you're developing a bad headache."
?L13:	EQUAL? SICKNESS-LEVEL,5 \?L16
	CRLF
	PRINTR "Your health has deteriorated further. You feel hot and weak, and your head is throbbing."
?L16:	EQUAL? SICKNESS-LEVEL,6 \?L19
	CRLF
	PRINTR "You feel very, very sick, and have almost no strength left."
?L19:	EQUAL? SICKNESS-LEVEL,7 \?L22
	CRLF
	PRINTR "You feel like you're on fire, burning up from the fever. You're almost too weak to move, and your brain is reeling from the pounding headache."
?L22:	EQUAL? SICKNESS-LEVEL,8 \?L25
	CRLF
	PRINTR "You're no longer sure of where you are and what you're doing. You stumble about, your pain subsiding into a dull numbness."
?L25:	EQUAL? SICKNESS-LEVEL,9 \FALSE
	CALL JIGS-UP,STR?70 >STACK
	RSTACK

	.FUNCT TRANSLATOR-PSEUDO
	IN? AMBASSADOR,HERE \?L1
	EQUAL? PRSA,V?TAKE \?L3
	PRINTR "The ambassador whimpers and slaps your wrist."
?L3:	EQUAL? PRSA,V?MUNG \FALSE
	PRINTR "Are you trying to create an interplanetary incident?"
?L1:	PRINTR "What translator?"

	.FUNCT SLIME-PSEUDO
	IN? AMBASSADOR,HERE /?L3
	GRTR? AMBASSADOR-LEAVE,0 \?L1
?L3:	EQUAL? PRSA,V?TASTE,V?EAT \?L4
	CALL LIKE-SLIME,STR?71 >STACK
	RSTACK
?L4:	EQUAL? PRSA,V?RUB,V?TAKE \?L6
	CALL LIKE-SLIME,STR?72 >STACK
	RSTACK
?L6:	EQUAL? PRSA,V?EXAMINE \?L7
	CALL LIKE-SLIME,STR?73 >STACK
	RSTACK
?L7:	EQUAL? PRSA,V?SMELL \?L8
	CALL LIKE-SLIME,STR?74 >STACK
	RSTACK
?L8:	EQUAL? PRSA,V?REMOVE,V?SCRUB \FALSE
	PRINTI "Whew. You've cleaned up maybe one ten-thousandth of the slime."
	IN? BLATHER,HERE /?L12
	PRINTI " If you hurry, it might be all cleaned up before Ensign Blather gets here."
?L12:	CRLF
	RTRUE
?L1:	PRINTR "What slime?"

	.FUNCT LIKE-SLIME,STRING
	PRINTI "It "
	PRINT STRING
	PRINTR " like slime. Aren't you glad you didn't step in it?"

	.FUNCT GRAFFITI-PSEUDO
	EQUAL? PRSA,V?READ \FALSE
	SET 'C-ELAPSED,28
	PRINTR "All the graffiti seem to be about Blather. One of the least obscene items reads:

There once was a krip, name of Blather
Who told a young Ensign named Smather
""I'll make you inherit
A trotting demerit
And ship you off to those stinking fawg-infested tar-pools of Krather.""

It's not a very good limerick, is it?"

	.FUNCT DOOR-PSEUDO
	EQUAL? PRSA,V?UNLOCK,V?OPEN \FALSE
	PRINTR "No way, Jose."

	.FUNCT WALKWAY-PSEUDO
	EQUAL? PRSA,V?LAMP-ON,V?EXAMINE \FALSE
	PRINTR "The walkway, which hastened the trip down that long corridor, is no longer in service."

	.FUNCT BENCH-PSEUDO
	EQUAL? PRSA,V?BOARD,V?CLIMB-ON \FALSE
	PRINTR "The benches look uncomfortable."

	.FUNCT CATWALK-PSEUDO
	EQUAL? PRSA,V?CLIMB-FOO,V?CLIMB-UP,V?CLIMB-ON \FALSE
	PRINTR "The catwalks are too high for you to access."

	.FUNCT EQUIPMENT-PSEUDO
	EQUAL? PRSA,V?LAMP-OFF /?L3
	EQUAL? PRSA,V?LAMP-ON,V?RUB,V?EXAMINE \FALSE
?L3:	PRINTR "The equipment here is so complicated that you couldn't even begin to figure out how to operate it."

	.FUNCT MONITORS-PSEUDO
	EQUAL? PRSA,V?READ,V?EXAMINE \FALSE
	CALL DESCRIBE-MONITORS >STACK
	RSTACK

	.FUNCT MURAL-PSEUDO
	ZERO? COMPUTER-FIXED /?L1
	CALL ANYMORE >STACK
	RSTACK
?L1:	EQUAL? PRSA,V?EXAMINE \?L4
	PRINTR "It's a gaudy work of orange and purple abstract shapes, reminiscent of the early works of Burstini Bonz. It doesn't appear to fit the decor of the room at all. The mural seems to ripple now and then, as though a breeze were blowing behind it."
?L4:	EQUAL? PRSA,V?MUNG \?L8
	PRINTR "My sentiments also, but let's be civil."
?L8:	EQUAL? PRSA,V?LOOK-BEHIND,V?MOVE \FALSE
	PRINTR "It won't budge."

	.FUNCT LOGO-PSEUDO
	EQUAL? PRSA,V?EXAMINE,V?READ \FALSE
	PRINTR "The logo shows a flame burning over a sleep chamber of some type. Under that is the phrase ""Prajekt Kuntrool."""

	.FUNCT KEYBOARD-PSEUDO
	EQUAL? PRSA,V?EXAMINE \FALSE
	PRINTR "It is a standard numeric keyboard with ten keys labelled from 0 through 9."

	.FUNCT CRACK-PSEUDO
	EQUAL? PRSA,V?EXAMINE \?L1
	PRINTR "The crack is too small to go through, but large enough to look through."
?L1:	EQUAL? PRSA,V?LOOK-INSIDE \FALSE
	EQUAL? HERE,RADIATION-LAB \?L6
	PRINTR "You see a dimly lit Bio Lab. Sinister shapes lurk about within."
?L6:	PRINTR "You see a laboratory suffused with a pale blue glow."

	.FUNCT VOID-PSEUDO
	EQUAL? PRSA,V?PUT \?L1
	EQUAL? PRSI,PSEUDO-OBJECT \?L1
	CALL PERFORM,V?THROW-OFF,PRSO,STRIP
	RTRUE
?L1:	EQUAL? PRSA,V?ZAP \?L3
	EQUAL? PRSO,LASER \?L3
	EQUAL? PRSI,PSEUDO-OBJECT \?L3
	SET 'PRSI,0
	CALL PERFORM,V?ZAP,LASER
	RTRUE
?L3:	EQUAL? PRSA,V?LEAP,V?THROUGH \?L4
	CALL JIGS-UP,STR?75 >STACK
	RSTACK
?L4:	EQUAL? PRSA,V?EXAMINE,V?LOOK-INSIDE \FALSE
	PRINTR "The void extends downward into the gloom far below."

	.FUNCT SPOUT-PSEUDO
	EQUAL? PRSA,V?PUT-UNDER \?L1
	EQUAL? PRSO,CANTEEN \?L1
	CALL PERFORM,V?PUT,CANTEEN,DISPENSER
	RTRUE
?L1:	EQUAL? PRSA,V?LOOK-UNDER \FALSE
	IN? CANTEEN,DISPENSER \FALSE
	PRINTR "The canteen is sitting under the spout."

	.FUNCT TOILET-PSEUDO
	EQUAL? PRSA,V?EXAMINE \?L1
	PRINTR "The fixtures are all dry and dusty."
?L1:	EQUAL? PRSA,V?FLUSH \FALSE
	PRINTR "The water seems to be turned off."

	.FUNCT GAMES-PSEUDO
	EQUAL? PRSA,V?PLAY \?L1
	CALL PERFORM,V?PLAY,GLOBAL-GAMES
	RTRUE
?L1:	EQUAL? PRSA,V?EXAMINE \FALSE
	PRINTR "All the usual games -- Chess, Cribbage, Galactic Overlord, Double Fannucci..."

	.FUNCT TAPES-PSEUDO
	EQUAL? PRSA,V?TAKE,V?PLAY,V?READ \?L1
	PRINTR "Hardly the time or place for reading recreational tapes."
?L1:	EQUAL? PRSA,V?EXAMINE \FALSE
	PRINTR "Let's see...here are some musical selections, here are some bestselling romantic novels, here is a biography of a famous Double Fannucci champion..."

	.FUNCT PARTITION-PSEUDO
	EQUAL? PRSA,V?EXAMINE \FALSE
	PRINTR "The partitions are very plain, and were obviously intended to separate this huge room into smaller areas."

	.FUNCT CUBBYHOLE-PSEUDO
	EQUAL? PRSA,V?LOOK-INSIDE,V?EXAMINE \FALSE
	PRINTR "The cubbyholes look like the kind that are used to hold maps or blueprints. They are all empty now."

	.FUNCT MAPS-PSEUDO
	EQUAL? PRSA,V?EXAMINE \FALSE
	PRINTR "Examining the maps reveals no new information."

	.FUNCT DEVICES-PSEUDO
	EQUAL? PRSA,V?EXAMINE \FALSE
	PRINTR "They are components of disassembled robots, beyond repair."

	.FUNCT CABLES-PSEUDO
	EQUAL? PRSA,V?FOLLOW,V?EXAMINE \?L1
	PRINTR "These heavy cables merely run from the two consoles up into the ceiling."
?L1:	EQUAL? PRSA,V?MUNG \FALSE
	CALL JIGS-UP,STR?76 >STACK
	RSTACK

	.FUNCT STRUCTURE-PSEUDO
	EQUAL? PRSA,V?EXAMINE \?L1
	PRINTR "You'd be able to tell more about it if you climbed up to it."
?L1:	EQUAL? PRSA,V?CLIMB-UP \FALSE
	CALL DO-WALK,P?UP >STACK
	RSTACK

	.FUNCT BUTTON-PSEUDO
	EQUAL? PRSA,V?PUSH \FALSE
	FSET? DISPENSER,MUNGEDBIT \?L3
	PRINTR "The dispenser sputters a few times."
?L3:	IN? CANTEEN,DISPENSER \?L7
	FSET? CANTEEN,OPENBIT /?L8
	PRINTR "A thick, brown liquid spills over the closed canteen, dribbles down the side of the machine, and forms a puddle on the floor which quickly dries up."
?L8:	IN? HIGH-PROTEIN,CANTEEN \?L12
	PRINTI "The brown liquid splashes over the mouth of the already-filled canteen, creating a mess"
	FSET? PATROL-UNIFORM,WORNBIT \?L15
	PRINTI " and staining your uniform"
?L15:	PRINTR "."
?L12:	MOVE HIGH-PROTEIN,CANTEEN
	PRINTR "The canteen fills almost to the brim with a brown liquid."
?L7:	PRINTR "A thick, brownish liquid pours from the spout and splashes to the floor, where it quickly evaporates."

	.FUNCT CARPET-PSEUDO
	EQUAL? PRSA,V?EXAMINE \FALSE
	PRINTR "It's pretty dusty."

	.FUNCT CABINETS-PSEUDO
	EQUAL? PRSA,V?OPEN,V?EXAMINE \?L1
	PRINTR "The cabinets are locked."
?L1:	EQUAL? PRSA,V?UNLOCK \FALSE
	PRINTR "You don't have the correct key."

	.FUNCT PLATE-PSEUDO
	EQUAL? PRSA,V?EXAMINE \FALSE
	PRINTR "The plates seem to be featureless metal squares."

	.FUNCT ESCALATOR-PSEUDO
	EQUAL? PRSA,V?CLIMB-FOO,V?CLIMB-UP \?L1
	EQUAL? HERE,FORK \?L3
	PRINTR "You're already at the top of the escalator."
?L3:	CALL DO-WALK,P?UP >STACK
	RSTACK
?L1:	EQUAL? PRSA,V?CLIMB-DOWN \?L8
	EQUAL? HERE,LAWANDA-PLATFORM \?L9
	PRINTR "You're already at the bottom of the escalator."
?L9:	CALL DO-WALK,P?DOWN >STACK
	RSTACK
?L8:	EQUAL? PRSA,V?LAMP-ON \FALSE
	CALL PICK-ONE,YUKS >STACK
	PRINT STACK
	CRLF
	RTRUE

	.FUNCT REACTOR-BUTTON-PSEUDO
	EQUAL? PRSA,V?PUSH \FALSE
	FSET REACTOR-ELEVATOR-DOOR,OPENBIT
	CALL QUEUE,I-REACTOR-DOOR-CLOSE,30 >STACK
	PUT STACK,0,1
	PRINTR "The metal doors slide open, revealing a small room to the east."

	.FUNCT SUPPLIES-PSEUDO
	EQUAL? PRSA,V?TAKE \FALSE
	PRINTR "These supplies are of absolutely no use."

	.FUNCT DESK-PSEUDO
	EQUAL? PRSA,V?OPEN \?L1
	PRINTR "All the drawers are empty."
?L1:	EQUAL? PRSA,V?EXAMINE \FALSE
	PRINTR "It is bare except for the microfilm reader."

	.FUNCT CRYO-BUTTON-PSEUDO
	EQUAL? PRSA,V?PUSH \FALSE
	ZERO? CRYO-SCORE-FLAG \?L1
	CALL QUEUE,I-CRYO-ELEVATOR-ARRIVE,100 >STACK
	PUT STACK,0,1
	CALL INT,I-CHASE-SCENE >STACK
	PUT STACK,0,0
	FCLEAR CRYO-ELEVATOR-DOOR,OPENBIT
	SET 'CRYO-SCORE-FLAG,1
	ADD SCORE,5 >SCORE
	PRINTR "The elevator door closes just as the monsters reach it! You slump back against the wall, exhausted from the chase. The elevator begins to move downward."
?L1:	EQUAL? PRSA,V?PUSH \FALSE
	ZERO? CRYO-SCORE-FLAG /FALSE
	FSET? CRYO-ELEVATOR-DOOR,OPENBIT \FALSE
	CALL JIGS-UP,STR?77 >STACK
	RSTACK

	.FUNCT CASTLE-PSEUDO
	EQUAL? PRSA,V?EXAMINE \FALSE
	PRINTR "The castle is ancient and crumbling."

	.FUNCT CHEM-SPOUT-PSEUDO
	EQUAL? PRSA,V?PUT-UNDER \?L1
	EQUAL? PRSI,PSEUDO-OBJECT \?L1
	CALL PERFORM,V?PUT-UNDER,PRSO,CHEMICAL-DISPENSER
	RTRUE
?L1:	EQUAL? PRSA,V?LOOK-UNDER \FALSE
	ZERO? SPOUT-PLACED /FALSE
	PRINTI "There is "
	CALL A-AN
	PRINTD SPOUT-PLACED
	PRINTR " under the spout."

	.FUNCT CLEFT-PSEUDO
	EQUAL? PRSA,V?CLIMB-FOO,V?CLIMB-UP \FALSE
	CALL DO-WALK,P?UP >STACK
	RSTACK

	.FUNCT RUBBLE-PSEUDO
	EQUAL? PRSA,V?MOVE \FALSE
	CALL PICK-ONE,YUKS >STACK
	PRINT STACK
	CRLF
	RTRUE

	.FUNCT PLAQUE-PSEUDO
	EQUAL? PRSA,V?EXAMINE,V?READ \FALSE
	PRINTR "
SEENIK VISTA 
Xis stuneeng vuu uf xee Kalamontee Valee kuvurz oovur fortee skwaar miilz uf xat faamus tuurist spot. Xee larj bildeeng at xee bend in xee Gulmaan Rivur iz xee formur pravincul kapitul bildeeng."

	.FUNCT FENCE-PSEUDO
	EQUAL? PRSA,V?LEAP,V?CLIMB-FOO,V?CLIMB-UP \FALSE
	PRINTR "You can't."

	.FUNCT LOCK-PSEUDO
	EQUAL? PRSA,V?UNLOCK,V?OPEN \FALSE
	ZERO? PRSI /?L3
	PRINTR "That won't unlock it."
?L3:	PRINTR "But you don't have the orange key!"

	.FUNCT DIAGRAM-PSEUDO
	EQUAL? PRSA,V?READ \FALSE
	PRINTR "Not unless you've taken a special twelve-year course in ninth-order molecular physics."

	.FUNCT ENUNCIATOR-PSEUDO
	EQUAL? PRSA,V?MOVE,V?PUSH,V?LOOK-INSIDE \FALSE
	CALL PICK-ONE,YUKS >STACK
	PRINT STACK
	RTRUE

	.FUNCT NEAR-BOOTH-PSEUDO
	EQUAL? PRSA,V?DISEMBARK,V?EXIT,V?DROP \?L1
	PRINTR "You're not in the booth!"
?L1:	EQUAL? PRSA,V?WALK-TO,V?BOARD,V?THROUGH \FALSE
	CALL DO-WALK,P?IN >STACK
	RSTACK

	.FUNCT IN-BOOTH-PSEUDO
	EQUAL? PRSA,V?WALK-TO,V?BOARD,V?THROUGH \?L1
	PRINTR "You're already in the booth!"
?L1:	EQUAL? PRSA,V?DISEMBARK,V?EXIT,V?DROP \FALSE
	CALL DO-WALK,P?OUT >STACK
	RSTACK

	.FUNCT PARSER,PTR=P-LEXSTART,WORD,VAL=0,VERB=0,LEN,DIR=0,NW=0,LW=0,NUM,SCNT,CNT=-1
?L1:	IGRTR? 'CNT,P-ITBLLEN /?L2
	PUT P-ITBL,CNT,0
	JUMP ?L1
?L2:	SET 'P-ADVERB,0
	SET 'P-ADJECTIVE,0
	SET 'P-MERGED,0
	PUT P-PRSO,P-MATCHLEN,0
	PUT P-PRSI,P-MATCHLEN,0
	PUT P-BUTS,P-MATCHLEN,0
	ZERO? QUOTE-FLAG \?L8
	EQUAL? WINNER,ADVENTURER /?L8
	SET 'WINNER,ADVENTURER
	LOC WINNER >STACK
	FSET? STACK,VEHBIT /?L8
	LOC WINNER >HERE
?L8:	ZERO? P-CONT /?L12
	SET 'PTR,P-CONT
	SET 'P-CONT,0
	EQUAL? PRSA,V?TELL /?L17
	ZERO? SUPER-BRIEF \?L17
	CRLF
	JUMP ?L17
?L12:	SET 'WINNER,ADVENTURER
	SET 'QUOTE-FLAG,0
	LOC WINNER >STACK
	FSET? STACK,VEHBIT /?L18
	LOC WINNER >HERE
?L18:	SET 'SCNT,P-SPACE
?L21:	DLESS? 'SCNT,0 /?L22
	ZERO? SUPER-BRIEF \?L21
	CRLF
	JUMP ?L21
?L22:	PRINTI ">"
	READ P-INBUF,P-LEXV
?L17:	GETB P-LEXV,P-LEXWORDS >P-LEN
	ZERO? P-LEN \?L29
	PRINTI "I beg your pardon?"
	CRLF
	RFALSE
?L29:	SET 'LEN,P-LEN
	SET 'P-DIR,0
	SET 'P-NCN,0
	SET 'P-GETFLAGS,0
?L34:	DLESS? 'P-LEN,0 \?L36
	SET 'QUOTE-FLAG,0
	JUMP ?L35
?L36:	GET P-LEXV,PTR >WORD
	ZERO? WORD \?L39
	CALL NUMBER?,PTR >WORD
	ZERO? WORD /?L38
?L39:	EQUAL? WORD,W?TO \?L40
	EQUAL? VERB,ACT?TELL \?L40
	SET 'WORD,W?$QUOTE
	JUMP ?L42
?L40:	EQUAL? WORD,W?THEN \?L42
	ZERO? VERB \?L42
	ZERO? QUOTE-FLAG \?L42
	PUT P-ITBL,P-VERB,ACT?TELL
	PUT P-ITBL,P-VERBN,0
	SET 'WORD,W?$QUOTE
?L42:	EQUAL? WORD,W?THEN,W?$PERIOD /?L46
	EQUAL? WORD,W?$QUOTE \?L44
?L46:	EQUAL? WORD,W?$QUOTE \?L51
	ZERO? QUOTE-FLAG /?L49
	SET 'QUOTE-FLAG,0
	JUMP ?L51
?L49:	SET 'QUOTE-FLAG,1
?L51:	ZERO? P-LEN /?L53
	ADD PTR,P-LEXELEN >P-CONT
?L53:	PUTB P-LEXV,P-LEXWORDS,P-LEN
	JUMP ?L35
?L44:	CALL WT?,WORD,PS?DIRECTION,P1?DIRECTION >VAL
	ZERO? VAL /?L55
	EQUAL? LEN,1 /?L56
	EQUAL? LEN,2 \?L57
	EQUAL? VERB,ACT?WALK /?L56
?L57:	ADD PTR,P-LEXELEN >STACK
	GET P-LEXV,STACK >NW
	EQUAL? NW,W?THEN,W?$QUOTE \?L58
	EQUAL? VERB,ACT?WALK \?L58
	GRTR? LEN,2 /?L56
?L58:	EQUAL? NW,W?$PERIOD \?L59
	EQUAL? VERB,ACT?WALK,0 \?L59
	GRTR? LEN,1 /?L56
?L59:	ZERO? QUOTE-FLAG /?L60
	EQUAL? LEN,2 \?L60
	EQUAL? NW,W?$QUOTE /?L56
?L60:	GRTR? LEN,2 \?L55
	EQUAL? VERB,ACT?WALK \?L55
	EQUAL? NW,W?$COMMA,W?AND \?L55
?L56:	SET 'DIR,VAL
	EQUAL? NW,W?$COMMA,W?AND \?L61
	ADD PTR,P-LEXELEN >STACK
	PUT P-LEXV,STACK,W?THEN
?L61:	GRTR? LEN,2 /?L92
	SET 'QUOTE-FLAG,0
	JUMP ?L35
?L55:	CALL WT?,WORD,PS?VERB,P1?VERB >VAL
	ZERO? VAL /?L67
	ZERO? VERB \?L67
	SET 'VERB,VAL
	PUT P-ITBL,P-VERB,VAL
	PUT P-ITBL,P-VERBN,P-VTBL
	PUT P-VTBL,0,WORD
	MUL PTR,2 >STACK
	ADD STACK,2 >NUM
	GETB P-LEXV,NUM >STACK
	PUTB P-VTBL,2,STACK
	ADD NUM,1 >STACK
	GETB P-LEXV,STACK >STACK
	PUTB P-VTBL,3,STACK
	JUMP ?L92
?L67:	CALL WT?,WORD,PS?PREPOSITION,0 >VAL
	ZERO? VAL \?L69
	EQUAL? WORD,W?ALL,W?ONE,W?A /?L70
	EQUAL? WORD,W?BOTH /?L70
	CALL WT?,WORD,PS?ADJECTIVE >STACK
	ZERO? STACK \?L70
	CALL WT?,WORD,PS?OBJECT >STACK
	ZERO? STACK /?L68
?L70:	SET 'VAL,0
?L69:	GRTR? P-LEN,0 \?L71
	ADD PTR,P-LEXELEN >STACK
	GET P-LEXV,STACK >STACK
	EQUAL? STACK,W?OF \?L71
	ZERO? VAL \?L102
	EQUAL? WORD,W?ALL,W?ONE,W?A /?L71
	EQUAL? WORD,W?BOTH \?L92
?L71:	ZERO? VAL /?L73
?L102:	ZERO? P-LEN /?L74
	ADD PTR,2 >STACK
	GET P-LEXV,STACK >STACK
	EQUAL? STACK,W?THEN,W?$PERIOD \?L73
?L74:	LESS? P-NCN,2 \?L92
	PUT P-ITBL,P-PREP1,VAL
	PUT P-ITBL,P-PREP1N,WORD
	JUMP ?L92
?L73:	EQUAL? P-NCN,2 \?L78
	PRINTI "I found too many nouns in that sentence."
	CRLF
	RFALSE
?L78:	INC 'P-NCN
	CALL CLAUSE,PTR,VAL,WORD >PTR
	ZERO? PTR /FALSE
	LESS? PTR,0 \?L92
	SET 'QUOTE-FLAG,0
	JUMP ?L35
?L68:	CALL WT?,WORD,PS?BUZZ-WORD >STACK
	ZERO? STACK \?L92
	EQUAL? VERB,ACT?TELL \?L88
	CALL WT?,WORD,PS?VERB,P1?VERB >STACK
	ZERO? STACK /?L88
	PRINTI "Please consult your manual for the correct way to talk to other people or creatures."
	CRLF
	RFALSE
?L88:	CALL CANT-USE,PTR
	RFALSE
?L38:	CALL UNKNOWN-WORD,PTR
	RFALSE
?L92:	SET 'LW,WORD
	ADD PTR,P-LEXELEN >PTR
	JUMP ?L34
?L35:	ZERO? DIR /?L93
	SET 'PRSA,V?WALK
	SET 'PRSO,DIR
	SET 'P-WALK-DIR,DIR
	RTRUE
?L93:	SET 'P-WALK-DIR,0
	ZERO? P-OFLAG /?L96
	CALL ORPHAN-MERGE
?L96:	CALL SYNTAX-CHECK >STACK
	ZERO? STACK /FALSE
	CALL SNARF-OBJECTS >STACK
	ZERO? STACK /FALSE
	CALL MANY-CHECK >STACK
	ZERO? STACK /FALSE
	CALL TAKE-CHECK >STACK
	ZERO? STACK \TRUE
	RFALSE

	.FUNCT WT?,PTR,BIT,B1=5,OFFST=P-P1OFF,TYP
	GETB PTR,P-PSOFF >TYP
	BTST TYP,BIT \FALSE
	GRTR? B1,4 /TRUE
	BAND TYP,P-P1BITS >TYP
	EQUAL? TYP,B1 /?L6
	INC 'OFFST
?L6:	GETB PTR,OFFST >STACK
	RSTACK

	.FUNCT CLAUSE,PTR,VAL,WORD,OFF,NUM,ANDFLG=0,FIRST??=1,NW,LW=0
	SUB P-NCN,1 >STACK
	MUL STACK,2 >OFF
	ZERO? VAL /?L1
	ADD P-PREP1,OFF >NUM
	PUT P-ITBL,NUM,VAL
	ADD NUM,1 >STACK
	PUT P-ITBL,STACK,WORD
	ADD PTR,P-LEXELEN >PTR
	JUMP ?L3
?L1:	INC 'P-LEN
?L3:	ZERO? P-LEN \?L4
	DEC 'P-NCN
	RETURN -1
?L4:	ADD P-NC1,OFF >NUM
	MUL PTR,2 >STACK
	ADD P-LEXV,STACK >STACK
	PUT P-ITBL,NUM,STACK
	GET P-LEXV,PTR >STACK
	EQUAL? STACK,W?THE,W?A,W?AN \?L7
	GET P-ITBL,NUM >STACK
	ADD STACK,4 >STACK
	PUT P-ITBL,NUM,STACK
?L7:	DLESS? 'P-LEN,0 \?L12
	MUL PTR,2 >STACK
	ADD P-LEXV,STACK >STACK
	ADD NUM,1 >STACK
	PUT P-ITBL,STACK,STACK
	RETURN -1
?L12:	GET P-LEXV,PTR >WORD
	ZERO? WORD \?L17
	CALL NUMBER?,PTR >WORD
	ZERO? WORD /?L15
?L17:	ZERO? P-LEN \?L18
	SET 'NW,0
	JUMP ?L20
?L18:	ADD PTR,P-LEXELEN >STACK
	GET P-LEXV,STACK >NW
?L20:	EQUAL? WORD,W?AND,W?$COMMA \?L21
	SET 'ANDFLG,1
	JUMP ?L42
?L21:	EQUAL? WORD,W?ALL,W?BOTH,W?ONE \?L23
	EQUAL? NW,W?OF \?L42
	DEC 'P-LEN
	ADD PTR,P-LEXELEN >PTR
	JUMP ?L42
?L23:	EQUAL? WORD,W?THEN,W?$PERIOD /?L28
	CALL WT?,WORD,PS?PREPOSITION >STACK
	ZERO? STACK /?L27
	ZERO? FIRST?? \?L27
?L28:	INC 'P-LEN
	MUL PTR,2 >STACK
	ADD P-LEXV,STACK >STACK
	ADD NUM,1 >STACK
	PUT P-ITBL,STACK,STACK
	SUB PTR,P-LEXELEN >STACK
	RSTACK
?L27:	CALL WT?,WORD,PS?OBJECT >STACK
	ZERO? STACK /?L29
	GRTR? P-LEN,0 \?L30
	EQUAL? NW,W?OF \?L30
	EQUAL? WORD,W?ALL,W?ONE \?L42
?L30:	CALL WT?,WORD,PS?ADJECTIVE,P1?ADJECTIVE >STACK
	ZERO? STACK /?L32
	ZERO? NW /?L32
	CALL WT?,NW,PS?OBJECT >STACK
	ZERO? STACK \?L42
?L32:	ZERO? ANDFLG \?L33
	EQUAL? NW,W?BUT,W?EXCEPT,W?AND /?L33
	EQUAL? NW,W?$COMMA /?L33
	ADD PTR,2 >STACK
	MUL STACK,2 >STACK
	ADD P-LEXV,STACK >STACK
	ADD NUM,1 >STACK
	PUT P-ITBL,STACK,STACK
	RETURN PTR
?L33:	SET 'ANDFLG,0
	JUMP ?L42
?L29:	ZERO? P-OFLAG \?L36
	ZERO? P-MERGED \?L36
	GET P-ITBL,P-VERB >STACK
	ZERO? STACK /?L35
?L36:	CALL WT?,WORD,PS?ADJECTIVE >STACK
	ZERO? STACK \?L42
	CALL WT?,WORD,PS?BUZZ-WORD >STACK
	ZERO? STACK \?L42
?L35:	ZERO? ANDFLG /?L38
	CALL WT?,WORD,PS?DIRECTION >STACK
	ZERO? STACK \?L39
	CALL WT?,WORD,PS?VERB >STACK
	ZERO? STACK /?L38
?L39:	SUB PTR,4 >PTR
	ADD PTR,2 >STACK
	PUT P-LEXV,STACK,W?THEN
	ADD P-LEN,2 >P-LEN
	JUMP ?L42
?L38:	CALL WT?,WORD,PS?PREPOSITION >STACK
	ZERO? STACK \?L42
	CALL CANT-USE,PTR
	RFALSE
?L15:	CALL UNKNOWN-WORD,PTR
	RFALSE
?L42:	SET 'LW,WORD
	SET 'FIRST??,0
	ADD PTR,P-LEXELEN >PTR
	JUMP ?L7

	.FUNCT NUMBER?,PTR,CNT,BPTR,CHR,SUM=0,TIM=0
	MUL PTR,2 >STACK
	ADD P-LEXV,STACK >STACK
	GETB STACK,2 >CNT
	MUL PTR,2 >STACK
	ADD P-LEXV,STACK >STACK
	GETB STACK,3 >BPTR
?L1:	DLESS? 'CNT,0 /?L2
	GETB P-INBUF,BPTR >CHR
	GRTR? SUM,10000 /FALSE
	LESS? CHR,58 \FALSE
	GRTR? CHR,47 \FALSE
	SUB CHR,48 >STACK
	MUL SUM,10 >STACK
	ADD STACK,STACK >SUM
	INC 'BPTR
	JUMP ?L1
?L2:	PUT P-LEXV,PTR,W?INTNUM
	GRTR? SUM,10000 /FALSE
	SET 'P-NUMBER,SUM
	RETURN W?INTNUM

	.FUNCT ORPHAN-MERGE,CNT=-1,TEMP,VERB,BEG,END,ADJ=0,WRD
	SET 'P-OFLAG,0
	GET P-ITBL,P-VERBN >STACK
	GET STACK,0 >WRD
	CALL WT?,WRD,PS?ADJECTIVE,P1?ADJECTIVE >STACK
	ZERO? STACK /?L1
	SET 'ADJ,1
	JUMP ?L3
?L1:	CALL WT?,WRD,PS?OBJECT,P1?OBJECT >STACK
	ZERO? STACK /?L3
	ZERO? P-NCN \?L3
	PUT P-ITBL,P-VERB,0
	PUT P-ITBL,P-VERBN,0
	ADD P-LEXV,2 >STACK
	PUT P-ITBL,P-NC1,STACK
	ADD P-LEXV,6 >STACK
	PUT P-ITBL,P-NC1L,STACK
	SET 'P-NCN,1
?L3:	GET P-ITBL,P-VERB >VERB
	ZERO? VERB /?L5
	ZERO? ADJ \?L5
	GET P-OTBL,P-VERB >STACK
	EQUAL? VERB,STACK \FALSE
?L5:	EQUAL? P-NCN,2 /FALSE
	GET P-OTBL,P-NC1 >STACK
	EQUAL? STACK,1 \?L8
	GET P-ITBL,P-PREP1 >TEMP
	GET P-OTBL,P-PREP1 >STACK
	EQUAL? TEMP,STACK /?L11
	ZERO? TEMP \FALSE
?L11:	ZERO? ADJ /?L12
	ADD P-LEXV,2 >STACK
	PUT P-OTBL,P-NC1,STACK
	ADD P-LEXV,6 >STACK
	PUT P-OTBL,P-NC1L,STACK
	JUMP ?L32
?L12:	GET P-ITBL,P-NC1 >STACK
	PUT P-OTBL,P-NC1,STACK
	GET P-ITBL,P-NC1L >STACK
	PUT P-OTBL,P-NC1L,STACK
	JUMP ?L32
?L8:	GET P-OTBL,P-NC2 >STACK
	EQUAL? STACK,1 \?L16
	GET P-ITBL,P-PREP1 >TEMP
	GET P-OTBL,P-PREP2 >STACK
	EQUAL? TEMP,STACK /?L19
	ZERO? TEMP \FALSE
?L19:	ZERO? ADJ /?L20
	ADD P-LEXV,2 >STACK
	PUT P-ITBL,P-NC1,STACK
	ADD P-LEXV,6 >STACK
	PUT P-ITBL,P-NC1L,STACK
?L20:	GET P-ITBL,P-NC1 >STACK
	PUT P-OTBL,P-NC2,STACK
	GET P-ITBL,P-NC1L >STACK
	PUT P-OTBL,P-NC2L,STACK
	SET 'P-NCN,2
	JUMP ?L32
?L16:	ZERO? P-ACLAUSE /?L32
	EQUAL? P-NCN,1 /?L25
	ZERO? ADJ \?L25
	SET 'P-ACLAUSE,0
	RFALSE
?L25:	GET P-ITBL,P-NC1 >BEG
	ZERO? ADJ /?L28
	ADD P-LEXV,2 >BEG
	SET 'ADJ,0
?L28:	GET P-ITBL,P-NC1L >END
?L31:	GET BEG,0 >WRD
	EQUAL? BEG,END \?L33
	ZERO? ADJ /?L35
	CALL ACLAUSE-WIN,ADJ
	JUMP ?L32
?L35:	SET 'P-ACLAUSE,0
	RFALSE
?L33:	ZERO? ADJ \?L38
	GETB WRD,P-PSOFF >STACK
	BTST STACK,PS?ADJECTIVE /?L39
	EQUAL? WRD,W?ALL,W?ONE \?L38
?L39:	SET 'ADJ,WRD
	JUMP ?L44
?L38:	GETB WRD,P-PSOFF >STACK
	BTST STACK,PS?OBJECT /?L41
	EQUAL? WRD,W?ONE \?L44
?L41:	EQUAL? WRD,P-ANAM,W?ONE \FALSE
	CALL ACLAUSE-WIN,ADJ
	JUMP ?L32
?L44:	ADD BEG,P-WORDLEN >BEG
	ZERO? END \?L31
	SET 'END,BEG
	SET 'P-NCN,1
	SUB BEG,4 >STACK
	PUT P-ITBL,P-NC1,STACK
	PUT P-ITBL,P-NC1L,BEG
	JUMP ?L31
?L32:	IGRTR? 'CNT,P-ITBLLEN \?L52
	SET 'P-MERGED,1
	RTRUE
?L52:	GET P-OTBL,CNT >STACK
	PUT P-ITBL,CNT,STACK
	JUMP ?L32

	.FUNCT ACLAUSE-WIN,ADJ
	GET P-OTBL,P-VERB >STACK
	PUT P-ITBL,P-VERB,STACK
	SET 'P-CCSRC,P-OTBL
	ADD P-ACLAUSE,1 >STACK
	CALL CLAUSE-COPY,P-ACLAUSE,STACK,ADJ
	GET P-OTBL,P-NC2 >STACK
	ZERO? STACK /?L1
	SET 'P-NCN,2
?L1:	SET 'P-ACLAUSE,0
	RTRUE

	.FUNCT WORD-PRINT,CNT,BUF
?L1:	DLESS? 'CNT,0 /TRUE
	GETB P-INBUF,BUF >STACK
	PRINTC STACK
	INC 'BUF
	JUMP ?L1

	.FUNCT UNKNOWN-WORD,PTR,BUF,?TMP
	PRINTI "I don't know the word """
	MUL PTR,2 >BUF
	ADD P-LEXV,BUF >STACK
	GETB STACK,2 >?TMP
	ADD P-LEXV,BUF >STACK
	GETB STACK,3 >STACK
	CALL WORD-PRINT,?TMP,STACK
	PRINTI "."""
	CRLF
	SET 'QUOTE-FLAG,0
	SET 'P-OFLAG,0
	RETURN P-OFLAG

	.FUNCT CANT-USE,PTR,BUF,?TMP
	PRINTI "I can't use the word """
	MUL PTR,2 >BUF
	ADD P-LEXV,BUF >STACK
	GETB STACK,2 >?TMP
	ADD P-LEXV,BUF >STACK
	GETB STACK,3 >STACK
	CALL WORD-PRINT,?TMP,STACK
	PRINTI """ here."
	CRLF
	SET 'QUOTE-FLAG,0
	SET 'P-OFLAG,0
	RETURN P-OFLAG

	.FUNCT SYNTAX-CHECK,SYN,LEN,NUM,OBJ,DRIVE1=0,DRIVE2=0,PREP,VERB,TMP
	GET P-ITBL,P-VERB >VERB
	ZERO? VERB \?L1
	PRINTI "I can't find a verb in that sentence!"
	CRLF
	RFALSE
?L1:	SUB 255,VERB >STACK
	GET VERBS,STACK >SYN
	GETB SYN,0 >LEN
	INC 'SYN
?L6:	GETB SYN,P-SBITS >STACK
	BAND STACK,P-SONUMS >NUM
	GRTR? P-NCN,NUM /?L15
	LESS? NUM,1 /?L10
	ZERO? P-NCN \?L10
	GET P-ITBL,P-PREP1 >PREP
	ZERO? PREP /?L11
	GETB SYN,P-SPREP1 >STACK
	EQUAL? PREP,STACK \?L10
?L11:	SET 'DRIVE1,SYN
	JUMP ?L15
?L10:	GET P-ITBL,P-PREP1 >STACK
	GETB SYN,P-SPREP1 >STACK
	EQUAL? STACK,STACK \?L15
	EQUAL? NUM,2 \?L13
	EQUAL? P-NCN,1 \?L13
	SET 'DRIVE2,SYN
	JUMP ?L15
?L13:	GET P-ITBL,P-PREP2 >STACK
	GETB SYN,P-SPREP2 >STACK
	EQUAL? STACK,STACK \?L15
	CALL SYNTAX-FOUND,SYN
	RTRUE
?L15:	DLESS? 'LEN,1 \?L18
	ZERO? DRIVE1 \?L51
	ZERO? DRIVE2 \?L7
	PRINTI "I don't understand that sentence."
	CRLF
	RFALSE
?L18:	ADD SYN,P-SYNLEN >SYN
	JUMP ?L6
?L7:	ZERO? DRIVE1 /?L27
?L51:	GETB DRIVE1,P-SPREP1 >STACK
	GETB DRIVE1,P-SLOC1 >STACK
	GETB DRIVE1,P-SFWIM1 >STACK
	CALL GWIM,STACK,STACK,STACK >OBJ
	ZERO? OBJ /?L27
	PUT P-PRSO,P-MATCHLEN,1
	PUT P-PRSO,1,OBJ
	CALL SYNTAX-FOUND,DRIVE1 >STACK
	RSTACK
?L27:	ZERO? DRIVE2 /?L29
	GETB DRIVE2,P-SPREP2 >STACK
	GETB DRIVE2,P-SLOC2 >STACK
	GETB DRIVE2,P-SFWIM2 >STACK
	CALL GWIM,STACK,STACK,STACK >OBJ
	ZERO? OBJ /?L29
	PUT P-PRSI,P-MATCHLEN,1
	PUT P-PRSI,1,OBJ
	CALL SYNTAX-FOUND,DRIVE2 >STACK
	RSTACK
?L29:	EQUAL? VERB,ACT?FIND \?L30
	PRINTI "I can't answer that question."
	CRLF
	RFALSE
?L30:	EQUAL? WINNER,ADVENTURER /?L33
	CALL CANT-ORPHAN >STACK
	RSTACK
?L33:	CALL ORPHAN,DRIVE1,DRIVE2
	PRINTI "What do you want to "
	GET P-OTBL,P-VERBN >TMP
	ZERO? TMP \?L37
	PRINTI "tell"
	JUMP ?L42
?L37:	GETB P-VTBL,2 >STACK
	ZERO? STACK \?L41
	GET TMP,0 >STACK
	PRINTB STACK
	JUMP ?L42
?L41:	GETB TMP,3 >STACK
	GETB TMP,2 >STACK
	CALL WORD-PRINT,STACK,STACK
	PUTB P-VTBL,2,0
?L42:	ZERO? DRIVE2 /?L43
	CALL CLAUSE-PRINT,P-NC1,P-NC1L
?L43:	SET 'P-OFLAG,1
	ZERO? DRIVE1 /?L46
	GETB DRIVE1,P-SPREP1 >STACK
	JUMP ?L48
?L46:	GETB DRIVE2,P-SPREP2 >STACK
?L48:	CALL PREP-PRINT,STACK
	PRINTI "?"
	CRLF
	RFALSE

	.FUNCT CANT-ORPHAN
	PRINTI """I don't understand! What are you referring to?"""
	CRLF
	RFALSE

	.FUNCT ORPHAN,D1,D2,CNT=-1
	PUT P-OCLAUSE,P-MATCHLEN,0
	SET 'P-CCSRC,P-ITBL
?L1:	IGRTR? 'CNT,P-ITBLLEN /?L2
	GET P-ITBL,CNT >STACK
	PUT P-OTBL,CNT,STACK
	JUMP ?L1
?L2:	EQUAL? P-NCN,2 \?L6
	CALL CLAUSE-COPY,P-NC2,P-NC2L
?L6:	LESS? P-NCN,1 /?L9
	CALL CLAUSE-COPY,P-NC1,P-NC1L
?L9:	ZERO? D1 /?L12
	GETB D1,P-SPREP1 >STACK
	PUT P-OTBL,P-PREP1,STACK
	PUT P-OTBL,P-NC1,1
	RTRUE
?L12:	ZERO? D2 /FALSE
	GETB D2,P-SPREP2 >STACK
	PUT P-OTBL,P-PREP2,STACK
	PUT P-OTBL,P-NC2,1
	RTRUE

	.FUNCT CLAUSE-PRINT,BPTR,EPTR,THE?=1
	GET P-ITBL,EPTR >STACK
	GET P-ITBL,BPTR >STACK
	CALL BUFFER-PRINT,STACK,STACK,THE? >STACK
	RSTACK

	.FUNCT BUFFER-PRINT,BEG,END,CP,NOSP=0,WRD,FIRST??=1,PN=0
?L1:	EQUAL? BEG,END /TRUE
	ZERO? NOSP /?L6
	SET 'NOSP,0
	JUMP ?L8
?L6:	PRINTI " "
?L8:	GET BEG,0 >WRD
	EQUAL? WRD,W?$PERIOD \?L11
	SET 'NOSP,1
	JUMP ?L14
?L11:	EQUAL? WRD,W?FLOYD,W?BLATHER \?L13
	CALL CAPITALIZE,BEG
	SET 'PN,1
	JUMP ?L14
?L13:	ZERO? FIRST?? /?L15
	ZERO? PN \?L15
	ZERO? CP /?L15
	PRINTI "the "
?L15:	ZERO? P-OFLAG /?L20
	PRINTB WRD
	JUMP ?L23
?L20:	EQUAL? WRD,W?IT \?L22
	EQUAL? P-IT-LOC,HERE \?L22
	PRINTD P-IT-OBJECT
	JUMP ?L23
?L22:	GETB BEG,3 >STACK
	GETB BEG,2 >STACK
	CALL WORD-PRINT,STACK,STACK
?L23:	SET 'FIRST??,0
?L14:	ADD BEG,P-WORDLEN >BEG
	JUMP ?L1

	.FUNCT CAPITALIZE,PTR
	GETB PTR,3 >STACK
	GETB P-INBUF,STACK >STACK
	SUB STACK,32 >STACK
	PRINTC STACK
	GETB PTR,3 >STACK
	INC 'STACK
	GETB PTR,2 >STACK
	DEC 'STACK
	CALL WORD-PRINT,STACK,STACK >STACK
	RSTACK

	.FUNCT PREP-PRINT,PREP,WRD
	ZERO? PREP /FALSE
	PRINTI " "
	CALL PREP-FIND,PREP >WRD
	PRINTB WRD
	RTRUE

	.FUNCT CLAUSE-COPY,BPTR,EPTR,INSRT=0,BEG,END
	GET P-CCSRC,BPTR >BEG
	GET P-CCSRC,EPTR >END
	GET P-OCLAUSE,P-MATCHLEN >STACK
	MUL STACK,P-LEXELEN >STACK
	ADD STACK,2 >STACK
	ADD P-OCLAUSE,STACK >STACK
	PUT P-OTBL,BPTR,STACK
?L1:	EQUAL? BEG,END \?L3
	GET P-OCLAUSE,P-MATCHLEN >STACK
	MUL STACK,P-LEXELEN >STACK
	ADD STACK,2 >STACK
	ADD P-OCLAUSE,STACK >STACK
	PUT P-OTBL,EPTR,STACK
	RTRUE
?L3:	ZERO? INSRT /?L6
	GET BEG,0 >STACK
	EQUAL? P-ANAM,STACK \?L6
	CALL CLAUSE-ADD,INSRT
?L6:	GET BEG,0 >STACK
	CALL CLAUSE-ADD,STACK
	ADD BEG,P-WORDLEN >BEG
	JUMP ?L1

	.FUNCT CLAUSE-ADD,WRD,PTR
	GET P-OCLAUSE,P-MATCHLEN >STACK
	ADD STACK,2 >PTR
	SUB PTR,1 >STACK
	PUT P-OCLAUSE,STACK,WRD
	PUT P-OCLAUSE,PTR,0
	PUT P-OCLAUSE,P-MATCHLEN,PTR
	RTRUE

	.FUNCT PREP-FIND,PREP,CNT=0,SIZE
	GET PREPOSITIONS,0 >STACK
	MUL STACK,2 >SIZE
?L1:	IGRTR? 'CNT,SIZE /FALSE
	GET PREPOSITIONS,CNT >STACK
	EQUAL? STACK,PREP \?L1
	SUB CNT,1 >STACK
	GET PREPOSITIONS,STACK >STACK
	RSTACK

	.FUNCT SYNTAX-FOUND,SYN
	SET 'P-SYNTAX,SYN
	GETB SYN,P-SACTION >PRSA
	RETURN PRSA

	.FUNCT GWIM,GBIT,LBIT,PREP,OBJ
	EQUAL? GBIT,RMUNGBIT \?L1
	RETURN ROOMS
?L1:	SET 'P-GWIMBIT,GBIT
	SET 'P-SLOCBITS,LBIT
	PUT P-MERGE,P-MATCHLEN,0
	CALL GET-OBJECT,P-MERGE,0 >STACK
	ZERO? STACK /?L4
	SET 'P-GWIMBIT,0
	GET P-MERGE,P-MATCHLEN >STACK
	EQUAL? STACK,1 \FALSE
	GET P-MERGE,1 >OBJ
	FSET? OBJ,VEHBIT \?L8
	EQUAL? PREP,PR?DOWN \?L8
	SET 'PREP,PR?ON
?L8:	PRINTI "("
	ZERO? PREP /?L13
	CALL PREP-FIND,PREP >STACK
	PRINTB STACK
	PRINTI " the "
?L13:	PRINTD OBJ
	PRINTI ")"
	CRLF
	RETURN OBJ
?L4:	SET 'P-GWIMBIT,0
	RFALSE

	.FUNCT SNARF-OBJECTS,PTR
	GET P-ITBL,P-NC1 >PTR
	ZERO? PTR /?L5
	GETB P-SYNTAX,P-SLOC1 >P-SLOCBITS
	GET P-ITBL,P-NC1L >STACK
	CALL SNARFEM,PTR,STACK,P-PRSO >STACK
	ZERO? STACK /FALSE
	GET P-BUTS,P-MATCHLEN >STACK
	ZERO? STACK /?L5
	CALL BUT-MERGE,P-PRSO >P-PRSO
?L5:	GET P-ITBL,P-NC2 >PTR
	ZERO? PTR /TRUE
	GETB P-SYNTAX,P-SLOC2 >P-SLOCBITS
	GET P-ITBL,P-NC2L >STACK
	CALL SNARFEM,PTR,STACK,P-PRSI >STACK
	ZERO? STACK /FALSE
	GET P-BUTS,P-MATCHLEN >STACK
	ZERO? STACK /TRUE
	GET P-PRSI,P-MATCHLEN >STACK
	EQUAL? STACK,1 \?L14
	CALL BUT-MERGE,P-PRSO >P-PRSO
	RTRUE
?L14:	CALL BUT-MERGE,P-PRSI >P-PRSI
	RTRUE

	.FUNCT BUT-MERGE,TBL,LEN,BUTLEN,CNT=1,MATCHES=0,OBJ,NTBL
	GET TBL,P-MATCHLEN >LEN
	PUT P-MERGE,P-MATCHLEN,0
?L1:	DLESS? 'LEN,0 /?L2
	GET TBL,CNT >OBJ
	CALL ZMEMQ,OBJ,P-BUTS >STACK
	ZERO? STACK \?L6
	ADD MATCHES,1 >STACK
	PUT P-MERGE,STACK,OBJ
	INC 'MATCHES
?L6:	INC 'CNT
	JUMP ?L1
?L2:	PUT P-MERGE,P-MATCHLEN,MATCHES
	SET 'NTBL,P-MERGE
	SET 'P-MERGE,TBL
	RETURN NTBL

	.FUNCT SNARFEM,PTR,EPTR,TBL,BUT=0,LEN,WV,WORD,NW
	SET 'P-AND,0
	SET 'P-GETFLAGS,0
	SET 'P-CSPTR,PTR
	SET 'P-CEPTR,EPTR
	PUT P-BUTS,P-MATCHLEN,0
	PUT TBL,P-MATCHLEN,0
	GET PTR,0 >WORD
?L1:	EQUAL? PTR,EPTR \?L3
?L49:	ZERO? BUT /?L6
	PUSH BUT
	JUMP ?L5
?L6:	PUSH TBL
?L5:	CALL GET-OBJECT,STACK >STACK
	RSTACK
?L3:	GET PTR,P-LEXELEN >NW
	EQUAL? WORD,W?ALL,W?BOTH \?L8
	SET 'P-GETFLAGS,P-ALL
	EQUAL? NW,W?OF \?L44
	ADD PTR,P-WORDLEN >PTR
	JUMP ?L44
?L8:	EQUAL? WORD,W?BUT,W?EXCEPT \?L13
	ZERO? BUT /?L17
	PUSH BUT
	JUMP ?L16
?L17:	PUSH TBL
?L16:	CALL GET-OBJECT,STACK >STACK
	ZERO? STACK /FALSE
	SET 'BUT,P-BUTS
	PUT BUT,P-MATCHLEN,0
	JUMP ?L44
?L13:	EQUAL? WORD,W?A,W?ONE \?L18
	ZERO? P-ADJ \?L19
	SET 'P-GETFLAGS,P-ONE
	EQUAL? NW,W?OF \?L44
	ADD PTR,P-WORDLEN >PTR
	JUMP ?L44
?L19:	SET 'P-NAM,P-ONEOBJ
	ZERO? BUT /?L28
	PUSH BUT
	JUMP ?L27
?L28:	PUSH TBL
?L27:	CALL GET-OBJECT,STACK >STACK
	ZERO? STACK /FALSE
	ZERO? NW /TRUE
	JUMP ?L44
?L18:	EQUAL? WORD,W?AND,W?$COMMA \?L31
	EQUAL? NW,W?AND,W?$COMMA /?L31
	SET 'P-AND,1
	ZERO? BUT /?L35
	PUSH BUT
	JUMP ?L34
?L35:	PUSH TBL
?L34:	CALL GET-OBJECT,STACK >STACK
	ZERO? STACK /FALSE
	JUMP ?L44
?L31:	CALL WT?,WORD,PS?PREPOSITION >STACK
	ZERO? STACK /?L36
	EQUAL? PTR,P-CSPTR \?L36
	ADD P-CSPTR,P-WORDLEN >P-CSPTR
	JUMP ?L44
?L36:	CALL WT?,WORD,PS?BUZZ-WORD >STACK
	ZERO? STACK \?L44
	EQUAL? WORD,W?AND,W?$COMMA /?L44
	EQUAL? WORD,W?OF \?L39
	ZERO? P-GETFLAGS \?L44
	SET 'P-GETFLAGS,P-INHIBIT
	JUMP ?L44
?L39:	CALL WT?,WORD,PS?ADJECTIVE,P1?ADJECTIVE >WV
	ZERO? WV /?L43
	CALL ADJ-CHECK >STACK
	ZERO? STACK /?L43
	SET 'P-ADJ,WV
	SET 'P-ADJN,WORD
	SET 'P-ADJECTIVE,WORD
	JUMP ?L44
?L43:	CALL WT?,WORD,PS?OBJECT,P1?OBJECT >STACK
	ZERO? STACK /?L44
	SET 'P-NAM,WORD
	SET 'P-ONEOBJ,WORD
?L44:	EQUAL? PTR,EPTR /?L49
	ADD PTR,P-WORDLEN >PTR
	SET 'WORD,NW
	JUMP ?L1

	.FUNCT ADJ-CHECK
	ZERO? P-ADJ /TRUE
	EQUAL? P-ADJ,A?FIRST,A?SECOND,A?THIRD /FALSE
	EQUAL? P-ADJ,A?FOURTH,A?OLD,A?NEW /FALSE
	EQUAL? P-ADJ,A?SEND,A?RECEIVE,A?KITCHEN /FALSE
	EQUAL? P-ADJ,A?UPPER,A?LOWER,A?SHUTTL /FALSE
	EQUAL? P-ADJ,A?ELEVATOR,A?SQUARE,A?ROUND /FALSE
	EQUAL? P-ADJ,A?GOOD,A?SHINY,A?CRACKED /FALSE
	EQUAL? P-ADJ,A?FRIED /FALSE
	EQUAL? P-ADJ,A?TELEPO,A?MINI,A?MINIAT \TRUE
	RFALSE

	.FUNCT GET-OBJECT,TBL,VRB=1,BITS,LEN,XBITS,TLEN,GCHECK=0,OLEN=0,OBJ
	SET 'XBITS,P-SLOCBITS
	GET TBL,P-MATCHLEN >TLEN
	BTST P-GETFLAGS,P-INHIBIT /TRUE
	ZERO? P-NAM \?L7
	ZERO? P-ADJ /?L4
	CALL WT?,P-ADJN,PS?OBJECT,P1?OBJECT >STACK
	ZERO? STACK /?L4
	SET 'P-NAM,P-ADJN
	SET 'P-ADJ,0
?L4:	ZERO? P-NAM \?L7
	ZERO? P-ADJ \?L7
	EQUAL? P-GETFLAGS,P-ALL /?L76
	ZERO? P-GWIMBIT \?L7
	ZERO? VRB /FALSE
	PRINTI "I couldn't find a noun in that sentence!"
	CRLF
	RFALSE
?L7:	EQUAL? P-GETFLAGS,P-ALL \?L17
?L76:	ZERO? P-SLOCBITS \?L15
?L17:	SET 'P-SLOCBITS,-1
?L15:	SET 'P-TABLE,TBL
?L19:	ZERO? GCHECK /?L21
	CALL GLOBAL-CHECK,TBL
	JUMP ?L33
?L21:	ZERO? LIT /?L29
	EQUAL? WINNER,ADVENTURER /?L26
	FCLEAR WINNER,OPENBIT
?L26:	CALL DO-SL,HERE,SOG,SIR
	EQUAL? WINNER,ADVENTURER /?L29
	FSET WINNER,OPENBIT
?L29:	CALL DO-SL,WINNER,SH,SC
	EQUAL? WINNER,ADVENTURER /?L33
	EQUAL? P-GETFLAGS,P-ALL /?L33
	CALL DO-SL,ADVENTURER,SH,SC
?L33:	GET TBL,P-MATCHLEN >STACK
	SUB STACK,TLEN >LEN
	BTST P-GETFLAGS,P-ALL /?L74
	BTST P-GETFLAGS,P-ONE \?L38
	ZERO? LEN /?L38
	EQUAL? LEN,1 /?L39
	RANDOM LEN >STACK
	GET TBL,STACK >STACK
	PUT TBL,1,STACK
	PRINTI "(How about the "
	GET TBL,1 >STACK
	PRINTD STACK
	PRINTI "?)"
	CRLF
?L39:	PUT TBL,P-MATCHLEN,1
	JUMP ?L74
?L38:	GRTR? LEN,1 /?L47
	ZERO? LEN \?L74
	EQUAL? P-SLOCBITS,-1 /?L46
?L47:	EQUAL? P-SLOCBITS,-1 \?L48
	SET 'P-SLOCBITS,XBITS
	SET 'OLEN,LEN
	GET TBL,P-MATCHLEN >STACK
	SUB STACK,LEN >STACK
	PUT TBL,P-MATCHLEN,STACK
	JUMP ?L19
?L48:	ZERO? LEN \?L51
	SET 'LEN,OLEN
?L51:	EQUAL? WINNER,ADVENTURER /?L54
	CALL CANT-ORPHAN
	RFALSE
?L54:	ZERO? VRB /?L60
	ZERO? P-NAM /?L56
	CALL WHICH-PRINT,TLEN,LEN,TBL
	EQUAL? TBL,P-PRSO \?L57
	SET 'P-ACLAUSE,P-NC1
	JUMP ?L59
?L57:	SET 'P-ACLAUSE,P-NC2
?L59:	SET 'P-AADJ,P-ADJ
	SET 'P-ANAM,P-NAM
	CALL ORPHAN,0,0
	SET 'P-OFLAG,1
	JUMP ?L60
?L56:	ZERO? VRB /?L60
	PRINTI "I couldn't find a noun in that sentence!"
	CRLF
?L60:	SET 'P-NAM,0
	SET 'P-ADJ,0
	RFALSE
?L46:	ZERO? LEN \?L74
	ZERO? GCHECK /?L64
	ZERO? VRB /?L70
	SET 'P-SLOCBITS,XBITS
	ZERO? LIT \?L69
	EQUAL? P-NAM,W?GRUE \?L67
?L69:	CALL OBJ-FOUND,NOT-HERE-OBJECT,TBL
	SET 'P-XNAM,P-NAM
	SET 'P-XADJ,P-ADJ
	SET 'P-XADJN,P-ADJN
	SET 'P-NAM,0
	SET 'P-ADJ,0
	SET 'P-ADJN,0
	RTRUE
?L67:	PRINTI "It's too dark to see!"
	CRLF
?L70:	SET 'P-NAM,0
	SET 'P-ADJ,0
	RFALSE
?L64:	ZERO? LEN \?L74
	SET 'GCHECK,1
	JUMP ?L19
?L74:	SET 'P-SLOCBITS,XBITS
	SET 'P-NAM,0
	SET 'P-ADJ,0
	RTRUE

	.FUNCT MOBY-FIND,TBL,FOO,LEN
	SET 'P-SLOCBITS,-1
	SET 'P-NAM,P-XNAM
	SET 'P-ADJ,P-XADJ
	PUT TBL,P-MATCHLEN,0
	FIRST? ROOMS >FOO \?L3
?L4:	CALL SEARCH-LIST,FOO,TBL,P-SRCALL
	NEXT? FOO >FOO /?L4
?L3:	GET TBL,P-MATCHLEN >LEN
	ZERO? LEN \?L8
	CALL DO-SL,LOCAL-GLOBALS,1,1
?L8:	GET TBL,P-MATCHLEN >LEN
	ZERO? LEN \?L11
	CALL DO-SL,ROOMS,1,1
?L11:	GET TBL,P-MATCHLEN >LEN
	EQUAL? LEN,1 \?L14
	GET TBL,1 >P-MOBY-FOUND
?L14:	SET 'P-NAM,0
	SET 'P-ADJ,0
	RETURN LEN

	.FUNCT WHICH-PRINT,TLEN,LEN,TBL,OBJ,RLEN
	SET 'RLEN,LEN
	PRINTI "Which"
	ZERO? P-OFLAG \?L5
	ZERO? P-MERGED \?L5
	ZERO? P-AND /?L3
?L5:	PRINTI " "
	PRINTB P-NAM
	JUMP ?L9
?L3:	EQUAL? TBL,P-PRSO \?L8
	CALL CLAUSE-PRINT,P-NC1,P-NC1L,0
	JUMP ?L9
?L8:	CALL CLAUSE-PRINT,P-NC2,P-NC2L,0
?L9:	PRINTI " do you mean, "
?L12:	INC 'TLEN
	GET TBL,TLEN >OBJ
	PRINTI "the "
	PRINTD OBJ
	EQUAL? LEN,2 \?L18
	EQUAL? RLEN,2 /?L20
	PRINTI ","
?L20:	PRINTI " or "
	JUMP ?L27
?L18:	GRTR? LEN,2 \?L27
	PRINTI ", "
?L27:	DLESS? 'LEN,1 \?L12
	PRINTR "?"

	.FUNCT GLOBAL-CHECK,TBL,LEN,RMG,RMGL,CNT=0,OBJ,OBITS,FOO
	GET TBL,P-MATCHLEN >LEN
	SET 'OBITS,P-SLOCBITS
	GETPT HERE,P?GLOBAL >RMG
	ZERO? RMG /?L4
	PTSIZE RMG >STACK
	SUB STACK,1 >RMGL
?L3:	GETB RMG,CNT >OBJ
	CALL THIS-IT?,OBJ,TBL >STACK
	ZERO? STACK /?L5
	CALL OBJ-FOUND,OBJ,TBL
?L5:	IGRTR? 'CNT,RMGL \?L3
?L4:	GETPT HERE,P?PSEUDO >RMG
	ZERO? RMG /?L15
	PTSIZE RMG >STACK
	DIV STACK,4 >STACK
	SUB STACK,1 >RMGL
	SET 'CNT,0
?L14:	MUL CNT,2 >STACK
	GET RMG,STACK >STACK
	EQUAL? P-NAM,STACK \?L16
	SET 'LAST-PSEUDO-LOC,HERE
	MUL CNT,2 >STACK
	INC 'STACK
	GET RMG,STACK >STACK
	PUTP PSEUDO-OBJECT,P?ACTION,STACK
	GETPT PSEUDO-OBJECT,P?ACTION >STACK
	SUB STACK,5 >FOO
	GET P-NAM,0 >STACK
	PUT FOO,0,STACK
	GET P-NAM,1 >STACK
	PUT FOO,1,STACK
	CALL OBJ-FOUND,PSEUDO-OBJECT,TBL
	JUMP ?L15
?L16:	IGRTR? 'CNT,RMGL \?L14
?L15:	GET TBL,P-MATCHLEN >STACK
	EQUAL? STACK,LEN \FALSE
	SET 'P-SLOCBITS,-1
	SET 'P-TABLE,TBL
	CALL DO-SL,GLOBAL-OBJECTS,1,1
	SET 'P-SLOCBITS,OBITS
	GET TBL,P-MATCHLEN >STACK
	ZERO? STACK \FALSE
	EQUAL? PRSA,V?LOOK-INSIDE,V?SEARCH /?L27
	EQUAL? PRSA,V?EXAMINE,V?FIND,V?THROUGH \FALSE
?L27:	CALL DO-SL,ROOMS,1,1 >STACK
	RSTACK

	.FUNCT DO-SL,OBJ,BIT1,BIT2
	ADD BIT1,BIT2 >STACK
	BTST P-SLOCBITS,STACK \?L1
	CALL SEARCH-LIST,OBJ,P-TABLE,P-SRCALL >STACK
	RSTACK
?L1:	BTST P-SLOCBITS,BIT1 \?L4
	CALL SEARCH-LIST,OBJ,P-TABLE,P-SRCTOP >STACK
	RSTACK
?L4:	BTST P-SLOCBITS,BIT2 \TRUE
	CALL SEARCH-LIST,OBJ,P-TABLE,P-SRCBOT >STACK
	RSTACK

	.FUNCT SEARCH-LIST,OBJ,TBL,LVL,FLS,NOBJ
	FIRST? OBJ >OBJ \FALSE
?L3:	EQUAL? LVL,P-SRCBOT /?L5
	GETPT OBJ,P?SYNONYM >STACK
	ZERO? STACK /?L5
	CALL THIS-IT?,OBJ,TBL >STACK
	ZERO? STACK /?L5
	CALL OBJ-FOUND,OBJ,TBL
?L5:	FSET? OBJ,INVISIBLE /?L14
	EQUAL? LVL,P-SRCTOP \?L10
	FSET? OBJ,SEARCHBIT /?L10
	FSET? OBJ,SURFACEBIT \?L14
?L10:	FIRST? OBJ >NOBJ \?L14
	FSET? OBJ,OPENBIT /?L11
	FSET? OBJ,TRANSBIT \?L14
?L11:	EQUAL? LVL,P-SRCTOP \?L12
	FSET? OBJ,SEARCHBIT \?L12
	EQUAL? P-GETFLAGS,P-ALL /?L14
?L12:	FSET? OBJ,SURFACEBIT \?L15
	PUSH P-SRCALL
	JUMP ?L18
?L15:	FSET? OBJ,SEARCHBIT \?L17
	PUSH P-SRCALL
	JUMP ?L18
?L17:	PUSH P-SRCTOP
?L18:	CALL SEARCH-LIST,OBJ,TBL,STACK >FLS
?L14:	NEXT? OBJ >OBJ /?L3
	RTRUE

	.FUNCT OBJ-FOUND,OBJ,TBL,PTR
	GET TBL,P-MATCHLEN >PTR
	ADD PTR,1 >STACK
	PUT TBL,STACK,OBJ
	ADD PTR,1 >STACK
	PUT TBL,P-MATCHLEN,STACK
	RTRUE

	.FUNCT TAKE-CHECK
	GETB P-SYNTAX,P-SLOC1 >STACK
	CALL ITAKE-CHECK,P-PRSO,STACK >STACK
	ZERO? STACK /FALSE
	GETB P-SYNTAX,P-SLOC2 >STACK
	CALL ITAKE-CHECK,P-PRSI,STACK >STACK
	RSTACK

	.FUNCT ITAKE-CHECK,TBL,IBITS,PTR,OBJ,TAKEN
	GET TBL,P-MATCHLEN >PTR
	ZERO? PTR /TRUE
	BTST IBITS,SHAVE /?L3
	BTST IBITS,STAKE \TRUE
?L3:	DLESS? 'PTR,0 /TRUE
	ADD PTR,1 >STACK
	GET TBL,STACK >OBJ
	EQUAL? OBJ,IT \?L9
	SET 'OBJ,P-IT-OBJECT
?L9:	CALL HELD?,OBJ >STACK
	ZERO? STACK \?L3
	EQUAL? OBJ,HANDS /?L3
	SET 'PRSO,OBJ
	FSET? OBJ,TRYTAKEBIT \?L14
	SET 'TAKEN,1
	JUMP ?L18
?L14:	EQUAL? WINNER,ADVENTURER /?L16
	SET 'TAKEN,0
	JUMP ?L18
?L16:	BTST IBITS,STAKE \?L17
	CALL ITAKE,0 >STACK
	EQUAL? STACK,1 \?L17
	SET 'TAKEN,0
	JUMP ?L18
?L17:	SET 'TAKEN,1
?L18:	ZERO? TAKEN /?L36
	BTST IBITS,SHAVE \?L19
	EQUAL? OBJ,NOT-HERE-OBJECT \?L21
	PRINTI "You don't have that!"
	CRLF
	RFALSE
?L21:	PRINTI "You don't have the "
	PRINTD OBJ
	PRINTI "."
	CRLF
	CALL THIS-IS-IT,OBJ
	RFALSE
?L19:	ZERO? TAKEN \?L3
?L36:	EQUAL? WINNER,ADVENTURER \?L3
	PRINTI "(Taking the "
	PRINTD OBJ
	PRINTI " first)"
	CRLF
	JUMP ?L3

	.FUNCT HERE?,CAN?1
?L1:	LOC CAN?1 >CAN?1
	ZERO? CAN?1 /?L2
	EQUAL? CAN?1,HERE \?L1
	RTRUE
?L2:	CALL GLOBAL-IN?,CAN?1,HERE >STACK
	ZERO? STACK \TRUE
	EQUAL? CAN?1,PSEUDO-OBJECT \FALSE
	RTRUE

	.FUNCT HELD?,CAN?1
?L1:	LOC CAN?1 >CAN?1
	ZERO? CAN?1 /FALSE
	EQUAL? CAN?1,WINNER \?L1
	RTRUE

	.FUNCT MANY-CHECK,LOSS=0,TMP
	GET P-PRSO,P-MATCHLEN >STACK
	GRTR? STACK,1 \?L1
	GETB P-SYNTAX,P-SLOC1 >STACK
	BTST STACK,SMANY /?L1
	SET 'LOSS,1
	JUMP ?L3
?L1:	GET P-PRSI,P-MATCHLEN >STACK
	GRTR? STACK,1 \?L3
	GETB P-SYNTAX,P-SLOC2 >STACK
	BTST STACK,SMANY /?L3
	SET 'LOSS,2
?L3:	ZERO? LOSS /TRUE
	PRINTI "I can't use multiple "
	EQUAL? LOSS,2 \?L9
	PRINTI "in"
?L9:	PRINTI "direct objects with """
	GET P-ITBL,P-VERBN >TMP
	ZERO? TMP \?L16
	PRINTI "tell"
	JUMP ?L22
?L16:	ZERO? P-OFLAG \?L21
	ZERO? P-MERGED /?L20
?L21:	GET TMP,0 >STACK
	PRINTB STACK
	JUMP ?L22
?L20:	GETB TMP,3 >STACK
	GETB TMP,2 >STACK
	CALL WORD-PRINT,STACK,STACK
?L22:	PRINTI "."""
	CRLF
	RFALSE

	.FUNCT ZMEMQ,ITM,TBL,SIZE=-1,CNT=1
	ZERO? TBL /FALSE
	LESS? SIZE,0 /?L4
	SET 'CNT,0
	JUMP ?L6
?L4:	GET TBL,0 >SIZE
?L6:	GET TBL,CNT >STACK
	EQUAL? ITM,STACK /TRUE
	IGRTR? 'CNT,SIZE \?L6
	RFALSE

	.FUNCT ZMEMQB,ITM,TBL,SIZE,CNT=0
?L1:	GETB TBL,CNT >STACK
	EQUAL? ITM,STACK /TRUE
	IGRTR? 'CNT,SIZE \?L1
	RFALSE

	.FUNCT LIT?,RM,OHERE,LIT?1=0
	SET 'P-GWIMBIT,ONBIT
	SET 'OHERE,HERE
	SET 'HERE,RM
	FSET? RM,ONBIT \?L1
	SET 'LIT?1,1
	JUMP ?L7
?L1:	PUT P-MERGE,P-MATCHLEN,0
	SET 'P-TABLE,P-MERGE
	SET 'P-SLOCBITS,-1
	EQUAL? OHERE,RM \?L4
	CALL DO-SL,WINNER,1,1
?L4:	CALL DO-SL,RM,1,1
	GET P-TABLE,P-MATCHLEN >STACK
	GRTR? STACK,0 \?L7
	SET 'LIT?1,1
?L7:	SET 'HERE,OHERE
	SET 'P-GWIMBIT,0
	RETURN LIT?1

	.FUNCT PRSO-PRINT,PTR
	ZERO? P-MERGED \?L3
	GET P-ITBL,P-NC1 >PTR
	GET PTR,0 >STACK
	EQUAL? STACK,W?IT \?L1
?L3:	PRINTI " "
	PRINTD PRSO
	RTRUE
?L1:	GET P-ITBL,P-NC1L >STACK
	CALL BUFFER-PRINT,PTR,STACK,0 >STACK
	RSTACK

	.FUNCT THIS-IT?,OBJ,TBL,SYNS
	FSET? OBJ,INVISIBLE /FALSE
	ZERO? P-NAM /?L3
	GETPT OBJ,P?SYNONYM >SYNS
	PTSIZE SYNS >STACK
	DIV STACK,2 >STACK
	DEC 'STACK
	CALL ZMEMQ,P-NAM,SYNS,STACK >STACK
	ZERO? STACK /FALSE
?L3:	ZERO? P-ADJ /?L4
	GETPT OBJ,P?ADJECTIVE >SYNS
	ZERO? SYNS /FALSE
	PTSIZE SYNS >STACK
	DEC 'STACK
	CALL ZMEMQB,P-ADJ,SYNS,STACK >STACK
	ZERO? STACK /FALSE
?L4:	ZERO? P-GWIMBIT /TRUE
	FSET? OBJ,P-GWIMBIT /TRUE
	RFALSE

	.FUNCT V-VERBOSE
	SET 'VERBOSE,1
	SET 'SUPER-BRIEF,0
	PRINTI "Maximum verbosity."
	CRLF
	CRLF
	CALL V-LOOK >STACK
	RSTACK

	.FUNCT V-BRIEF
	SET 'VERBOSE,0
	SET 'SUPER-BRIEF,0
	PRINTR "Brief descriptions."

	.FUNCT V-SUPER-BRIEF
	SET 'SUPER-BRIEF,1
	PRINTR "Super-brief descriptions."

	.FUNCT V-LOOK
	SET 'C-ELAPSED,9
	CALL DESCRIBE-ROOM,1 >STACK
	ZERO? STACK /FALSE
	CALL DESCRIBE-OBJECTS,1 >STACK
	RSTACK

	.FUNCT V-LOOK-CRETIN
	PRINTR "This isn't a primitive two-word-parser adventure game. If you want to look AT that object, please say so."

	.FUNCT V-FIRST-LOOK
	CALL DESCRIBE-ROOM >STACK
	ZERO? STACK /FALSE
	ZERO? SUPER-BRIEF \FALSE
	CALL DESCRIBE-OBJECTS >STACK
	RSTACK

	.FUNCT PRE-EXAMINE
	CALL HERE?,PRSO >STACK
	ZERO? STACK \FALSE
	IN? PRSO,GLOBAL-OBJECTS /FALSE
	EQUAL? PRSO,PSEUDO-OBJECT /FALSE
	IN? PRSO,LOCAL-GLOBALS \?L3
	CALL GLOBAL-IN?,PRSO,HERE >STACK
	ZERO? STACK \FALSE
?L3:	EQUAL? PRSO,GRUE /FALSE
	PRINTI "You can't see any"
	CALL PRSO-PRINT
	PRINTR " here!"

	.FUNCT V-EXAMINE
	SET 'C-ELAPSED,32
	GETP PRSO,P?TEXT >STACK
	ZERO? STACK /?L1
	GETP PRSO,P?TEXT >STACK
	PRINT STACK
	CRLF
	RTRUE
?L1:	FSET? PRSO,DOORBIT \?L5
	CALL V-LOOK-INSIDE >STACK
	RSTACK
?L5:	FSET? PRSO,CONTBIT \?L6
	FSET? PRSO,OPENBIT \?L7
	CALL V-LOOK-INSIDE >STACK
	RSTACK
?L7:	PRINTI "The "
	PRINTD PRSO
	PRINTR " is closed."
?L6:	PRINTI "I see nothing special about the "
	PRINTD PRSO
	PRINTR "."

	.FUNCT DESCRIBE-ROOM,LOOK?=0,V?,STR,AV
	SET 'V?,LOOK?
	ZERO? V? \?L1
	SET 'V?,VERBOSE
?L1:	ZERO? LIT \?L3
	PRINTI "It is pitch black. You might be eaten by a grue."
	CRLF
	EQUAL? HERE,TRANSPORTATION-SUPPLY \FALSE
	PRINTI "There is light to the south."
	CRLF
	RFALSE
?L3:	FSET? HERE,TOUCHBIT /?L13
	FSET HERE,TOUCHBIT
	SET 'V?,1
?L13:	IN? HERE,ROOMS \?L16
	PRINTD HERE
	LOC WINNER >STACK
	FSET? STACK,VEHBIT \?L20
	PRINTI ", in the "
	LOC WINNER >STACK
	PRINTD STACK
?L20:	CRLF
?L16:	ZERO? LOOK? \?L28
	ZERO? SUPER-BRIEF \TRUE
?L28:	LOC WINNER >AV
	ZERO? V? /?L31
	GETP HERE,P?ACTION >STACK
	CALL STACK,M-LOOK >STACK
	ZERO? STACK \TRUE
	ZERO? V? /?L31
	GETP HERE,P?LDESC >STR
	ZERO? STR /?L31
	PRINT STR
	CRLF
	JUMP ?L34
?L31:	GETP HERE,P?ACTION >STACK
	CALL STACK,M-FLASH >STACK
?L34:	EQUAL? HERE,AV /TRUE
	FSET? AV,VEHBIT \TRUE
	GETP AV,P?ACTION >STACK
	CALL STACK,M-LOOK >STACK
	RTRUE

	.FUNCT DESCRIBE-OBJECTS,V?=0
	ZERO? LIT /?L1
	FIRST? HERE >STACK \FALSE
	ZERO? V? \?L5
	SET 'V?,VERBOSE
?L5:	CALL PRINT-CONT,HERE,V?,-1 >STACK
	RSTACK
?L1:	PRINTR "You can't see anything in the dark."

	.FUNCT DESCRIBE-OBJECT,OBJ,V?,LEVEL,STR=0,AV
	ZERO? LEVEL \?L1
	GETP OBJ,P?DESCFCN >STACK
	CALL STACK,M-OBJDESC >STACK
	ZERO? STACK \TRUE
?L1:	EQUAL? OBJ,SPOUT-PLACED /TRUE
	ZERO? LEVEL \?L9
	FSET? OBJ,TOUCHBIT /?L6
	GETP OBJ,P?FDESC >STR
	ZERO? STR \?L5
?L6:	GETP OBJ,P?LDESC >STR
	ZERO? STR /?L4
?L5:	PRINT STR
	JUMP ?L33
?L4:	ZERO? LEVEL \?L9
	PRINTI "There is "
	FSET? OBJ,VOWELBIT \?L12
	PRINTI "an "
	JUMP ?L16
?L12:	PRINTI "a "
?L16:	PRINTD OBJ
	PRINTI " here."
	JUMP ?L33
?L9:	GET INDENTS,LEVEL >STACK
	PRINT STACK
	FSET? OBJ,VOWELBIT \?L24
	PRINTI "An "
	JUMP ?L28
?L24:	PRINTI "A "
?L28:	PRINTD OBJ
	FSET? OBJ,WORNBIT \?L33
	PRINTI " (being worn)"
?L33:	ZERO? LEVEL \?L38
	LOC WINNER >AV
	ZERO? AV /?L38
	FSET? AV,VEHBIT \?L38
	PRINTI " (outside the "
	PRINTD AV
	PRINTI ")"
?L38:	CRLF
	CALL SEE-INSIDE?,OBJ >STACK
	ZERO? STACK /FALSE
	FIRST? OBJ >STACK \FALSE
	CALL PRINT-CONT,OBJ,V?,LEVEL >STACK
	RSTACK

	.FUNCT PRINT-CONT,OBJ,V?=0,LEVEL=0,Y,1ST?,AV,STR,PV?=0,INV?=0
	FIRST? OBJ >Y \TRUE
	LOC WINNER >AV
	ZERO? AV /?L4
	FSET? AV,VEHBIT /?L6
?L4:	SET 'AV,0
?L6:	SET '1ST?,1
	LOC OBJ >STACK
	EQUAL? WINNER,OBJ,STACK \?L7
	SET 'INV?,1
	JUMP ?L11
?L7:	ZERO? Y \?L12
?L58:	ZERO? 1ST? \?L14
	PUSH 1
	JUMP ?L11
?L14:	PUSH 0
	JUMP ?L11
?L12:	EQUAL? Y,AV \?L16
	SET 'PV?,1
	JUMP ?L24
?L16:	EQUAL? Y,WINNER /?L24
	FSET? Y,INVISIBLE /?L24
	FSET? Y,TOUCHBIT /?L24
	GETP Y,P?FDESC >STR
	ZERO? STR /?L24
	FSET? Y,NDESCBIT /?L19
	PRINT STR
	CRLF
?L19:	CALL SEE-INSIDE?,Y >STACK
	ZERO? STACK /?L24
	LOC Y >STACK
	GETP STACK,P?DESCFCN >STACK
	ZERO? STACK \?L24
	FIRST? Y >STACK \?L24
	CALL PRINT-CONT,Y,V?,0
?L24:	NEXT? Y >Y /?L12
	JUMP ?L58
?L11:	FIRST? OBJ >Y /?L32
?L57:	ZERO? PV? /?L34
	ZERO? AV /?L34
	FIRST? AV >STACK \?L34
	CALL PRINT-CONT,AV,V?,LEVEL
?L34:	ZERO? 1ST? \FALSE
	RTRUE
?L32:	EQUAL? Y,AV,ADVENTURER /?L53
	FSET? Y,INVISIBLE /?L53
	ZERO? INV? \?L41
	FSET? Y,TOUCHBIT /?L41
	GETP Y,P?FDESC >STACK
	ZERO? STACK \?L53
?L41:	FSET? Y,NDESCBIT /?L42
	ZERO? 1ST? /?L44
	CALL FIRSTER,OBJ,LEVEL >STACK
	ZERO? STACK /?L48
	LESS? LEVEL,0 \?L48
	SET 'LEVEL,0
?L48:	INC 'LEVEL
	SET '1ST?,0
?L44:	CALL DESCRIBE-OBJECT,Y,V?,LEVEL
	JUMP ?L53
?L42:	FIRST? Y >STACK \?L53
	CALL SEE-INSIDE?,Y >STACK
	ZERO? STACK /?L53
	CALL PRINT-CONT,Y,V?,LEVEL
?L53:	NEXT? Y >Y /?L32
	JUMP ?L57

	.FUNCT FIRSTER,OBJ,LEVEL
	EQUAL? OBJ,WINNER \?L1
	PRINTR "You are carrying:"
?L1:	IN? OBJ,ROOMS /FALSE
	GRTR? LEVEL,0 \?L6
	GET INDENTS,LEVEL >STACK
	PRINT STACK
?L6:	FSET? OBJ,SURFACEBIT \?L11
	PRINTI "Sitting on the "
	PRINTD OBJ
	PRINTR " is:"
?L11:	FSET? OBJ,ACTORBIT \?L15
	PRINTI "The "
	PRINTD OBJ
	PRINTR " is holding:"
?L15:	PRINTI "The "
	PRINTD OBJ
	PRINTR " contains:"

	.FUNCT SCORE-OBJ,OBJ
	GETP OBJ,P?VALUE >STACK
	GRTR? STACK,0 \FALSE
	FSET OBJ,TOUCHBIT
	GETP OBJ,P?VALUE >STACK
	ADD SCORE,STACK >SCORE
	PUTP OBJ,P?VALUE,0
	RTRUE

	.FUNCT V-SCORE,ASK?=1
	PRINTI "Your score "
	ZERO? ASK? /?L3
	PRINTI "would be "
	JUMP ?L7
?L3:	PRINTI "is "
?L7:	PRINTN SCORE
	PRINTI " (out of 80 points). It is Day "
	PRINTN DAY
	PRINTI " of your adventure. Current Galactic Standard Time "
	IN? CHRONOMETER,ADVENTURER \?L18
	PRINTI "(adjusted to your local day-cycle) is "
	FSET? CHRONOMETER,MUNGEDBIT \?L22
	PRINTN MUNGED-TIME
	JUMP ?L29
?L22:	PRINTN INTERNAL-MOVES
	JUMP ?L29
?L18:	PRINTI "is impossible to determine, since you're not wearing your chronometer"
?L29:	PRINTI "."
	CRLF
	PRINTI "This score gives you the rank of "
	EQUAL? SCORE,80 \?L36
	PRINTI "Galactic Overlord"
	JUMP ?L58
?L36:	GRTR? SCORE,72 \?L40
	PRINTI "Cluster Admiral"
	JUMP ?L58
?L40:	GRTR? SCORE,64 \?L43
	PRINTI "System Captain"
	JUMP ?L58
?L43:	GRTR? SCORE,48 \?L46
	PRINTI "Planetary Commodore"
	JUMP ?L58
?L46:	GRTR? SCORE,36 \?L49
	PRINTI "Lieutenant"
	JUMP ?L58
?L49:	GRTR? SCORE,24 \?L52
	PRINTI "Ensign First Class"
	JUMP ?L58
?L52:	GRTR? SCORE,12 \?L55
	PRINTI "Space Cadet"
	JUMP ?L58
?L55:	PRINTI "Beginner"
?L58:	PRINTI "."
	CRLF
	RETURN SCORE

	.FUNCT FINISH,DIED,REPEATING=0
	CRLF
	ZERO? REPEATING \?L3
	CALL V-SCORE
	ZERO? DIED /?L3
	CRLF
	PRINTI "Oh, well. According to the Treaty of Gishen IV, signed in 8747 GY, all adventure game players must be given another chance after dying. In the interests of interstellar peace..."
	CRLF
?L3:	PUTB P-INBUF,0,10
	CRLF
	PRINTI "Would you like to restart the game from the beginning, restore a saved game position, or end this session of the game? (Type RESTART, RESTORE, or QUIT.)"
	CRLF
	CRLF
	PRINTI ">"
	READ P-INBUF,P-LEXV
	PUTB P-INBUF,0,80
	GET P-LEXV,1 >STACK
	EQUAL? STACK,W?RESTAR \?L11
	RESTART
?L11:	GET P-LEXV,1 >STACK
	EQUAL? STACK,W?RESTOR \?L15
	RESTORE \?L16
	PRINTR "Ok."
?L16:	PRINTI "Failed."
	CRLF
	CALL FINISH,0,1 >STACK
	RSTACK
?L15:	GET P-LEXV,1 >STACK
	EQUAL? STACK,W?QUIT,W?Q \?L23
	QUIT
?L23:	CALL FINISH,0,1 >STACK
	RSTACK

	.FUNCT V-QUIT
	CALL V-SCORE
	IN? FLOYD,HERE \?L1
	FSET? FLOYD,RLANDBIT \?L1
	SET 'FLOYD-SPOKE,1
	CRLF
	PRINTI "Floyd grins impishly. ""Giving up, huh?"""
	CRLF
?L1:	CRLF
	PRINTI "Do you wish to leave the game? (Y is affirmative): "
	CALL YES? >STACK
	ZERO? STACK /?L8
	QUIT
?L8:	PRINTR "Ok."

	.FUNCT YES?
	PUTB P-INBUF,0,10
	PRINTI ">"
	READ P-INBUF,P-LEXV
	PUTB P-INBUF,0,80
	GET P-LEXV,1 >STACK
	EQUAL? STACK,W?YES,W?Y \FALSE
	RTRUE

	.FUNCT V-VERSION,CNT=17
	PRINTI "PLANETFALL
Infocom interactive fiction - a science fiction story
Copyright (c) 1983 by Infocom, Inc. All rights reserved.
"
	PRINTI "PLANETFALL is a trademark of Infocom, Inc.
Release "
	GET 0,1 >STACK
	BAND STACK,2047 >STACK
	PRINTN STACK
	PRINTI " / Serial number "
?L7:	IGRTR? 'CNT,23 /?L8
	GETB 0,CNT >STACK
	PRINTC STACK
	JUMP ?L7
?L8:	CRLF
	IN? FLOYD,HERE \FALSE
	FSET? FLOYD,RLANDBIT \FALSE
	SET 'FLOYD-SPOKE,1
	CRLF
	PRINTR """Last version was better,"" says Floyd. ""More bugs. Bugs make game fun."""

	.FUNCT V-AGAIN,OBJ
	ZERO? L-PRSA \?L1
	CALL ANYMORE >STACK
	RSTACK
?L1:	EQUAL? HERE,LAST-PSEUDO-LOC /?L3
	EQUAL? PSEUDO-OBJECT,L-PRSO,L-PRSI \?L3
	SET 'L-PRSA,0
	CALL ANYMORE >STACK
	RSTACK
?L3:	EQUAL? L-PRSA,V?WALK \?L4
	CALL DO-WALK,L-PRSO >STACK
	RSTACK
?L4:	ZERO? L-PRSO /?L6
	LOC L-PRSO >STACK
	ZERO? STACK \?L6
	SET 'OBJ,L-PRSO
	JUMP ?L7
?L6:	ZERO? L-PRSI /?L8
	LOC L-PRSI >STACK
	ZERO? STACK \?L8
	SET 'OBJ,L-PRSI
	JUMP ?L7
?L8:	SET 'OBJ,0
?L7:	EQUAL? OBJ,0,PSEUDO-OBJECT,ROOMS /?L10
	CALL ANYMORE
	RETURN 2
?L10:	CALL PERFORM,L-PRSA,L-PRSO,L-PRSI
	RTRUE

	.FUNCT JIGS-UP,DESC,PLAYER?=0
	PRINT DESC
	CRLF
	CRLF
	PRINTI "    ****  You have died  ****"
	CRLF
	CALL FINISH,1 >STACK
	RSTACK

	.FUNCT V-RESTORE
	IN? FLOYD,HERE \?L1
	FSET? FLOYD,RLANDBIT \?L1
	SET 'FLOYD-SPOKE,1
	PRINTI "Floyd looks disappointed, but understanding. ""That part of the game was more fun than this part,"" he admits."
	CRLF
	CRLF
?L1:	RESTORE \?L6
	PRINTR "Ok."
?L6:	PRINTR "Failed."

	.FUNCT V-SAVE
	IN? FLOYD,HERE \?L1
	FSET? FLOYD,RLANDBIT \?L1
	SET 'FLOYD-SPOKE,1
	PRINTI "Floyd's eyes light up. ""Oh boy! Are we gonna try something dangerous now?"""
	CRLF
	CRLF
?L1:	SAVE \?L6
	PRINTR "Ok."
?L6:	PRINTR "Failed."

	.FUNCT V-RESTART
	CALL V-SCORE,1
	IN? FLOYD,HERE \?L1
	FSET? FLOYD,RLANDBIT \?L1
	SET 'FLOYD-SPOKE,1
	PRINTI "Floyd looks sad. ""Going away?"" he asks."
	CRLF
?L1:	CRLF
	PRINTI "Do you wish to restart? (Y is affirmative): "
	CALL YES? >STACK
	ZERO? STACK /FALSE
	PRINTI "Restarting."
	CRLF
	RESTART

	.FUNCT V-WALK-AROUND
	CALL USE-DIRECTIONS >STACK
	RSTACK

	.FUNCT V-WALK-TO
	IN? PRSO,HERE /?L3
	CALL GLOBAL-IN?,PRSO,HERE >STACK
	ZERO? STACK /?L1
?L3:	PRINTR "It's here!"
?L1:	CALL USE-DIRECTIONS >STACK
	RSTACK

	.FUNCT V-WALK,PT,PTS,STR,OBJ,RM,TEMP-ELAPSED
	ZERO? P-WALK-DIR \?L1
	CALL PERFORM,V?WALK-TO,PRSO
	RTRUE
?L1:	GETPT HERE,PRSO >PT
	ZERO? PT /?L3
	SUB PRSO,P?OUT >STACK
	GETP HERE,P?C-MOVE >STACK
	GET STACK,STACK >TEMP-ELAPSED
	ZERO? TEMP-ELAPSED \?L4
	SET 'TEMP-ELAPSED,DEFAULT-MOVE
?L4:	PTSIZE PT >PTS
	EQUAL? PTS,UEXIT \?L7
	SET 'C-ELAPSED,TEMP-ELAPSED
	GETB PT,REXIT >STACK
	CALL GOTO,STACK >STACK
	RSTACK
?L7:	EQUAL? PTS,NEXIT \?L9
	GET PT,NEXITSTR >STACK
	PRINT STACK
	CRLF
	RETURN 2
?L9:	EQUAL? PTS,FEXIT \?L14
	GET PT,FEXITFCN >STACK
	CALL STACK >RM
	ZERO? RM /?L15
	CALL GOTO,RM >STACK
	RSTACK
?L15:	RETURN 2
?L14:	EQUAL? PTS,CEXIT \?L20
	GETB PT,CEXITFLAG >STACK
	VALUE STACK >STACK
	ZERO? STACK /?L21
	SET 'C-ELAPSED,TEMP-ELAPSED
	GETB PT,REXIT >STACK
	CALL GOTO,STACK >STACK
	RSTACK
?L21:	GET PT,CEXITSTR >STR
	ZERO? STR /?L23
	PRINT STR
	CRLF
	RETURN 2
?L23:	PRINTI "You can't go that way."
	CRLF
	RETURN 2
?L20:	EQUAL? PTS,DEXIT \FALSE
	GETB PT,DEXITOBJ >OBJ
	FSET? OBJ,OPENBIT \?L34
	SET 'C-ELAPSED,TEMP-ELAPSED
	GETB PT,REXIT >STACK
	CALL GOTO,STACK >STACK
	RSTACK
?L34:	GET PT,DEXITSTR >STR
	ZERO? STR /?L36
	PRINT STR
	CRLF
	RETURN 2
?L36:	PRINTI "The "
	PRINTD OBJ
	PRINTI " is closed."
	CRLF
	CALL THIS-IS-IT,OBJ
	RETURN 2
?L3:	ZERO? LIT \?L47
	RANDOM 100 >STACK
	LESS? 75,STACK /?L47
	CALL JIGS-UP,STR?78 >STACK
	RSTACK
?L47:	PRINTI "You can't go that way."
	CRLF
	RETURN 2

	.FUNCT V-INVENTORY
	SET 'C-ELAPSED,18
	FIRST? ADVENTURER >STACK \?L1
	CALL PRINT-CONT,ADVENTURER >STACK
	RSTACK
?L1:	PRINTR "You are empty-handed."

	.FUNCT PRE-TAKE
	IN? PRSO,ADVENTURER \?L1
	PRINTR "You already have it."
?L1:	EQUAL? PRSO,GOOD-BOARD \?L5
	FSET? GOOD-BOARD,NDESCBIT /FALSE
?L5:	LOC PRSO >STACK
	FSET? STACK,CONTBIT \?L6
	LOC PRSO >STACK
	FSET? STACK,OPENBIT /?L6
	PRINTR "You can't reach into a closed container."
?L6:	ZERO? PRSI /?L9
	LOC PRSO >STACK
	EQUAL? PRSI,STACK /?L10
	EQUAL? PRSO,KEY \?L12
	FSET? KEY,TOUCHBIT \FALSE
?L12:	EQUAL? PRSO,CELERY \?L14
	EQUAL? PRSI,AMBASSADOR /FALSE
?L14:	PRINTR "It's not in that!"
?L10:	SET 'PRSI,0
	RFALSE
?L9:	LOC WINNER >STACK
	EQUAL? PRSO,STACK \FALSE
	PRINTR "You are in it, asteroid-brain!"

	.FUNCT V-TAKE
	CALL ITAKE >STACK
	EQUAL? STACK,1 \FALSE
	PRINTR "Taken."

	.FUNCT TRYTAKE
	IN? PRSO,WINNER /TRUE
	FSET? PRSO,TRYTAKEBIT \?L3
	GETP PRSO,P?ACTION >STACK
	ZERO? STACK /?L3
	CALL PERFORM,V?TAKE,PRSO
	RTRUE
?L3:	CALL ITAKE >STACK
	RSTACK

	.FUNCT ITAKE,VB=1,CNT,OBJ,?TMP
	FSET? PRSO,TAKEBIT /?L1
	ZERO? VB /FALSE
	CALL PICK-ONE,YUKS >STACK
	PRINT STACK
	CRLF
	RFALSE
?L1:	LOC PRSO >STACK
	IN? STACK,WINNER /?L8
	CALL WEIGHT,PRSO >?TMP
	CALL WEIGHT,WINNER >STACK
	ADD ?TMP,STACK >STACK
	GRTR? STACK,LOAD-ALLOWED \?L8
	ZERO? VB /?L9
	PRINTI "Your load is too heavy."
	CRLF
?L9:	RETURN 2
?L8:	CALL CCOUNT,WINNER >CNT
	GRTR? CNT,FUMBLE-NUMBER \?L16
	MUL CNT,FUMBLE-PROB >?TMP
	RANDOM 100 >STACK
	LESS? ?TMP,STACK /?L16
	FIRST? WINNER >OBJ /?L17
?L17:	FSET? OBJ,WORNBIT \?L19
	NEXT? OBJ >OBJ /?L17
	JUMP ?L17
?L19:	PRINTI "Oh, no. The "
	PRINTD OBJ
	PRINTI " slips from your arms while taking the "
	PRINTD PRSO
	PRINTI " and both tumble to the ground."
	CRLF
	EQUAL? FLASK,OBJ,PRSO \?L26
	IN? CHEMICAL-FLUID,FLASK \?L26
	REMOVE CHEMICAL-FLUID
	PRINTI "Unfortunately, the chemical spills out of the flask and evaporates."
	CRLF
?L26:	EQUAL? CANTEEN,OBJ,PRSO \?L31
	IN? HIGH-PROTEIN,CANTEEN \?L31
	FSET? CANTEEN,OPENBIT \?L31
	REMOVE HIGH-PROTEIN
	PRINTI "To make matters worse, the high-protein liquid spills all over the place and then evaporates."
	CRLF
?L31:	MOVE OBJ,HERE
	MOVE PRSO,HERE
	RETURN 2
?L16:	MOVE PRSO,ADVENTURER
	FCLEAR PRSO,NDESCBIT
	CALL SCORE-OBJ,PRSO
	FSET PRSO,TOUCHBIT
	EQUAL? PRSO,SPOUT-PLACED \TRUE
	SET 'SPOUT-PLACED,GROUND
	RTRUE

	.FUNCT PRE-PUT
	ZERO? PRSO /FALSE
	FSET? PRSO,WORNBIT \?L4
	PRINTR "You can't while you're wearing it."
?L4:	IN? PRSO,GLOBAL-OBJECTS /?L9
	FSET? PRSO,TAKEBIT /FALSE
?L9:	PRINTR "Nice try."

	.FUNCT V-PUT,?TMP
	FSET? PRSI,OPENBIT /?L7
	FSET? PRSI,DOORBIT /?L4
	FSET? PRSI,CONTBIT /?L4
	FSET? PRSI,VEHBIT /?L4
	PRINTR "You can't do that."
?L4:	FSET? PRSI,OPENBIT /?L7
	PRINTI "The "
	PRINTD PRSI
	PRINTR " isn't open."
?L7:	EQUAL? PRSI,PRSO \?L11
	PRINTR "How can you do that?"
?L11:	IN? PRSO,PRSI \?L14
	PRINTI "The "
	PRINTD PRSO
	PRINTI " is already in the "
	PRINTD PRSI
	PRINTR "."
?L14:	IN? PRSI,PRSO \?L17
	PRINTI "How can you put the "
	PRINTD PRSO
	PRINTI " in the "
	PRINTD PRSI
	PRINTI " when the "
	PRINTD PRSI
	PRINTI " is already in the "
	PRINTD PRSO
	PRINTR "?"
?L17:	CALL WEIGHT,PRSI >?TMP
	CALL WEIGHT,PRSO >STACK
	ADD ?TMP,STACK >?TMP
	GETP PRSI,P?SIZE >STACK
	SUB ?TMP,STACK >?TMP
	GETP PRSI,P?CAPACITY >STACK
	GRTR? ?TMP,STACK \?L20
	PRINTR "There's no room."
?L20:	CALL HELD?,PRSO >STACK
	ZERO? STACK \?L23
	CALL TRYTAKE >STACK
	ZERO? STACK /TRUE
?L23:	CALL SCORE-OBJ,PRSO
	MOVE PRSO,PRSI
	FSET PRSO,TOUCHBIT
	PRINTR "Done."

	.FUNCT V-SLIDE
	CALL PICK-ONE,YUKS >STACK
	PRINT STACK
	CRLF
	RTRUE

	.FUNCT PRE-GIVE
	CALL HELD?,PRSO >STACK
	ZERO? STACK \FALSE
	CALL NOT-HOLDING >STACK
	RSTACK

	.FUNCT PRE-SGIVE
	CALL PERFORM,V?GIVE,PRSI,PRSO
	RTRUE

	.FUNCT V-GIVE
	FSET? PRSI,ACTORBIT /?L1
	PRINTI "You can't give "
	CALL A-AN
	PRINTD PRSO
	PRINTI " to "
	FSET? PRSI,VOWELBIT \?L7
	PRINTI "an "
	JUMP ?L11
?L7:	PRINTI "a "
?L11:	PRINTD PRSI
	PRINTR "!"
?L1:	PRINTI "The "
	PRINTD PRSI
	PRINTR " declines your offer."

	.FUNCT V-SGIVE
	PRINTR "Foo!"

	.FUNCT V-DROP
	CALL IDROP >STACK
	ZERO? STACK /FALSE
	PRINTR "Dropped."

	.FUNCT V-THROW
	CALL IDROP >STACK
	ZERO? STACK /FALSE
	PRINTR "Thrown."

	.FUNCT IDROP
	CALL HELD?,PRSO >STACK
	ZERO? STACK \?L1
	PRINTI "You're not carrying the "
	PRINTD PRSO
	PRINTI "."
	CRLF
	RFALSE
?L1:	FSET? PRSO,WORNBIT \?L5
	CALL TAKE-IT-OFF
	RFALSE
?L5:	IN? PRSO,WINNER /?L6
	LOC PRSO >STACK
	FSET? STACK,OPENBIT /?L6
	PRINTI "The "
	PRINTD PRSO
	PRINTI " is closed."
	CRLF
	RFALSE
?L6:	MOVE PRSO,HERE
	RTRUE

	.FUNCT V-OPEN,F,STR
	FSET? PRSO,CONTBIT /?L1
	FSET? PRSO,DOORBIT /?L6
	PRINTI "You must be very clever to do that to the "
	PRINTD PRSO
	PRINTR "."
?L1:	FSET? PRSO,DOORBIT /?L6
	GETP PRSO,P?CAPACITY >STACK
	ZERO? STACK /?L5
?L6:	FSET? PRSO,OPENBIT \?L7
	CALL ALREADY,STR?79 >STACK
	RSTACK
?L7:	FSET PRSO,OPENBIT
	FSET? PRSO,DOORBIT \?L10
	PRINTI "The "
	PRINTD PRSO
	PRINTR " is now open."
?L10:	FIRST? PRSO >STACK \?L15
	FSET? PRSO,TRANSBIT \?L14
?L15:	PRINTR "Opened."
?L14:	FIRST? PRSO >F \?L18
	NEXT? F >STACK /?L18
	GETP F,P?FDESC >STR
	ZERO? STR /?L18
	PRINTI "The "
	PRINTD PRSO
	PRINTI " opens."
	CRLF
	PRINT STR
	CRLF
	RTRUE
?L18:	PRINTI "Opening the "
	PRINTD PRSO
	PRINTI " reveals "
	CALL PRINT-CONTENTS,PRSO
	PRINTR "."
?L5:	PRINTI "The "
	PRINTD PRSO
	PRINTR " cannot be opened."

	.FUNCT V-OPEN-WITH
	EQUAL? PRSI,HANDS \?L1
	CALL PERFORM,V?OPEN,PRSO
	RTRUE
?L1:	PRINTR "That doesn't work."

	.FUNCT PRINT-CONTENTS,OBJ,F,N,1ST?=1,IT?=0,TWO?=0
	FIRST? OBJ >F \FALSE
?L3:	NEXT? F >N /?L5
?L5:	ZERO? 1ST? /?L6
	SET '1ST?,0
	JUMP ?L11
?L6:	PRINTI ", "
	ZERO? N \?L11
	PRINTI "and "
?L11:	PRINTI "a "
	PRINTD F
	ZERO? IT? \?L18
	ZERO? TWO? \?L18
	SET 'IT?,F
	JUMP ?L20
?L18:	SET 'TWO?,1
	SET 'IT?,0
?L20:	SET 'F,N
	ZERO? F \?L3
	ZERO? IT? /TRUE
	ZERO? TWO? \TRUE
	CALL THIS-IS-IT,IT?
	RTRUE

	.FUNCT V-CLOSE
	FSET? PRSO,CONTBIT /?L1
	FSET? PRSO,DOORBIT /?L1
	PRINTI "You can't do that to "
	CALL A-AN
	PRINTD PRSO
	PRINTR "."
?L1:	FSET? PRSO,SURFACEBIT /?L7
	GETP PRSO,P?CAPACITY >STACK
	ZERO? STACK \?L8
	FSET? PRSO,DOORBIT \?L7
?L8:	FSET? PRSO,OPENBIT \?L9
	FCLEAR PRSO,OPENBIT
	PRINTR "Closed."
?L9:	CALL ALREADY,STR?80 >STACK
	RSTACK
?L7:	PRINTR "You cannot close that."

	.FUNCT CCOUNT,OBJ,CNT=0,X
	FIRST? OBJ >X \?L4
?L3:	INC 'CNT
	NEXT? X >X /?L3
?L4:	RETURN CNT

	.FUNCT WEIGHT,OBJ,CONT,WT=0
	FIRST? OBJ >CONT \?L4
?L3:	FSET? CONT,WORNBIT /?L5
	CALL WEIGHT,CONT >STACK
	ADD WT,STACK >WT
?L5:	NEXT? CONT >CONT /?L3
?L4:	GETP OBJ,P?SIZE >STACK
	ADD WT,STACK >STACK
	RSTACK

	.FUNCT V-SCRIPT
	IN? FLOYD,HERE \?L1
	FSET? FLOYD,RLANDBIT \?L1
	SET 'FLOYD-SPOKE,1
	PRINTI "Floyd hops around excitedly. ""Oh boy! I've never seen my name in print before!"""
	CRLF
	CRLF
?L1:	GET 0,8 >STACK
	BOR STACK,1 >STACK
	PUT 0,8,STACK
	PRINTI "Here begins"
	PRINT COPR-NOTICE
	CRLF
	RTRUE

	.FUNCT V-UNSCRIPT
	IN? FLOYD,HERE \?L1
	FSET? FLOYD,RLANDBIT \?L1
	SET 'FLOYD-SPOKE,1
	PRINTI """Can I have a copy of the printout?"" asks Floyd, looking up at you."
	CRLF
	CRLF
?L1:	PRINTI "Here ends"
	PRINT COPR-NOTICE
	CRLF
	GET 0,8 >STACK
	BAND STACK,-2 >STACK
	PUT 0,8,STACK
	RTRUE

	.FUNCT PRE-MOVE
	CALL HELD?,PRSO >STACK
	ZERO? STACK /FALSE
	PRINTR "Why juggle objects?"

	.FUNCT V-MOVE
	FSET? PRSO,TAKEBIT \?L1
	PRINTI "Moving the "
	PRINTD PRSO
	PRINTR " reveals nothing."
?L1:	PRINTI "You can't move the "
	PRINTD PRSO
	PRINTR "."

	.FUNCT V-LAMP-ON
	FSET? PRSO,LIGHTBIT \?L1
	FSET? PRSO,ONBIT \?L3
	CALL ALREADY,STR?81
	RTRUE
?L3:	FSET PRSO,ONBIT
	PRINTI "The "
	PRINTD PRSO
	PRINTR " is now on."
?L1:	PRINTR "You can't turn that on."

	.FUNCT V-LAMP-OFF
	FSET? PRSO,LIGHTBIT \?L1
	FSET? PRSO,ONBIT /?L3
	CALL ALREADY,STR?82
	RTRUE
?L3:	FCLEAR PRSO,ONBIT
	PRINTI "The "
	PRINTD PRSO
	PRINTR " is now off."
?L1:	PRINTR "You can't turn that off."

	.FUNCT V-WAIT
	SET 'C-ELAPSED,40
	PRINTR "Time passes..."

	.FUNCT PRE-BOARD,AV
	LOC WINNER >AV
	EQUAL? PRSO,GROUND,GLOBAL-SHUTTLE /FALSE
	FSET? PRSO,VEHBIT \?L3
	FSET? AV,VEHBIT \FALSE
	PRINTI "You are already in it!"
	CRLF
	RETURN 2
?L3:	PRINTI "I suppose you have a theory on boarding "
	CALL A-AN
	PRINTD PRSO
	PRINTI "."
	CRLF
	RETURN 2

	.FUNCT V-BOARD,AV
	PRINTI "You are now in the "
	PRINTD PRSO
	PRINTI "."
	CRLF
	MOVE WINNER,PRSO
	GETP PRSO,P?ACTION >STACK
	CALL STACK,M-ENTER >STACK
	RTRUE

	.FUNCT V-DISEMBARK
	EQUAL? PRSO,ROOMS \?L1
	IN? ADVENTURER,SAFETY-WEB \?L3
	CALL PERFORM,V?DISEMBARK,SAFETY-WEB
	RTRUE
?L3:	IN? ADVENTURER,BED \?L5
	CALL OWN-FEET >STACK
	RSTACK
?L5:	IN? ADVENTURER,SHUTTLE-CAR-ALFIE \?L6
	CALL DO-WALK,P?NORTH >STACK
	RSTACK
?L6:	IN? ADVENTURER,SHUTTLE-CAR-BETTY \?L7
	CALL DO-WALK,P?SOUTH >STACK
	RSTACK
?L7:	IN? ADVENTURER,BRIG \?L8
	CALL PERFORM,V?ZESCAPE
	RTRUE
?L8:	CALL DO-WALK,P?OUT >STACK
	RSTACK
?L1:	LOC WINNER >STACK
	EQUAL? STACK,PRSO /?L10
	PRINTI "You're not in that!"
	CRLF
	RETURN 2
?L10:	CALL OWN-FEET >STACK
	RSTACK

	.FUNCT OWN-FEET
	MOVE WINNER,HERE
	PRINTR "You're on your own feet again."

	.FUNCT V-STAND
	LOC WINNER >STACK
	FSET? STACK,VEHBIT \?L1
	LOC WINNER >STACK
	CALL PERFORM,V?DISEMBARK,STACK
	RTRUE
?L1:	PRINTR "You are already standing, I think."

	.FUNCT GOTO,RM,V?=1,WLOC,OLIT
	LOC WINNER >WLOC
	SET 'OLIT,LIT
	MOVE ADVENTURER,RM
	SET 'HERE,RM
	CALL LIT?,HERE >LIT
	ZERO? OLIT \?L1
	ZERO? LIT \?L1
	RANDOM 100 >STACK
	LESS? 75,STACK /?L1
	CALL JIGS-UP,STR?83
	RTRUE
?L1:	GETP HERE,P?ACTION >STACK
	CALL STACK,M-ENTER >STACK
	EQUAL? STACK,2 /TRUE
	ZERO? V? /?L7
	CALL V-FIRST-LOOK
?L7:	CALL SCORE-OBJ,RM
	RTRUE

	.FUNCT V-EAT
	PRINTI "I don't think that the "
	PRINTD PRSO
	PRINTR " would agree with you."

	.FUNCT V-EAT-FROM,X
	FIRST? PRSO >X /?L1
?L1:	FSET? PRSO,OPENBIT /?L2
	PRINTR "It's closed."
?L2:	NEXT? X >STACK \?L6
	PRINTI "There's more than one thing in the "
	PRINTD PRSO
	PRINTR "."
?L6:	ZERO? X /?L9
	CALL PERFORM,V?EAT,X
	RTRUE
?L9:	PRINTR "It's empty!"

	.FUNCT V-CURSE
	PRINTR "Such language from an Ensign in the Stellar Patrol!"

	.FUNCT V-LISTEN
	SET 'C-ELAPSED,18
	PRINTI "The "
	PRINTD PRSO
	PRINTR " makes no sound."

	.FUNCT V-FOLLOW
	PRINTI "The "
	PRINTD PRSO
	PRINTR " is right here!"

	.FUNCT V-LEAP
	ZERO? PRSO /?L1
	IN? PRSO,HERE \?L3
	FSET? PRSO,ACTORBIT \?L5
	PRINTI "The "
	PRINTD PRSO
	PRINTR " is too big to jump over."
?L5:	CALL V-SKIP >STACK
	RSTACK
?L3:	PRINTR "That would be a good trick."
?L1:	CALL V-SKIP >STACK
	RSTACK

	.FUNCT V-SKIP
	CALL PICK-ONE,WHEEEEE >STACK
	PRINT STACK
	CRLF
	RTRUE

	.FUNCT V-LEAVE
	IN? ADVENTURER,BED \?L1
	CALL PERFORM,V?DISEMBARK,BED
	RTRUE
?L1:	IN? ADVENTURER,SAFETY-WEB \?L3
	CALL PERFORM,V?DISEMBARK,SAFETY-WEB
	RTRUE
?L3:	CALL DO-WALK,P?OUT >STACK
	RSTACK

	.FUNCT V-HELLO
	ZERO? PRSO /?L1
	PRINTI "Until now, I've only heard demented Denebian Devils say ""Hello"" to "
	CALL A-AN
	PRINTD PRSO
	PRINTR "."
?L1:	CALL PICK-ONE,HELLOS >STACK
	PRINT STACK
	CRLF
	RTRUE

	.FUNCT V-HELP
	PRINTR "If you're really stuck, you can order a complete map and InvisiClues Hint Booklet using the order form in your game package."

	.FUNCT PRE-READ
	ZERO? LIT \FALSE
	PRINTR "It is impossible to read in the dark."

	.FUNCT V-READ
	FSET? PRSO,READBIT /?L1
	PRINTI "How can I read "
	CALL A-AN
	PRINTD PRSO
	PRINTR "?"
?L1:	GETP PRSO,P?TEXT >STACK
	PRINT STACK
	CRLF
	SET 'C-ELAPSED,18
	RETURN C-ELAPSED

	.FUNCT V-LOOK-UNDER
	PRINTI "There is nothing but "
	EQUAL? PRSO,AMBASSADOR \?L3
	PRINTI "slime"
	JUMP ?L7
?L3:	PRINTI "dust"
?L7:	PRINTR " there."

	.FUNCT V-LOOK-BEHIND
	CALL V-LOOK-UNDER >STACK
	RSTACK

	.FUNCT V-LOOK-INSIDE
	FSET? PRSO,ACTORBIT \?L1
	PRINTR "There is nothing special to be seen."
?L1:	FSET? PRSO,DOORBIT \?L5
	FSET? PRSO,OPENBIT \?L6
	PRINTI "The "
	PRINTD PRSO
	PRINTI " is open, but I can't tell what's beyond it"
	JUMP ?L10
?L6:	PRINTI "The "
	PRINTD PRSO
	PRINTI " is closed"
?L10:	PRINTR "."
?L5:	FSET? PRSO,CONTBIT \?L15
	FSET? PRSO,OPENBIT /?L16
	CALL PERFORM,V?OPEN,PRSO
	RTRUE
?L16:	CALL SEE-INSIDE?,PRSO >STACK
	ZERO? STACK /?L18
	FIRST? PRSO >STACK \?L19
	CALL PRINT-CONT,PRSO >STACK
	ZERO? STACK \TRUE
?L19:	FSET? PRSO,SURFACEBIT \?L21
	PRINTI "There is nothing on the "
	PRINTD PRSO
	PRINTR "."
?L21:	PRINTI "The "
	PRINTD PRSO
	PRINTR " is empty."
?L18:	PRINTI "The "
	PRINTD PRSO
	PRINTR " is closed."
?L15:	FSET? PRSO,TRANSBIT \?L30
	PRINTI "You can see dimly through the "
	PRINTD PRSO
	PRINTR "."
?L30:	PRINTI "You can't look inside "
	CALL A-AN
	PRINTD PRSO
	PRINTR "."

	.FUNCT SEE-INSIDE?,OBJ
	FSET? OBJ,INVISIBLE /FALSE
	FSET? OBJ,TRANSBIT /TRUE
	FSET? OBJ,OPENBIT /TRUE
	RFALSE

	.FUNCT V-LOOK-DOWN
	CALL PERFORM,V?EXAMINE,GROUND
	RTRUE

	.FUNCT V-TURN
	PRINTR "You can't do that."

	.FUNCT V-LOCK
	CALL V-TURN >STACK
	RSTACK

	.FUNCT V-UNLOCK
	CALL V-TURN >STACK
	RSTACK

	.FUNCT V-ATTACK
	FSET? PRSO,ACTORBIT \?L1
	PRINTI "The "
	PRINTD PRSO
	PRINTR " is frightened and backs away."
?L1:	PRINTI "I've known strange beings, but attacking "
	CALL A-AN
	PRINTD PRSO
	PRINTR "???"

	.FUNCT V-KICK
	CALL HACK-HACK,STR?84 >STACK
	RSTACK

	.FUNCT V-WAVE
	CALL HACK-HACK,STR?85 >STACK
	RSTACK

	.FUNCT V-RUB
	CALL HACK-HACK,STR?86 >STACK
	RSTACK

	.FUNCT V-PUSH
	ZERO? PRSI \?L1
	EQUAL? PRSO,INTNUM \?L1
	EQUAL? HERE,LIBRARY-LOBBY,MINI-BOOTH \?L3
	PRINTR "You probably want to use the TYPE command. Check your documentation."
?L3:	EQUAL? P-NUMBER,1 \?L7
	EQUAL? HERE,BOOTH-2,BOOTH-3 \?L8
	CALL PERFORM,V?PUSH,TELEPORTATION-BUTTON-1
	RTRUE
?L8:	EQUAL? HERE,BOOTH-1 \?L10
	CALL NO-BUTTON,BOOTH-1 >STACK
	RSTACK
?L10:	PRINTR "Push a number?!?"
?L7:	EQUAL? P-NUMBER,2 \?L14
	EQUAL? HERE,BOOTH-1,BOOTH-3 \?L15
	CALL PERFORM,V?PUSH,TELEPORTATION-BUTTON-2
	RTRUE
?L15:	EQUAL? HERE,BOOTH-2 \?L17
	CALL NO-BUTTON,BOOTH-2 >STACK
	RSTACK
?L17:	PRINTR "Push a number?!?"
?L14:	EQUAL? P-NUMBER,3 \?L21
	EQUAL? HERE,BOOTH-1,BOOTH-2 \?L22
	CALL PERFORM,V?PUSH,TELEPORTATION-BUTTON-3
	RTRUE
?L22:	EQUAL? HERE,BOOTH-3 \?L21
	CALL NO-BUTTON,BOOTH-3 >STACK
	RSTACK
?L21:	PRINTR "Push a number?!?"
?L1:	CALL HACK-HACK,STR?87 >STACK
	RSTACK

	.FUNCT NO-BUTTON,NUMBER
	PRINTI "There's no button here that's labelled with the number "
	EQUAL? NUMBER,BOOTH-1 \?L3
	PRINTI "1"
	JUMP ?L10
?L3:	EQUAL? NUMBER,BOOTH-2 \?L7
	PRINTI "2"
	JUMP ?L10
?L7:	EQUAL? NUMBER,BOOTH-3 \?L10
	PRINTI "3"
?L10:	PRINTR "."

	.FUNCT V-PUSH-UP
	CALL HACK-HACK,STR?88 >STACK
	RSTACK

	.FUNCT V-PUSH-DOWN
	CALL HACK-HACK,STR?89 >STACK
	RSTACK

	.FUNCT V-PULL
	CALL HACK-HACK,STR?90 >STACK
	RSTACK

	.FUNCT V-MUNG
	CALL HACK-HACK,STR?91 >STACK
	RSTACK

	.FUNCT HACK-HACK,STR
	PRINT STR
	PRINTD PRSO
	CALL PICK-ONE,HO-HUM >STACK
	PRINT STACK
	CRLF
	RTRUE

	.FUNCT WORD-TYPE,OBJ,WORD,SYNS
	GETPT OBJ,P?SYNONYM >SYNS
	PTSIZE SYNS >STACK
	DIV STACK,2 >STACK
	DEC 'STACK
	CALL ZMEMQ,WORD,SYNS,STACK >STACK
	RSTACK

	.FUNCT V-KNOCK
	CALL WORD-TYPE,PRSO,W?DOOR >STACK
	ZERO? STACK /?L1
	PRINTR "Nobody's home."
?L1:	PRINTI "Why knock on "
	CALL A-AN
	PRINTD PRSO
	PRINTR "?"

	.FUNCT V-YELL
	PRINTR "Aarrrrggggggghhhhhhhh!"

	.FUNCT BATTERY-FALLS
	PRINTR "The battery falls out."

	.FUNCT V-SHAKE,X
	CALL HELD?,PRSO >STACK
	ZERO? STACK \?L1
	EQUAL? PRSO,HANDS /?L1
	CALL NOT-HOLDING >STACK
	RSTACK
?L1:	EQUAL? PRSO,LASER \?L3
	IN? OLD-BATTERY,LASER \?L4
	MOVE OLD-BATTERY,HERE
	CALL BATTERY-FALLS >STACK
	RSTACK
?L4:	IN? NEW-BATTERY,LASER \?L6
	MOVE NEW-BATTERY,HERE
	CALL BATTERY-FALLS >STACK
	RSTACK
?L6:	PRINTR "Shaken."
?L3:	FSET? PRSO,OPENBIT /?L39
	FIRST? PRSO >STACK \?L10
	PRINTI "It sounds as if there is something inside the "
	PRINTD PRSO
	PRINTR "."
?L10:	FSET? PRSO,OPENBIT \?L13
?L39:	EQUAL? PRSO,FOOD-KIT \?L14
	IN? RED-GOO,FOOD-KIT /?L16
	IN? GREEN-GOO,FOOD-KIT /?L16
	IN? BROWN-GOO,FOOD-KIT \?L14
?L16:	REMOVE RED-GOO
	REMOVE GREEN-GOO
	REMOVE BROWN-GOO
	PRINTR "Colored goo flies all over everything. Yechh!"
?L14:	FIRST? PRSO >STACK \?L19
?L20:	FIRST? PRSO >X \?L21
	EQUAL? X,HIGH-PROTEIN,CHEMICAL-FLUID \?L24
	REMOVE X
	JUMP ?L20
?L24:	MOVE X,HERE
	JUMP ?L20
?L21:	PRINTI "The contents of the "
	PRINTD PRSO
	PRINTR " spill onto the floor."
?L19:	PRINTI "You have shaken the "
	PRINTD PRSO
	PRINTR "."
?L13:	FSET? PRSO,CONTBIT \?L33
	PRINTI "The "
	PRINTD PRSO
	PRINTR " sounds empty."
?L33:	PRINTR "Shaken."

	.FUNCT V-SHAKE-WITH
	EQUAL? PRSO,HANDS \?L1
	FSET? PRSI,ACTORBIT \?L3
	CALL PERFORM,V?SHAKE,HANDS
	RTRUE
?L3:	PRINTI "You can't shake hands with "
	CALL A-AN
	PRINTD PRSI
	PRINTR "!"
?L1:	PRINTR "Huh?"

	.FUNCT V-SMELL
	PRINTI "It smells just like "
	CALL A-AN
	PRINTD PRSO
	PRINTR "."

	.FUNCT GLOBAL-IN?,OBJ1,OBJ2,TEE
	GETPT OBJ2,P?GLOBAL >TEE
	ZERO? TEE /FALSE
	PTSIZE TEE >STACK
	DEC 'STACK
	CALL ZMEMQB,OBJ1,TEE,STACK >STACK
	RSTACK

	.FUNCT V-SWIM
	EQUAL? HERE,UNDERWATER \?L1
	PRINTR "Not much else you can do here. Might try a direction next time, though."
?L1:	PRINTR "You can't swim here!"

	.FUNCT V-SWIM-DIR
	EQUAL? HERE,UNDERWATER \?L1
	PRINTR "Okay. You're still underwater."
?L1:	CALL PERFORM,V?SWIM
	RTRUE

	.FUNCT V-SWIM-UP
	EQUAL? HERE,UNDERWATER \?L1
	CALL DO-WALK,P?UP >STACK
	RSTACK
?L1:	CALL PERFORM,V?SWIM >STACK
	ZERO? STACK \TRUE
	RFALSE

	.FUNCT V-ALARM
	PRINTI "The "
	PRINTD PRSO
	PRINTR " isn't sleeping."

	.FUNCT V-ZORK
	PRINTR "Gesundheit!"

	.FUNCT V-SIT
	EQUAL? HERE,ESCAPE-POD \?L1
	PRINTI "(in the web)"
	CRLF
	CALL PERFORM,V?BOARD,SAFETY-WEB
	RTRUE
?L1:	EQUAL? HERE,DORM-A,DORM-B,DORM-C /?L6
	EQUAL? HERE,DORM-D,INFIRMARY \?L5
?L6:	PRINTI "(on the bed)"
	CRLF
	CALL PERFORM,V?BOARD,BED
	RTRUE
?L5:	SET 'C-ELAPSED,31
	PRINTR "You recline on the floor for a bit, and then stand up again."

	.FUNCT V-SIT-DOWN
	EQUAL? PRSO,ROOMS \?L1
	CALL PERFORM,V?SIT
	RTRUE
?L1:	CALL PERFORM,V?BOARD,PRSO
	RTRUE

	.FUNCT V-GO-UP
	CALL DO-WALK,P?UP >STACK
	RSTACK

	.FUNCT V-CLIMB-ON
	FSET? PRSO,VEHBIT \?L1
	CALL PERFORM,V?BOARD,PRSO
	RTRUE
?L1:	PRINTI "You can't climb onto the "
	PRINTD PRSO
	PRINTR "."

	.FUNCT V-CLIMB-FOO
	FSET? PRSO,CLIMBBIT \?L1
	CALL V-CLIMB-UP,P?UP,1 >STACK
	RSTACK
?L1:	CALL PERFORM,V?CLIMB-ON,PRSO
	RTRUE

	.FUNCT V-CLIMB-UP,DIR=P?UP,OBJ=0,X
	GETPT HERE,DIR >STACK
	ZERO? STACK /?L1
	CALL DO-WALK,DIR
	RTRUE
?L1:	ZERO? OBJ \?L3
	PRINTR "You can't go that way."
?L3:	PRINTR "Bizarre!"

	.FUNCT V-CLIMB-DOWN
	FSET? PRSO,VEHBIT \?L1
	CALL V-CLIMB-ON
	RTRUE
?L1:	CALL V-CLIMB-UP,P?DOWN >STACK
	RSTACK

	.FUNCT PRE-PUT-UNDER
	CALL HELD?,PRSO >STACK
	ZERO? STACK \?L1
	CALL NOT-HOLDING >STACK
	RSTACK
?L1:	FSET? PRSO,WORNBIT \FALSE
	CALL TAKE-IT-OFF >STACK
	RSTACK

	.FUNCT V-PUT-UNDER
	PRINTR "You can't do that."

	.FUNCT V-ENTER
	CALL DO-WALK,P?IN >STACK
	RSTACK

	.FUNCT V-EXIT
	CALL DO-WALK,P?OUT >STACK
	RSTACK

	.FUNCT V-SEARCH
	SET 'C-ELAPSED,32
	PRINTR "You find nothing unusual."

	.FUNCT V-FIND,L
	LOC PRSO >L
	SET 'C-ELAPSED,18
	EQUAL? PRSO,ME,HANDS \?L1
	PRINTR "You're around here somewhere..."
?L1:	EQUAL? L,GLOBAL-OBJECTS \?L5
	PRINTR "You find it."
?L5:	IN? PRSO,WINNER \?L8
	PRINTR "You have it."
?L8:	IN? PRSO,HERE /?L12
	EQUAL? PRSO,PSEUDO-OBJECT \?L11
?L12:	PRINTR "It's right here."
?L11:	FSET? L,ACTORBIT \?L15
	PRINTI "The "
	PRINTD L
	PRINTR " has it."
?L15:	FSET? L,CONTBIT \?L18
	PRINTI "It's in the "
	PRINTD L
	PRINTR "."
?L18:	PRINTR "Beats me."

	.FUNCT V-TELL
	EQUAL? PRSO,ME \?L1
	PRINTI "Talking to yourself is a sign of impending mental collapse."
	CRLF
	SET 'P-CONT,0
	SET 'QUOTE-FLAG,0
	RETURN 2
?L1:	FSET? PRSO,ACTORBIT \?L7
	ZERO? P-CONT /?L8
	SET 'WINNER,PRSO
	LOC WINNER >HERE
	RETURN HERE
?L8:	PRINTI "The "
	PRINTD PRSO
	PRINTR " looks at you expectantly, as though he thought you were about to talk."
?L7:	PRINTI "Talking to "
	EQUAL? HERE,DECK-NINE \?L16
	EQUAL? PRSO,PSEUDO-OBJECT \?L16
	PRINTI "the "
	JUMP ?L20
?L16:	CALL A-AN
?L20:	PRINTD PRSO
	PRINTI "? Dr. Quarnsboggle, the Feinstein's psychiatrist, would "
	EQUAL? BLOWUP-COUNTER,5 \?L23
	PRINTI "have been"
	JUMP ?L27
?L23:	PRINTI "be"
?L27:	PRINTI " fascinated to hear that."
	CRLF
	SET 'QUOTE-FLAG,0
	SET 'P-CONT,0
	RETURN 2

	.FUNCT V-ASK-FOR
	FSET? PRSO,ACTORBIT \?L1
	IN? PRSI,PRSO \?L3
	PRINTI "The "
	PRINTD PRSO
	PRINTI " doesn't seem inclined to give up the "
	PRINTD PRSI
	PRINTR "."
?L3:	PRINTI "The "
	PRINTD PRSO
	PRINTI " isn't holding the "
	PRINTD PRSI
	PRINTR "."
?L1:	CALL PERFORM,V?TELL,PRSO
	RTRUE

	.FUNCT V-SAY,V
	CALL FIND-IN,HERE,ACTORBIT >V
	ZERO? V /?L1
	SET 'P-CONT,0
	PRINTI "You must address the "
	PRINTD V
	PRINTR " directly."
?L1:	SET 'QUOTE-FLAG,0
	SET 'P-CONT,0
	CALL PERFORM,V?TELL,ME >STACK
	RSTACK

	.FUNCT V-TALK
	CALL PERFORM,V?TELL,PRSO
	RTRUE

	.FUNCT V-ANSWER
	PRINTI "Nobody is awaiting your answer."
	CRLF
	SET 'P-CONT,0
	SET 'QUOTE-FLAG,0
	RTRUE

	.FUNCT V-REPLY
	PRINTI "It is hardly likely that the "
	PRINTD PRSO
	PRINTI " is interested."
	CRLF
	SET 'P-CONT,0
	SET 'QUOTE-FLAG,0
	RTRUE

	.FUNCT V-KISS
	PRINTR "I'd sooner kiss a pile of Antarian swamp mold."

	.FUNCT V-RAPE
	PRINTR "What a (ahem!) strange idea."

	.FUNCT V-DIAGNOSE
	SET 'C-ELAPSED,18
	ZERO? SICKNESS-LEVEL \?L1
	PRINTI "You are in perfect health."
	CRLF
	JUMP ?L5
?L1:	PRINTI "You are "
	GRTR? SICKNESS-LEVEL,7 \?L8
	PRINTI "severely"
	JUMP ?L18
?L8:	GRTR? SICKNESS-LEVEL,5 \?L12
	PRINTI "very"
	JUMP ?L18
?L12:	GRTR? SICKNESS-LEVEL,3 \?L15
	PRINTI "somewhat"
	JUMP ?L18
?L15:	PRINTI "a bit"
?L18:	PRINTI " sick and feverish."
	CRLF
?L5:	ZERO? SLEEPY-LEVEL \?L23
	PRINTI "You feel well-rested."
	CRLF
	JUMP ?L27
?L23:	PRINTI "You feel "
	GRTR? SLEEPY-LEVEL,2 \?L30
	PRINTI "phenomenally"
	JUMP ?L37
?L30:	GRTR? SLEEPY-LEVEL,1 \?L34
	PRINTI "quite"
	JUMP ?L37
?L34:	PRINTI "sort of"
?L37:	PRINTI " tired."
	CRLF
?L27:	ZERO? HUNGER-LEVEL \?L42
	PRINTR "You seem to be well-fed."
?L42:	PRINTI "You seem to be "
	GRTR? HUNGER-LEVEL,4 \?L49
	PRINTI "awesomely phenomenally"
	JUMP ?L56
?L49:	GRTR? HUNGER-LEVEL,2 \?L53
	PRINTI "noticeably"
	JUMP ?L56
?L53:	PRINTI "fairly"
?L56:	PRINTR " thirsty and hungry."

	.FUNCT V-WEAR
	FSET? PRSO,WEARBIT \?L1
	PRINTI "You are wearing the "
	PRINTD PRSO
	PRINTI "."
	CRLF
	SET 'C-ELAPSED,18
	FSET PRSO,WORNBIT
	RTRUE
?L1:	PRINTR "They're out of fashion, and besides, it wouldn't fit."

	.FUNCT V-REMOVE
	FSET? PRSO,WORNBIT \?L1
	CALL PERFORM,V?TAKE-OFF,PRSO
	RTRUE
?L1:	CALL PERFORM,V?TAKE,PRSO
	RTRUE

	.FUNCT V-TAKE-OFF
	FSET? PRSO,VEHBIT \?L1
	CALL V-DISEMBARK >STACK
	RSTACK
?L1:	FSET? PRSO,WORNBIT \?L3
	PRINTI "You are no longer wearing the "
	PRINTD PRSO
	PRINTI "."
	CRLF
	SET 'C-ELAPSED,18
	FCLEAR PRSO,WORNBIT
	RTRUE
?L3:	PRINTR "You aren't wearing that."

	.FUNCT V-STEP-ON
	PRINTR "That's a silly thing to do."

	.FUNCT V-PUT-ON
	EQUAL? PRSO,MAGNET,LADDER \?L1
	CALL PERFORM,V?ATTRACT,PRSO,PRSI
	RTRUE
?L1:	CALL PERFORM,V?PUT,PRSO,PRSI
	RTRUE

	.FUNCT V-NO
	PRINTR "You sound rather negative."

	.FUNCT V-YES
	PRINTR "You sound rather positive."

	.FUNCT V-MAYBE
	PRINTR "You sound rather indecisive."

	.FUNCT V-POINT
	IN? FLOYD,HERE \?L1
	CALL FLOYDS-FAMOUS-DOOR-ROUTINE >STACK
	RSTACK
?L1:	PRINTR "It's usually impolite to point."

	.FUNCT V-SET
	ZERO? PRSI \?L1
	EQUAL? PRSO,COMBINATION-DIAL,LASER-DIAL \?L3
	PRINTR "You must specify a number to set the dial to."
?L3:	PRINTI "Turning the "
	PRINTD PRSO
	PRINTR " accomplishes nothing."
?L1:	PRINTI "Setting "
	CALL A-AN
	PRINTD PRSO
	PRINTR " is a strange concept."

	.FUNCT V-$0024VERIFY
	EQUAL? PRSO,INTNUM \?L1
	EQUAL? P-NUMBER,502 \?L1
	PRINTN SERIAL
	CRLF
	RTRUE
?L1:	PRINTI "Verifying..."
	CRLF
	VERIFY \?L8
	PRINTR "Game correct. (YAY!)"
?L8:	CRLF
	PRINTR "** Game File Failure **"

	.FUNCT V-$0024COMMAND
	DIRIN 1
	RTRUE

	.FUNCT V-$0024RANDOM
	EQUAL? PRSO,INTNUM /?L1
	PRINTR "Illegal call to #RANDOM."
?L1:	SUB 0,P-NUMBER >STACK
	RANDOM STACK >STACK
	RTRUE

	.FUNCT V-$0024RECORD
	DIROUT D-RECORD-ON
	RTRUE

	.FUNCT V-$0024UNRECORD
	DIROUT D-RECORD-OFF
	RTRUE

	.FUNCT V-STAND-ON
	PRINTI "Standing on "
	CALL A-AN
	PRINTD PRSO
	PRINTR " seems like a waste of time."

	.FUNCT V-REACH
	FIRST? PRSO >STACK \?L1
	PRINTI "There is something"
	JUMP ?L5
?L1:	PRINTI "There is nothing"
?L5:	PRINTI " inside the "
	PRINTD PRSO
	PRINTR "."

	.FUNCT V-REACH-FOR
	FSET? PRSO,TAKEBIT \?L1
	CALL PERFORM,V?TAKE,PRSO
	RTRUE
?L1:	IN? PRSO,HERE \?L3
	PRINTR "It's here! Now what?"
?L3:	PRINTR "It is out of reach."

	.FUNCT DO-WALK,DIR
	SET 'P-WALK-DIR,DIR
	CALL PERFORM,V?WALK,DIR
	RTRUE

	.FUNCT V-FLUSH
	PRINTI "Flush "
	CALL A-AN
	PRINTD PRSO
	PRINTR "?"

	.FUNCT V-FLY
	PRINTR "Humans are not usually equipped for flying."

	.FUNCT V-SMILE
	PRINTR "How pleasant!"

	.FUNCT V-SALUTE
	PRINTI "The "
	PRINTD PRSO
	PRINTR " fails to return your salute."

	.FUNCT V-ATTRACT
	PRINTR "Nothing interesting happens."

	.FUNCT V-ZATTRACT
	CALL PERFORM,V?ATTRACT,PRSI,PRSO
	RTRUE

	.FUNCT V-SPAN
	PRINTR "You can't."

	.FUNCT NUMBERS-ONLY
	PRINTR "This keyboard only has numeric keys. You can type numbers on it, but not words."

	.FUNCT V-TYPE
	EQUAL? HERE,MINI-BOOTH \?L1
	EQUAL? PRSO,INTNUM /?L3
	CALL NUMBERS-ONLY >STACK
	RSTACK
?L3:	ZERO? MINI-ACTIVATED /?L5
	EQUAL? P-NUMBER,384 \?L6
	PRINTI "You notice the walls of the booth sliding away in all directions, followed by a momentary queasiness in the pit of your stomach..."
	CRLF
	CRLF
	CALL GOTO,STATION-384
	SET 'BEEN-HERE,1
	RETURN BEEN-HERE
?L6:	LESS? P-NUMBER,10 \?L10
	PRINTR "After a pause a recorded voice says ""There are no one-digit computer sectors...clearing entry...please type damaged sector number."""
?L10:	GRTR? P-NUMBER,1024 \?L13
	PRINTR "A recorded voice says ""Databanks indicate no computer sector corresponding to that number. Please check with your supervisor."""
?L13:	CALL JIGS-UP,STR?92 >STACK
	RSTACK
?L5:	PRINTR "A recording says ""Internal computer repair booth not activated."""
?L1:	EQUAL? HERE,LIBRARY-LOBBY \?L20
	CALL LIBRARY-TYPE >STACK
	RSTACK
?L20:	PRINTR "Type on what???"

	.FUNCT PRE-SZAP
	CALL PERFORM,V?ZAP,PRSI,PRSO
	RTRUE

	.FUNCT PRE-ZAP
	ZERO? PRSI \FALSE
	EQUAL? PRSO,LASER /FALSE
	IN? LASER,ADVENTURER \?L4
	CALL PERFORM,V?ZAP,LASER,PRSO
	RTRUE
?L4:	PRINTR "You have nothing to shoot it with."

	.FUNCT V-ZAP
	CALL HELD?,PRSO >STACK
	ZERO? STACK \?L1
	CALL NOT-HOLDING >STACK
	RSTACK
?L1:	EQUAL? PRSO,LASER /?L3
	PRINTR "You can't shoot that."
?L3:	ZERO? PRSI \?L6
	PRINTI "At what?"
	RTRUE
?L6:	PRINTR "Nothing happens."

	.FUNCT V-SZAP
	PRINTR "Zap!"

	.FUNCT V-SCRUB
	ZERO? PRSI \?L14
	IN? SCRUB-BRUSH,ADVENTURER /?L1
	IN? TOWEL,ADVENTURER /?L1
	PRINTR "You don't have anything to scrub with!"
?L1:	ZERO? PRSI /?L5
?L14:	EQUAL? PRSI,SCRUB-BRUSH,TOWEL /?L5
	PRINTR "You can't scrub something with that!"
?L5:	FSET? PRSO,ACTORBIT \?L8
	PRINTI "The "
	PRINTD PRSO
	PRINTR " prefers cleaning himself."
?L8:	PRINTI "The "
	PRINTD PRSO
	PRINTR " is a bit shinier now."

	.FUNCT V-POUR
	PRINTR "Pouring or spilling non-liquids is specifically forbidden by section 17.9.2 of the Galactic Adventure Game Compendium of Rules."

	.FUNCT V-EMPTY,X
	FSET? PRSO,OPENBIT /?L1
	PRINTR "You can't empty it when it's closed!"
?L1:	FIRST? PRSO >STACK \?L5
?L6:	FIRST? PRSO >X \?L7
	EQUAL? X,HIGH-PROTEIN,CHEMICAL-FLUID \?L10
	REMOVE X
	JUMP ?L6
?L10:	MOVE X,HERE
	JUMP ?L6
?L7:	PRINTI "The "
	PRINTD PRSO
	PRINTR " is now empty."
?L5:	PRINTI "There's nothing in the "
	PRINTD PRSO
	PRINTR "."

	.FUNCT V-THROW-OFF
	PRINTR "It's difficult to see how that can be done."

	.FUNCT V-SLEEP
	ZERO? SLEEPY-LEVEL \?L1
	PRINTR "You're not tired!"
?L1:	CALL INT,I-FALL-ASLEEP >STACK
	GET STACK,C-ENABLED? >STACK
	ZERO? STACK /?L5
	PRINTR "You'll probably be asleep before you know it."
?L5:	PRINTR "Civilized members of society usually sleep in beds."

	.FUNCT V-FIX-IT
	PRINTR "You shouldn't expect sweeping general commands like this to work. If you want to repair something, you must perform the specific steps required."

	.FUNCT V-OIL
	ZERO? PRSI \?L1
	IN? OIL-CAN,ADVENTURER \?L3
	CALL PERFORM,V?OIL,PRSO,OIL-CAN
	RTRUE
?L3:	PRINTR "Oil it with what?"
?L1:	EQUAL? PRSI,OIL-CAN \?L8
	EQUAL? PRSO,FLOYD \?L9
	FSET? FLOYD,RLANDBIT \?L9
	PRINTR "Floyd thanks you for your thoughtfulness."
?L9:	PRINTI "The "
	PRINTD PRSO
	PRINTR " doesn't need oiling."
?L8:	PRINTI "You can't use "
	FSET? PRSI,VOWELBIT \?L19
	PRINTI "an "
	JUMP ?L23
?L19:	PRINTI "a "
?L23:	PRINTD PRSI
	PRINTR " as an oil can!"

	.FUNCT V-SHOW
	CALL HELD?,PRSO >STACK
	ZERO? STACK \?L1
	CALL NOT-HOLDING >STACK
	RSTACK
?L1:	EQUAL? PRSI,ME \?L3
	CALL PERFORM,V?EXAMINE,PRSO
	RTRUE
?L3:	FSET? PRSI,ACTORBIT \?L4
	PRINTI "The "
	PRINTD PRSI
	PRINTI " looks at the "
	PRINTD PRSO
	PRINTR "."
?L4:	PRINTI "Why would you want to show something to "
	CALL A-AN
	PRINTD PRSO
	PRINTR "?"

	.FUNCT V-INSERT
	EQUAL? HERE,LIBRARY \?L1
	PRINTI "(into the spool reader)"
	CRLF
	CALL PERFORM,V?PUT,PRSO,SPOOL-READER
	RTRUE
?L1:	EQUAL? HERE,KITCHEN \?L5
	PRINTI "(into the niche)"
	CRLF
	CALL PERFORM,V?PUT,PRSO,DISPENSER
	RTRUE
?L5:	PRINTI "You'll have to specify where you want to put the "
	PRINTD PRSO
	PRINTR "."

	.FUNCT V-TASTE
	EQUAL? PRSO,HIGH-PROTEIN,RED-GOO /?L3
	EQUAL? PRSO,BROWN-GOO,GREEN-GOO \?L1
?L3:	PRINTR "It tastes edible."
?L1:	EQUAL? PRSO,CHEMICAL-FLUID \?L6
	PRINTR "It burns your tongue."
?L6:	PRINTI "It tastes just like "
	CALL A-AN
	PRINTD PRSO
	PRINTR "."

	.FUNCT V-ZESCAPE
	EQUAL? HERE,BRIG \?L1
	PRINTR "Houdini himself would be stumped by this cell."
?L1:	PRINTR "There is no escape. We control the horizontal. We control the vertical. We control the disk drives..."

	.FUNCT V-TIME
	IN? CHRONOMETER,ADVENTURER \?L1
	CALL TELL-TIME
	CRLF
	RTRUE
?L1:	PRINTR "It's hard to say, since you've removed your chronometer."

	.FUNCT V-PLAY
	PRINTI "How does one play "
	CALL A-AN
	PRINTD PRSO
	PRINTR "?"

	.FUNCT V-PLAY-WITH
	FSET? PRSO,ACTORBIT \?L1
	CALL PERFORM,V?PLAY,GLOBAL-GAMES
	RTRUE
?L1:	PRINTR "I sometimes wonder about your mental health."

	.FUNCT V-SCOLD
	FSET? PRSO,ACTORBIT \?L1
	CALL PERFORM,V?TELL,PRSO
	RTRUE
?L1:	PRINTI "For some reason, the "
	PRINTD PRSO
	PRINTR " doesn't seem too chagrined."

	.FUNCT ROB,WHO,WHERE,N,X
	FIRST? WHO >X /?L4
	RTRUE
?L1:	ZERO? X /TRUE
?L4:	NEXT? X >N /?L7
?L7:	MOVE X,WHERE
	SET 'X,N
	JUMP ?L1

	.FUNCT THIS-IS-IT,OBJ
	SET 'P-IT-OBJECT,OBJ
	SET 'P-IT-LOC,HERE
	RETURN P-IT-LOC

	.FUNCT ACCESSIBLE?,OBJ,L
	LOC OBJ >L
	FSET? OBJ,INVISIBLE /FALSE
	EQUAL? OBJ,PSEUDO-OBJECT \?L3
	EQUAL? LAST-PSEUDO-LOC,HERE \FALSE
	RTRUE
?L3:	ZERO? L /FALSE
	EQUAL? L,GLOBAL-OBJECTS /TRUE
	EQUAL? L,LOCAL-GLOBALS \?L9
	CALL GLOBAL-IN?,OBJ,HERE >STACK
	ZERO? STACK \TRUE
?L9:	CALL META-LOC,OBJ >STACK
	EQUAL? STACK,HERE \FALSE
	EQUAL? L,WINNER,HERE /TRUE
	FSET? L,OPENBIT \FALSE
	CALL ACCESSIBLE?,L >STACK
	ZERO? STACK /FALSE
	RTRUE

	.FUNCT VISIBLE?,OBJ,L
	LOC OBJ >L
	CALL ACCESSIBLE?,OBJ >STACK
	ZERO? STACK \TRUE
	CALL SEE-INSIDE?,L >STACK
	ZERO? STACK /FALSE
	CALL VISIBLE?,L >STACK
	ZERO? STACK /FALSE
	RTRUE

	.FUNCT A-AN
	FSET? PRSO,VOWELBIT \?L1
	PRINTI "an "
	RTRUE
?L1:	PRINTI "a "
	RTRUE

	.FUNCT ALREADY,ON-OFF,OBJ=0
	ZERO? OBJ /?L1
	PRINTI "The "
	PRINTD OBJ
	PRINTI " is "
	JUMP ?L5
?L1:	PRINTI "It's "
?L5:	PRINTI "already "
	PRINT ON-OFF
	PRINTR "."

	.FUNCT NOT-HOLDING
	PRINTI "You're not holding the "
	PRINTD PRSO
	PRINTR "."

	.FUNCT TAKE-IT-OFF
	PRINTR "You'll have to take it off, first."

	.FUNCT ANYMORE
	PRINTR "You can't see that anymore."

	.FUNCT FIXED-FONT-ON
	GET 0,8 >STACK
	BOR STACK,2 >STACK
	PUT 0,8,STACK
	RTRUE

	.FUNCT FIXED-FONT-OFF
	GET 0,8 >STACK
	BAND STACK,-3 >STACK
	PUT 0,8,STACK
	RTRUE

	.FUNCT UNDERWATER-F,RARG
	EQUAL? RARG,M-END \FALSE
	IGRTR? 'DROWN,2 \FALSE
	CALL JIGS-UP,STR?93 >STACK
	RSTACK

	.FUNCT CRAG-F,RARG
	EQUAL? RARG,M-ENTER \FALSE
	SET 'DROWN,3
	RETURN DROWN

	.FUNCT BALCONY-F,RARG
	EQUAL? RARG,M-LOOK \FALSE
	PRINTI "This is an octagonal room, half carved into and half built out from the cliff wall. Through the shattered windows which ring the outer wall you can see ocean to the horizon. A weathered metal plaque with barely readable lettering rests below the windows. The language seems to be a corrupt form of Galalingua. A steep stairway, roughly cut into the face of the cliff, leads upward. "
	EQUAL? DAY,1 \?L5
	PRINTR "A rocky crag can be seen about eight meters below."
?L5:	EQUAL? DAY,2 \?L9
	PRINTR "The ocean waters swirl below. The crag where you landed yesterday is now underwater!"
?L9:	EQUAL? DAY,3 \FALSE
	PRINTR "Ocean waters are lapping at the base of the balcony."

	.FUNCT WINDING-STAIR-F,RARG
	EQUAL? RARG,M-LOOK \FALSE
	PRINTI "The middle of a long, steep stairway carved into the face of a cliff."
	EQUAL? DAY,4 \?L5
	PRINTR " You hear the lapping of water from below."
?L5:	EQUAL? DAY,5 \?L9
	PRINTI " You can see ocean water splashing against the steps below you."
?L9:	CRLF
	RTRUE

	.FUNCT COURTYARD-F,RARG
	EQUAL? RARG,M-LOOK \FALSE
	PRINTI "You are in the courtyard of an ancient stone edifice, vaguely reminiscent of the castles you saw during your leave on Ramos Two. It has decayed to the point where it can probably be termed a ruin. Openings lead north and west, and a stairway downward is visible to the south. "
	EQUAL? DAY,6,7 \?L5
	PRINTR "From the direction of the stairway comes the sound of ocean surf."
?L5:	EQUAL? DAY,8 \?L9
	PRINTI "Ocean water washes against the top few steps."
?L9:	CRLF
	RTRUE

	.FUNCT WATER-LEVEL-F
	EQUAL? HERE,BALCONY \?L1
	EQUAL? DAY,1 \?L3
	RETURN CRAG
?L3:	RETURN UNDERWATER
?L1:	EQUAL? HERE,WINDING-STAIR \?L6
	LESS? DAY,4 \?L7
	RETURN BALCONY
?L7:	RETURN UNDERWATER
?L6:	EQUAL? HERE,COURTYARD \FALSE
	LESS? DAY,6 \?L11
	RETURN WINDING-STAIR
?L11:	RETURN UNDERWATER

	.FUNCT REC-AREA-F,RARG
	EQUAL? RARG,M-LOOK \FALSE
	PRINTI "This is a recreational facility of some sort. Games and tapes are scattered about the room. Hallways head off to the east and south, and to the north is a door which is "
	FSET? CONFERENCE-DOOR,OPENBIT \?L5
	PRINTI "open"
	JUMP ?L9
?L5:	PRINTI "closed and locked. A dial on the door is currently set to "
	PRINTN DIAL-NUMBER
?L9:	PRINTR "."

	.FUNCT CONFERENCE-ROOM-F,RARG
	EQUAL? RARG,M-LOOK \FALSE
	PRINTI "This is a fairly square room, almost filled by a round conference table. To the south is a door which is "
	CALL DDESC,CONFERENCE-DOOR
	PRINTR ". To the north is a small room about the size of a phone booth."

	.FUNCT COMBINATION-DIAL-F
	EQUAL? PRSA,V?EXAMINE \?L1
	PRINTR "The dial can be turned to any number between 0 and 1000."
?L1:	EQUAL? PRSA,V?SET \FALSE
	EQUAL? PRSI,INTNUM \FALSE
	FSET? COMBINATION-DIAL,MUNGEDBIT \?L6
	PRINTR "The dial has somehow become fused and won't move."
?L6:	EQUAL? P-NUMBER,DIAL-NUMBER \?L10
	PRINTR "That's what the dial is set to now!"
?L10:	EQUAL? P-NUMBER,NUMBER-NEEDED \?L13
	SET 'DIAL-NUMBER,0
	FSET CONFERENCE-DOOR,OPENBIT
	PRINTR "The door swings open, and the dial resets to 0."
?L13:	GRTR? P-NUMBER,1000 \?L16
	PRINTR "The dial cannot be turned to a number that high."
?L16:	SET 'DIAL-NUMBER,P-NUMBER
	PRINTI "The dial is now set to "
	PRINTN P-NUMBER
	PRINTR "."

	.FUNCT CONFERENCE-DOOR-F
	EQUAL? PRSA,V?OPEN \?L1
	FSET? CONFERENCE-DOOR,OPENBIT \?L3
	CALL ALREADY-OPEN >STACK
	RSTACK
?L3:	EQUAL? HERE,REC-AREA \?L6
	PRINTR "The door is locked. You probably have to turn the dial to some number to open it."
?L6:	PRINTR "The door seems to be locked from the other side."
?L1:	EQUAL? PRSA,V?CLOSE \FALSE
	FSET? CONFERENCE-DOOR,OPENBIT \?L14
	FCLEAR CONFERENCE-DOOR,OPENBIT
	PRINTR "The door closes and you hear a click as it locks."
?L14:	CALL IS-CLOSED >STACK
	RSTACK

	.FUNCT MESS-CORRIDOR-F,RARG
	EQUAL? RARG,M-LOOK \FALSE
	PRINTI "This is a wide, east-west hallway with a large portal to the south. A small door to the north is "
	CALL DDESC,STORAGE-WEST-DOOR
	ZERO? PADLOCK-REMOVED \?L13
	PRINTI " and hooked with a simple steel padlock"
	FSET? PADLOCK,OPENBIT \?L9
	PRINTI " which hangs unlocked"
	JUMP ?L13
?L9:	PRINTI " which is also closed"
?L13:	PRINTR "."

	.FUNCT STORAGE-WEST-DOOR-F
	EQUAL? PRSA,V?OPEN \?L1
	FSET? STORAGE-WEST-DOOR,OPENBIT \?L3
	CALL ALREADY-OPEN >STACK
	RSTACK
?L3:	ZERO? PADLOCK-REMOVED /?L5
	FSET STORAGE-WEST-DOOR,OPENBIT
	PRINTR "Opened."
?L5:	PRINTR "The door cannot be opened until the padlock is removed."
?L1:	EQUAL? PRSA,V?CLOSE \?L11
	FSET? STORAGE-WEST-DOOR,OPENBIT \?L12
	FCLEAR STORAGE-WEST-DOOR,OPENBIT
	PRINTR "The door is now closed."
?L12:	CALL IS-CLOSED >STACK
	RSTACK
?L11:	EQUAL? PRSA,V?UNLOCK \FALSE
	PRINTI "The door itself isn't locked."
	FSET? PADLOCK,OPENBIT /?L20
	PRINTI " It is the padlock on the door which is locked."
?L20:	CRLF
	RTRUE

	.FUNCT PADLOCK-F
	EQUAL? HERE,BRIG \?L1
	PRINTR "You can't see or reach the lock from inside the cell."
?L1:	EQUAL? PRSA,V?OPEN-WITH \?L5
	EQUAL? PADLOCK,PRSO \?L5
	CALL PERFORM,V?UNLOCK,PADLOCK,PRSI
	RTRUE
?L5:	EQUAL? PRSA,V?OPEN,V?UNLOCK \?L6
	FSET? PADLOCK,OPENBIT /?L7
	ZERO? PRSI \?L9
	PRINTR "You can't open it with your hands."
?L9:	EQUAL? PRSI,KEY \?L13
	FSET? PADLOCK,MUNGEDBIT \?L14
	PRINTR "Tsk, tsk ... the padlock seems to be fused shut."
?L14:	FSET PADLOCK,OPENBIT
	PRINTR "The padlock springs open."
?L13:	PRINTR "That doesn't work."
?L7:	PRINTR "The padlock is already unlocked."
?L6:	EQUAL? PRSA,V?LOCK,V?CLOSE \?L27
	FSET? PADLOCK,OPENBIT \?L28
	FCLEAR PADLOCK,OPENBIT
	PRINTR "The padlock closes with a sharp click."
?L28:	PRINTR "The padlock is already locked."
?L27:	EQUAL? PRSA,V?TAKE \?L35
	ZERO? PADLOCK-REMOVED \?L35
	FSET? PADLOCK,OPENBIT \?L39
	SET 'PADLOCK-REMOVED,1
	FCLEAR PADLOCK,TRYTAKEBIT
	FCLEAR PADLOCK,NDESCBIT
	RFALSE
?L39:	PRINTR "The padlock is locked to the door."
?L35:	EQUAL? PRSA,V?MUNG \FALSE
	PRINTR "And, as we go into the next round, it's Padlock 1, Adventurer 0..."

	.FUNCT CAN-F
	EQUAL? PRSA,V?EXAMINE \?L1
	PRINTR "This is a rather normal tin can. It is large and is labelled ""Spam and Egz."""
?L1:	EQUAL? PRSA,V?OPEN \FALSE
	PRINTR "You certainly can't open it with your hands, and you don't seem to have found a can opener yet."

	.FUNCT LADDER-F
	EQUAL? PRSA,V?TAKE \?L1
	ZERO? LADDER-EXTENDED /FALSE
	PRINTR "You can't possibly carry the ladder while it's extended."
?L1:	EQUAL? PRSA,V?EXAMINE \?L8
	PRINTI "It is a heavy-duty ladder built of sturdy aluminum tubing. It is currently "
	ZERO? LADDER-EXTENDED /?L11
	PRINTR "extended to its full length of about 8 meters, but could be collapsed to a shorter length for easier carrying."
?L11:	PRINTR "collapsed and is around two-and-a-half meters long, but if extended would obviously be much longer."
?L8:	EQUAL? PRSA,V?OPEN \?L18
	ZERO? LADDER-EXTENDED /?L19
	PRINTR "The ladder is already extended."
?L19:	EQUAL? HERE,STORAGE-EAST,STORAGE-WEST,BOOTH-2 /?L24
	EQUAL? HERE,UPPER-ELEVATOR,LOWER-ELEVATOR \?L23
?L24:	PRINTR "You can't extend the ladder in this tiny space!"
?L23:	IN? LADDER,ADVENTURER \?L27
	PRINTR "You couldn't possibly extend the ladder while you're holding it."
?L27:	FSET LADDER,TRYTAKEBIT
	SET 'LADDER-EXTENDED,1
	SET 'C-ELAPSED,36
	PRINTR "The ladder extends to a length of around eight meters."
?L18:	EQUAL? PRSA,V?CLOSE \?L33
	ZERO? LADDER-EXTENDED /?L34
	SET 'C-ELAPSED,21
	ZERO? LADDER-FLAG /?L36
	SET 'LADDER-FLAG,0
	REMOVE LADDER
	PRINTR "As the ladder shortens it plunges into the rift."
?L36:	SET 'LADDER-EXTENDED,0
	FCLEAR LADDER,TRYTAKEBIT
	PRINTR "The ladder collapses to a length of around two-and-a-half meters."
?L34:	PRINTR "The ladder is already in its collapsed state."
?L33:	EQUAL? PRSA,V?ATTRACT,V?SPAN \?L46
	EQUAL? PRSI,RIFT \?L46
	ZERO? LADDER-FLAG /?L47
	PRINTR "The ladder already spans the rift."
?L47:	ZERO? LADDER-EXTENDED /?L52
	SET 'LADDER-FLAG,1
	FSET LADDER,NDESCBIT
	PRINTR "The ladder swings out across the rift and comes to rest on the far edge, spanning the precipice."
?L52:	REMOVE LADDER
	PRINTR "The ladder, far too short to reach the other edge of the rift, plunges into the rift and is lost forever."
?L46:	EQUAL? PRSA,V?CLIMB-FOO,V?CLIMB-UP \FALSE
	ZERO? LADDER-FLAG /?L60
	PRINTR "You can't climb a horizontal ladder!"
?L60:	IN? LADDER,ADVENTURER \FALSE
	PRINTR "That would be a neat trick, considering that you're holding it."

	.FUNCT MESS-HALL-F,RARG
	EQUAL? RARG,M-LOOK \FALSE
	PRINTI "This is a large hall lined with tables and benches. An opening to the north leads back to the corridor. A door to the south is "
	CALL DDESC,KITCHEN-DOOR
	PRINTR ". Next to the door is a small slot."

	.FUNCT KITCHEN-DOOR-F
	EQUAL? PRSA,V?OPEN \FALSE
	PRINTR "A light flashes ""Pleez yuuz kitcin akses kard."""

	.FUNCT DISPENSER-F
	EQUAL? PRSA,V?EXAMINE \?L1
	PRINTI "This wall-mounted unit contains an octagonal niche beneath a spout. "
	IN? CANTEEN,DISPENSER \?L5
	PRINTI "A canteen is resting in the niche, its mouth lying just below the spout. "
?L5:	PRINTR "Above the spout is a button. The machine is labelled ""Hii Prooteen Likwid Dispensur."""
?L1:	EQUAL? PRSA,V?CLOSE \?L12
	CALL NO-CLOSE
	RTRUE
?L12:	EQUAL? PRSA,V?PUT \FALSE
	EQUAL? PRSO,CANTEEN \?L14
	MOVE CANTEEN,DISPENSER
	PRINTR "The canteen fits snugly into the octagonal niche, its mouth resting just below the spout of the machine."
?L14:	PRINTR "It doesn't fit in the niche."

	.FUNCT HIGH-PROTEIN-F,X=0
	EQUAL? PRSA,V?EAT \?L1
	IN? CANTEEN,ADVENTURER /?L3
	SET 'PRSO,CANTEEN
	CALL NOT-HOLDING >STACK
	RSTACK
?L3:	ZERO? HUNGER-LEVEL \?L6
	PRINT NOT-HUNGRY
	CRLF
	RTRUE
?L6:	REMOVE HIGH-PROTEIN
	SET 'C-ELAPSED,15
	SET 'HUNGER-LEVEL,0
	CALL QUEUE,I-HUNGER-WARNINGS,3600 >STACK
	PUT STACK,0,1
	PRINTR "Mmmm....that was good. It certainly quenched your thirst and satisfied your hunger."
?L1:	EQUAL? PRSA,V?POUR \FALSE
	EQUAL? PRSO,HIGH-PROTEIN \FALSE
	IN? CANTEEN,ADVENTURER /?L14
	PRINTR "Maybe if you were holding the canteen..."
?L14:	ZERO? PRSI \?L18
	SET 'PRSI,GROUND
?L18:	EQUAL? PRSI,FLASK \?L20
	CALL WORTHLESS-ACTION >STACK
	RSTACK
?L20:	EQUAL? PRSI,FUNNEL-HOLE \?L22
	IN? CHEMICAL-FLUID,FLASK \?L23
	SET 'X,1
?L23:	SET 'CHEMICAL-REQUIRED,10
	REMOVE HIGH-PROTEIN
	CALL PERFORM,V?POUR,CHEMICAL-FLUID,FUNNEL-HOLE
	ZERO? X /TRUE
	MOVE CHEMICAL-FLUID,FLASK
	RTRUE
?L22:	REMOVE HIGH-PROTEIN
	PRINTI "The protein-rich fluid pours over the "
	PRINTD PRSI
	PRINTR " and then dries up."

	.FUNCT WORTHLESS-ACTION
	PRINTR "A worthless action -- and much too difficult for a poorly-written program like this one to handle."

	.FUNCT LONG-HALL-F
	PRINTI "You walk down the long, featureless hallway for a long time. Finally, you see "
	SET 'C-ELAPSED,160
	EQUAL? HERE,CORRIDOR-JUNCTION \?L3
	PRINTI "some doorways ahead..."
	CRLF
	CRLF
	RETURN DORM-CORRIDOR
?L3:	PRINTI "an intersection ahead..."
	CRLF
	CRLF
	RETURN CORRIDOR-JUNCTION

	.FUNCT ADMIN-CORRIDOR-S-F,RARG
	EQUAL? RARG,M-END \FALSE
	FSET? KEY,INVISIBLE \FALSE
	RANDOM 100 >STACK
	LESS? 20,STACK /FALSE
	PRINTR "You catch, out of the corner of your eye, a glint of light from the direction of the floor."

	.FUNCT CREVICE-F
	EQUAL? PRSA,V?REACH \?L1
	PRINTR "The crevice is too narrow to reach into."
?L1:	EQUAL? PRSA,V?SEARCH,V?EXAMINE,V?LOOK-INSIDE \FALSE
	FSET? KEY,TOUCHBIT \?L6
	PRINTR "Nothing there but bunches of dust."
?L6:	FCLEAR KEY,INVISIBLE
	PRINTR "Lying at the bottom of the narrow crack, partly covered by layers of dust, is a shiny steel key!"

	.FUNCT KEY-F
	EQUAL? PRSA,V?MOVE,V?ZATTRACT,V?TAKE \?L1
	FSET? KEY,TOUCHBIT /?L1
	EQUAL? PRSI,PLIERS \?L3
	PRINTR "These are heavy-duty pliers, too large to reach into this narrow crack."
?L3:	EQUAL? PRSI,MAGNET \?L7
	CALL PERFORM,V?ATTRACT,MAGNET,KEY
	RTRUE
?L7:	ZERO? PRSI /?L8
	PRINTR "Nice try."
?L8:	PRINTR "Either the crevice is too narrow, or your fingers are too large."
?L1:	EQUAL? PRSA,V?PUT \FALSE
	EQUAL? PRSI,CREVICE \FALSE
	PRINTR "And you wonder why you're still only an Ensign Seventh Class?"

	.FUNCT ADMIN-CORRIDOR-F,RARG
	ZERO? LADDER-FLAG /?L1
	EQUAL? RARG,M-ENTER \?L1
	MOVE LADDER,HERE
	RTRUE
?L1:	EQUAL? RARG,M-LOOK \FALSE
	PRINTI "The hallway, in fact the entire building, has been rent apart here, presumably by seismic upheaval. You can see the sky through the severed roof above, and the ground is thick with rubble. To the north is a gaping rift, at least eight meters across and thirty meters deep. "
	ZERO? LADDER-FLAG /?L6
	PRINTI "A metal ladder spans the rift. "
?L6:	PRINTR "A wide doorway, labelled ""Sistumz Moniturz,"" leads west."

	.FUNCT ADMIN-CORRIDOR-N-F,RARG
	ZERO? LADDER-FLAG /?L1
	EQUAL? RARG,M-ENTER \?L1
	MOVE LADDER,HERE
	RTRUE
?L1:	EQUAL? RARG,M-LOOK \FALSE
	PRINTI "The corridor ends here. Portals lead west, north, and east. Signs above these portals read, respectively, ""Administraativ Awfisiz,"" ""Tranzportaashun Suplii,"" and ""Plan Ruum."" To the south is a wide rift"
	ZERO? LADDER-FLAG /?L6
	PRINTI ", spanned by a metal ladder,"
?L6:	PRINTR " separating this area from the rest of the building."

	.FUNCT LADDER-EXIT-F
	ZERO? LADDER-FLAG /?L1
	SET 'C-ELAPSED,33
	PRINTI "You slowly make your way across the swaying ladder. You can see sharp, pointy rocks at the bottom of the rift, far below..."
	CRLF
	CRLF
	EQUAL? HERE,ADMIN-CORRIDOR-N \?L5
	RETURN ADMIN-CORRIDOR
?L5:	RETURN ADMIN-CORRIDOR-N
?L1:	PRINTI "The rift is too wide to jump across."
	CRLF
	RFALSE

	.FUNCT RIFT-F
	EQUAL? PRSA,V?LEAP \?L1
	CALL JIGS-UP,STR?94 >STACK
	RSTACK
?L1:	EQUAL? PRSA,V?PUT \?L3
	EQUAL? RIFT,PRSI \?L3
	EQUAL? PRSO,LASER \?L4
	CALL INT,I-WARMTH >STACK
	PUT STACK,0,0
?L4:	REMOVE PRSO
	EQUAL? PRSO,SCRUB-BRUSH \?L7
	PRINTR "You watch with tremendous satisfaction as the brush is lost forever."
?L7:	PRINTI "The "
	PRINTD PRSO
	PRINTR " sails gracefully into the rift."
?L3:	EQUAL? PRSA,V?LOOK-INSIDE,V?EXAMINE \FALSE
	PRINTR "The rift is at least eight meters wide and more than thirty meters deep. The bottom is covered with sharp and nasty rocks."

	.FUNCT SYSTEMS-MONITORS-F,RARG
	EQUAL? RARG,M-LOOK \FALSE
	PRINTI "This is a large room filled with tables full of strange equipment. "
	CALL DESCRIBE-MONITORS >STACK
	RSTACK

	.FUNCT DESCRIBE-MONITORS
	PRINTI "The far wall is filled with a number of monitors. Of these, the ones labelled "
	ZERO? DEFENSE-FIXED /?L3
	PRINTI "PLANATEREE DEFENS, "
?L3:	ZERO? COURSE-CONTROL-FIXED /?L8
	PRINTI "PLANATEREE KORS KUNTROOL, "
?L8:	ZERO? COMM-FIXED /?L13
	PRINTI "KUMUUNIKAASHUNZ, "
?L13:	PRINTI "LIIBREREE, REEAKTURZ, and LIIF SUPORT are green, but the one"
	ZERO? DEFENSE-FIXED /?L22
	ZERO? COURSE-CONTROL-FIXED /?L22
	ZERO? COMM-FIXED \?L20
?L22:	PRINTI "s"
?L20:	PRINTI " labelled "
	ZERO? DEFENSE-FIXED \?L28
	PRINTI "PLANATEREE DEFENS, "
?L28:	ZERO? COURSE-CONTROL-FIXED \?L33
	PRINTI "PLANATEREE KORS KUNTROOL, "
?L33:	ZERO? COMM-FIXED \?L38
	PRINTI "KUMUUNIKAASHUNZ, "
?L38:	ZERO? DEFENSE-FIXED /?L45
	ZERO? COURSE-CONTROL-FIXED /?L45
	ZERO? COMM-FIXED \?L43
?L45:	PRINTI "and "
?L43:	PRINTI "PRAJEKT KUNTROOL indicate"
	ZERO? DEFENSE-FIXED /?L51
	ZERO? COURSE-CONTROL-FIXED /?L51
	ZERO? COMM-FIXED /?L51
	PRINTI "s"
?L51:	PRINTR " a malfunctioning condition."

	.FUNCT DESK-F
	EQUAL? PRSA,V?EXAMINE,V?SEARCH \FALSE
	PRINTI "The desk has a drawer which is currently "
	CALL DDESC,PRSO
	PRINTR "."

	.FUNCT OIL-CAN-F
	EQUAL? PRSA,V?POUR \?L1
	ZERO? PRSI \?L3
	SET 'PRSI,GROUND
?L3:	CALL PERFORM,V?OIL,PRSI
	RTRUE
?L1:	EQUAL? PRSA,V?EMPTY \FALSE
	PRINTR "Pretty much impossible -- you could only do that one drop at a time."

	.FUNCT CARTON-F
	EQUAL? PRSA,V?CLOSE \FALSE
	CALL NO-CLOSE
	RTRUE

	.FUNCT CRACKED-BOARD-F
	EQUAL? PRSA,V?EXAMINE \FALSE
	CALL EXAMINE-BOARD
	PRINTR " This one looks as though it's been dropped."

	.FUNCT GOOD-BEDISTOR-F
	EQUAL? PRSA,V?TAKE \FALSE
	ZERO? COURSE-CONTROL-FIXED /FALSE
	CALL JIGS-UP,STR?95 >STACK
	RSTACK

	.FUNCT REACTOR-ELEVATOR-DOOR-F
	EQUAL? PRSA,V?CLOSE,V?OPEN \FALSE
	PRINTR "It won't budge."

	.FUNCT I-REACTOR-DOOR-CLOSE
	CALL QUEUE,I-REACTOR-DOOR-CLOSE,-1 >STACK
	PUT STACK,0,1
	EQUAL? HERE,REACTOR-ELEVATOR /FALSE
	FCLEAR REACTOR-ELEVATOR-DOOR,OPENBIT
	EQUAL? HERE,REACTOR-CONTROL \?L3
	CRLF
	PRINTI "The elevator door slides shut."
	CRLF
?L3:	CALL INT,I-REACTOR-DOOR-CLOSE >STACK
	PUT STACK,0,0
	RTRUE

	.FUNCT FLASK-F
	EQUAL? PRSA,V?EXAMINE \?L1
	PRINTI "The flask has a wide mouth and looks large enough to hold one or two liters. It is made of glass, or perhaps some tough plastic"
	IN? CHEMICAL-FLUID,FLASK \?L5
	PRINTI ", and is filled with a milky white fluid"
?L5:	PRINTR "."
?L1:	EQUAL? PRSA,V?CLOSE \?L12
	CALL NO-CLOSE
	RTRUE
?L12:	EQUAL? PRSA,V?EMPTY \FALSE
	IN? CHEMICAL-FLUID,FLASK \FALSE
	EQUAL? PRSI,FUNNEL-HOLE \FALSE
	CALL PERFORM,V?POUR,CHEMICAL-FLUID,FUNNEL-HOLE
	RTRUE

	.FUNCT MAGNET-F
	EQUAL? PRSA,V?TAKE \?L1
	CALL QUEUE,I-MAGNET,-1 >STACK
	PUT STACK,0,1
	RFALSE
?L1:	EQUAL? PRSA,V?PUT-ON,V?ATTRACT \FALSE
	EQUAL? PRSO,MAGNET \?L4
	IN? MAGNET,ADVENTURER /?L4
	CALL NOT-HOLDING >STACK
	RSTACK
?L4:	FSET? KEY,TOUCHBIT \?L14
	EQUAL? PRSI,KEY \?L6
	MOVE KEY,ADVENTURER
	PRINTR "The key jumps against the ends of the magnet and sticks there. Proud of your feat, you remove the key from the magnet."
?L6:	FSET? KEY,TOUCHBIT /FALSE
?L14:	EQUAL? PRSI,KEY,CREVICE \FALSE
	MOVE KEY,ADVENTURER
	FCLEAR KEY,INVISIBLE
	FCLEAR KEY,TRYTAKEBIT
	FSET KEY,TOUCHBIT
	PRINTR "With a spray of dust and a loud clank, a piece of metal leaps from the crevice and affixes itself to the magnet. It is a steel key! With a tug, you remove the key from the magnet."

	.FUNCT I-MAGNET
	IN? MAGNET,ADVENTURER \?L1
	CALL HELD?,KITCHEN-CARD >STACK
	ZERO? STACK /?L3
	FSET KITCHEN-CARD,SCRAMBLEDBIT
	RFALSE
?L3:	CALL HELD?,SHUTTLE-CARD >STACK
	ZERO? STACK /?L5
	FSET SHUTTLE-CARD,SCRAMBLEDBIT
	RFALSE
?L5:	CALL HELD?,TELEPORTATION-CARD >STACK
	ZERO? STACK /?L6
	FSET TELEPORTATION-CARD,SCRAMBLEDBIT
	RFALSE
?L6:	CALL HELD?,UPPER-ELEVATOR-CARD >STACK
	ZERO? STACK /?L7
	FSET UPPER-ELEVATOR-CARD,SCRAMBLEDBIT
	RFALSE
?L7:	CALL HELD?,LOWER-ELEVATOR-CARD >STACK
	ZERO? STACK /?L8
	FSET LOWER-ELEVATOR-CARD,SCRAMBLEDBIT
	RFALSE
?L8:	CALL HELD?,MINI-CARD >STACK
	ZERO? STACK /?L9
	FSET MINI-CARD,SCRAMBLEDBIT
	RFALSE
?L9:	CALL HELD?,ID-CARD >STACK
	ZERO? STACK /FALSE
	FSET ID-CARD,SCRAMBLEDBIT
	RFALSE
?L1:	CALL INT,I-MAGNET >STACK
	PUT STACK,0,0
	RFALSE

	.FUNCT MACHINE-SHOP-F,RARG
	EQUAL? RARG,M-LOOK \?L1
	PRINTI "This room is probably some sort of machine shop filled with a variety of unusual machines. Doorways lead north, east, and west.

Standing against the rear wall is a large dispensing machine with a spout. "
	EQUAL? SPOUT-PLACED,GROUND /?L5
	PRINTI "Sitting under the spout is "
	FSET? SPOUT-PLACED,VOWELBIT \?L9
	PRINTI "an "
	JUMP ?L13
?L9:	PRINTI "a "
?L13:	PRINTD SPOUT-PLACED
	PRINTI ". "
?L5:	PRINTR "The dispenser is lined with brightly-colored buttons. The first four buttons, labelled ""KUULINTS 1 - 4"", are colored red, blue, green, and yellow. The next three buttons, labelled ""KATALISTS 1 - 3"", are colored gray, brown, and black. The last two buttons are both white. One of these is square and says ""BAAS."" The other white button is round and says ""ASID."""
?L1:	EQUAL? RARG,M-END \FALSE
	EQUAL? SPOUT-PLACED,GROUND \FALSE
	IN? FLOYD,HERE \FALSE
	FSET? FLOYD,RLANDBIT \FALSE
	RANDOM 100 >STACK
	LESS? 15,STACK /FALSE
	SET 'FLOYD-SPOKE,1
	PRINTR "Floyd pushes one of the dispenser buttons. Fluid pours from the spout and splashes across the floor. Floyd jumps up and down, giggling."

	.FUNCT CHEMICAL-DISPENSER-F
	EQUAL? PRSA,V?PUT-UNDER \FALSE
	EQUAL? PRSI,CHEMICAL-DISPENSER \FALSE
	EQUAL? SPOUT-PLACED,GROUND \?L3
	MOVE PRSO,HERE
	PRINTI "The "
	PRINTD PRSO
	PRINTI " is now sitting under the spout."
	CRLF
	SET 'SPOUT-PLACED,PRSO
	RETURN SPOUT-PLACED
?L3:	PRINTI "The "
	PRINTD SPOUT-PLACED
	PRINTR " is already resting under the spout."

	.FUNCT CHEM-BUTTON-F
	EQUAL? PRSA,V?PUSH \FALSE
	FSET? CHEMICAL-DISPENSER,MUNGEDBIT \?L3
	PRINTR "The machine coughs a few times, but nothing else happens."
?L3:	EQUAL? SPOUT-PLACED,FLASK \?L7
	IN? CHEMICAL-FLUID,FLASK \?L8
	PRINTR "Another dose of the chemical fluid pours out of the spout, splashes over the already-full flask, spills onto the floor, and dries up."
?L8:	MOVE CHEMICAL-FLUID,FLASK
	PRINTI "The flask fills with some "
	GETP PRSO,P?C-MOVE >CHEMICAL-FLAG
	GETP PRSO,P?C-MOVE >STACK
	GET COLOR-LTBL,STACK >STACK
	PRINT STACK
	PRINTR " chemical fluid. The fluid gradually turns milky white."
?L7:	EQUAL? SPOUT-PLACED,CANTEEN \?L19
	FSET? CANTEEN,OPENBIT \?L19
	PRINTR "Chemical fluid gushes from the spout. Unfortunately, the mouth of the canteen is very narrow, and the fluid just splashes over it."
?L19:	PRINTI "Some sort of chemical fluid pours out of the spout, spills all over the "
	PRINTD SPOUT-PLACED
	PRINTI ", and dries up."
	CRLF
	EQUAL? PRSO,ROUND-WHITE-BUTTON,SQUARE-WHITE-BUTTON \TRUE
	FSET? SPOUT-PLACED,ACIDBIT /?L27
	FSET? SPOUT-PLACED,MUNGBIT \TRUE
?L27:	SET 'CHEMICAL-FLAG,9
	CALL PERFORM,V?POUR,CHEMICAL-FLUID,SPOUT-PLACED
	RTRUE

	.FUNCT FLOYD-F,X,N
	EQUAL? FLOYD,WINNER \?L1
	SET 'FLOYD-SPOKE,1
	EQUAL? PRSA,V?GIVE \?L3
	EQUAL? PRSI,ME \?L3
	SET 'WINNER,ADVENTURER
	CALL PERFORM,V?ASK-FOR,FLOYD,PRSO
	RTRUE
?L3:	EQUAL? PRSA,V?SGIVE \?L5
	EQUAL? PRSO,ME \?L5
	SET 'WINNER,ADVENTURER
	CALL PERFORM,V?ASK-FOR,FLOYD,PRSI
	RTRUE
?L5:	EQUAL? PRSA,V?WALK \?L6
	EQUAL? HERE,REPAIR-ROOM \?L7
	EQUAL? PRSO,P?NORTH,P?IN \?L7
	CALL FLOYD-THROUGH-HOLE
	JUMP ?L13
?L7:	EQUAL? HERE,BIO-LOCK-EAST \?L9
	EQUAL? PRSO,P?EAST \?L9
	CALL FLOYD-INTO-LAB
	JUMP ?L13
?L9:	EQUAL? HERE,RADIATION-LOCK-EAST \?L10
	EQUAL? PRSO,P?EAST \?L10
	PRINTI """After you."""
	CRLF
	JUMP ?L13
?L10:	PRINTI "Floyd looks slightly embarrassed. ""You know me and my sense of direction."" Then he looks up at you with wide, trusting eyes. ""Tell Floyd a story?"""
	CRLF
?L13:	CALL FLUSH >STACK
	ZERO? STACK /TRUE
	RETURN 2
?L6:	EQUAL? PRSA,V?THROUGH \?L21
	CALL FLOYDS-FAMOUS-DOOR-ROUTINE
	CALL FLUSH >STACK
	ZERO? STACK /TRUE
	RETURN 2
?L21:	EQUAL? PRSA,V?TAKE \?L27
	EQUAL? PRSO,GOOD-BOARD \?L27
	IN? GOOD-BOARD,ROBOT-HOLE /?L28
	PRINTI "Floyd looks half-bored and half-annoyed. "
	PRINTR "Floyd already did that. How about some leap-frogger?"""
?L28:	ZERO? BOARD-REPORTED /?L32
	MOVE GOOD-BOARD,ADVENTURER
	FCLEAR GOOD-BOARD,NDESCBIT
	FSET GOOD-BOARD,TAKEBIT
	SET 'C-ELAPSED,22
	PRINTR "Floyd shrugs. ""If you say so."" He vanishes for a few minutes, and returns holding the fromitz board. It seems to be in good shape. He tosses it toward you, and you just manage to catch it before it smashes."
?L32:	PRINTR """Huh?"" asks Floyd. ""What fromitz board?"""
?L27:	EQUAL? PRSA,V?FOLLOW \?L38
	EQUAL? PRSO,ME \?L38
	PRINTR """Okay!"""
?L38:	EQUAL? PRSA,V?HELLO \?L41
	SET 'WINNER,ADVENTURER
	CALL PERFORM,V?HELLO,FLOYD
	RTRUE
?L41:	EQUAL? PRSA,V?DROP \?L42
	IN? PRSO,FLOYD \?L43
	RANDOM 100 >STACK
	LESS? 50,STACK /?L45
	MOVE PRSO,HERE
	PRINTI "Floyd shrugs and drops the "
	PRINTD PRSO
	PRINTR "."
?L45:	PRINTI "Floyd clutches the "
	PRINTD PRSO
	PRINTR " even more tightly. ""Floyd won't,"" he says defiantly."
?L43:	CALL FLOYD-NOT-HAVE >STACK
	RSTACK
?L42:	PRINTI "Floyd whines, ""Enough talking! Let's play Hider-and-Seeker."""
	CRLF
	RETURN 2
?L1:	EQUAL? PRSA,V?CLOSE \?L58
	PRINTR "Huh?"
?L58:	EQUAL? PRSA,V?REACH,V?LOOK-INSIDE \?L61
	CALL PERFORM,V?OPEN,FLOYD
	RTRUE
?L61:	FSET? FLOYD,RLANDBIT \?L62
	SET 'FLOYD-SPOKE,1
	EQUAL? PRSA,V?LAMP-ON \?L63
	PRINTR "He's already been activated."
?L63:	EQUAL? PRSA,V?LAMP-OFF \?L67
	FCLEAR FLOYD,RLANDBIT
	FCLEAR FLOYD,ACTORBIT
	CALL INT,I-FLOYD >STACK
	PUT STACK,0,0
	PRINTI "Floyd, shocked by this betrayal from his new-found friend, whimpers and keels over"
	FIRST? FLOYD >STACK \?L70
	PRINTI ", dropping what he was carrying."
	CRLF
	JUMP ?L74
?L70:	PRINTI "."
	CRLF
?L74:	FIRST? FLOYD >X /?L192
	RTRUE
?L77:	ZERO? X /TRUE
?L192:	NEXT? X >N /?L82
?L82:	MOVE X,HERE
	SET 'X,N
	JUMP ?L77
?L67:	EQUAL? PRSA,V?EXAMINE \?L84
	PRINTR "From its design, the robot seems to be of the multi-purpose sort. It is slightly cross-eyed, and its mechanical mouth forms a lopsided grin."
?L84:	EQUAL? PRSA,V?KISS \?L87
	PRINTR "You receive a painful electric shock."
?L87:	EQUAL? PRSA,V?SCOLD \?L90
	PRINTR "Floyd looks defensive. ""What did Floyd do wrong?"""
?L90:	EQUAL? PRSA,V?PLAY-WITH \?L93
	SET 'C-ELAPSED,30
	CALL QUEUE,I-FLOYD,1 >STACK
	PUT STACK,0,1
	PRINTR "You play with Floyd for several centichrons until you drop to the floor, exhausted. Floyd pokes at you gleefully. ""C'mon! Let's play some more!"""
?L93:	EQUAL? PRSA,V?LISTEN \?L96
	PRINTR "Floyd is babbling about this and that."
?L96:	EQUAL? PRSA,V?TAKE \?L99
	EQUAL? PRSO,FLOYD \?L99
	PRINTR "You manage to lift Floyd a few inches off the ground, but he is too heavy and you drop him suddenly. Floyd gives a surprised squeal and moves a respectable distance away."
?L99:	EQUAL? PRSA,V?MUNG,V?ATTACK \?L102
	PRINTR "Floyd starts dashing around the room. ""Oh boy oh boy oh boy! I haven't played Chase and Tag for years! You be It! Nah, nah!"""
?L102:	EQUAL? PRSA,V?SHAKE,V?KICK \?L105
	PRINTR """Why you do that?"" Floyd whines. ""I think a wire now shaken loose."" He goes off into a corner and sulks."
?L105:	EQUAL? PRSA,V?TALK,V?HELLO \?L108
	PRINTR """Hi!"" Floyd grins and bounces up and down."
?L108:	EQUAL? PRSA,V?OPEN,V?SCRUB,V?SEARCH \?L111
	PRINTR "Floyd giggles and pushes you away. ""You're tickling Floyd!"" He clutches at his side panels, laughing hysterically. Oil drops stream from his eyes."
?L111:	EQUAL? PRSA,V?PUT,V?GIVE \?L114
	EQUAL? FLOYD,PRSI \?L114
	EQUAL? PRSO,LAZARUS-PART \?L115
	REMOVE FLOYD
	SET 'FLOYD-FOLLOW,0
	MOVE LAZARUS-PART,HERE
	CALL QUEUE,I-FLOYD,40 >STACK
	PUT STACK,0,1
	PRINTR "At first, Floyd is all grins because of your gift. Then, he realizes what it is, begins weeping, drops the breastplate, and rushes out of the room."
?L115:	EQUAL? PRSO,RED-GOO,GREEN-GOO,BROWN-GOO \?L119
	PRINTR "Floyd looks at the goo. ""Yech! Got any Number Seven Heavy Grease?"""
?L119:	FIRST? FLOYD >STACK /?L123
	RANDOM 100 >STACK
	LESS? 25,STACK /?L122
?L123:	MOVE PRSO,HERE
	PRINTI "Floyd examines the "
	PRINTD PRSO
	PRINTI ", shrugs, and drops "
	EQUAL? PRSO,PLIERS \?L126
	PRINTR "them."
?L126:	PRINTR "it."
?L122:	MOVE PRSO,FLOYD
	PRINTR """Neat!"" exclaims Floyd. He thanks you profusely."
?L114:	EQUAL? PRSA,V?SHOW \?L136
	EQUAL? FLOYD,PRSI \?L136
	EQUAL? PRSO,PRINT-OUT \?L137
	ZERO? COMPUTER-FLAG \?L137
	CALL COMPUTER-ACTION >STACK
	RSTACK
?L137:	EQUAL? PRSO,ROBOT-HOLE \?L139
	CALL FLOYD-THROUGH-HOLE >STACK
	RSTACK
?L139:	EQUAL? HERE,REC-AREA \?L140
	EQUAL? PRSO,PSEUDO-OBJECT \?L140
	PRINTR """Too intellectual for Floyd. Any paddleball sets around?"""
?L140:	EQUAL? PRSO,ID-CARD,SHUTTLE-CARD /?L144
	EQUAL? PRSO,KITCHEN-CARD,UPPER-ELEVATOR-CARD \?L143
?L144:	PRINTR "Floyd scratches his head. ""Aren't those things usually blue?"""
?L143:	EQUAL? PRSO,LOWER-ELEVATOR-CARD \?L147
	ZERO? CARD-REVEALED \?L147
	SET 'CARD-REVEALED,1
	PRINTR """I've got one just like that!"" says Floyd. He looks through several of his compartments, then glances at you suspiciously."
?L147:	PRINTI "Floyd looks over the "
	PRINTD PRSO
	PRINTR ". ""Can you play any games with it?"" he asks."
?L136:	EQUAL? PRSA,V?RUB \?L153
	PRINTR "Floyd gives a contented sigh."
?L153:	EQUAL? PRSA,V?SMELL \?L156
	PRINTR "Floyd smells faintly of ozone and light machine oil."
?L156:	EQUAL? PRSA,V?ASK-FOR \FALSE
	IN? PRSI,FLOYD \?L160
	MOVE PRSI,ADVENTURER
	PRINTI """Okay,"" says Floyd, handing you the "
	PRINTD PRSI
	PRINTR ", ""but only because you're Floyd's best friend."""
?L160:	CALL FLOYD-NOT-HAVE >STACK
	RSTACK
?L62:	EQUAL? PRSA,V?LAMP-ON \?L167
	ZERO? FLOYD-INTRODUCED /?L169
	CALL QUEUE,I-FLOYD,-1 >STACK
	PUT STACK,0,1
	RTRUE
?L169:	CALL QUEUE,I-FLOYD,25 >STACK
	PUT STACK,0,1
	PRINTI "Nothing happens."
	CRLF
	ZERO? FLOYD-SCORE-FLAG \TRUE
	SET 'FLOYD-SCORE-FLAG,1
	ADD SCORE,2 >SCORE
	RTRUE
?L167:	EQUAL? PRSA,V?LAMP-OFF \?L177
	PRINTR "The robot doesn't seem to be on."
?L177:	EQUAL? PRSA,V?EXAMINE \?L180
	PRINTR "The de-activated robot is leaning against the wall, its head lolling to the side. It is short, and seems to be equipped for general-purpose work. It has apparently been turned off."
?L180:	EQUAL? PRSA,V?OPEN,V?SEARCH \FALSE
	ZERO? CARD-REVEALED \?L184
	ZERO? CARD-STOLEN \?L184
	FCLEAR LOWER-ELEVATOR-CARD,INVISIBLE
	MOVE LOWER-ELEVATOR-CARD,ADVENTURER
	CALL SCORE-OBJ,LOWER-ELEVATOR-CARD
	SET 'CARD-STOLEN,1
	PRINTR "In one of the robot's compartments you find and take a magnetic-striped card embossed ""Loowur Elavaatur Akses Kard."""
?L184:	PRINTR "Your search discovers nothing in the robot's compartments except a single crayon which you leave where you found it."

	.FUNCT FLOYDS-FAMOUS-DOOR-ROUTINE
	EQUAL? PRSO,ROBOT-HOLE \?L1
	CALL FLOYD-THROUGH-HOLE >STACK
	RSTACK
?L1:	EQUAL? PRSO,BIO-DOOR-EAST \?L3
	CALL FLOYD-INTO-LAB >STACK
	RSTACK
?L3:	FSET? PRSO,DOORBIT \?L4
	PRINTR """You go first,"" says Floyd."
?L4:	PRINTR "Floyd scratches his head and looks at you."

	.FUNCT FLUSH
	ZERO? P-CONT /FALSE
	SET 'P-CONT,0
	CRLF
	PRINTR "Floyd scratches his head and looks at you. ""What else were you saying to Floyd? I can't remember."""

	.FUNCT FLOYD-INTO-LAB
	ZERO? FLOYD-WAITING /?L1
	PRINTR """As soon as you open the door, dummy."""
?L1:	PRINTR """Are you kidding? Floyd not going in THERE without a good reason."""

	.FUNCT FLOYD-NOT-HAVE
	PRINTR """Floyd does not one of those have!"""

	.FUNCT FLOYD-COMES-ALIVE,FOO
	IN? FLOYD,HERE \?L7
	ZERO? FLOYD-REACTIVATED /?L3
	SET 'FLOYD-SPOKE,1
	PRINTI "Floyd jumps to his feet, hopping mad. ""Why you turn Floyd off?"" he asks accusingly."
	CRLF
	JUMP ?L7
?L3:	SET 'FLOYD-INTRODUCED,1
	SET 'FLOYD-SPOKE,1
	PRINTI "Suddenly, the robot comes to life and its head starts swivelling about. It notices you and bounds over. ""Hi! I'm B-19-7, but to everyperson I'm called Floyd. Are you a doctor-person or a planner-person? "
	FIRST? ADVENTURER >FOO \?L10
	PRINTI "That's a nice "
	PRINTD FOO
	PRINTI " you are having there. "
?L10:	PRINTI "Let's play Hider-and-Seeker you with me."""
	CRLF
?L7:	FSET FLOYD,RLANDBIT
	FSET FLOYD,ACTORBIT
	FSET FLOYD,TOUCHBIT
	SET 'FLOYD-REACTIVATED,1
	RETURN FLOYD-REACTIVATED

	.FUNCT I-FLOYD
	CALL QUEUE,I-FLOYD,-1 >STACK
	PUT STACK,0,1
	FSET? FLOYD,RLANDBIT /?L1
	FSET FLOYD,ACTORBIT
	CRLF
	CALL FLOYD-COMES-ALIVE
	JUMP ?L85
?L1:	IN? FLOYD,HERE \?L3
	ZERO? FLOYD-INTRODUCED \?L4
	SET 'FLOYD-INTRODUCED,1
	CRLF
	PRINTI "The robot, now apparently active, notices you enter. ""Hi,"" he says. ""I'm Floyd!"""
	CRLF
	JUMP ?L85
?L4:	ZERO? FLOYD-FOLLOW /?L8
	FSET? HERE,FLOYDBIT \?L8
	RANDOM 100 >STACK
	LESS? 6,STACK /?L8
	REMOVE FLOYD
	SET 'FLOYD-FOLLOW,0
	CRLF
	PRINTI "Floyd says ""Floyd going exploring. See you later."" He glides out of the room."
	CRLF
	JUMP ?L85
?L8:	SET 'FLOYD-FOLLOW,1
	RANDOM 100 >STACK
	LESS? 40,STACK /?L85
	ZERO? FLOYD-SPOKE \?L85
	PRINTI "Floyd "
	CALL PICK-ONE,FLOYDISMS >STACK
	PRINT STACK
	PRINTR "."
?L3:	ZERO? FLOYD-FOLLOW /?L22
	RANDOM 100 >STACK
	LESS? 80,STACK /?L22
	IN? LAZARUS-PART,HERE \?L24
	SET 'FLOYD-FOLLOW,0
	CRLF
	PRINTR "Floyd starts to follow you but notices the Lazarus breast plate. He sniffs and leaves the room."
?L24:	MOVE FLOYD,HERE
	PRINTI "Floyd follows you."
	CRLF
	CALL KLUDGE
	JUMP ?L85
?L22:	SET 'FLOYD-FOLLOW,0
	EQUAL? HERE,BOOTH-1,BOOTH-2,BOOTH-3 \?L32
	MOVE FLOYD,HERE
	ZERO? FLOYD-INTRODUCED \?L34
	CRLF
	CALL CALL-ME-FLOYD
	RTRUE
?L34:	CRLF
	PRINTI "Floyd scampers into the booth. ""Oooo, this is a tiny room,"" he remarks."
	CRLF
	JUMP ?L85
?L32:	EQUAL? HERE,BIO-LOCK-EAST,BIO-LOCK-WEST \?L41
	ZERO? FLOYD-GAVE-UP /?L40
?L41:	EQUAL? HERE,RADIATION-LOCK-EAST,RADIATION-LOCK-WEST \?L39
?L40:	MOVE FLOYD,HERE
	ZERO? FLOYD-INTRODUCED \?L42
	CRLF
	CALL CALL-ME-FLOYD
	RTRUE
?L42:	CRLF
	PRINTI "Floyd glides after you. ""Is this...is this a squash court?"" he asks."
	CRLF
	JUMP ?L85
?L39:	EQUAL? HERE,ALFIE-CONTROL-EAST,ALFIE-CONTROL-WEST,BETTY-CONTROL-EAST /?L48
	EQUAL? HERE,BETTY-CONTROL-WEST,UPPER-ELEVATOR,LOWER-ELEVATOR /?L48
	EQUAL? HERE,REACTOR-ELEVATOR /?L48
	EQUAL? HERE,MESS-HALL \?L47
	IN? FLOYD,KITCHEN \?L47
?L48:	MOVE FLOYD,HERE
	ZERO? FLOYD-INTRODUCED \?L49
	CRLF
	CALL CALL-ME-FLOYD
	RTRUE
?L49:	CRLF
	PRINTI "Floyd bounces into the "
	EQUAL? HERE,UPPER-ELEVATOR,LOWER-ELEVATOR,REACTOR-ELEVATOR \?L54
	PRINTI "elevator"
	JUMP ?L61
?L54:	EQUAL? HERE,MESS-HALL \?L58
	PRINTI "room"
	JUMP ?L61
?L58:	PRINTI "cabin"
?L61:	PRINTI ". ""Hey, wait for Floyd!"" he yells, smiling broadly."
	CRLF
	JUMP ?L85
?L47:	EQUAL? HERE,MINI-BOOTH \?L66
	MOVE FLOYD,HERE
	ZERO? FLOYD-INTRODUCED \?L67
	CRLF
	CALL CALL-ME-FLOYD
	RTRUE
?L67:	CRLF
	PRINTI """Hi,"" whispers Floyd, tiptoeing in. ""Are we going to teleport into the computer like Achilles always used to do?"""
	CRLF
	JUMP ?L85
?L66:	RANDOM 100 >STACK
	LESS? 30,STACK /?L85
	EQUAL? HERE,INFIRMARY \?L73
	ZERO? LAZARUS-FLAG \FALSE
?L73:	MOVE FLOYD,HERE
	ZERO? FLOYD-INTRODUCED /?L76
	RANDOM 100 >STACK
	LESS? 15,STACK /?L78
	IN? ADVENTURER,BED /?L78
	CRLF
	PRINTI "Floyd rushes into the room and barrels into you. ""Oops, sorry,"" he says. ""Floyd not looking at where he was going to."""
	CRLF
	JUMP ?L82
?L78:	CRLF
	PRINTI "Floyd bounds into the room. ""Floyd here now!"" he cries."
	CRLF
?L82:	CALL KLUDGE
	JUMP ?L85
?L76:	CRLF
	CALL CALL-ME-FLOYD
?L85:	SET 'FLOYD-SPOKE,0
	RETURN FLOYD-SPOKE

	.FUNCT CALL-ME-FLOYD
	SET 'FLOYD-INTRODUCED,1
	PRINTR "The robot you were fiddling with in the Robot Shop bounds into the room. ""Hi!"" he says, with a wide and friendly smile. ""You turn Floyd on? Be Floyd's friend, yes?"""

	.FUNCT KLUDGE
	EQUAL? HERE,REPAIR-ROOM \?L1
	ZERO? ACHILLES-FLAG \?L1
	SET 'ACHILLES-FLAG,1
	SET 'FLOYD-SPOKE,1
	PRINTR "Floyd points at the fallen robot. ""That's Achilles. He was in charge of repairing machinery. He repaired Floyd once. I never liked him much; he wasn't friendly like other robots. Looks like he fell down the stairs. He always had trouble with one of his feet working right. A Planner-person once told me that's why they named him Achilles."""
?L1:	EQUAL? HERE,COMPUTER-ROOM \FALSE
	ZERO? COMPUTER-FLAG \FALSE
	CALL COMPUTER-ACTION >STACK
	RSTACK

	.FUNCT DEAD-FLOYD-F
	EQUAL? PRSA,V?EXAMINE \?L1
	PRINTR "You turn to look at Floyd, but a tremendous sense of loss overcomes you, and you turn away."
?L1:	EQUAL? PRSA,V?LAMP-ON \?L5
	PRINTR "As you touch Floyd's on-off switch, it falls off in your hands."
?L5:	EQUAL? PRSA,V?LAMP-OFF \FALSE
	PRINTR "I'm afraid that Floyd has already been turned off, permanently, and gone to that great robot shop in the sky."

	.FUNCT ELEVATOR-LOBBY-F,RARG
	EQUAL? RARG,M-LOOK \FALSE
	PRINTI "This is a wide, brightly lit lobby. A blue metal door to the north is "
	FSET? UPPER-ELEVATOR-DOOR,OPENBIT \?L5
	ZERO? UPPER-ELEVATOR-UP \?L5
	PRINTI "open"
	JUMP ?L9
?L5:	PRINTI "closed"
?L9:	PRINTI " and a larger red metal door to the south is "
	FSET? LOWER-ELEVATOR-DOOR,OPENBIT \?L14
	EQUAL? LOWER-ELEVATOR-UP,1 \?L14
	FSET? UPPER-ELEVATOR-DOOR,OPENBIT \?L16
	ZERO? UPPER-ELEVATOR-UP \?L16
	PRINTI "also "
?L16:	PRINTI "open"
	JUMP ?L23
?L14:	FSET? UPPER-ELEVATOR-DOOR,OPENBIT \?L26
	EQUAL? UPPER-ELEVATOR-UP,1 \?L24
?L26:	PRINTI "also "
?L24:	PRINTI "closed"
?L23:	PRINTR ". Beside the blue door is a blue button, and beside the red door is a red button. A corridor leads west. To the east is a small room about the size of a telephone booth."

	.FUNCT UPPER-ELEVATOR-F,RARG
	EQUAL? RARG,M-LOOK \?L1
	PRINTI "You have entered a tiny room with a sliding door to the south which is "
	CALL DDESC,UPPER-ELEVATOR-DOOR
	PRINTR ". A control panel contains an Up button, a Down button, and a narrow slot."
?L1:	EQUAL? RARG,M-END \FALSE
	FSET? UPPER-ELEVATOR-DOOR,OPENBIT /FALSE
	RANDOM 100 >STACK
	LESS? 10,STACK /FALSE
	PRINTR "Some innocuous Hawaiian music oozes from the elevator's intercom."

	.FUNCT LOWER-ELEVATOR-F,RARG
	EQUAL? RARG,M-LOOK \FALSE
	PRINTI "This is a medium-sized room with a door to the north which is "
	CALL DDESC,LOWER-ELEVATOR-DOOR
	PRINTR ". A control panel contains an Up button, a Down button, and a narrow slot."

	.FUNCT ELEVATOR-ENTER-F
	EQUAL? PRSO,P?NORTH \?L1
	FSET? UPPER-ELEVATOR-DOOR,OPENBIT \?L3
	ZERO? UPPER-ELEVATOR-UP \?L3
	RETURN UPPER-ELEVATOR
?L3:	CALL DOOR-CLOSED
	RFALSE
?L1:	EQUAL? PRSO,P?SOUTH \FALSE
	FSET? LOWER-ELEVATOR-DOOR,OPENBIT \?L7
	EQUAL? LOWER-ELEVATOR-UP,1 \?L7
	RETURN LOWER-ELEVATOR
?L7:	CALL DOOR-CLOSED
	RFALSE

	.FUNCT ELEVATOR-EXIT-F
	EQUAL? HERE,UPPER-ELEVATOR \?L1
	FSET? UPPER-ELEVATOR-DOOR,OPENBIT \?L3
	EQUAL? UPPER-ELEVATOR-UP,1 \?L5
	RETURN TOWER-CORE
?L5:	RETURN ELEVATOR-LOBBY
?L3:	CALL DOOR-CLOSED
	RFALSE
?L1:	EQUAL? HERE,LOWER-ELEVATOR \FALSE
	FSET? LOWER-ELEVATOR-DOOR,OPENBIT \?L10
	EQUAL? LOWER-ELEVATOR-UP,1 \?L12
	RETURN ELEVATOR-LOBBY
?L12:	RETURN WAITING-AREA
?L10:	CALL DOOR-CLOSED
	RFALSE

	.FUNCT UPPER-ELEVATOR-DOOR-F
	EQUAL? PRSA,V?OPEN \?L1
	FSET? UPPER-ELEVATOR-DOOR,OPENBIT \?L3
	CALL ALREADY-OPEN >STACK
	RSTACK
?L3:	PRINTR "It won't budge."
?L1:	EQUAL? PRSA,V?CLOSE \FALSE
	FSET? UPPER-ELEVATOR-DOOR,OPENBIT \?L9
	PRINTR "You can't close it yourself."
?L9:	CALL IS-CLOSED >STACK
	RSTACK

	.FUNCT LOWER-ELEVATOR-DOOR-F
	EQUAL? PRSA,V?OPEN \?L1
	FSET? LOWER-ELEVATOR-DOOR,OPENBIT \?L5
	EQUAL? HERE,ELEVATOR-LOBBY \?L3
	EQUAL? LOWER-ELEVATOR-UP,1 \?L3
	CALL ALREADY-OPEN >STACK
	RSTACK
?L3:	FSET? LOWER-ELEVATOR-DOOR,OPENBIT \?L5
	EQUAL? HERE,WAITING-AREA \?L5
	ZERO? LOWER-ELEVATOR-UP \?L5
	CALL ALREADY-OPEN >STACK
	RSTACK
?L5:	PRINTR "It won't budge."
?L1:	EQUAL? PRSA,V?CLOSE \FALSE
	FSET? LOWER-ELEVATOR-DOOR,OPENBIT \?L14
	EQUAL? HERE,ELEVATOR-LOBBY \?L10
	EQUAL? LOWER-ELEVATOR-UP,1 \?L10
	PRINTR "You can't close it yourself."
?L10:	FSET? LOWER-ELEVATOR-DOOR,OPENBIT \?L14
	EQUAL? HERE,WAITING-AREA \?L14
	ZERO? LOWER-ELEVATOR-UP \?L14
	PRINTR "You can't close it yourself."
?L14:	CALL IS-CLOSED >STACK
	RSTACK

	.FUNCT DOOR-CLOSED
	PRINTR "The door is closed."

	.FUNCT BLUE-ELEVATOR-BUTTON-F
	EQUAL? PRSA,V?PUSH \FALSE
	EQUAL? UPPER-ELEVATOR-UP,1 \FALSE
	CALL INT,I-UPPER-ELEVATOR-ARRIVE >STACK
	GET STACK,C-ENABLED? >STACK
	EQUAL? STACK,1 \?L3
	PRINTR "Patience, patience..."
?L3:	RANDOM 20 >STACK
	ADD STACK,40 >STACK
	CALL QUEUE,I-UPPER-ELEVATOR-ARRIVE,STACK >STACK
	PUT STACK,0,1
	PRINTR "You hear a faint whirring noise from behind the blue door."

	.FUNCT RED-ELEVATOR-BUTTON-F
	EQUAL? PRSA,V?PUSH \FALSE
	ZERO? LOWER-ELEVATOR-UP \FALSE
	CALL INT,I-LOWER-ELEVATOR-ARRIVE >STACK
	GET STACK,C-ENABLED? >STACK
	EQUAL? STACK,1 \?L3
	PRINTR "Patience, patience..."
?L3:	RANDOM 40 >STACK
	ADD STACK,80 >STACK
	CALL QUEUE,I-LOWER-ELEVATOR-ARRIVE,STACK >STACK
	PUT STACK,0,1
	PRINTR "The red door begins vibrating a bit."

	.FUNCT I-UPPER-ELEVATOR-ARRIVE
	FSET UPPER-ELEVATOR-DOOR,OPENBIT
	SET 'UPPER-ELEVATOR-UP,0
	CALL INT,I-UPPER-ELEVATOR-ARRIVE >STACK
	PUT STACK,0,0
	EQUAL? HERE,ELEVATOR-LOBBY \FALSE
	CRLF
	PRINTR "The door at the north end of the room slides open."

	.FUNCT I-LOWER-ELEVATOR-ARRIVE
	FSET LOWER-ELEVATOR-DOOR,OPENBIT
	SET 'LOWER-ELEVATOR-UP,1
	CALL INT,I-LOWER-ELEVATOR-ARRIVE >STACK
	PUT STACK,0,0
	EQUAL? HERE,ELEVATOR-LOBBY \FALSE
	CRLF
	PRINTR "The door at the south end of the room slides open."

	.FUNCT ELEVATOR-BUTTON-F
	EQUAL? PRSA,V?PUSH-UP \?L1
	EQUAL? HERE,LOWER-ELEVATOR \?L3
	ZERO? LOWER-ELEVATOR-UP \?L3
	EQUAL? LOWER-ELEVATOR-ON,1 \?L3
	ZERO? ELEVATOR-IN-TRANSIT \?L3
	PRINT ELEVATOR-STARTS
	CRLF
	FCLEAR LOWER-ELEVATOR-DOOR,OPENBIT
	SET 'ELEVATOR-IN-TRANSIT,1
	CALL QUEUE,I-LOWER-ELEVATOR-TRIP,100 >STACK
	PUT STACK,0,1
	RTRUE
?L3:	EQUAL? HERE,UPPER-ELEVATOR \?L7
	ZERO? UPPER-ELEVATOR-UP \?L7
	EQUAL? UPPER-ELEVATOR-ON,1 \?L7
	ZERO? ELEVATOR-IN-TRANSIT \?L7
	PRINT ELEVATOR-STARTS
	CRLF
	FCLEAR UPPER-ELEVATOR-DOOR,OPENBIT
	SET 'ELEVATOR-IN-TRANSIT,1
	CALL QUEUE,I-UPPER-ELEVATOR-TRIP,50 >STACK
	PUT STACK,0,1
	RTRUE
?L7:	PRINTR "Nothing happens."
?L1:	EQUAL? PRSA,V?PUSH-DOWN \?L13
	EQUAL? HERE,LOWER-ELEVATOR \?L14
	EQUAL? LOWER-ELEVATOR-UP,1 \?L14
	EQUAL? LOWER-ELEVATOR-ON,1 \?L14
	ZERO? ELEVATOR-IN-TRANSIT \?L14
	PRINT ELEVATOR-STARTS
	CRLF
	FCLEAR LOWER-ELEVATOR-DOOR,OPENBIT
	SET 'ELEVATOR-IN-TRANSIT,1
	CALL QUEUE,I-LOWER-ELEVATOR-TRIP,100 >STACK
	PUT STACK,0,1
	RTRUE
?L14:	EQUAL? HERE,UPPER-ELEVATOR \?L18
	EQUAL? UPPER-ELEVATOR-UP,1 \?L18
	EQUAL? UPPER-ELEVATOR-ON,1 \?L18
	ZERO? ELEVATOR-IN-TRANSIT \?L18
	PRINT ELEVATOR-STARTS
	CRLF
	FCLEAR UPPER-ELEVATOR-DOOR,OPENBIT
	SET 'ELEVATOR-IN-TRANSIT,1
	CALL QUEUE,I-UPPER-ELEVATOR-TRIP,50 >STACK
	PUT STACK,0,1
	RTRUE
?L18:	PRINTR "Nothing happens."
?L13:	EQUAL? PRSA,V?PUSH \FALSE
	PRINTR "You must specify whether you want to push the Up button or the Down button."

	.FUNCT I-TURNOFF-UPPER-ELEVATOR
	ZERO? ELEVATOR-IN-TRANSIT /?L1
	CALL QUEUE,I-TURNOFF-UPPER-ELEVATOR,120 >STACK
	PUT STACK,0,1
	RFALSE
?L1:	SET 'UPPER-ELEVATOR-ON,0
	EQUAL? HERE,UPPER-ELEVATOR \FALSE
	CRLF
	PRINT ELEVATOR-LIGHT-OFF
	CRLF
	RFALSE

	.FUNCT I-TURNOFF-LOWER-ELEVATOR
	ZERO? ELEVATOR-IN-TRANSIT /?L1
	CALL QUEUE,I-TURNOFF-LOWER-ELEVATOR,120 >STACK
	PUT STACK,0,1
	RFALSE
?L1:	SET 'LOWER-ELEVATOR-ON,0
	EQUAL? HERE,LOWER-ELEVATOR \FALSE
	CRLF
	PRINT ELEVATOR-LIGHT-OFF
	CRLF
	RFALSE

	.FUNCT I-UPPER-ELEVATOR-TRIP
	EQUAL? UPPER-ELEVATOR-UP,1 \?L1
	SET 'UPPER-ELEVATOR-UP,0
	SET 'ELEVATOR-IN-TRANSIT,0
	FSET UPPER-ELEVATOR-DOOR,OPENBIT
	CRLF
	CALL ELEVATOR-DOOR-OPENS >STACK
	RSTACK
?L1:	SET 'UPPER-ELEVATOR-UP,1
	SET 'ELEVATOR-IN-TRANSIT,0
	FSET UPPER-ELEVATOR-DOOR,OPENBIT
	CRLF
	CALL ELEVATOR-DOOR-OPENS >STACK
	RSTACK

	.FUNCT I-LOWER-ELEVATOR-TRIP
	EQUAL? LOWER-ELEVATOR-UP,1 \?L1
	SET 'LOWER-ELEVATOR-UP,0
	SET 'ELEVATOR-IN-TRANSIT,0
	FSET LOWER-ELEVATOR-DOOR,OPENBIT
	CRLF
	CALL ELEVATOR-DOOR-OPENS >STACK
	RSTACK
?L1:	SET 'LOWER-ELEVATOR-UP,1
	SET 'ELEVATOR-IN-TRANSIT,0
	FSET LOWER-ELEVATOR-DOOR,OPENBIT
	CRLF
	CALL ELEVATOR-DOOR-OPENS >STACK
	RSTACK

	.FUNCT ELEVATOR-DOOR-OPENS
	PRINTR "The elevator door slides open."

	.FUNCT HELICOPTER-OBJECT-F
	EQUAL? PRSA,V?WALK-TO,V?BOARD,V?THROUGH \?L1
	EQUAL? HERE,HELIPAD \?L3
	CALL GOTO,HELICOPTER >STACK
	RSTACK
?L3:	PRINTR "You're in it!"
?L1:	EQUAL? PRSA,V?DISEMBARK,V?DROP,V?EXIT \?L8
	EQUAL? HERE,HELICOPTER \?L9
	CALL GOTO,HELIPAD >STACK
	RSTACK
?L9:	PRINTR "You're not in it!"
?L8:	EQUAL? PRSA,V?FLY \FALSE
	EQUAL? HERE,HELICOPTER \?L15
	PRINTR "The controls seem to be locked."
?L15:	PRINTR "You're not even in it!"

	.FUNCT COMM-ROOM-F,RARG
	EQUAL? RARG,M-LOOK \?L1
	PRINTI "This is a small room with no windows. The sole exit is southwest. Two wide consoles fill either end of the room; thick cables lead up into the ceiling.

The console on the left side of the room is labelled ""Reeseev Staashun."" A bright red light, labelled ""Tranzmishun Reeseevd"", is blinking rapidly. Next to the light is a glowing button marked ""Mesij Plaabak.""

The console on the right side of the room is labelled ""Send Staashun."" A screen on the console displays a message. Next to the screen is a flashing sign which says "
	ZERO? COMM-SHUTDOWN /?L5
	CALL SHUTDOWN
	JUMP ?L10
?L5:	ZERO? COMM-FIXED /?L7
	PRINTI """Tranzmishun in pragres."""
	JUMP ?L10
?L7:	PRINTI """Malfunkshun in Sendeeng Kuulint Sistum."""
?L10:	PRINTI " Next to this console is an enunciator"
	ZERO? COMM-FIXED \?L17
	ZERO? COMM-SHUTDOWN /?L15
?L17:	PRINTI " whose lights are all dark"
?L15:	PRINTR ". On the console next to the enunciator panel is a funnel-shaped hole labelled ""Kuulint Sistum Manyuuwul Oovuriid."""
?L1:	EQUAL? RARG,M-END \FALSE
	ZERO? COMM-FIXED \FALSE
	ZERO? COMM-SHUTDOWN \FALSE
	ZERO? JUST-ENTERED /FALSE
	CALL QUEUE,I-UNENTER,-1 >STACK
	PUT STACK,0,1
	SET 'JUST-ENTERED,0
	PRINTI "A "
	EQUAL? CHEMICAL-REQUIRED,1 \?L26
	PRINTI "red"
	JUMP ?L45
?L26:	EQUAL? CHEMICAL-REQUIRED,2 \?L30
	PRINTI "blue"
	JUMP ?L45
?L30:	EQUAL? CHEMICAL-REQUIRED,3 \?L33
	PRINTI "green"
	JUMP ?L45
?L33:	EQUAL? CHEMICAL-REQUIRED,4 \?L36
	PRINTI "yellow"
	JUMP ?L45
?L36:	EQUAL? CHEMICAL-REQUIRED,5 \?L39
	PRINTI "gray"
	JUMP ?L45
?L39:	EQUAL? CHEMICAL-REQUIRED,6 \?L42
	PRINTI "brown"
	JUMP ?L45
?L42:	EQUAL? CHEMICAL-REQUIRED,7 \?L45
	PRINTI "black"
?L45:	PRINTR " colored light is flashing on the enunciator panel."

	.FUNCT I-UNENTER
	EQUAL? HERE,COMM-ROOM /FALSE
	SET 'JUST-ENTERED,1
	CALL INT,I-UNENTER >STACK
	PUT STACK,0,0
	RFALSE

	.FUNCT PLAYBACK-BUTTON-F
	EQUAL? PRSA,V?PUSH \FALSE
	PRINTR "A voice fills the room ... the voice of the Feinstein's communications officer! ""Stellar Patrol Ship Feinstein to planetside ... Please respond on frequency 48.5 ... SPS Feinstein to planetside ... Please come in ..."" After a pause you hear the officer, in a quieter voice, say ""Admiral, no response on any of the standard frequen..."" The sentence is cut short by the sound of an explosion and a loud burst of static, followed by silence."

	.FUNCT RANDOMIZE-ORDER,COUNT=0,TEMP
?L1:	IGRTR? 'COUNT,7 /?L2
	PUT ORDER-LTBL,COUNT,0
	JUMP ?L1
?L2:	SET 'COUNT,0
?L6:	IGRTR? 'COUNT,7 /TRUE
	RANDOM 7 >TEMP
	GET ORDER-LTBL,3 >STACK
	GET ORDER-LTBL,2 >STACK
	GET ORDER-LTBL,1 >STACK
	EQUAL? TEMP,STACK,STACK,STACK /?L13
	GET ORDER-LTBL,6 >STACK
	GET ORDER-LTBL,5 >STACK
	GET ORDER-LTBL,4 >STACK
	EQUAL? TEMP,STACK,STACK,STACK /?L13
	GET ORDER-LTBL,7 >STACK
	EQUAL? TEMP,STACK \?L11
?L13:	DEC 'COUNT
	JUMP ?L6
?L11:	PUT ORDER-LTBL,COUNT,TEMP
	JUMP ?L6

	.FUNCT CHEMICAL-FLUID-F
	EQUAL? PRSA,V?EAT \?L1
	CALL JIGS-UP,STR?96 >STACK
	RSTACK
?L1:	EQUAL? PRSA,V?PUT \?L3
	EQUAL? PRSI,CHEMICAL-FLUID \?L3
	CALL PERFORM,V?PUT,PRSO,FLASK
	RTRUE
?L3:	EQUAL? PRSA,V?POUR,V?THROW \?L4
	EQUAL? PRSI,RAT-ANT,TROLL /?L5
	EQUAL? PRSI,GRUE,TRIFFID \?L4
?L5:	CALL HELD?,FLASK >STACK
	ZERO? STACK \?L6
	PRINTR "You're not holding the flask."
?L6:	REMOVE CHEMICAL-FLUID
	PRINTR "The mutants lap up the chemical, howling with delight. One immediately grows three new mouths."
?L4:	EQUAL? PRSA,V?POUR,V?PUT \FALSE
	CALL HELD?,FLASK >STACK
	ZERO? STACK \?L14
	PRINTR "You're not holding the flask."
?L14:	EQUAL? PRSI,CANTEEN \?L18
	CALL WORTHLESS-ACTION
	RTRUE
?L18:	REMOVE CHEMICAL-FLUID
	ZERO? PRSI \?L20
	SET 'PRSI,GROUND
?L20:	EQUAL? PRSI,FUNNEL-HOLE \?L23
	EQUAL? CHEMICAL-FLAG,CHEMICAL-REQUIRED \?L25
	GET ORDER-LTBL,STEPS-TO-GO >CHEMICAL-REQUIRED
	DEC 'STEPS-TO-GO
	PRINTI "The liquid disappears into the hole. The lights on the enunciator panel blink rapidly "
	ZERO? STEPS-TO-GO \?L29
	SET 'COMM-FIXED,1
	ADD SCORE,6 >SCORE
	SET 'CHEMICAL-REQUIRED,10
	PRINTR "and then go dark. The coolant system warning light goes off, and another flashes, indicating that the help message is now being sent."
?L29:	PRINTI "and all go off except one, a "
	EQUAL? CHEMICAL-REQUIRED,1 \?L36
	PRINTI "red"
	JUMP ?L55
?L36:	EQUAL? CHEMICAL-REQUIRED,2 \?L40
	PRINTI "blue"
	JUMP ?L55
?L40:	EQUAL? CHEMICAL-REQUIRED,3 \?L43
	PRINTI "green"
	JUMP ?L55
?L43:	EQUAL? CHEMICAL-REQUIRED,4 \?L46
	PRINTI "yellow"
	JUMP ?L55
?L46:	EQUAL? CHEMICAL-REQUIRED,5 \?L49
	PRINTI "gray"
	JUMP ?L55
?L49:	EQUAL? CHEMICAL-REQUIRED,6 \?L52
	PRINTI "brown"
	JUMP ?L55
?L52:	EQUAL? CHEMICAL-REQUIRED,7 \?L55
	PRINTI "black"
?L55:	PRINTR " light."
?L25:	SET 'COMM-SHUTDOWN,1
	ZERO? COMM-FIXED /?L62
	SUB SCORE,6 >SCORE
	SET 'COMM-FIXED,0
?L62:	PRINTI "An alarm sounds briefly, and a sign flashes "
	CALL SHUTDOWN
	PRINTR " A moment later, the lights in the room dim and the send console shuts down."
?L23:	EQUAL? CHEMICAL-FLAG,8,9 \?L69
	FSET? PRSI,ACIDBIT \?L70
	EQUAL? PRSI,SPOUT-PLACED \?L72
	SET 'SPOUT-PLACED,GROUND
?L72:	REMOVE PRSI
	PRINTI "The "
	PRINTD PRSI
	PRINTI " dissolves right before your eyes!"
	EQUAL? PRSI,BAD-BEDISTOR \?L77
	FSET? BAD-BEDISTOR,TOUCHBIT /?L77
	FSET CUBE,MUNGEDBIT
	CALL CUBE-SEEMS
	CRLF
	RTRUE
?L77:	EQUAL? PRSI,GOOD-BEDISTOR \?L79
	ZERO? COURSE-CONTROL-FIXED /?L79
	FSET CUBE,MUNGEDBIT
	SUB SCORE,6 >SCORE
	SET 'COURSE-CONTROL-FIXED,0
	CALL CUBE-SEEMS
?L79:	CRLF
	RTRUE
?L70:	EQUAL? CREVICE,PRSI \?L81
	FSET? KEY,TOUCHBIT /?L81
	FSET? KEY,INVISIBLE \?L82
	PRINTI "A puff of smoke rises from the crevice."
	CRLF
	JUMP ?L86
?L82:	PRINTI "Although the chemical has no effect on the crevice, it does seem to have dissolved the key that was lying in it."
	CRLF
?L86:	REMOVE KEY
	FSET KEY,TOUCHBIT
	FCLEAR KEY,INVISIBLE
	RTRUE
?L81:	EQUAL? PRSI,HIGH-PROTEIN,MEDICINE \?L89
	CALL JIGS-UP,STR?97 >STACK
	RSTACK
?L89:	EQUAL? PRSI,ME,ADVENTURER,HANDS \?L90
	CALL JIGS-UP,STR?98 >STACK
	RSTACK
?L90:	EQUAL? PRSI,FLOYD \?L91
	FSET? FLOYD,RLANDBIT \?L91
	PRINTR "Floyd yelps. ""Hey, cut it out! That stuff burns!"""
?L91:	EQUAL? PRSI,MICROBE \?L94
	PRINTI "The microbe writhes in pain. "
	CALL STRIP-DISSOLVES >STACK
	RSTACK
?L94:	EQUAL? PRSI,STRIP,RELAY \?L97
	CALL STRIP-DISSOLVES >STACK
	RSTACK
?L97:	FSET? PRSI,MUNGBIT \?L98
	FSET PRSI,MUNGEDBIT
	EQUAL? PRSI,CHRONOMETER \?L99
	SET 'MUNGED-TIME,INTERNAL-MOVES
?L99:	PRINTI "The "
	PRINTD PRSI
	PRINTI " seems to undergo some damage as a result of your action."
	CRLF
	EQUAL? PRSI,CUBE \TRUE
	ZERO? COURSE-CONTROL-FIXED /TRUE
	SET 'COURSE-CONTROL-FIXED,0
	REMOVE GOOD-BEDISTOR
	SUB SCORE,6 >SCORE
	PRINTR "The bedistor also happens to dissolve."
?L98:	CALL CHEMICAL-POURS >STACK
	RSTACK
?L69:	CALL CHEMICAL-POURS >STACK
	RSTACK

	.FUNCT CUBE-SEEMS
	PRINTI " Unfortunately, the cube seems to undergo some damage as well."
	RTRUE

	.FUNCT CHEMICAL-POURS
	PRINTI "The chemical pours all over the "
	PRINTD PRSI
	PRINTR ", making quite a mess."

	.FUNCT STRIP-DISSOLVES
	CALL JIGS-UP,STR?99 >STACK
	RSTACK

	.FUNCT SHUTDOWN
	PRINTI """Kuulint Sistum Imbalins Kritikul -- Shuteeng Down Awl Sistumz."""
	RTRUE

	.FUNCT COMM-SETUP
	RANDOM 3 >STACK
	ADD 2,STACK >OLD-SHOTS
	RANDOM 10 >STACK
	ADD 20,STACK >NEW-SHOTS
	CALL RANDOMIZE-ORDER
	RANDOM 2 >STACK
	ADD 1,STACK >STEPS-TO-GO
	ADD STEPS-TO-GO,1 >STACK
	GET ORDER-LTBL,STACK >CHEMICAL-REQUIRED
	RETURN CHEMICAL-REQUIRED

	.FUNCT OTHER-ELEVATOR-ENTER-F
	FSET? LOWER-ELEVATOR-DOOR,OPENBIT \?L1
	ZERO? LOWER-ELEVATOR-UP \?L1
	RETURN LOWER-ELEVATOR
?L1:	CALL DOOR-CLOSED
	CALL THIS-IS-IT,LOWER-ELEVATOR-DOOR
	RFALSE

	.FUNCT KALAMONTEE-PLATFORM-F,RARG
	EQUAL? RARG,M-LOOK \FALSE
	PRINTI "This is a wide, flat strip of concrete which continues westward. "
	ZERO? BETTY-AT-KALAMONTEE /?L9
	ZERO? ALFIE-AT-KALAMONTEE /?L5
	PRINTI "Open shuttle cars lie on the north and south sides of the platform. "
	JUMP ?L12
?L5:	ZERO? BETTY-AT-KALAMONTEE /?L9
	PRINTI "An open shuttle car lies to the north. "
	JUMP ?L12
?L9:	ZERO? ALFIE-AT-KALAMONTEE /?L12
	PRINTI "A large transport of some sort lies to the south, its open door beckoning you to enter. "
?L12:	PRINTR "A faded sign on the wall reads ""Shutul Platform -- Kalamontee Staashun."""

	.FUNCT LAWANDA-PLATFORM-F,RARG
	ZERO? LAWANDA-PLATFORM-FLAG \?L1
	SET 'LAWANDA-PLATFORM-FLAG,1
	SET 'SICKNESS-WARNING-FLAG,1
?L1:	EQUAL? RARG,M-LOOK \FALSE
	PRINTI "This is a wide, flat strip of concrete. "
	ZERO? ALFIE-AT-KALAMONTEE \?L27
	ZERO? BETTY-AT-KALAMONTEE \?L8
	PRINTI "Open shuttle cars lie to the north and south."
	JUMP ?L20
?L8:	ZERO? ALFIE-AT-KALAMONTEE /?L13
?L27:	ZERO? BETTY-AT-KALAMONTEE \?L20
?L13:	PRINTI "An open shuttle car lies to the "
	ZERO? ALFIE-AT-KALAMONTEE /?L16
	PRINTI "north."
	JUMP ?L20
?L16:	PRINTI "south."
?L20:	PRINTR " A wide escalator, not currently operating, beckons upward at the east end of the platform. A faded sign reads ""Shutul Platform -- Lawanda Staashun."""

	.FUNCT INFIRMARY-F,RARG
	EQUAL? RARG,M-END \FALSE
	ZERO? LAZARUS-FLAG \FALSE
	IN? FLOYD,HERE \FALSE
	FSET? FLOYD,RLANDBIT \FALSE
	RANDOM 100 >STACK
	LESS? 30,STACK /FALSE
	SET 'LAZARUS-FLAG,1
	MOVE LAZARUS-PART,HERE
	MOVE FLOYD,FORK
	SET 'FLOYD-FOLLOW,0
	SET 'FLOYD-SPOKE,1
	PRINTR "Floyd, rummaging in a corner, finds something and carries it to the center of the room to examine it in the brighter light. It seems to be the breast plate of a robot, along with some connected inner circuitry. The entire piece is bent and rusting. Floyd stares at it in complete silence. A moment later, he begins sobbing quietly, awkwardly excuses himself, and runs out of the room. You look at the breast plate, and notice the name ""Lazarus"" engraved on it."

	.FUNCT RED-SPOOL-F
	EQUAL? PRSA,V?TAKE \FALSE
	IN? RED-SPOOL,SPOOL-READER \FALSE
	FSET? SPOOL-READER,ONBIT \FALSE
	MOVE RED-SPOOL,ADVENTURER
	FCLEAR RED-SPOOL,TRYTAKEBIT
	PRINTR "The screen goes blank as you take the spool."

	.FUNCT MEDICINE-F,X=0
	EQUAL? PRSA,V?POUR,V?EAT,V?TASTE \?L3
	IN? MEDICINE-BOTTLE,ADVENTURER /?L1
	SET 'PRSO,MEDICINE-BOTTLE
	CALL NOT-HOLDING
	CALL THIS-IS-IT,MEDICINE-BOTTLE >STACK
	RSTACK
?L1:	EQUAL? PRSA,V?POUR,V?EAT,V?TASTE \?L3
	FSET? MEDICINE-BOTTLE,OPENBIT /?L3
	PRINTR "The bottle is closed."
?L3:	EQUAL? PRSA,V?TASTE \?L6
	PRINTR "It tastes fairly bitter."
?L6:	EQUAL? PRSA,V?EAT \?L9
	REMOVE MEDICINE
	SET 'C-ELAPSED,15
	SUB SICKNESS-LEVEL,2 >SICKNESS-LEVEL
	ADD LOAD-ALLOWED,20 >LOAD-ALLOWED
	PRINTR "The medicine tasted extremely bitter."
?L9:	EQUAL? PRSA,V?POUR \?L12
	REMOVE MEDICINE
	ZERO? PRSI \?L13
	SET 'PRSI,GROUND
?L13:	EQUAL? PRSI,FUNNEL-HOLE \?L16
	IN? CHEMICAL-FLUID,FLASK \?L18
	SET 'X,1
?L18:	SET 'CHEMICAL-REQUIRED,10
	CALL PERFORM,V?POUR,CHEMICAL-FLUID,FUNNEL-HOLE
	ZERO? X /TRUE
	MOVE CHEMICAL-FLUID,FLASK
	RTRUE
?L16:	PRINTI "It pours over the "
	PRINTD PRSI
	PRINTR " and evaporates."
?L12:	EQUAL? PRSA,V?TAKE \FALSE
	GET P-VTBL,0 >STACK
	EQUAL? STACK,W?TAKE \FALSE
	CALL PERFORM,V?EAT,MEDICINE
	RTRUE

	.FUNCT ROBOT-HOLE-F
	EQUAL? PRSA,V?EXAMINE \?L1
	PRINTR "It's too small for you to get through. It was presumably intended for robots, such as the broken repair robot lying over there."
?L1:	EQUAL? PRSA,V?LOOK-INSIDE \?L5
	PRINTR "You can make out a small supply room of some sort."
?L5:	EQUAL? PRSA,V?CLOSE,V?OPEN \FALSE
	PRINTR "There's no door, just an opening in the wall."

	.FUNCT FLOYD-THROUGH-HOLE
	ZERO? HOLE-TRIP-FLAG /?L1
	PRINTR """Not again,"" whines Floyd."
?L1:	SET 'C-ELAPSED,50
	SET 'HOLE-TRIP-FLAG,1
	SET 'BOARD-REPORTED,1
	FCLEAR GOOD-BOARD,INVISIBLE
	PRINTR "Floyd squeezes through the opening and is gone for quite a while. You hear thudding noises and squeals of enjoyment. After a while the noise stops, and Floyd emerges, looking downcast. ""Floyd found a rubber ball inside. Lots of fun for a while, but must have been old, because it fell apart. Nothing else interesting inside. Just a shiny fromitz board."""

	.FUNCT GOOD-BOARD-F
	FSET? GOOD-BOARD,NDESCBIT \?L1
	EQUAL? PRSA,V?LOOK-UNDER,V?MOVE,V?PULL /?L3
	EQUAL? PRSA,V?PUSH /?L3
	EQUAL? PRSA,V?RUB,V?EXAMINE,V?TAKE \?L1
?L3:	EQUAL? GOOD-BOARD,PRSO \?L1
	PRINTI "You can't see any "
	PRINTD PRSO
	PRINTR " here."
?L1:	EQUAL? PRSA,V?EXAMINE \FALSE
	CALL EXAMINE-BOARD
	CRLF
	RTRUE

	.FUNCT PLANETARY-DEFENSE-F,RARG
	EQUAL? RARG,M-LOOK \FALSE
	PRINTI "This room is filled with a dazzling array of lights and controls. "
	ZERO? DEFENSE-FIXED \?L5
	PRINTI "One light, blinking quickly, catches your eye. It reads ""Surkit Boord Faalyur. WORNEENG: xis boord kuntroolz xe diskriminaashun surkits."""
?L5:	PRINTI " There is a small access panel on one wall which is "
	CALL DDESC,ACCESS-PANEL
	PRINTR "."

	.FUNCT ACCESS-PANEL-F
	EQUAL? PRSA,V?OPEN \?L1
	FSET? ACCESS-PANEL,OPENBIT \?L3
	CALL ALREADY-OPEN >STACK
	RSTACK
?L3:	FSET ACCESS-PANEL,OPENBIT
	PRINTI "The panel swings open."
	CRLF
	CALL PERFORM,V?LOOK-INSIDE,ACCESS-PANEL
	RTRUE
?L1:	EQUAL? PRSA,V?CLOSE \?L8
	FSET? ACCESS-PANEL,OPENBIT \?L9
	FCLEAR ACCESS-PANEL,OPENBIT
	PRINTR "The panel swings closed."
?L9:	CALL IS-CLOSED >STACK
	RSTACK
?L8:	EQUAL? PRSA,V?PUT \FALSE
	EQUAL? PRSI,ACCESS-PANEL \FALSE
	FSET? ACCESS-PANEL,OPENBIT /?L15
	PRINTR "The panel is closed."
?L15:	ZERO? ACCESS-PANEL-FULL /?L19
	PRINTR "There's no room."
?L19:	EQUAL? PRSO,GOOD-BOARD \?L22
	REMOVE GOOD-BOARD
	MOVE SECOND-BOARD,ACCESS-PANEL
	CALL THIS-IS-IT,SECOND-BOARD
	SET 'DEFENSE-FIXED,1
	ADD SCORE,6 >SCORE
	SET 'ACCESS-PANEL-FULL,1
	CALL PUT-BOARD
	PRINTR " The warning lights stop flashing."
?L22:	EQUAL? PRSO,CRACKED-BOARD,FRIED-BOARD \?L25
	REMOVE PRSO
	CALL THIS-IS-IT,SECOND-BOARD
	MOVE SECOND-BOARD,ACCESS-PANEL
	SET 'ACCESS-PANEL-FULL,1
	EQUAL? PRSO,CRACKED-BOARD \?L26
	SET 'ITS-CRACKED,1
?L26:	CALL PUT-BOARD
	CRLF
	RTRUE
?L25:	PRINTI "The "
	PRINTD PRSO
	PRINTI " doesn't fit."
	RTRUE

	.FUNCT FRIED-BOARD-F
	EQUAL? PRSA,V?EXAMINE \FALSE
	CALL EXAMINE-BOARD
	PRINTR " This one is a bit blackened around the edges, though."

	.FUNCT BOARD-F
	EQUAL? PRSA,V?TAKE \?L1
	EQUAL? PRSO,SECOND-BOARD \?L3
	ZERO? DEFENSE-FIXED /?L5
	CALL BOARD-SHOCK >STACK
	RSTACK
?L5:	PRINTI "The fromitz board slides out of the panel, producing an empty socket for another board."
	CRLF
	REMOVE SECOND-BOARD
	SET 'ACCESS-PANEL-FULL,0
	EQUAL? ITS-CRACKED,1 \?L10
	MOVE CRACKED-BOARD,ADVENTURER
	JUMP ?L12
?L10:	MOVE FRIED-BOARD,ADVENTURER
?L12:	CALL THIS-IS-IT,FRIED-BOARD >STACK
	RSTACK
?L3:	CALL BOARD-SHOCK >STACK
	RSTACK
?L1:	EQUAL? PRSA,V?EXAMINE \FALSE
	CALL EXAMINE-BOARD
	CRLF
	RTRUE

	.FUNCT EXAMINE-BOARD
	PRINTI "Like most fromitz boards, it is a twisted maze of silicon circuits. It is square, approximately seventeen centimeters on each side."
	RTRUE

	.FUNCT PUT-BOARD
	PRINTI "The card clicks neatly into the socket."
	RTRUE

	.FUNCT BOARD-SHOCK
	PRINTR "You jerk your hand back as you receive a powerful shock from the fromitz board."

	.FUNCT PLANETARY-COURSE-CONTROL-F,RARG
	EQUAL? RARG,M-LOOK \FALSE
	PRINTI "This is a long room whose walls are covered with complicated controls and colored lights. "
	ZERO? COURSE-CONTROL-FIXED /?L5
	PRINTI "One blinking light says ""Kors diivurjins minimiizeeng."""
	JUMP ?L9
?L5:	PRINTI "Two of these lights are blinking. The first one reads ""Bedistur Faalyur!"" The other light reads ""Kritikul diivurjins frum pland kors."""
?L9:	PRINTI " In one corner is a large metal cube whose lid is "
	FSET? CUBE,OPENBIT \?L14
	PRINTI "open"
	JUMP ?L18
?L14:	PRINTI "closed"
?L18:	PRINTR "."

	.FUNCT CUBE-F
	EQUAL? PRSA,V?OPEN \?L1
	FSET? CUBE,OPENBIT \?L3
	CALL ALREADY-OPEN >STACK
	RSTACK
?L3:	FSET CUBE,OPENBIT
	PRINTI "The lid swings open."
	CRLF
	CALL PERFORM,V?LOOK-INSIDE,CUBE
	RTRUE
?L1:	EQUAL? PRSA,V?CLOSE \?L8
	FSET? CUBE,OPENBIT \?L9
	FCLEAR CUBE,OPENBIT
	PRINTR "The lid swings closed."
?L9:	CALL IS-CLOSED >STACK
	RSTACK
?L8:	EQUAL? PRSA,V?PUT \FALSE
	EQUAL? PRSI,CUBE \FALSE
	FSET? CUBE,OPENBIT /?L15
	PRINTR "The cube is closed."
?L15:	IN? BAD-BEDISTOR,CUBE \?L19
	PRINTR "There's a fused bedistor in the way."
?L19:	EQUAL? PRSO,GOOD-BEDISTOR \?L22
	MOVE GOOD-BEDISTOR,CUBE
	FSET? CUBE,MUNGEDBIT /?L23
	SET 'COURSE-CONTROL-FIXED,1
	FSET GOOD-BEDISTOR,TRYTAKEBIT
	ADD SCORE,6 >SCORE
	PRINTR "Done. The warning lights go out and another light goes on."
?L23:	PRINTR "Done."
?L22:	EQUAL? PRSO,BAD-BEDISTOR \?L30
	MOVE BAD-BEDISTOR,CUBE
	PRINTR "Done."
?L30:	PRINTI "The "
	PRINTD PRSO
	PRINTI " doesn't fit."
	RTRUE

	.FUNCT BAD-BEDISTOR-F
	EQUAL? PRSA,V?TAKE \?L1
	IN? BAD-BEDISTOR,CUBE \?L1
	PRINTR "It seems to be fused to its socket."
?L1:	EQUAL? PRSA,V?ZATTRACT \FALSE
	EQUAL? PRSI,PLIERS \?L6
	MOVE BAD-BEDISTOR,ADVENTURER
	FCLEAR BAD-BEDISTOR,TRYTAKEBIT
	PRINTR "With a tug, you manage to remove the fused bedistor."
?L6:	PRINTR "You can't get a grip on the bedistor with that."

	.FUNCT GREEN-SPOOL-F
	EQUAL? PRSA,V?TAKE \FALSE
	IN? GREEN-SPOOL,SPOOL-READER \FALSE
	FSET? SPOOL-READER,ONBIT \FALSE
	MOVE GREEN-SPOOL,ADVENTURER
	FCLEAR GREEN-SPOOL,TRYTAKEBIT
	PRINTR "The screen goes blank as you take the spool."

	.FUNCT TERMINAL-F
	EQUAL? PRSA,V?EXAMINE \?L1
	PRINTI "The computer terminal consists of a video display screen, a keyboard with ten keys numbered from zero through nine, and an on-off switch. "
	FSET? TERMINAL,ONBIT \?L5
	PRINTI "The screen displays some writing:"
	CRLF
	PRINT SCREEN-TEXT
	CRLF
	GRTR? MENU-LEVEL,9 \TRUE
	PRINT MORE-INFO
	CRLF
	RTRUE
?L5:	PRINTR "The screen is dark."
?L1:	EQUAL? PRSA,V?READ \?L17
	FSET? TERMINAL,ONBIT \?L18
	PRINT SCREEN-TEXT
	CRLF
	GRTR? MENU-LEVEL,9 \TRUE
	PRINT MORE-INFO
	CRLF
	RTRUE
?L18:	PRINTR "The screen is blank."
?L17:	EQUAL? PRSA,V?LAMP-ON \?L30
	FSET? TERMINAL,ONBIT \?L31
	PRINTR "It's already on."
?L31:	FSET TERMINAL,ONBIT
	FSET TERMINAL,TOUCHBIT
	SET 'SCREEN-TEXT,MAIN-MENU
	PRINTI "The screen gives off a green flash, and then some writing appears on the screen:"
	CRLF
	PRINT SCREEN-TEXT
	CRLF
	RTRUE
?L30:	EQUAL? PRSA,V?LAMP-OFF \FALSE
	FSET? TERMINAL,ONBIT \?L41
	FCLEAR TERMINAL,ONBIT
	SET 'MENU-LEVEL,0
	PRINTR "The screen goes dark."
?L41:	PRINTR "It isn't on!"

	.FUNCT LIBRARY-TYPE
	EQUAL? PRSO,INTNUM /?L1
	CALL NUMBERS-ONLY >STACK
	RSTACK
?L1:	ZERO? MENU-LEVEL \?L3
	ZERO? P-NUMBER \?L4
	PRINT NO-MEANING
	CRLF
	RTRUE
?L4:	EQUAL? P-NUMBER,1 \?L8
	PRINT SCREEN-CLEARS
	CRLF
	SET 'SCREEN-TEXT,HISTORY-MENU
	PRINT SCREEN-TEXT
	CRLF
	SET 'MENU-LEVEL,1
	RETURN MENU-LEVEL
?L8:	EQUAL? P-NUMBER,2 \?L13
	PRINT SCREEN-CLEARS
	CRLF
	SET 'SCREEN-TEXT,CULTURE-MENU
	PRINT SCREEN-TEXT
	CRLF
	SET 'MENU-LEVEL,2
	RETURN MENU-LEVEL
?L13:	EQUAL? P-NUMBER,3 \?L18
	PRINT SCREEN-CLEARS
	CRLF
	SET 'SCREEN-TEXT,TECHNOLOGY-MENU
	PRINT SCREEN-TEXT
	CRLF
	SET 'MENU-LEVEL,3
	RETURN MENU-LEVEL
?L18:	EQUAL? P-NUMBER,4 \?L23
	PRINT SCREEN-CLEARS
	CRLF
	SET 'SCREEN-TEXT,GEOGRAPHY-MENU
	PRINT SCREEN-TEXT
	CRLF
	SET 'MENU-LEVEL,4
	RETURN MENU-LEVEL
?L23:	EQUAL? P-NUMBER,5 \?L28
	PRINT SCREEN-CLEARS
	CRLF
	SET 'SCREEN-TEXT,PROJECT-MENU
	PRINT SCREEN-TEXT
	CRLF
	SET 'MENU-LEVEL,5
	RETURN MENU-LEVEL
?L28:	EQUAL? P-NUMBER,6 \?L33
	SET 'MENU-LEVEL,6
	PRINT SCREEN-CLEARS
	CRLF
	SET 'SCREEN-TEXT,INTERLOGIC-MENU
	PRINT SCREEN-TEXT
	CRLF
	RTRUE
?L33:	GRTR? P-NUMBER,6 \FALSE
	PRINT NO-MEANING
	CRLF
	RTRUE
?L3:	EQUAL? MENU-LEVEL,1 \?L42
	ZERO? P-NUMBER \?L43
	SET 'MENU-LEVEL,0
	PRINT SCREEN-CLEARS
	CRLF
	SET 'SCREEN-TEXT,MAIN-MENU
	PRINT SCREEN-TEXT
	CRLF
	RTRUE
?L43:	EQUAL? P-NUMBER,1 \?L49
	SET 'MENU-LEVEL,11
	PRINT TEXT-APPEARS
	CRLF
	SET 'SCREEN-TEXT,11-TEXT
	PRINT SCREEN-TEXT
	CRLF
	PRINT MORE-INFO
	CRLF
	RTRUE
?L49:	EQUAL? P-NUMBER,2 \?L56
	SET 'MENU-LEVEL,12
	PRINT TEXT-APPEARS
	CRLF
	SET 'SCREEN-TEXT,12-TEXT
	PRINT SCREEN-TEXT
	CRLF
	PRINT MORE-INFO
	CRLF
	RTRUE
?L56:	EQUAL? P-NUMBER,3 \?L63
	SET 'MENU-LEVEL,13
	PRINT TEXT-APPEARS
	CRLF
	SET 'SCREEN-TEXT,13-TEXT
	PRINT SCREEN-TEXT
	CRLF
	PRINT MORE-INFO
	CRLF
	RTRUE
?L63:	GRTR? P-NUMBER,3 \FALSE
	PRINT NO-MEANING
	CRLF
	RTRUE
?L42:	EQUAL? MENU-LEVEL,2 \?L74
	ZERO? P-NUMBER \?L75
	SET 'MENU-LEVEL,0
	PRINT SCREEN-CLEARS
	CRLF
	SET 'SCREEN-TEXT,MAIN-MENU
	PRINT SCREEN-TEXT
	CRLF
	RTRUE
?L75:	EQUAL? P-NUMBER,1 \?L81
	SET 'MENU-LEVEL,21
	PRINT TEXT-APPEARS
	CRLF
	SET 'SCREEN-TEXT,21-TEXT
	PRINT SCREEN-TEXT
	CRLF
	PRINT MORE-INFO
	CRLF
	RTRUE
?L81:	EQUAL? P-NUMBER,2 \?L88
	SET 'MENU-LEVEL,22
	PRINT TEXT-APPEARS
	CRLF
	SET 'SCREEN-TEXT,22-TEXT
	PRINT SCREEN-TEXT
	CRLF
	PRINT MORE-INFO
	CRLF
	RTRUE
?L88:	EQUAL? P-NUMBER,3 \?L95
	SET 'MENU-LEVEL,23
	PRINT TEXT-APPEARS
	CRLF
	SET 'SCREEN-TEXT,23-TEXT
	PRINT SCREEN-TEXT
	CRLF
	PRINT MORE-INFO
	CRLF
	RTRUE
?L95:	GRTR? P-NUMBER,4 \FALSE
	PRINT NO-MEANING
	CRLF
	RTRUE
?L74:	EQUAL? MENU-LEVEL,3 \?L106
	ZERO? P-NUMBER \?L107
	SET 'MENU-LEVEL,0
	PRINT SCREEN-CLEARS
	CRLF
	SET 'SCREEN-TEXT,MAIN-MENU
	PRINT SCREEN-TEXT
	CRLF
	RTRUE
?L107:	EQUAL? P-NUMBER,1 \?L113
	SET 'MENU-LEVEL,31
	PRINT TEXT-APPEARS
	CRLF
	SET 'SCREEN-TEXT,31-TEXT
	PRINT SCREEN-TEXT
	CRLF
	PRINT MORE-INFO
	CRLF
	RTRUE
?L113:	EQUAL? P-NUMBER,2 \?L120
	SET 'MENU-LEVEL,32
	PRINT TEXT-APPEARS
	CRLF
	SET 'SCREEN-TEXT,32-TEXT
	PRINT SCREEN-TEXT
	CRLF
	PRINT MORE-INFO
	CRLF
	RTRUE
?L120:	EQUAL? P-NUMBER,3 \?L127
	SET 'MENU-LEVEL,33
	PRINT TEXT-APPEARS
	CRLF
	SET 'SCREEN-TEXT,33-TEXT
	PRINT SCREEN-TEXT
	CRLF
	PRINT MORE-INFO
	CRLF
	RTRUE
?L127:	EQUAL? P-NUMBER,4 \?L134
	SET 'MENU-LEVEL,34
	PRINT TEXT-APPEARS
	CRLF
	SET 'SCREEN-TEXT,34-TEXT
	PRINT SCREEN-TEXT
	CRLF
	PRINT MORE-INFO
	CRLF
	RTRUE
?L134:	EQUAL? P-NUMBER,5 \?L141
	SET 'MENU-LEVEL,35
	PRINT TEXT-APPEARS
	CRLF
	SET 'SCREEN-TEXT,35-TEXT
	PRINT SCREEN-TEXT
	CRLF
	PRINT MORE-INFO
	CRLF
	RTRUE
?L141:	GRTR? P-NUMBER,5 \FALSE
	PRINT NO-MEANING
	CRLF
	RTRUE
?L106:	EQUAL? MENU-LEVEL,4 \?L152
	ZERO? P-NUMBER \?L153
	SET 'MENU-LEVEL,0
	PRINT SCREEN-CLEARS
	CRLF
	SET 'SCREEN-TEXT,MAIN-MENU
	PRINT SCREEN-TEXT
	CRLF
	RTRUE
?L153:	EQUAL? P-NUMBER,1 \?L159
	SET 'MENU-LEVEL,41
	PRINT TEXT-APPEARS
	CRLF
	SET 'SCREEN-TEXT,41-TEXT
	PRINT SCREEN-TEXT
	CRLF
	PRINT MORE-INFO
	CRLF
	RTRUE
?L159:	EQUAL? P-NUMBER,2 \?L166
	SET 'MENU-LEVEL,42
	PRINT TEXT-APPEARS
	CRLF
	SET 'SCREEN-TEXT,42-TEXT
	PRINT SCREEN-TEXT
	CRLF
	PRINT MORE-INFO
	CRLF
	RTRUE
?L166:	EQUAL? P-NUMBER,3 \?L173
	SET 'MENU-LEVEL,43
	PRINT TEXT-APPEARS
	CRLF
	SET 'SCREEN-TEXT,43-TEXT
	PRINT SCREEN-TEXT
	CRLF
	PRINT MORE-INFO
	CRLF
	RTRUE
?L173:	GRTR? P-NUMBER,3 \FALSE
	PRINT NO-MEANING
	CRLF
	RTRUE
?L152:	EQUAL? MENU-LEVEL,5 \?L184
	ZERO? P-NUMBER \?L185
	SET 'MENU-LEVEL,0
	PRINT SCREEN-CLEARS
	CRLF
	SET 'SCREEN-TEXT,MAIN-MENU
	PRINT SCREEN-TEXT
	CRLF
	RTRUE
?L185:	EQUAL? P-NUMBER,1 \?L191
	SET 'MENU-LEVEL,51
	PRINT TEXT-APPEARS
	CRLF
	SET 'SCREEN-TEXT,51-TEXT
	PRINT SCREEN-TEXT
	CRLF
	PRINT MORE-INFO
	CRLF
	RTRUE
?L191:	EQUAL? P-NUMBER,2 \?L198
	SET 'MENU-LEVEL,52
	PRINT TEXT-APPEARS
	CRLF
	SET 'SCREEN-TEXT,52-TEXT
	PRINT SCREEN-TEXT
	CRLF
	PRINT MORE-INFO
	CRLF
	RTRUE
?L198:	EQUAL? P-NUMBER,3 \?L205
	SET 'MENU-LEVEL,53
	PRINT TEXT-APPEARS
	CRLF
	SET 'SCREEN-TEXT,53-TEXT
	PRINT SCREEN-TEXT
	CRLF
	PRINT MORE-INFO
	CRLF
	RTRUE
?L205:	GRTR? P-NUMBER,3 \FALSE
	PRINT NO-MEANING
	CRLF
	RTRUE
?L184:	EQUAL? MENU-LEVEL,6 \?L216
	ZERO? P-NUMBER \?L217
	SET 'MENU-LEVEL,0
	PRINT SCREEN-CLEARS
	CRLF
	SET 'SCREEN-TEXT,MAIN-MENU
	PRINT SCREEN-TEXT
	CRLF
	RTRUE
?L217:	EQUAL? P-NUMBER,1 \?L223
	SET 'MENU-LEVEL,61
	PRINT TEXT-APPEARS
	CRLF
	SET 'SCREEN-TEXT,61-TEXT
	PRINT SCREEN-TEXT
	CRLF
	PRINT MORE-INFO
	CRLF
	IN? FLOYD,HERE \FALSE
	SET 'FLOYD-SPOKE,1
	PRINTR "Floyd, peering over your shoulder, says ""Oh, I love that game! Solved every problem, except couldn't figure out how to get into white house."""
?L223:	EQUAL? P-NUMBER,2 \?L235
	SET 'MENU-LEVEL,62
	PRINT TEXT-APPEARS
	CRLF
	SET 'SCREEN-TEXT,62-TEXT
	PRINT SCREEN-TEXT
	CRLF
	PRINT MORE-INFO
	CRLF
	RTRUE
?L235:	EQUAL? P-NUMBER,3 \?L242
	SET 'MENU-LEVEL,63
	PRINT TEXT-APPEARS
	CRLF
	SET 'SCREEN-TEXT,63-TEXT
	PRINT SCREEN-TEXT
	CRLF
	PRINT MORE-INFO
	CRLF
	RTRUE
?L242:	GRTR? P-NUMBER,3 \FALSE
	PRINT NO-MEANING
	CRLF
	RTRUE
?L216:	GRTR? MENU-LEVEL,10 \?L253
	LESS? MENU-LEVEL,20 \?L253
	ZERO? P-NUMBER \?L254
	SET 'MENU-LEVEL,1
	PRINT SCREEN-CLEARS
	CRLF
	SET 'SCREEN-TEXT,HISTORY-MENU
	PRINT SCREEN-TEXT
	CRLF
	RTRUE
?L254:	PRINT LOW-END
	CRLF
	RTRUE
?L253:	GRTR? MENU-LEVEL,20 \?L263
	LESS? MENU-LEVEL,30 \?L263
	ZERO? P-NUMBER \?L264
	SET 'MENU-LEVEL,2
	PRINT SCREEN-CLEARS
	CRLF
	SET 'SCREEN-TEXT,CULTURE-MENU
	PRINT SCREEN-TEXT
	CRLF
	RTRUE
?L264:	PRINT LOW-END
	CRLF
	RTRUE
?L263:	GRTR? MENU-LEVEL,30 \?L273
	LESS? MENU-LEVEL,40 \?L273
	ZERO? P-NUMBER \?L274
	SET 'MENU-LEVEL,3
	PRINT SCREEN-CLEARS
	CRLF
	SET 'SCREEN-TEXT,TECHNOLOGY-MENU
	PRINT SCREEN-TEXT
	CRLF
	RTRUE
?L274:	PRINT LOW-END
	CRLF
	RTRUE
?L273:	GRTR? MENU-LEVEL,40 \?L283
	LESS? MENU-LEVEL,50 \?L283
	ZERO? P-NUMBER \?L284
	SET 'MENU-LEVEL,4
	PRINT SCREEN-CLEARS
	CRLF
	SET 'SCREEN-TEXT,GEOGRAPHY-MENU
	PRINT SCREEN-TEXT
	CRLF
	RTRUE
?L284:	PRINT LOW-END
	CRLF
	RTRUE
?L283:	GRTR? MENU-LEVEL,50 \?L293
	LESS? MENU-LEVEL,60 \?L293
	ZERO? P-NUMBER \?L294
	SET 'MENU-LEVEL,5
	PRINT SCREEN-CLEARS
	CRLF
	SET 'SCREEN-TEXT,PROJECT-MENU
	PRINT SCREEN-TEXT
	CRLF
	RTRUE
?L294:	PRINT LOW-END
	CRLF
	RTRUE
?L293:	GRTR? MENU-LEVEL,60 \FALSE
	LESS? MENU-LEVEL,70 \FALSE
	ZERO? P-NUMBER \?L304
	SET 'MENU-LEVEL,6
	PRINT SCREEN-CLEARS
	CRLF
	SET 'SCREEN-TEXT,INTERLOGIC-MENU
	PRINT SCREEN-TEXT
	CRLF
	RTRUE
?L304:	PRINT LOW-END
	CRLF
	RTRUE

	.FUNCT SPOOL-READER-F
	EQUAL? PRSA,V?LAMP-ON \?L1
	FSET? SPOOL-READER,ONBIT \?L3
	PRINTR "The spool reader is already on."
?L3:	FSET SPOOL-READER,ONBIT
	FSET SPOOL-READER,TOUCHBIT
	FIRST? SPOOL-READER >STACK \?L8
	PRINT SPOOL-TEXT
	CRLF
	RTRUE
?L8:	PRINTR "The machine hums quietly, and the screen lights up with the phrase ""Pleez insurt spuul."""
?L1:	EQUAL? PRSA,V?LAMP-OFF \?L15
	FSET? SPOOL-READER,ONBIT \?L16
	FCLEAR SPOOL-READER,ONBIT
	PRINTR "The spool reader is now off."
?L16:	PRINTR "It's not on!"
?L15:	EQUAL? PRSA,V?EXAMINE \?L23
	PRINTI "The machine has a small screen, and below that, a small circular opening. The screen is currently "
	FSET? SPOOL-READER,ONBIT \?L26
	FIRST? SPOOL-READER >STACK \?L26
	PRINTI "displaying some information:"
	CRLF
	PRINT SPOOL-TEXT
	CRLF
	RTRUE
?L26:	PRINTR "blank."
?L23:	EQUAL? PRSA,V?READ \?L35
	FSET? SPOOL-READER,ONBIT \?L36
	FIRST? SPOOL-READER >STACK \?L36
	PRINT SPOOL-TEXT
	CRLF
	RTRUE
?L36:	PRINTR "The screen is blank."
?L35:	EQUAL? PRSA,V?PUT \?L43
	EQUAL? PRSI,SPOOL-READER \?L43
	FIRST? SPOOL-READER >STACK \?L44
	PRINTR "There's already a spool in the reader."
?L44:	EQUAL? PRSO,GREEN-SPOOL \?L48
	SET 'SPOOL-TEXT,GREEN-TEXT
	MOVE GREEN-SPOOL,SPOOL-READER
	FSET GREEN-SPOOL,TRYTAKEBIT
	PRINT SPOOL-FITS
	FSET? SPOOL-READER,ONBIT \?L51
	PRINT SOME-INFO
?L51:	CRLF
	RTRUE
?L48:	EQUAL? PRSO,RED-SPOOL \?L58
	SET 'SPOOL-TEXT,RED-TEXT
	MOVE RED-SPOOL,SPOOL-READER
	FSET RED-SPOOL,TRYTAKEBIT
	PRINT SPOOL-FITS
	FSET? SPOOL-READER,ONBIT \?L61
	PRINT SOME-INFO
?L61:	CRLF
	RTRUE
?L58:	PRINTR "It doesn't fit in the circular opening."
?L43:	EQUAL? PRSA,V?CLOSE \FALSE
	CALL NO-CLOSE
	RTRUE

	.FUNCT PROJCON-OFFICE-F,RARG
	EQUAL? RARG,M-LOOK \?L1
	PRINTI "This office looks like a headquarters of some kind. Exits lead north and east. The west wall displays a logo. "
	ZERO? COMPUTER-FIXED /?L5
	PRINTR "The mural that previously adorned the south wall has slid away, revealing an open doorway to a large elevator!"
?L5:	PRINTR "The south wall is completely covered by a garish mural which clashes with the other decor of the room."
?L1:	EQUAL? RARG,M-END \FALSE
	IN? FLOYD,HERE \FALSE
	ZERO? MURAL-FLAG \FALSE
	SET 'MURAL-FLAG,1
	SET 'FLOYD-SPOKE,1
	PRINTR "Floyd surveys the mural and scratches his head. ""I don't remember seeing this before,"" he comments."

	.FUNCT CRYO-ELEVATOR-F,RARG
	EQUAL? RARG,M-LOOK \FALSE
	PRINTI "This is a large, plain elevator with one solitary button and a door to the north which is "
	CALL DDESC,CRYO-ELEVATOR-DOOR
	PRINTR "."

	.FUNCT CRYO-EXIT-F
	FSET? CRYO-ELEVATOR-DOOR,OPENBIT \?L1
	ZERO? CRYO-SCORE-FLAG /?L3
	RETURN CRYO-ANTEROOM
?L3:	RETURN PROJCON-OFFICE
?L1:	CALL DOOR-CLOSED
	RFALSE

	.FUNCT I-CRYO-ELEVATOR-ARRIVE
	FSET CRYO-ELEVATOR-DOOR,OPENBIT
	CRLF
	PRINTR "The elevator door opens onto a room to the north."

	.FUNCT CRYO-ANTEROOM-F,RARG
	EQUAL? RARG,M-LOOK \?L1
	PRINTI "The elevator closes as you leave it, and you find yourself in a small, chilly room. To the north, through a wide arch, is an enormous chamber lined from floor to ceiling with thousands of cryo-units. You can see similar chambers beyond, and your mind staggers at the thought of the millions of individuals asleep for countless centuries.

In the anteroom where you stand is a solitary cryo-unit, its cover frosted. Next to the cryo-unit is a complicated control panel."
	CRLF
	CRLF
	RTRUE
?L1:	EQUAL? RARG,M-END \FALSE
	PRINTI "A door slides open and a medical robot glides in. It opens the cryo-unit and administers an injection to its inhabitant. As the robot glides away, a figure rises from the cryo-unit -- a handsome, middle-aged woman with flowing red hair. She spends some time studying readouts from the control panel"
	ZERO? COMM-FIXED /?L8
	ZERO? DEFENSE-FIXED /?L8
	PRINTI ", pressing several keys."
	CRLF
	JUMP ?L12
?L8:	PRINTI "."
	CRLF
?L12:	ZERO? COURSE-CONTROL-FIXED /?L15
	PRINTI "
As other cryo-units in the chambers beyond begin opening, the woman turns to you, bows gracefully, and speaks in a beautiful, lilting voice. ""I am Veldina, leader of Resida. Thanks to you, the cure has been discovered, and the planetary systems repaired. We are eternally grateful."""
	CRLF
	ZERO? COMM-FIXED /?L19
	ZERO? DEFENSE-FIXED /?L19
	PRINTI "
""You will also be glad to hear that a ship of your Stellar Patrol now orbits the planet. I have sent them the coordinates for this room."" As if on cue, a landing party from the S.P.S. Flathead materializes nearby. Blather is with them, having been picked up from deep space in another escape pod, babbling cravenly. Captain Sterling of the Flathead acknowledges your heroic actions, and informs you of your promotion to Lieutenant First Class.

As a team of mutant hunters head for the cryo-elevator, Veldina mentions that the grateful people of Resida offer you leadership of their world. Captain Sterling points out that, even if you choose to remain on Resida, Blather (demoted to Ensign Twelfth Class) has been assigned as your personal toilet attendant.

You feel a sting from your arm and turn to see a medical robot moving away after administering the antidote for The Disease.

A team of robot technicians step into the anteroom. They part their ranks, and a familiar figure comes bounding toward you! ""Hi!"" shouts Floyd, with uncontrolled enthusiasm. ""Floyd feeling better now!"" Smiling from ear to ear, he says, ""Look what Floyd found!"" He hands you a helicopter key, a reactor elevator card, and a paddleball set. ""Maybe we can use them in the sequel..."""
	CRLF
	CRLF
	CALL FINISH,0 >STACK
	RSTACK
?L19:	PRINTI "
""Unfortunately, a second ship from your Stellar Patrol has "
	ZERO? DEFENSE-FIXED \?L26
	PRINTI "been destroyed by our malfunctioning meteor defenses."
	JUMP ?L30
?L26:	PRINTI "come looking for survivors, and because of our malfunctioning communications system, has given up and departed."
?L30:	PRINTI " I fear that you are stranded on Resida, possibly forever. However, we show our gratitude by offering you an unlimited bank account and a house in the country."""
	CRLF
	CRLF
	CALL FINISH,0 >STACK
	RSTACK
?L15:	PRINTI "
She turns to you and, with a strained voice says, ""You have fixed our computer and a Cure has been discovered, and we are grateful. But alas, it was all in vain. Our planetary course control system has malfunctioned, and the orbit has now decayed beyond correction. Soon Resida will plunge into the sun."""
	CRLF
	CRLF
	ZERO? COMM-FIXED /?L38
	ZERO? DEFENSE-FIXED /?L38
	PRINTI "Veldina examines the control panel again. ""Fortunately, another ship from your Stellar Patrol has arrived, so at least you will survive."" At that moment, a landing party from the S.P.S. Flathead materializes, and takes you away from the doomed world."
	CRLF
	CRLF
?L38:	CALL FINISH,0 >STACK
	RSTACK

	.FUNCT COMPUTER-ACTION
	SET 'COMPUTER-FLAG,1
	SET 'FLOYD-SPOKE,1
	PRINTI "Floyd examines the "
	EQUAL? HERE,COMPUTER-ROOM \?L3
	PRINTI "glowing light"
	JUMP ?L7
?L3:	PRINTI "computer printout"
?L7:	PRINTR ". With a concerned frown, he says, ""Uh oh. Computer is broken. A Doctor-person once told Floyd that Computer is the most important part of the Project."""

	.FUNCT PRINT-OUT-F
	EQUAL? PRSA,V?EXAMINE,V?READ \FALSE
	CALL FIXED-FONT-ON
	PRINTI "The printout is hundreds of pages long. It would take many chrons to read it all. The last page looks pretty interesting, though:

""Daalee Statis Reeport:
PREELIMINEREE REESURC:  100.000%
INTURMEEDEEIT REESURC:  100.000%
FIINUL REESURC:         100.000%
DRUG PROODUKSHUN:       100.000%
DRUG TESTEENG:           99.985%
Proojektid tiim tuu reeviivul prooseedzur:  0 daaz, 0.8 kronz


*** ALURT! ALURT! ***
Malfunkshun in Sekshun 384! Sumuneeng reepaar roobot.""

The printout ends at this point."
	CRLF
	CALL FIXED-FONT-OFF >STACK
	RSTACK

	.FUNCT MINI-CARD-F
	FSET? MINI-CARD,NDESCBIT \FALSE
	EQUAL? PRSA,V?SMELL,V?PULL,V?PUSH /?L3
	EQUAL? PRSA,V?TAKE,V?SET /?L3
	EQUAL? PRSA,V?TURN,V?MOVE,V?RUB \FALSE
?L3:	PRINTR "It's in the next room."

	.FUNCT LAB-UNIFORM-F
	EQUAL? PRSA,V?EXAMINE \?L1
	PRINTI "It is a plain lab uniform. The logo above the pocket depicts a flame burning above some kind of sleep chamber. The pocket is "
	CALL DDESC,LAB-UNIFORM
	PRINTR "."
?L1:	EQUAL? PRSA,V?OPEN,V?SEARCH \?L7
	FSET? LAB-UNIFORM,OPENBIT \?L8
	PRINTR "The pocket is already open."
?L8:	FSET LAB-UNIFORM,OPENBIT
	ZERO? UNIFORM-OPENED /?L13
	FIRST? LAB-UNIFORM >STACK \?L15
	PRINTI "Opening the uniform's pocket reveals "
	CALL PRINT-CONTENTS,LAB-UNIFORM
	PRINTR "."
?L15:	PRINTR "The pocket is empty."
?L13:	FSET LAB-UNIFORM,OPENBIT
	SET 'UNIFORM-OPENED,1
	PRINTR "You discover a small piece of paper and a teleportation access card in the pocket of the uniform."
?L7:	EQUAL? PRSA,V?WEAR \FALSE
	FSET? PATROL-UNIFORM,WORNBIT \FALSE
	PRINTR "It won't fit on top of the Patrol uniform."

	.FUNCT COMBINATION-PAPER-F
	EQUAL? PRSA,V?EXAMINE,V?READ \FALSE
	PRINTI "Week uv 14-Juun--2882. Kombinaashun tuu Konfurins Ruum: "
	PRINTN NUMBER-NEEDED
	PRINTR "."

	.FUNCT BIO-LOCK-EAST-F,RARG
	EQUAL? RARG,M-END \FALSE
	IN? FLOYD,HERE \FALSE
	FSET? FLOYD,RLANDBIT \FALSE
	EQUAL? FLOYD,WINNER /FALSE
	ZERO? FLOYD-WAITING /?L3
	GRTR? WAITING-COUNTER,3 \?L5
	SET 'FLOYD-WAITING,0
	SET 'FLOYD-GAVE-UP,1
	SET 'FLOYD-SPOKE,1
	SET 'FLOYD-FOLLOW,0
	MOVE FLOYD,BIO-LOCK-WEST
	CALL QUEUE,I-FLOYD,1 >STACK
	PUT STACK,0,1
	PRINTR """Okay,"" says Floyd with uncharacteristic annoyance. ""Forget about the stupid card."" He goes to the other end of the bio-lock and sulks."
?L5:	ZERO? FLOYD-FORAYED \FALSE
	SET 'FLOYD-SPOKE,1
	INC 'WAITING-COUNTER
	PRINTR "Floyd looks at you with a dash of impatience and a healthy helping of nervousness. ""Well?"" he asks. ""Are you going to open the door?"""
?L3:	ZERO? FLOYD-GAVE-UP \FALSE
	ZERO? FLOYD-PEERED \FALSE
	SET 'FLOYD-SPOKE,1
	SET 'FLOYD-PEERED,1
	CALL QUEUE,I-CLEAR-FLOYD-PEER,40 >STACK
	PUT STACK,0,1
	FCLEAR MINI-CARD,INVISIBLE
	PRINTI "Floyd stands on his tiptoes and peers in the window. "
	ZERO? COMPUTER-FLAG /?L16
	SET 'FLOYD-WAITING,1
	PRINTR """Looks dangerous in there,"" says Floyd. ""I don't think you should go inside."" He peers in again. ""We'll need card there to fix computer. Hmmm... I know! Floyd will get card. Robots are tough. Nothing can hurt robots. You open the door, then Floyd will rush in. Then you close door. When Floyd knocks, open door again. Okay? Go!"" Floyd's voice trembles slightly as he waits for you to open the door."
?L16:	PRINTR """Ooo, look,"" he says. ""There's a miniaturization booth access card!"""

	.FUNCT I-CLEAR-FLOYD-PEER
	SET 'FLOYD-PEERED,0
	RFALSE

	.FUNCT BIO-DOOR-EAST-F
	EQUAL? PRSA,V?OPEN \?L1
	FSET? BIO-DOOR-EAST,OPENBIT \?L3
	CALL ALREADY-OPEN >STACK
	RSTACK
?L3:	FSET? BIO-DOOR-WEST,OPENBIT \?L5
	PRINT BOTH-DOORS
	CRLF
	RTRUE
?L5:	ZERO? FLOYD-WAITING /?L8
	FSET? FLOYD,RLANDBIT \?L8
	ZERO? FORAY-COUNTER \?L8
	CALL QUEUE,I-FLOYD-FORAY,-1 >STACK
	PUT STACK,0,1
	SET 'FLOYD-FORAYED,1
	FSET BIO-DOOR-EAST,OPENBIT
	REMOVE FLOYD
	CALL INT,I-FLOYD >STACK
	PUT STACK,0,0
	PRINTR "The door opens and Floyd, pausing only for the briefest moment, plunges into the Bio Lab. Immediately, he is set upon by hideous, mutated monsters! More are heading straight toward the open door! Floyd shrieks and yells to you to close the door."
?L8:	ZERO? FLOYD-FORAYED \?L11
	CALL INT,I-CHASE-SCENE >STACK
	GET STACK,C-ENABLED? >STACK
	ZERO? STACK \?L11
	CALL JIGS-UP,STR?100 >STACK
	RSTACK
?L11:	FSET BIO-DOOR-EAST,OPENBIT
	CALL QUEUE,I-BIO-EAST-CLOSES,30 >STACK
	PUT STACK,0,1
	PRINT DOOR-OPENS
	CRLF
	RTRUE
?L1:	EQUAL? PRSA,V?CLOSE \FALSE
	FSET? BIO-DOOR-EAST,OPENBIT \?L16
	EQUAL? FORAY-COUNTER,4 \?L18
	SET 'C-ELAPSED,95
?L18:	FCLEAR BIO-DOOR-EAST,OPENBIT
	PRINTI "The door closes"
	CALL INT,I-CHASE-SCENE >STACK
	GET STACK,C-ENABLED? >STACK
	EQUAL? STACK,1 \?L23
	PRINTR ", but not soon enough!"
?L23:	PRINTR "."
?L16:	CALL IS-CLOSED >STACK
	RSTACK

	.FUNCT I-BIO-EAST-CLOSES
	FSET? BIO-DOOR-EAST,OPENBIT \FALSE
	FCLEAR BIO-DOOR-EAST,OPENBIT
	EQUAL? HERE,BIO-LOCK-EAST,BIO-LOCK-WEST,BIO-LAB \FALSE
	CRLF
	PRINTR "The door at the eastern end of the bio-lock closes silently."

	.FUNCT BIO-DOOR-WEST-F
	EQUAL? PRSA,V?OPEN \?L1
	FSET? BIO-DOOR-WEST,OPENBIT \?L3
	CALL ALREADY-OPEN >STACK
	RSTACK
?L3:	FSET? BIO-DOOR-EAST,OPENBIT \?L5
	PRINT BOTH-DOORS
	CRLF
	RTRUE
?L5:	PRINT DOOR-OPENS
	CRLF
	CALL QUEUE,I-BIO-WEST-CLOSES,30 >STACK
	PUT STACK,0,1
	FSET BIO-DOOR-WEST,OPENBIT
	RTRUE
?L1:	EQUAL? PRSA,V?CLOSE \FALSE
	FSET? BIO-DOOR-WEST,OPENBIT \?L12
	FCLEAR BIO-DOOR-WEST,OPENBIT
	PRINT DOOR-CLOSES
	CRLF
	RTRUE
?L12:	CALL IS-CLOSED >STACK
	RSTACK

	.FUNCT I-BIO-WEST-CLOSES
	FSET? BIO-DOOR-WEST,OPENBIT \FALSE
	FCLEAR BIO-DOOR-WEST,OPENBIT
	EQUAL? HERE,BIO-LOCK-WEST,BIO-LOCK-EAST,MAIN-LAB \FALSE
	CRLF
	PRINTR "The door at the western end of the bio-lock closes silently."

	.FUNCT RAD-DOOR-EAST-F
	EQUAL? PRSA,V?OPEN \?L1
	FSET? RAD-DOOR-EAST,OPENBIT \?L3
	CALL ALREADY-OPEN >STACK
	RSTACK
?L3:	FSET? RAD-DOOR-WEST,OPENBIT \?L5
	PRINT BOTH-DOORS
	CRLF
	RTRUE
?L5:	FSET RAD-DOOR-EAST,OPENBIT
	PRINT DOOR-OPENS
	CRLF
	RTRUE
?L1:	EQUAL? PRSA,V?CLOSE \FALSE
	FSET? RAD-DOOR-EAST,OPENBIT \?L12
	FCLEAR RAD-DOOR-EAST,OPENBIT
	PRINT DOOR-CLOSES
	CRLF
	RTRUE
?L12:	CALL IS-CLOSED >STACK
	RSTACK

	.FUNCT RAD-DOOR-WEST-F
	EQUAL? PRSA,V?OPEN \?L1
	FSET? RAD-DOOR-WEST,OPENBIT \?L3
	CALL ALREADY-OPEN >STACK
	RSTACK
?L3:	FSET? RAD-DOOR-EAST,OPENBIT \?L5
	PRINT BOTH-DOORS
	CRLF
	RTRUE
?L5:	PRINT DOOR-OPENS
	CRLF
	FSET RAD-DOOR-WEST,OPENBIT
	RTRUE
?L1:	EQUAL? PRSA,V?CLOSE \FALSE
	FSET? RAD-DOOR-WEST,OPENBIT \?L12
	FCLEAR RAD-DOOR-WEST,OPENBIT
	PRINT DOOR-CLOSES
	CRLF
	RTRUE
?L12:	CALL IS-CLOSED >STACK
	RSTACK

	.FUNCT I-FLOYD-FORAY
	INC 'FORAY-COUNTER
	EQUAL? FORAY-COUNTER,2 \?L1
	FSET? BIO-DOOR-EAST,OPENBIT \?L3
	CRLF
	CALL MONSTER-DEATH >STACK
	RSTACK
?L3:	CRLF
	PRINTR "From within the lab you hear ferocious growlings, the sounds of a skirmish, and then a high-pitched metallic scream!"
?L1:	EQUAL? FORAY-COUNTER,3 \?L8
	FSET? BIO-DOOR-EAST,OPENBIT \?L9
	CRLF
	CALL MONSTER-DEATH >STACK
	RSTACK
?L9:	CRLF
	PRINTR "You hear, slightly muffled by the door, three fast knocks, followed by the distinctive sound of tearing metal."
?L8:	EQUAL? FORAY-COUNTER,4 \?L14
	FSET? BIO-DOOR-EAST,OPENBIT \?L15
	MOVE FLOYD,HERE
	CRLF
	PRINTR "Floyd stumbles out of the Bio Lab, clutching the mini-booth card. The mutations rush toward the open doorway!"
?L15:	CRLF
	PRINTI "The three knocks come again, followed by a wild scream. Then, all is silence from within the Bio Lab, except for an occasional metallic crunch."
	CRLF
	FCLEAR FLOYD,RLANDBIT
	CALL INT,I-FLOYD-FORAY >STACK
	PUT STACK,0,0
	RTRUE
?L14:	EQUAL? FORAY-COUNTER,5 \FALSE
	FSET? BIO-DOOR-EAST,OPENBIT \?L23
	CRLF
	CALL MONSTER-DEATH >STACK
	RSTACK
?L23:	REMOVE FLOYD
	FCLEAR FLOYD,RLANDBIT
	CALL INT,I-FLOYD >STACK
	PUT STACK,0,0
	FSET FLOYD,INVISIBLE
	MOVE DEAD-FLOYD,HERE
	MOVE MINI-CARD,BIO-LOCK-EAST
	FSET MINI-CARD,TOUCHBIT
	ADD SCORE,2 >SCORE
	CRLF
	PRINTI "And not a moment too soon! You hear a pounding from the door as the monsters within vent their frustration at losing their prey.

Floyd staggers to the ground, dropping the mini card. He is badly torn apart, with loose wires and broken circuits everywhere. Oil flows from his lubrication system. He obviously has only moments to live.

You drop to your knees and cradle Floyd's head in your lap. Floyd looks up at his friend with half-open eyes. ""Floyd did it ... got card. Floyd a good friend, huh?"" Quietly, you sing Floyd's favorite song, the Ballad of the Starcrossed Miner:

O, they ruled the solar system
Near ten thousand years before
In their single starcrossed scout ships
Mining ast'roids, spinning lore.

Then one true courageous miner
Spied a spaceship from the stars
Boarded he that alien liner
Out beyond the orb of Mars.

Yes, that ship was filled with danger
Mighty monsters barred his way
Yet he solved the alien myst'ries
Mining quite a lode that day.

O, they ruled the solar system
Near ten thousand years before
'Til one brave advent'rous spirit
Brought that mighty ship to shore.

As you finish the last verse, Floyd smiles with contentment, and then his eyes close as his head rolls to one side. You sit in silence for a moment, in memory of a brave friend who gave his life so that you might live."
	CRLF
	FCLEAR FLOYD,RLANDBIT
	FCLEAR MINI-CARD,NDESCBIT
	CALL INT,I-FLOYD-FORAY >STACK
	PUT STACK,0,0
	RTRUE

	.FUNCT MONSTER-DEATH
	CALL JIGS-UP,STR?101 >STACK
	RSTACK

	.FUNCT BIO-LAB-F,RARG
	EQUAL? RARG,M-LOOK \?L1
	PRINTI "This is a huge laboratory filled with many biological experiments. The lighting is "
	ZERO? LAB-LIGHTS-ON /?L5
	PRINTI "bright."
	JUMP ?L9
?L5:	PRINTI "dim, and a faint blue glow comes from a gaping crack in the northern wall."
?L9:	PRINTR " Some of the experiments seem to be out of control..."
?L1:	EQUAL? RARG,M-END \FALSE
	CALL QUEUE,I-CHASE-SCENE,-1 >STACK
	PUT STACK,0,1
	ZERO? LAB-FLOODED /?L15
	PRINTI "The air is filled with mist, which is affecting the mutants. They appear to be stunned and confused, but are slowly recovering."
	CRLF
	FSET? GAS-MASK,WORNBIT /FALSE
	CALL JIGS-UP,STR?102 >STACK
	RSTACK
?L15:	CALL JIGS-UP,STR?103 >STACK
	RSTACK

	.FUNCT I-CHASE-SCENE
	IN? RAT-ANT,HERE \?L1
	ZERO? LAB-FLOODED \?L22
	CALL JIGS-UP,STR?104
	JUMP ?L22
?L1:	ZERO? LAB-FLOODED \?L22
	EQUAL? HERE,BIO-LOCK-WEST \?L4
	ZERO? EXTRA-MOVE-FLAG \?L4
	SET 'EXTRA-MOVE-FLAG,1
	CRLF
	PRINTI "The monsters gallop toward you, smacking their lips."
	CRLF
	JUMP ?L22
?L4:	EQUAL? HERE,CRYO-ELEVATOR \?L8
	ZERO? CRYO-MOVE-FLAG \?L8
	SET 'CRYO-MOVE-FLAG,1
	CRLF
	PRINTI "The monsters are storming straight toward the elevator door!"
	CRLF
	JUMP ?L22
?L8:	EQUAL? HERE,SECOND-TO-LAST-ROOM \?L11
	EQUAL? PRSA,V?WALK \?L11
	CALL JIGS-UP,STR?105
	JUMP ?L22
?L11:	EQUAL? HERE,CRYO-ELEVATOR \?L13
	CRLF
	CALL MONSTER-DEATH
?L13:	MOVE RAT-ANT,HERE
	MOVE TRIFFID,HERE
	MOVE TROLL,HERE
	MOVE GRUE,HERE
	CRLF
	PRINTI "The mutants "
	EQUAL? HERE,BIO-LOCK-WEST \?L18
	PRINTI "are almost upon you now!"
	CRLF
	JUMP ?L22
?L18:	PRINTI "burst into the room right on your heels! "
	CALL PICK-ONE,MONSTER-ENTRANCES >STACK
	PRINT STACK
	CRLF
?L22:	SET 'SECOND-TO-LAST-ROOM,LAST-CHASE-ROOM
	SET 'LAST-CHASE-ROOM,HERE
	RETURN LAST-CHASE-ROOM

	.FUNCT RADIATION-LAB-F,RARG
	EQUAL? RARG,M-ENTER \FALSE
	FSET? RADIATION-LAB,TOUCHBIT /FALSE
	CALL QUEUE,I-NUKED-BLUE,50 >STACK
	PUT STACK,0,1
	RTRUE

	.FUNCT I-NUKED-BLUE
	CALL QUEUE,I-NUKED-BLUE,-1 >STACK
	PUT STACK,0,1
	INC 'NUKED-COUNTER
	EQUAL? NUKED-COUNTER,1 \?L1
	CRLF
	PRINTR "You suddenly feel sick and dizzy."
?L1:	EQUAL? NUKED-COUNTER,2 \?L5
	CRLF
	PRINTI "You feel incredibly nauseous and begin vomiting. Also, all your hair has fallen out."
	IN? FLOYD,HERE \?L8
	PRINTI " Floyd points at you and laughs hysterically. ""You look funny with no hair,"" he gasps."
?L8:	CRLF
	RTRUE
?L5:	EQUAL? NUKED-COUNTER,3 \FALSE
	CALL JIGS-UP,STR?106 >STACK
	RSTACK

	.FUNCT LAMP-F
	EQUAL? PRSA,V?LAMP-ON \?L1
	FSET? LAMP,ONBIT \?L3
	PRINTR "It is on."
?L3:	FSET LAMP,ONBIT
	FSET LAMP,TOUCHBIT
	PRINTR "The lamp is now producing a bright light."
?L1:	EQUAL? PRSA,V?LAMP-OFF \FALSE
	FSET? LAMP,ONBIT \?L11
	FCLEAR LAMP,ONBIT
	PRINTR "The lamp goes dark."
?L11:	PRINTR "It isn't on."

	.FUNCT LAB-OFFICE-F,RARG
	EQUAL? RARG,M-LOOK \?L1
	PRINTI "This is the office for storing files on Bio Lab experiments. A large and messy desk is surrounded by locked files. A small booth lies to the south. "
	FSET? OFFICE-DOOR,OPENBIT \?L5
	PRINTI "An open"
	JUMP ?L9
?L5:	PRINTI "A closed"
?L9:	PRINTR " door to the west is labelled ""Biioo Lab."" You realize with shock and horror that the only way out is through the mutant-infested Bio Lab.

On the wall are three buttons: a white button labelled ""Lab Liits On"", a black button labelled ""Lab Liits Of"", and a red button labelled ""Eemurjensee Sistum."""
?L1:	EQUAL? RARG,M-END \FALSE
	FSET? OFFICE-DOOR,OPENBIT \FALSE
	ZERO? LAB-FLOODED /?L15
	PRINTR "Through the open doorway you can see the Bio Lab. It seems to be filled with a light mist. Horrifying biological nightmares stagger about making choking noises."
?L15:	CALL JIGS-UP,STR?107 >STACK
	RSTACK

	.FUNCT LAB-DESK-F
	EQUAL? PRSA,V?SEARCH,V?EXAMINE \?L1
	FSET? LAB-DESK,TOUCHBIT /?L1
	MOVE MEMO,ADVENTURER
	FSET LAB-DESK,TOUCHBIT
	PRINTI "After inspecting the various papers on the desk, you find only one item of interest, a memo of some sort. The desk itself is "
	FSET? LAB-DESK,OPENBIT \?L5
	PRINTI "open"
	JUMP ?L9
?L5:	PRINTI "closed, but it doesn't look locked"
?L9:	PRINTR "."
?L1:	EQUAL? PRSA,V?OPEN \FALSE
	IN? GAS-MASK,LAB-DESK \FALSE
	CALL THIS-IS-IT,GAS-MASK
	RFALSE

	.FUNCT LIGHT-BUTTON-F
	EQUAL? PRSA,V?PUSH \FALSE
	ZERO? LAB-LIGHTS-ON /?L3
	PRINTR "Nothing happens."
?L3:	SET 'LAB-LIGHTS-ON,1
	PRINT FAINT-SOUND
	CRLF
	RTRUE

	.FUNCT DARK-BUTTON-F
	EQUAL? PRSA,V?PUSH \FALSE
	ZERO? LAB-LIGHTS-ON /?L3
	SET 'LAB-LIGHTS-ON,0
	PRINT FAINT-SOUND
	CRLF
	RTRUE
?L3:	PRINTR "Nothing happens."

	.FUNCT FUNGICIDE-BUTTON-F
	EQUAL? PRSA,V?PUSH \FALSE
	SET 'LAB-FLOODED,1
	CALL QUEUE,I-UNFLOOD,50 >STACK
	PUT STACK,0,1
	PRINTR "You hear a hissing from beyond the door to the west."

	.FUNCT I-UNFLOOD
	SET 'LAB-FLOODED,0
	EQUAL? HERE,BIO-LAB \?L1
	CRLF
	PRINTR "The last traces of mist in the air vanish. The mutants, recovering quickly, notice you and begin salivating."
?L1:	EQUAL? HERE,LAB-OFFICE \FALSE
	FSET? OFFICE-DOOR,OPENBIT \FALSE
	CRLF
	PRINTR "The mist in the Bio Lab clears. The mutants recover and rush toward the door!"

	.FUNCT I-TURNOFF-MINI
	SET 'MINI-ACTIVATED,0
	EQUAL? HERE,MINI-BOOTH \FALSE
	CRLF
	PRINTR "A recorded voice says ""Miniaturization booth de-activated."""

	.FUNCT STATION-384-F,RARG
	EQUAL? RARG,M-ENTER \FALSE
	ZERO? BEEN-HERE /FALSE
	SET 'BEEN-HERE,0
	ZERO? COMPUTER-FIXED /?L5
	PRINTI "A voice seems to whisper in your ear ""Main Miniaturization and Teleportation Booth has malfunctioned...switching to Auxiliary Booth..."" "
	CALL QUEUE,I-ANNOUNCEMENT,130 >STACK
	PUT STACK,0,1
	PRINT FAMILIAR-WRENCHING
	CRLF
	CALL GOTO,AUXILIARY-BOOTH
	RETURN 2
?L5:	PRINT FAMILIAR-WRENCHING
	CRLF
	CALL GOTO,MINI-BOOTH,0 >STACK
	RSTACK

	.FUNCT I-ANNOUNCEMENT
	CRLF
	PRINTR "A recorded announcement blares from the public address system. ""Revival procedure beginning. Cryo-chamber access from Project Control Office now open."""

	.FUNCT MIDDLE-OF-STRIP-F,RARG
	EQUAL? RARG,M-ENTER \FALSE
	ZERO? COMPUTER-FIXED /FALSE
	ZERO? NO-MICROBE /FALSE
	ZERO? MICROBE-DISPATCHED \FALSE
	MOVE MICROBE,HERE
	CALL QUEUE,I-MICROBE,-1 >STACK
	PUT STACK,0,1
	SET 'NO-MICROBE,0
	PRINTI "Suddenly, with a loud plop, a giant elephant-sized monster lands on the strip just in front of you. It is amorphously shaped, its skin a slimy translucent red membrane. While most of your brain screams with panic about the disgusting monster that now blocks your exit, some small section in the back of your mind calmly realizes that this is merely some tiny microbe which has somehow violated the sterile environment of the computer interior.

As you stand frozen with fear, the microbe slithers toward you, extending slimy pseudopods thick with waving cilia. It looks pretty hungry, and seems intent on having you for lunch."
	CRLF
	CRLF
	RTRUE

	.FUNCT STRIP-NEAR-RELAY-F,RARG
	EQUAL? RARG,M-LOOK \?L1
	PRINTI "North of here, the filament ends at a huge featureless wall, presumably the side of some micro-component. "
	IN? RELAY,HERE \?L5
	PRINTR "To the east is a vacuu-sealed micro-relay, sealed in transparent red plastic. You could probably see into the micro-relay."
?L5:	PRINTR "To the east are the shattered remains of some large object."
?L1:	EQUAL? RARG,M-ENTER \FALSE
	ZERO? NO-MICROBE \FALSE
	MOVE MICROBE,HERE
	SET 'MICROBE-COUNTER,0
	PRINTR "The microbe, writhing angrily, follows you northward."

	.FUNCT RELAY-EXIT-F
	IN? RELAY,HERE \?L1
	PRINTI "The relay is sealed. Although you cannot enter it, you could look into it."
	CRLF
	RFALSE
?L1:	PRINTI "You would slice yourself to ribbons on the shattered relay."
	CRLF
	RFALSE

	.FUNCT RELAY-F
	EQUAL? PRSA,V?LOOK-INSIDE,V?EXAMINE \FALSE
	PRINTI "This is a vacuum-sealed micro-relay, encased in red translucent plastic."
	ZERO? COMPUTER-FIXED \?L5
	PRINTI " Within, you can see that some sort of speck or impurity has wedged itself into the contact point of the relay, preventing it from closing. The speck, presumably of microscopic size, resembles a blue boulder to you in your current size."
?L5:	CRLF
	RTRUE

	.FUNCT LASER-DIAL-F
	EQUAL? PRSA,V?SET \?L1
	EQUAL? PRSI,INTNUM \?L1
	FSET? LASER-DIAL,MUNGEDBIT \?L3
	PRINTR "The laser dial seems to have become damaged and will not turn."
?L3:	EQUAL? P-NUMBER,LASER-SETTING \?L7
	PRINTR "That's where it's set now!"
?L7:	GRTR? P-NUMBER,6 /?L11
	ZERO? P-NUMBER \?L10
?L11:	PRINTR "The dial can only be set from 1 to 6."
?L10:	SET 'LASER-SETTING,P-NUMBER
	PRINTI "The dial is now set to "
	PRINTN P-NUMBER
	PRINTR "."
?L1:	EQUAL? PRSA,V?EXAMINE \FALSE
	PRINTI "The dial is currently set to "
	PRINTN LASER-SETTING
	PRINTR "."

	.FUNCT ZAP-COUNT
	IN? OLD-BATTERY,LASER \?L1
	GRTR? OLD-SHOTS,0 \TRUE
	DEC 'OLD-SHOTS
	RFALSE
?L1:	IN? NEW-BATTERY,LASER \TRUE
	GRTR? NEW-SHOTS,0 \TRUE
	DEC 'NEW-SHOTS
	RFALSE

	.FUNCT LASER-F,RARG=0
	EQUAL? PRSA,V?SET \?L1
	EQUAL? PRSI,INTNUM \?L1
	CALL PERFORM,V?SET,LASER-DIAL,PRSI
	RTRUE
?L1:	EQUAL? PRSA,V?EXAMINE \?L3
	PRINTI "The laser, though portable, is still fairly heavy. It has a long, slender barrel and a dial with six settings, labelled ""1"" through ""6."" This dial is currently on setting "
	PRINTN LASER-SETTING
	PRINTI ". There is a depression on the top of the laser which "
	IN? OLD-BATTERY,LASER \?L6
	PRINTI "contains an "
	PRINTD OLD-BATTERY
	JUMP ?L13
?L6:	IN? NEW-BATTERY,LASER \?L10
	PRINTI "contains a "
	PRINTD NEW-BATTERY
	JUMP ?L13
?L10:	PRINTI "is empty"
?L13:	PRINTR "."
?L3:	EQUAL? PRSA,V?CLOSE,V?OPEN \?L18
	PRINTR "There doesn't seem to be any way to do that to this laser."
?L18:	EQUAL? PRSA,V?PUT \?L21
	EQUAL? PRSO,OLD-BATTERY \?L22
	IN? NEW-BATTERY,LASER \?L24
	CALL ALREADY-BATTERY >STACK
	RSTACK
?L24:	MOVE OLD-BATTERY,LASER
	CALL BATTERY-NOW >STACK
	RSTACK
?L22:	EQUAL? PRSO,NEW-BATTERY \?L27
	IN? OLD-BATTERY,LASER \?L28
	CALL ALREADY-BATTERY >STACK
	RSTACK
?L28:	MOVE NEW-BATTERY,LASER
	CALL BATTERY-NOW >STACK
	RSTACK
?L27:	EQUAL? LASER,PRSO /FALSE
	PRINTI "The "
	PRINTD PRSO
	PRINTR " doesn't fit the depression."
?L21:	EQUAL? PRSA,V?ZAP \?L35
	IN? LASER,ADVENTURER /?L36
	CALL NOT-HOLDING
	RTRUE
?L36:	ZERO? LASER-SCORE-FLAG \?L39
	SET 'LASER-SCORE-FLAG,1
	ADD SCORE,2 >SCORE
?L39:	EQUAL? PRSI,LASER,LASER-DIAL /?L44
	EQUAL? PRSI,OLD-BATTERY \?L45
	IN? OLD-BATTERY,LASER /?L44
?L45:	EQUAL? PRSI,NEW-BATTERY \?L42
	IN? NEW-BATTERY,LASER \?L42
?L44:	PRINTR "Sorry, the laser doesn't have a rubber barrel."
?L42:	CALL ZAP-COUNT >STACK
	ZERO? STACK /?L48
	PRINTR "Click."
?L48:	FSET? LASER,MUNGEDBIT \?L51
	PRINTR "The laser sparks a few times, whines, and then stops."
?L51:	CALL QUEUE,I-WARMTH,-1 >STACK
	PUT STACK,0,1
	SET 'LASER-JUST-SHOT,1
	EQUAL? PRSI,SPECK \?L55
	CALL SHOOT-SPECK
	RTRUE
?L55:	EQUAL? PRSI,MICROBE \?L57
	CALL SHOOT-MICROBE
	RTRUE
?L57:	EQUAL? PRSI,ME,HANDS,ADVENTURER \?L58
	PRINTR "Ouch! You managed to burn yourself nicely."
?L58:	PRINTI "The laser emits a narrow "
	CALL BEAM-COLOR
	PRINTI " beam of light"
	ZERO? PRSI /?L66
	EQUAL? PRSI,TOWEL,BROCHURE,COMBINATION-PAPER /?L70
	EQUAL? PRSI,PRINT-OUT,LAB-UNIFORM,PATROL-UNIFORM /?L70
	EQUAL? PRSI,ID-CARD,KITCHEN-CARD,MINI-CARD /?L70
	EQUAL? PRSI,TELEPORTATION-CARD,SHUTTLE-CARD,UPPER-ELEVATOR-CARD /?L70
	EQUAL? PRSI,LOWER-ELEVATOR-CARD \?L68
?L70:	REMOVE PRSI
	EQUAL? PRSI,SPOUT-PLACED \?L71
	SET 'SPOUT-PLACED,GROUND
?L71:	PRINTI " which strikes the "
	PRINTD PRSI
	PRINTI ". The "
	PRINTD PRSI
	PRINTR " bursts into flame, blinding you momentarily, and is quickly consumed."
?L68:	EQUAL? PRSI,FLOYD \?L76
	FSET? FLOYD,RLANDBIT \?L76
	PRINTR " which strikes Floyd. ""Yow!"" yells Floyd. He jumps to the other end of the room and eyes you warily."
?L76:	EQUAL? PRSI,PSEUDO-OBJECT \?L79
	EQUAL? HERE,PROJCON-OFFICE \?L79
	PRINTI " which strikes the "
	PRINTD PRSI
	PRINTR ". However, this doesn't seem to affect it."
?L79:	PRINTI " which strikes the "
	PRINTD PRSI
	PRINTI ". The "
	PRINTD PRSI
	PRINTR " grows a bit warm, but nothing else happens."
?L66:	PRINTR "."
?L35:	EQUAL? PRSA,V?DROP \FALSE
	CALL INT,I-WARMTH >STACK
	PUT STACK,0,0
	IN? MICROBE,HERE \FALSE
	GRTR? WARMTH-FLAG,7 \FALSE
	REMOVE LASER
	PRINTR "The microbe rushes to envelop the laser. You hear a faint burp as the monster begins to look around for other morsels..."

	.FUNCT ALREADY-BATTERY
	PRINTR "There's already a battery there."

	.FUNCT BATTERY-NOW
	PRINTR "The battery is now resting in the depression, attached to the laser."

	.FUNCT I-WARMTH
	ZERO? LASER-JUST-SHOT /?L1
	SET 'LASER-JUST-SHOT,0
	INC 'WARMTH-FLAG
	EQUAL? WARMTH-FLAG,3 \?L3
	CALL LASER-FEELS,STR?108 >STACK
	RSTACK
?L3:	EQUAL? WARMTH-FLAG,6 \?L5
	CALL LASER-FEELS,STR?109 >STACK
	RSTACK
?L5:	EQUAL? WARMTH-FLAG,9 \?L6
	CALL LASER-FEELS,STR?110 >STACK
	RSTACK
?L6:	EQUAL? WARMTH-FLAG,12 \FALSE
	CALL LASER-FEELS,STR?111 >STACK
	RSTACK
?L1:	ZERO? WARMTH-FLAG \?L10
	CALL INT,I-WARMTH >STACK
	PUT STACK,0,0
	RTRUE
?L10:	DEC 'WARMTH-FLAG
	EQUAL? WARMTH-FLAG,12 \?L13
	CALL LASER-COOLS,STR?111 >STACK
	RSTACK
?L13:	EQUAL? WARMTH-FLAG,9 \?L15
	CALL LASER-COOLS,STR?112 >STACK
	RSTACK
?L15:	EQUAL? WARMTH-FLAG,6 \?L16
	CALL LASER-COOLS,STR?113 >STACK
	RSTACK
?L16:	EQUAL? WARMTH-FLAG,3 \FALSE
	CALL LASER-COOLS,STR?114 >STACK
	RSTACK

	.FUNCT LASER-FEELS,STRING
	CRLF
	PRINTI "The laser feels "
	PRINT STRING
	PRINTR ", but that doesn't seem to affect its performance at all."

	.FUNCT LASER-COOLS,STRING
	CRLF
	PRINTI "The laser has cooled, but it still feels "
	PRINT STRING
	PRINTR "."

	.FUNCT BEAM-COLOR
	EQUAL? LASER-SETTING,1 \?L1
	PRINTI "red"
	RTRUE
?L1:	EQUAL? LASER-SETTING,2 \?L5
	PRINTI "orange"
	RTRUE
?L5:	EQUAL? LASER-SETTING,3 \?L8
	PRINTI "yellow"
	RTRUE
?L8:	EQUAL? LASER-SETTING,4 \?L11
	PRINTI "green"
	RTRUE
?L11:	EQUAL? LASER-SETTING,5 \?L14
	PRINTI "blue"
	RTRUE
?L14:	EQUAL? LASER-SETTING,6 \FALSE
	PRINTI "violet"
	RTRUE

	.FUNCT SHOOT-SPECK
	EQUAL? LASER-SETTING,1 \?L1
	RANDOM 100 >STACK
	LESS? MARKSMANSHIP-COUNTER,STACK /?L3
	ZERO? SPECK-HIT /?L5
	SET 'COMPUTER-FIXED,1
	FSET CRYO-ELEVATOR-DOOR,OPENBIT
	FCLEAR PROJCON-OFFICE,TOUCHBIT
	FCLEAR CRYO-ELEVATOR-DOOR,INVISIBLE
	CALL QUEUE,I-FRY,200 >STACK
	PUT STACK,0,1
	ADD SCORE,8 >SCORE
	REMOVE SPECK
	PRINTR "The beam hits the speck again! This time, it vaporizes into a fine cloud of ash. The relay slowly begins to close, and a voice whispers in your ear ""Sector 384 will activate in 200 millichrons. Proceed to exit station."""
?L5:	SET 'SPECK-HIT,1
	PRINTR "The speck is hit by the beam! It sizzles a little, but isn't destroyed yet."
?L3:	ADD MARKSMANSHIP-COUNTER,12 >MARKSMANSHIP-COUNTER
	CALL PICK-ONE,BEAM-MISSES >STACK
	PRINT STACK
	CRLF
	RTRUE
?L1:	REMOVE RELAY
	PRINTI "A thin "
	CALL BEAM-COLOR
	PRINTR " beam shoots from the laser and slices through the red plastic covering of the relay like a hot knife through butter. Air rushes into the relay, which collapses into a heap of plastic shards."

	.FUNCT I-FRY
	EQUAL? HERE,MIDDLE-OF-STRIP,STRIP-NEAR-STATION,STRIP-NEAR-RELAY \FALSE
	CRLF
	CALL JIGS-UP,STR?115 >STACK
	RSTACK

	.FUNCT MICROBE-F
	EQUAL? PRSA,V?TALK,V?HELLO,V?TELL \?L1
	PRINTI "You don't seem to have bridged the vast communication gulf between yourself and the microbe."
	CRLF
	SET 'P-CONT,0
	SET 'QUOTE-FLAG,0
	RETURN 2
?L1:	EQUAL? PRSA,V?GIVE,V?THROW \FALSE
	EQUAL? PRSI,MICROBE \FALSE
	EQUAL? PRSO,LASER \FALSE
	GRTR? WARMTH-FLAG,7 \FALSE
	REMOVE LASER
	CALL INT,I-WARMTH >STACK
	PUT STACK,0,0
	GRTR? WARMTH-FLAG,10 \?L10
	CALL INT,I-MICROBE >STACK
	PUT STACK,0,0
	PRINTI "The microbe gobbles up the laser and turns toward you. A moment later, it begins writhing in pain. Apparently, eating the hot laser was a bit too much for it. With a bellow of agony, it rolls off the edge of the strip. (Whew!)"
	CRLF
	REMOVE LASER
	REMOVE MICROBE
	SET 'NO-MICROBE,1
	SET 'MICROBE-DISPATCHED,1
	RETURN MICROBE-DISPATCHED
?L10:	PRINTR "The microbe greedily devours the laser, and turns toward you."

	.FUNCT I-MICROBE
	EQUAL? MICROBE-HIT,1 \?L1
	CRLF
	CALL PICK-ONE,WINNER-ATTACKED >STACK
	PRINT STACK
	GRTR? WARMTH-FLAG,13 \?L5
	IN? LASER,ADVENTURER \?L5
	CALL JIGS-UP,STR?116
	JUMP ?L7
?L5:	GRTR? WARMTH-FLAG,7 \?L7
	IN? LASER,ADVENTURER \?L7
	PRINTI " Another pseudopod, perhaps attracted by the warmth of the laser, tries to envelop the weapon. You snatch it away from the monster's grasp."
?L7:	CRLF
	JUMP ?L14
?L1:	EQUAL? MICROBE-COUNTER,2 \?L12
	CALL JIGS-UP,STR?117
	JUMP ?L14
?L12:	INC 'MICROBE-COUNTER
	CRLF
	CALL PICK-ONE,MONSTER-CLOSES >STACK
	PRINT STACK
	CRLF
?L14:	SET 'MICROBE-HIT,0
	RETURN MICROBE-HIT

	.FUNCT SHOOT-MICROBE
	PRINTI "The laser beam strikes the microbe"
	EQUAL? LASER-SETTING,1 \?L3
	PRINTR ", but passes harmlessly through its red skin."
?L3:	SET 'MICROBE-HIT,1
	PRINTI ". "
	CALL PICK-ONE,MICROBE-STRIKES >STACK
	PRINT STACK
	CRLF
	RTRUE

	.FUNCT STRIP-F
	EQUAL? PRSA,V?THROW-OFF \FALSE
	EQUAL? PRSO,LASER \?L8
	GRTR? WARMTH-FLAG,7 \?L3
	CALL INT,I-WARMTH >STACK
	PUT STACK,0,0
	CALL INT,I-MICROBE >STACK
	PUT STACK,0,0
	PRINTI "As the laser flies over the edge of the strip, the hungry microbe lunges after it. Both the laser and the microbe plummet into the void. (Whew!)"
	CRLF
	REMOVE LASER
	REMOVE MICROBE
	SET 'NO-MICROBE,1
	SET 'MICROBE-DISPATCHED,1
	RETURN MICROBE-DISPATCHED
?L3:	EQUAL? PRSO,LASER \?L8
	CALL INT,I-WARMTH >STACK
	PUT STACK,0,0
?L8:	REMOVE PRSO
	PRINTI "The "
	PRINTD PRSO
	PRINTR " flies over the edge of the strip and disappears into the void."

	.FUNCT GRUE-F
	EQUAL? PRSA,V?EXAMINE \FALSE
	IN? GRUE,HERE /FALSE
	PRINTR "Grues are vicious, carnivorous beasts first introduced to Earth by a visiting alien spaceship during the late 22nd century. Grues spread throughout the galaxy alongside man. Although now extinct on all civilized planets, they still exist in some backwater corners of the galaxy. Their favorite diet is Ensigns Seventh Class, but their insatiable appetite is tempered by their fear of light."

	.INSERT "planetfall_str"
	.END

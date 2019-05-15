 9-Aug-88 19:12:36-EDT,615;000000000005
Date:  9 Aug 1988 1912-EDT
From: Timothy A. Anderson <TAA at FRED>
To: swg

XXZILCH has the new priority stuff; get LALR from <taa.parse>.
RED-ERR-PRIORITY is the error priority; RED-PRIORITY is the parse
priority.
To specify part-of-speech weighting, change the call to TERMINALS:
<TERMINALS (VERB 4) (NOUN 2) (ADJ 1) ...>
To give a priority to a production, give a fix as the first optional
argument to PRODUCTION (just before all the token types).
REDUCTION-RESULT and REDUCTION-NAME are only included in the debugging
version; they're the last two things in the reduction structure.
	-ta
-------

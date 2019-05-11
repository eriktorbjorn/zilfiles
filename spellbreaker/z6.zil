"Z6 for
				MAGE
	(c) Copyright 1985 Infocom, Inc. All Rights Reserved."

<COND (<GASSIGNED? ZILCH>
       <SETG ZDEBUGGING? <>>)
      (ELSE
       <SETG ZDEBUGGING? T>)>

<PRINC "
*** MAGE: Interactive Fantasy ***
">

ON!-INITIAL
OFF!-INITIAL

;<REPEAT (CHR)
	<PRINC "Debugging? (Y or N): " ,OUTCHAN>
	<SET CHR <TYI>>
	<COND (<MEMQ .CHR "Yy ">
	       <PRINC " Debugging!
" ,OUTCHAN>
	       <RETURN <SETG ZDEBUGGING? T>>)
	      (<MEMQ .CHR "Nn">
	       <PRINC " No debugging!
" ,OUTCHAN>
	       <RETURN <SETG ZDEBUGGING? <>>>)
	      (ELSE
	       <PRINC " ??
" ,OUTCHAN>)>>

<DEFINE DEBUG-CODE ('X "OPTIONAL" ('Y T))
	<COND (,ZDEBUGGING? .X)(ELSE .Y)>>

<SNAME "Z6">

<SET REDEFINE T>

<COND (<NOT <GASSIGNED? ZILCH>>
       <SETG WBREAKS <STRING !\" !,WBREAKS>>)>

<COND (<GASSIGNED? ZILCH>
       <ID 0>)>

<CONSTANT SERIAL 0>

<INSERT-FILE "misc" T>
<INSERT-FILE "parser" T>
<INSERT-FILE "syntax" T>
<INSERT-FILE "debug" T>
<INSERT-FILE "record" T>
<INSERT-FILE "interrupts" T>
<INSERT-FILE "verbs" T>
<INSERT-FILE "magic" T>
<INSERT-FILE "globals" T>
<INSERT-FILE "guild" T>
<INSERT-FILE "c1" T>
<INSERT-FILE "c2" T>
<INSERT-FILE "c3" T>
<INSERT-FILE "c4" T>

<PROPDEF SIZE 5>
<PROPDEF CAPACITY 0>

"B for BUREAUCRACY: (C)1987 Infocom, Inc. All Rights Reserved."

<VERSION EZIP>
<FUNNY-GLOBALS?>
<FREQUENT-WORDS?>
<LONG-WORDS?>

<SETG PRESERVE-SPACES? T>

<PRINC "
BUREAUCRACY: Interactive Fiction PLUS
">

ON!-INITIAL	"For DEBUGR."
OFF!-INITIAL
ENABLE!-INITIAL
DISABLE!-INITIAL

<SET REDEFINE T>

<OR <GASSIGNED? ZILCH>
    <SETG WBREAKS <STRING !\" !,WBREAKS>>>

<COND (<GASSIGNED? PREDGEN>
       <SETG ZSTR-ON <SETG ZSTR-OFF ,TIME>>
       ;<ID 0>)>

<OR <LOOKUP "DEBUGGING?" <ROOT>>
    <INSERT "DEBUGGING?" <ROOT>>>

;<SETG DEBUGGING? T>
<SETG DEBUGGING? <>>

; "Definitions only..."
<INSERT-FILE "random-globals" T>
<INSERT-FILE "old-parserdefs" T>
<INSERT-FILE "formdefs" T>
<INSERT-FILE "bankdefs" T>
<INSERT-FILE "computerdefs" T>
<INSERT-FILE "xxjetdefs" T>
<INSERT-FILE "macros" T>
<INSERT-FILE "syntax" T>
<INSERT-FILE "misc" T>
<INSERT-FILE "clocker" T>
<INSERT-FILE "parser" T>
<PUT-PURE-HERE>
<INSERT-FILE "other-misc" T>
<INSERT-FILE "verbs" T>
<INSERT-FILE "events" T>
<INSERT-FILE "people" T>
<INSERT-FILE "places" T>
<INSERT-FILE "things" T>
<INSERT-FILE "forms" T>
<INSERT-FILE "computer" T>
<INSERT-FILE "nnairport" T>
<INSERT-FILE "paranoid" T>
<INSERT-FILE "zalagasa" T>
<INSERT-FILE "maze" T>
<INSERT-FILE "mumble" T>
<CHECKPOINT "TAA-C.EXE" <> "TAA.EXE">
<INSERT-FILE "bank" T>
<INSERT-FILE "xxjet" T>
<PROPDEF SIZE 0>
<PROPDEF CAPACITY 0>

; <PROPDEF VALUE 0>


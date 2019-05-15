        TITLE   SIMIL.ASM written by John W. Ratcliff and David E. Metzener

; November 10, 1987
; Uses the Ratcliff/Obershelp pattern recognition algorithm.
; This program provides a new function to C on an 8086 based machine.
; The function SIMIL returns a percentage value corresponding to how
; alike any two strings are.  Be certain to upper case to two strings
; passed if you are not concerned about case sensitivity.
; NOTE:!!! This routine is for SMALL model only.  As an exerciese for
; the student, feel free to convert it to LARGE.

_TEXT   SEGMENT  BYTE PUBLIC 'CODE'
_TEXT   ENDS
CONST   SEGMENT  WORD PUBLIC 'CONST'
CONST   ENDS
_BSS    SEGMENT  WORD PUBLIC 'BSS'
_BSS    ENDS
_DATA   SEGMENT  WORD PUBLIC 'DATA'
_DATA   ENDS
DGROUP  GROUP   CONST,  _BSS,   _DATA
        ASSUME  CS: _TEXT, DS: DGROUP, SS: DGROUP, ES: DGROUP




_DATA   SEGMENT

ststr1l dw   25 dup(?)              ; contains lefts for string 1
ststr1r dw   25 dup(?)              ; contains rights for string 1
ststr2l dw   25 dup(?)              ; contains lefts for string 2
ststr2r dw   25 dup(?)              ; contains rights for string 2
stcknum dw   ?                      ; number of elements on the stack
score   dw   ?                      ; the #of chars in common times 2
total   dw   ?                      ; total #of chars in string 1 and 2
cl1     dw   ?                      ; left of string 1 found in common
cr1     dw   ?                      ; right of string 1 found in common
cl2     dw   ?                      ; left of string 2 found in common
cr2     dw   ?                      ; right of string 2 found in common
s2ed    dw   ?                      ; the end of string 2 used in compare

_DATA   ENDS

        public _simil


_TEXT   SEGMENT

_simil  proc   near
; This routine expects pointers passed to two character strings, null
; terminated, that you wish compared.  It returns a percentage value
; from 0 to 100% corresponding to how alike the two strings are.
;                   +4       +6
; usage: simil(char *str1,char *str2)
; The similiarity routine is composed of three major components
; pushst    ---- pushes a strings section to be compared on the stack
; popst     ---- pops a string section to be examined off of the stack
; compare   ---- finds the largest group of characters in common between
;                any two string sections
; The similiarity routine begins by computing the total length of both
; strings passed and placing that value in TOTAL.  It then takes
; the beginning and ending of both strings passed and pushes them on
; the stack.  It then falls into the main line code.
; The original two strings are immediately popped off of the stack and
; are passed to the compare routine.  The compare routine will find the
; largest group of characters in common between the two strings.
; The number of characters in common is multiplied times two and added
; to the total score.  If there were no characters in common then there
; is nothing to push onto the stack.  If there are exactly one character
; to the left in both strings then we needn't push it on the stack.
; (We allready know they aren't equal from the previous call to compare.)
; Otherwise the characters to the left are pushed onto the stack.  These
; same rules apply to characters to the right of the substring found in
; common.  This process of pulling substrings off of the stack, comparing
; them, and pushing remaining sections on the stack is continued until
; the stack is empty.  On return the total score is divided by the
; number of characters in both strings.  This is mulitplied time 100 to
; yeild a percentage.  This percentage similiarity is returned to the
; calling procedure.

        push   bp                 ;save BP reg.
        mov    bp,sp              ;save SP reg in BP for use in program
        push   es                 ;save the ES segment register
        mov    ax,ds              ;copy DS segement register to ES
        mov    es,ax
        xor    ax,ax              ;zero out AX for clearing of SCORE var.
        mov    score,ax           ;zero out SCORE
        mov    stcknum,ax         ;initalize number of stack entries to 0
        mov    si,[bp+4]          ;move beginning pointer of string 1 to SI
        mov    di,[bp+6]          ;move beginning pointer of string 2 to DI
        cmp    [si],al            ;is it a null string?
        je     strerr             ;can't process null strings.
        cmp    [di],al            ;is it a null string?
        jne    docmp              ;neither is a null string so process them
strerr: jmp    donit              ;exit routine
docmp:  push   di                 ;save DI because of SCAS opcode
        push   si                 ;save SI because of SCAS opcode
        xor    al,al              ;clear out AL to search for end of string
        cld                       ;set direction flag to forward
        mov    cx,-1              ;make sure we repeat the correct # of times
        repnz  scasb              ;scan for string delimiter in string 2
        dec    di                 ;point DI to '$00' byte of string 2
        dec    di                 ;point DI to last character of string 2
        mov    bp,di              ;move DI to BP where it is supposed to be
        pop    di                 ;restore SI into DI for SCAS (string 1)
        repnz  scasb              ;scan for string delimiter in string 1
        not    cx                 ;do one's compliment for correct length of st
        sub    cx,2               ;subtract the two zero bytes at the end of st
        mov    total,cx           ;store string 2's length
        dec    di                 ;point DI to '$00' byte of string 1
        dec    di                 ;point DI to last character of string 1
        mov    bx,di              ;move DI to BX where it is supposed to be
        pop    di                 ;restore DI to what it should be
        call   pushst             ;Push values for the first call to SIMILIARITY
main:   cmp    stcknum,0          ;is there anything on the stack?
        je     done               ;No, then all done!
        call   popst              ;get regs. set up for a COMPARE call
        call   compare            ;do compare for this substring set
        cmp    dx,0               ;if nothing in common then nothing to push
        je     main               ;try another set
        shl    dx,1               ;*2 for add to score
        add    score,dx           ;add into score
        mov    bp,stcknum         ;get number of entry I want to look at
        shl    bp,1               ;get AX ready to access string stacks
        mov    si,[ststr1l+bp]    ;move L1 into SI or L1
        mov    bx,cl1             ;move CL1 into BX or R1
        mov    di,[ststr2l+bp]    ;move L2 into DI or L2
        mov    cx,cl2             ;move CL2 into CX t emporarily
        mov    ax,[ststr1r+bp]    ;get old R1 off of stack
        mov    cl1,ax             ;place in CL1 temporarily
        mov    ax,[ststr2r+bp]    ;get old R2 off of stack
        mov    cl2,ax             ; save in CL2 temporarily
        mov    bp,cx              ;place CL2 into BP
        cmp    bx,si              ;compare CL1 to L1
        je     chrght             ;if zero, then nothing on left side string 1
        cmp    bp,di              ;compare CL2 to L2
        je     chrght             ;if zero, then nothing on left side string 2
        dec    bx                 ;point to last part of left side string 1
        dec    bp                 ;point to last part of left side string 2
        cmp    bx,si              ;only one character to examine?
        jne    pushit             ;no->we need to examine this
        cmp    bp,di              ;only one character in both?
        je     chrght             ;nothing to look at if both only one char
pushit: call   pushst             ;push left side on stack
chrght: mov    si,cr1             ;move CR1 into SI or L1
        mov    bx,cl1             ;move R1 into BX or R1
        mov    di,cr2             ;move CR2 into DI or L2
        mov    bp,cl2             ;move R2 into BP or R2
        cmp    si,bx              ;compare CR1 to R1
        je     main               ;if zero, then nothing on right side string 1
        cmp    di,bp              ;compare CR2 to R2
        je     main               ;if zero, then nothing on right side string 2
        inc    si                 ;point to last part of right side string 1
        inc    di                 ;point to last part of right side string 2
        cmp    bx,si              ;only one character to examine?
        jne    push2              ;no->examine it
        cmp    bp,di              ;only one character to examine in both?
        je     main               ;yes->get next string off of stack
push2:  call   pushst             ;push right side on stack
        jmp short main            ;do next level of compares
done:   mov    ax,score           ;get score into AX for MUL
        mov    cx,100             ;get 100 into CX for MUL
        mul    cx                 ;Multiply by 100
        mov    cx,total           ;get total characters for divide
        div    cx                 ;Divide by total
donit:  pop    es                 ;Restore ES segement register to entry value
        pop    bp                 ;Restore BP back to entry value
        ret                       ;Leave with AX holding % similarity
_simil  endp

compare proc   near
; The compare routine locates the largest group of characters between string 1
;   and string 2.  This routine assumes that the direction flag is clear.
; Pass to this routine:
;   BX    = R1 (right side of string 1)
;   DS:SI = L1 (left side of string 1)
;   ES:DI = L2 (left side of string 2)
;   BP    = R2 (right side of string 2)
;
; This routine returns:
;   DX    = # of characters matching
;  CL1    = Left side of first string that matches
;  CL2    = Left side of second string that matches
;  CR1    = Right side of first string that matches
;  CR2    = Right side of second string that matches
; The compare routine is composed of two loops.  An inner and an outer loop.
; The worst case scenario is that ther are absolutely no characters in
; common between string 1 and string 2.  In this case N x M compares are
; performed.  However, whan an equal condition occurs in the inner
; loop, then the next character to be examinded in string 2 (for this loop)
; is advanced by the number of characters found equal.  Whenever a new
; maximum number of characters in common is found then the ending location
; of both the inner and outer loop is backed off by the difference between
; the new max chars value and the old max chars value for both loops.  In
; short if 5 characters have been found in common part of the way through
; the search then we can cut our search short 5 characters before the
; true end of both strings since there is no chance of finding better than
; a 5 character match at that point.  This technique means that an exact
; equal match will require only a single compare and combinations of other
; matches will proceed as efficiently as possible.

        mov    s2ed,bp            ;store end of string 2
        xor    dx,dx              ;Init MAXCHARS
forl3:  push   di                 ;Save start of string 2
forl4:  push   di                 ;Save start of string 2
        push   si                 ;Save start of string 1
        mov    cx,s2ed            ;Set up for calc of length of string 1
        sub    cx,di              ;get length of string 1 -1
        inc    cx                 ;make proper length
        push   cx                 ;Save starting length of string 1
        repz   cmpsb              ;compare strings
        jz     equal              ;if equal, then skip fixes
        inc    cx                 ;inc back because CMPS decs even if not equal
equal:  pop    ax                 ;get starting length of string1
        sub    ax,cx              ;get lenght of common characters
        jnz    newmax             ;more than 0 chars matched
        pop    si                 ;get back start of string 1
        pop    di                 ;get back start of string 2
reent:  inc    di                 ;Do the next character no matter what
reent2: cmp    di,bp              ;Are we done with string 2?
        jle    forl4              ;No, then do next string compare
        pop    di                 ;get back start of string 2
        inc    si                 ;next char in string 1 to scan
        cmp    si,bx              ;Are we done with string 1?
        jle    forl3              ;No, then do next string compare
        ret                       ;MAXCHARS is in DX register
; We branch downwards for both newmax and newmx2 because on the
; 8086.. line of processors a branch not taken is faster than
; one which is.  Therefore since the not equal condition is to be
; found most often and we would like the inner loop to execute as quickly
; as possible we branch outside of this loop on the  less frequent
; occurance.  When a match and or a new maxchars is found we branch down to
; these two routines, process the new conditions and then branch back up
; to the main line code.
newmax: cmp    ax,dx              ;greater than MAXCHARS?
        jg     newmx2             ;yes, update new maxchars and pointers
        pop    si                 ;get back start of string 1
        pop    di                 ;get back start of string 2
        add    di,ax              ;Skip past matching chars
        jmp short reent2          ;re-enter inner loop
newmx2: pop    si                 ;get back start of string 1
        pop    di                 ;get back start of string 2
        mov    cl1,si             ;put begin of match of string 1
        mov    cl2,di             ;put begin of match of string 2
        mov    cx,ax              ;save new maxchars
        sub    ax,dx              ;get delta for adjustment to ends of strings
        sub    bx,ax              ;adjust end of string 1
        sub    bp,ax              ;adjust end of string 2
        mov    dx,cx              ;new maxchars
        dec    cx                 ;set up for advance to last matching char
        add    di,cx              ;advance to last matching char string 2
        mov    cr2,di             ;put end of match of string 2
        add    cx,si              ;advance to last matching char string 1
        mov    cr1,cx             ;put end of match of string 1
        jmp short reent           ;re-enter inner loop
compare endp

pushst  proc near
; On entry:
;   BX    = R1 (right side of string 1)
;   DS:SI = L1 (left side of string 1)
;   ES:DI = L2 (left side of string 2)
;   BP    = R2 (right side of string 2)

        mov    cx,bp              ;save R2
        mov    bp,stcknum
        shl    bp,1               ;*2 for words
        mov    [bp+ststr1l],si    ;put left side of string 1 on stack
        mov    [bp+ststr1r],bx    ;put right side of string 1 on stack
        mov    [bp+ststr2l],di    ;put left side of string 2 on stack
        mov    [bp+ststr2r],cx    ;put right side of string 2 on stack
        inc    stcknum            ;Add one to number of stack entries
        mov    bp,cx              ;Restore R2
        ret
pushst  endp


popst   proc near
;   BX    = R1 (right side of string 1)
;   DS:SI = L1 (left side of string 1)
;   ES:DI = L2 (left side of string 2)
;   BP    = R2 (right side of string 2)

        dec    stcknum            ;point to last entry in stack
        mov    bp,stcknum         ;get number of stack entries
        shl    bp,1               ;*2 for words
        mov    si,[bp+ststr1l]    ;restore left side of string 1 from stack
        mov    bx,[bp+ststr1r]    ;restore right side of string 1 from stack
        mov    di,[bp+ststr2l]    ;restore left side of string 2 from stack
        mov    bp,[bp+ststr2r]    ;restore right side of string 2 from stack
        ret
popst   endp


_TEXT   ENDS

        END

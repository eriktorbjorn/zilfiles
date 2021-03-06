<ZZSECTION "OLD-PARSERDEFS">

<FILE-FLAGS MDL-ZIL?>

<SETG CURRENT-OZ-VICTIM <>>

<COND (<NOT <GASSIGNED? DEBUGGING?>>
       <SETG20 DEBUGGING? T>)>

<DEFMAC DEBUGGING-CODE ('X "OPT" 'Y)
  <COND (,DEBUGGING?
	 .X)
	(<ASSIGNED? Y>
	 .Y)
	(T
	 T)>>

"Byte offset to # of entries in LEXV"

<CONSTANT P-LEXWORDS 1>

"Word offset to start of LEXV entries"

<CONSTANT P-LEXSTART 1>

"Number of words per LEXV entry"

<CONSTANT P-LEXELEN 2>   
<CONSTANT P-WORDLEN 4>

"Offset to parts of speech byte"

<CONSTANT P-PSOFF 6>

"Offset to first part of speech"

<CONSTANT P-P1OFF 7>

"First part of speech bit mask in PSOFF byte"

<CONSTANT P-P1BITS 3>    
<CONSTANT P-ITBLLEN 9>   

<CONSTANT P-VERB 0> 
<CONSTANT P-VERBN 1>
<CONSTANT P-PREP1 2>
<CONSTANT P-PREP1N 3>    
<CONSTANT P-PREP2 4>

<CONSTANT P-NC1 6>  
<CONSTANT P-NC1L 7> 
<CONSTANT P-NC2 8>  
<CONSTANT P-NC2L 9> 

<CONSTANT M-BEG 1>  
<CONSTANT M-ENTERING 2>
<CONSTANT M-LOOK 3> 
<CONSTANT M-ENTERED 4>
<CONSTANT M-OBJDESC 5>
<CONSTANT M-END 6> 
<CONSTANT M-CONT 7> 
<CONSTANT M-WINNER 8>
<CONSTANT M-EXIT 9>
<CONSTANT M-SHORT-OBJDESC 10>
<CONSTANT M-SHORTDESC 11>

<CONSTANT O-PTR 0>
<CONSTANT O-START 1>
<CONSTANT O-LENGTH 2>
<CONSTANT O-END 3>
<CONSTANT P-SYNLEN 8>    
 
<CONSTANT P-SBITS 0>
 
<CONSTANT P-SPREP1 1>    
 
<CONSTANT P-SPREP2 2>    
 
<CONSTANT P-SFWIM1 3>    
 
<CONSTANT P-SFWIM2 4>    
 
<CONSTANT P-SLOC1 5>
 
<CONSTANT P-SLOC2 6>
 
<CONSTANT P-SACTION 7>   
 
<CONSTANT P-SONUMS 3>    

<CONSTANT P-MATCHLEN 0>

<CONSTANT P-ALL 1>  
 
<CONSTANT P-ONE 2>  
 
<CONSTANT P-INHIBIT 4>   

<CONSTANT SH 128>   
<CONSTANT SC 64>    
<CONSTANT SIR 32>   
<CONSTANT SOG 16>
<CONSTANT STAKE 8>  
<CONSTANT SMANY 4>  
<CONSTANT SHAVE 2>  

<DEFMAC WT? ('PTR BIT "OPT" (B1:FIX 5))
  <COND (<G? .B1 4>
	 <FORM BTST <FORM GETB .PTR ,P-PSOFF> .BIT>)
	(T
	 <FORM DO-WT? .PTR .BIT .B1>)>>

<ENDSECTION>

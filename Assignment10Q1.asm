TITLE {SUNDAR VEKARIYA} {str_remove} (AssignmentQ1.asm)
; will return in the target string a new string representing the characters from the first 
; character of the source string to the index to the first character to be removed

INCLUDE Irvine32.inc


Str_remove	PROTO,
	OffS	:	PTR BYTE,
	OffT	:	PTR BYTE,
	first	:	DWORD,
	last	:	DWORD

.data

msg1	BYTE	"Enter a String: ",0
msg2	BYTE	"Substring: ",0
source BYTE 100 DUP(0)
target BYTE 100 DUP(0)

indexFirst	DWORD	?
indexLast	DWORD	?

str1	BYTE	"Start Index: ",0
str2	BYTE	"End Index: ",0
.code
	
main PROC
	mov edx,OFFSET msg1
	call WriteString

	mov ecx, SIZEOF source				;reading the string
	mov edx,OFFSET source
	call ReadString
	call CrLf


	mov edx,OFFSET str1
	call WriteString
	call ReadInt
	mov indexFirst,eax
  
  	mov edx,OFFSET str2
	call WriteString
	call ReadInt
	mov indexLast,eax


  	mov edx,OFFSET msg2				;Invoke the method 
	call WriteString
	mov al,'"'
	call WriteChar
	INVOKE Str_remove, ADDR source, ADDR target, indexFirst, indexLast
	mov edx,OFFSET target
	call WriteString
	mov al,'"'
	call WriteChar

quit:
	exit
main ENDP

Str_remove	PROC,
	sourcestring	:	PTR BYTE,
	targetstring	:	PTR BYTE,
	first	:	DWORD,
	last	:	DWORD

LOCAL diff	:	DWORD

	cld

	mov ebx,last
	sub ebx,first
	mov diff,ebx					;calc difference to get the characters to remove

	mov ecx,LENGTHOF source
	sub ecx,diff
	sub ecx,first
	
	mov ebx,first					;If the end index is less than or equal to the first index, return the source string
	cmp last,ebx
	ja next
	mov edi,targetstring
	mov esi,sourcestring
	rep movsb

next:
	cmp first,LENGTHOF source		;If the first index is greater than the source length, return the source string.
	jbe next1
	mov edi,targetstring
	mov esi,sourcestring
	rep movsb

next1:
	cmp last,LENGTHOF source		;If the end index is greater than the string length, use the string length as the end index.
	jbe end_block
	mov last,LENGTHOF source

end_block:
	mov edi,targetstring
	add edi,first
	mov esi,sourcestring
	add esi,first
	add esi,diff
	rep movsb
	ret
Str_remove	ENDP

END main

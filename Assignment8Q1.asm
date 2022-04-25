TITLE {SUNDAR VEKARIYA} {ADVANCED PROCEDURES} (Assignment8Q1.asm)
; generate 60 values in the range from +/-5000 and store these in an array of
; type SDWORD. Using these values, the program will present the user with the menu

INCLUDE Irvine32.inc


PopulateArrayRandomly PROTO,
	arrayOff : DWORD,
	arrayLen : DWORD,
	lowVal	: DWORD,
	highVal	: DWORD

.data

array	SDWORD	60 DUP(?)


msg1	BYTE	" 1 - Report the overall average",0
msg2	BYTE	" 2 - Count the negative numbers",0
msg3	BYTE	" 3 - Generate new random numbers",0
msg4	BYTE	" 4 - Print the values, 10 per line",0
msg5	BYTE	" 0 - Exit",0
msg6	BYTE	" Choice?",0
msg7	BYTE	" Invalid selection. Choice: ",0

str1	BYTE	"Array Populated Successfully",0

commaspace	BYTE	", ",0

.code
	
main PROC
	call Randomize


	push 5000						; [EBP + 20]
	push -5000						; [EBP + 16]
	push LENGTHOF array				; [EBP + 12]
	push OFFSET array				; [EBP + 8]
	call PopulateArrayRandomly

	
top:
	mov edx,OFFSET msg1				;Display menu to user
	call WriteString
	call CrLf
	mov edx,OFFSET msg2
	call WriteString
	call CrLf
	mov edx,OFFSET msg3
	call WriteString
	call CrLf
	mov edx,OFFSET msg4
	call WriteString
	call CrLf
	mov edx,OFFSET msg5
	call WriteString
	call CrLf
	mov edx,OFFSET msg6
	call WriteString
	call CrLf

L0:
	call ReadChar				;Choice?
	cmp al,'0'					;Quit
	jne L1
	jmp quit

L1:
	cmp al,'1'					;Input 1 and then jmp back to top else fall through
	jne L2

	push LENGTHOF array			;number of elements
	push OFFSET array
	call AverageOfArray
	call CrLf
	jmp top

L2:
	cmp al,'2'					;Input 2 and then jmp back to top else fall through
	jne L3
	push LENGTHOF array			;number of elements
	push OFFSET array
	call CountNegativeNumbers
	call CrLf
	jmp top

L3:
	cmp al,'3'					;Input 3 and then jmp back to top else fall through
	jne L4

	push 5000						; [EBP + 20]
	push -5000						; [EBP + 16]
	push LENGTHOF array				; [EBP + 12]
	push OFFSET array				; [EBP + 8]
	call PopulateArrayRandomly
	mov edx,OFFSET str1
	call WriteString
	call CrLf
	call CrLf
	jmp top

L4:
	cmp al,'4'						;Input 4 and then jmp back to top else fall through
	jne L5
	;push 5000						; [EBP + 20]
	;push -5000						; [EBP + 16]
	;push LENGTHOF array			; [EBP + 12]
	;push OFFSET array				; [EBP + 8]
	INVOKE PopulateArrayRandomly, ADDR array, LENGTHOF array, -5000, 5000

	push 10							; [EBP + 16] = elements
	push LENGTHOF array				; [EBP + 12]
	push OFFSET array				; [EBP + 8]
	call PrintArray
	call CrLf
	jmp top

L5:
	cmp al,'5'						;Input 5 and above, so invalid selection and then jmp back to top for choice?
	mov edx,OFFSET msg7
	call WriteString
	jae L0



quit:
	exit
main ENDP

;--------------------------------------
PopulateArrayRandomly PROC,
	arrayOff : DWORD,
	arrayLen : DWORD,
	lowVal	: DWORD,
	highVal	: DWORD

LOCAL range : DWORD
;Populate the array with random numbers between 5000 and -5000
;Receives: 4 named parameters as above 
;Returns: null
;--------------------------------------
	;push ebp
	;mov ebp,esp
	;sub esp,4
	



	mov esi, OFFSET array
	mov ecx, LENGTHOF array
L1:
	mov eax, 500 - -250 + 1
	call RandomRange
	add eax,-250
	call CrLf
	mov [esi], eax
	add esi, TYPE DWORD
	loop L1

	
	ret 
PopulateArrayRandomly ENDP

;--------------------------------------
AverageOfArray PROC
;return the average of the array 
;Receives: stack parameters
;Returns: eax
;--------------------------------------
	push ebp						
	mov ebp,esp
	sub esp,4

	push eax
	push ecx
	push esi
	push edx

	mov esi,[EBP + 8]
	mov ecx,[EBP + 12]
	mov DWORD PTR [EBP - 4],0

L1:
	mov eax, [esi]
	add DWORD PTR [EBP - 4],eax
	add esi, TYPE DWORD
	loop L1
	FILD total 
	mov edx,0
	mov eax, [EBP - 4]
	cdq
	idiv DWORD PTR [EBP + 12]
	call WriteInt


	pop edx
	pop esi
	pop ecx
	pop eax

	pop ebp
	ret
AverageOfArray ENDP

;--------------------------------------
CountNegativeNumbers PROC USES eax esi ecx,
	arrayPtr : PTR DWORD,
	arrayLen : DWORD

LOCAL count : DWORD
;count negative numbers in an array
;Receives: 2 named parameters as above and a local variable
;Returns: eax
;--------------------------------------


	mov esi,arrayPtr
	mov ecx,arrayLen
	mov count,0

L1:
	mov eax,DWORD PTR [esi]
	shl eax,1
	jc negative
	add esi,TYPE DWORD
	jmp L1

negative:
	inc count
	add esi,TYPE DWORD
	jmp L1


	mov eax, count
	call WriteInt

	ret
CountNegativeNumbers ENDP

;--------------------------------------
PrintArray PROC
;print the array using populatearray with random numbers between 5000 and -5000
;Receives: 4 stack parameters  
;Returns: null
;--------------------------------------
	ENTER 0,0

	push esi
	push ecx
	push edx

	mov al,'['
	call WriteChar
	mov edx,OFFSET commaspace

	mov esi, [ebp + 8]
	mov ecx, [ebp + 12]
L1:
	mov edx, [ebp + 16]
L2:
	jecxz end_block
	mov eax,[esi]
	call WriteInt
	call WriteString
	dec ecx
	dec edx
	add esi,TYPE DWORD
	jnz L2
	call CrLf
	jmp L1
	

	mov eax, [esi]
	call WriteInt
	mov al,']'
	call WriteChar
	call CrLf

end_block:
	pop edx
    pop ecx
    pop esi

	LEAVE
	ret
PrintArray ENDP

END main

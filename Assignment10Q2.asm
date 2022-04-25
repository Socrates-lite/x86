TITLE {SUNDAR VEKARIYA} {Populate and fill the array base index displacement} (Lab9Q1.asm)
;

INCLUDE Irvine32.inc


SumColumnOfArray	PROTO,
	arrayOff : DWORD,
	arrayLen : DWORD,
	lowVal	: DWORD,
	highVal	: DWORD

.data

NUM_ROWS = 3
NUM_COLS = 3
Array SWORD NUM_ROWS*NUM_COLS DUP(?)
comma	BYTE	" , ",0

Number	DWORD	?

msg1	BYTE	"Please enter a number for the column to be added: ",0
msg2	BYTE	"The total of the selected column is: ",0

.code
	
main PROC
	call Randomize

	call PopulateArray

	push NUM_ROWS
	push NUM_COLS
	push OFFSET Array
	call PrintArray
	call CrLf

	mov edx,OFFSET msg1
	call WriteString


top:
	call ReadInt
	cmp eax, 0
	jb top
	cmp eax,NUM_COLS
	jae top
	mov Number,eax
	mov edx,OFFSET msg2
	call WriteString
	INVOKE SumColumnOfArray, ADDR Array, NUM_ROWS, NUM_COLS, Number
	
	call CrLf

	exit
main ENDP

PopulateArray	PROC

	mov esi,OFFSET array
	mov ecx,LENGTHOF array

L1:
	mov eax, 100 - 25 +1
	call RandomRange
	add eax,25
	mov Array[esi],ax
	add esi, TYPE Array
	loop L1


	ret	
PopulateArray	ENDP

PrintArray	PROC
	push ebp
	mov ebp,esp

	mov esi,[EBP + 8]
	mov ecx,[EBP + 16]


L1:
	mov al,'|'
	call WriteChar
	push ecx
	mov edi,0
	mov ecx,[EBP + 12]
	dec ecx
L2:
	movsx eax, WORD PTR [esi + edi]
	call WriteInt
	mov edx,OFFSET comma
	call WriteString
	add edi, TYPE Array
	loop L2

	movsx eax, WORD PTR [esi + edi]
	call WriteInt
	add edi, TYPE Array
	mov al,'|'
	call WriteChar
	call CrLf

	add esi,edi
	pop ecx
	loop L1

	pop ebp
	ret	12
PrintArray	ENDP

SumColumnOfArray	PROC,
	arrayOff : DWORD,
	row : DWORD,
	column	: DWORD,
	value	: DWORD

LOCAL total:DWORD
	
	mov total,0
	mov esi,arrayOff
	mov ecx,row
	mov ebx,value
	add value,ebx

L1:
	push ecx
	mov edi,0
	mov ecx,column
L2:
	cmp edi,value
	jne below
	movsx eax, WORD PTR [esi + edi]
	add total,eax
below:
	add edi, TYPE Array
	loop L2

	add esi,edi
	pop ecx
	loop L1

	mov eax,total
	call WriteInt
	ret
SumColumnOfArray	ENDP

END main

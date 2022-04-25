TITLE {SUNDAR VEKARIYA} {Populate and fill the array base index displacement} (Lab9Q1.asm)
;

INCLUDE Irvine32.inc

.data

NUM_ROWS = 7
NUM_COLS = 5
Array SWORD NUM_ROWS*NUM_COLS DUP(?)
plus	BYTE	" + ",0
comma	BYTE	" = ",0

.code
	
main PROC
	call Randomize
  
	push NUM_ROWS
	push NUM_COLS
	push OFFSET Array			;ADDR
	call popRandomArray

	push NUM_ROWS
	push NUM_COLS
	push OFFSET Array
	call totalRows
	call CrLf

	push NUM_ROWS
	push NUM_COLS
	call totalRows2

	exit
main ENDP

popRandomArray	PROC
	push ebp
	mov ebp,esp
	mov esi,[EBP + 8]
	mov ecx,[EBP + 16]

L1:
	push ecx
	mov edi,0
	mov ecx,[EBP + 12]
L2:
	mov eax, 500 - -250 + 1
	call RandomRange
	add eax,-250
	mov [esi + edi],ax
	add edi, TYPE Array
	loop L2

	add esi,edi
	pop ecx
	loop L1

	pop ebp
	ret	12
popRandomArray	ENDP

totalRows	PROC
LOCAL total:DWORD
	
	mov total,0

	mov esi,[EBP + 8]
	mov ecx,[EBP + 16]

L1:
	push ecx
	mov edi,0
	mov ecx,[EBP + 12]
	dec ecx
L2:
	movsx eax, WORD PTR [esi + edi]
	add total,eax
	call WriteInt
	mov edx,OFFSET plus
	call WriteString
	add edi, TYPE Array
	loop L2

	movsx eax, WORD PTR [esi + edi]
	add total,eax
	call WriteInt

	mov edx,OFFSET comma
	call WriteString
	mov eax,total
	call WriteInt
	mov total,0
	call CrLf

	add esi,edi
	pop ecx
	loop L1

	ret	12
totalRows	ENDP

totalRows2	PROC
LOCAL total:DWORD
	
	mov total,0
	mov esi,OFFSET 	0		;ADDR
	mov ecx,[EBP + 12]

L1:
	push ecx
	mov edi,0
	mov ecx,[EBP + 8]
	dec ecx
L2:
	movsx eax, Array[esi + edi]
	add total,eax
	call WriteInt
	mov edx,OFFSET plus
	call WriteString						
	add edi, TYPE Array
	loop L2

	movsx eax, Array[esi + edi]
	add total,eax
	call WriteInt
	mov edx,OFFSET comma
	call WriteString
	mov eax,total
	call WriteInt
	mov total,0
	call CrLf

	add esi,edi
	pop ecx
	loop L1

	ret 12
totalRows2	ENDP

END main

TITLE {SUNDAR VEKARIYA} {Floating-Point Number in Binary} (Assignment9Q2.asm)
; receives a single-precision floating-point binary value as a stack value and
; displays it in the following format: sign 1. significand x 2^exponent.

INCLUDE Irvine32.inc

.data

msg1	BYTE	"Enter a float value: ",0
num		REAL4	?
power	BYTE	"x2^",0

.code
	
main PROC
	FINIT

	mov edx,OFFSET msg1
	call WriteString
	call ReadFloat
	fstp num

	push num
	call FPB
	call CrLf

	call ShowFPUStack				;Stack empty after the calculation
	exit
main ENDP
									; sign 1. significand x 2^exponent.
FPB	PROC	
	push ebp
	mov ebp,esp
	
	mov   ebx,[EBP + 8]
    mov   eax,0
    shld   eax,ebx,1       ; shift the sign bit into EAX
	cmp eax,1
	jne pos_block
	pusha
    mov al,'-'
	
    jmp next

pos_block:
	mov al,'+'

next:
	call WriteChar
	popa

	call BIT
	mov al,'.'
	call WriteChar

	shl   ebx,9       ; remove the sign & exponent bits
	
	mov   ecx,23       ; loop counter for 23 bits
  
L1:
	mov   eax,0
    shld   eax,ebx,1		; get the next bit
    call BIT 
    shl   ebx,1				; remove the bit to get the next one in the loop
    loop L1


	mov   eax,[EBP + 8]
    shr   eax,23			; remove significand part
    and   eax,011111111b    ; remove the sign bit as already calculated
    sub   eax,127			; remove the bias value to find the exponent
	mov edx,OFFSET power
	call writeString
    call   WriteInt			; write the signed exponent

	pop ebp
	ret
FPB	ENDP

BIT	PROC
	cmp eax,1				;print the value at eax while shifting
	jne zero_block
	mov al,'1'
	jmp next

zero_block:
	mov al,'0'

next:
	call WriteChar
	ret
BIT	ENDP

END main

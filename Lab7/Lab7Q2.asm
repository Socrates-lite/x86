TITLE {} {Program name} (File name)
; Description of program

INCLUDE Irvine32.inc

.data

inp1	BYTE	"Enter a unsigned value for A: ",0
inp2	BYTE	"Enter a unsigned value for B: ",0
inp3	BYTE	"Enter a unsigned value for C: ",0

msg1	BYTE	"4A + (C-1) * 2B: ",0
msg2	BYTE	"(10 + C) / (B - A): ",0
msg3	BYTE	"(3A + 4C) / 6B: ",0

varA	DWORD	0
varB	DWORD	0
varC	DWORD	0

.code
	
main PROC

	mov edx,OFFSET inp1
	call WriteString
	call ReadDec
	mov varA,eax
	


	mov edx,OFFSET inp2
	call WriteString
	call ReadDec
	mov varB,eax

	mov edx,OFFSET inp3
	call WriteString
	call ReadDec
	mov varC,eax
	call CrLf



	



	mov ebx,varA
	shl ebx,2
	mov eax,varC
	sub eax,1
	mov ecx,varB
	shl ecx,1
	mul ecx
	add eax,ebx
	

	mov edx,OFFSET msg1
	call WriteString
	call WriteInt
	call CrLf



	mov edx,0
	mov eax,varC
	add eax,10
	mov ebx,varB
	sub ebx,varA
	div ebx



	mov edx,OFFSET msg2
	call WriteString
	call WriteInt
	call CrLf


	mov edx,0
	mov eax,varA
	mov ebx,3
	mul ebx						;al = 3A
	mov ecx,varC
	shl ecx,2					;cl = 4C
	add eax,ecx					;al = 3A + 4C
	mov ebx,varB
	mov edx,varB
	sal ebx,2					;4B
	sal edx,1					;2B
	add ebx,edx					;6B
	div ebx						;al/bl




	mov edx,OFFSET msg3
	call WriteString
	call WriteInt
	call CrLf


	exit
main ENDP

END main


TITLE {} {Program name} (File name)
; Description of program

INCLUDE Irvine32.inc

.data

inp1	BYTE	"Enter a signed value for A: ",0
inp2	BYTE	"Enter a signed value for B: ",0
inp3	BYTE	"Enter a signed value for C: ",0

msg1	BYTE	"4A + (C-1) * 2B: ",0
msg2	BYTE	"(10 + C) / (B - A): ",0
msg3	BYTE	"(3A + 4C) / 6B: ",0

varA	BYTE	0
varB	BYTE	0
varC	BYTE	0

.code
	
main PROC

	mov edx,OFFSET inp1
	call WriteString
	call ReadInt
	mov varA,al
	


	mov edx,OFFSET inp2
	call WriteString
	call ReadInt
	mov varB,al

	mov edx,OFFSET inp3
	call WriteString
	call ReadInt
	mov varC,al
	call CrLf



	

	mov bl,varA
	sal bl,2
	mov al,varC
	sub al,1
	mov cl,varB
	sal cl,1
	imul cl
	add al,bl
	movsx eax,al
	

	mov edx,OFFSET msg1
	call WriteString
	call WriteInt
	call CrLf



	
	mov al,varC
	add al,10
	cbw
	mov bl,varB
	sub bl,varA
	idiv bl
	movsx eax,al



	mov edx,OFFSET msg2
	call WriteString
	call WriteInt
	call CrLf



	mov al,varA
	mov bl,3
	imul bl						;al = 3A
	mov cl,varC
	sal cl,2					;cl = 4C
	add al,cl					;al = 3A + 4C
	mov bl,varB
	mov dl,varB
	sal bl,2					;4B
	sal dl,1					;2B
	add bl,dl					;6B
	cbw
	idiv bl						;al/bl
	movsx eax,al



	mov edx,OFFSET msg3
	call WriteString
	call WriteInt
	call CrLf


	exit
main ENDP

END main

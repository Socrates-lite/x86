TITLE {} {Program name} (File name)
; Description of program

INCLUDE Irvine32.inc

area PROTO,
	height1 : REAL4,
	width1 : REAL4

.data

rHeight REAL4 ?
rWidth REAL4 ?			;NOTE: width is a reserved word (operator)
rPerim REAL4 ?
rArea REAL4 ?
ratio REAL4 ?

msg1 BYTE "Please enter the rectangle height: ", 0
msg2 BYTE "Please enter the rectangle width: ", 0
msg3 BYTE "The perimeter of the rectangle is: ", 0
msg4 BYTE "The area of the rectangle is: ", 0
msg5 BYTE "The ratio of width/height is: ", 0


.code
	
main PROC
  
	FINIT

	call ReadValue
	mov edx,OFFSET msg3
	call WriteString

	push rHeight		;[ebp + 12]
	push rWidth			;[ebp + 8]
	call perimeter
	call WriteFloat
	fstp rPerim
	call CrLf

	mov edx,OFFSET msg4
	call WriteString

	INVOKE area, rHeight, rWidth
	call WriteFloat
	fstp rArea
	call CrLf

	
	mov edx,OFFSET msg5
	call WriteString
	

	call ratio2
	call WriteFloat
	fstp ratio
	call CrLf

	exit
main ENDP

ReadValue PROC
TOP:
	mov edx, OFFSET msg1
	call WriteString
	call ReadFloat

	fldz

	fcomp
	fnstsw ax
	sahf

	jbe next
	FFREE ST(0)
	jmp TOP

next:
	fstp rHeight

	mov edx,OFFSET msg2
	call WriteString
	call ReadFloat

	fldz
	
	fcomip ST(0), ST(1)
	fabs
	fstp rWidth
	
	ret
ReadValue ENDP


perimeter PROC
	push ebp
	mov ebp,esp
	sub esp,4

	mov DWORD PTR [ebp - 4],2
	fld REAL4 PTR [ebp + 12]
	fimul DWORD PTR [ebp - 4]			;ST(0) 2 width
	

	fld REAL4 PTR [ebp + 8]				;ST(0) height   ST(1) 2 width
	fimul DWORD PTR [ebp - 4]			; ST (0)  2 height ST(1) 2 width
	
	fadd

	mov esp,ebp
	pop ebp
	ret 4
perimeter ENDP

area PROC,
	height1 : REAL4,
	width1 : REAL4
	
	fld height1		;ST(0) height
	fld width1		;ST(0) width ST(1) height

	fmul

	ret
area ENDP


ratio2 PROC
	

	fld rWidth				;ST(0) width
	
	fld rHeight				; ST(0) height   ST(1) width
	fdiv					;ST(0) = ST(1) / ST(0)

	ret
ratio2 ENDP

END main

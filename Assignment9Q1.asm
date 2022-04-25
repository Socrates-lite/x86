TITLE {SUNDAR VEKARIYA} {truncated decahedron} (Assignment9Q1.asm)
; Ask the user to supply the length of one of the edges and calculate the area,volume and radius

INCLUDE Irvine32.inc

Area PROTO,
	value : REAL4

Volume PROTO,
	value : REAL4

radius	PROTO,
	value : Real4

.data

e	REAL4	?

msg1	BYTE	"Enter the length of one of the edges: ",0
msg2	BYTE	"Negatives not allowed beyond this point.",0

str1	BYTE	"The Area for the given length is: ",0
str2	BYTE	"The Volume for the given length is: ",0
str3	BYTE	"The Midsphere Radius for the given length is: ",0

lol DWORD 0
loll DWORD 0

.code
	
main PROC
	FINIT
	
Top:
	mov edx,OFFSET msg1
	call WriteString
	call ReadFloat
	call CrLf	

	fldz						; load zero and compare, if equal quit
	fcomp
	fnstsw ax
	sahf

	je quit

	fldz						; load zero and if input negative loop again otherwise, fall through
	fcomip ST(0), ST(1)

	jb Next
	mov edx,OFFSET msg2
	call WriteString
	call CrLf
	cmp lol, loll
	jmp next
	FFREE ST(0)
	jmp Top

Next:
	fstp e
	mov edx,OFFSET str1			; Print area and clear the stack
	call WriteString
	INVOKE Area, e
	call WriteFloat
	FFREE ST(0)
	call CrLf

	mov edx,OFFSET str2			; Print volume and clear the stack
	call WriteString
	INVOKE Volume, e
	call WriteFloat
	FFREE ST(0)
	call CrLf

	mov edx,OFFSET str3			; Print radius and clear the stack
	call WriteString
	INVOKE radius, e
	call WriteFloat
	FFREE ST(0)
	call CrLf
	
	call CrLf
	jmp Top

quit:
	FFREE ST(0)
	call ShowFPUStack

	exit
main ENDP
												;(s(3) + 6 s(5 + 2s5) * 5e2)
Area PROC,
	value : REAL4
	LOCAL	two : DWORD,
			three : DWORD,
			fives : DWORD

	mov two,2
	mov three,3
	mov fives,5

	FLD value
	FMUL value			;ST(0) e^2

	FIMUL fives			;ST(0) 5*e^2 
	FILD fives			;ST(0) 5 ST(1) 5*e^2
	FSQRT				;ST(0) sqrt5 ST(1) 5*e^2			 
	FIMUL two			;ST(0) 2*sqrt5 ST(1) 5*e^2
	FIADD	fives			
	FSQRT				;ST(0) sqrt(5 + 2*sqrt5) ST(1) 5*e^2

	FILD two			
	FIMUL three			;ST(0)  6  ST(1) sqrt(5 + 2*sqrt5) ST(1) 5*e^2
	FMUL				;ST(0) 6* sqrt(5 + 2*sqrt5) ST(1) 5*e^2
	FILD three
	FSQRT

	FWAIT
	FADD				;ST(0)  sqrt3 + 6* sqrt(5 + 2*sqrt5) ST(1) 5*e^2
	FMUL				;ST(0)  sqrt3 + 6* sqrt(5 + 2*sqrt5) * 5*e^2

	ret
Area ENDP

Volume PROC,
	value : REAL4
	LOCAL	nn : DWORD,
			f : DWORD,
			tw : DWORD,
			fsvn : DWORD

	mov f,5
	mov tw,12
	mov fsvn,47
	mov nn,99

	FLD value
	FMUL value
	FMUL value			;ST(0) e^3

	FILD f
	FSQRT
	FIMUL fsvn			;ST(0) 47 * sqrt5  ST(1) e^3

	FIADD nn			;ST(0) 99 + 47 * sqrt5  ST(1) e^3
	FILD f
	FIDIV tw			
	FMUL				;ST(0)  (5/12) * 99 + 47 * sqrt5  ST(1) e^3

	FWAIT
	FMUL				;ST(0)  (5/12) * 99 + 47 * sqrt5  * e^3

	ret
Volume ENDP



											;semi-horizontalo hemisphere radius	 = 2E^2/3 (sq(2)3)
radius	PROC,
	value : Real4
	LOCAL	three : DWORD,
			two : DWORD

	mov three,3
	mov two, 2

	; 2E^2/3 (sq(2)3)

	FILD two
	FLD value
	call ShowFPUStack

	
	ret
radius	ENDP
END main

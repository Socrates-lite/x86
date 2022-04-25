TITLE {} {Program name} (File name)
; Description of program

INCLUDE Irvine32.inc

.data

varA DWORD 3
varB DWORD -6
varC DWORD 4
varD DWORD 4


.code
	
main PROC
  
	mov eax,varB
sub eax,varC
mov edx,3
imul edx
mov edx,0
mov ebx,varA
sal ebx,1
cdq
idiv ebx


	call WriteInt



	exit
main ENDP

END main


;------------------------------------------------------
findGCD	PROC
;
; finds the greatest common divisor from the given two numbers
; Recieves: num1 and num2
; Returns: num1
;------------------------------------------------------

	mov eax,num1						;num1 = Math.abs(num1)
	test eax,eax
	jns do
	neg num1

	mov eax,num2						;num2 = Math.abs(num2)
	test eax,eax
	jns do
	neg num2

do:
	mov eax,num1						;int remainder = num1 % num2
	cdq
	idiv num2
	mov remainder,edx

	mov ebx,num2						;num1 = num2
	mov num1,ebx
	
	mov ebx,remainder					;num2 = remainder
	mov num2,ebx

	cmp num2,0							;while( num2 > 0)
	jg do

	mov eax,num1						;return num1

	ret
findGCD	ENDP

END main

COMMENT#

	mov val1,0							; int val1 = 0
	mov val2,0							; int val2 = 0

do:
	mov edx,OFFSET first				;System.out.print("Enter first integer: ");
	call WriteString
	call ReadInt						;val1 = input.nextInt();
	mov val1,eax

	mov edx,OFFSET second				;System.out.print("Enter second integer: ");
	call WriteString
	call ReadInt						;val2 = input.nextInt();
	mov val2,eax
	

if_block:
	cmp val1,0							;if(val1 == 0 || val2 ==0)
	je exit1
	cmp val2,0
	jne else_block


else_block:
	mov edx,OFFSET str1					;System.out.println("For the numbers " + val1 + " and " + val2 + " the greatest common divisor is " + findGCD(val1, val2));
	call WriteString

	mov eax, val1
	call WriteInt

	mov edx,OFFSET str2			
	call WriteString

	mov eax, val2
	call WriteInt

	mov edx,OFFSET str3				
	call WriteString
	
	mov num2,eax
	mov ebx,val1
	mov num1,ebx

	call findGCD
	call WriteInt
	call CrLf
	call CrLf

while_block:
	cmp val1,0
	je bye
	cmp val2,0
	jne do

	
exit1:
	mov edx,OFFSET zero					;System.out.println("Zero cannot be used.");
	call WriteString
	call CrLf


bye:
	mov edx,OFFSET goodbye				;System.out.println("Goodbye.");
	call WriteString
	call CrLf

#
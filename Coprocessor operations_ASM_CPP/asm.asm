; lab 5, variant 18: (c*149+b*b)/(a+b-117)
; nasm -f elf64 name.asm
; ld -o name name.o

section .data
extern a, b, c, num, denom, result ; a and b are float, c is integer
const1: dd 149
const2: dd 117

section .text
global calculate_asm

calculate_asm:
;;;;; numerator
; calculate c*149
	finit ; init
	fild dword [c] ; st0 = c (integer)
	fimul dword [const1] ; st0 = c*149

; calculate b*b
	fld dword [b] ; st0 = b; st1 = c*149
	fmul st0, st0 ; st0 = b*b

; sum up
	faddp st1, st0 ; st0 = c*149 + b*b
	fst dword[num] ; save numerator in num

;;;;; denominator
	fld dword [a] ; st0 = a; st1 = num
	fld dword [b] ; st1 = b; st1 = a; st2 = num
	faddp st1, st0 ; st0 = a + b; st1 = num

	fild dword[const2] ; st0 = 117
	fsubp st1, st0 ; st0 = st1-st0 = (a + b) - 117

	fst dword[denom] ; denom = a + b - 117

;;;;; result
	fdivp st1, st0 ; st0 = st1/st0 = num / denom
	fstp dword[result]
	ret ; ret returns to main()

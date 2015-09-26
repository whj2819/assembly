
section .data
    Snippet db "KANGAROO"

section .text
    global _start:
_start:
    nop
; 将你的实验放在两个nop之间


    mov ebx, Snippet
    mov eax, 8

DoMore: add byte [ebx],32
    inc ebx
    dec eax
    jnz DoMore 



; 将你的实验放在两个nop之间
nop

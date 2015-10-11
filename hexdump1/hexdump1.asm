;
; 可执行文件名:hexdump1
; 版本:1.0
; 创建日期:2015-10-11
; 最后更新日期:2015-10-11
; 作者:huajie.wu
; 描述:
;    Linux 下的一个简单的汇编程序,采用NASM
;    演示了如何把二进制转换成16进制字符串
;
;    通过以下方式执行本程序:
;    hexdump1 < (input file)
; nasm -f elf -g -F stabs eatsyscall.asm
; 32位:ld -o eatsyscall eatsyscall.o
; 64位:ld -m elf_i386 -o eatsyscall eatsyscall.o
;

;
; gdb debug:
; run <inputfile.txt >outputfile.txt
;
;


SECTION .bss

    BUFFLEN equ 16          ;
    Buff: resb BUFFLEN      ;

SECTION .data
    HexStr: db " 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00",10
    HEXLEN equ $-HexStr

    Digits: db "0123456789ABCDEF"

SECTION .text

global  _start:

_start:
    nop


Read:
    mov eax,3
    mov ebx,0
    mov ecx,Buff
    mov edx,BUFFLEN
    int 80h
    mov ebp,eax
    cmp eax,0
    je Done

    
    mov esi,Buff
    mov edi,HexStr
    xor ecx,ecx


Scan:
    xor eax,eax

    mov edx,ecx
    shl edx,1
    add edx,ecx

    mov al,byte [esi+ecx]
    mov ebx,eax


    and al,0Fh
    mov al, byte [Digits + eax]
    mov byte [HexStr + edx + 2],al


    shr bl,4
    mov bl, byte [Digits + ebx]
    mov byte [HexStr + edx + 1],bl

    inc ecx
    cmp ecx,ebp
    jna Scan

    mov eax,4
    mov ebx,1
    mov ecx,HexStr
    mov edx, HEXLEN
    int 80h
    jmp Read

Done:
    mov eax,1
    mov ebx,0
    int 80h

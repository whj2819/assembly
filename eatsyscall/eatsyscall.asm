
; 可执行程序 :eatsyscall
; 版本: 1.0
; 创建日期:2015-09-26
; 修改日期:2015-09-26
; 作者: huajie.wu
; 描述:
; 使用这些命令生成:
; nasm -f elf -g -F stabs eatsyscall.asm
; 32位:ld -o eatsyscall eatsyscall.o
; 64位:ld -m elf_i386-o eatsyscall eatsyscall.o
;

SECTION .data                          ; 包含已经初始化的数据的段

EatMsg: db "Eat at Joe's!",10
EatLen: equ $ - EatMsg

SECTION .bss                           ; 包含未初始化的数据的段
SECTION .text                          ; 包含代码的段

global _start                          ; 链接器需要根据这个找到入口点.

_start:

    nop
    mov eax,4                          ; 指定sys_write 系统调用
    mov ebx,1                          ; 指定文件描述符1:标准输出
    mov ecx,EatMsg                     ; 传递显示信息的偏移地址
    mov edx,EatLen                     ; 传递显示信息的长度 
    int 80H                            ; 进行系统调用来输出文本到标准输出

    mov eax,1                          ; 指定系exit统调用
    mov ebx,0                          ; 返回一个零代码
    int 80H                            ; 进行系统调用来终止程序


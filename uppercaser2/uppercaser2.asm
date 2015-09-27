;
; 可执行程序名称: uppercaser2
; 版本:1.0
; 创建日期:2015-09-27
; 最后修改日期:2015-09-27
; 作者:huajie.wu
; 描述:
;       一个为Linux编写的简单汇编程序,使用NASM 2.10.09,
;       展示了简单的文本文件输入/输出(通过重定向),
;       为了实现从输入文件读入一块缓冲区,强制将小写字符转换为大写字符
;       并将修改过的缓冲区写入到一个输出文件. 
;
; 运行方式: uppercaser2 <(output file) >(input file)
;
; 通过使用这些命令来生成可执行文件:
; nasm -f elf -g -f stabs uppercaser2.asm
; ld -o uppercaser2 uppercaser2.o (32位环境)
; ld -m elf_i386 -o uppercaser2 uppercaser2.o (64位环境)
;


SECTION .bss

    BUFFLEN equ 1024                    ; 缓冲区的长度
    Buff: resb BUFFLEN                  ; 缓冲区

SECTION .data

SECTION .text                           ; 代码段
global _start:
    
_start:
    nop

; 从标准输入中读入满满一缓冲区文本:

read:
    mov eax,3                           ; sys_read 系统调用.
    mov ebx,0                           ; 标准输入.
    mov ecx,Buff                        ; 缓冲区的偏移地址.
    mov edx,BUFFLEN                     ; 一次循环中要读入的字节数.
    int 80H                             ; 调用sys_read 来填充缓冲区.

    mov esi, eax                        ; 复制sys_read  的返回值.
    cmp eax,0                           ; 读到EOF(文件尾)...
    je Done                             ; ...... 则退出程序.

; 设置寄存器,用于处理缓冲区.
    mov ecx,esi                         ; 将读入的字节数放入ecx
    mov ebp,Buff                        ; 将缓冲区的地址放入ebp
    dec ebp                             ; 调整对偏移地址的计数值


Scan:
    cmp byte [ebp + ecx],61h
    jb Next

    cmp byte [ebp + ecx],7Ah
    ja Next

    sub byte [ebp + ecx], 20h           ; 得到大写字符.

Next:
    dec ecx                             ; 字符计数减1
    jnz Scan                            ; 缓冲区中仍有字符.


;将处理过的缓冲区写到标准输出:
Write:
    mov eax,4
    mov ebx,1
    mov ecx,Buff
    mov edx,esi
    int 80h
    jmp read

; 程序退出.
Done:
    mov eax,1
    mov ebx,0
    int 80H




;
; gdb debug:
; run <inputfile.txt >outputfile.txt
;
;


section .bss
    Buff resb 1

section .data

section .text

global _start:

_start:
    nop


Read:
    mov eax,3               ; 指定sys_read 调用
    mov ebx,0               ; 指定文件描述符0: 标准输入
    mov ecx,Buff            ; 传递即将从中读取数据的缓冲区的地址
    mov edx,1               ; 告诉sys_read 从标准输入读入一个字符
    int 80h                 ; 调用sys_read 系统调用
    cmp eax,0
    je Exit                 ; 如果为EOF,则跳转到Exit.

    cmp byte [Buff],61h     ; 将输入的字符与小写字母'a'比较
    jb Write                ; 如果在ASCII表中比'a'小, 则不是小写字符.

    cmp byte [Buff],7Ah     ; 将输入的字符与小写字母'z'比较
    ja Write                ; 如果在ASCII表中比'z'大, 则不是小写字符
                            ; 此时,我们已经拥有了一个小写字符.

    sub byte [Buff],20h     ; 从小写字符中减去 20h, 得出相应的大写字符......
                            ; ......然后将该字符写出到标准输出.

Write:
    mov eax,4               ; 指定sys_write 系统调用.
    mov ebx,1               ; 指定文件描述符1:标准输出.
    mov ecx,Buff            ; 传递要写出的字符的地址.
    mov edx,1               ; 传递要写出的字符的数量.
    int 80h                 ; 调用sys_write ...
    jmp Read                ; ........ 然后跳转到开始处,获取另一个字符.

Exit:
    mov eax,1
    mov ebx,0
    int 80H


progs = uppercaser1
cleanfiles = *.o *.out

uppercaser2: uppercaser2.o
	ld -m elf_i386 -o uppercaser2 uppercaser2.o

uppercaser2.o: uppercaser2.asm
	nasm -f elf -g -F stabs uppercaser2.asm

clean:
	rm -fv ${progs} ${cleanfiles}

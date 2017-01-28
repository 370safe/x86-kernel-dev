nasm C:\Users\algas\Desktop\OsDev\kek-os\boot_sect.asm -f bin -o C:\Users\algas\Desktop\OsDev\kek-os\boot_sect.bin
gcc -ffreestanding -c kernel.c -o kernel.o
ld -T NUL -o kernel.tmp -Ttext 0x7e00 kernel.o
objcopy -O binary -j .rdata  -j .text kernel.tmp kernel.bin
copy /b boot_sect.bin + kernel.bin os.bin
pause
ld -r a.o b.o -o c.o
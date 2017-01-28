
boot_sect.bin : boot_sect.asm
	nasm C:\Users\algas\Desktop\OsDev\kek-os\boot_sect.asm -f bin -o C:\Users\algas\Desktop\OsDev\kek-os\boot_sect.bin


	
#kernel.tmp : kernel.o
#ld -T NUL -o kernel.tmp -Ttext 0x7e00 kernel.o

#kernel.bin : kernel.tmp
#objcopy -O binary -j .rdata  -j .text kernel.tmp kernel.bin
	
os.bin : boot_sect.bin kernel.bin
	copy /b boot_sect.bin + kernel.bin os.bin


clean :
	del /S *.bin
	del /S *.tmp
	del /S *.o

# C to OBJ
%.o : %.c
	gcc -ffreestanding -std=c99 -c $< -o $@	
objects := $(patsubst %.c,%.o,$(wildcard *.c))
buildObjs : $(objects)



#combile all OBJS into COMBO.BIN
objs = $(filter-out COMBO.o,$(filter-out kernel.o, $(wildcard *.o)))
combineObjs :
	ld -r kernel.o $(objs) -o COMBO.o
#ld -r kernel.o utils.o low_level.o screen.o -o COMBO.o

#BINS + Boot sector
all:
	make clean
	make boot_sect.bin
#build all OBJS	
	make buildObjs
#combine all OBJS
	make combineObjs
	ld -T NUL -o COMBO.tmp -Ttext 0x7e00 COMBO.o
	objcopy -O binary -j .rdata  -j .text COMBO.tmp COMBO.bin
	copy /b boot_sect.bin + COMBO.bin os.bin
	

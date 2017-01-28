[org 0x7c00] ;set where the origin of the code is in mem

;mov [0x9000], byte 'A'
mov bp, 0xffff ;st stack base point
mov sp, bp ;set stack pointer

mov bx, MSG ;param
call printString
call endLine

mov bx, MSG_16B_MODE
call printString
call endLine

mov bx, MSG_LOADING_KERNEL
call printString
call endLine

mov al, 25
mov bx, kernel_entry
call read_from_disk

;mov bx, kernel_entry ; prints out outter sector data
;call printString
;call endLine

call switch_to_pm
call endLine



jmp $ ;endless jump

;=====FUNCTIONS
%include "C:\Users\algas\Desktop\OsDev\kek-os\functions.asm"
%include "C:\Users\algas\Desktop\OsDev\kek-os\switch_to_pm.asm"
%include "C:\Users\algas\Desktop\OsDev\kek-os\functions32.asm"

[bits 32]
BEGIN_PM:
	mov esi, MSG_32B_MODE
	call print_string32

;jmp $ ;endless jump in 32 bit mode
jmp kernel_entry ;jumps to C code
[bits 16]


;====DATA
MSG_LOADING_KERNEL:
	db 'Loading kernel...', 0
MSG_16B_MODE:
	db 'Entered 16-bit mode.', 0
MSG_32B_MODE:
	db 'Entered 32-bit mode.', 0
DISK_READ_ERROR:
	db 'Error, cant read disk.', 0

HEX_TEMPLATE:
db '0x????',0
MSG:
	db 'kek OS booting...', 0

HEXABET:
	db '0123456789abcdef'
	
times 510-($-$$) db 0
dw 0xaa55

;=========OUTTER SECTOR
kernel_entry:
	;db 'Outter sector data.', 0
;times 512 db 0

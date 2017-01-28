[bits 32]

VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_string32:
	pusha
	mov edx, VIDEO_MEMORY

print_string32_loop:
	mov al, [esi]
	mov ah, WHITE_ON_BLACK
	
	cmp al, 0
	je print_string32_done
	
	mov [edx], ax
	
	add esi, 1
	add edx, 2
	
	jmp print_string32_loop
	
print_string32_done:
	popa
	ret
	
	
	
	
	
[bits 16]
printString:
	pusha
		top:
		mov ax, [bx]
		call printChar
		add bx, 1
		cmp [bx], byte 0
		jne top
		mov al, ' '
		int 0x10
		call printChar
	popa
	ret

printChar:
	pusha
	mov ah, 0x0e ;BIOS scrolling teletype function
	int 0x10
	popa
	ret
	
printHex:
	pusha
		push bx
		;mov bx, dx ; cx-> 0x1234
		shr bx, 12 ; cx-> 0x0001
		;add cx, 48
		mov bx, [bx + HEXABET]
		mov [HEX_TEMPLATE+2], bl ; replace 2nd index at HEX_TEMPLATE location
		pop bx
		;========
		push bx
		;mov bx, dx ; cx-> 0x1234
		shr bx, 8 ; cx-> 0x00012
		and bx, 0x000f ; cx-> 0x0002
		;add cx, 48
		mov bx, [bx + HEXABET]
		mov [HEX_TEMPLATE+3], bl ; replace 2nd index at HEX_TEMPLATE location
		pop bx
		;========
		push bx
		;mov bx, dx ; cx-> 0x1234
		shr bx, 4 ; cx-> 0x0123
		and bx, 0x000f ; cx-> 0x0003
		;add cx, 48
		mov bx, [bx + HEXABET]
		mov [HEX_TEMPLATE+4], bl ; replace 2nd index at HEX_TEMPLATE location
		pop bx
		;========
		push bx
		;mov bx, dx ; cx-> 0x1234
		and bx, 0x000f ; cx-> 0x0003
		;add cx, 48
		mov bx, [bx + HEXABET]
		mov [HEX_TEMPLATE+5], bl ; replace 2nd index at HEX_TEMPLATE location
		pop bx
		;=======PRINT HEX
		mov bx, HEX_TEMPLATE ; pass argument to print string
		call printString
	popa
	ret
	
; findBIOS:
	; pusha
	; mov bx, 0
	; mov es, bx
	; _search_loop:
	
	; mov al, [es:bx]
	; cmp al, 'B'
	; jne _continue_search
	
	; mov al, [es:bx+1]
	; cmp al, 'I'
	; jne _continue_search
	
	; mov al, [es:bx+2]
	; cmp al, 'O'
	; jne _continue_search
	
	; mov al, [es:bx+3]
	; cmp al, 'S'
	; jne _continue_search
	
	; push bx
	; mov bx, es
	; call printHex
	; pop bx
	
	; call printHex ; print out mem location of string found
	
	; push bx
	; mov bx, es
	; mov ds, bx
	; pop bx
	
	; call printString ; print out the string contents of the string found
	; jmp $
	
	; _continue_search:
	; inc bx
	; cmp bx, 0
	; je _inc_segment
	
	; jmp _search_loop
		
	; _inc_segment:
		; push bx
		; mov bx, es
		; add bx, 0x1000
		; mov es, bx
		; pop bx
		; jmp _search_loop
		
	; popa
	; ret
	
read_from_disk:
	pusha
	
	mov ah, 0x02 ;disk reading functions
	
	;mov al, 1 ; number of sectors to read_from_disk
	mov ch, 0 ; select cylinder to read
	mov dh, 0 ; select head to use
	mov cl, 2 ; select 2nd sector (the sector that goes straight after boot loader)
	
	push bx
	mov bx, 0
	mov es, bx ; set the sector to read the data to from disk
	pop bx
	;mov bx, 0x7c00 + 512 ; absolute memory location in the sector to read in to from disk
	int 0x13
	
	jc read_error ; jump to error message if carry flag is set by BIOS
	popa
	ret
	
	
read_error:
	mov bx, DISK_READ_ERROR
	call printString
	jmp $
endLine:
	pusha
	mov ah, 0x03
	mov bh, 0
	int 0x10

	mov ah, 0x02
	mov bh, 0
	add dh, 1
	mov dl, 0
	int 0x10
	popa
	ret
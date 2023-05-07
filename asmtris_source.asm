.model small
org 0100h

.data
	;tablero de juego (sólo contiene piezas estáticas)
	tablero db 0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0
		db 0,0,0,0,0,0,0,0,0,0
	;variables de estado de las teclas
		arriba db 0
		abajo db 0
		izquierda db 0
		derecha db 0
		z db 0
		x db 0
	;posiciones de las piezas de los tetriminos
		pivote_x db 41
		pivote_y db 0
		pieza_x db 41,41,41
		pieza_y db 0,0,0
	;variables debug
		debug_counter dw 0
		debug_color db 2
		hex db 48,49,50,51,52,53,54,55,56,57,65,66,67,68,69,70
	;otras variables
		flag_pausa db 1
		flag_game_over db 0
		flag_bajar db 0
		tetrimino_rotable db 1
		cooldown_bajada db 1
		max_cooldown_bajada db 14
		lineas dw 0
		semilla dw 16;para generar numeros pseudoaleatorios
	;tabla de tetriminos
	tetrimino  db   0,  0,  1,  0;pieza
		   db   1,255,  1,  0;L1
		   ;----------------
		   db   1,  0,  0,  0;pieza
		   db   1,255,  1,  0;L2
		   ;----------------
		   db   0,  1,  0,  0;pieza
		   db   1,255,  1,  0;T
		   ;----------------
		   db   0,  0,  0,  0;pieza
		   db   1,255,  1,  1;larga
			;----------------
		   db   0,  1,  1,  0;pieza
		   db   1,255,  0,  0;S
		   ;----------------
		   db   1,  1,  0,  0;pieza
		   db   0,255,  1,  0;Z
		   ;----------------
		   db   1,255,  0,  0;pieza
		   db   1,  1,  0,  0;cuadrada
		   
	;letras
	letras 	db    0 ,15,15,0 ,   15,15,15,0 ,   0 ,15,15,0 ,   15,15,15,0 ,   15,15,15,15,   15,15,15,15,   0 ,15,15,15,   15,0 ,0 ,15,   15,15,15,0 ,   15,15,15,15,   15,0 ,0 ,15,   15,0 ,0 ,0 ,   15,0 ,0 ,15,   15,0 ,0 ,15,   0 ,15,15,0 ,   15,15,15,0 ,   15,15,15,0 ,   15,15,15,0 ,   0 ,15,15,15,   15,15,15,0 ,   15,0 ,0 ,15,   15,0 ,15,15,   15,0 ,0 ,15,   15,0 ,0 ,15,   15,0 ,0 ,15,   15,15,15,15,   15,15,15,15,   0 ,15,15,0 ,   0 ,15,15,0 ,   15,15,15,15,   15,0 ,15,15,   15,15,15,15,   15,15,15,15,   15,15,15,15,   15,15,15,15,   15,15,15,15
		db    15,0 ,0 ,15,   15,0 ,0 ,15,   15,0 ,0 ,15,   15,0 ,0 ,15,   15,0 ,0 ,0 ,   15,0 ,0 ,0 ,   15,0 ,0 ,0 ,   15,0 ,0 ,15,   0 ,15,0 ,0 ,   0 ,0 ,15,0 ,   15,0 ,15,0 ,   15,0 ,0 ,0 ,   15,15,15,15,   15,15,0 ,15,   15,0 ,0 ,15,   15,0 ,0 ,15,   15,0 ,0 ,15,   15,0 ,0 ,15,   15,0 ,0 ,0 ,   0 ,15,0 ,0 ,   15,0 ,0 ,15,   15,0 ,0 ,15,   15,0 ,0 ,15,   0 ,15,15,0 ,   15,0 ,0 ,15,   0 ,0 ,15,0 ,   15,15,0 ,15,   15,15,15,0 ,   15,0 ,0 ,15,   0 ,0 ,15,15,   15,0 ,15,15,   15,15,0 ,0 ,   15,15,0 ,0 ,   0 ,0 ,15,15,   15,15,0 ,15,   15,0 ,15,15
		db    15,15,15,15,   15,15,15,0 ,   15,0 ,0 ,0 ,   15,0 ,0 ,15,   15,15,15,0 ,   15,15,15,0 ,   15,0 ,15,15,   15,15,15,15,   0 ,15,0 ,0 ,   0 ,0 ,15,0 ,   15,15,0 ,15,   15,0 ,0 ,0 ,   15,0 ,0 ,15,   15,15,15,15,   15,0 ,0 ,15,   15,15,15,0 ,   15,0 ,0 ,15,   15,15,15,0 ,   0 ,15,15,0 ,   0 ,15,0 ,0 ,   15,0 ,0 ,15,   15,0 ,0 ,15,   15,0 ,15,15,   0 ,15,15,0 ,   0 ,15,15,15,   0 ,15,0 ,0 ,   15,15,0 ,15,   0 ,15,15,0 ,   0 ,0 ,15,15,   0 ,15,15,15,   15,15,15,15,   15,15,15,15,   15,15,15,15,   0 ,15,15,15,   15,15,15,15,   15,15,15,15
		db    15,0 ,0 ,15,   15,0 ,0 ,15,   15,0 ,0 ,15,   15,0 ,0 ,15,   15,0 ,0 ,0 ,   15,0 ,0 ,0 ,   15,0 ,0 ,15,   15,0 ,0 ,15,   0 ,15,0 ,0 ,   15,0 ,15,0 ,   15,0 ,0 ,15,   15,0 ,0 ,0 ,   15,0 ,0 ,15,   15,0 ,15,15,   15,0 ,0 ,15,   15,0 ,0 ,0 ,   15,0 ,15,15,   15,0 ,0 ,15,   0 ,0 ,0 ,15,   0 ,15,0 ,0 ,   15,0 ,0 ,15,   15,0 ,15,0 ,   15,15,0 ,15,   15,0 ,0 ,15,   0 ,0 ,0 ,15,   15,0 ,0 ,15,   15,15,0 ,15,   0 ,15,15,0 ,   0 ,15,15,0 ,   0 ,0 ,15,15,   0 ,0 ,15,15,   0 ,0 ,15,15,   15,15,0 ,15,   15,15,15,0 ,   15,15,0 ,15,   0 ,0 ,15,15
		db    15,0 ,0 ,15,   15,15,15,0 ,   0 ,15,15,0 ,   15,15,15,0 ,   15,15,15,15,   15,0 ,0 ,0 ,   0 ,15,15,0 ,   15,0 ,0 ,15,   15,15,15,0 ,   0 ,15,0 ,0 ,   15,0 ,0 ,15,   15,15,15,0 ,   15,0 ,0 ,15,   15,0 ,0 ,15,   0 ,15,15,0 ,   15,0 ,0 ,0 ,   0 ,15,15,15,   15,0 ,0 ,15,   15,15,15,0 ,   0 ,15,0 ,0 ,   0 ,15,15,0 ,   0 ,15,0 ,0 ,   15,0 ,0 ,15,   15,0 ,0 ,15,   15,15,15,0 ,   15,15,15,15,   15,15,15,15,   15,15,15,15,   15,15,15,15,   15,15,15,15,   0 ,0 ,15,15,   15,15,15,15,   15,15,15,15,   15,15,0 ,0 ,   15,15,15,15,   15,15,15,15

	;sprites
	bloque_rojo 	db 15,15,15,15,15,15,15,15
			db 15,15,15,15,15,15,15, 4
			db 15,15,12,12,12,12, 4, 4
			db 15,15,12,12,12,12, 4, 4
			db 15,15,12,12,12,12, 4, 4
			db 15,15,12,12,12,12, 4, 4
			db 15, 4, 4, 4, 4, 4, 4, 4
			db  4, 4, 4, 4, 4, 4, 4, 4
	
	bloque_azul 	db 15,15,15,15,15,15,15,15
			db 15,15,15,15,15,15,15, 1
			db 15,15,11,11,11,11, 1, 1
			db 15,15,11,11,11,11, 1, 1
			db 15,15,11,11,11,11, 1, 1
			db 15,15,11,11,11,11, 1, 1
			db 15, 1, 1, 1, 1, 1, 1, 1
			db  1, 1, 1, 1, 1, 1, 1, 1
	
	bloque_amarillo db 15,15,15,15,15,15,15,15
			db 15,15,15,15,15,15,15,12
			db 15,15,14,14,14,14,12,12
			db 15,15,14,14,14,14,12,12
			db 15,15,14,14,14,14,12,12
			db 15,15,14,14,14,14,12,12
			db 15,12,12,12,12,12,12,12
			db 12,12,12,12,12,12,12,12
	
	bloque_vacio	 db 0,0,0,0,0,0,0,0
			 db 0,0,0,0,0,0,0,0
			 db 0,0,0,0,0,0,0,0
			 db 0,0,0,0,0,0,0,0
			 db 0,0,0,0,0,0,0,0
			 db 0,0,0,0,0,0,0,0
			 db 0,0,0,0,0,0,0,0
			 db 0,0,0,0,0,0,0,0

.code
	mov ax,seg tablero
	mov ds,ax;inicializacion del registro de segmento de datos
	
	jmp inicio
	
;######################################### INTERRUPCIONES ####################################################

int_teclado proc
	cli
	;actualiza las variables de estado de las teclas
	
	cmp byte ptr flag_pausa,0
	jnz pulsa_enter
	
	pulsa_arriba:
	cmp al,48h
	jne suelta_arriba
		mov arriba,1
		call estampar_piezas
	suelta_arriba:
	cmp al,0C8h
	jne pulsa_abajo
		mov arriba,0
	pulsa_abajo:
	cmp al,50h
	jne suelta_abajo
		mov byte ptr abajo,1
		mov byte ptr cooldown_bajada,1
	suelta_abajo:
	cmp al,0D0h
	jne pulsa_izquierda
		mov byte ptr abajo,0
	pulsa_izquierda:
	cmp al,4Bh
	jne suelta_izquierda
		mov byte ptr izquierda,1
		call mover_izquierda
	suelta_izquierda:
	cmp al,0CBh
	jne pulsa_derecha
		mov byte ptr izquierda,0
	pulsa_derecha:
	cmp al,4Dh
	jne suelta_derecha
		mov byte ptr derecha,1
		call mover_derecha
	suelta_derecha:
	cmp al,0CDh
	jne pulsa_z
		mov byte ptr derecha,0
	pulsa_z:
	cmp al,2Ch
	jne suelta_z
		mov byte ptr z,1
		call rotar_piezas
	suelta_z:
	cmp al,0ACh
	jne pulsa_x
		mov byte ptr z,0
	pulsa_x:
	cmp al,2Dh
	jne suelta_x
		mov byte ptr x,1
		call rotar_piezasr
	suelta_x:
	cmp al,0ADh
	jne pulsa_enter
		
	pulsa_enter:
	cmp al,1Ch
	jne suelta_enter
		cmp byte ptr flag_game_over,0
		jz pulsa_enter_flag_pausa
			call reset
		jmp suelta_enter
		pulsa_enter_flag_pausa:
			call pausar
	suelta_enter:
	cmp al,09ch
	jne teclado_fin
	
	teclado_fin:
	
	sti
	iret
int_teclado endp

int_temporizador proc
	cli
	
	temp_bajar:
		dec cooldown_bajada
		jnz int_temporizador_fin
			mov ah,max_cooldown_bajada
			mov cooldown_bajada,ah
			call bajar_tetrimino
		int_temporizador_fin:
	sti
iret
int_temporizador endp

;################################################## RUTINAS JUEGO #########################################################

reset proc
	push ax
	push dx
	
	mov byte ptr flag_game_over,0
	mov byte ptr max_cooldown_bajada,14
	mov word ptr lineas,0
	call mostrar_lineas
	
	xor al,al
	reset1:
		xor ah,ah
		reset2:
			mov dl,0
			call set_tablero
		inc ah
		cmp ah,10
		jb reset2
	inc al
	cmp al,20
	jb reset1
	
	call dibujar_tablero
	
	pop dx
	pop ax
ret
reset endp

pausar proc
	push cx
	push dx
	push si
	
	cmp byte ptr flag_pausa,0
	jz flag_pausar_0
	
	mov byte ptr flag_pausa,0
	
	call dibujar_tablero
	
	mov ah,pivote_x
	mov al,pivote_y
	mov si,offset bloque_rojo
	call dibujar_bloque
	
	xor di,di
	pausar_tetrimino_mostrar:
		mov ah,pieza_x[di]
		mov al,pieza_y[di]
		mov si,offset bloque_rojo
		call dibujar_bloque
	inc di
	cmp di,3
	jb pausar_tetrimino_mostrar
	
	jmp flag_pausar_fin
	flag_pausar_0:
	
	mov byte ptr flag_pausa,1
	
	;dibujar recuadro negro:
	
	;pos ini:
	mov si,(15+1)*8+(2+7)*8*320
	pausar1:
		mov cx,34
		pausar2:
			mov word ptr es:[si],0
			add si,2
		loop pausar2
		
		add si,252
		cmp si,(15)*8+(2+11)*8*320
	jbe pausar1
	
	;dibujar marco
	
	mov ax,16*8+1
	mov bx,9*8+1
	mov cx,25*8-6
	mov dx,13*8-2
	
	call dibujar_recuadro
	
	mov cx,150
	mov dx,85
	mov si,'P'
	call dibujar_letra
	add cx,5
	mov si,'A'
	call dibujar_letra
	add cx,5
	mov si,'U'
	call dibujar_letra
	add cx,5
	mov si,'S'
	call dibujar_letra
	add cx,5
	mov si,'A'
	call dibujar_letra
	
	flag_pausar_fin:
	
	pop si
	pop dx
	pop cx
ret
pausar endp

mover_izquierda proc
	push ax
	push si
	
	;comprobar pivote
	mov ah,pivote_x
	dec ah
	mov al,pivote_y
	call get_tablero
	cmp dl,2
	je mover_izquierda_no_hay_espacio
	
	;comprobar resto de piezas
	xor si,si
	mover_izquierda_bucle1:
		mov ah,pieza_x[si]
		dec ah
		mov al,pieza_y[si]
		call get_tablero
		cmp dl,2
		je mover_izquierda_no_hay_espacio
	inc si
	cmp si,3
	jb mover_izquierda_bucle1
	
	;hay espacio:
	mov ah,pivote_x
	mov al,pivote_y
	mov si,offset bloque_vacio
	call dibujar_bloque
	
	dec pivote_x
	
	xor si,si
	mover_izquierda_bucle2:
		push si
			mov ah,pieza_x[si]
			mov al,pieza_y[si]
			mov si,offset bloque_vacio
			call dibujar_bloque
		pop si
		dec pieza_x[si]
	inc si
	cmp si,3
	jb mover_izquierda_bucle2
	
	mov ah,pivote_x
	mov al,pivote_y
	mov si,offset bloque_rojo
	call dibujar_bloque
	
	xor si,si
	mover_izquierda_bucle3:
		push si
			mov ah,pieza_x[si]
			mov al,pieza_y[si]
			mov si,offset bloque_rojo
			call dibujar_bloque
		pop si
	inc si
	cmp si,3
	jb mover_izquierda_bucle3
	
	mover_izquierda_no_hay_espacio:
	pop si
	pop ax
ret
mover_izquierda endp

mover_derecha proc
	push ax
	push si
	
	;comprobar pivote
	mov ah,pivote_x
	inc ah
	mov al,pivote_y
	call get_tablero
	cmp dl,2
	je mover_derecha_no_hay_espacio
	
	;comprobar resto de piezas
	xor si,si
	mover_derecha_bucle1:
		mov ah,pieza_x[si]
		inc ah
		mov al,pieza_y[si]
		call get_tablero
		cmp dl,2
		je mover_derecha_no_hay_espacio
	inc si
	cmp si,3
	jb mover_derecha_bucle1
	
	;hay espacio:
	mov ah,pivote_x
	mov al,pivote_y
	mov si,offset bloque_vacio
	call dibujar_bloque
	
	inc pivote_x
	
	xor si,si
	mover_derecha_bucle2:
		push si
			mov ah,pieza_x[si]
			mov al,pieza_y[si]
			mov si,offset bloque_vacio
			call dibujar_bloque
		pop si
		inc pieza_x[si]
	inc si
	cmp si,3
	jb mover_derecha_bucle2
	
	mov ah,pivote_x
	mov al,pivote_y
	mov si,offset bloque_rojo
	call dibujar_bloque
	
	xor si,si
	mover_derecha_bucle3:
		push si
			mov ah,pieza_x[si]
			mov al,pieza_y[si]
			mov si,offset bloque_rojo
			call dibujar_bloque
		pop si
	inc si
	cmp si,3
	jb mover_derecha_bucle3
	
	mover_derecha_no_hay_espacio:
	pop si
	pop ax
ret
mover_derecha endp

rotar_piezas proc
	push ax
	push si
	
	cmp tetrimino_rotable,0
	jz rotar_piezas_fin
	
	xor si,si
	rotar_piezas1:
		mov ah,pivote_x
		add ah,pivote_y
		sub ah,pieza_y[si]
		
		mov al,pieza_x[si]
		add al,pivote_y
		sub al,pivote_x
		
		call get_tablero
		
		cmp dl,2
		je rotar_piezas_fin
	inc si
	cmp si,3
	jb rotar_piezas1
	
	;hay espacio para rotar
	
	xor si,si
	rotar_piezas2:
		mov ah,pieza_x[si]
		mov al,pieza_y[si]
		push si
			mov si,offset bloque_vacio
			call dibujar_bloque
		pop si
	inc si
	cmp si,3
	jb rotar_piezas2
	
	xor si,si
	rotar_piezas3:
		mov ah,pivote_x
		add ah,pivote_y
		sub ah,pieza_y[si]
		
		mov al,pieza_x[si]
		add al,pivote_y
		sub al,pivote_x
		
		push si
			mov si,offset bloque_rojo
			call dibujar_bloque
		pop si
		
		mov pieza_x[si],ah
		mov pieza_y[si],al
	inc si
	cmp si,3
	jb rotar_piezas3
	
	rotar_piezas_fin:
	pop si
	pop ax
ret
rotar_piezas endp

rotar_piezasr proc
	push ax
	push si
	
	cmp tetrimino_rotable,0
	jz rotar_piezasr_fin
	
	xor si,si
	rotar_piezasr1:
		mov ah,pieza_y[si]
		add ah,pivote_x
		sub ah,pivote_y
		
		mov al,pivote_x
		add al,pivote_y
		sub al,pieza_x[si]
		
		call get_tablero
		
		cmp dl,2
		je rotar_piezasr_fin
	inc si
	cmp si,3
	jb rotar_piezasr1
	
	;hay espacio para rotar
	
	xor si,si
	rotar_piezasr2:
		mov ah,pieza_x[si]
		mov al,pieza_y[si]
		push si
			mov si,offset bloque_vacio
			call dibujar_bloque
		pop si
	inc si
	cmp si,3
	jb rotar_piezasr2
	
	xor si,si
	rotar_piezasr3:
		mov ah,pieza_y[si]
		add ah,pivote_x
		sub ah,pivote_y
		
		mov al,pivote_x
		add al,pivote_y
		sub al,pieza_x[si]
		
		push si
			mov si,offset bloque_rojo
			call dibujar_bloque
		pop si
		
		mov pieza_x[si],ah
		mov pieza_y[si],al
	inc si
	cmp si,3
	jb rotar_piezasr3
	
	rotar_piezasr_fin:
	pop si
	pop ax
ret
rotar_piezasr endp

dibujar_letra proc;ok
	;dibuja la letra número "si"(en ASCII) en las coordenadas cx,dx
	push ax
	push cx
	push dx
	push si
	push di
	
	cmp si,65
	jae dibujar_letra_es_letra
		;es numero
		sub si,22
		jmp dibujar_letra_inicio
	
	dibujar_letra_es_letra:
	sub si,65

	dibujar_letra_inicio:
	;SI:-----------------------------------
	shl si,2
	add si,offset letras
	;DI:-----------------------------------
	mov ax,320
	mul dx;dxax=ax*dx
	add ax,cx
	mov di,ax;di=dirección base en pantalla
	;--------------------------------------
	cld;para que movsw haga si+=2,di+=2
	
	mov ax,0
	dibujar_letra_bucle:
	
	movsw
	movsw
	
	add di,316
	add si,140
	
	inc ax
	cmp ax,5
	jb dibujar_letra_bucle
	
	pop di
	pop si
	pop dx
	pop cx
	pop ax
ret
dibujar_letra endp

dibujar_debug proc;ok (súper útil)
	;muestra un pixel verde en pantalla cuando se ejecuta
	
	push si
	
	mov si,debug_counter
	push ax
	mov al,debug_color
	mov es:[si],al
	mov es:[si+1],al
	mov es:[si+320],al
	mov es:[si+321],al
	pop ax
	add debug_counter,4

	pop si

ret
dibujar_debug endp

bajar_tetrimino proc;ok
	;este procedimiento baja el tetrimino si hay espacio
	;si no queda espacio: cala la pieza y genera una nueva
	
	push ax
	push si
	push di
	
	cmp flag_pausa,0
	jnz bajar_tetrimino_fin
	;comprobar que todas las piezas tienen espacio para bajar
	mov ah,pivote_x
	mov al,pivote_y
	inc al
	call get_tablero
	cmp dl,0
	jnz bajar_tetrimino_calar
	
	xor si,si
	bajar_tetrimino_comprobar:
		mov ah,pieza_x[si]
		mov al,pieza_y[si]
		inc al
		call get_tablero
		cmp dl,0
		jnz bajar_tetrimino_calar
	inc si
	cmp si,3
	jnz bajar_tetrimino_comprobar
	
	;hay espacio: actualizar el tetrimino y bajar la pieza
	
	;primero borro el tetrimino actual
	mov si,offset bloque_vacio
	mov ah,pivote_x
	mov al,pivote_y
	call dibujar_bloque
	
	xor di,di
	bajar_tetrimino_borrar:
		mov ah,pieza_x[di]
		mov al,pieza_y[di]
		call dibujar_bloque
	inc di
	cmp di,3
	jnz bajar_tetrimino_borrar
	
	;luego actualizo los valores de posición de las piezas
	;y dibujo los bloques en el tablero
	
	mov si,offset bloque_rojo
	inc byte ptr pivote_y
	mov ah,pivote_x
	mov al,pivote_y
	call dibujar_bloque
	
	mov si,offset bloque_rojo
	xor di,di
	bajar_tetrimino_colocar:
		inc byte ptr pieza_y[di]
		mov ah,pieza_x[di]
		mov al,pieza_y[di]
		call dibujar_bloque
	inc di
	cmp di,3
	jnz bajar_tetrimino_colocar
	
	jmp bajar_tetrimino_fin
	bajar_tetrimino_calar:
		call calar_piezas
	bajar_tetrimino_fin:
	pop di
	pop si
	pop ax
ret
bajar_tetrimino endp

mostrar_registros proc;ok (súper útil)
;interrumpe el programa y muestra el valor en hexadecimal de los registros
	push di
	push si
	push dx
	push cx
	push bx
	push ax
	
	;apilar todos los registros relevantes
	
	push di
	push si
	push dx
	push cx
	push bx
	push ax
	;se irán desapilando a medida que se muestran por pantalla
	;----------------------------------AX
	mov cx,4
	mov dx,4
	mov si,'R'
	call dibujar_letra
	add cx,5
	mov si,'E'
	call dibujar_letra
	add cx,5
	mov si,'G'
	call dibujar_letra
	add cx,5
	mov si,'I'
	call dibujar_letra
	add cx,4
	mov si,'S'
	call dibujar_letra
	add cx,5
	mov si,'T'
	call dibujar_letra
	add cx,4
	mov si,'R'
	call dibujar_letra
	add cx,5
	mov si,'O'
	call dibujar_letra
	add cx,5
	mov si,'S'
	call dibujar_letra
	add cx,5
	
	mov cx,4
	add dx,7
	xor bx,bx
	
	mov si,'A'
	call dibujar_letra
	add cx,5
	mov si,'X'
	call dibujar_letra
	add cx,10

	pop ax
	mov si,ax
	and si,0f000h
	shr si,12
	mov byte ptr bl,hex[si]
	mov si,bx
	call dibujar_letra
	add cx,5

	mov si,ax
	and si,0f00h
	shr si,8
	mov byte ptr bl,hex[si]
	mov si,bx
	call dibujar_letra
	add cx,5

	mov si,ax
	and si,00f0h
	shr si,4
	mov byte ptr bl,hex[si]
	mov si,bx
	call dibujar_letra
	add cx,5

	mov si,ax
	and si,000fh
	mov byte ptr bl,hex[si]
	mov si,bx
	call dibujar_letra
	add cx,5
	
	;----------------------------------BX
	mov cx,4
	add dx,7
	
	mov si,'B'
	call dibujar_letra
	add cx,5
	mov si,'X'
	call dibujar_letra
	add cx,10

	pop ax
	mov si,ax
	and si,0f000h
	shr si,12
	mov byte ptr bl,hex[si]
	mov si,bx
	call dibujar_letra
	add cx,5

	mov si,ax
	and si,0f00h
	shr si,8
	mov byte ptr bl,hex[si]
	mov si,bx
	call dibujar_letra
	add cx,5

	mov si,ax
	and si,00f0h
	shr si,4
	mov byte ptr bl,hex[si]
	mov si,bx
	call dibujar_letra
	add cx,5

	mov si,ax
	and si,000fh
	mov byte ptr bl,hex[si]
	mov si,bx
	call dibujar_letra
	add cx,5
	;----------------------------------CX
	mov cx,4
	add dx,7
	
	mov si,'C'
	call dibujar_letra
	add cx,5
	mov si,'X'
	call dibujar_letra
	add cx,10

	pop ax
	mov si,ax
	and si,0f000h
	shr si,12
	mov byte ptr bl,hex[si]
	mov si,bx
	call dibujar_letra
	add cx,5

	mov si,ax
	and si,0f00h
	shr si,8
	mov byte ptr bl,hex[si]
	mov si,bx
	call dibujar_letra
	add cx,5

	mov si,ax
	and si,00f0h
	shr si,4
	mov byte ptr bl,hex[si]
	mov si,bx
	call dibujar_letra
	add cx,5

	mov si,ax
	and si,000fh
	mov byte ptr bl,hex[si]
	mov si,bx
	call dibujar_letra
	add cx,5
	;----------------------------------DX
	mov cx,4
	add dx,7
	
	mov si,'D'
	call dibujar_letra
	add cx,5
	mov si,'X'
	call dibujar_letra
	add cx,10

	pop ax
	mov si,ax
	and si,0f000h
	shr si,12
	mov byte ptr bl,hex[si]
	mov si,bx
	call dibujar_letra
	add cx,5

	mov si,ax
	and si,0f00h
	shr si,8
	mov byte ptr bl,hex[si]
	mov si,bx
	call dibujar_letra
	add cx,5

	mov si,ax
	and si,00f0h
	shr si,4
	mov byte ptr bl,hex[si]
	mov si,bx
	call dibujar_letra
	add cx,5

	mov si,ax
	and si,000fh
	mov byte ptr bl,hex[si]
	mov si,bx
	call dibujar_letra
	add cx,5
	;----------------------------------SI
	mov cx,4
	add dx,7
	
	mov si,'S'
	call dibujar_letra
	add cx,5
	mov si,'I'
	call dibujar_letra
	add cx,10

	pop ax
	mov si,ax
	and si,0f000h
	shr si,12
	mov byte ptr bl,hex[si]
	mov si,bx
	call dibujar_letra
	add cx,5

	mov si,ax
	and si,0f00h
	shr si,8
	mov byte ptr bl,hex[si]
	mov si,bx
	call dibujar_letra
	add cx,5

	mov si,ax
	and si,00f0h
	shr si,4
	mov byte ptr bl,hex[si]
	mov si,bx
	call dibujar_letra
	add cx,5

	mov si,ax
	and si,000fh
	mov byte ptr bl,hex[si]
	mov si,bx
	call dibujar_letra
	add cx,5
	;----------------------------------DI
	mov cx,4
	add dx,7
	
	mov si,'D'
	call dibujar_letra
	add cx,5
	mov si,'I'
	call dibujar_letra
	add cx,10

	pop ax
	mov si,ax
	and si,0f000h
	shr si,12
	mov byte ptr bl,hex[si]
	mov si,bx
	call dibujar_letra
	add cx,5

	mov si,ax
	and si,0f00h
	shr si,8
	mov byte ptr bl,hex[si]
	mov si,bx
	call dibujar_letra
	add cx,5

	mov si,ax
	and si,00f0h
	shr si,4
	mov byte ptr bl,hex[si]
	mov si,bx
	call dibujar_letra
	add cx,5

	mov si,ax
	and si,000fh
	mov byte ptr bl,hex[si]
	mov si,bx
	call dibujar_letra
	add cx,5
	
	pop ax
	pop bx
	pop cx
	pop dx
	pop si
	pop di
ret
mostrar_registros endp

hay_espacio proc;ok
	;comprueba si hay espacio para colocar el tetrimino con desplazamiento si dentro de tetrimino[]
	push ax
	push si
		
	xor al,al
	hay_espacio_alto:
		mov ah,3
		hay_espacio_ancho:
		cmp byte ptr tetrimino[si],0
		jz hay_espacio_0
			call get_tablero
			cmp dl,0
			jnz no_hay_espacio
		hay_espacio_0:
		inc si
		inc ah
		cmp ah,7
		jb hay_espacio_ancho
	inc al
	cmp al,2
	jb hay_espacio_alto

	mov dl,1
	
	pop si
	pop ax
ret
	no_hay_espacio:
	mov dl,0

	pop si
	pop ax
ret
hay_espacio endp

colocar_tetrimino proc;ok
	;coloca el tetrimino con desplazamiento si dentro de tetrimino[]
	cli
	push ax
	push si
	push di;para contar el numero de piezas encontradas

	xor di,di
	
	xor al,al
	colocar_tetrimino_alto:
		mov ah,3
		colocar_tetrimino_ancho:
		cmp byte ptr tetrimino[si],0
		jz colocar_tetrimino_0
			cmp byte ptr tetrimino[si],1
			je colocar_tetrimino_1
				mov byte ptr pivote_x,ah
				mov byte ptr pivote_y,al
				jmp colocar_tetrimino_0
			colocar_tetrimino_1:
				mov byte ptr pieza_x[di],ah
				mov byte ptr pieza_y[di],al
				inc di
		colocar_tetrimino_0:
		inc si
		inc ah
		cmp ah,7
		jb colocar_tetrimino_ancho
	inc al
	cmp al,2
	jb colocar_tetrimino_alto
	
	mov ah,pivote_x
	mov al,pivote_y
	mov si,offset bloque_rojo
	call dibujar_bloque
	
	xor di,di
	colocar_tetrimino_mostrar:
		mov ah,pieza_x[di]
		mov al,pieza_y[di]
		mov si,offset bloque_rojo
		call dibujar_bloque
	inc di
	cmp di,3
	jb colocar_tetrimino_mostrar
	
	pop di
	pop si
	pop ax
	sti
ret
colocar_tetrimino endp

generar_tetrimino proc;ok
	;este procedimiento genera un tetrimino indicado por "si" sólo si hay espacio
	;si no hay espacio, ejecuta game_over
	cli
	push dx
	
	cmp si,6
	jne rotable;la pieza cuadrada (6) no es rotable
		mov byte ptr tetrimino_rotable,0
		jmp no_rotable
	rotable:
		mov byte ptr tetrimino_rotable,1
	no_rotable:
	shl si,3
	
	;compruebo si hay espacio
	call hay_espacio
	cmp dl,0
	jz generar_tetrimino_fin
	
	call colocar_tetrimino
	
	pop dx
	sti
	ret
	
	generar_tetrimino_fin:
	
	call game_over
	
	pop dx
	sti
ret
generar_tetrimino endp

game_over proc;ok!!
	
	push ax
	push bx
	push cx
	push dx
	push si

	cmp byte ptr flag_game_over,0
	jnz game_over3
	;dibujar recuadro negro:
	
	;pos ini:
	mov si,(15+1)*8+(2+7)*8*320
	game_over1:
		mov cx,34
		game_over2:
			mov word ptr es:[si],0
			add si,2
		loop game_over2
		
		add si,252
		cmp si,(15)*8+(2+11)*8*320
	jbe game_over1
	
	;dibujar marco
	
	mov ax,16*8+1
	mov bx,9*8+1
	mov cx,25*8-6
	mov dx,13*8-2
	
	call dibujar_recuadro
	
	game_over3:
	
	;dibujar "game over, pulsa enter":
	mov cx,140
	mov dx,80
	
	mov si,'G'
	call dibujar_letra
	add cx,5
	
	mov si,'A'
	call dibujar_letra
	add cx,5
	
	mov si,'M'
	call dibujar_letra
	add cx,5
	
	mov si,'E'
	call dibujar_letra
	add cx,10
	
	mov si,'O'
	call dibujar_letra
	add cx,5
	
	mov si,'V'
	call dibujar_letra
	add cx,5
	
	mov si,'E'
	call dibujar_letra
	add cx,5
	
	mov si,'R'
	call dibujar_letra
	add cx,5
	
	mov cx,136
	mov dx,90
	
	mov si,'P'
	call dibujar_letra
	add cx,5
	
	mov si,'U'
	call dibujar_letra
	add cx,5
	
	mov si,'L'
	call dibujar_letra
	add cx,4
	
	mov si,'S'
	call dibujar_letra
	add cx,5
	
	mov si,'A'
	call dibujar_letra
	add cx,10
	
	mov si,'E'
	call dibujar_letra
	add cx,5
	
	mov si,'N'
	call dibujar_letra
	add cx,5
	
	mov si,'T'
	call dibujar_letra
	add cx,5
	
	mov si,'E'
	call dibujar_letra
	add cx,5
	
	mov si,'R'
	call dibujar_letra
	add cx,5
	
	mov byte ptr flag_game_over,1
	
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	
ret
game_over endp

calar_piezas proc;ok
	;este procedimiento cala las piezas en el tablero
	push ax
	push si
	push di
	
	mov ah,pivote_x
	mov al,pivote_y
	mov dl,2
	call set_tablero
	
	xor di,di
	calar_piezas_colocar:
		mov ah,pieza_x[di]
		mov al,pieza_y[di]
		mov dl,2
		call set_tablero
	inc di
	cmp di,3
	jnz calar_piezas_colocar
	
	call pseudoaleatorio
	xor dh,dh
	mov si,dx
	call generar_tetrimino
	call comprobar_linea
	
	pop di
	pop si
	pop ax
ret
calar_piezas endp

set_tablero proc;ok
	;colocar en el tablero el valor dl en la posició ah,al
	;primero compruebo si se trata de una posición valida dentro del tablero:
	cmp ah,10
	ja set_tablero_error
	cmp al,20
	ja set_tablero_error
	
	push ax
	push si
	
	;actualizo la pantalla
	cmp dl,0
	jnz set_bloque_azul
		mov si,offset bloque_vacio
		jmp set_0
	set_bloque_azul:
	cmp dl,2
	jnz set_bloque_amarillo
		mov si,offset bloque_azul
		jmp set_0
	set_bloque_amarillo:
	cmp dl,3
		mov si,offset bloque_amarillo
	set_0:
		call dibujar_bloque
	mov si,ax;guardo ax en si para no perder ah
	mov ah,10
	mul ah;consigo ax=al*10
	shr si,8;si=ah
	add si,ax;si=ah+al*10
	
	add si,offset tablero
	mov ds:[si],dl
	
	pop si
	pop ax
	ret
	
	set_tablero_error:
ret
set_tablero endp
	
get_tablero proc;ok
	;esta rutina devuelve en dl el valor de la pieza ubicada en ah,al en el tablero
	;si la posición es inválida, devuelve 2
	
	;primero compruebo si se trata de una posición valida dentro del tablero:
	cmp ah,10
	jae get_tablero_error
	cmp al,20
	jae get_tablero_error
	
	push ax
	push si
	
	mov si,ax;primero guardo ax en si para no perder ah
	mov ah,10
	mul ah;consigo ax=al*10
	shr si,8;si=ah
	add si,ax;si=ah+al*10
	
	add si,offset tablero
	mov dl,ds:[si]
	
	pop si
	pop ax
	ret
	
	get_tablero_error:
	mov dl,2
ret
get_tablero endp

dibujar_bloque proc;ok
	;este procedimiento dibuja un bloque 8x8 en pantalla
	;posición: ah,al (en una rejilla de 8x8 con centrada en pantalla)
	;offset sprite: si
	push si
	push ax
	push dx
	push di
	
	add ah,15
	add al,2;les sumo el offset del tablero en pantalla
	
	shl ah,3
	shl al,3;multiplico ambas posiciones por 8 (rejilla 8x8)
	
	mov di,ax;primero guardo ax en di para no perder ah
	shr di,8;di=ah
	mov dx,320
	and ax,0000000011111111b
	mul dx;consigo ax=ax*320
	add di,ax;di=ah+al*10 -> posición en pantalla del bloque a dibujar

	cld	;clear direction flag -> de esta manera la instrucción
		;movsw incrementará si y di al copiar
	mov al,8
	dibujar_bloque_alto:
		mov ah,4
		dibujar_bloque_ancho:
			movsw
		dec ah
		jnz dibujar_bloque_ancho
		add di,312
	dec al
	jnz dibujar_bloque_alto
	
	pop di
	pop dx
	pop ax
	pop si
	
ret
dibujar_bloque endp

dibujar_tablero proc;ok
	;este procedimiento dibuja el tablero por completo en la pantalla (usado al inicio del programa).
	push ax
	push si
	
	xor al,al
	dibujar_tablero_alto:
		xor ah,ah
		dibujar_tablero_ancho:
			mov si,offset bloque_vacio
			call get_tablero
			cmp dl,2
			jne dibujar_tablero_fin
				mov si,offset bloque_azul
			dibujar_tablero_fin:
			call dibujar_bloque
		inc ah
		cmp ah,10
		jb dibujar_tablero_ancho
	inc al
	cmp al,20
	jb dibujar_tablero_alto
	
	pop si
	pop ax
ret
dibujar_tablero endp

dibujar_recuadro proc;ok
;dibuja un recuadro blanco desde ax,bx hasta cx,dx en pantalla
push ax
push bx
push cx
push dx
push si
push di

push ax
push dx
	;si=ax+320*bx   vvvvv
	mov di,ax
	mov si,bx
	mov ax,320
	mul bx;dxax=ax*bx
	add ax,di
	mov si,ax
	mov ax,di

	dibujar_linea1:
		mov byte ptr es:[si],15
	inc si
	inc ax
	cmp ax,cx
	jb dibujar_linea1
pop dx
pop ax
;-------------------------------------------
push ax
push dx
	;si=cx+320*dx   vvvvv
	mov di,ax
	mov ax,320
	mul dx;dxax=ax*dx
	mov si,ax
	add si,cx
	mov ax,di
pop dx
push cx
	dibujar_linea2:
		mov byte ptr es:[si],15
	dec si
	dec cx
	cmp cx,ax
	jae dibujar_linea2
pop cx
pop ax
;-------------------------------------------
push bx
push dx
	;si=ax+320*bx   vvvvv
	mov di,ax
	mov si,bx
	mov ax,320
	mul bx;dxax=ax*bx
	add ax,di
	mov si,ax
	mov ax,di
pop dx
	dibujar_linea3:
		mov byte ptr es:[si],15
	add si,320
	inc bx
	cmp bx,dx
	jb dibujar_linea3
pop bx
;-------------------------------------------
push ax
push dx
	;si=cx+320*dx   vvvvv
	mov di,ax
	mov ax,320
	mul dx;dxax=ax*dx
	mov si,ax
	add si,cx
	mov ax,di
pop dx
	dibujar_linea4:
		mov byte ptr es:[si],15
	sub si,320
	dec dx
	cmp dx,bx
	jae dibujar_linea4
pop ax
;-------------------------------------------
pop di
pop si
pop dx
pop cx
pop bx
pop ax

ret
dibujar_recuadro endp

pseudoaleatorio proc;ok
;genera un numero pseudoaleatorio entre 0 y 6 y lo introduce en dl

push ax
push bx
xor dx,dx

mov ax,semilla
mov bx,ax
shl ax,2
shr bx,2
sub ax,bx
mov bx,256
sub bx,semilla
mul bl
shr ax,8
mov semilla,ax
mov dl,7
div dl
mov dl,ah
add semilla,dx
and semilla,0000000011111111b

pop bx
pop ax

ret
pseudoaleatorio endp

tetrix proc;ok

mov cx,138
mov dx,4
mov si,'T'
call dibujar_letra
add cx,4
mov si,'E'
call dibujar_letra
add cx,5
mov si,'T'
call dibujar_letra
add cx,4
mov si,'R'
call dibujar_letra
add cx,5
mov si,'I'
call dibujar_letra
add cx,4
mov si,'X'
call dibujar_letra
add cx,5
mov si,'4'
call dibujar_letra
add cx,5
mov si,'5'
call dibujar_letra
add cx,5
mov si,'0'
call dibujar_letra

ret
tetrix endp

estampar_piezas proc
	push ax
	push si
	
	mov ah,pivote_x
	mov al,pivote_y
	mov si,offset bloque_vacio
	call dibujar_bloque
	
	xor si,si
	estampar_piezas3:
		mov ah,pieza_x[si]
		mov al,pieza_y[si]
		push si
			mov si,offset bloque_vacio
			call dibujar_bloque
		pop si
	inc si
	cmp si,3
	jb estampar_piezas3
	
	estampar_comprobar:
	;comprobar
	mov ah,pivote_x
	mov al,pivote_y
	inc al
	call get_tablero
	cmp dl,2
	je estampar_calar
	
	xor si,si
	estampar_piezas1:
		mov ah,pieza_x[si]
		mov al,pieza_y[si]
		inc al
		call get_tablero
		cmp dl,2
		je estampar_calar
	inc si
	cmp si,3
	jb estampar_piezas1
	
	;bajar las piezas
	inc pivote_y
	
	xor si,si
	estampar_piezas2:
		inc pieza_y[si]
	inc si
	cmp si,3
	jb estampar_piezas2
	
	jmp estampar_comprobar
	estampar_calar:
	
	call calar_piezas
	
	pop si
	pop ax
ret
estampar_piezas endp

comprobar_linea proc
;comprueba si hay lineas completas y las borra
	push ax
	push cx
	push si
	
	xor al,al
	comprobar_linea_alto:
		xor ah,ah
		xor cx,cx;contador de bloques
		comprobar_linea_ancho:
			call get_tablero
			cmp dl,2
			jne comprobar_linea_0
				inc cx
			comprobar_linea_0:
		inc ah
		cmp ah,10
		jb comprobar_linea_ancho
		cmp cx,10
		jne comprobar_linea_siguiente
			call borrar_linea
		comprobar_linea_siguiente:
	inc al
	cmp al,20
	jb comprobar_linea_alto
	
	call mostrar_lineas
	
	cmp lineas,80
	jb lineas_60
		mov max_cooldown_bajada,3
		jmp lineas_0
	lineas_60:
	cmp lineas,60
	jb lineas_40
		mov max_cooldown_bajada,6
		jmp lineas_0
	lineas_40:
	cmp lineas,40
	jb lineas_20
		mov max_cooldown_bajada,9
		jmp lineas_0
	lineas_20:
	cmp lineas,20
	jb lineas_0
		mov max_cooldown_bajada,12
	lineas_0:
	
	pop si
	pop cx
	pop ax
ret
comprobar_linea endp

borrar_linea proc
;borra la linea al y desplaza el tablero
push ax
push dx
push si
	
	borrar_linea_alto:
		mov ah,10
		borrar_linea_ancho:
			dec ah
			push ax
			dec al
				call get_tablero
			pop ax
				call set_tablero
		cmp ah,0
		jnz borrar_linea_ancho
	dec al
	jnz borrar_linea_alto
	
	inc lineas
	
pop si
pop dx
pop ax
ret
borrar_linea endp

mostrar_lineas proc
push si
push ax
push cx
push dx
	
	mov cx,210
	mov dx,20
	mov si,'L'
	call dibujar_letra
	add cx,4
	mov si,'I'
	call dibujar_letra
	add cx,4
	mov si,'N'
	call dibujar_letra
	add cx,5
	mov si,'E'
	call dibujar_letra
	add cx,5
	mov si,'A'
	call dibujar_letra
	add cx,5
	mov si,'S'
	call dibujar_letra
	
	mov ax,lineas
	mov si,5
	mostrar_lineas_bcd1:
		xor dx,dx
		mov cx,10
		div cx;ax=dxax/10;dx=modulo
		push dx
	dec si
	jnz mostrar_lineas_bcd1
	
	mov dx,20
	mov cx,235
	mov ax,5
	mostrar_lineas_bcd2:
		pop si
		add si,48
		add cx,5
		call dibujar_letra
	dec ax
	jnz mostrar_lineas_bcd2
	
	
	
pop dx
pop cx
pop ax
pop si
ret
mostrar_lineas endp

mostrar_controles proc
push cx
push dx
push si

	mov ax,205
	mov bx,60
	mov cx,280
	mov dx,110
	call dibujar_recuadro
	
	mov cx,210
	mov dx,65
	mov si,'C'
	call dibujar_letra
	add cx,5
	mov si,'O'
	call dibujar_letra
	add cx,5
	mov si,'N'
	call dibujar_letra
	add cx,5
	mov si,'T'
	call dibujar_letra
	add cx,4
	mov si,'R'
	call dibujar_letra
	add cx,5
	mov si,'O'
	call dibujar_letra
	add cx,5
	mov si,'L'
	call dibujar_letra
	add cx,4
	mov si,'E'
	call dibujar_letra
	add cx,5
	mov si,'S'
	call dibujar_letra
	
	mov cx,210
	add dx,15
	mov si,'M'
	call dibujar_letra
	add cx,5
	mov si,'O'
	call dibujar_letra
	add cx,5
	mov si,'V'
	call dibujar_letra
	add cx,5
	mov si,'E'
	call dibujar_letra
	add cx,5
	mov si,'R'
	call dibujar_letra
	add cx,10
	mov si,'F'
	call dibujar_letra
	add cx,5
	mov si,'L'
	call dibujar_letra
	add cx,4
	mov si,'E'
	call dibujar_letra
	add cx,5
	mov si,'C'
	call dibujar_letra
	add cx,5
	mov si,'H'
	call dibujar_letra
	add cx,5
	mov si,'A'
	call dibujar_letra
	add cx,5
	mov si,'S'
	call dibujar_letra
	add cx,5
	
	mov cx,210
	add dx,10
	mov si,'R'
	call dibujar_letra
	add cx,5
	mov si,'O'
	call dibujar_letra
	add cx,5
	mov si,'T'
	call dibujar_letra
	add cx,4
	mov si,'A'
	call dibujar_letra
	add cx,5
	mov si,'R'
	call dibujar_letra
	add cx,10
	mov si,'Z'
	call dibujar_letra
	add cx,10
	mov si,'X'
	call dibujar_letra
	
	mov cx,210
	add dx,10
	mov si,'P'
	call dibujar_letra
	add cx,5
	mov si,'A'
	call dibujar_letra
	add cx,5
	mov si,'U'
	call dibujar_letra
	add cx,5
	mov si,'S'
	call dibujar_letra
	add cx,5
	mov si,'A'
	call dibujar_letra
	add cx,5
	mov si,'R'
	call dibujar_letra
	add cx,10
	mov si,'E'
	call dibujar_letra
	add cx,5
	mov si,'N'
	call dibujar_letra
	add cx,5
	mov si,'T'
	call dibujar_letra
	add cx,4
	mov si,'E'
	call dibujar_letra
	add cx,5
	mov si,'R'
	call dibujar_letra
	add cx,5
	
	
pop si
pop dx
pop cx
ret
mostrar_controles endp

;################################################## INICIO PROGRAMA #######################################################

inicio:

;--------------------------------
mov dx,offset int_teclado	;
xor ax,ax			;todo este bloque es para poder
mov es,ax			;capturar la interrupcion de teclado
mov si,4*15h			;y asi conseguir el scancode de cada
cli				;tecla pulsada
mov es:[si],dx			;
mov es:[si+2],cs		;
sti				;
;--------------------------------

;--------------------------------
mov dx,offset int_temporizador	;
xor ax,ax			;todo este bloque es para poder
mov es,ax			;capturar la interrupcion del temporizador
mov si,4*1Ch			;
cli				;
mov es:[si],dx			;
mov es:[si+2],cs		;
sti				;
;--------------------------------

mov ax,0a000h
mov es,ax

xor ah,ah
mov al,13h;256colores,320x200
int 10h

;############################################ INICIO NORMAL ###################################################

inicio_normal:
;eventos antes del bucle
call pausar
call mostrar_lineas
call mostrar_controles
call tetrix

mov ax,118
mov bx,14
mov cx,201
mov dx,177

call dibujar_recuadro

mov ah,2Ch
int 21h
mov semilla,dx

call dibujar_tablero

;bucle del programa
bucle_programa:
	
jmp bucle_programa

end

; UNILO Bootloader BIOS (x86 real mode)
; Compilar con: nasm -f bin unilo.asm -o unilo.bin

org 0x7C00                ; dirección donde BIOS carga el MBR

start:
    ; Guardar unidad de arranque (BIOS pasa en DL)
    mov [boot_drive], dl

    ; Configurar lectura de disco
    mov ah, 0x02           ; función BIOS: leer sector
    mov al, 1              ; número de sectores a leer
    mov ch, 0              ; cilindro
    mov cl, 2              ; sector (el kernel está en el segundo sector)
    mov dh, 0              ; cabeza
    mov dl, [boot_drive]   ; unidad de arranque
    mov bx, 0x1000         ; dirección destino en memoria

    int 0x13               ; llamada BIOS para leer disco

    jc disk_error          ; si falla, saltar a error

    ; Saltar al kernel cargado en 0x1000
    jmp 0x1000

disk_error:
    ; Mensaje de error simple
    mov si, error_msg
.print_char:
    lodsb
    cmp al, 0
    je .halt
    mov ah, 0x0E
    int 0x10
    jmp .print_char
.halt:
    hlt
    jmp .halt

; Variables y datos
boot_drive db 0
error_msg db 'Error al leer kernel',0

; Rellenar hasta 512 bytes y firma de arranque
times 510-($-$$) db 0
dw 0xAA55

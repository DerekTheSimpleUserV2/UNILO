; UNILO Bootloader - Menu Básico
; Ensamblador NASM, 512 bytes (MBR)

BITS 16
ORG 0x7C00

start:
    ; Limpiar pantalla
    mov ah, 0x00
    mov al, 0x03
    int 0x10

    ; Mostrar menú
    mov si, menu_text
    call print_string

wait_key:
    ; Esperar tecla
    mov ah, 0x00
    int 0x16
    cmp al, '1'
    je boot_linux
    cmp al, '2'
    je boot_bsd
    jmp wait_key

boot_linux:
    mov si, linux_text
    call print_string
    jmp $

boot_bsd:
    mov si, bsd_text
    call print_string
    jmp $

; Rutina para imprimir cadenas
print_string:
    mov ah, 0x0E
.next_char:
    lodsb
    cmp al, 0
    je .done
    int 0x10
    jmp .next_char
.done:
    ret

menu_text db "UNILO Bootloader",0x0D,0x0A
          db "1) Arrancar Linux",0x0D,0x0A
          db "2) Arrancar BSD",0x0D,0x0A,0
linux_text db "Cargando kernel Linux...",0
bsd_text   db "Cargando kernel BSD...",0

; Firma MBR
times 510-($-$$) db 0
dw 0xAA55

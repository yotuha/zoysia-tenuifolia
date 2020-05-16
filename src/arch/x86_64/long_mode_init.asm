global long_mode_start
extern kmain

section .boot
[bits 64]
long_mode_start:
    ; load 0 into all data segment registers
    mov ax, 0
    mov ss, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    ; print `OK` to screen
    mov dword [0xb8000], 0x2f4b2f4f
    call kmain
    hlt

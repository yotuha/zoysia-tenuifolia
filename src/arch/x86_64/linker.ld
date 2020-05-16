OUTPUT_FORMAT("elf64-x86-64");
ENTRY(start)

KERNEL_BOOT_ADDR   = 0x100000;
KERNEL_VIRT_ADDR = 0xffffffff80000000;


SECTIONS {
    . = KERNEL_BOOT_ADDR;

    .boot : AT(KERNEL_BOOT_ADDR)
    {
        /* ensure that the multiboot header is at the beginning */
        *(.multiboot_header)
        *(.boot)
    }

    . += KERNEL_VIRT_ADDR; /* KERNEL_BOOT_ADDR + KERNEL_VIRT_ADDR + boot code size */

    .text : AT(ADDR(.text) - KERNEL_VIRT_ADDR) ALIGN(8)
    {
        /* place your kernel code section */
        *(.text)
        *(.rodata)
    }

    .data : AT(ADDR(.data) - KERNEL_VIRT_ADDR) ALIGN(8)
    {
        /* place your kernel data section */
        *(.data)
    }

    .bss : AT(ADDR(.bss) - KERNEL_VIRT_ADDR) ALIGN(8)
    {
        /* place your kernel data section */
        *(.bss)
    }

    . = ALIGN(0x1000);
    KERNEL_VMA_END = .;
   /*KERNEL_LMA_END = KERNEL_LMA_START + . - KERNEL_VIRT_ADDR;*/
}

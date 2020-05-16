arch ?= x86_64
kernel := build/zoysia_kernel.bin
iso := build/zoysia_os.iso

CFLAGS		:= -ffreestanding -nostdinc -fno-pie
CFLAGS		+= -Wall -Wextra -Werror
CFLAGS		+= -Os -m64 -mcmodel=kernel
CFLAGS		+= -I./src/lib/include

linker_script := src/arch/$(arch)/linker.ld
grub_cfg := src/arch/$(arch)/grub.cfg
assembly_source_files := $(wildcard src/arch/$(arch)/*.asm)
assembly_object_files := $(patsubst src/arch/$(arch)/%.asm, \
	build/arch/$(arch)/%.o, $(assembly_source_files))
kernel_source_files := $(wildcard src/kernel/*.c)
kernel_object_files := $(patsubst src/kernel/%.c, \
	build/kernel/%.o, $(kernel_source_files))
kernel_include_files := $(wildcard src/lib/include/*.h)

.PHONY: all clean run iso

all: $(iso)

clean:
	@rm -r build

run: $(iso)
	@qemu-system-x86_64 -cdrom $(iso)

iso: $(iso)

$(iso): $(kernel) $(grub_cfg)
	@mkdir -p build/isofiles/boot/grub
	@cp $(kernel) build/isofiles/boot/kernel.bin
	@cp $(grub_cfg) build/isofiles/boot/grub
	@grub-mkrescue -o $(iso) build/isofiles 2> /dev/null
	@rm -r build/isofiles

$(kernel): $(assembly_object_files) $(linker_script) $(kernel_object_files)
	@ld -n -T $(linker_script) -o $(kernel) $(assembly_object_files) $(kernel_object_files)

# compile assembly files
build/arch/$(arch)/%.o: src/arch/$(arch)/%.asm
	@mkdir -p $(shell dirname $@)
	@nasm -felf64 $< -o $@

# compile kernel source code files
#build/kernel/kmain.o: src/kernel/kmain.c
#	@gcc ${CFLAGS} -c -o kmain.o kmain.c
build/kernel/%.o: src/kernel/%.c
	@mkdir -p $(shell dirname $@)
	@gcc ${CFLAGS} -c $< -o $@

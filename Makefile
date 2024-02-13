default: copy_kernel
	genisoimage -R -b boot/grub/stage2_eltorito -no-emul-boot -boot-load-size 4 -A os -input-charset utf8 -quiet -boot-info-table -o os.iso iso

loader: loader.s
	nasm -f elf32 loader.s

link: link.ld loader
	ld -T link.ld -melf_i386 loader.o -o kernel.elf

copy_kernel: link
	mv ./kernel.elf iso/boot

run: default
	qemu-system-x86_64 -boot d -cdrom os.iso -m 512
fasm ../src/boot.asm ../boot/boot.bin

pause

qemu-system-i386 -fda ../boot/boot.bin 
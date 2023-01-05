fasm ../src/boot.asm ../boot/boot.img

pause

qemu-system-i386 -fda ../boot/boot.img

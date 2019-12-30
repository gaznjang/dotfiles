#!/usr/bin/bash

qemu-system-x86_64 \
-M pc \
-m 16G \
-bios /usr/share/ovmf/OVMF.fd \
-nographic -serial "pty" \
-nic user,model=e1000,net=192.168.50.0/24 \
-device ipmi-bmc-sim,id=bmc0 \
-device isa-ipmi-kcs,bmc=bmc0,irq=5 \
-chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
-tpmdev emulator,id=tpm0,chardev=chrtpm \
-device tpm-tis,tpmdev=tpm0 \
-drive file=disk.img,if=virtio,format=raw

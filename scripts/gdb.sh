#!/usr/bin/env bash

HOST_PORT=${HOST_PORT:="$((3000 + RANDOM % 3000))"}

echo "**** Running QEMU SSH on port ${HOST_PORT} ****\n"

./riscv-qemu/riscv64-softmmu/qemu-system-riscv64 \
    -S -s \
    -D debug.log \
    -m 4G \
    -bios bootrom/bootrom.elf \
    -nographic \
    -machine virt \
    -kernel hifive-work/riscv-pk/bbl \
    -netdev user,id=net0,net=192.168.100.1/24,dhcpstart=192.168.100.128,hostfwd=tcp::${HOST_PORT}-:22 \
    -device virtio-net-device,netdev=net0
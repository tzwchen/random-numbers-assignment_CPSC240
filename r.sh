#!/bin/bash

# Clear out old files to ensure a fresh build
rm -f *.o
rm -f *.out

echo "Assembling x86 source files..."
nasm -f elf64 -o executive.o executive.asm
nasm -f elf64 -o fill.o fill_random_array.asm
nasm -f elf64 -o isnan.o isnan.asm
nasm -f elf64 -o normalize.o normalize_array.asm
nasm -f elf64 -o show.o show_array.asm

echo "Compiling C++ source files..."
g++ -c -m64 -Wall -o main.o main.cpp -fno-stack-protector
g++ -c -m64 -Wall -o sort.o sort.cpp -fno-stack-protector

echo "Linking all object files with noexecstack..."
# Added -z noexecstack to the linker flags
g++ -m64 -o program.out main.o executive.o fill.o isnan.o normalize.o show.o sort.o \
    -fno-stack-protector -no-pie -z noexecstack

echo "Build complete. Running Program:"
./program.out
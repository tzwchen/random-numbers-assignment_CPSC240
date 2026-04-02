#!/bin/bash
rm *.o
rm *.out

echo "Assemble the source files"
nasm -f elf64 -o executive.o executive.asm
nasm -f elf64 -o fill.o fill_random_array.asm
nasm -f elf64 -o isnan.o isnan.asm
nasm -f elf64 -o normalize.o normalize_array.asm
nasm -f elf64 -o show.o show_array.asm

echo "Compile the C++ source files"
g++ -c -m64 -Wall -o main.o main.cpp -fno-stack-protector
g++ -c -m64 -Wall -o sort.o sort.cpp -fno-stack-protector

echo "Link the object files"
g++ -m64 -o program.out main.o executive.o fill.o isnan.o normalize.o show.o sort.o -fno-stack-protector -no-pie

echo "Run the program"
./program.out
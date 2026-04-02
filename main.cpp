/****************************************************************************************************************************
* Program name: "Random Numbers"
* Purpose: This program generates, normalizes, and sorts 64-bit IEEE float numbers.
* Copyright (C) 2026 Tristan Chen
* * This file is part of the software program "Random Numbers".
* "Random Numbers" is free software: you can redistribute it and/or modify it under the terms of the GNU General
* Public License version 3 as published by the Free Software Foundation.
* * Author information
* Author name: Tristan Chen
* Author email: tchen2006@csu.fullerton.edu
*
* Program information
* Programming languages: Main and Sort in C++, assembly modules in x86 Intel syntax.
* Date of last update: 2026-Apr-2
* Files in this program: main.cpp, executive.asm, fill_random_array.asm, isnan.asm, 
* normalize_array.asm, show_array.asm, sort.cpp, r.sh
*************************************************************************************************************************/

// Purpose: The entry point of the program. Handles the "Welcome" and "Goodbye" green text.

#include <iostream>
#include <iomanip>

extern "C" long executive();

int main() {
    std::cout << "Welcome to Random Products, LLC." << std::endl;
    std::cout << "This software is maintained by Alfred Finkelstein" << std::endl << std::endl;

    long result = executive();

    std::cout << "Oh, Sam Freidrickson. We hope you enjoyed your arrays. Do come again." << std::endl;
    std::cout << "A zero will be returned to the operating system." << std::endl;

    return result;
}
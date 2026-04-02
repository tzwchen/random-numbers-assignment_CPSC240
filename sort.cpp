/****************************************************************************************************************************
* Program name: "Random Numbers"
* Purpose: This module implements a QuickSort algorithm to sort the normalized array.
* Copyright (C) 2026 Tristan Chen
* * Author information
* Author name: Tristan Chen
* Author email: tchen2006@csu.fullerton.edu
*
* File information
* File name: sort.cpp
* Language: C++ (compiled with -m64)
* Compile: g++ -c -m64 -o sort.o sort.cpp
*************************************************************************************************************************/

// Purpose: Provides the partitioning and recursive quicksort logic for the 64-bit array.


#include <iostream>
#include <cmath>

// Using a standard swap function
void swap(double* a, double* b) {
    double temp = *a;
    *a = *b;
    *b = temp;
}

// Partition using the last element as pivot
int partition(double arr[], int low, int high) {
    double pivot = arr[high];

    // check if the pivot itself is a nan
    if (std::isnan(pivot)) {
        return high; 
    }

    int i = (low - 1);
    for (int j = low; j < high; j++) {
        // check if the current element is a NaN
        if (std::isnan(arr[j])) {
            continue; 
        }

        if (arr[j] < pivot) {
            i++;
            std::swap(arr[i], arr[j]);
        }
    }
    std::swap(arr[i + 1], arr[high]);
    return (i + 1);
}

// The main sorting function
extern "C" void quickSort(double arr[], int low, int high) {
    if (low < high) {
        int pi = partition(arr, low, high);
        quickSort(arr, low, pi - 1);
        quickSort(arr, pi + 1, high);
    }
}
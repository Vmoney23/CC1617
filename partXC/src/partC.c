/*
 * partC.c
 *
 *  Created on: 30 Sep 2016
 *      Author: vd15808
 */
#include <stdio.h>
#include <platform.h>

extern void delay(uint delay, int tile);

void hello(int tileNo) {
    delay(1000, tileNo);
    printf("Hello from tile %d\n", tileNo);
}

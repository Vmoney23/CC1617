/*
 * partXC.xc
 *
 *  Created on: 30 Sep 2016
 *      Author: vd15808
 */
#include <platform.h>
#include <stdio.h>

extern void hello(int tileNo);

int main(void) {
    par {
        on tile[0] : hello(0);
        on tile[1] : hello(1);
    }
    return 0;
}

void delay(uint delay, int tile) {
    uint time, tmp;
    timer t;
    t :> time;
    printf("time tile%d: %d\n", tile, time);
    t when timerafter (time + delay) :> tmp;
    printf("timeafter tile%d: %d\n", tile, tmp);
}

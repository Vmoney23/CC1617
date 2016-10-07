/*
 * queen.xc
 *
 *  Created on: 7 Oct 2016
 *      Author: vd15808
 */

#include <stdio.h>
#include <platform.h>

void queen ( const unsigned char w[3][4],
             chanend cAnt0,
             chanend cAnt1
           ) {

    unsigned int report0 = 0;
    unsigned int report1 = 0;
    unsigned int harvest = 0;

    printf("The Queen has risen..\n");

    for (int k=0; k<5; k++) {
        printf("Current harvest: %d\n", harvest);
        cAnt0 :> report0;
        cAnt1 :> report1;

        if (report0 > report1) {
            cAnt0 <: 1;
            cAnt1 <: 0;
            harvest += report0;
            printf("Ant0 is bae, got %d food.\n", report0);
        } else {
            cAnt1 <: 1;
            cAnt0 <: 0;
            harvest += report1;
            printf("Ant1 is bae, got %d food.\n", report1);
        }
    }
    printf("Got mad food bitches: %d\n", harvest);
}

void ant ( unsigned int id, //the ant identifier
                    const unsigned char w[3][4], //the constant world array
                    unsigned int x, //the starting position x
                    unsigned int y, //the starting position y
                    chanend cQueen //channel to queen
                  ) {

    unsigned int food = 0; // init food
    unsigned int command = 0; // init command

    printf("Ant%d starting at (%d,%d)!\n", id, x, y); // start statement

    for (int k=0; k<5; k++) {
        food = w[x][y];
        cQueen <: food;
        cQueen :> command;
        switch (command) {
            case 0 :
                for (int i=0; i<2; i++) {
                    if (w[(x+1)%3][y] >= w[x][(y+1)%4]) // check whether east or south is more fertile. if same move east
                        x = (x+1)%3; // move east
                    else
                        y = (y+1)%4; // move south
                }
                break;
            case 1 :
                printf("Eating, lol\n");
                break;
            default :
                break;
        }
    }
}

int main (void) {
    const unsigned char world[3][4] = {{10,0,1,7},{2,10,0,3},{6,8,7,6}}; //the world
    chan antChannel[2];

    par {
        ant(0, world, 0, 1, antChannel[0]);
        ant(1, world, 1, 0, antChannel[1]);
        queen(world, antChannel[0], antChannel[1]);
    }

    printf("Done..\n");
    return 0;
}

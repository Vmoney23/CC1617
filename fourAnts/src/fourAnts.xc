/*
 * fourAnts.xc
 *
 *  Created on: 30 Sep 2016
 *      Author: vd15808
 */
#include <stdio.h>
{int,int,int} ant ( unsigned int id, //the ant identifier
                    const unsigned char w[3][4], //the constant world array
                    unsigned int x, //the starting position x
                    unsigned int y //the starting position y
                  ) {

    unsigned int food = 0; // init food

    printf("Ant %d starting!, id\n"); // start statement

    for (int i=0; i<2; i++) {
        if (w[(x+1)%3][y] >= w[x][(y+1)%4]) // check whether east or south is more fertile. if same move east
            x = (x+1)%3; // move east
        else
            y = (y+1)%4; // move south
        food += w[x][y]; // eat food
        printf("Ant %d is at (%d,%d), and has food: %d!\n", id, x, y, food); // ant status update
    }
    printf("Ant %d finished at (%d,%d), and has collected %d pieces of food\n", id, x, y, food); // end statement

    return {food, x, y};
}

int main (void) {
    const unsigned char world[3][4] = {{10,0,1,7},{2,10,0,3},{6,8,7,6}}; //the world
    unsigned int food[4]; //food reported as harvested per ant
    unsigned int x[4], y[4]; //end positions reported per ant
    unsigned int allFood = 0; //final overall food count
    unsigned int sumX = 0;
    unsigned int sumY = 0;

    par {
        {food[0], x[0], y[0]} = ant(0, world, 0, 1);
        {food[1], x[1], y[1]} = ant(1, world, 1, 2);
        {food[2], x[2], y[2]} = ant(2, world, 0, 2);
        {food[3], x[3], y[3]} = ant(3, world, 1, 0);
    }

    for(int i=0; i<4; i++) {
        allFood += food[i];
        sumX += x[i];
        sumY += y[i];
    }

    printf("Food: %d avg-X: %d/10 avg-Y: %d/10\n", allFood, 10*sumX/4, 10*sumY/4);

    return 0;
}

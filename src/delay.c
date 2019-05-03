#include "delay.h"

void delayms(unsigned int ms)
{
        unsigned int x, y;
 
        for (y = ms; y > 0; y--) {
                for (x = 227; x > 0; x--);
        }
}

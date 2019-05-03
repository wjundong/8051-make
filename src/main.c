#include <at89x52.h>
#include "delay.h"
#include "foo.h"

#define led1 P2_0

void main(void)
{
	int a = 5,b = 6;

	temp(&a,&b);

        while (1) 
	{
                led1 = 0;
                delayms(1000);
                led1 = 1;
                delayms(1000);
        }
}

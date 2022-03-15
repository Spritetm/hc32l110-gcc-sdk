/*
   Blinkie example for HC32L110

   This code is in the Public Domain (or CC0 licensed, at your option.)

   Unless required by applicable law or agreed to in writing, this
   software is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
   CONDITIONS OF ANY KIND, either express or implied.
*/

#include "gpio.h"

int main(void) {
	Gpio_InitIOExt(0, 1, GpioDirOut, TRUE, FALSE, FALSE, FALSE);
	Gpio_InitIOExt(0, 2, GpioDirOut, TRUE, FALSE, FALSE, FALSE);
	Gpio_InitIOExt(2, 6, GpioDirOut, TRUE, FALSE, FALSE, FALSE);
	Gpio_InitIOExt(3, 6, GpioDirOut, TRUE, FALSE, FALSE, FALSE);
	Gpio_InitIOExt(3, 5, GpioDirOut, TRUE, FALSE, FALSE, FALSE);
	Gpio_InitIOExt(2, 5, GpioDirOut, TRUE, FALSE, FALSE, FALSE);
	Gpio_InitIOExt(2, 4, GpioDirOut, TRUE, FALSE, FALSE, FALSE);
	Gpio_InitIOExt(1, 4, GpioDirOut, TRUE, FALSE, FALSE, FALSE);
	Gpio_InitIOExt(1, 5, GpioDirOut, TRUE, FALSE, FALSE, FALSE);
	Gpio_InitIOExt(2, 3, GpioDirOut, TRUE, FALSE, FALSE, FALSE);
	int t=0;
	while (1) {
		t++;
		if (t==10) t=0;
		Gpio_SetIO(0, 1, t==0);
		Gpio_SetIO(0, 2, t==1);
		Gpio_SetIO(2, 6, t==2);
		Gpio_SetIO(3, 6, t==3);
		Gpio_SetIO(3, 5, t==4);
		Gpio_SetIO(2, 5, t==5);
		Gpio_SetIO(2, 4, t==6);
		Gpio_SetIO(1, 4, t==7);
		Gpio_SetIO(1, 5, t==8);
		Gpio_SetIO(2, 3, t==9);
		delay1ms(50);
	}
}


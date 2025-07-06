#include "led_control.h"

void Led_Init(void)
{
	Vfb_Call_GPIO_EnableClock(GPIOA);
	Vfb_Call_GPIO_SetPinAsOutput(PIN_8);
}

void Led_On(void)
{

}

void Led_Off()
{

}

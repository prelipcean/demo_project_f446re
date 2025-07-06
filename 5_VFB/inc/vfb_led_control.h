#ifndef VFB_LED_CONTROL_H_
#define VFB_LED_CONTROL_H_

#include "vfb.h"

#define Vfb_Call_GPIO_EnableClock HAL_GPIO_EnableClock

HAL_GPIO_EnableClock(port)

HAL_GPIO_SetMode(port, mode, pin)
HAL_GPIO_SetOutputType(port, type, pin)
HAL_GPIO_SetOutputSpeed(port, speed, pin)
HAL_GPIO_SetPUPD(port, pupd, pin)
HAL_GPIO_SetOutputData(port, data, pin)
HAL_GPIO_SetBitSetReset(port, action, bit)
HAL_GPIO_SetPortLock(port, lock, bit)
HAL_GPIO_SetAlternateFunction(port, function, pin)

HAL_GPIO_ReadMode(port, pin)
HAL_GPIO_ReadOutputType(port, pin)
HAL_GPIO_ReadOutputSpeed(port, pin)
HAL_GPIO_ReadPUPD(port, pin)
HAL_GPIO_ReadInputData(port, pin)
HAL_GPIO_ReadOutputData(port, pin)
HAL_GPIO_ReadPortLock(port, bit)
HAL_GPIO_ReadAlternateFunction(port, pin)

#endif /* VFB_LED_CONTROL_H_ */

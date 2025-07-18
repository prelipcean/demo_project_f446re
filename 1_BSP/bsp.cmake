# bsp.cmake
list(APPEND BSP_SRC
	${CMAKE_CURRENT_SOURCE_DIR}/1_BSP/STM32_F446XX/src/syscalls.c
	${CMAKE_CURRENT_SOURCE_DIR}/1_BSP/STM32_F446XX/src/sysmem.c
)

list(APPEND BSP_INC
	${CMAKE_CURRENT_SOURCE_DIR}/1_BSP/STM32_F446XX/inc
	${CMAKE_CURRENT_SOURCE_DIR}/1_BSP/STM32_F446XX/inc/CMSIS
	${CMAKE_CURRENT_SOURCE_DIR}/1_BSP/Utils/inc
)

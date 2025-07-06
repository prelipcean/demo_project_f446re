# app.cmake

list(APPEND APP_SRC
	${CMAKE_CURRENT_SOURCE_DIR}/6_Application/LedControl/src/led_control.c
)

list(APPEND APP_INC
	${CMAKE_CURRENT_SOURCE_DIR}/6_Application/LedControl/inc
)

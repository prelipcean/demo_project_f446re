# services.cmake

list(APPEND SERVICES_SRC
	${CMAKE_CURRENT_SOURCE_DIR}/3_Services/BoardStart/src/boardstart.c
)

list(APPEND SERVICES_INC
	${CMAKE_CURRENT_SOURCE_DIR}/3_Services/BoardStart/inc
)

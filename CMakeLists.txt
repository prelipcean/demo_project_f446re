# Minimum required version of CMake
cmake_minimum_required(VERSION 3.14.0)

# CMAKE_SYSTEM_NAME - on unix this is uname -s, for windows it is Windows
# CMAKE_SYSTEM_VERSION - on unix this is uname -r, for windows it is empty
# CMAKE_SYSTEM - ${CMAKE_SYSTEM}-${CMAKE_SYSTEM_VERSION}, for windows: ${CMAKE_SYSTEM}
#
# Expected uname -s output:
# AIX                           AIX
# BSD/OS                        BSD/OS
# FreeBSD                       FreeBSD
# HP-UX                         HP-UX
# Linux                         Linux
# GNU/kFreeBSD                  GNU/kFreeBSD
# NetBSD                        NetBSD
# OpenBSD                       OpenBSD
# OFS/1 (Digital Unix)          OSF1
# SCO OpenServer 5              SCO_SV
# SCO UnixWare 7                UnixWare
# SCO UnixWare (pre release 7)  UNIX_SV
# SCO XENIX                     Xenix
# Solaris                       SunOS
# SunOS                         SunOS
# Tru64                         Tru64
# Ultrix                        ULTRIX
# cygwin                        CYGWIN_NT-5.1
# MSYS                          MSYS_NT-6.1
# MacOSX                        Darwin

# For platforms without OS, typically embedded platforms, we set
# CMAKE_SYSTEM_NAME to "Generic"
set(CMAKE_SYSTEM_NAME Generic)

set(CMAKE_SYSTEM_VERSION 1) # Optional

# amd64
# armv8l
# armv5te
# armv7-a
# armv6l
# arm64
# aarch64
# i686
# riscv64
# x86
# x86_64
# s390x
# ppc64le
# mips
# mips64
set(CMAKE_SYSTEM_PROCESSOR arm)
#set(CMAKE_SYSTEM_PROCESSOR armv7e-m)

# STM32 F446RE has a single core: Arm 32bit Cortex-M4 CPU with FPU
# Arm architecture is armv7e-m
# Computer architecture is Harvard
# Instruction pipeline: 3 stages
# Interrupt latency: 12 cycles
# Thumb-1 and Thumb-2 entire instructions supported 

# Set toolchain path
if (UNIX)
  message(STATUS "Unix system")
  set(ARM_TOOLCHAIN_BIN_DIR /opt/gcc-arm-11/bin)
  set(TOOLCHAIN_PREFIX arm-none-eabi-)
  set(EXT "")
else()
  message(STATUS "We suppose that is Windows system")
  set(ARM_TOOLCHAIN_BIN_DIR "c:/Program Files (x86)/GNU Tools Arm Embedded/9 2019-q4-major/bin")
  set(TOOLCHAIN_PREFIX arm-none-eabi-)
  set(EXT ".exe")
endif()

set(FLAGS
    "-fdata-sections -ffunction-sections -fstack-usage \
    --specs=nano.specs -Wl,--gc-sections")

set(CPP_FLAGS
    "-fdata-sections -ffunction-sections -fstack-usage \
    --specs=nano.specs -Wl,--gc-sections \
    -fno-rtti -fno-exceptions \
    -fno-threadsafe-statics")

set(CMAKE_C_COMPILER ${ARM_TOOLCHAIN_BIN_DIR}/${TOOLCHAIN_PREFIX}gcc${EXT} ${FLAGS})
set(CMAKE_CXX_COMPILER ${ARM_TOOLCHAIN_BIN_DIR}/${TOOLCHAIN_PREFIX}g++${EXT} ${CPP_FLAGS})
set(CMAKE_ASM_COMPILER ${ARM_TOOLCHAIN_BIN_DIR}/${TOOLCHAIN_PREFIX}gcc${EXT})
set(CMAKE_AR ${ARM_TOOLCHAIN_BIN_DIR}/${TOOLCHAIN_PREFIX}ar${EXT})
set(CMAKE_OBJCOPY ${ARM_TOOLCHAIN_BIN_DIR}/${TOOLCHAIN_PREFIX}objcopy${EXT} CACHE INTERNAL "objcopy tool")
set(CMAKE_OBJDUMP ${ARM_TOOLCHAIN_BIN_DIR}/${TOOLCHAIN_PREFIX}objdump${EXT} CACHE INTERNAL "objdump tool")
set(CMAKE_SIZE ${ARM_TOOLCHAIN_BIN_DIR}/${TOOLCHAIN_PREFIX}size${EXT} CACHE INTERNAL "size tool")

# message(STATUS "CMAKE_C_COMPILER: ${CMAKE_C_COMPILER}")
# message(STATUS "CMAKE_CXX_COMPILER: ${CMAKE_CXX_COMPILER}")
# message(STATUS "CMAKE_ASM_COMPILER: ${CMAKE_ASM_COMPILER}")
# message(STATUS "CMAKE_AR: ${CMAKE_AR}")
# message(STATUS "CMAKE_OBJCOPY: ${CMAKE_OBJCOPY}")
# message(STATUS "CMAKE_OBJDUMP: ${CMAKE_OBJDUMP}")
# message(STATUS "CMAKE_SIZE: ${CMAKE_SIZE}")

set(CMAKE_EXECUTABLE_SUFFIX_ASM ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_C ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_CXX ".elf")

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# Project settings
# Project name will also be set to CMake environment variable PROJECT_NAME
project(DemoProject VERSION 1.0.0 DESCRIPTION "DemoProject for test purposes" LANGUAGES C CXX ASM)

# Set EXECUTABLE name as the name of the project
set(EXECUTABLE ${CMAKE_PROJECT_NAME})

# Options for the project
# option(OPTIONNAME "Description" ON/OFF)
option(PRINT_SIZE_LISTS "Print the sizes of lists containing source and header files" ON)

# Common compile settings
# Language standard
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)

set(MCU_FAMILY STM32F4xx)
set(MCU_MODEL STM32F446xx)
set(CPU_PARAMETERS
    -mcpu=cortex-m4
    -mthumb
    -mfpu=fpv4-sp-d16
    -mfloat-abi=hard)


message("CMAKE_PROJECT_NAME: ${CMAKE_PROJECT_NAME}")
message("CMAKE_CURRENT_SOURCE_DIR: ${CMAKE_CURRENT_SOURCE_DIR}")


# Create lists for header files and source files
set(BSP_SRC)
set(BSP_INC)
set(HAL_SRC)
set(HAL_INC)
set(SERVICES_SRC)
set(SERVICES_INC)
set(OS_SRC)
set(OS_INC)
set(VFB_SRC)
set(VFB_INC)
set(APP_SRC)
set(APP_INC)


# Append to lists from other cmake files e.g. list(APPEND NAMEOFLIST files/paths to append)
include(${CMAKE_CURRENT_SOURCE_DIR}/1_BSP/bsp.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/2_HAL/hal.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/3_Services/services.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/4_OS/os.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/5_VFB/vfb.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/6_Application/app.cmake)


# Verify sizes of lists
# list(LENGTH NAMEOFLIST NAMEOFVARIABLETOHOLDLISTLENGTH)
# message(STATUS "List lengts ... ${NAMEOFVARIABLETOHOLDLISTLENGTH}")
if(PRINT_SIZE_LISTS)
	list(LENGTH BSP_SRC BSP_SRC_LEN)
	message(STATUS "List BSP_SRC legth is: ${BSP_SRC_LEN}")
	list(LENGTH BSP_INC BSP_INC_LEN)
	message(STATUS "List BSP_INC legth is: ${BSP_INC_LEN}")
	list(LENGTH HAL_SRC HAL_SRC_LEN)
	message(STATUS "List HAL_SRC legth is: ${HAL_SRC_LEN}")
	list(LENGTH HAL_INC HAL_INC_LEN)
	message(STATUS "List HAL_INC legth is: ${HAL_INC_LEN}")
	list(LENGTH SERVICES_SRC SERVICES_SRC_LEN)
	message(STATUS "List SERVICES_SRC legth is: ${SERVICES_SRC_LEN}")
	list(LENGTH SERVICES_INC SERVICES_INC_LEN)
	message(STATUS "List SERVICES_INC legth is: ${SERVICES_INC_LEN}")
	list(LENGTH OS_SRC OS_SRC_LEN)
	message(STATUS "List OS_SRC legth is: ${OS_SRC_LEN}")
	list(LENGTH OS_INC OS_INC_LEN)
	message(STATUS "List OS_INC legth is: ${OS_INC_LEN}")
	list(LENGTH VFB_SRC VFB_SRC_LEN)
	message(STATUS "List VFB_SRC legth is: ${VFB_SRC_LEN}")
	list(LENGTH VFB_INC VFB_INC_LEN)
	message(STATUS "List VFB_INC legth is: ${VFB_INC_LEN}")
	list(LENGTH APP_SRC APP_SRC_LEN)
	message(STATUS "List APP_SRC legth is: ${APP_SRC_LEN}")
	list(LENGTH APP_INC APP_INC_LEN)
	message(STATUS "List APP_INC legth is: ${APP_INC_LEN}")
endif()

set(STARTUP_SCRIPT ${CMAKE_CURRENT_SOURCE_DIR}/1_BSP/Startup/startup_stm32f446retx.s)

set(MCU_FLASH_LINKER_SCRIPT ${CMAKE_CURRENT_SOURCE_DIR}/0_Linker/STM32F446RETx_FLASH.ld)
set(MCU_RAM_LINKER_SCRIPT ${CMAKE_CURRENT_SOURCE_DIR}/0_Linker/STM32F446RETX_RAM.ld)

# Executable files
add_executable(${EXECUTABLE}
    ${BSP_SRC}
    ${HAL_SRC}
	${SERVICES_SRC}
	${OS_SRC}
	${VFB_SRC}
	${APP_SRC}
    ${STARTUP_SCRIPT}
)

# Add preprocessor definitions to the compiler command line
target_compile_definitions(${EXECUTABLE} PRIVATE
    ${MCU_MODEL}
	__SOFT_FP__
    #USE_HAL_DRIVER
)

# Add header directories include paths (AFTER add_executable !!)
target_include_directories(${EXECUTABLE} PRIVATE
    ${BSP_INC}
    ${HAL_INC}
	${SERVICES_INC}
	${OS_INC}
	${VFB_INC}
	${APP_INC}
)

# Compiler and linker options
target_compile_options(${EXECUTABLE} PRIVATE
    ${CPU_PARAMETERS}
    -Wall
    -Wextra
    -Wpedantic
    -Wno-unused-parameter
    $<$<COMPILE_LANGUAGE:CXX>:
        -Wno-volatile
        -Wold-style-cast
        -Wuseless-cast
        -Wsuggest-override>
    $<$<CONFIG:Debug>:-Og -g3 -ggdb>
    $<$<CONFIG:Release>:-Og -g0>)

target_link_options(${EXECUTABLE} PRIVATE
    #"SHELL:-T ${MCU_FLASH_LINKER_SCRIPT}"
	#"SHELL:-T ${MCU_RAM_LINKER_SCRIPT}"
	#-T ${MCU_FLASH_LINKER_SCRIPT} ${MCU_RAM_LINKER_SCRIPT}
	-T ${MCU_FLASH_LINKER_SCRIPT}
    ${CPU_PARAMETERS}
    -Wl,-Map=${CMAKE_PROJECT_NAME}.map
    --specs=nosys.specs
	#$<$<CONFIG:DEBUG>:--specs=rdimon.specs>
    #$<$<CONFIG:RELEASE>:--specs=nosys.specs>
    -Wl,--start-group
    -lc
    -lm
    -lstdc++
    -Wl,--end-group
    -Wl,--print-memory-usage)

add_custom_command(TARGET ${EXECUTABLE} POST_BUILD
    COMMAND ${CMAKE_SIZE} $<TARGET_FILE:${EXECUTABLE}>)

add_custom_command(TARGET ${EXECUTABLE} POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O ihex $<TARGET_FILE:${EXECUTABLE}>
    ${EXECUTABLE}.hex
    COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${EXECUTABLE}>
    ${EXECUTABLE}.bin)


# Add Doxygen build for documentation
# ToDo

# Add Unit Test build for unit testing (GTest + Coverage)
# ToDo

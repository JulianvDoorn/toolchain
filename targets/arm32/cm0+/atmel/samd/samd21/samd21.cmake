enable_language(ASM)
enable_language(C)

SET(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS)

link_directories(
    ${toolchain}/targets/arm32/cm0+/atmel/samd/samd21/deps
)

include_directories(
    ${toolchain}/targets/arm32/cm0+/deps
    ${toolchain}/targets/arm32/cm0+/atmel/samd/deps
    ${toolchain}/targets/arm32/cm0+/atmel/samd/samd21/deps
)
    

add_definitions(
    -DNDEBUG
    -D__SAMD21G18A__
    -D__ATSAMD21G18A__
    # TODO: Add definitions
)

set(compile_flags "-Os -mcpu=cortex-m0plus  -mthumb  -MMD  -MP  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mapcs  ${compile_flags}")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${compile_flags} -fno-exceptions -fno-rtti")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${compile_flags}")

set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} --specs=nano.specs  -lm  -Wall  -fno-common  -ffunction-sections  -fdata-sections  -ffreestanding  -fno-builtin  -mthumb  -mapcs  -Xlinker --gc-sections  -Xlinker -static  -Xlinker -z  -Xlinker muldefs  -Xlinker --defsym=__stack_size__=0x300  -Xlinker -Tsamd21e18a_flash.ld")

add_executable(${PROJECT_NAME}.elf
        ${toolchain}/targets/arm32/cm0+/atmel/samd/samd21/deps/startup_samd21.c
        ${toolchain}/targets/arm32/cm0+/atmel/samd/samd21/deps/system_samd21.c
        ${sources}
)

add_custom_target(${PROJECT_NAME}.hex DEPENDS ${PROJECT_NAME}.elf COMMAND ${OBJCOPY} -Oihex ${PROJECT_NAME}.elf ${PROJECT_NAME}.hex)
add_custom_target(${PROJECT_NAME}.bin DEPENDS ${PROJECT_NAME}.elf COMMAND ${OBJCOPY} -Obinary ${PROJECT_NAME}.elf ${PROJECT_NAME}.bin)

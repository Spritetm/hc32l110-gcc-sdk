/* This linker script is public domain. */

ENTRY(Reset_Handler)

/* Memory configuration for HC32L110 */

MEMORY
{
    flash   :   ORIGIN = 0x00000000, LENGTH = 32k
    sram    :   ORIGIN = 0x20000000, LENGTH = 4k
}

_end_stack = 0x20000FFC;

SECTIONS {
    . = ORIGIN(flash);

    vectors :
    {
        *(.vectors)
    } >flash

    .text :
    {
        *(.text)
        *(.rodata)
        *(.rodata*)
        _end_text = .;
    } >flash

    .data :
    {
        _start_data = .;
        *(.data)
        _end_data = .;
    } >sram AT >flash
    _start_data_flash = LOADADDR(.data);

    . = ALIGN(4);

    .bss :
    {
        _start_bss = .;
        *(.bss)
        _end_bss = .;
    } >sram

    . = ALIGN(4);

    _start_stack = .;
}

_end = .;
PROVIDE(end = .);

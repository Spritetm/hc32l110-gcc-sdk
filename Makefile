PROJECT=blink
PROJECT_SRCS=startup.c main.c
LINKER_SCRIPT=hc32l110.ld

#Change this if you have an updated version of the DDL SDK.
SDK_DIR=HC32L110_DDL_Rev1.1.4/

SDK_SRCS=mcu/common/system_hc32l110.c
#If you use other drivers from DDL, add them here.
SDK_SRCS+=driver/src/adc.c driver/src/gpio.c driver/src/interrupts_hc32l110.c
SDK_SRCS+=driver/src/clk.c driver/src/ddl.c
SDK_INCLUDEDIRS=mcu/common/ driver/inc

SRCS = $(addprefix $(SDK_DIR),$(SDK_SRCS)) $(PROJECT_SRCS)
OBJS = $(patsubst %.c,build/%.o,$(SRCS))

DEPFLAGS = -MT $@ -MMD -MP -MF build/$*.d

CFLAGS=-fno-common -mcpu=cortex-m0plus -mthumb
CFLAGS+=-Wall -ggdb -Og
CFLAGS+=-I- -Iddl_workarounds -I. $(addprefix -I $(SDK_DIR),$(SDK_INCLUDEDIRS))
LDFLAGS=-lgcc -ggdb -mcpu=cortex-m0plus -mthumb -nostartfiles -Wl,-Map=$(PROJECT).map -T$(LINKER_SCRIPT) -nostdlib
ASFLAGS=-ahls -mcpu=cortex-m0plus -mthumb

CROSS = arm-none-eabi-
CC = $(CROSS)gcc
AS = $(CROSS)as
LD = $(CROSS)ld
OBJDUMP = $(CROSS)objdump
OBJCOPY = $(CROSS)objcopy
SIZE = $(CROSS)size

$(PROJECT).elf: $(OBJS) $(LINKER_SCRIPT)
	$(CC) $(OBJS) $(LDFLAGS) -o $(PROJECT).elf

.PHONY: clean
clean:
	rm -rf build $(PROJECT).elf $(PROJECT).bin $(PROJECT).map


gdb: $(PROJECT).elf
	gdb-multiarch blink.elf -ex "target remote localhost:3333" -ex "mon reset halt" -ex "mon flash erase_address 0 0x8000" -ex "load $(PROJECT).elf"

#Not needed during normal flow, but can be handy
$(PROJECT).bin: $(PROJECT).elf
	arm-none-eabi-objcopy -I elf32-littlearm -O binary $(PROJECT).elf $(PROJECT).bin $(PROJECT).map


#Dependency generation stuff
build/%.o : %.c build/%.d | build
	@mkdir -p $(@D)
	$(CC) $(DEPFLAGS) $(CFLAGS) $(CPPFLAGS) -o $@ -c $<

build: ; @mkdir -p build

DEPFILES := $(SRCS:%.c=build/%.d)
$(DEPFILES):

include $(wildcard $(DEPFILES))

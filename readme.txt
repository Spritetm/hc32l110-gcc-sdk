This is a quick and dirty way to get the HC32L110 SDK working with 
GCC/GDB/OpenOCD. It's distributed as a project that flashes a bunch 
of LEDs connected to all of the GPIOs. You should be able to simply
modify the source code and Makefile in order to compile your own
code.

For convenience, the translated_docs directory contains machine-translated
versions of the current datasheets, user manual and other docs at the time
of creation of this SDK. (For what it's worth, the documents were translated
using DeepL.)

=== Requirements ===

This stuff assumes you have some board with an HC32L110 chip on it, plus
a SWD adapter that is supported by OpenOCD connected to it.

It also assumes an Unix'y system with all the 'standard' dev stuff
like GNU Make etc installed. It's developed under Debian; Ubuntu installs
should likely work the same, but for other distributions and things like
WSL and OSX you may need to adjust some things.

=== Installation instructions ===

Grab an arm gcc embedded crosscompilation toolchain. Easiest way if
you're running Debian or Ubuntu is to apt-get install gcc-arm-none-eabi.
Also grab gdb-multiarch: apt-get install gdb-multiarch.

Grab the SDK (DDL) from the manufacturers site: 
https://www.hdsc.com.cn/cn/Index/downloadFile/modelid/66/id/25/key/0
or if that doesn't work:
https://www.hdsc.com.cn/Category82-1391 --> 开发工具 --> HC32L110_DDL_Rev*.zip
Extract the zip in this directory. If the resulting directory is 
not called HC32L110_DDL_Rev1.1.4, you need to adjust the Makefile 
accordingly.

You will need an openocd which supports the HC32L110 flash in 
order to program the chip. As this is not mainstream yet, one is 
included as a submodule. To compile it, make sure you have its 
requirements (hint: apt-get build-dep openocd)
and compile as such:
git submodule init
git submodule update
cd openocd-hc32l110
./bootstrap.sh && ./configure && make

=== Compiling & flashing ===

To compile the blink program, simply run 'make'.

To flash the program, you need to have OpenOCD running. An 
example of how to run it is included in the file 'openocd.sh', 
but you may need to adjust it to suit whichever SWD adapter 
you have. Note that you probably want to run OpenOCD in a 
separate terminal as it needs to run during the entire flash/debug 
session.

GDB is used to flash the program. Simply run `make gdb` and the 
flash is erased and the program is flashed. Press 'c' and enter 
to run it. Gdb allows for debugging as well, e.g. press Ctrl-C 
to interrupt the program and inspect its state.

=== Known Issues ===

During compilation, gcc will complain about an 'obsolete' -I- 
command line flag. This is a known issue. I need the flag in 
order to override a header that is included by a C file in 
the same directory as that header, and I don't think there is 
another way but that obsolete command to do so. (Note that the 
suggested -iquote alternative does not work for this purpose.)

More generally: This entire thing is a somewhat hacky set of 
files cobbled together simply to prove I could solder the WSCP 
that the HC28L110 is packaged in and still have it work. Don't 
expect too much from it, and especially don't expect any support.

=== Credits ===

The ld and startup.c files are are modified versions of the
ones from  https://sergeev.io/notes/cortex_cmsis/
License on those, according to the readme there:
'Makefile, linker script, and all code in the root directory are 
100% public domain.'


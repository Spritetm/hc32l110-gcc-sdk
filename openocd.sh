
#This starts up OpenOCD with a tumpa in swd-mode to connect to the HC32L110.
#Modify to your board if needed.

./openocd/src/openocd  -s ${PWD}/openocd/tcl -f interface/ftdi/tumpa.cfg -f interface/ftdi/swd-resistor-hack.cfg  -f target/hc32l110.cfg

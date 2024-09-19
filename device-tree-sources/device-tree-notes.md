# Notes

The device tree source in this folder is based off the raspberry pi 4 
device tree source from Linux after running it through the cpp
preprocessor.  Changes to add the interrupt number to the Aux uart
were added.

This is the compiled with the dtc compiler to produce the rpi4.dtb
in the skeleton root directory.

To make dtb from the original u-boot/linux device tree sources,
go the the dts directory in the respective repository and run:

```
  $ cpp -nostdinc -I include -I arch -I../../../../include  -undef -x \
      assembler-with-cpp bcm2711-rpi-4-b.dts bcm2711-rpi-4-b.prep.dts
  $ dtc -q -O dtb -o rpi4.dtb bcm2711-rpi-4-b.prep.dts
```

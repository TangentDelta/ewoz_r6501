SHELL		:= /bin/bash

AFLAGS		= -t none
LFLAGS		= -t none -m ewoz.map -l ewoz.lst
RMFLAGS		= -f

CC		= cc65
CA		= ca65
CL		= cl65
RM		= rm

all: ewoz.hex

ewoz.hex: ewoz.bin
	srec_cat ewoz.bin -binary -offset=0x200 -o ewoz.hex -intel -address-length=2

ewoz.bin: ewoz.a65
	$(CL) $(LFLAGS) -C gw-r65x1qsbc-1.cfg -o ewoz.bin ewoz.a65 IO_Modules/tan-glitchbus-scc.lib

clean:
	$(RM) $(RMFLAGS) *.o *.bin *.hex *.lst *.map

copy: ewoz.bin
	cp ewoz.bin ../r6501q_romfs/binaries/ewoz_ram.bin
	

distclean: clean

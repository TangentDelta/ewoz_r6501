SHELL := /bin/bash

PROJECT		:= ewoz-scc

CLFLAGS		:= -t none -v
RMFLAGS		:= -f
 
CL		:= cl65
RM		:= rm

SRCS		:= ewoz.a65
OBJS		:= $(SRCS:.a65=.o)
LIBDIR		:= Libraries
LIBS		:= $(LIBDIR)/glitchbus-scc.lib $(LIBDIR)/gw-r65x1q-sbc.lib

TARGET = gw-r65x1qsbc-1-ram



.PHONY: clean libraries all

all: clean $(LIBS) $(PROJECT).hex

$(PROJECT).bin: $(SRCS) $(LIBS)
	$(CL) -C $(TARGET).cfg $(CLFLAGS) $(SRCS) $(LIBS) -o $(PROJECT).bin

$(PROJECT).hex: $(PROJECT).bin
	srec_cat $(PROJECT).bin -binary -offset=0x0200 -output $(PROJECT).hex -Intel -address-length=2

clean:
	$(RM) $(RMFLAGS) *.o *.lst *.map *.bin *.hex

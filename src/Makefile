# make
# modinfo nothing.ko

#obj-m += draiveris.o

#all:
#	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

#clean:
#	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean


#TARGET  := draiveris
#WARN    := -W -Wall -Wstrict-prototypes -Wmissing-prototypes
#INCLUDE := -isystem /lib/modules/`uname -r`/build/include
#CFLAGS  := -O2 -DMODULE -D__KERNEL__ ${WARN} ${INCLUDE}
	
#${TARGET}.o: ${TARGET}.c

#.PHONY: clean

#clean:
#	rm -rf ${TARGET}.o


#CFLAGS  += -Wall -Os -I $(BUILD_DIR)/include

#all: draiveris

#draiveris.o: draiveris.c
#	$(CC) $(CFLAGS) -C draiveris.c -o draiveris.o

#clean:
#	rm -f *.o draiveris
#	rm -f tags cscope.*








#
# Makefile for sample driver
#
obj-m   := draiveris.o
#obj-m += dr.o
#dr-objs := draiveris.o

ifeq ($(MAKING_MODULES), 1)

export-objs := draiveris.o

#-include $(TOPDIR)/Rules.make

endif

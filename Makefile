# Copyright (C) 2012 Žilvinas Valinskas, Saulius Lukšė
# See LICENSE for more information.

# http://www.adafruit.com/datasheets/WS2812.pdf

# PC Build single package
# cd /home/test/carambola2/
# clear; make package/ws2812-draiveris/clean
# clear; make package/ws2812-draiveris/compile V=99

# PC: http server
# cd /home/test/carambola2/bin/ar71xx/; python -m SimpleHTTPServer

# PC: Carambola picocom
# sudo picocom -b 115200 /dev/ttyUSB0

# Carambola: get packet
## clear; rmmod ws2812-draiveris; rm /lib/modules/3.7.9/ws2812-draiveris.ko; cd /tmp; rm kmod-ws2812-draiveris*; wget http://192.168.0.63:8000/packages/kmod-draiveris_3.7.9-5_ar71xx.ipk; opkg install kmod-draiveris_3.7.9-5_ar71xx.ipk --force-reinstall; insmod /lib/modules/3.7.9/ws2812-draiveris.ko
## clear; rmmod ws2812-draiveris; insmod /lib/modules/3.7.9/ws2812-draiveris.ko gpio_number=20
# clear; rmmod ws2812-draiveris; rm /lib/modules/3.7.9/ws2812-draiveris.ko; cd /tmp; rm kmod-ws2812-draiveris*; wget http://192.168.0.63:8000/packages/kmod-draiveris_3.7.9-5_ar71xx.ipk; opkg install kmod-draiveris_3.7.9-5_ar71xx.ipk --force-reinstall;
# insmod /lib/modules/3.7.9/ws2812-draiveris.ko gpio_number=20
# mknod /dev/ws2812 c 253 0
# echo -en '\x00\x00\x40' > /dev/ws2812

# test.py
#dev = os.open("/dev/ws2812", os.O_RDWR)
#data = [0x0, 0x60, 0x00] 
#os.write(dev, bytearray(data))





# upgrade firmware
# cd /tmp; wget http://192.168.0.63:8000/openwrt-ar71xx-generic-carambola2-squashfs-sysupgrade.bin; sysupgrade -v -n openwrt-ar71xx-generic-carambola2-squashfs-sysupgrade.bin

# carambola install python
# opkg update
# opkg install python

# carambola driver
# rmmod ws2812-draiveris
# insmod /lib/modules/3.7.9/ws2812-draiveris.ko



# Copyright (C) 2006-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=kmod-ws2812-draiveris
PKG_RELEASE:=8

include $(INCLUDE_DIR)/package.mk

define KernelPackage/ws2812-draiveris
	UBMENU:=Other modules
	TITLE:=ws2812 draiveris drivers
	FILES:= \
	$(PKG_BUILD_DIR)/ws2812-draiveris.ko

	AUTOLOAD:=$(call AutoLoad, 92, ws2812-draiveris-dev)
endef

define KernelPackage/ws2812-draiveris/description
	This package contains ws2812-draiveris drivers for
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Build/Compile
	$(MAKE) -C "$(LINUX_DIR)" \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	ARCH="$(LINUX_KARCH)" \
	SUBDIRS="$(PKG_BUILD_DIR)" \
	EXTRA_CFLAGS="$(BUILDFLAGS)" \
	modules
endef

define KernelPackage/ws2812-draiveris/install
	$(INSTALL_DIR) $(1)/lib/network/
endef

$(eval $(call KernelPackage,ws2812-draiveris))

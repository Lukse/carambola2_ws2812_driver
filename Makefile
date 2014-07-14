# Copyright (C) 2012 Žilvinas Valinskas, Saulius Lukšė
# See LICENSE for more information.


# PC Build single package
# cd /home/test/carambola2/
# clear; make package/draiveris/clean
# clear; make package/draiveris/compile V=99

# PC: http server
# cd /home/test/carambola2/bin/ar71xx/; python -m SimpleHTTPServer

# PC: Carambola picocom
# sudo picocom -b 115200 /dev/ttyUSB0

# Carambola: get packet
# clear; rmmod draiveris; rm /lib/modules/3.7.9/draiveris.ko; cd /tmp; rm kmod-draiveris*; wget http://192.168.0.63:8000/packages/kmod-draiveris_3.7.9-5_ar71xx.ipk; opkg install kmod-draiveris_3.7.9-5_ar71xx.ipk --force-reinstall; insmod /lib/modules/3.7.9/draiveris.ko
# clear; rmmod draiveris; insmod /lib/modules/3.7.9/draiveris.ko mystring="zzzaaasss"

# upgrade firmware
# cd /tmp; wget http://192.168.0.63:8000/openwrt-ar71xx-generic-carambola2-squashfs-sysupgrade.bin; sysupgrade -v -n openwrt-ar71xx-generic-carambola2-squashfs-sysupgrade.bin

# carambola install python
# opkg update
# opkg install python

# carambola driver
# rmmod draiveris
# insmod /lib/modules/3.7.9/draiveris.ko



# Copyright (C) 2006-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=kmod-draiveris
PKG_RELEASE:=5

include $(INCLUDE_DIR)/package.mk

define KernelPackage/draiveris
	UBMENU:=Other modules
	TITLE:=draiveris drivers
	FILES:= \
	$(PKG_BUILD_DIR)/draiveris.ko

	AUTOLOAD:=$(call AutoLoad, 92, draiveris-dev)
endef

define KernelPackage/draiveris/description
	This package contains draiveris drivers for
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

define KernelPackage/draiveris/install
	$(INSTALL_DIR) $(1)/lib/network/
endef

$(eval $(call KernelPackage,draiveris))
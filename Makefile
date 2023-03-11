
include $(TOPDIR)/rules.mk

PKG_NAME:=bfWakePc
PKG_VERSION:=1.1
PKG_RELEASE:=$(AUTORELEASE)

PKG_MAINTAINER:=Jethro <jethro2019x@outlook.com>

PKG_LICENSE:=ISC
PKG_LICENSE_FILES:=COPYING

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk #如果使用cmake，则必须增加此行

define Package/bfWakePc
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=bfWakePc
  TITLE:=bfWakePc
  DEPENDS:=+etherwake
endef

define Package/bfWakePc/description
  cloud.bemfa.com wake pc
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Package/bfWakePc/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bfWakePc $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/ipkg-install/usr/lib/libpaho-embed-mqtt3c.so $(1)/usr/lib/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/ipkg-install/usr/lib/libpaho-embed-mqtt3cc.so $(1)/usr/lib/
endef


$(eval $(call BuildPackage,bfWakePc))

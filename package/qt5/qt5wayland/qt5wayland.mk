################################################################################
#
# qt5wayland
#
################################################################################

QT5WAYLAND_VERSION = $(QT5_VERSION)
QT5WAYLAND_SITE = $(QT5_SITE)
QT5WAYLAND_SOURCE = qtwayland-opensource-src-$(QT5WAYLAND_VERSION).tar.xz
QT5WAYLAND_DEPENDENCIES = qt5base wayland
QT5WAYLAND_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_QT5BASE_LICENSE_APPROVED),y)
QT5WAYLAND_LICENSE = GPLv2+ or LGPLv3, GPLv3 with exception(tools), GFDLv1.3 (docs)
QT5WAYLAND_LICENSE_FILES = LICENSE.GPLv2 LICENSE.GPLv3 LICENSE.GPL3-EXCEPT LICENSE.LGPLv3 LICENSE.FDL
else
QT5WAYLAND_LICENSE = Commercial license
QT5WAYLAND_REDISTRIBUTE = NO
endif

QT5WAYLAND_DEPENDENCIES += qt5declarative

ifeq ($(BR2_PACKAGE_QT5WAYLAND_COMPOSITOR),y)
	QT5WAYLAND_CONFIG_EXTRA += CONFIG+=wayland-compositor
endif

define QT5WAYLAND_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/usr/bin/qmake) $(QT5WAYLAND_CONFIG_EXTRA)
endef

define QT5WAYLAND_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QT5WAYLAND_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) install
	$(QT5_LA_PRL_FILES_FIXUP)
endef

define QT5WAYLAND_INSTALL_TARGET_JAVASCRIPT
	$(INSTALL) -m 0644 -D $(@D)/src/wayland/qwayland.js \
		$(TARGET_DIR)/var/www/qwayland.js
endef

ifeq ($(BR2_PACKAGE_QT5DECLARATIVE_QUICK),y)
define QT5WAYLAND_INSTALL_TARGET_QMLS
	cp -dpfr $(STAGING_DIR)/usr/qml/QtWayland $(TARGET_DIR)/usr/qml/
endef
endif

ifeq ($(BR2_PACKAGE_QT5BASE_EXAMPLES),y)
define QT5WAYLAND_INSTALL_TARGET_EXAMPLES
	cp -dpfr $(STAGING_DIR)/usr/lib/qt/examples/wayland $(TARGET_DIR)/usr/lib/qt/examples/
endef
endif

ifneq ($(BR2_STATIC_LIBS),y)
define QT5WAYLAND_INSTALL_TARGET_LIBS
	cp -dpf $(STAGING_DIR)/usr/lib/libQt5Wayland.so.* $(TARGET_DIR)/usr/lib
endef
endif

define QT5WAYLAND_INSTALL_TARGET_CMDS
	$(QT5WAYLAND_INSTALL_TARGET_LIBS)
	$(QT5WAYLAND_INSTALL_TARGET_QMLS)
	$(QT5WAYLAND_INSTALL_TARGET_JAVASCRIPT)
	$(QT5WAYLAND_INSTALL_TARGET_EXAMPLES)
endef

$(eval $(generic-package))

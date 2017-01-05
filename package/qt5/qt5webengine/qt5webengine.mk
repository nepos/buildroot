################################################################################
#
# qt5webengine
#
################################################################################

QT5WEBENGINE_VERSION = $(QT5_VERSION)
QT5WEBENGINE_SITE = $(QT5_SITE)
QT5WEBENGINE_SOURCE = qtwebengine-opensource-src-$(QT5WEBENGINE_VERSION).tar.xz
QT5WEBENGINE_DEPENDENCIES = qt5base qt5websockets qt5webchannel
QT5WEBENGINE_INSTALL_STAGING = YES
QT5WEBENGINE_CONFIG_EXTRA =

ifeq ($(BR2_PACKAGE_QT5BASE_LICENSE_APPROVED),y)
QT5WEBENGINE_LICENSE = GPLv2+ or LGPLv3, GPLv3 with exception(tools), GFDLv1.3 (docs)
QT5WEBENGINE_LICENSE_FILES = LICENSE.GPLv2 LICENSE.GPLv3 LICENSE.GPL3-EXCEPT LICENSE.LGPLv3 LICENSE.FDL
else
QT5WEBENGINE_LICENSE = Commercial license
QT5WEBENGINE_REDISTRIBUTE = NO
endif

ifeq ($(BR2_PACKAGE_QT5DECLARATIVE),y)
QT5WEBENGINE_DEPENDENCIES += qt5declarative
endif

ifeq ($(BR2_PACKAGE_QT5WEBENGINE_PROPRIETARY_CODECS),y)
	QT5WEBENGINE_CONFIG_EXTRA += WEBENGINE_CONFIG+=use_proprietary_codecs
endif

define QT5WEBENGINE_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/usr/bin/qmake $(QT5WEBENGINE_CONFIG_EXTRA))
endef

define QT5WEBENGINE_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QT5WEBENGINE_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) install
	$(QT5_LA_PRL_FILES_FIXUP)
endef

ifeq ($(BR2_PACKAGE_QT5DECLARATIVE_QUICK),y)
define QT5WEBENGINE_INSTALL_TARGET_QMLS
	cp -dpfr $(STAGING_DIR)/usr/qml/QtWebEngine $(TARGET_DIR)/usr/qml/
endef
endif

ifeq ($(BR2_PACKAGE_QT5BASE_EXAMPLES),y)
define QT5WEBENGINE_INSTALL_TARGET_EXAMPLES
	cp -dpfr $(STAGING_DIR)/usr/lib/qt/examples/webengine $(TARGET_DIR)/usr/lib/qt/examples/
	cp -dpfr $(STAGING_DIR)/usr/lib/qt/examples/webenginewidgets $(TARGET_DIR)/usr/lib/qt/examples/
endef
endif

ifneq ($(BR2_STATIC_LIBS),y)
define QT5WEBENGINE_INSTALL_TARGET_LIBS
	cp -dpf $(STAGING_DIR)/usr/lib/libQt5WebEngine*.so.* $(TARGET_DIR)/usr/lib
endef
endif

define QT5WEBENGINE_INSTALL_TARGET_CMDS
	$(QT5WEBENGINE_INSTALL_TARGET_LIBS)
	$(QT5WEBENGINE_INSTALL_TARGET_QMLS)
	$(QT5WEBENGINE_INSTALL_TARGET_EXAMPLES)
endef

$(eval $(generic-package))

################################################################################
#
# nepos-kiosk-browser-qt
#
################################################################################

NEPOS_KIOSK_BROWSER_QT_VERSION = master
NEPOS_KIOSK_BROWSER_QT_SITE = git@github.com:nepos/kiosk-browser-qt.git
NEPOS_KIOSK_BROWSER_QT_SITE_METHOD = git
NEPOS_KIOSK_BROWSER_QT_LICENSE = GPLv2
NEPOS_KIOSK_BROWSER_QT_LICENSE_FILES = LICENSE.GPL2
NEPOS_KIOSK_BROWSER_QT_DEPENDENCIES = qt5base qt5webengine
NEPOS_KIOSK_BROWSER_QT_QMAKE = $(QT5_QMAKE)

define NEPOS_KIOSK_BROWSER_QT_CONFIGURE_CMDS
	cd $(@D); $(TARGET_MAKE_ENV) $(QT5_QMAKE)
endef

define NEPOS_KIOSK_BROWSER_QT_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define NEPOS_KIOSK_BROWSER_QT_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) install
endef

$(eval $(generic-package))

################################################################################
#
# casync
#
################################################################################

CASYNC_VERSION = master
CASYNC_SITE = $(call github,systemd,casync,$(CASYNC_VERSION))
CASYNC_DEPENDENCIES = host-pkgconf xz libgcrypt
CASYNC_LICENSE = LGPLv2+
#CASYNC_LICENSE_FILES = COPYING
CASYNC_AUTORECONF = YES
CASYNC_CONF_OPTS = \
	--with-libgcrypt-prefix=$(STAGING_DIR)/usr

$(eval $(autotools-package))

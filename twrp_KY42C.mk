#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit common TWRP configuration.
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from KY-42C device configuration.
$(call inherit-product, device/kyocera/KY-42C/device.mk)

# Keep the product/lunch name hyphen-free, but PRODUCT_DEVICE must match the
# actual device-tree directory name so build/make can locate BoardConfig.mk.
PRODUCT_DEVICE := KY-42C
PRODUCT_NAME := twrp_KY42C
PRODUCT_BRAND := KYOCERA
PRODUCT_MODEL := KY-42C
PRODUCT_MANUFACTURER := KYOCERA

PRODUCT_GMS_CLIENTID_BASE := android-kyocera

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="KY-42C-user 10 1.120GC.0153.a 1.120GC.0153.a release-keys"

BUILD_FINGERPRINT := KYOCERA/KY-42C/KY-42C:10/1.120GC.0153.a/1.120GC.0153.a:user/release-keys

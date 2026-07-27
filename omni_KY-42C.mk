#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Omni stuff.
$(call inherit-product, vendor/omni/config/common.mk)

# Inherit from KY-42C device
$(call inherit-product, device/kyocera/KY-42C/device.mk)

PRODUCT_DEVICE := KY-42C
PRODUCT_NAME := omni_KY-42C
PRODUCT_BRAND := KYOCERA
PRODUCT_MODEL := KY-42C
PRODUCT_MANUFACTURER := kyocera

PRODUCT_GMS_CLIENTID_BASE := android-kyocera

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="KY-42C-user 10 1.120GC.0153.a 1.120GC.0153.a release-keys"

BUILD_FINGERPRINT := KYOCERA/KY-42C/KY-42C:10/1.120GC.0153.a/1.120GC.0153.a:user/release-keys

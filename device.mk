#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/kyocera/KY-42C

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.0-impl \
    android.hardware.health@2.0-impl.recovery \
    android.hardware.health@2.0-service

# API levels
PRODUCT_SHIPPING_API_LEVEL := 29

# VNDK
PRODUCT_TARGET_VNDK_VERSION := 29

# Useful during bring-up.
PRODUCT_PACKAGES += lshal
TARGET_RECOVERY_DEVICE_MODULES += lshal

# The KY-41C merge imported a recovery-side Trustonic/Keymaster stack here.
# KY-42C does advertise Keymaster 3.0, Gatekeeper 1.0, and Trustonic TEE,
# but recovery decryption will be re-enabled only after the KY-42C vendor
# binaries and runtime dependencies have been validated independently.

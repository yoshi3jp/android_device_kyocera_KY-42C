#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/kyocera/KY-42C

# Make Soong modules declared in this device namespace visible to Make.
PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH)

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
# PRODUCT_PACKAGES += lshal
# TARGET_RECOVERY_DEVICE_MODULES += lshal

# Recovery-only keypad to virtual mouse/keyboard bridge. The stock matrix
# keypad remains the hardware source; TWRP consumes the uinput device emitted
# by ky42c-keyptrd instead of consuming matrix_keypad directly.
TARGET_RECOVERY_DEVICE_MODULES += ky42c-keyptrd

# Android 10-era fscrypt uses the legacy session keyring interface.
# TWRP 12.1 no longer creates the "fscrypt" child keyring during init,
# so create it before recovery begins FBE initialization.
# TARGET_RECOVERY_DEVICE_MODULES += ky42c-fscrypt-keyring

# The KY-41C merge imported a recovery-side Trustonic/Keymaster stack here.
# KY-42C does advertise Keymaster 3.0, Gatekeeper 1.0, and Trustonic TEE,
# but recovery decryption will be re-enabled only after the KY-42C vendor
# binaries and runtime dependencies have been validated independently.

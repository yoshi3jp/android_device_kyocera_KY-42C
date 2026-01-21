#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),KY41C)
include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif

#SET TRUSTONIC TO DEFAULT VIA SYMLINK
include $(CLEAR_VARS)
LOCAL_MODULE := kmsetkey_symlinks
LOCAL_MODULE_CLASS := FAKE
LOCAL_MODULE_TAGS := optional
LOCAL_POST_INSTALL_CMD := \
    ln -sf /vendor/lib/hw/kmsetkey.trustonic.so $(TARGET_OUT_VENDOR)/lib/hw/kmsetkey.default.so; \
    ln -sf /vendor/lib/hw/libSoftGatekeeper.so $(TARGET_OUT_VENDOR)/lib/hw/gatekeeper.default.so; \
    ln -sf /vendor/lib/hw/gatekeeper.k61v1_32_bsp_1g.so $(TARGET_OUT_VENDOR)/lib/hw/libMcGatekeeper.so; \
    ln -sf /vendor/lib/hw/gatekeeper.mt6761.so $(TARGET_OUT_VENDOR)/lib/hw/libMcGatekeeper.so;
include $(BUILD_SYSTEM)/base_rules.mk

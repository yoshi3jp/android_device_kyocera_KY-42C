#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/kyocera/KY-42C

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

# Architecture
#
# A1 deliberately keeps the TWRP userspace 32-bit.  Only the prebuilt Linux
# kernel is AArch64; CONFIG_COMPAT in that kernel provides the 32-bit userspace
# execution environment.
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a53

# PRODUCT_SHIPPING_API_LEVEL >= 28 requires a 64-bit binder ABI.
TARGET_USES_64_BIT_BINDER := true

# APEX
OVERRIDE_TARGET_FLATTEN_APEX := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := k61v1_32_bsp_1g
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 240
TARGET_SCREEN_WIDTH := 480
TARGET_SCREEN_HEIGHT := 854

# Kernel - ARM64 A1 recovery prebuilts.  Recovery userspace remains ARM32.
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img

# Kernel image geometry
#
# Same-generation MediaTek MT6761 K64 BoardConfig keeps the common LK-visible
# base at 0x40000000, but changes the kernel offset from the K32 0x8000 to
# 0x80000.  That gives the AArch64 Image load address 0x40080000 and matches
# the text_offset=0x80000 carried by the A1 Linux Image header.
BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_KERNEL_BASE := 0x40000000
BOARD_KERNEL_OFFSET := 0x00080000
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 buildvariant=eng
BOARD_KERNEL_PAGESIZE := 2048
BOARD_RAMDISK_OFFSET := 0x11b00000
BOARD_KERNEL_TAGS_OFFSET := 0x07880000

# Keep the MT6761 K64 header-v2 contract explicit.  In particular, do not
# inherit mkbootimg's generic kernel or DTB offsets: LK consumes these physical
# addresses from the boot image header.
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_KERNEL_TAGS_OFFSET)

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072 # BOARD_KERNEL_PAGESIZE * 64
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 33554432
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 870318080
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# Verified KY-42C super geometry. Stock metadata names the group "main".
BOARD_SUPER_PARTITION_SIZE := 2044723200
BOARD_SUPER_PARTITION_GROUPS := main
BOARD_MAIN_PARTITION_LIST := system vendor product odm
BOARD_MAIN_SIZE := 2042626048

# Platform
TARGET_BOARD_PLATFORM := mt6761
BOARD_USES_MTK_HARDWARE := true
BOARD_HAS_MTK_HARDWARE := true

# Recovery
BOARD_INCLUDE_RECOVERY_DTBO := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/etc/recovery.fstab

# Verified Boot. Restore the KY-42C pre-merge RSA-4096 recovery signing setup;
# the KY-41C merge changed this to RSA-2048 without KY-42C evidence.
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# Recovery build compatibility values.
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 10.0.0

# File-based encryption.
#
# Stock KY-42C uses fscrypt FBE with AES-256-XTS contents encryption.
# Userdata is mounted directly as F2FS; there is no metadata-encryption
# dm layer, no keydirectory=, and no wrapped-key fstab flag.
TW_INCLUDE_CRYPTO := true
TW_USE_FSCRYPT_POLICY := 1
TW_PREPARE_DATA_MEDIA_EARLY := true

# TWRP Configuration
TW_THEME := portrait_mdpi
TW_EXTRA_LANGUAGES := true
TW_SCREEN_BLANK_ON_BOOT := true
TW_USE_TOOLBOX := true
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 127
TW_INCLUDE_NTFS_3G := true
TW_EXCLUDE_SUPERSU := true
TW_USE_NEW_MINADBD := true
# ky42c-keyptrd reads matrix_keypad directly and re-emits a composite uinput
# mouse/keyboard. Blacklist only that live source to avoid duplicate TWRP input.
# The stock keyptr stays disabled (onoff=0) and emits no events.
TW_INPUT_BLACKLIST := "matrix_keypad"
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_DEVICE_VERSION := SavedByLight & Yoshi3jp
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_LIBRESETPROP := true
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

# VINTF / Treble
PRODUCT_FULL_TREBLE := true
PRODUCT_ENFORCE_VINTF_MANIFEST := true

# Logging
TARGET_USES_LOGD := true
TWRP_INCLUDE_LOGCAT := true
TWRP_EVENT_LOGGING := true

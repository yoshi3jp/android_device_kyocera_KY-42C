LOCAL_PATH := device/kyocera/KY41C

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.0-impl \
    android.hardware.health@2.0-impl.recovery \
    android.hardware.health@2.0-service

# API levels
PRODUCT_SHIPPING_API_LEVEL := 29

# VNDK
PRODUCT_TARGET_VNDK_VERSION := 29
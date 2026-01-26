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

# LD CONFIG FOR SP HAL : apparently not a good idea.
#PRODUCT_PACKAGES += \
#    ld.config.txt

# Add only Keymaster 3
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-service.trustonic

PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.keymaster.version=3.0 \
    ro.hardware.kmsetkey=trustonic \
    ro.hardware.gatekeeper=trustonic \
    ro.vendor.mtk_trustonic_tee_support=1

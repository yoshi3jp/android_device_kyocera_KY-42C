LOCAL_PATH := device/kyocera/KY41C

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.0-impl \
    android.hardware.health@2.0-impl.recovery \
    android.hardware.health@2.0-service

# Add only Keymaster 3
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-service.trustonic

PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.keymaster.version=3.0 \
    ro.hardware.kmsetkey=trustonic \
    ro.hardware.gatekeeper=trustonic \
    ro.vendor.mtk_trustonic_tee_support=1

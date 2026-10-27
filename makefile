TARGET := iphone:clang:latest
ARCHS := arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME := OxidePro
OxidePro_FILES := Tweak.mm
OxidePro_CFLAGS := -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

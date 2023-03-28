ifeq ($(BUILD_CPU_MPU1),yes)
ifeq ($(TARGET_CPU),A53)
ifeq ($(TARGET_OS),$(filter $(TARGET_OS), QNX))

include $(PRELUDE)
TARGET      := app_rtos_qnx_mpu1_common
TARGETTYPE  := library
CSOURCES    := $(call all-c-files)

IDIRS+=$(VISION_APPS_PATH)/platform/$(SOC)/qnx
IDIRS+=$(VISION_APPS_PATH)/platform/$(SOC)/rtos/common
IDIRS+=$(VISION_APPS_PATH)/platform/$(SOC)/rtos
IDIRS+=$(PSDK_QNX_PATH)/pdk/packages
IDIRS+=$(PSDK_QNX_PATH)/qnx
IDIRS+=$(IMAGING_PATH)/kernels/include

IDIRS+=$(VISION_APPS_PATH)/apps/basic_demos/app_single_cam

STATIC_LIBS += vx_app_single_cam
include $(FINALE)

endif
endif
endif


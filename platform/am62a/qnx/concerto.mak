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
IDIRS+=$(VISION_APPS_PATH)/apps/dl_demos/app_tidl
IDIRS+=$(VISION_APPS_PATH)/apps/dl_demos/app_tidl_cam
IDIRS+=$(VISION_APPS_PATH)/apps/dl_demos/app_tidl_od_cam
IDIRS+=$(EDGEAI_KERNELS_PATH)
IDIRS+=$(EDGEAI_KERNELS_PATH)/include

STATIC_LIBS += app_utils_draw2d
STATIC_LIBS += app_utils_omax_wrapper
STATIC_LIBS += app_utils_codec_wrapper
STATIC_LIBS += vx_app_single_cam
STATIC_LIBS += vx_app_tidl
STATIC_LIBS += vx_app_tidl_cam 
STATIC_LIBS += vx_app_tidl_od_cam 
SHARED_LIBS += edgeai-tiovx-kernels
include $(FINALE)

endif
endif
endif


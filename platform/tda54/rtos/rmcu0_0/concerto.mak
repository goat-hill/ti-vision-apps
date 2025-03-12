ifeq ($(BUILD_APP_RTOS_LINUX),yes)
ifeq ($(BUILD_CPU_RMCU0_0),yes)
ifeq ($(TARGET_CPU),R5F)

# OS_ID must be set before include $(PRELUDE)
OS_ID=linux

_MODULE=$(OS_ID)
include $(PRELUDE)

TARGET      := vx_app_rtos_linux_rmcu0_0
TARGETTYPE  := exe
CSOURCES    := main.c

include $($(_MODULE)_SDIR)/concerto_rmcu0_0_inc.mak

IDIRS+=$(VISION_APPS_PATH)/platform/$(SOC)/rtos/common_linux

include $(FINALE)

endif
endif
endif

ifeq ($(BUILD_APP_RTOS_QNX),yes)
ifeq ($(BUILD_CPU_RMCU0_0),yes)
ifeq ($(TARGET_CPU),R5F)

# OS_ID must be set before include $(PRELUDE)
OS_ID=qnx

_MODULE=$(OS_ID)
include $(PRELUDE)

TARGET      := vx_app_rtos_qnx_rmcu0_0
TARGETTYPE  := exe
CSOURCES    := main.c

include $($(_MODULE)_SDIR)/concerto_rmcu0_0_inc.mak

IDIRS+=$(VISION_APPS_PATH)/platform/$(SOC)/rtos/common_qnx

include $(FINALE)

endif
endif
endif

DEFS+=CPU_mcu3
RTOS_LC := $(call lowercase,$(RTOS))

ifeq ($(RTOS),FREERTOS)
	CSOURCES += generated/ti_board_config.c
	CSOURCES += generated/ti_board_open_close.c
	CSOURCES += generated/ti_dpl_config.c
	CSOURCES += generated/ti_drivers_config.c
	CSOURCES += generated/ti_drivers_open_close.c
#	CSOURCES += generated/ti_pinmux_config.c
#	CSOURCES += generated/ti_power_clock_config.c
#	CSOURCES += $(SOC)_mpu_cfg.c
	LINKER_CMD_FILES +=  $($(_MODULE)_SDIR)/$(SOC)_linker_freertos.cmd
endif

ifeq ($(RTOS),SAFERTOS)
	CSOURCES += $(SOC)_safertos_mpu_cfg.c
	LINKER_CMD_FILES +=  $($(_MODULE)_SDIR)/$(SOC)_linker_safertos.cmd
endif

LINKER_CMD_FILES +=  $($(_MODULE)_SDIR)/linker_mem_map.cmd

IDIRS+=$(VISION_APPS_PATH)/platform/$(SOC)/rtos
IDIRS+=$(REMOTE_DEVICE_PATH)
IDIRS+=$(ETHFW_PATH)

ifeq ($(RTOS),SAFERTOS)
#	IDIRS+=${SAFERTOS_KERNEL_INSTALL_PATH_r5f}/source_code_and_projects/SafeRTOS/api/$(SAFERTOS_ISA_EXT_r5f)
#	IDIRS+=${SAFERTOS_KERNEL_INSTALL_PATH_r5f}/source_code_and_projects/SafeRTOS/api/PrivWrapperStd
#	IDIRS+=${SAFERTOS_KERNEL_INSTALL_PATH_r5f}/source_code_and_projects/SafeRTOS/config
#	IDIRS+=${SAFERTOS_KERNEL_INSTALL_PATH_r5f}/source_code_and_projects/SafeRTOS/kernel/include_api
#	IDIRS+=${SAFERTOS_KERNEL_INSTALL_PATH_r5f}/source_code_and_projects/SafeRTOS/kernel/include_prv
#	IDIRS+=${SAFERTOS_KERNEL_INSTALL_PATH_r5f}/source_code_and_projects/SafeRTOS/portable/$(SAFERTOS_ISA_EXT_r5f)
#	IDIRS+=${SAFERTOS_KERNEL_INSTALL_PATH_r5f}/source_code_and_projects/SafeRTOS/portable/$(SAFERTOS_ISA_EXT_r5f)/$(SAFERTOS_COMPILER_EXT_r5f)
endif


IDIRS+=$(VISION_APPS_PATH)/platform/$(SOC)/rtos/mcu3/generated

ifeq ($(RTOS),FREERTOS)
	LDIRS += $(MCU_PLUS_SDK_PATH)/source/kernel/freertos/lib/
endif

LDIRS += $(MCU_PLUS_SDK_PATH)/source/drivers/lib/
# LDIRS += $(MCU_PLUS_SDK_PATH)/source/board/lib/
# LDIRS += $(MCU_PLUS_SDK_PATH)/source/drivers/vhwa/lib
# LDIRS += $(ETHFW_PATH)/out/TDA54/R5Ft/$(TARGET_OS)/$(TARGET_BUILD)
# LDIRS += $(REMOTE_DEVICE_PATH)/lib/J784S4/$(TARGET_CPU)/$(TARGET_OS)/$(TARGET_BUILD)

#ifeq ($(RTOS), $(filter $(RTOS), FREERTOS SAFERTOS))
#	LDIRS += $(PDK_PATH)/packages/ti/transport/lwip/lwip-stack/lib/$(RTOS_LC)/$(SOC)/r5f/$(TARGET_BUILD)/
#	LDIRS += $(PDK_PATH)/packages/ti/transport/lwip/lwip-stack/contrib/lib/$(RTOS_LC)/$(SOC)/r5f/$(TARGET_BUILD)/
#	LDIRS += $(PDK_PATH)/packages/ti/transport/lwip/lwip-port/lib/$(RTOS_LC)/${SOC}/r5f/$(TARGET_BUILD)/
#	LDIRS += $(PDK_PATH)/packages/ti/drv/enet/lib/$(RTOS_LC)/$(SOC)/r5f/$(TARGET_BUILD)/
#ifeq ($(ETHFW_GPTP_BUILD_SUPPORT),yes)
#	LDIRS += $(PDK_PATH)/packages/ti/transport/tsn/lib/r5f/$(TARGET_BUILD)/
#	LDIRS += $(PDK_PATH)/packages/ti/drv/mmcsd/lib/r5f/$(TARGET_BUILD)/
#    LDIRS += $(PDK_PATH)/packages/ti/fs/fatfs/lib/r5f/$(TARGET_BUILD)/
#endif
#endif

include $($(_MODULE)_SDIR)/../concerto_m55_inc.mak

#ifeq ($(BUILD_ENABLE_ETHFW),yes)
#DEFS+=ENABLE_ETHFW
#endif

# CPU instance specific libraries
STATIC_LIBS += app_rtos_common_mcu3
ifeq ($(RTOS), $(filter $(RTOS), FREERTOS SAFERTOS))
	#STATIC_LIBS += app_rtos
endif

ADDITIONAL_STATIC_LIBS += drivers.tda54.m55.ti-arm-clang.${TARGET_BUILD}.lib

#SYS_STATIC_LIBS += app_utils_hwa
SYS_STATIC_LIBS += app_utils_sciclient
#
#ifeq ($(BUILD_MCU_BOARD_DEPENDENCIES),yes)
#SYS_STATIC_LIBS += app_utils_dss
#endif
#
#ifeq ($(BUILD_ENABLE_ETHFW),yes)
#STATIC_LIBS += app_utils_ethfw
#ETHFW_LIBS += ethfw_callbacks
#ETHFW_LIBS += eth_intervlan
#ETHFW_LIBS += ethfw_board
#ETHFW_LIBS += ethfw_remotecfg_server
#ETHFW_LIBS += ethfw_common
#ETHFW_LIBS += ethfw_abstract
#ifeq ($(ETHFW_EST_DEMO_SUPPORT),yes)
#ETHFW_LIBS += ethfw_estdemo
#endif
#endif
#
#SYS_STATIC_LIBS += $(ETHFW_LIBS)
#SYS_STATIC_LIBS += $(REMOTE_DEVICE_LIBS)
#
#ADDITIONAL_STATIC_LIBS += csirx.aer5f
#ADDITIONAL_STATIC_LIBS += csitx.aer5f
#ADDITIONAL_STATIC_LIBS += dss.aer5f
#ADDITIONAL_STATIC_LIBS += vhwa.aer5f
#
#ifeq ($(BUILD_ENABLE_ETHFW),yes)
#ADDITIONAL_STATIC_LIBS += enetsoc.aer5f
#ADDITIONAL_STATIC_LIBS += enet.aer5f
#ADDITIONAL_STATIC_LIBS += enetphy.aer5f
#ifeq ($(ETHFW_GPTP_BUILD_SUPPORT),yes)
#ADDITIONAL_STATIC_LIBS += tsn_gptp.aer5f
#ADDITIONAL_STATIC_LIBS += tsn_uniconf.aer5f
#ADDITIONAL_STATIC_LIBS += tsn_combase.aer5f
#ADDITIONAL_STATIC_LIBS += tsn_unibase.aer5f
#ADDITIONAL_STATIC_LIBS += ti.drv.mmcsd.aer5f
#ADDITIONAL_STATIC_LIBS += ti.fs.fatfs.aer5f
#endif
#
#ifeq ($(RTOS), $(filter $(RTOS), FREERTOS SAFERTOS))
#	ADDITIONAL_STATIC_LIBS += lwipcontrib_$(RTOS_LC).aer5f
#	ADDITIONAL_STATIC_LIBS += lwipstack_$(RTOS_LC).aer5f
#	ADDITIONAL_STATIC_LIBS += lwipport_$(RTOS_LC).aer5f
#	ADDITIONAL_STATIC_LIBS += lwipif_$(RTOS_LC).aer5f
#	ADDITIONAL_STATIC_LIBS += lwipific_$(RTOS_LC).aer5f
#	ADDITIONAL_STATIC_LIBS += enet_intercore.aer5f
#	ADDITIONAL_STATIC_LIBS += enet_example_utils_$(RTOS_LC).aer5f
#	ADDITIONAL_STATIC_LIBS += enet_cfgserver_$(RTOS_LC).aer5f
#endif
#endif
#
#ADDITIONAL_STATIC_LIBS += pm_lib.aer5f
#ADDITIONAL_STATIC_LIBS += sciclient.aer5f

DEFS        += $(RTOS)

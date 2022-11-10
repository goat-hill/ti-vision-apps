#
# Utility makefile to build TIDL libaries and related components
#
# Edit this file to suit your specific build needs
#

export MMALIB_PATH

mmalib:
ifeq ($(BUILD_TARGET_MODE),yes)
	$(MAKE) -C $(MMALIB_PATH) mmalib mmalib_cn common SRC_DIR=cnn TARGET_BUILD=release
endif
ifeq ($(BUILD_EMULATION_MODE),yes)
	$(MAKE) -C $(MMALIB_PATH) mmalib mmalib_cn common SRC_DIR=cnn TARGET_CPU=x86_64 TARGET_SCPU=$(C7X_TARGET) TARGET_PLATFORM=PC TARGET_BUILD=release
endif

mmalib_clean:
	rm -rf $(MMALIB_PATH)/out

ifeq ($(BUILD_QNX_A72),yes)
tidl: tidl_rt tfl_delegate
else
tidl:
endif
ifeq ($(BUILD_EMULATION_MODE),yes)
	$(foreach current_profile, $(PDK_BUILD_PROFILE_LIST_ALL),\
		$(MAKE) -C $(TIDL_PATH)/algo PSDK_INSTALL_PATH=$(PSDK_PATH) DSP_TOOLS=$(CGT7X_ROOT) TARGET_PLATFORM=PC TARGET_BUILD=$(current_profile); \
    )
endif
# forcing release mode build, modify below to switch to $(current_profile)
# TARGET_BUILD=release -> TARGET_BUILD=$(current_profile)
ifeq ($(BUILD_TARGET_MODE),yes)
	$(foreach current_profile, $(PDK_BUILD_PROFILE_LIST_ALL),\
		$(MAKE) -C $(TIDL_PATH)/algo PSDK_INSTALL_PATH=$(PSDK_PATH) DSP_TOOLS=$(CGT7X_ROOT) TARGET_PLATFORM=TI_DEVICE TARGET_BUILD=release; \
    )
endif

tidl_scrub tidl_clean: tidl_rt_clean tfl_delegate_clean
ifeq ($(BUILD_LINUX_A72),yes)
	rm -rf $(TIDL_PATH)/../out
endif
ifeq ($(BUILD_QNX_A72),yes)
	rm -rf $(TIDL_PATH)/../out
endif
tidl_rt:
ifeq ($(BUILD_LINUX_A72),yes)
ifeq ($(BUILD_EMULATION_MODE),yes)
	$(foreach current_profile, $(PDK_BUILD_PROFILE_LIST_ALL),\
		$(MAKE) -C $(TIDL_PATH)/../ tidl_rt PSDK_INSTALL_PATH=$(PSDK_PATH) TARGET_PLATFORM=PC TARGET_BUILD=$(current_profile); \
    )
endif
ifeq ($(BUILD_TARGET_MODE),yes)
	$(foreach current_profile, $(PDK_BUILD_PROFILE_LIST_ALL),\
		$(MAKE) -C $(TIDL_PATH)/../ tidl_rt PSDK_INSTALL_PATH=$(PSDK_PATH) TARGET_BUILD=$(current_profile); \
    )
endif
endif
ifeq ($(BUILD_QNX_A72),yes)
ifeq ($(BUILD_TARGET_MODE),yes)
	$(foreach current_profile, $(PDK_BUILD_PROFILE_LIST_ALL),\
		$(MAKE) -C $(TIDL_PATH)/../ tidl_rt PSDK_INSTALL_PATH=$(PSDK_PATH) TARGET_BUILD=$(current_profile); \
    )
endif
endif

tidl_rt_scrub tidl_rt_clean:
ifeq ($(BUILD_LINUX_A72),yes)
ifeq ($(BUILD_EMULATION_MODE),yes)
	$(foreach current_profile, $(PDK_BUILD_PROFILE_LIST_ALL),\
		$(MAKE) -C $(TIDL_PATH)/../ tidl_rt_clean PSDK_INSTALL_PATH=$(PSDK_PATH) TARGET_PLATFORM=PC TARGET_BUILD=$(current_profile); \
    )
endif
ifeq ($(BUILD_TARGET_MODE),yes)
	$(foreach current_profile, $(PDK_BUILD_PROFILE_LIST_ALL),\
		$(MAKE) -C $(TIDL_PATH)/../ tidl_rt_clean PSDK_INSTALL_PATH=$(PSDK_PATH) TARGET_BUILD=$(current_profile); \
    )
endif
endif
ifeq ($(BUILD_QNX_A72),yes)
ifeq ($(BUILD_TARGET_MODE),yes)
	$(foreach current_profile, $(PDK_BUILD_PROFILE_LIST_ALL),\
		$(MAKE) -C $(TIDL_PATH)/../ tidl_rt_clean PSDK_INSTALL_PATH=$(PSDK_PATH) TARGET_BUILD=$(current_profile); \
    )
endif
endif
tfl_delegate:
ifeq ($(BUILD_QNX_A72),yes)
ifeq ($(BUILD_TARGET_MODE),yes)
	$(foreach current_profile, $(PDK_BUILD_PROFILE_LIST_ALL),\
		$(MAKE) -C $(TIDL_PATH)/../ tfl_delegate PSDK_INSTALL_PATH=$(PSDK_PATH) TARGET_BUILD=$(current_profile) TARGET_OS=QNX; \
    )
endif
endif

tfl_delegate_clean tfl_delegate_scrub:
ifeq ($(BUILD_QNX_A72),yes)
ifeq ($(BUILD_TARGET_MODE),yes)
	$(foreach current_profile, $(PDK_BUILD_PROFILE_LIST_ALL),\
	$(MAKE) -C $(TIDL_PATH)/../ tfl_delegate_clean PSDK_INSTALL_PATH=$(PSDK_PATH) TARGET_BUILD=$(current_profile) TARGET_OS=QNX; \
    )
endif
endif
.PHONY: tidl tidl_clean mmalib mmalib_clean tidl_rt tidl_rt_clean tidl_rt_scrub tfl_delegate

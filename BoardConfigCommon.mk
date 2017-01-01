#
# Copyright (C) 2016 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

BOARD_VENDOR := lge

COMMON_PATH := device/lge/msm8952-common

# Platform
TARGET_BOARD_PLATFORM := msm8952
TARGET_BOARD_PLATFORM_GPU := qcom-adreno405

# Architecture
ifneq ($(FORCE_32_BIT),true)
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

TARGET_BOARD_SUFFIX := _64
TARGET_USES_64_BIT_BINDER := true
else
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a53

TARGET_BOARD_SUFFIX := _32
endif

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := MSM8952
TARGET_NO_BOOTLOADER := true

# Kernel
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_CMDLINE := androidboot.hardware=qcom msm_rtb.filter=0x237 ehci-hcd.park=3 androidboot.bootdevice=7824900.sdhci lpm_levels.sleep_disabled=1 androidboot.selinux=permissive
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_RAMDISK_OFFSET     := 0x01000000
TARGET_KERNEL_APPEND_DTB := true
TARGET_KERNEL_SOURCE := kernel/lge/msm8952
ifneq ($(FORCE_32_BIT),true)
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-android-
else
BOARD_KERNEL_IMAGE_NAME := zImage-dtb
endif

# Audio
BOARD_USES_ALSA_AUDIO := true
USE_CUSTOM_AUDIO_POLICY := 1

# Display
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true
TARGET_USES_C2D_COMPOSITION := true
TARGET_USES_ION := true
TARGET_USES_OVERLAY := true
USE_OPENGL_RENDERER := true

MAX_EGL_CACHE_KEY_SIZE := 12*1024
MAX_EGL_CACHE_SIZE := 2048*1024

HAVE_ADRENO_SOURCE:= false
OVERRIDE_RS_DRIVER:= libRSDriver_adreno.so

# Filesystem
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
TARGET_USERIMAGES_USE_EXT4 := true

# Init
TARGET_PLATFORM_DEVICE_BASE := /devices/soc.0/

# Keymaster
TARGET_PROVIDES_KEYMASTER := true

# Power
TARGET_POWERHAL_VARIANT := qcom

# Properties
TARGET_SYSTEM_PROP := $(COMMON_PATH)/system.prop

# Qualcomm
BOARD_USES_QCOM_HARDWARE := true
BOARD_USES_QC_TIME_SERVICES := true

# Recovery
TARGET_RECOVERY_FSTAB := $(COMMON_PATH)/rootdir/etc/fstab.qcom

# RIL
BOARD_PROVIDES_LIBRIL := true

# inherit from the proprietary version
-include vendor/lge/msm8952-common/BoardConfigVendor.mk

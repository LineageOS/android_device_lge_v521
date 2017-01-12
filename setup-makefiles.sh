#!/bin/bash
#
# Copyright (C) 2017 The LineageOS Project
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

set -e

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi

CM_ROOT="$MY_DIR"/../../..

HELPER="$CM_ROOT"/vendor/cm/build/tools/extract_utils.sh
if [ ! -f "$HELPER" ]; then
    echo "Unable to find helper script at $HELPER"
    exit 1
fi
. "$HELPER"

# Initialize the helper for common device
setup_vendor "$DEVICE_COMMON" "$VENDOR" "$CM_ROOT" true

# Copyright headers and common guards
write_headers "msm8952 v521"

# The standard blobs
write_makefiles "$MY_DIR"/proprietary-files.txt

printf '\n%s\n' "ifeq (\$(FORCE_32_BIT),)" >> "$PRODUCTMK"
printf '\n%s\n' "ifeq (\$(FORCE_32_BIT),)" >> "$ANDROIDMK"

write_makefiles "$MY_DIR"/proprietary-files-64.txt

echo "endif" >> "$PRODUCTMK"
echo "endif" >> "$ANDROIDMK"

# Qualcomm BSP blobs - we put a conditional around here
# in case the BSP is actually being built
printf '\n%s\n' "ifeq (\$(QCPATH),)" >> "$PRODUCTMK"
printf '\n%s\n' "ifeq (\$(QCPATH),)" >> "$ANDROIDMK"

write_makefiles "$MY_DIR"/proprietary-files-qc.txt
printf '\n%s\n' "\$(call inherit-product, vendor/qcom/binaries/msm8916-32/graphics/graphics-vendor.mk)" >> "$PRODUCTMK"

printf '\n%s\n' "ifeq (\$(FORCE_32_BIT),)" >> "$PRODUCTMK"
printf '\n%s\n' "ifeq (\$(FORCE_32_BIT),)" >> "$ANDROIDMK"

write_makefiles "$MY_DIR"/proprietary-files-qc-64.txt
printf '\n%s\n' "\$(call inherit-product, vendor/qcom/binaries/msm8916-64/graphics/graphics-vendor.mk)" >> "$PRODUCTMK"

echo "endif" >> "$PRODUCTMK"
echo "endif" >> "$ANDROIDMK"

echo "endif" >> "$PRODUCTMK"
echo "endif" >> "$ANDROIDMK"

# We are done with common
write_footers

# Check if there is a variant list
VARIANT_LIST="$CM_ROOT"/device/"$VENDOR"/"$DEVICE"/proprietary-files.txt
if [ ! -f "$VARIANT_LIST" ]; then
    echo "$DEVICE does not have any variant specific blobs"
else

# Reinitialize the helper for device
setup_vendor "$DEVICE" "$VENDOR" "$CM_ROOT"

# Copyright headers and guards
write_headers

write_makefiles "$MY_DIR"/../$DEVICE/proprietary-files.txt
write_makefiles "$MY_DIR"/../$DEVICE/proprietary-files-64.txt

# We are done with device
write_footers

fi

#!/bin/bash
#
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 1.复制自定义DTS
cp -f "${GITHUB_WORKSPACE}/adslr_g7.dts" target/linux/ramips/dts/

# 2.注册新设备到 mt7621.mk
cat >> target/linux/ramips/image/mt7621.mk << 'EOF'

define Device/adslr_g7
  DEVICE_VENDOR := ADSLR
  DEVICE_MODEL := G7
  DEVICE_DTS := adslr_g7
  DEVICE_PACKAGES := kmod-mt7603 kmod-mt7612e kmod-mt76x2
  SUPPORTED_DEVICES := adslr_g7
  USE_FIT := 0
  KERNEL_LOADADDR := 0x80001000
  IMAGE_SIZE := 15040k
endef
TARGET_DEVICES += adslr_g7
EOF

# 3.为设备 adslr_g7 启用 lzma-loader，修复 LZMA ERROR 1 问题
sed -i '/^define Device\/adslr_g7$/,/^endef$/ s/^\([[:space:]]*\)DEVICE_VENDOR/\1$(Device\/uimage-lzma-loader)\n&/' target/linux/ramips/image/mt7621.mk

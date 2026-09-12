#!/bin/bash
#
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 复制 DTS 到源码目录
cp -f "${GITHUB_WORKSPACE}/adslr_g7.dts" target/linux/ramips/dts/

# 追加 ADSLR G7 设备定义到 mt7621.mk
cat >> target/linux/ramips/image/mt7621.mk << 'EOF'

define Device/adslr_g7
  DEVICE_VENDOR := ADSLR
  DEVICE_MODEL := G7
  DEVICE_DTS := adslr_g7
  DEVICE_PACKAGES := kmod-mt7615e kmod-mt7615-firmware kmod-mt76-core kmod-mt76-connac
  SUPPORTED_DEVICES := adslr_g7
  USE_FIT := 0
  KERNEL_LOADADDR := 0x80001000
  KERNEL := kernel-bin | append-dtb | lzma-loader | uImage none
  KERNEL_INITRAMFS := kernel-bin | append-dtb | lzma-loader | uImage none
  IMAGE/sysupgrade.bin := append-kernel | append-rootfs | pad-rootfs | append-metadata
endef
TARGET_DEVICES += adslr_g7
EOF

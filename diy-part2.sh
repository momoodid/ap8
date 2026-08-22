#!/bin/bash

cp -f "${GITHUB_WORKSPACE}/adslr_g7.dts" target/linux/ramips/dts/

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
  DEVICE_CMDLINE := console=ttyS0,57600 root=/dev/mtdblock4 rootfstype=squashfs,jffs2
  KERNEL := kernel-bin | append-dtb | lzma-loader | uImage none
  KERNEL_INITRAMFS := kernel-bin | append-dtb | lzma-loader | uImage none
  IMAGE/sysupgrade.bin := append-kernel | append-rootfs | pad-rootfs | append-metadata
endef
TARGET_DEVICES += adslr_g7
EOF


rm -rf build_dir/target-mipsel_24kc_musl/luci-base

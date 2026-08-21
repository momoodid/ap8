#!/bin/bash
git checkout openwrt‑23.05
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
# Add a feed source
echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

#复制自定义DTS到源码dts目录
cp -f "${GITHUB_WORKSPACE}/mt7621-adslr-g7.dts" openwrt/target/linux/ramips/dts/

# 在mt7621.mk注册我们的硬件设备
cat >> openwrt/target/linux/ramips/image/mt7621.mk <<'EOF'
define Device/mt7621-adslr-g7
  DEVICE_VENDOR := ADSLR
  DEVICE_MODEL := G7
  DEVICE_DTS := mt7621-adslr-g7
  DEVICE_PACKAGES := kmod-mt7603 kmod-mt7612e kmod-mt76x2
  SUPPORTED_DEVICES := mt7621-adslr-g7
endef
TARGET_DEVICES += mt7621-adslr-g7
EOF

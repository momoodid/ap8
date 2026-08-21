#!/bin/bash
#
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 1.复制自定义DTS（你的分区已经在dts内写好，dts文件放在github仓库根目录）
cp -f "${GITHUB_WORKSPACE}/mt7621-adslr-g7.dts" target/linux/ramips/dts/

# 2.注册新设备到 mt7621.mk
# USE_FIT:=0 关闭FIT .itb镜像，老U‑Boot 1.1.3只识别legacy uImage
# KERNEL_LOADADDR 严格匹配uboot fileaddr 0x80100000
cat >> target/linux/ramips/image/mt7621.mk <<'EOF'
define Device/mt7621-adslr-g7
  DEVICE_VENDOR := ADSLR
  DEVICE_MODEL := G7
  DEVICE_DTS := mt7621-adslr-g7
  DEVICE_PACKAGES := kmod-mt7603 kmod-mt7612e kmod-mt76x2
  SUPPORTED_DEVICES := mt7621-adslr-g7
  USE_FIT := 0
  KERNEL_LOADADDR := 0x80100000
endef
TARGET_DEVICES += mt7621-adslr-g7
EOF

### 可选修改，不需要就整行注释掉 ###
# 修改默认管理IP
#sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate
# 修改主机名
#sed -i 's/OpenWrt/ADSLR‑G7/g' package/base-files/files/bin/config_generate

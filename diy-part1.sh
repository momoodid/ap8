#!/bin/bash
#
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# 添加 helloworld feed（代理插件）
echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default

# 如果 GitHub 拉取慢，可以取消下面这行的注释，用镜像加速
# sed -i 's/github.com/ghproxy.com\/https:\/\/github.com/g' feeds.conf.default

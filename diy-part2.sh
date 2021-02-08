#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
#移除argon主题
rm -rf package/lean/luci-theme-argon
#移除v2ray等
rm -rf ./package/lean/dns2socks
rm -rf ./package/lean/ipt2socks
rm -rf ./package/lean/kcptun
rm -rf ./package/lean/microsocks
rm -rf ./package/lean/shadowsocksr-libev
rm -rf ./package/lean/simple-obfs
rm -rf ./package/lean/tcping
rm -rf ./package/lean/trojan
rm -rf ./package/lean/v2ray
rm -rf ./package/lean/v2ray-plugin

# 清除默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
#=================================================

#拉取软件仓
git clone https://github.com/waynesg/OpenWrt-Software.git package/OpenWrt-Software
find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-redir/shadowsocksr-libev-alt/g' {}
find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-server/shadowsocksr-libev-server/g' {}

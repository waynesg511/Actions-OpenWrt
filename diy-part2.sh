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

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
git clone https://github.com/kenzok8/openwrt-packages.git  package/openwrt-packages
git clone https://github.com/kenzok8/small.git  package/openwrt-small
# 获取luci-app-bypass
git clone https://github.com/garypang13/luci-app-bypass.git package/bypass
svn co https://github.com/garypang13/openwrt-packages/trunk/lua-maxminddb package/lua-maxminddb
svn co https://github.com/garypang13/openwrt-packages/trunk/smartdns package/smartdns
# 获取luci-app-dnsfilter
git clone https://github.com/garypang13/luci-app-dnsfilter.git package/dnsfilter
# 获取luci-app-dockerman
git clone https://github.com/lisaac/luci-app-dockerman.git package/dockerman
# 获取luci-app-serverchan
git clone https://github.com/tty228/luci-app-serverchan package/luci-app-serverchan
# 获取luci-app-poweroff
git clone https://github.com/waynesg/luci-app-poweroff.git package/poweroff
# 获取luci-app-pptp-server
git clone https://github.com/waynesg/luci-app-pptp-server.git package/pptp
# 获取luci-app-oaf
git clone https://github.com/destan19/OpenAppFilter.git package/oaf
# 获取luci-app-ipsec
# git clone https://github.com/waynesg/luci-app-ipsec-vpnserver-manyusers.git package/luci-app-ipsec-vpnserver-manyusers
# 获取luci-app-argon-config
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/argon-config
# 获取KoolProxyR Plus+
git clone https://github.com/godros/luci-app-godproxy.git package/godproxy
# 获取unblock网易音乐
git clone https://github.com/immortalwrt/luci-app-unblockneteasemusic.git package/unblockneteasemusic
# 获取高级设置
git clone https://github.com/sirpdboy/luci-app-advanced.git package/adv
# 获取自动关机
git clone https://github.com/sirpdboy/luci-app-autopoweroff.git package/autopwoff
# 获取opentopd主题
git clone https://github.com/sirpdboy/luci-theme-opentopd.git package/opentopd
# 获取vssr和依赖
# git clone https://github.com/jerrykuku/lua-maxminddb package/diy-packages/helloworld/lua-maxminddb
# git clone https://github.com/jerrykuku/luci-app-vssr package/diy-packages/helloworld/luci-app-vssr
# 清除默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
#=================================================
# 清除旧版argon主题并拉取最新版
pushd package/lean
rm -rf luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon luci-theme-argon
popd
#=================================================

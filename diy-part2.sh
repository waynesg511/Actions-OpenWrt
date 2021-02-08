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
# rm -rf package/lean/luci-theme-argon
#移除v2ray等
rm -rf /package/lean/dns2socks
rm -rf /package/lean/ipt2socks
rm -rf /package/lean/kcptun
rm -rf /package/lean/microsocks
rm -rf /package/lean/shadowsocksr-libev
rm -rf /package/lean/simple-obfs
rm -rf /package/lean/tcping
rm -rf /package/lean/trojan
rm -rf /package/lean/v2ray
rm -rf /package/lean/v2ray-plugin

# 清除默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
#=================================================
# 清除旧版argon主题并拉取最新版
pushd package/lean
rm -rf luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon luci-theme-argon
popd
#=================================================



# OpenAppFilter
svn co https://github.com/waynesg/OpenWrt-Software/trunk/OpenAppFilter package/wayne/OpenAppFilter
# Luci-App-Advanced
svn co https://github.com/waynesg/OpenWrt-Software/trunk/luci-app-advanced package/wayne/luci-app-advanced
# 自动关机
svn co https://github.com/waynesg/OpenWrt-Software/trunk/luci-app-autopoweroff package/wayne/luci-app-autopoweroff
# Bypass
svn co https://github.com/waynesg/OpenWrt-Software/trunk/luci-app-bypass package/wayne/luci-app-bypass
svn co https://github.com/waynesg/OpenWrt-Software/trunk/openwrt-passwall/tcping package/wayne/tcping
svn co https://github.com/garypang13/openwrt-packages/trunk/lua-maxminddb package/wayne/lua-maxminddb
svn co https://github.com/garypang13/openwrt-packages/trunk/smartdns package/wayne/smartdns
find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-redir/shadowsocksr-libev-alt/g' {}
find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-server/shadowsocksr-libev-server/g' {}
# Dnsfilter去广告
svn co https://github.com/waynesg/OpenWrt-Software/trunk/luci-app-dnsfilter package/wayne/luci-app-dnsfilter
# Dockerman
svn co https://github.com/waynesg/OpenWrt-Software/trunk/luci-app-dockerman package/wayne/luci-app-dockerman
# Godproxy去广告
svn co https://github.com/waynesg/OpenWrt-Software/trunk/luci-app-godproxy package/wayne/luci-app-godproxy
# PassWall
# svn co https://github.com/waynesg/OpenWrt-Software/trunk/openwrt-passwall package/wayne/openwrt-passwall
# Openclash
svn co https://github.com/waynesg/OpenWrt-Software/trunk/luci-app-openclash package/wayne/luci-app-openclash
# 关机脚本
svn co https://github.com/waynesg/OpenWrt-Software/trunk/luci-app-poweroff package/wayne/luci-app-poweroff
# PPTP
svn co https://github.com/waynesg/OpenWrt-Software/trunk/luci-app-pptp-server package/wayne/luci-app-pptp-server
# SERVER酱
svn co https://github.com/waynesg/OpenWrt-Software/trunk/luci-app-serverchan package/wayne/luci-app-serverchan
# 网易云音乐解锁
svn co https://github.com/waynesg/OpenWrt-Software/trunk/luci-app-unblockneteasemusic package/wayne/luci-app-unblockneteasemusic
# 单线融合IPTV
svn co https://github.com/waynesg/OpenWrt-Software/trunk/openwrt-iptvhelper package/wayne/openwrt-iptvhelper


# argon主题设置
svn co https://github.com/waynesg/OpenWrt-Software/trunk/luci-app-argon-config package/wayne/luci-app-argon-config
# opentopd主题
svn co https://github.com/waynesg/OpenWrt-Software/trunk/luci-theme-opentopd package/lean/luci-theme-opentopd















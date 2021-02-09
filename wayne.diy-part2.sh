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

# 修改openwrt登陆地址,把下面的192.168.2.2修改成你想要的就可以了
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate

# 修改主机名字，把OpenWrt-123修改你喜欢的就行（不能纯数字或者使用中文）
sed -i '/uci commit system/i\uci set system.@system[0].hostname='OpenWrt-xhh'' package/lean/default-settings/files/zzz-default-settings

# 版本号里显示一个自己的名字（281677160 build $(TZ=UTC-8 date "+%Y.%m.%d") @ 这些都是后增加的）
sed -i "s/OpenWrt /Reimu-LM build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

# 修改 argon 为默认主题,可根据你喜欢的修改成其他的（不选择那些会自动改变为默认主题的主题才有效果）
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings


# 修改内核版本
#sed -i 's/KERNEL_PATCHVER:=5.4/KERNEL_PATCHVER:=4.19/g' target/linux/x86/Makefile
#sed -i 's/KERNEL_TESTING_PATCHVER:=5.4/KERNEL_TESTING_PATCHVER:=4.19/g' target/linux/x86/Makefile

# 修改插件名字（修改名字后不知道会不会对插件功能有影响，自己多测试）
sed -i 's/"BaiduPCS Web"/"百度网盘"/g' package/lean/luci-app-baidupcs-web/luasrc/controller/baidupcs-web.lua
sed -i 's/cbi("qbittorrent"),_("qBittorrent")/cbi("qbittorrent"),_("BT下载")/g' package/lean/luci-app-qbittorrent/luasrc/controller/qbittorrent.lua
sed -i 's/"aMule设置"/"电驴下载"/g' package/lean/luci-app-amule/po/zh-cn/amule.po
sed -i 's/"网络存储"/"存储"/g' package/lean/luci-app-amule/po/zh-cn/amule.po
sed -i 's/"网络存储"/"存储"/g' package/lean/luci-app-vsftpd/po/zh-cn/vsftpd.po
sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' package/lean/luci-app-flowoffload/po/zh-cn/flowoffload.po
sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' package/lean/luci-app-sfe/po/zh-cn/sfe.po
sed -i 's/"实时流量监测"/"流量"/g' package/lean/luci-app-wrtbwmon/po/zh-cn/wrtbwmon.po
sed -i 's/"KMS 服务器"/"KMS激活"/g' package/lean/luci-app-vlmcsd/po/zh-cn/vlmcsd.zh-cn.po
#sed -i 's/"TTYD 终端"/"命令窗"/g' package/lean/luci-app-ttyd/po/zh-cn/terminal.po
sed -i 's/"USB 打印服务器"/"打印服务"/g' package/lean/luci-app-usb-printer/po/zh-cn/usb-printer.po
sed -i 's/"网络存储"/"存储"/g' package/lean/luci-app-usb-printer/po/zh-cn/usb-printer.po
sed -i 's/"Web 管理"/"Web"/g' package/lean/luci-app-webadmin/po/zh-cn/webadmin.po
#sed -i 's/"管理权"/"改密码"/g' feeds/luci/modules/luci-base/po/zh-cn/base.po
sed -i 's/"带宽监控"/"监视"/g' feeds/luci/applications/luci-app-nlbwmon/po/zh-cn/nlbwmon.po













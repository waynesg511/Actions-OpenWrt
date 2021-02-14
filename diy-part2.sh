# 版本号里显示一个自己的名字（281677160 build $(TZ=UTC-8 date "+%Y.%m.%d") @ 这些都是后增加的）
sed -i "s/OpenWrt /By @waynesg build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

git clone https://github.com/waynesg/OpenWrt-Software.git package/waynesg

# 修改 argon 为默认主题,可根据你喜欢的修改成其他的（不选择那些会自动改变为默认主题的主题才有效果）
pushd package/lean
rm -rf luci-theme-argon
popd
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

chmod 0755 /package/waynesg/luci-app-smartinfo/root/usr/lib/smartinfo/smart_status.sh
chmod 0755 /package/waynesg/luci-app-smartinfo/root/etc/init.d/smartinfo
chmod 0755 /package/waynesg/wrtbwmon/usr/sbin/wrtbwmon
chmod 0755 /package/waynesg/wrtbwmon/etc/init.d/wrtbwmon

find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-redir/shadowsocksr-libev-alt/g' {}
find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-server/shadowsocksr-libev-server/g' {}

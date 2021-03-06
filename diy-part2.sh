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

# 修改 argon 为默认主题,可根据你喜欢的修改成其他的（不选择那些会自动改变为默认主题的主题才有效果）
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify default IP
sed -i 's/192.168.1.1/192.168.5.2/g' package/base-files/files/bin/config_generate

# Add build date to index page
export orig_version="$(cat "package/lean/default-settings/files/zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')"
sed -i "s/${orig_version}/${orig_version} ($(date +"%Y-%m-%d"))/g" package/lean/default-settings/files/zzz-default-settings

# luci-app-cpufreq
#sed -i "s/@arm/@(arm||aarch64)/g" ./feeds/luci/applications/luci-app-cpufreq/Makefile
#sed -i "s/"services"/"system"/g" ./feeds/luci/applications/luci-app-cpufreq/luasrc/controller/cpufreq.lua
# Add cpufreq
#rm -rf ./feeds/luci/applications/luci-app-cpufreq 
#svn co https://github.com/immortalwrt/luci/trunk/applications/luci-app-cpufreq ./feeds/luci/applications/luci-app-cpufreq

# Add luci-theme-argon
rm -rf feeds/luci/themes/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config

# Add ServerChan
#git clone --depth=1 https://github.com/tty228/luci-app-serverchan feeds/luci/applications/luci-app-serverchan

# Add openclash
git clone --depth=1 -b master https://github.com/vernesong/OpenClash package/luci-app-openclash

# Add bypass
git clone --depth=1 https://github.com/kiddin9/openwrt-bypass.git package/luci-app-bypass

# Add subconverter
git clone --depth=1 https://github.com/tindy2013/openwrt-subconverter

# Add luci-app-dockerman
rm -rf feeds/luci/applications/luci-app-dockerman
git clone --depth=1 https://github.com/lisaac/luci-app-dockerman package/luci-app-dockerman

./scripts/feeds update -a
./scripts/feeds install -a

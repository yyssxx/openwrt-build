#!/bin/bash
#
# diy-part2.sh：在 feeds 安装后、编译前执行
# 用途：修改默认配置（IP、主机名、主题等）
#

# 修改默认管理 IP：192.168.1.1 -> 192.168.10.1（如需请取消注释）
# sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# 修改默认主机名
# sed -i 's/OpenWrt/MyRouter/g' package/base-files/files/bin/config_generate

# lean-lede 默认已带 Argon 主题，如需设为默认主题可取消注释
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

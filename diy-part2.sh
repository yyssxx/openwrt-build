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
# node：feed 默认编 v12，在新编译机上编不过，直接改成默认 v22

NODE_MK="feeds/packages/lang/node/Makefile"
if [ -f "$NODE_MK" ]; then
  sed -i 's/PKG_VERSION:=v12.22.12/PKG_VERSION:=v22.23.0/' "$NODE_MK"
  sed -i 's|PATCH_DIR:=./patches/v12.x|PATCH_DIR:=./patches/v22.x|' "$NODE_MK"
  sed -i 's/PKG_HASH:=bc42b7f8495b9bfc7f7850dd180bb02a5bdf139cc232b8c6f02a6967e20714f2/PKG_HASH:=3acfae100c7b855a4c76520ee0f95cadcace3f4254f16b7d4887f178fc95d4a0/' "$NODE_MK"
fi
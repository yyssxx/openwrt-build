#!/bin/bash
#
# diy-part2.sh：在 feeds 安装后、编译前执行
# 用途：修改默认配置（IP、主机名、主题等）
#

# 修改默认管理 IP：192.168.1.1 -> 192.168.10.1（本文件为 newifi-d2 专用版；AX3000T 用 .31.1，别混）
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# 修改默认主机名
# sed -i 's/OpenWrt/MyRouter/g' package/base-files/files/bin/config_generate

# lean-lede 默认已带 Argon 主题，如需设为默认主题可取消注释
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# node：feed 默认编 v12（2021 年古董），在新编译机（GCC 13）上编不过；
# 且版本选择 CONFIG_NODEJS_* 在 Kconfig 里没定义，.config 里指定无效，
# 这里直接把 Makefile 的默认版本改成 v22（LTS，能正常编译）
NODE_MK="feeds/packages/lang/node/Makefile"
if [ -f "$NODE_MK" ]; then
  sed -i 's/PKG_VERSION:=v12.22.12/PKG_VERSION:=v22.23.0/' "$NODE_MK"
  sed -i 's|PATCH_DIR:=./patches/v12.x|PATCH_DIR:=./patches/v22.x|' "$NODE_MK"
  sed -i 's/PKG_HASH:=bc42b7f8495b9bfc7f7850dd180bb02a5bdf139cc232b8c6f02a6967e20714f2/PKG_HASH:=3acfae100c7b855a4c76520ee0f95cadcace3f4254f16b7d4887f178fc95d4a0/' "$NODE_MK"
fi

# AX3000T 首刷文件 initramfs-factory.ubi：lede 的设备定义用的是老式 KERNEL_IN_UBI 写法，
# 缺官方 OpenWrt 那 5 行 ARTIFACTS 定义，所以永远编不出 factory.ubi（run 20、run 22 两次实证）。
# 这里照官方 filogic.mk 给 ax3000t 块补上（2026-11-06 Rio 备好，本地已在 lede 源码上验证插入正确）。
# 幂等：文件里已有就不动；只作用于 ax3000t 块，不影响其他设备。
FILOGIC_MK="target/linux/mediatek/image/filogic.mk"
if [ -f "$FILOGIC_MK" ] && ! awk '/^define Device\/xiaomi_mi-router-ax3000t$/,/^endef/' "$FILOGIC_MK" | grep -q 'initramfs-factory.ubi'; then
  awk '
    /^define Device\/xiaomi_mi-router-ax3000t$/ { inblk=1 }
    inblk && /IMAGE\/sysupgrade\.bin/ && !done {
      print "ifeq ($(IB),)"
      print "ifneq ($(CONFIG_TARGET_ROOTFS_INITRAMFS),)"
      print "  ARTIFACTS := initramfs-factory.ubi"
      print "  ARTIFACT/initramfs-factory.ubi := append-image-stage initramfs-kernel.bin | ubinize-kernel"
      print "endif"
      print "endif"
      done=1
    }
    { print }
    inblk && /^endef/ { inblk=0 }
  ' "$FILOGIC_MK" > "$FILOGIC_MK.tmp" && mv "$FILOGIC_MK.tmp" "$FILOGIC_MK"
fi

#!/bin/bash
#
# diy-part1.sh：在 feeds update 之前执行
# 用途：添加第三方 feed 源
#

# helloworld：ssr-plus、xray-core、hysteria、ipt2socks、naiveproxy、
# frpc/frps、nps、v2ray-server 等（.config 里大量包依赖此源，必须保留）
echo 'src-git helloworld https://github.com/fw876/helloworld' >> feeds.conf.default

# 示例：添加 OpenClash（去掉注释即启用）
# echo 'src-git openclash https://github.com/vernesong/OpenClash' >> feeds.conf.default

# OpenWrt 云编译（lean-lede）

用 GitHub Actions 编译 lean-lede 固件.

## 文件说明

| 文件 | 作用 |
|---|---|
| `.github/workflows/build-openwrt.yml` | 编译 workflow，定义全部步骤 |
| `.config` | 编译配置：目标设备 + 软件包 |
| `diy-part1.sh` | 加第三方 feed 源 |
| `diy-part2.sh` | 改默认配置：管理 IP、主机名等 |

## 换目标设备 / 加插件

- 改 `.config` 里 `CONFIG_TARGET_` 开头的三行（target），push 后重新 Run
- 加插件：先在 `diy-part1.sh` 里加 feed 源，再在 `.config` 里加 `CONFIG_PACKAGE_xxx=y`
- 常见插件 feed：OpenClash（`vernesong/OpenClash`）、helloworld（`fw876/helloworld`），diy-part1.sh 里有注释示例

## 说明
- 默认：192.168.10.1，root/password
- 源码地址：https://github.com/coolsnowwolf/lede
- 已加 helloworld feed（ssr-plus、xray 等依赖）
- 构建缓存了 dl 目录，改配置后重编会更快
- workflow 里有 SSH 调试开关（Run workflow 时填 true）

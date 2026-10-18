# OpenWrt 云编译（lean-lede）

用 GitHub Actions 云编译 lean-lede 固件.

## 使用方法

1. 在 GitHub 建一个**公开**仓库
2. 把目录所有文件 push 到仓库根目录
3. 打开 **Actions** 页面 → 左侧选 **Build OpenWrt (lean-lede)** → **Run workflow**

## 文件说明

| 文件 | 作用 |
|---|---|
| `.github/workflows/build-openwrt.yml` | 编译 workflow，定义全部步骤 |
| `.config` | 编译配置：目标设备 + 软件包，改这里换设备/加插件 |
| `diy-part1.sh` | 加第三方 feed 源（编译前） |
| `diy-part2.sh` | 改默认配置：管理 IP、主机名等 |

## 换目标设备 / 加插件

- 改 `.config` 里 `CONFIG_TARGET_` 开头的三行（target），push 后重新 Run
- 加插件：先在 `diy-part1.sh` 里加 feed 源，再在 `.config` 里加 `CONFIG_PACKAGE_xxx=y`
- 常见插件 feed：OpenClash（`vernesong/OpenClash`）、helloworld（`fw876/helloworld`），diy-part1.sh 里有注释示例

## 说明

- 源码地址：https://github.com/coolsnowwolf/lede
- 默认 target：ramips/mt7621，设备 d-team_newifi-d2（Newifi D2）
- 已加 helloworld feed（ssr-plus、xray 等依赖）
- 已加 USB 网络共享：安卓 RNDIS/CDC + 苹果 ipheth/usbmuxd
- 构建缓存了 dl 目录，改配置后重编会快很多
- workflow 里有个 SSH 调试开关（Run workflow 时填 true）

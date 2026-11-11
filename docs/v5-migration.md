# Noctalia v4 → v5 迁移交接

> 生成时间：2026-11-11
> 当前系统：已回滚到 generation 336（`26.11.20260919.20b1ddd`，Qt 6.11，v4 shell 正常）。
> 新的 generation 337（`26.11.20261101.4ef6f0e`，Qt 6.12，v4 shell 坏）仍在，但**不要用**。

## 1. 一句话现状

v4 在 Qt 6.12 下被 Qt 内置的 `QtQuick/Color` 单例遮蔽，界面全黑/无主题色；v4 已停止维护，没有上游修复。
已回滚到旧 generation 保证可用。下一步是迁移到 v5（`noctalia-dev/noctalia-shell` 的 `main` 分支，原生 C++/Qt，和 v4 是两套东西）。

## 2. 根因（别再踩）

Qt 6.12 在 `QtQuick` 里新增了内置单例 `QtQuick/Color`（C++ 类型 `QQuickColor`）。Noctalia v4 自己的主题单例也叫 `Color`（`Commons/Color.qml`，通过 `import qs.Commons` 加载），QML 名称解析让内置类型胜出，于是：

- `Color.mPrimary` 等属性全部 `undefined` → 满屏 `Unable to assign [undefined] to QColor`
- `Color.smartAlpha(...)` / `Color.resolveColorKey(...)` → `Property '...' of object QQuickColor(...) is not a function`

参考：

- Qt 文档：<https://doc.qt.io/qt-6/qml-qtquick-color.html>
- omarchy 同类 issue：#15069、#15090、#15134、#15879（都是同一根因）

**v4 不会修复**（legacy-v4 已于 2026-08-29 标记 unsupported）。

## 3. 机器 / 仓库当前状态

### 系统

| 项 | 值 |
|---|---|
| 当前 generation | 336（旧，可用） |
| 新 generation | 337（Qt 6.12 + v4，坏） |
| 回滚命令 | `sudo nixos-rebuild switch --rollback` |
| 临时文件 | `~/.config/nix/nix.conf` 还在（历史遗留的 substituters 覆盖） |

### `~/nix` 关键配置

| 文件 | 状态 |
|---|---|
| [flake.nix](../flake.nix) | `noctalia` input 仍指向 `.../legacy-v4`；`niri-flake` 的 `niri-unstable` 已跟随上游 `niri-wm/niri`（`7f81a7f7`，含 PR #4711）；nixpkgs 锁在 `4ef6f0e7`（11-01，Qt 6.12.0） |
| [home/Pulsar/desktop/noctalia.nix](../home/Pulsar/desktop/noctalia.nix) | v4 的 `programs.noctalia-shell`；含给 quickshell 打 Qt 6.12 编译补丁的 `package` override；`settings` 指向 `assets/noctalia-config.json`；还有一堆插件 sourceUrl |
| [pkgs/noctalia-qs/qt612.patch](../pkgs/noctalia-qs/qt612.patch) | 已 `git add`（未 commit）：v4 的 quickshell 在 Qt 6.12 下的 MOC 编译补丁；**v5 不需要** |
| [system/desktop/fonts.nix](../system/desktop/fonts.nix) | noto static + poppler 定向 pin（与 v5 无关，保留即可） |
| [flake.lock](../flake.lock) | nixpkgs `4ef6f0e7`；niri-unstable `7f81a7f7`；noctalia `f6c7c01` |

### 仓库外的改动

| 对象 | 状态 |
|---|---|
| `~/Projects/niri` | 本地 `main` 已 reset 到 upstream `7f81a7f7`（含 PR #4711），**未 push**；origin 仍是旧 `11ee7a60`。已不需要 fork |
| `~/Projects/pulsar-ns-plugins` | `ScreenShotNiri.qml` 已改为读 `niri msg -j windows` 的 `tile_pos_in_workspace_view`，commit `51012ab` 已 push；**这是 v4 插件，v5 不适用** |
| 已安装插件副本 | `~/.config/noctalia/plugins/f4c24d:screen-shot-and-record/ScreenShotNiri.qml` 已更新；回滚到旧 niri 后窗口选择会失效 |
| `~/Projects/noctalia-qs` | 本地 patched 仓库，v5 后可以删 |

### 未提交的改动

`git status` 里 `flake.nix` / `flake.lock` / `fonts.nix` / `noctalia.nix` 等是 `MM`（部分已暂存、部分未暂存），另有大量之前暂存的 Nix 配置和 BenBen 光标资源。提交由你自己做。

## 4. v5 事实清单（已核实）

- 仓库：`github:noctalia-dev/noctalia-shell`，**默认分支 `main` 就是 v5**（最近提交 2026-11-10）。
- 形态：原生 **C++/Qt（meson）**，可执行文件叫 `noctalia`；**不再使用 quickshell / noctalia-qs**。
- Nix package：`noctalia`；HM 模块：`programs.noctalia`；NixOS 模块：`programs.noctalia`（含 `systemd.enable` / `systemd.target`）。
- 配置：**TOML**，读 `~/.config/noctalia/*.toml`（按文件名排序合并），app 自管状态在 `~/.local/state/noctalia/settings.toml`。
- **v4 的 `settings.json` 不会迁移到 v5**（官方 FAQ 明确：v5 是 fresh install，不是自动升级）。
- v4 和 v5 可以共存：包名/可执行文件/配置文件名都不同，互不冲突；切哪个由 compositor 键位决定。
- 插件 API 变了：v5 用带 `plugin_api` 兼容声明的插件（见 v5 仓库 `docs/plugin-api.json`），v4 的 QML 插件不能直接复用。
- 当前 v5 版本线是 `v5.0.0-beta.x`，配置项仍可能变。

## 5. 推荐迁移路径（先并行，再切换）

### Step 0：先把当前状态提交/建分支

```bash
cd ~/nix
git add -A
git commit -m "wip: v4 rollback state before noctalia v5 migration"
```

### Step 1：加 v5 input，和 v4 并存

```nix
# flake.nix
noctalia-v4 = {
  url = "github:noctalia-dev/noctalia-shell/legacy-v4";
  inputs.nixpkgs.follows = "nixpkgs";
};
noctalia = {
  url = "github:noctalia-dev/noctalia-shell";   # main = v5
  inputs.nixpkgs.follows = "nixpkgs";
};
```

保留现有 `inputs.noctalia-v4.homeModules.default` 和 `programs.noctalia-shell`（v4），新增：

```nix
imports = [ inputs.noctalia.homeModules.default ];

programs.noctalia = {
  enable = true;
  # settings 是 TOML attrset，写法见 v5 文档；先留默认也行
  settings = { };
};
```

注意两个 shell 同时 enable 会抢 bar/键位。并行期建议只让一个跑（比如先 `programs.noctalia-shell.enable = false`，手动跑 `noctalia` 验证；或者反过来）。

### Step 2：构建 + 试跑 v5

```bash
nix flake lock
nh os build
# 先不要 switch；构建产物里直接试跑 v5：
# nix run 或从 build 结果里运行 noctalia
```

重点验证：

- 日志里不再出现 `QQuickColor` / `smartAlpha` 相关错误
- bar/面板有主题色
- 快捷键能打开 launcher / 控制中心
- niri 相关功能正常（v5 直接走 niri IPC，不再需要我们的 fork / PR #4711 插件）

### Step 3：迁移配置（v4 JSON → v5 TOML）

- v4 配置在 `home/assets/noctalia-config.json`（很长），**不能直接复用**。
- v5 文档：<https://docs.noctalia.dev>（v5 仓库 `docs/user/configuration/`）
- 推荐先用 `programs.noctalia.settings = { }` + GUI 配一遍，再把关键项写回 Nix。
- `programs.noctalia.checkConfig = true`（默认）会在构建时校验 TOML。
- 自定义调色板用 `programs.noctalia.customPalettes`。

### Step 4：插件与截图

- v4 插件（`pulsar-ns-plugins` 里的 `ScreenShot & Record`、keybind-cheatsheet 等）是 QML + `qs.Commons`，**v5 不能用**。
- 先看 v5 是否内置了截图/键位提示；没有再决定是否按 v5 插件 API 重写。
- 我们为 v4 做的 `niri msg windows` 适配只对 v4 插件有意义，v5 阶段可以不管。

### Step 5：删除 v4 相关

确认 v5 稳定后：

1. `flake.nix` 删掉 `noctalia-v4` input，`noctalia` 保留 main。
2. `home/Pulsar/desktop/noctalia.nix` 整体替换为 v5 的 `programs.noctalia` 配置。
3. 删除 `pkgs/noctalia-qs/` 和 `noctalia.nix` 里的 `package = ... quickshell ...` override。
4. 删掉根 `quickshell` input（本来就没用了）。
5. `flake.lock` 重新 lock。
6. 可选：`~/Projects/noctalia-qs`、`~/Projects/pulsar-ns-plugins` 里的 v4 插件归档。

### Step 6：收尾

```bash
rm ~/.config/nix/nix.conf        # 临时 substituters 覆盖
nix profile remove dsh ffmpeg mpvpaper ruff splayer-next
sudo nix-collect-garbage -d
```

## 6. 已知坑 / 注意事项

- **不要在 v4 + nixpkgs 11-01 上跑 `nh os switch`**：Qt 6.12 会把 v4 打回黑屏。
- **不要全量 `nix flake update`**：nixpkgs 11-01 是特意选的（opencode 2.2.1 / splayer / fastfetch / KDE 都有缓存）；换到 11-07 会多出一堆本地构建。
- v5 构建若在 nixpkgs 11-01 上失败（C++/Qt 版本偏旧），再考虑 bump nixpkgs；届时缓存收益会变，先算一遍 dry-run。
- v5 是 beta，配置键可能变；别把 v4 的 JSON 键名硬套。
- 当前 niri 已上游 `7f81a7f7`（PR #4711），v4 插件用它；v5 是否用同一字段待确认。
- `~/.config/nix/nix.conf` 在旧 generation 下也生效，最终记得删。

## 7. 回滚 / 排错

```bash
# 回旧系统（当前就是这个）
sudo nixos-rebuild switch --rollback

# 明确切到 336
sudo nix-env --profile /nix/var/nix/profiles/system --set /nix/var/nix/profiles/system-336-link
sudo /nix/var/nix/profiles/system-336-link/bin/switch-to-configuration switch
```

v5 构建/运行失败时优先看：

- `journalctl --user -u noctalia`（v5 systemd user service）
- `~/.local/state/noctalia/` 下的日志/状态
- v5 仓库 `docs/user/` 与 `BUILDING.md`

## 8. 参考资料

- v5 仓库：<https://github.com/noctalia-dev/noctalia-shell>（main）
- v5 文档：<https://docs.noctalia.dev>
- v4 FAQ（明确不自动升级）：v5 仓库 `docs/user/getting-started/faq.mdx`
- Qt `Color` 单例文档：<https://doc.qt.io/qt-6/qml-qtquick-color.html>
- omarchy 同类问题：#15069 / #15090 / #15134 / #15879
- niri PR #4711（`tile_pos_in_workspace_view`）：<https://github.com/niri-wm/niri/pull/4711>

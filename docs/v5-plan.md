# Noctalia v4 → v5 迁移执行计划

> 编写时间：2026-11-11
> 目标版本：Noctalia **5.4.1**（`noctalia-dev/noctalia`，`main` == `cachix` == `03d144e`）
> 前提：当前系统仍停在 generation 336（Qt 6.11 + v4 可用）；337 不要用。
> 规则：每个阶段结束后停手，产出 diff / 验证结果，**commit 需要你逐次授权**。

## 0. 目标与不变量

**目标状态**

- 合成器仍是 niri，shell 换成 v5（原生 C++/Qt，不再有 quickshell）。
- v5 配置的真相源是仓库里的一个 TOML 文件，经 home-manager 落到 `~/.config/noctalia/config.toml`；
  GUI 的临时改动落在 `~/.local/state/noctalia/settings.toml`（覆盖层），随时可删。
- 插件只留：内置 polkit agent、内置 `privacy` 组件、`pulsar/screen-shot-and-record`（自研 port）、
  `noctalia/timer`、`thepunkoff/pomodoro`。不装 keybind-cheatsheet、不装 github-feed、nix-monitor 关闭。
- 外挂二进制（`screenshot-overlay` 及截图依赖）进 `pkgs/`，由 HM 安装，不再靠系统里散装的工具。

**不变量**

- 迁移期间 v4 随时可回：`noctalia-shell` 包和 v4 配置在 Phase 5 之前不删。
- 不改 nixpkgs pin（`4ef6f0e7`，里面有 noctalia 5.4.1），避免多出一堆本地构建。
- 不跑 `nix flake update` 全量更新。
- 每一阶段可单独回滚，回滚点写在 §5。

## 1. 决策清单

| # | 决策 | 结论 | 影响 |
|---|---|---|---|
| D1 | keybind-cheatsheet | **不要**（`kenn/keybind-cheatsheet` 也不装） | niri `Mod+Slash` 绑定删除；v4 fork 的 PR #4711 适配可归档 |
| D2 | github-feed | **不要** | v5 无对应，enabled 列表里不出现 |
| D3 | nix-monitor | **关闭** | 从 `[plugins].enabled` 移除，并让 GUI 写一次 state 关闭 |
| D4 | screen_recorder vs SSR 录制 | **待定**，默认留 SSR、去 `noctalia/screen_recorder` | 两者都做录制；删一个 widget + 一个插件 |
| D5 | todo | **待定**，默认先不装 | 要装则用 `nightwatch75/todo`，v4 数据不通用 |
| D6 | 壁纸 | 解 pin，交回声明式 | `settings.toml` 里 `wallpaper.default/last/monitors` 三条删除 |
| D7 | niri `config.kdl` | **待定**，默认先原地改，之后收进仓库 | 目前 `~/.config/niri/` 不受 HM 管理，迁进仓库是独立小任务 |
| D8 | v4 input 保留期 | 保留到 v5 稳定一周，再删 | Phase 5 只改名成 `noctalia-v4`，不删 |

## 2. 阶段

### Phase 0 — 存档（✅ 2026-11-11 完成）

- [x] 记录现状：system = 336（`26.11.20260919.20b1ddd`），337 是坏的 Qt 6.12 那一代。
      `nix-env --list-generations` 需要 system.lock 权限，改用
      `ls -l /nix/var/nix/profiles/system-*-link`
- [x] 备份 v5 覆盖层与状态 → `~/noctalia-v5-state-backup-2026-11-11/`
      （另含 `config-export-merged.toml`、`plugins-list.txt`、`README.txt` 元数据）
- [x] 备份 niri → `~/niri-config-backup-2026-11-11.kdl`
- [x] 确认 336 / 337 两个 generation link 都在，336 为当前

**完成判据**：备份文件存在，336 仍是当前 generation。（已满足）

**Phase 0 顺带确认的事实**

- profile 里的 v5 是 `noctalia 5.4.1`，正在运行，`noctalia msg` 可用。
- `noctalia msg plugins list` 证实 `pulsar/screenshot-overlay` 不存在于任何来源，
  只有 `pulsar/screen-shot-and-record [ssr-dev]`。
- `noctalia config export` 会把 v4 遗留的 `~/.config/noctalia/user-templates.toml`
  一起合并进来（`[templates.hyprland]` / `[templates.hyprlock]`），Phase 2 要先挪走它。

### Phase 1 — 临时试用 v5（✅ 已完成）

v5 已装进 profile 并在跑，版本与目标一致：

```bash
# 已执行（记录用）
nix profile install \
  --option extra-substituters https://noctalia.cachix.org \
  --option extra-trusted-public-keys 'noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=' \
  'github:noctalia-dev/noctalia/cachix'
```

- [x] `~/.nix-profile/bin/noctalia` → `/nix/store/cmlsxk9…-noctalia-5.4.1/bin/noctalia`
- [x] 在 niri 会话下可用（bar、面板、IPC 均可用）
- [x] `noctalia msg plugins list` 能列出 official / community / ssr-dev 三个来源

**回滚**：`nix profile remove noctalia`，`pkill noctalia`，重新 `noctalia-shell`。

### Phase 2 — 把 v5 配置从 state 迁到仓库（✅ 2026-11-11 执行）

实际执行的步骤：

- [x] 删掉 v4 的 HM 软链：`~/.config/noctalia/{settings.json,plugins.json,templates,user-templates.toml}`
- [x] `noctalia config export` → `/tmp/n5-export.toml`（此时已无 `[templates.*]` 噪音）
- [x] 修剪：
      - `[plugins].enabled` 去掉 `pulsar/screenshot-overlay`（不存在的 id）和 `avivbintangaringga/nix-monitor`（D3）
      - 加 `auto_update = "none"`
      - 删 `[wallpaper.last]`、`[wallpaper.monitors.eDP-1]`，只留声明式的 `[wallpaper.default]`
- [x] 补 v4 行为：`[accessibility] ui_scale=0.95`、`[shell] font_family`、`[weather]`、`[nightlight]`、
      `[idle.behavior.*]`（300/600/900，fade 5s）、`[keybinds]`、
      `[theme.templates]`（gtk3/gtk4/qt/kcolorscheme/kitty + pywalfox）
- [x] `[plugin_settings."pulsar/screen-shot-and-record"]`：关通知，对齐 v4
- [x] `noctalia config validate` → 0 error / 0 warning
- [x] 落盘 `~/.config/noctalia/config.toml`，`settings.toml` → `settings.toml.bak`
- [x] 校验：导出结果与新文件 TOML 语义等价；live `config validate` 通过
- [x] 仓库副本：`home/Pulsar/assets/noctalia/config.toml`
- [x] 清掉 `~/.config/noctalia/` 里 v4 GUI 残留（`colors.json`、`colorschemes/`、`plugins/`），
      移入 `~/noctalia-v5-state-backup-2026-11-11/v4-config-leftovers/`；配置目录只剩 `config.toml`

与最初计划的差异

- **bar 一行没动**：v4 的 bar 样式不迁移（新 bar 是你重做的），`[bar.*]` 原样保留。
- **privacy 组件**：按你的要求放到 `bar.default` 的 start 最左侧，配置随 `[widget.privacy]` 一起声明。
- **ssr-dev 源暂时保留**：P5 之前删掉会让截图插件直接失效，绝对路径留到 P5 换成 `xdg.dataFile`。
- **timer / pomodoro 没启用**：新 bar 里没有它们的组件，等要用时再开。
- **desktop_widgets 没迁**：v4 的桌面时钟是坐标式的，建议 GUI 摆好后重新导出。

**完成判据**：`settings.toml` 不存在时行为不变 —— 已满足（待你目视确认 bar 正常）。

**回滚**：`mv ~/.local/state/noctalia/settings.toml.bak ~/.local/state/noctalia/settings.toml`，删 `~/.config/noctalia/config.toml`。

### Phase 3 — niri 接线（✅ 2026-11-11 执行）

文件：`~/.config/niri/config.kdl`（仍未进仓库，D7 待定）。备份：
`~/niri-config-backup-2026-11-11-0858.kdl`。

- [x] 33 处 `noctalia-shell ipc call ...` 全部换成 `noctalia msg ...`，`grep noctalia-shell` 归零
- [x] 特殊项：`bar toggle` → `bar-toggle`、`settings toggle` → `settings-toggle`、
      `plugin:screen-shot-and-record screenshot` → `screenshot-region`、
      重启 shell → `config-reload`、emoji → `panel-toggle launcher /emo`
- [x] 删除 `Mod+Slash`（keybind-cheatsheet，D1）
- [x] `spawn-at-startup "noctalia-shell"` → `"noctalia"`；lid-close → `spawn "noctalia" "msg" "session" "lock"`
- [x] 删掉 `NOCTALIA_PAM_SERVICE "noctalia-shell"`（v5 不读，锁屏走 `login` 栈）
- [x] `niri validate -c ~/.config/niri/config.kdl` → valid；`noctalia msg config-reload` → ok

**回滚**：`cp ~/niri-config-backup-2026-11-11-0858.kdl ~/.config/niri/config.kdl`。

### Phase 4 — Nix 声明式接管（✅ 2026-11-11 执行）

- [x] `home/Pulsar/desktop/noctalia.nix` 换成 HM 内置 `programs.noctalia`（154 → 17 行）：
      `settings = ../assets/noctalia/config.toml`、`checkConfig = true`
- [x] 删掉 v4 残留：模块 import、quickshell 的 package override、`user-templates` + `templates` 目录、
      `plugins` / `pluginSettings` 整段
- [x] `system/hardware/default.nix`：删掉 `security.pam.services.noctalia-shell`
- [x] `git add` 了 `config.toml`（flake 只看得见被 git 跟踪的文件，未跟踪会直接 eval 失败）
- [x] `nh os build` 通过，构建期 `noctalia config validate` 通过
- [x] 已 switch：`~/.config/noctalia/config.toml` 变成 store 软链，旧文件被 HM 备份为 `config.toml.bak`；
      v4 的 `settings.json` / `plugins.json` / `user-templates.toml` / `templates/` 已清除
- [x] profile 清理：`noctalia`、`niri-unstable` 移除（现在分别来自 HM 与系统，版本一致），
      只留 `screenshot-overlay`（P5 之前插件还依赖它）

**代价**：`config.toml` 是只读软链，改配置要改仓库再 rebuild；GUI 改动仍写 state 层。

**回滚**：`sudo nixos-rebuild switch --rollback`（回 336，v4 的文件会被放回去）。

### Phase 5 — 插件与二进制打包（2-3h）

- [ ] `pkgs/screenshot-overlay/`：从 `~/Projects/pulsar-ns-plugins/ssr-overlay-demo` 搬 crate，
      保留 `Cargo.lock`，用 `rustPlatform.buildRustPackage`（原 flake 已有可参考的 derivation）
- [ ] `pkgs/pulsar-plugins/screen-shot-and-record/`：搬插件目录（`plugin.toml` + `*.luau` + `lib/` + `translations/`）
- [ ] HM 安装运行时依赖：
      ```nix
      home.packages = [ screenshot-overlay wl-clipboard tesseract curl jq wf-recorder swappy ];
      ```
- [ ] 用 HM 的 `xdg.dataFile` 投放，让 v5 当**内置 local 源**发现（避免 path source 需要绝对路径 / 无法在静态 TOML 里插值）：
      ```nix
      xdg.dataFile."noctalia/plugins/screen-shot-and-record".source =
        ../assets/noctalia/plugins/screen-shot-and-record;
      ```
      插件仍需在 `[plugins].enabled` 里显式启用（`pulsar/screen-shot-and-record`），id 来自 manifest 与来源无关。
      > 备选：若确实要声明 `kind = "path"` 的源，`settings` 就不能是静态 path，得改成 Nix attrset 或
      > `pkgs.writeText` 生成的配置，才能把 store 路径插进去。
- [ ] 验证：`noctalia msg plugins list` 中 SSR 为 enabled；`noctalia msg screenshot-region` 能出 overlay；
      `noctalia msg plugins disable avivbintangaringga/nix-monitor`（D3 落到 state）
- [ ] D4 定案后删掉多余的一个 widget（`[widget.recorder]` 或 `[widget.widget_2]`）

**回滚**：删 `pkgs/` 下两个新目录，config 里 source 改回绝对路径。

### Phase 6 — 收尾（1h）

- [ ] 稳定一周后：删 `noctalia-v4` input、`pkgs/noctalia-qs/`、`home/Pulsar/assets/noctalia-config.json`
- [ ] 删除 `~/.config/nix/nix.conf`（临时 substituters 覆盖）
- [ ] `nix profile remove noctalia`（改用声明式后不再需要）
- [ ] `nix-collect-garbage -d`（先确认 336 之外还有可用 generation）
- [ ] 归档 `~/Projects/noctalia-qs`、`~/Projects/pulsar-ns-plugins`（v4 分支打 tag）
- [ ] 更新或替换 `docs/v5-migration.md`，把本计划的结论并进去

## 3. v4 → v5 配置补全清单（Phase 2 用）

| v4 项 | v4 值 | v5 写法 |
|---|---|---|
| `idle` 300/600/900s | 熄屏/锁屏/挂起 | `[idle.behavior.screen-off] timeout=300 action="screen_off" enabled=true` 等三条 |
| `nightLight` | 6000/6500K 自动 | `[nightlight] enabled=true temperature_day=6500 temperature_night=6000` |
| `scaleRatio` 0.95 | 全局缩放 | `[accessibility] ui_scale = 0.95` |
| `ui.fontDefault` | Noto Sans CJK SC Medium | `[shell] font_family = "Noto Sans CJK SC Medium"` |
| `location.name` / 天气 | Xi'an、特效开 | `[location] address="Xi'an"` + `[weather] enabled=true effects=true` |
| `templates.activeTemplates` | gtk/qt/kitty/kcolorscheme/pywalfox | `[theme.templates] builtin_ids = ["gtk-qt", "kitty", "niri"]`（先 `noctalia theme --list-templates` 核对 id） |
| `notifications.sounds.enabled=false` | 关声音 | `[audio] enable_sounds=false`（默认即关） |
| `desktopWidgets` 时钟 | eDP-1 数字钟 | `[desktop_widgets]` + `[widget.<name>]`（坐标式，先 GUI 摆好再导出） |
| `general.keybinds` | Up/Down/Enter 等 | `[keybinds]`（v5 名称不同，用 example.toml 对照） |

## 4. 验收清单

- [ ] 日志无 `QQuickColor` / `smartAlpha` / `Property ... is not a function`
- [ ] `noctalia config validate` → 0 error
- [ ] 锁屏：锁、密码解锁、指纹解锁、锁屏下音量/亮度可用
- [ ] idle：5 分钟熄屏、10 分钟锁屏、15 分钟挂起（按 v4 值）
- [ ] 主题：壁纸取色生效，gtk/qt/kitty 跟随，niri 边框跟随
- [ ] 插件：SSR 截图（区域/窗口/OCR/录制）、timer、pomodoro 可用；nix-monitor 不在列表
- [ ] niri：所有 `noctalia msg` 绑定实按通过，无残留 `noctalia-shell`
- [ ] Nix：`nh os build` 无 `checkConfig` 失败；`~/.config/noctalia/` 只有 `config.toml`

## 5. 回滚矩阵

| 阶段 | 回滚动作 | 代价 |
|---|---|---|
| 1 | `nix profile remove noctalia` + 重启 v4 | 分钟级 |
| 2 | 恢复 `settings.toml.bak`，删 `config.toml` | 分钟级 |
| 3 | 恢复 `config.kdl` 备份 + reload | 分钟级 |
| 4 | `nixos-rebuild switch --rollback` + `git checkout` | 一次 rebuild |
| 5 | 删新 `pkgs/` 目录，source 改回路径 | 分钟级 |
| 6 | 不可回滚（此时已稳定一周） | — |

## 6. 风险

- **v5 是 5.4.x，配置键仍可能变**（`config_version` 每次升级会迁移）；声明式配置的好处是 `config validate` 能在构建期抓到。
- **`checkConfig = true` 会让配置错误阻断 rebuild**；调试期可临时 `checkConfig = false`。
- **`[plugins].enabled` 会被 state 合并**：GUI 里关插件会写 state 覆盖，排查时先看 `settings.toml`。
- **path source 要求目录不可变**：指 store 路径最稳；指 `~/Projects` 会在 Nix 之外漂移。
- **HM 内置模块与 flake 模块同名**：只选一个，别同时 import（flake 模块会 `disabledModules` 掉内置的，混用会打架）。

# AGENTS.md — NixOS 配置仓库

## 仓库概况

单用户单机 NixOS flake（`x86_64-linux`），主机名 `NixOS-Pulsar`，用户 `Pulsar`。
使用 home-manager（stateVersion = "25.11"），默认 shell 为 zsh。

远程：`git@github.com:Pulsar33550336/nixos-dots.git`

## 关键命令

```bash
sudo nh os switch   # 构建并切换系统（nh 已预配 flake 路径）
nh os build         # 仅构建
nh home switch      # 构建并切换 home 配置
nh clean all --keep 5 --keep-since 3d   # 手动清理旧 generations（自动每周触发）
```

## 目录结构

```
flake.nix          # 入口：nixosSystem NixOS-Pulsar
system/            # NixOS 模块
  core/            #   boot, nix配置(USTC/清华镜像), ssh远程构建, sudo
  desktop/         #   Hyprland, KDE(sddm/plasma6), portal(KDE), cups, flatpak, fonts
  hardware/        #   硬件配置 + snapper(btrfs快照/home) + bluetooth
  network/         #   NetworkManager, firewall disabled
  i18n/            #   国际化 + fcitx5(rime-ice) + 字体 + 时区
  users/           #   Pulsar(zsh, networkmanager/wheel/podman组)
  packages/        #   按语言/用途拆分的包集合
home/              # home-manager 配置
  apps/            #   git, gpg, vscode, kitty, libreoffice, nh, 杂项包
  desktop/         #   hyprland, noctalia shell(~900行), env变量, fontconfig
  shell/           #   zsh
  assets/          #   dotfiles模板(hypr, noctalia, p10k, MacOS光标)
pkgs/              #   自定义包(pam-fprint-grosshack)
```

## 重要约定

- **`system/hardware/hardware-configuration.nix`** 由 `nixos-generate-config` 自动生成，在 `.gitignore` 中，不要手动修改
- **noctalia-shell**：完整的桌面 shell（bar、锁屏、控制中心、通知等），配置在 `home/desktop/noctalia.nix`（~900行）
- **Lua LSP** 需要 hyprland stubs，配在 `.luarc.json`，路径 `~/.local/share/hyprland-stubs`
- **Nix 格式化**：nixfmt
- **VSCode Nix LSP**：nixd，expr 指向 `(builtins.getFlake "/home/Pulsar/nix").nixosConfigurations.NixOS-Pulsar.options`
- **远程构建**：`server`（IPv6, port 2222, 24 jobs）
- **Git 签名**：key `2B867C4832784EE0`，默认签名提交
- **镜像源**优先使用 USTC/清华，其次 `cache.nixos.org`
- **allowUnfree = true`

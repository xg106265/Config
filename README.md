# dotfiles

个人 zsh 环境配置：oh-my-zsh + starship，通过软链接管理，多台 Mac 之间用 git 同步。

## 目录结构

```
.
├── install.sh            # 新机器一键安装入口
├── Brewfile              # .zshrc 依赖的命令行工具 (starship / trash / nvm / pyenv)
├── zsh/                  # -> ~/.zshrc, ~/.zshenv, ~/.zprofile
├── starship/             # -> ~/.config/starship.toml
├── omz/plugins.txt       # 第三方 oh-my-zsh 插件（名称 + git 地址）
└── scripts/
    ├── brew.sh           # 安装 Homebrew 及 Brewfile 中的工具
    ├── omz.sh            # 安装 oh-my-zsh 本体
    ├── plugins.sh        # 克隆 / 更新第三方插件
    ├── link.sh           # 把配置软链接到 $HOME（已有文件会先备份）
    └── sync.sh           # 拉取远端 + 提交并推送本地改动
```

## 新机器安装

```bash
git clone https://github.com/xg106265/dotfiles.git ~/Downloads/Config
~/Downloads/Config/install.sh
exec zsh
```

被覆盖的原有文件会备份到 `~/.dotfiles-backup/<时间戳>/`。

> Rust（`~/.cargo/env`）不在 Brewfile 中，需要的话单独用 rustup 安装。

## 日常同步

`~/.zshrc` 等文件是指向本仓库的软链接，直接编辑即可，然后：

```bash
~/Downloads/Config/scripts/sync.sh "可选的提交说明"
```

另一台机器上执行同一条命令即可拉取最新配置。

## 新增 oh-my-zsh 插件

1. 在 `omz/plugins.txt` 加一行 `名称  git地址`
2. 在 `zsh/.zshrc` 的 `plugins=(...)` 中加上名称
3. 执行 `scripts/plugins.sh`，再 `scripts/sync.sh`

## 仓库挪位置

软链接指向仓库的绝对路径。移动仓库目录后重新执行一次 `scripts/link.sh` 即可。

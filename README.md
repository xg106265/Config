# Config

个人软件配置集合（zsh / oh-my-zsh、starship、vim 等），通过软链接管理，多台 Mac 之间用 git 同步。

## 目录结构

```
.
├── install.sh            # 新机器一键安装入口
├── links.txt             # 软链接清单：仓库路径 -> $HOME 下的路径
├── Brewfile              # 配置依赖的命令行工具 (starship / trash / nvm / pyenv)
├── zsh/                  # .zshrc / .zshenv / .zprofile
├── starship/             # starship.toml
├── vim/                  # .vimrc / .ideavimrc (JetBrains IdeaVim)
├── omz/plugins.txt       # 第三方 oh-my-zsh 插件（名称 + git 地址）
└── scripts/
    ├── brew.sh           # 安装 Homebrew 及 Brewfile 中的工具
    ├── omz.sh            # 安装 oh-my-zsh 本体
    ├── plugins.sh        # 克隆 / 更新第三方插件
    ├── link.sh           # 按 links.txt 建软链接（已有文件会先备份）
    └── sync.sh           # 拉取远端 + 提交并推送本地改动
```

## 新机器安装

```bash
git clone https://github.com/xg106265/Config.git ~/Downloads/Config
~/Downloads/Config/install.sh
exec zsh
```

被覆盖的原有文件会备份到 `~/.dotfiles-backup/<时间戳>/`。

> Rust（`~/.cargo/env`）不在 Brewfile 中，需要的话单独用 rustup 安装。

## 日常同步

`$HOME` 下的配置文件都是指向本仓库的软链接，直接编辑即可，然后：

```bash
~/Downloads/Config/scripts/sync.sh "可选的提交说明"
```

另一台机器上执行同一条命令即可拉取最新配置；如果对方新增了配置文件，再执行一次 `scripts/link.sh`。

## 添加新软件的配置

1. 新建一个以软件命名的目录，把配置文件拷进去，例如 `git/.gitconfig`
2. 在 `links.txt` 加一行：`git/.gitconfig   .gitconfig`
3. 执行 `scripts/link.sh`（会自动备份原文件并建立软链接），再 `scripts/sync.sh`

如果软件依赖某个命令行工具，顺手加到 `Brewfile`。

## 新增 oh-my-zsh 插件

1. 在 `omz/plugins.txt` 加一行 `名称  git地址`
2. 在 `zsh/.zshrc` 的 `plugins=(...)` 中加上名称
3. 执行 `scripts/plugins.sh`，再 `scripts/sync.sh`

## 仓库挪位置

软链接指向仓库的绝对路径。移动仓库目录后重新执行一次 `scripts/link.sh` 即可。

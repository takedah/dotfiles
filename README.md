# dotfiles

## Description

macOS と Ubuntu で共用している開発環境の設定ファイル。

| | |
|---|---|
| シェル | bash（Ubuntu）/ zsh（macOS） |
| エディタ | Neovim + vim-plug + coc.nvim |
| ターミナル | tmux |
| ランタイム | mise 経由の Python / Node.js |

Ubuntu 側は [takedah/ubuntu_playbooks](https://github.com/takedah/ubuntu_playbooks) が
このリポジトリを clone してリンクを張るので、手作業での設定は不要。

## Files

| ファイル | 対象 | 内容 |
|---|---|---|
| `.profile` | Ubuntu | PATH（mise shims / `~/.local/bin`）、PS1、XDG 変数 |
| `.bashrc` | Ubuntu | 対話シェル設定、`mise activate bash` |
| `.bash_profile` | Ubuntu | `.profile` と `.bashrc` の読み込み |
| `.bash_aliases` | Ubuntu | ls の色付け、`ll` / `vi` / `sudo` エイリアス |
| `.zprofile` | macOS | Homebrew、PATH（mise shims / `~/.local/bin`） |
| `.zshrc` | macOS | エイリアス、PS1、fzf、`mise activate zsh` |
| `.git-prompt.sh` | 両方 | git ブランチ名を PS1 に出す（upstream の git 同梱スクリプト） |
| `.tmux.conf` | 両方 | tmux 共通設定。末尾でプラットフォーム別ファイルを読む |
| `.tmux/macos.conf` | macOS | `pbcopy` へコピー |
| `.tmux/linux.conf` | Ubuntu | OSC 52 でコピー。GUI セッションなら `wl-copy` / `xsel` |
| `.config/nvim/init.vim` | 両方 | Neovim 本体設定、プラグイン、キーマップ |
| `.config/nvim/coc-settings.json` | 両方 | coc.nvim の LSP / フォーマッタ設定 |
| `.editorconfig` | 両方 | 言語ごとのインデント幅 |
| `.flake8` | 両方 | black に合わせた flake8 設定（max-line-length 88） |

`symbolic-link.sh` は macOS 用の `.zshrc` / `.zprofile` も含めて全部リンクする。
Ubuntu では zsh を使わない限り読まれないので実害はない。

## Requirements

設定ファイルが PATH 上に要求するコマンド。

| | 用途 |
|---|---|
| `nvim` | 0.9 以降 |
| `node` + npm の `neovim` | Neovim の node provider |
| `python` + `pynvim` | Neovim の python3 provider |
| `yarn` | `coc-jedi` / `coc-htmldjango` の `do` フック |
| `diagnostic-languageserver` | coc-diagnostic 経由の isort / black |
| `jedi-language-server` | coc-jedi が起動する Python LSP |
| `black` `isort` `flake8` | ale の fixer と coc-diagnostic の formatter |
| `fzf` `rg` `bat` `fd` | fzf-preview.vim のファイル検索とプレビュー |

Ubuntu では `bat` が `batcat`、`fd` が `fdfind` という名前で入るため、
`~/.local/bin` にリンクを張る必要がある（Playbook が実施済み）。

## Setup

### Ubuntu

[ubuntu_playbooks](https://github.com/takedah/ubuntu_playbooks) を流せば
clone からリンクまで済むので、この節の作業は不要。

### macOS

```console
$ git clone https://github.com/takedah/dotfiles.git ~/dotfiles
$ ~/dotfiles/symbolic-link.sh
```

依存コマンドを入れる。

```console
$ brew install mise tmux neovim fzf ripgrep bat fd yarn
$ mise use --global python@3.14.7 node@22 uv@latest
$ mise exec -- uv tool install jedi-language-server
$ mise exec -- uv tool install black
$ mise exec -- uv tool install isort
$ mise exec -- uv tool install flake8
```

Neovim の provider は mise の default packages に任せる。
ここに書いておくと、ランタイムのバージョンを上げたときに自動で入り直す。

```console
$ cat ~/.default-python-packages
pynvim
$ cat ~/.default-npm-packages
neovim
diagnostic-languageserver
typescript
```

Ubuntu 側は yarn も default-npm-packages で入れているが、macOS は
Homebrew 版を使っている。

最後に `nvim` を対話的に起動する。vim-plug が入っていれば `:PlugInstall`、
その後 `g:coc_global_extensions` の拡張が非同期で入る。
`:checkhealth` で `python3` と `node` が OK、`ruby` / `perl` が
disabled になっていれば想定どおり。

## Key bindings

`<Leader>` は `<Space>`、`m` が `[dev]`、`z` が `[ff]`（fzf-preview）の前置キー。

### 検索・移動

| | |
|---|---|
| `<C-p>` | バッファ / MRU / プロジェクトファイルを横断検索 |
| `zf` | プロジェクト grep（ビジュアルモードでは選択文字列を検索） |
| `zb` `zmu` | バッファ一覧 / 最近使ったファイル |
| `zs` `zgg` | git status / git アクション |
| `zd` `zt` `zrf` `zo` `zq` | 定義 / 型定義 / 参照 / アウトライン / 診断 |
| `<Leader>e` `<Leader>E` | fern ドロワーを開く / 現在のファイルを選択して開く |

### 編集・LSP

| | |
|---|---|
| `gd` `gy` `gi` `gr` | 定義 / 型定義 / 実装 / 参照へジャンプ |
| `K` | ホバードキュメントを表示 |
| `[g` `]g` | 前後の診断へ移動 |
| `<C-k>` `<C-j>` | 前後の ale 警告へ移動 |
| `<Leader>rn` | シンボルのリネーム |
| `<Leader>f` | 選択範囲をフォーマット |
| `<Leader>ac` `<Leader>qf` `<Leader>cl` | code action / 現在行の自動修正 / code lens |
| `mf` | TypeScript のみ: eslint autofix → prettier |
| `<Tab>` `<S-Tab>` `<CR>` | 補完候補の選択と確定 |
| `<C-s>` | 選択範囲を段階的に拡張 |

Python は保存時に ale が black をかける（`g:ale_fix_on_save`）。
全ファイルタイプで行末空白と末尾の空行も除去される。

### tmux

| | |
|---|---|
| `prefix` `[` → `v` → `y` | コピーモードに入って選択、コピー |
| マウスドラッグ | 離した時点でコピー |

## Notes

**tmux のクリップボード**
Ubuntu 側は GUI が無ければ OSC 52 でコピーする。SSH 越しでも手元の
クリップボードに届くが、手元のターミナルが OSC 52 に対応している必要がある
（iTerm2 / WezTerm / Ghostty / Alacritty は対応、Terminal.app は非対応）。

**coc 拡張が自動で入らないとき**
`~/.config/coc/extensions/package.json` に記載があると coc は導入済みと
判断する。実体だけ消えているとこの状態になるので、まるごと消して入れ直す。

```console
$ rm -rf ~/.config/coc
$ nvim
```

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
| `.config/mise/config.toml` | 両方 | mise のグローバルなツール（Python / Node.js / uv と Python 製 CLI） |
| `.default-python-packages` | 両方 | Python を入れたときに自動で入るパッケージ（pynvim） |
| `.default-npm-packages` | 両方 | Node.js を入れたときに自動で入るパッケージ |
| `.editorconfig` | 両方 | 言語ごとのインデント幅 |
| `.flake8` | 両方 | black に合わせた flake8 設定（max-line-length 88） |
| `.claude/settings.json` | 両方 | Claude Code の通常セッションの設定（読み取り拒否、sandbox） |
| `.claude/settings-aws.json` | 両方 | AWS セッション用の追加設定（`AWS_*` の mask、通信先の制限） |
| `.claude/settings-gh.json` | 両方 | GitHub セッション用の追加設定（`GH_TOKEN` の mask、通信先の制限） |
| `.claude/CLAUDE.md` | 両方 | Claude Code 全体への指示（認証情報が必要な作業の扱い、変更時の承認ルール） |
| `.local/bin/claude-safe` | 両方 | Claude Code を認証情報なしで起動するラッパー |
| `.local/bin/claude-aws` | 両方 | AWS の資格情報を渡して Claude Code を起動するラッパー |
| `.local/bin/claude-gh` | 両方 | GitHub の資格情報を渡して Claude Code を起動するラッパー |
| `.codex/aws.config.toml` | 両方 | Codex の AWS セッション用プロファイル（`AWS_*` だけ渡す、通信先の制限） |
| `.codex/gh.config.toml` | 両方 | Codex の GitHub セッション用プロファイル（`GH_TOKEN` だけ渡す、通信先の制限） |
| `.local/bin/codex-aws` | 両方 | AWS の資格情報を渡して Codex を起動するラッパー |
| `.local/bin/codex-gh` | 両方 | GitHub の資格情報を渡して Codex を起動するラッパー |

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
$ brew install mise tmux neovim fzf ripgrep bat fd
$ mise install
```

`mise install` は `~/.config/mise/config.toml` に書いたランタイムと
Python 製の CLI ツール（black / isort / flake8 / jedi-language-server /
git-remote-codecommit / cfn-lint / pytest）を入れる。CLI ツールは mise の `pypi` バックエンド
（旧 `pipx`）が uv でツールごとの venv に入れ、mise の shims から呼ばれる。
venv は uv が管理する Python を使うので、mise の Python を上げても壊れない。
ツールの更新は `mise upgrade`。

Neovim の provider と yarn は mise の default packages
（`.default-python-packages` / `.default-npm-packages`）に任せる。
ランタイムを入れたときに自動で入るので、バージョンを上げても入り直す。

バージョンを変えるときは `mise use --global python@x.y.z` でよい。
リンク先のリポジトリのファイルが書き換わるので、そのままコミットする。

最後に `nvim` を対話的に起動する。vim-plug が入っていれば `:PlugInstall`、
その後 `g:coc_global_extensions` の拡張が非同期で入る。
`:checkhealth` で `python3` と `node` が OK、`ruby` / `perl` が
disabled になっていれば想定どおり。

## Claude Code

Claude Code のセッションから、重要な認証情報を原則読めないようにしている。
AWS と GitHub の資格情報は、明示的に環境変数へセットして起動したセッションだけが使える。

`symbolic-link.sh` が `.claude/settings*.json` を `~/.claude/` へ、`.local/bin/claude-*` を `~/.local/bin/` へリンクする。

### 起動方法

| コマンド | 用途 | 資格情報 |
|---|---|---|
| `claude-safe` | 通常のセッション | 渡さない（AWS / GitHub の環境変数を削除して起動） |
| `claude-aws <profile> -- <args>` | AWS 資格情報が必要なセッション | `aws configure export-credentials` で取得して環境変数にセット |
| `claude-gh [--prompt-pat] -- <args>` | GitHub 資格情報が必要なセッション | `gh auth token` で取得。`--prompt-pat` なら PAT を入力 |

ラッパーの実体はリポジトリの `.local/bin/` にあり、`~/.local/bin/` からリンクされる。
ラッパーは本体の `claude` を PATH から探して起動する。

macOS の `.zshrc` では `alias claude='claude-safe'` を設定しているので、
`claude` と入力すると通常セッションになる。
`/opt/homebrew/bin/claude` を直接実行するとラッパーを通らないため、この仕組みの対象外になる。

### 認証情報の扱い

- 認証情報は Claude Code の外側で取得し、起動したプロセスの環境変数としてだけ渡す。ファイルには書かない。
- ラッパーは、起動前に既存の AWS / GitHub の認証関連の環境変数を削除する。
- `settings-aws.json` と `settings-gh.json` は `--settings` で読み込む。Claude から認証情報の値を直接読めないよう、`mask` を指定している。
  ただし、認証情報は `claude` プロセスの環境変数には存在する。
- 通信先は sandbox の `allowedDomains` で制限している。AWS は `*.amazonaws.com` と `*.api.aws`、GitHub は `github.com` と `api.github.com` だけ。
- AWS の資格情報には期限がある。期限が切れたら、セッションを起動し直す。SSO のプロファイルは、先に `aws sso login --profile <profile>` を実行する。
- `claude-aws` の最初の引数は、必ずプロファイル名として扱われる。Claude へ渡す引数は `--` の後に書く。
  例: `claude-aws prod -- --resume`
- `claude-gh` の既定は、`gh` にログイン済みの OAuth トークンを使う。このトークンは権限が広いことがある。
  権限を絞りたいときは、`--prompt-pat` で fine-grained PAT を入力する。
- ラッパーは `--append-system-prompt` で起動方法を Claude に伝える。`CLAUDE.md` はそれを見て、認証情報が必要な作業を止めるかを判断する。
  `--system-prompt-snapshot off` を付けているので、別のラッパーで resume しても、いま起動したラッパーの内容が使われる。

## Codex

Claude Code と同じく、AWS と GitHub の資格情報は、ラッパーで起動したセッションだけに渡す。

`symbolic-link.sh` が `.codex/*.config.toml` を `~/.codex/` へ、`.local/bin/codex-*` を `~/.local/bin/` へリンクする。
`~/.codex` 本体は Claude Code から読めないが、リポジトリの `.codex/` は読める。
`settings.json` の禁止規則を `//Users/*/.codex/**` にして、ホーム直下の `~/.codex` だけを対象にしている。
`~/.codex/config.toml` は Codex が自動で書き換えるため、このリポジトリでは管理しない。
プロファイルは、`config.toml` で定義した権限プロファイル `secure` を `extends` で引き継ぐ。

### 起動方法

| コマンド | 用途 | 資格情報 |
|---|---|---|
| `codex` | 通常のセッション | 渡さない（`config.toml` の `inherit = "core"` で除外） |
| `codex-aws <profile> -- <args>` | AWS 資格情報が必要なセッション | `aws configure export-credentials` で取得 |
| `codex-gh [--use-gh-token] -- <args>` | GitHub 資格情報が必要なセッション | 既定は fine-grained PAT を入力。`--use-gh-token` なら `gh auth token` |

### Claude Code との違い

- Codex には `mask` に当たる機能がない。渡した資格情報は、エージェントが `env` などで読める。
  権限を絞った短命な資格情報を使う。
- 子プロセスには、`shell_environment_policy.filters` で許可した変数だけを渡す。
- 通信先の制限は `features.network_proxy`（experimental）で行う。プロキシは TLS を終端して検査する。

### 動作確認

```console
$ AWS_ACCESS_KEY_ID=dummy FOO_TOKEN=dummy codex sandbox -p aws -- env | cut -d= -f1 | sort
$ codex sandbox -p aws -- curl -sS -o /dev/null -w '%{http_code}\n' https://example.com/   # 403 で拒否される
```

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

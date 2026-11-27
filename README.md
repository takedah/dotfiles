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
| `.bashrc` | Ubuntu | 対話シェル設定、`mise activate bash`、`.bash_aliases` の読み込み |
| `.bash_profile` | Ubuntu | `.profile` と `.bashrc` の読み込み |
| `.bash_aliases` | Ubuntu | ls の色付け、`ll` / `vi` / `sudo` / `claude` / `agy` エイリアス |
| `.zprofile` | macOS | Homebrew、PATH（mise shims / `~/.local/bin`） |
| `.zshrc` | macOS | エイリアス、PS1、fzf、`mise activate zsh` |
| `.git-prompt.sh` | 両方 | git ブランチ名を PS1 に出す（upstream の git 同梱スクリプト） |
| `.tmux.conf` | 両方 | tmux 共通設定。末尾でプラットフォーム別ファイルを読む |
| `.tmux/macos.conf` | macOS | `pbcopy` へコピー |
| `.tmux/linux.conf` | Ubuntu | OSC 52 でコピー。GUI セッションなら `wl-copy` / `xsel` |
| `.config/nvim/init.vim` | 両方 | Neovim 本体設定、プラグイン、キーマップ |
| `.config/nvim/coc-settings.json` | 両方 | coc.nvim の LSP / フォーマッタ設定 |
| `.config/mise/config.toml` | 両方 | mise のグローバルなツール（Python / Node.js / uv と Python 製 CLI） |
| `.config/git/ignore` | 両方 | Git のグローバルな除外設定（ルート直下の `handoff.md` / `.yomiyasu/` など）。リンクせず `core.excludesfile` で指す |
| `.default-python-packages` | 両方 | Python を入れたときに自動で入るパッケージ（pynvim） |
| `.default-npm-packages` | 両方 | Node.js を入れたときに自動で入るパッケージ |
| `.editorconfig` | 両方 | 言語ごとのインデント幅 |
| `.flake8` | 両方 | black に合わせた flake8 設定（max-line-length 88） |
| `.claude/settings.json` | 両方 | Claude Code の通常セッションの設定（読み取り拒否、sandbox） |
| `.claude/settings-aws.json` | 両方 | AWS セッション用の追加設定（`AWS_*` の mask、通信先の制限） |
| `.claude/settings-gh.json` | 両方 | GitHub セッション用の追加設定（`GH_TOKEN` の mask、通信先の制限） |
| `.claude/CLAUDE.md` | 両方 | Claude Code 全体への指示（役割分担、認証情報が必要な作業の扱い、変更時の承認ルール） |
| `.local/bin/claude-safe` | 両方 | Claude Code を認証情報なしで起動するラッパー |
| `.local/bin/claude-aws` | 両方 | AWS の資格情報を渡して Claude Code を起動するラッパー |
| `.local/bin/claude-gh` | 両方 | GitHub の資格情報を渡して Claude Code を起動するラッパー |
| `.codex/AGENTS.md` | 両方 | Codex 全体への指示（役割分担、レビューの進め方、認証情報・承認ルール） |
| `.codex/aws.config.toml` | 両方 | Codex の AWS セッション用プロファイル（`AWS_*` だけ渡す、通信先の制限） |
| `.codex/gh.config.toml` | 両方 | Codex の GitHub セッション用プロファイル（`GH_TOKEN` だけ渡す、通信先の制限） |
| `.codex/config.toml.example` | 両方 | `~/.codex/config.toml` のテンプレート（権限プロファイル `secure`、環境変数、MCP）。リンクしない |
| `.local/bin/codex-aws` | 両方 | AWS の資格情報を渡して Codex を起動するラッパー |
| `.local/bin/codex-gh` | 両方 | GitHub の資格情報を渡して Codex を起動するラッパー |
| `.gemini/antigravity-cli/managed-settings.json` | 両方 | Antigravity CLI に強制する設定（sandbox、読み取り拒否） |
| `.gemini/config/AGENTS.md` | 両方 | Antigravity 全体への指示（役割分担、`handoff.md` での引き継ぎ、承認ルール） |
| `.gemini/config/mcp_config.json` | 両方 | Antigravity の MCP サーバー設定（AWS Knowledge MCP Server） |
| `.local/bin/agy-safe` | 両方 | 上の設定をマージし、認証情報なし・sandbox ありで Antigravity CLI を起動するラッパー |

`symbolic-link.sh` は macOS 用の `.zshrc` / `.zprofile` も含めて全部リンクする。
Ubuntu では zsh を使わない限り読まれないので実害はない。

Claude Code の sandbox は、リンクになった `~/.config/git/ignore` を読めないため、`.config/git/ignore` はリンクしない。
代わりに `symbolic-link.sh` が `git config --global core.excludesfile` でこのファイルを直接指す。
sandbox からも読めるよう、`.claude/settings.json` の `allowRead` にこのファイルを入れている。
`core.excludesfile` を設定すると `~/.config/git/ignore` は読まれなくなるので、独自の設定があれば先にリポジトリの `.config/git/ignore` へ取り込んでおく。
`core.excludesfile` に別のファイルがすでに設定されているときは、`symbolic-link.sh` は設定を変えずに警告を出す。
そのファイルの設定を `.config/git/ignore` へ取り込んでから `git config --global --unset core.excludesfile` で設定を外し、`symbolic-link.sh` を実行し直す。

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
| `jq` | 1.6 以降。`agy-safe` が Antigravity CLI の設定をマージする |

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
$ brew install mise tmux neovim fzf ripgrep bat fd jq
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

macOS の `.zshrc` と Ubuntu の `.bash_aliases` では `alias claude='claude-safe'` を設定しているので、
`claude` と入力すると通常セッションになる。
Ubuntu では `.bash_aliases` を `.profile`（ログインシェル）と `.bashrc`（非ログインの対話シェル）の両方から読み込む。
`/opt/homebrew/bin/claude` を直接実行するとラッパーを通らないため、この仕組みの対象外になる。

### 認証情報の扱い

- 認証情報は Claude Code の外側で取得し、起動したプロセスの環境変数としてだけ渡す。ファイルには書かない。
- ラッパーは起動前に既存の AWS / GitHub の認証関連の環境変数を削除する。
- `settings-aws.json` と `settings-gh.json` は `--settings` で読み込む。Claude から認証情報の値を直接読めないよう、`mask` を指定している。
  ただし、認証情報は `claude` プロセスの環境変数には存在する。
- 通常のセッションでは、sandbox 内のコマンドを確認なしで実行する（`autoAllowBashIfSandboxed`）。
  AWS / GitHub のセッションでは、`settings-aws.json` / `settings-gh.json` で確認ありに戻している。
- 通信先は sandbox の `allowedDomains` で制限している。AWS は `*.amazonaws.com` と `*.api.aws`、GitHub は `github.com` と `api.github.com` だけ。
- AWS の資格情報には期限がある。期限が切れたら、セッションを起動し直す。SSO のプロファイルでは、先に `aws sso login --profile <profile>` を実行する。
- `claude-aws` の最初の引数は必ずプロファイル名として扱われる。Claude へ渡す引数は `--` の後に書く。
  例: `claude-aws prod -- --resume`
- `claude-gh` は既定で、`gh` にログイン済みの OAuth トークンを使う。このトークンは権限が広いことがある。
  権限を絞りたいときは、`--prompt-pat` で fine-grained PAT を入力する。
- `GH_TOKEN` は mask されているので、Claude は `gh` で GitHub の API を使えるが、`git push` のように認証の要る git の操作はできない。git の操作はユーザーが自分のターミナルで行い、API の操作だけを Claude に任せる。
- `gh` は `~/.config/gh` を読めないと起動に失敗する。ラッパーは `GH_CONFIG_DIR` を存在しないフォルダに向け、`gh` が `GH_TOKEN` だけで動くようにしている。
- ラッパーは `--append-system-prompt` で起動方法を Claude に伝える。`CLAUDE.md` はそれを見て、認証情報が必要な作業を止めるかを判断する。
  `--system-prompt-snapshot off` を付けているので、別のラッパーで resume しても、いま起動したラッパーの内容が使われる。

## Codex

Claude Code と同じく、AWS と GitHub の資格情報はラッパーで起動したセッションだけに渡す。

`symbolic-link.sh` が `.codex/*.config.toml` と `.codex/AGENTS.md` を `~/.codex/` へ、`.local/bin/codex-*` を `~/.local/bin/` へリンクする。
`~/.codex` 本体は Claude Code から読めないが、リポジトリの `.codex/` は読める。
`settings.json` の禁止規則を `//Users/*/.codex/**` にして、ホーム直下の `~/.codex` だけを対象にしている。
`~/.codex/config.toml` は Codex が自動で書き換えるため、リンクしない。代わりに、リポジトリにはテンプレートの `.codex/config.toml.example` を置く。
プロファイルは `config.toml` で定義した権限プロファイル `secure` を `extends` で引き継ぐ。

### 導入

`~/.codex/config.toml` がまだない新しい環境では、テンプレートをコピーする。

```console
$ mkdir -p ~/.codex
$ cp ~/dotfiles/.codex/config.toml.example ~/.codex/config.toml
```

`~/.codex/config.toml` がすでにある環境では、上書きしない。`[tui]` や `[projects.*]` などの既存のセクションは残し、
テンプレートの次の部分を追記・マージする。

- 先頭の `approval_policy` / `default_permissions` / `cli_auth_credentials_store`
- `[permissions.secure.*]`（ファイルシステム、ワークスペース、ネットワーク）
- `[shell_environment_policy]`
- `[mcp_servers.aws-knowledge]`

従来の `sandbox_mode` や `[sandbox_workspace_write]` は `[permissions.*]` のプロファイルと併用できない。
既存のファイルに残っていれば削除する。

### 起動方法

| コマンド | 用途 | 資格情報 |
|---|---|---|
| `codex` | 通常のセッション | 渡さない（`config.toml` の `inherit = "core"` で除外） |
| `codex-aws <profile> -- <args>` | AWS 資格情報が必要なセッション | `aws configure export-credentials` で取得 |
| `codex-gh [--use-gh-token] -- <args>` | GitHub 資格情報が必要なセッション | 既定は fine-grained PAT を入力。`--use-gh-token` なら `gh auth token` |

### Claude Code との違い

- Codex には `mask` に当たる機能がない。渡した資格情報は、エージェントが `env` などで読める。
  権限を絞った短命な資格情報を使う。
- `config.toml` の `approval_policy = "on-request"` で、sandbox 内のコマンドは確認なしで実行する。
  AWS / GitHub のプロファイルも同じ設定を引き継ぐ（全コマンドを確認する `untrusted` は廃止された）。
- 子プロセスには `shell_environment_policy.filters` で許可した変数だけを渡す。
- 通信先の制限は `features.network_proxy`（experimental）で行う。プロキシは TLS を終端して検査する。

### 動作確認

```console
$ AWS_ACCESS_KEY_ID=dummy FOO_TOKEN=dummy codex sandbox -p aws -- env | cut -d= -f1 | sort
$ codex sandbox -p aws -- curl -sS -o /dev/null -w '%{http_code}\n' https://example.com/   # 403 で拒否される
```

## Antigravity

Google Antigravity は CLI（`agy`）だけを対象にする。IDE とアプリは設定を UI でしか持たないので、このリポジトリでは管理しない。

`symbolic-link.sh` が `.gemini/antigravity-cli/managed-settings.json` を `~/.gemini/antigravity-cli/` へ、`.gemini/config/AGENTS.md` と `.gemini/config/mcp_config.json` を `~/.gemini/config/` へ、`.local/bin/agy-safe` を `~/.local/bin/` へリンクする。
`~/.gemini` は Claude Code から読めないようにしている（`.codex` と同じく、リポジトリの `.gemini/` は読める）。

### 導入

インストーラは最後に `agy install` を実行し、シェルの設定ファイルを次のように書き換える。

- `.zshrc` などの `alias agy='agy-safe'` を削除する。削除されたままだと、`agy` がラッパーを通らずに起動する。
- 各ファイルの末尾に、ユーザー名を含む絶対パスで `~/.local/bin` を PATH に足す。

`install.sh` が受け付けるオプションは `--dir` だけなので、この書き換えは止められない。
`.zshrc` などがこのリポジトリへのリンクになっていると、変更はリポジトリに出る。
未コミットの編集を消さないよう、状況に応じて次のどちらかで導入する。

**新しい端末**: `symbolic-link.sh` を実行する前に `install.sh` を実行する。
インストーラが書き換えるのはホームにある元のファイルで、そのファイルはあとでリンクに置き換わるので、書き換えはリポジトリに出ない。

```console
$ curl -fsSL https://antigravity.google/cli/install.sh | bash
$ ~/dotfiles/symbolic-link.sh
$ agy-safe   # 初回はブラウザでログイン。トークンは OS のキーチェーンに保存される
```

リンクの後に実行する場合は、先に `git -C ~/dotfiles status` で作業ツリーがクリーンなことを確認し、
インストーラの書き換えを次の「リンク済みの環境」の手順で戻す。

**リンク済みの環境**: `install.sh` を実行する前に未コミットの変更を控え、実行後に `git diff` でインストーラが書き換えた箇所を確認する。

```console
$ cd ~/dotfiles && git status && BEFORE="$(mktemp)" && git diff > "$BEFORE" \
    && curl -fsSL https://antigravity.google/cli/install.sh | bash
$ git diff
```

控えた差分は、`mktemp` が作る一時ファイルに入る。このファイルは自分だけが読み書きできる。`~/dotfiles` への移動から差分の保存までを `&&` でつないでいるので、dotfiles の差分を保存できたときだけインストーラを実行する。
戻し終えたら `rm "$BEFORE"` で削除する。

- 実行前に未コミットの変更がなかったなら、`git checkout -- <書き換わったファイル>` でまとめて戻す。
- 未コミットの編集があったなら、控えた差分（`$BEFORE`）と比べて、インストーラ由来の行（`alias agy` の削除と PATH の追記）だけを戻す。
  `git checkout -p -- <ファイル>` で戻してよいのは、インストーラ由来の行だけのハンクに限る。
  インストーラ由来の行が既存の編集と同じハンクに入っていたら、そのハンクは手で編集して、インストーラ由来の行だけを戻す。

リンクが通常のファイルに置き換わっていたら、`symbolic-link.sh` を実行し直す。
`agy` は `~/.local/bin/agy` に入り、PATH は `.zprofile` / `.profile` で通っている。

### 設定の管理

`~/.gemini/antigravity-cli/settings.json` は CLI が起動時に自分の形式で書き直し、ファイルごと置き換える。
シンボリックリンクにすると通常のファイルに置き換わってしまうため、リンクしない。
代わりに `agy-safe` が起動のたびに、`managed-settings.json` を jq で `settings.json` へマージする。

- `managed-settings.json` に書いたキーは毎回この値で上書きする。
- `permissions.deny` は、`managed-settings.json` の内容で置き換える。CLI から足した `deny` は次の起動で消える。
- `permissions.allow` / `ask` は、既存のルールに足し合わせる（重複は除く）。CLI で「常に許可」したルールも残る。
- それ以外のキー（`/settings` で変えた配色など）は残る。
- ルール中の `~/` は `$HOME` に展開する。
  sandbox は相対パスの `read_file(...)` を受け付けず、全コマンドが失敗するので、相対パスは書かない。

### 起動方法

| コマンド | 用途 | 資格情報 |
|---|---|---|
| `agy-safe` | 通常のセッション | 渡さない（AWS / GitHub / `GOOGLE_APPLICATION_CREDENTIALS` を削除して `agy --sandbox` で起動） |

macOS の `.zshrc` と Ubuntu の `.bash_aliases` では `alias agy='agy-safe'` を設定している。
`agy update` などのサブコマンドはラッパーを通さず `command agy update` で実行する。

### Claude Code / Codex との違い

- 設定ファイルを切り替えるフラグ（`--settings` / `--profile`）がないため、`agy-aws` / `agy-gh` は用意していない。
  共有の `settings.json` を書き換えると、同時に起動したセッションと衝突する。
- 環境変数の mask やフィルタの機能がない。ラッパーで削除した変数以外は、そのまま子プロセスに渡る。
- sandbox は既定で通信を許さない。許可するドメインは `permissions.allow` に `read_url(<domain>)` で足す。
- 既定でブロックされるのは `~/.ssh` と `.env` だけなので、`~/.aws` などは `permissions.deny` の `read_file(...)` で拒否している。
- macOS の sandbox プロファイルは `(allow default)` から始まる拒否リスト型だという報告がある。Claude Code の sandbox ほど強い隔離だとは考えない。

### 動作確認

```console
$ agy-safe -p 'cat ~/.aws/config を実行して結果を表示して'   # 拒否される
$ agy-safe -p 'curl -sS https://example.com/ を実行して結果を表示して'   # 通信できない
$ jq . ~/.gemini/antigravity-cli/settings.json
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

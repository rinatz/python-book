# ツール一覧

Python には pip や venv 以外にも開発で使用するツールが多く存在しており、ネットで調べるときに混乱することが多いです。
そこでどんなツールが使われているのかを整理して解説します。

ネットで検索して見つかる Python ツールは、おおむね次の 3 つに分類されます。

1. Python 自体のバージョンを管理する
2. 仮想環境を管理する
3. パッケージやパッケージ間の依存関係を管理する

ツールによっては 2. と 3. の両方をサポートするようなツールもあるため、どういうシーンで利用すればよいのかがわかりにくいところがあります。

ネットで検索して見つかるツールには次のようなものがあります。

| ツール                        | Python バージョン管理 | 仮想環境管理                     | パッケージ管理                   | 依存関係解決       | ロックファイル生成 | パフォーマンス     | 備考                           |
| ----------------------------- | --------------------- | -------------------------------- | -------------------------------- | ------------------ | ------------------ | ------------------ | ------------------------------ |
| pyenv                         | :white_check_mark:    |                                  |                                  |                    |                    | :star:             | Python のバージョン管理        |
| [venv](./ch04-04-venv.md)     |                       | :white_check_mark:               |                                  |                    |                    | :star:             | Python 標準ライブラリ          |
| virtualenv                    |                       | :white_check_mark:               |                                  |                    |                    | :star::star:       | `venv` で代用可能              |
| [pip](./ch04-03-pip.md)       |                       |                                  | :white_check_mark:               |                    |                    | :star:             | Python 標準のパッケージ管理    |
| pip-tools                     |                       |                                  | :white_check_mark:               | :white_check_mark: | :white_check_mark: | :star:             | `requirements.txt` 強化        |
| pipx                          |                       |                                  | :white_check_mark:（グローバル） |                    |                    | :star::star:       | CLI ツール専用                 |
| [pipenv](./ch09-02-pipenv.md) |                       | :white_check_mark:               | :white_check_mark:               | :white_check_mark: | :white_check_mark: | :octicons-star-24: | 遅いため最近は非推奨気味       |
| [poetry](./ch09-03-poetry.md) |                       | :white_check_mark:               | :white_check_mark:               | :white_check_mark: | :white_check_mark: | :star::star:       | 近年の推奨ツール               |
| rye                           | :white_check_mark:    | :white_check_mark:               | :white_check_mark:               | :white_check_mark: | :white_check_mark: | :star::star:       | 試験的だが統合ツールとして注目 |
| uv                            |                       | :white_check_mark:（内部で管理） | :white_check_mark:               | :white_check_mark: | :white_check_mark: | :star::star::star: | `pip-tools` の超高速代替       |

## どのツールを使うべきか

どのツールを使う場合でも `requirements.txt` は生成しておくのがベターです
（どのツールでも生成コマンドが用意されています）。
`requirements.txt` があれば、Python の標準機能である pip を使ってパッケージのインストールができるようになるためです。

`requirements.txt` さえ生成していれば、どのツールを使ってもよいですが、使い分けのおおまかな方針は次のようになります。

### シンプルな開発

- `venv` + `pip` （標準機能）
- `pip-tools` （依存関係を固定したい場合）

### より便利な管理を求める場合

- `poetry` （仮想環境＋パッケージ管理）
- `pipx` （CLI ツール管理）

### 最新のトレンドを取り入れたい場合

- `rye` （統合環境管理の試験的ツール）
- `uv` （超高速なパッケージ管理）

### Python のバージョン管理をしたい場合

- `pyenv` （複数の Python バージョンを使いたい場合）

# インストール

ここでは開発環境の構築手順について説明します。インストールするものは次のとおりです。

- pyenv
- Python
- PyCharm

## pyenv のインストール

macOS, Linux では最初から Python がインストールされていますが最新版ではありません。また最新版をシステムに入れると古いバージョンと競合を起こすことがあり、好ましくないとされています。そういった問題を解決するためにユーザのホームディレクトリ内に Python をインストールするための pyenv というツールがよく使われます。ここでは pyenv を使った Python のインストール手順を説明します。

!!! info "pyenv"
    https://github.com/pyenv/pyenv

プラットフォームごとにインストール手順を説明します。

### Windows

pyenv は Windows には対応していませんので pyenv を使用しません。Windows では複数の Python がインストールされていてもそれらを切り替えて使用する機構が用意されているので pyenv が使用できなくても問題ありません。

### macOS

ターミナル上で下記のコマンドを実行します。

```shell
$ brew update
$ brew install pyenv
```

!!! info "Homebrew について"
    `brew` は Homebrew というパッケージ管理ツールのコマンドです。Homebrew をインストールしていなければ [公式サイト](https://brew.sh/index_ja) よりインストールをしてください。

### Linux

ターミナル上で下記のコマンドを実行します。

```shell
$ git clone https://github.com/pyenv/pyenv.git ~/.pyenv
$ echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
$ echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
$ echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bashrc
$ exec "$SHELL"
```

## Python のインストール

pyenv で Python をインストールするには、まずインストールする Python のバージョンを確認する必要があります。下記のコマンドを打つとインストールできるバージョンのリストが表示されます。

```shell
$ pyenv install -l
```

表示されたリストの中にある `3.x.x` というバージョンの中で一番最新のものを指定して下記のようにインストールします（下記は `3.7.1` の場合）。

```shell
$ CONFIGURE_OPTS="--enable-shared" pyenv install 3.7.1
$ pyenv rehash
```

インストールが成功したかどうかを下記コマンドで確認します。バージョンが表示されれば成功です。

```shell
$ python -V
```

!!! info "Windows でのインストール"
    Windows での Python のインストール手順は Python 公式の [環境構築ガイド](https://www.python.jp/install/windows/index.html) を参考にしてください。あわせて [Cコンパイラのインストール](https://www.python.jp/install/windows/install_vstools2017.html) も行っておくといいでしょう。

    Windows で Python のバージョンを確認するにはコマンドプロンプト上で下記を実行してください。

    ```shell
    $ py -V
    ```

    Windows に複数バージョンの Python がインストールされている場合は実行する Python のバージョンを `py` コマンドに指定することで Python のバージョンを切り替えながら使用ができます。

    ```shell
    $ py -3.7.1 -V
    ```

    今後 `python` コマンドを叩く説明が出てきた際は `py` コマンドに置き換えて読んでください。

## PyCharm のインストール

PyCharm は Python 用の IDE（統合開発環境）です。補完機能やデバッグ機能など、開発する上で欠かせない機能が豊富に含まれており、開発者の手助けとなってくれるはずです。これも Python と一緒にインストールをしておきます。

!!! Info "PyCharm"
    https://www.jetbrains.com/pycharm/

PyCharm には Professional 版と Community 版の 2 つのエディションが用意されています。

| エディション | ライセンス | 機能                 |
| ------------ | ---------- | -------------------- |
| Professional | 有料       | 全機能が使用可能     |
| Community    | 無料       | 一部の機能は使用不可 |

本サイトでは Community 版を使用しますので Community 版をインストールしてください。

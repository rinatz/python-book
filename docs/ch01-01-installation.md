# インストール

Python 開発に必要な下記のツールをインストールします。

- pyenv
- Python
- PyCharm

## pyenv

pyenv は特定のバージョンの Python をインストールしたり、使用する Python のバージョンを指定するためのツールです。

!!! info "pyenv"
    https://github.com/pyenv/pyenv

ターミナル上で下記のコマンドを実行します。

```shell
$ git clone https://github.com/pyenv/pyenv.git ~/.pyenv
$ echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
$ echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
$ echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bashrc
$ exec "$SHELL"
```

!!! warning
    pyenv は Windows では未対応です。インストールしなくても問題ありません。

## Python

pyenv を使ってインストールできる Python のバージョンリストを表示します。

```shell
$ pyenv install -l
  ...
  3.7-dev
  3.7.1
  3.7.2
  3.8-dev
  activepython-2.7.14
  activepython-3.5.4
  activepython-3.6.0
  ...
```

表示されたリストの中にある `3.x.x` というバージョン（`3.x-dev` は除く）の中で一番最新のものを指定して下記のようにインストールします（下記は `3.7.2` の場合）。

```shell
$ CONFIGURE_OPTS="--enable-shared" pyenv install 3.7.2
$ pyenv rehash
$ pyenv global 3.7.2
```

インストールが成功したかどうかを下記コマンドで確認します。バージョンが表示されれば成功です。

```shell
$ python -V
Python 3.7.2
```

!!! info "Windows でのインストール"
    下記のリンクを参考にしてインストールをしてください。

    1. [環境構築ガイド](https://www.python.jp/install/windows/index.html)
    1. [Cコンパイラのインストール](https://www.python.jp/install/windows/install_vstools2017.html)

    コマンドプロンプト上で下記のコマンドを打ってバージョンが表示されれば成功です。

    ```shell
    $ py -V
    Python 3.7.2
    ```

    本サイトに登場する `python` というコマンドは全て `py` と読み替えてください。

## PyCharm のインストール

Python 用の IDE（統合開発環境）である PyCharm をインストールします。

!!! Info "PyCharm"
    https://www.jetbrains.com/pycharm/

PyCharm には Professional 版と Community 版の 2 つのエディションが用意されています。

| エディション | ライセンス | 機能                 | 本サイトで使用     |
| ------------ | ---------- | -------------------- |--------------------|
| Professional | 有料       | 全機能が使用可能     |                    |
| Community    | 無料       | 一部の機能は使用不可 | :heavy_check_mark: |

Community 版をインストールして下さい。

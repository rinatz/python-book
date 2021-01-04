# poetry

`poetry` は `pipenv`と同様の課題を解決するために作られたサードパーティ製のパッケージ管理ツールです。

!!! note "poetry 公式サイト"
    [https://python-poetry.org/](https://python-poetry.org/)

poetry を使った場合の仮想環境の作成からパッケージのインストールまでの手順は下記のとおりです。

| 操作                     | コマンド                |
|--------------------------|-------------------------|
| 仮想環境の作成           | なし（暗黙的に作られる）|
| 仮想環境を有効にする     | `poetry shell`          |
| 仮想環境を無効にする     | `exit`                  |
| パッケージのインストール | `poetry add [name]`     |

## インストール

`poetry` のインストールは下記のようにします。

=== "macOS"

    ```shell
    $ curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3
    ```

=== "Windows"

    PowerShell 上で下記を実行します。

    ```shell
    (Invoke-WebRequest -Uri https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py -UseBasicParsing).Content | python3
    ```

## 使い方

まず作業ディレクトリを用意します。

```shell
$ mkdir sandbox
```

次に poetry の設定ファイルを生成するコマンドを実行します。

```shell
$ poetry init -n
```

コマンドを実行すると `pyproject.toml` というファイルが作成されます。

次に `pipenv` のときと同様に `requests` をインストールしてみます。

```shell
$ poetry add requests
```

`pipenv` の使い方で使用したソースコードを実行するには下記のようにします。

```shell
$ poetry shell
(.venv) $ python main.py
```

上記の 2 行のコマンドは次のように 1 行で実行することもできます。

```shell
$ poetry run python main.py
```

## pyproject.toml と poetry.lock

`pyproject.toml` は poetry の設定ファイルです。`pipenv` でいうところの `Pipfile` と同じ位置づけのファイルになります。

**pyproject.toml**

```toml
[tool.poetry]
name = "sandbox"
version = "0.1.0"
description = ""
authors = ["..."]

[tool.poetry.dependencies]
python = "^3.6"
requests = "^2.24.0"

[tool.poetry.dev-dependencies]

[build-system]
requires = ["poetry>=0.12"]
build-backend = "poetry.masonry.api"
```

`poetry.lock` はインストールしたパッケージのバージョンを保存しているファイルです。`pipenv` でいうところの `Pipfile.lock` と同じ位置づけのファイルになります。

`pipenv` の場合 `Pipfile` や `Pipfile.lock` の内容をもとにパッケージをインストールするには下記のようにコマンドを使い分ける必要がありました。

| 使用ファイル   | コマンド         |
|----------------|------------------|
| `Pipfile`      | `pipenv install` |
| `Pipfile.lock` | `pipenv sync`    |

`poetry` にも同等の機能があるのですが `pyproject.toml` の内容をもとにパッケージをインストールする場合も `poetry.lock` の内容をもとにパッケージをインストールする場合もコマンドは同じです。

```shell
$ poetry install
```

`pyproject.toml` と `poetry.lock` の両方がある場合は `poetry.lock` の内容が優先されるという仕組みになっています。

## pipenv との違い

詳細は割愛しますが `poetry` の方が `pipenv` よりも機能が豊富です。また `pyproject.toml` は `poetry` 専用の設定ファイルではなく Python が公式に策定したパッケージ管理用の設定ファイルになっているため、他のパッケージ管理ツールの設定ファイルとしても使われます。`pip` も新しいバージョンでは `pyproject.toml` を使用することができるようになっています。

# pipenv

`pipenv` は `pip` と `venv` の両方の機能を兼ね備えたサードパーティ製のパッケージ管理ツールです。`venv` で仮想環境を作成してから `pip` でパッケージをインストールするまでの手順では下記のように異なるコマンドを実行する必要がありますが、これを 1 つのコマンドで実行できるようにしたものが `pipenv` です。

| 操作                     | コマンド (macOS, Linux) | コマンド (Windows)            |
|--------------------------|-------------------------|-------------------------------|
| 仮想環境の作成           | `python -m venv venv`   | `py -m venv venv`             |
| 仮想環境を有効にする     | `. venv/bin/activate`   | `venv/Scripts/activate.bat`   |
| 仮想環境を無効にする     | `deactivate`            | `venv/Scripts/deactivate.bat` |
| パッケージのインストール | `pip install [name]`    | `py -m pip install [name]`    |

各操作に応じて実行するコマンドも異なれば OS ごとにも異なっており、とても複雑です。しかし `pipenv` を使うと上記の操作は次のようになります。

| 操作                     | コマンド                |
|--------------------------|-------------------------|
| 仮想環境の作成           | `pipenv --three`        |
| 仮想環境を有効にする     | `pipenv shell`          |
| 仮想環境を無効にする     | `exit`                  |
| パッケージのインストール | `pipenv install [name]` |

このように `pipenv` というコマンド 1 つで仮想環境の作成とパッケージのインストールの両方が実行できるため、操作がシンプルになります。また実行するコマンドは OS によらず同じです。

## 特徴

`pipenv` はパッケージのインストールを必ず仮想環境内で実行するように作られています。そのため仮想環境を有効にしていない状態で

```shell
$ pipenv install [name]
```

というコマンドを打っても自動的に仮想環境を作成して、それを有効にした上でパッケージのインストールを実行します。

## インストール

`pipenv` のインストールは下記のようにします。

```shell
$ pip install pipenv
```

!!! note
    `pipenv` のインストールは仮想環境内で行う必要はありません。なぜなら `pipenv` 自体が仮想環境を作成するツールだからです。

## 使い方

まず作業用ディレクトリを用意します。

```shell
$ mkdir sandbox
```

`pipenv` を使ってサードパーティライブラリの `requests` をインストールするには次のようにします。

```shell
$ cd sandbox
$ pipenv install requests
```

自動的に仮想環境が作成され、その仮想環境内に `requests` がインストールされます。次に `requests` を使用した次のようなソースコードを用意します。

**main.py**

```python
#!/usr/bin/env python


import requests


def main():
    response = requests.get('http://example.com')
    print(response.text)


if __name__ == '__main__':
    main()
```

ソースコードを作成したら仮想環境を有効にして実行してみます。

```shell
$ pipenv shell
(sandbox) $ python main.py
```

上記の 2 行のコマンドは次のように 1 行で実行することもできます。

```shell
$ pipenv run python main.py
```

`pipenv run [command]` は仮想環境を有効にした上で `[command]` を実行してくれる機能です。

## Pipfile

`pip` にはインストールしたいパッケージをテキストファイルに記述しておく `requirements.txt` という仕組みがありましたが、`pipenv` はこれの代替として `Pipfile` というテキストファイルが使用できます。先程の `requests` をインストールするとディレクトリ内に `Pipfile` が作成されていると思います。

```shell
$ cat Pipfile
[[source]]
name = "pypi"
url = "https://pypi.org/simple"
verify_ssl = true

[dev-packages]

[packages]
requests = "*"

[requires]
python_version = "3.7"
```

`pipenv` はパッケージをインストールすると `Pipfile` にインストールしたパッケージを記録するようになっています。もしディレクトリ内に `Pipfile` がある場合、下記のコマンドを実行すると `Pipfile` 内に記述されたパッケージをインストールしてくれます。

```shell
$ pipenv install
```

つまり `Pipfile` をバージョン管理しておくことで他の人の環境でも自分がインストールしたパッケージと同じものをインストールできるようになります。

## Pipfile.lock

`Pipfile` と合わせて `Pipfile.lock` というファイルも作成されていると思います。このファイルはインストールしたパッケージのバージョンを保存しているファイルです。`pipenv install` でパッケージをインストールすると、インストールされるパッケージのバージョンはその時点での最新版が取得されるようになっているため、自分がインストールしたパッケージのバージョンとは厳密には異なるバージョンのパッケージが他の人の環境にインストールされる可能性があります。もしバージョンも含めて完全に一致するものをインストールしたい場合は `Pipfile` の代わりに `Pipfile.lock` を使ってインストールすることで実現できます。

`Pipfile.lock` を使ってインストールするには次のようにします。

```shell
$ pipenv sync
```

## 公式サイト

`pipenv` はここで説明した機能以外にも便利な機能がたくさんあります。詳細は公式サイトに説明がありますので参考にしてみてください。

!!! note "Pipenv 公式サイト"
    https://pipenv.readthedocs.io/en/latest/

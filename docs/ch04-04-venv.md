# venv

`pip` を使ってサードパーティ製のパッケージをインストールすることができましたが、インストールしたいパッケージが稀に競合を起こすことがあります。

| プログラム | `requests` の要求バージョン |
|------------|-----------------------------|
| program1   | 2.21.0                      |
| program2   | 2.20.1                      |

program1 では `requests` 2.21.0 を使おうとしているのに対し program2 では 2.20.1 を使いたかったとすると、システムの中に複数バージョンの `requests` をインストールしておく必要が出てきます。もし使用したいパッケージのバージョンが意図しないものになっているとプログラムが正しく動かない可能性が出てきます。

## 仮想環境の作成

このような競合を解決するために Python には各プログラムで使用したいパッケージを互いに影響がない形で個別に管理するための仕組みが用意されており、仮想環境と呼ばれます。仮想環境を作成するためのツールは `venv` と呼ばれ、Python に標準で同梱されています。

試しにこれから 2 つの仮想環境を作成し、それぞれに異なるバージョンの `requests` をインストールしてみます。まず下記のように 2 つのディレクトリを作成します。

```shell
$ mkdir program1 program2
```

次に program1 配下で仮想環境を作成します。

=== "macOS"

    ```shell
    $ cd program1
    $ python3 -m venv .venv
    ```

=== "Windows"

    ```shell
    $ cd program1
    $ py -3 -m venv .venv
    ```

program1 配下に `.venv` というディレクトリが作成されます。仮想環境を有効にするために下記のコマンドを実行します。

=== "macOS"

    ```shell
    $ . .venv/bin/activate
    (.venv) $
    ```

=== "Windows"

    ```shell
    $ .venv\Scripts\activate.bat
    (.venv) $
    ```

この状態で `requests` 2.21.0 をインストールしてみます。パッケージをバージョン指定でインストールしたければ次のように実行します。

```shell
(.venv) $ pip install requests==2.21.0
```

!!! note

    仮想環境が有効な場合であれば pip コマンドは `pip` が使用できます。
    `pip3` コマンドも使用できますが、どちらを使用しても効果は同じです。

    一方で仮想環境が無効な状態であれば `pip` は Python 2 系の古い pip を呼び出すことになり
    `pip3` とは挙動が異なるので注意してください。

この `requests` は .venv ディレクトリ配下にインストールされ、仮想環境が有効でない限りは参照することができないようになっています。 `pip freeze` を使ってインストールされているパッケージ一覧を確認してみます。

```shell
(.venv) $ pip freeze
certifi==2019.3.9
chardet==3.0.4
idna==2.8
requests==2.21.0
urllib3==1.24.1
```

仮想環境を無効にする場合は `deactivate` というコマンドを実行します。このコマンドは仮想環境が有効なときだけ使用することができます。

=== "macOS"

    ```shell
    (.venv) $ deactivate
    $
    ```

=== "Windows"

    ```shell
    (.venv) $ venv\Scripts\deactivate.bat
    $
    ```

program2 配下でも同様に仮想環境を作成してみます。`requests` のバージョンは 2.20.1 を使用します。

=== "macOS"

    ```shell
    $ cd program2
    $ python3 -m venv .venv
    $ . .venv/bin/activate
    (.venv) $ pip install requests==2.20.1
    (.venv) $ pip freeze
    certifi==2019.3.9
    chardet==3.0.4
    idna==2.7
    requests==2.20.1
    urllib3==1.24.1
    ```

=== "Windows"

    ```shell
    $ cd program2
    $ py -3 -m venv .venv
    $ .venv\bin\activate.bat
    (.venv) $ pip install requests==2.20.1
    (.venv) $ pip freeze
    certifi==2019.3.9
    chardet==3.0.4
    idna==2.7
    requests==2.20.1
    urllib3==1.24.1
    ```

program1, program2 配下いずれかの仮想環境を有効にすることで異なるバージョンの `requests` が使用できるようになっています。ちなみに仮想環境が有効でない状態でインストールされたパッケージは全プログラムから参照可能なので競合を起こす可能性があり、使用すべきではありません。そのため、前章の `pip` の章でインストールしたパッケージは下記のように削除しておくことをおすすめします。

```shell
$ pip3 freeze > requirements.txt
$ pip3 uninstall -y -r requirements.txt
```

# pip

`pip` はインターネットで公開されている Python パッケージを取得するためのパッケージ管理ツールです。

## 使い方

[requests] という HTTP に関する機能を取り扱う有名なライブラリがあります。これを `pip` で取得して使ってみましょう。

[requests]: http://docs.python-requests.org/en/master/

ターミナル上で次のコマンドを実行して下さい。

```shell
$ pip3 install requests
```

成功したら次のようなソースコードを書いてみましょう。

```python
#!/usr/bin/env python


import requests


def main():
    response = requests.get('http://example.com')
    print(response.text)


if __name__ == '__main__':
    main()
```

実行すると [http://example.com](http://example.com) のページの HTML 文字列が出力されると思います。

## PyPI

`pip` によってインストールされるパッケージはどこから取得されているのでしょうか。 Python は [PyPI] というパッケージを登録しておける Web サイトがあり、 `pip` を実行すると PyPI からパッケージがインストールされます。上記の requests も下記の通り PyPI に登録されています。

!!! info "PyPI"
    [https://pypi.org/project/requests/](https://pypi.org/project/requests/)

[PyPI]: https://pypi.org/

## freeze

インストール済みのパッケージ一覧を確認するには `freeze` というコマンドを実行します。

```shell
$ pip3 freeze
certifi==2019.3.9
chardet==3.0.4
idna==2.8
requests==2.21.0
urllib3==1.24.1
```

`requests` とその依存パッケージがバージョン番号とともに表示されます。

## requirements.txt

インストールしたいパッケージをあらかじめファイルに列挙しておき、そのファイルを指定することでもインストールすることができます。インストールしたいパッケージを記述したファイルは通常 `requirements.txt` という名前で保存します。`requirements.txt` を指定してインストールをするには次のようにします。

```shell
$ pip3 install -r requirements.txt
```

`requirements.txt` は自分の環境にパッケージをインストールする目的で使用することはあまりありません。むしろ他の人の環境で自分が使っているパッケージをインストールして欲しいときに使用します。また `requirements.txt` は手で作成する必要はなく、`pip freeze` の結果を保存しておくだけで使用できます。`pip freeze` の結果にあるような `==version` という形式のものを `pip` でインストールすると指定されたバージョンをインストールしてくれるため、自分で入れたバージョンと全く同じものを他の人の環境でもインストールしてもらえるようになり、環境差分をなくすことができます。

まとめるとパッケージ管理は次のような手順で行うことになります。

**自分の環境**

```shell
$ pip3 install name1 name2 ...
$ pip3 freeze > requirements.txt
```

`requirements.txt` は Git などでバージョン管理をしておきます。

**他の人の環境**

```shell
$ pip3 install -r requirements.txt
```

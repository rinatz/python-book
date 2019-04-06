# pip

`pip` はインターネットで公開されている Python パッケージを取得するためのパッケージ管理ツールです。

## 使い方

[requests] という HTTP に関する機能を取り扱う有名なライブラリがあります。これを `pip` で取得して使ってみましょう。

[requests]: http://docs.python-requests.org/en/master/

ターミナル上で次のコマンドを実行して下さい。

```shell
$ pip install requests
```

!!! note
    Windows の場合は下記のコマンドを実行して下さい。

    $ py -m pip install requests

成功したら次のようなソースコードを書いてみましょう。

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-


import requests


def main():
    response = requests.get('http://example.com')
    print(response.text)


if __name__ == '__main__':
    main()
```

実行すると http://example.com のページの HTML 文字列が出力されると思います。

## PyPI

`pip` によってインストールされるパッケージはどこから取得されているのでしょうか。 Python は [PyPI] というパッケージを登録しておける Web サイトがあり、 `pip` を実行すると PyPI からパッケージがインストールされます。上記の requests も下記の通り PyPI に登録されています。

!!! info "PyPI"
    https://pypi.org/project/requests/

[PyPI]: https://pypi.org/

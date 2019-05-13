# プロジェクト構成

Python のソースコードを管理する際にディレクトリの構成をちゃんと考えておくことはとても重要なことです。なぜなら Python は適切な構成になっていないとプログラムを正しく動かすことができなくなるからです。そこで Python 開発ではどのような構成で管理すれば問題が起こりにくいのかについて説明します。

## The Hitchhiker's Guide to Python

Python の理想のプロジェクト構成は Kenneth Reitz 氏によって推奨されている構成に従うのがよいでしょう。どのような構成なのかは [The Hitchhiker’s Guide to Python] というサイトの [Structuring Your Project] の章で詳しく書かれていますのでそちらを参考にしてもらうことにして、ここでは特に注意すべきことについてまとめておきます。

!!! warning "注意"
    [Structuring Your Project] の章で説明されているプロジェクト構成は Pipenv が登場する前の推奨構成になっているのでやや古い内容になっています。`requirements.txt` の説明は `Pipfile, Pipfile.lock` と適宜読み替えて読んでください。

ディレクトリの基本構成は次のとおりです。

```
(project)
├── (project)  ............ プログラムのソースコードディレクトリ
│  ├── __init__.py
│  └── *.py
└── tests  ................ 単体テストのソースコードディレクトリ
   └── *.py
```

`(project)` の部分は開発する Python プログラムの名前を付けます。`sample` というプログラムを開発するなら

```
sample
├── sample
│  ├── __init__.py
│  └── *.py
└── tests
   └── *.py
```

のようになります。大事なのはプログラムのソースコードは必ず `(project)` 配下の 1 つのディレクトリ内に集約させるということです（単体テストのソースコードは除く）。なぜならディレクトリは Python のパッケージを構成するものなので、複数のディレクトリでソースコードを管理すると複数の Python パッケージを開発していることになります。しかし通常 1 つのプロジェクト内に複数のパッケージを含めて開発することはありません。

ソースコードが 1 つで十分な場合はディレクトリを用意しなくても大丈夫です。

```
(project)
├── (project).py  ........... プログラムのソースコードディレクトリ
└── test_(project).py  ...... 単体テストのソースコードディレクトリ
```

下記は良くない構成の一例です。

```
sample
├── sample
│  ├── __init__.py
│  └── *.py
├── libs  ................. よくないディレクトリ
│  ├── __init__.py
│  └── *.py
└── tests
   └── *.py
```

下記は `sample/__init__.py` が用意されていないため問題のある構成です。ディレクトリ内に Python ファイルを入れる場合は必ず `__init__.py` を用意してください。

```
sample
├── sample
│  └── *.py
└── tests
   └── *.py
```

下記のような構成もやってしまいがちですが適切ではありません。

```
sample
├── sample
│  ├── __init__.py
│  └── *.py
├── main.py
└── tests
   └── *.py
```

**main.py**

```python
#!/usr/bin/env python


import sample


def main():
    # sample パッケージを使った処理
    ...


if __name__ == '__main__':
    main()
```

この構成の問題点はライブラリとアプリケーションの区別ができていない構成になっているという点です。

| 構成             | 説明                                           |
|------------------|------------------------------------------------|
| ライブラリ       | 他のプログラムから `import` して使うプログラム |
| アプリケーション | 直接実行するプログラム                         |

この例だと `sample` はライブラリで `main.py` はアプリケーションという位置づけになります。もしライブラリとアプリケーションの両方の側面を持つプログラムを書きたいという場合は `main.py` を `sample/__main__.py` という名前で保存してください。

```
sample
├── sample
│  ├── __init__.py
│  ├── __main__.py
│  └── *.py
└── tests
   └── *.py
```

そして `main()` を実行したい場合はターミナル上で次のようにします。

```shell
$ python -m sample
```

こうすると `sample/__main__.py` が実行されるようになります。決して

```shell
$ python sample/__main__.py
```

のように実行してはいけません。たとえ動いたとしてもいつもうまくいくと期待しないほうがいいでしょう。

[The Hitchhiker’s Guide to Python]: https://docs.python-guide.org/
[Structuring Your Project]: https://docs.python-guide.org/writing/structure/

# ジェネレータ

ジェネレータとは処理を一時停止できる機能を持った関数のことです。処理を一時停止できるということがどういうことなのか、具体的なソースコードで説明していきます。

## ジェネレータの例

まず下記のような処理の挙動について確認しておきす。

**main.py**

```python
#!/usr/bin/env python


def f():
    print('開始')

    return

    print('終了')


def main():
    f()
    f()


if __name__ == '__main__':
    main()
```

```shell
$ python main.py
開始
開始
```

関数 `f()` は通常の関数ですが `return` の後ろに `print()` の呼び出しが入っています。`return` があると関数の処理はそこで終わってしまうので `f()` を実行しても `終了` という文字列はプリントされません。

次に `return` の箇所を `yield` というキーワードに変更して同様のプログラムを実行するとどうなるでしょうか。

```python hl_lines="7"
#!/usr/bin/env python


def f():
    print('開始')

    yield

    print('終了')


def main():
    f()
    f()


if __name__ == '__main__':
    main()
```

```shell
$ python main.py
開始
終了
```

2 回目の `f()` の呼び出しで `終了` という文字列がプリントされるはずです。`yield` は `return` とよく似た挙動をしますが `return` が関数の処理を終了するのに対し `yield` はそこで一時停止をして関数を抜けます。再度 `f()` が呼ばれると `yield` の箇所から関数の処理が再開されます。このように `yield` を使った関数のことをジェネレータといいます。

## ジェネレータを使ったループ

ジェネレータは `return` と同様 `yield` で任意の値を返すことができます。

**main.py**

```python
#!/usr/bin/env python


def f():
    yield 0
    yield 1
    yield 2


def main():
    print(f())
    print(f())
    print(f())


if __name__ == '__main__':
    main()
```

```shell
$ python main.py
0
1
2
```

さらに `for` にジェネレータを渡して値を取り出すこともできます。

```python
def main():
    for x in f():
        print(x)    # 0, 1, 2
```

ジェネレータを `for` に渡すとジェネレータに書かれた `yield` の個数分だけループが回ります。つまりジェネレータはリストのようなデータ構造とよく似た振る舞いをします。

## ループ処理のカスタマイズ

複雑なループ処理はジェネレータを使うことでシンプルに書くことができるようになります。例えば下記のような 2 つのリストの要素の総当たりの組み合わせを得るような処理を考えます。

```python
def main():
    xs = [0, 1, 2]
    ys = ['a', 'b', 'c']

    for x in xs:
        for y in ys:
            print(x, y)
```

このような処理は 2 つのリストを受け取って総当たりの組み合わせを返すジェネレータで書き換えることができます。

```python
def product(xs, ys):
    for x in xs:
        for y in ys:
            yield x, y


def main():
    xs = [0, 1, 2]
    ys = ['a', 'b', 'c']

    for x, y in product(xs, ys):
        print(x, y)
```

`product()` を使うと二重ループが単一ループで書き直せました。実は `product()` は標準ライブラリの [itertools] ですでに用意されているため、わざわざ自分で作らなくても使うことができます。

[itertools]: https://docs.python.org/ja/3/library/itertools.html#itertools.product

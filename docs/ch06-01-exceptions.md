# 例外

Python のプログラムで不正な処理を行ったときは例外と呼ばれる割り込み処理が通常の処理に変わって実行されます。例外が発生するタイミングにはいろいろなものがありますが、代表的なものには次のようなものがあります。

## 不正な構文を実行

```python
#!/usr/bin/env python


def main():
    print('Hello, World!'


if __name__ == '__main__':
    main()
```

```shell
$ python main.py
  File "main.py", line 8
    if __name__ == '__main__':
                             ^
SyntaxError: invalid syntax
```

`SyntexError` という種類の例外が発生しています。

## 配列のインデックスが不正

```python
#!/usr/bin/env python


def main():
    x = [0, 1, 2]
    print(x[3])


if __name__ == '__main__':
    main()
```

```shell
$ python main.py
Traceback (most recent call last):
  File "main.py", line 10, in <module>
    main()
  File "main.py", line 6, in main
    print(x[3])
IndexError: list index out of range
```

`IndexError` という種類の例外が発生しています。

## 存在しないファイルをオープン

```python
#!/usr/bin/env python


def main():
    with open('file.txt') as f:
        print(f.read())


if __name__ == '__main__':
    main()
```

```shell
$ python main.py
Traceback (most recent call last):
  File "main.py", line 10, in <module>
    main()
  File "main.py", line 5, in main
    with open('file.txt') as f:
FileNotFoundError: [Errno 2] No such file or directory: 'file.txt'
```

`FileNotFoundError` という種類の例外が発生しています。このように不正な処理が検知された時点で例外が割り込み、プログラムは停止します。

- `SyntexError`
- `IndexError`
- `FileNotFoundError`

はすべて例外クラスを呼ばれるものです。

## 例外を捕捉する

例外が発生したときにプログラムを停止させる代わりに、例外が発生したときに実行する処理を書くこともできます。`try-except` 文を使ってそれが実現できます。

```python
#!/usr/bin/env python


def main():
    try:
        # 例外を監視する処理
        with open('file.txt') as f:
            print(f.read())
    except FileNotFoundError:
        # 例外発生時の処理
        print('ファイルが存在しません。')


if __name__ == '__main__':
    main()
```

```shell
$ python main.py
ファイルが存在しません。
```

`try` ブロックで例外が発生しうる処理を記述し、`except` ブロックで例外が発生したときに実行する処理を記述します。 `except` ブロックは複数書くこともでき、そうすることで複数の例外を捕捉することができます。

```python
#!/usr/bin/env python


def main():
    try:
        with open('file.txt') as f:   # file.txt が存在しなければ FileNotFoundError
            contents = f.read()
            print(contents[1000])     # ファイル内の文章が 1000 字以上なければ IndexError
    except FileNotFoundError:
        print('ファイルが存在しません。')
    except IndexError:
        print('文章は 1000 字以上必要です。')


if __name__ == '__main__':
    main()
```

例外を捕捉するメリットには次のようなものがあります。

- `try-except` を `if-else` のような条件分岐の代わりとして使える
- どのようなエラーが発生しうるかがコード上で明らかになる
- エラー発生時の原因や解決策を `print()` などを使って伝えられる

## 例外を送出する

自分で例外を送出することもできます。例外を送出するには `raise` を使います。

```python
def factorial(n):
    if not n >= 0:
        raise ValueError('n >= 0 である必要があります')

    ...
```

自分で例外を送出する場合は独自の例外クラスを用意しておいたほうがエラーの起こった箇所が区別しやすくなります。例外クラスを作成するには `Exception` クラスを継承して作成する必要があります。

```python
class MyException(Exception):
    pass
```

例外クラスの実装は空で問題ありません。 `Exception` を継承している組み込みの例外クラスを継承しても良いです。

!!! tips "組み込み例外の一覧"
    下記ページに例外クラスの一覧が載っていますので参考にして下さい。
    [https://docs.python.org/ja/3/library/exceptions.html](https://docs.python.org/ja/3/library/exceptions.html)

# Hello, World!

標準出力に `Hello, World!` と表示するプログラムを書いてみます。

**main.py**

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-

def main():
    print('Hello, World!')


if __name__ == '__main__':
    main()
```

実行は main.py に実行権限を付けて実行します。

```shell
$ chmod +x main.py
$ ./main.py
```

## 構文の説明

```python
#!/usr/bin/env python
```

これは[シバン](https://ja.wikipedia.org/wiki/%E3%82%B7%E3%83%90%E3%83%B3_(Unix))といって、このソースコードを実行する際に使用するコマンドを記述します。シバンがこのように記述されていると

```shell
$ ./main.py
```

とプログラムを実行したとき、実際には

```shell
$ /usr/bin/env python ./main.py
```

のように実行されます。

```python
# -*- coding: utf-8 -*-
```

はソースコードの文字コードを `utf-8` として扱うことを意味しています。`utf-8` 以外でソースコードを記述したい場合は

```python
# -*- coding: sjis -*-
```

のように他の文字コードを指定することができますが、ソースコードの文字コードは常に `utf-8` であるべきなので推奨はしません。

```python
def main():
    print('Hello, World!')
```

これは関数の定義をしています。`def main():` とすることで関数名が `main` で引数なしの関数を定義することができます。`print()` を使うことで標準出力に文字列を出力することができます。`print()` がインデントされていることはとても重要です。なぜなら

```python
def main():
print('Hello, World!')
```

と書くと構文エラーになるからです。関数の実装は必ずインデントしてから記述するルールになっています。インデントを強制するのは Python では書き方に一貫性を持たせることを信念としているからです。

```python
if __name__ == '__main__':
    main()
```

これは `main()` 関数を呼び出しているコードです。`__name__ == '__main__'` の時だけ `main()` を呼び出すという意味になりますが、この `if` 文の意味はモジュールの章で説明します。他の言語ではエントリーポイント（プログラムの最初に呼び出される関数）となる関数の名前が `main` となっていることが多いですが、Python はそもそもエントリーポイントの概念がありません。単純にソースコードの上の行から順番に処理を実行するだけです。

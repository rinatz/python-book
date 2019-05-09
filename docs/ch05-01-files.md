# ファイル操作

ファイルの読み書きをする方法について説明します。

## 読み込み

`file.txt` というファイルを読み込み、1 行ずつプリントするプログラムは次のように書きます。

**main.py**

```python
#!/usr/bin/env python


def main():
    f = open('file.txt')

    for line in f:
        print(line)

    f.close()


if __name__ == '__main__':
    main()
```

`for` を使わずに 1 行読み込む場合は `readline()` メソッドを使います。

```python
print(f.readline())
```

注意が必要なのは読み込んだ各行の文字列は末尾の改行も含んでいるということです。例えば `file.txt` が次のような内容だった場合

**file.txt**

```
aaa
bbb
ccc
```

`for` や `readline()` で読み込んだ各行の文字列は次のようになります。

```python
'aaa\n'
'bbb\n'
'ccc\n'
```

`print()` は文字列をプリントした後に自動で改行を 1 つ書き出すため、これらの文字列をプリントすると改行が 2 つ入った状態で出力されてしまいます。

```shell
$ python main.py
aaa

bbb

ccc
```

これを解決するには読み込んだ文字列に対して `strip()` というメソッドを呼び出します。 `strip()` は文字列の両端にある空白や改行を削除するメソッドです。

```python
#!/usr/bin/env python


def main():
    f = open('file.txt')

    for line in f:
        print(line.strip())

    f.close()


if __name__ == '__main__':
    main()
```

その他次のようなメソッドでも文字列を読み込むことができます。

| メソッド      | 説明                              | 例                            |
|---------------|-----------------------------------|-------------------------------|
| `readlines()` | 各行をリストで読み込む            | `['aaa\n', 'bbb\n', 'ccc\n']` |
| `read()`      | 全行を 1 つの文字列として読み込む | `'aaa\nbbb\nccc\n'`           |

## 書き込み

ファイルを書き込む処理は次のように書きます。

```python
#!/usr/bin/env python


def main():
    f = open('file.txt', 'w')
    f.write('Hello, World!\n')
    f.close()


if __name__ == '__main__':
    main()
```

`open()` の第 2 引数に `'w'` を付けることで書き込みモードでファイルをオープンします。そして `write()` メソッドに書き出したい文字列を渡すことでファイルに書き出すことができます。 `write()` には文字列しか渡すことができませんので、数値などを書き出したいときは f-string を使って文字列に変換する必要があります。また `write()` は `print()` とは違って改行を自動で付与しないので、改行したいときは明示的に `'\n'` を渡す必要があります。

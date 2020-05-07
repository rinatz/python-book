# CSV

Python で CSV の読み書きを行いたい場合は `csv` モジュールを使います。

## 読み込み

### reader

CSV ファイルを読み込む場合は `open()` でファイルを開いた後、ファイルオブジェクトを `csv.reader()` に渡します。

```python
#!/usr/bin/env python
import csv


def main():
    with open('example.csv', newline='') as f:
        reader = csv.reader(f)

        for row in reader:
            print(row)  # row は CSV の各行になる


if __name__ == '__main__':
    main()
```

!!! warning "注意"
    `newline=''` というのはファイルの改行コードをそのまま読み込むというオプションです。これを付けないと CRLF, LF, CR などの改行コードはすべて LF に変換されてファイルが読み込まれますが CSV を読むときはこの変換をすべきでないとされています。

`row` にはカンマ区切りの要素がリストで保存されます。

**example.csv**

```
0,A
1,B
2,C
```

上記のファイルに対しては `row` は下記のようになります。

```python
[0, 'A']
[1, 'B']
[2, 'C']
```

### DictReader

CSV が下記のようなヘッダを持つ場合は `reader()` の代わりに `DictReader` を使うと各行を辞書で読むことができるようになります。

**example.csv**

```
id,name
0,A
1,B
2,C
```

```python
#!/usr/bin/env python
import csv


def main():
    with open('example.csv', newline='') as f:
        reader = csv.DictReader(f)

        for row in reader:
            print(row)
```

実行結果は下記のようになります。

```python
{'id': 0, 'name': 'A'}
{'id': 1, 'name': 'B'}
{'id': 2, 'name': 'C'}
```

## 書き込み

### writer

CSV ファイルを作成するには `open()` でファイルを開いた後 `csv.writer()` にファイルオブジェクトを渡します。

```python
#!/usr/bin/env python
import csv


def main():
    with open('example.csv', 'w', newline='') as f:
        writer = csv.writer(f)

        writer.writerow([0, 'A'])
        writer.writerow([1, 'B'])
        writer.writerow([2, 'C'])
```

!!! warning "注意"
    書き込みの場合も `newline=''` は必ず付けるようにしてください。

### DictWriter

ヘッダ付きの CSV を作成したい場合は `writer()` の代わりに `DictWriter` を使うと書き込む要素を辞書で指定できるようになります。

```python
#!/usr/bin/env python
import csv


def main():
    with open('example.csv', 'w', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=['id', 'name'])

        writer.writerow({'id': 0, 'name': 'A'})
        writer.writerow({'id': 1, 'name': 'B'})
        writer.writerow({'id': 2, 'name': 'C'})


if __name__ == '__main__':
    main()
```

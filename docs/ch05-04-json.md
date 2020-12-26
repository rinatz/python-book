# JSON

Python で JSON の読み書きを行いたい場合は `json` モジュールを使います。

## 読み込み

### ファイルから読み込み

JSON ファイルを読み込む場合は `open()` でファイルを開いた後、ファイルオブジェクトを `json.load()` に渡します。

```python
#!/usr/bin/env python

import json


def main():
    with open('example.json') as f:
        json_data = json.load(f)


if __name__ == '__main__':
    main()
```

`json_data` は読み込んだ JSON の構造に応じて Python の辞書やリストになります。

**example.json**

```json
{
    "message": "Hello, World!",
    "items": [0, 1, 2],
    "ok": true
}
```

上記のファイルに対しては `json_data` は下記のようになります。

```python
{
    "message": "Hello, World!",
    "items": [0, 1, 2],
    "ok": True
}
```

### 文字列から読み込み

`json.loads()` を使うと文字列で作成された JSON をパースすることができます。

```python
json_string = """
{
    "message": "Hello, World",
    "items": [
        0,
        1,
        2
    ],
    "ok": true
}
"""

json_data = json.loads(json_string)
```

!!! note
    `json.loads()` の `s` は `string` の `s` です。

## 書き込み

### ファイルに書き込み

JSON ファイルを作成するには `open()` でファイルを開いた後、`json.dump()` にファイルオブジェクトを渡します。

```python
#!/usr/bin/env python
import json


def main():
    json_data = {
        "message": "Hello, World!",
        "items": [0, 1, 2],
        "ok": True,
    }

    with open('example.json', 'w') as f:
        json.dump(json_data, f)


if __name__ == '__main__':
    main()
```

**example.json**

```json
{"items": [0, 1, 2], "message": "Hello, World!", "ok": true}
```

JSON データは改行されずに出力されます。もし整形して出力させたい場合は `json.dump()` に `indent` オプションを渡します。`indent` にはインデント数を渡します。

```python
json.dump(json_data, f, indent=4)
```

```json
{
    "items": [
        0,
        1,
        2
    ],
    "message": "Hello, World!",
    "ok": true
}
```

出力したいデータ内に日本語が含まれていると JSON に変換するときに `\uXXXX` というエスケープされた形式で変換されてしまいます。

```python
json_data = {
    "message": "こんにちは",
    "items": [0, 1, 2],
    "ok": True,
}
```

**結果**

```json
{
    "message": "\u3053\u3093\u306b\u3061\u306f",
    "items": [
        0,
        1,
        2
    ],
    "ok": true
}
```

日本語をエスケープさせたくない場合は `json.dump()` に `ensure_ascii=False` オプションを渡します。

```python
json.dump(json_data, f, indent=4, ensure_ascii=False)
```

**結果**

```json
{
    "message": "こんにちは",
    "items": [
        0,
        1,
        2
    ],
    "ok": true
}
```

### 文字列に出力

JSON を文字列に出力したい場合は `json.dumps()` を使います。

```python
json_data = {
    "message": "Hello, World!",
    "items": [0, 1, 2],
    "ok": True,
}

json_string = json.dumps(json_data, indent=4, ensure_ascii=False)
print(json_string)
```

**結果**

```json
{
    "message": "Hello, World!",
    "items": [0, 1, 2],
    "ok": true
}
```

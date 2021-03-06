# リスト内包表記

リスト内包表記とはリストを簡単に作成するための構文のことです。今 `[0, 2, 4, 6, ..., 98]` というリストを作ろうとした場合、

```python
x = []

for i in range(50):
    x.append(i * 2)
```

のようにループ処理をして要素を詰めて作ることができますが、リスト内包表記を使うと下記のようにもっとシンプルに書くことができます。

```python
x = [i * 2 for i in range(50)]
```

リスト内包表記は別のコレクション型から変換を行う際によく使われます。例えば下記は辞書からタプルを要素とするリストを作成する例です。

```python
x = {'a': 10, 'b': 20, 'c': 30}
y = [(key, val) for key, val in x.items()]  # [('a', 10), ('b', 20), ('c', 30)]
```

ループ処理を短く書くことができますので活用するとコードがシンプルになります。

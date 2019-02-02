# ループ文

リストの要素に対して繰り返し同様の処理を実行する場合は `for` や `while` を使います。

## `for`

リストに対して `for` を使う場合は次のように書きます。

```python
values = [0, 1, 2, 3, 4]

for value in values:
    print(f'The value is {value}')
```

タプルの場合も同様にして `for` に渡すことができます。辞書も渡すことができますが、この場合キーが各ループで参照されます。

```python
items = {'a': 1, 'b': 2, 'c': 3}

for key in items:
    print(f'The key is {key}')
```

値のループあるいはキーと値の両方をループで参照したい場合はそれぞれ `values(), items()` メソッドを使用します。

```python
items = {'a': 1, 'b': 2, 'c': 3}

for value in items.values():
    print(f'The value is {value}')

for key, value in items.items():
    print(f'The pair of key and value is ({key}, {value})')
```

### `range()`

整数を順にループさせたい場合は `range()` という関数を使って実現できます。

```python
for i in range(10):
    print(f'The value is {i}')
```

`range(10)` で 0 以上 10 未満（すなわち 0 ～ 9） の整数をループします。`range()` は終了値だけでなく、開始値と刻み幅を指定することもできます。

```python
range(stop, start=0, step=1)
```

!!! note "例"
    - `range(2, 10)`: 2, 3, 4, 5, 6, 7, 8, 9
    - `range(2, 10, 2)`: 2, 4, 6, 8
    - `range(10, 0, -1)`: 10, 9, 8, 7, 6, 5, 4, 3, 2, 1

## `while`

`while` は特定の条件が `True` である間ループ処理を続けるというものです。

```python
x = [10, 20, 30, 40, 50]
index = 0

while index < 5:
    print(f'The value is {x[index]}')
    index += 1
```

# 条件文

ある条件を満たしている時だけ行いたい処理がある場合は条件文を使って処理を書きます。

## `if` を使った条件文

```python
def main():
    check(3)
    check(7)


def check(number):
    if number < 5:
        print('condition was true')
    else:
        print('condition was false')
```

`number` の値が `5` 未満かどうかで出力されるメッセージが変化します。 `if` に渡す条件式は `bool` として評価されるものを渡すべきですが、実際には何でも渡すことができます。例えば次のように他の値と比較せずに単に整数を渡すこともできます。

```python
x = 10

if x:
    print('x is not 0')
```

この条件は `x != 0` と同じ、すなわち `x` が `0` でないという意味になります。同様に

```python
0, 0.0, '', b'', [], (), {}, None
```

は全て `False` と解釈されます。

## `elif` を使った複数の条件文

複数の条件を見たい場合は `if, elif, else` を使います。

```python
def main():
    check(number)


def check(number):
    if number % 4 == 0:
        print('number is divisible by 4')
    elif number % 3 == 0:
        print('number is divisible by 3')
    elif number % 2 == 0:
        print('number is divisible by 2')
    else:
        print('number is not divisible by 4, 3, or 2')
```

`else if` ではなく `elif` であることに注意してください。

!!! tip "switch 文"
    Python には switch 文がありません。これは `if, elif, else` で代用できて Python の書き方は 1 つというポリシーに従っているためでしょう。

## 演算子

条件文で使用できる演算子には次のようなものがあります。

### `and`

複数の条件が成立するかどうかを調べるときに使用します。

```python
def main():
    check(10)


def check(x):
    if x >= 0 and x < 10:
        print('x is in [0, 10)')
```

ただし変数の範囲チェックをする場合は `and` を使わなくてもシンプルな書き方ができます。

```python
def main():
    check(10)


def check(x):
    if 0 <= x < 10:     # x >= 0 and x < 10 と同じ
        print('x is in [0, 10)')
```

### `or`

複数の条件のうちどれか 1 つが成立するかどうかを調べるときに使用します。

```python
def main():
    check(10, -3)


def check(x, y):
    if x > 0 or y > 0:
        print('Either x or y is a positive value')
```

### `in`

リスト・タプル・集合内に特定の要素が含まれているかどうかを調べます。

```python
def main():
    check([0, 1, 2, 3, 4], 3)


def check(data, x):
    if x in data:
        print(f'{data} contains {x}')
```

辞書に対して使用するとキーの存在を調べることができます。

```python
def main():
    check({'x': 0, 'y': 1, 'z': 2}, 'x')


def check(data, key):
    if key in data:
        print(f'{data} contains the value of key {key}')
```

### `is`

`is` は 2 つの変数が同じインスタンスを参照しているかどうかを調べるときに使用します。

```python
def main():
    x = [0, 1, 2]
    y = x
    z = x
    check(y, z)


def check(x, y):
    if x is y:
        print('x is y == True')
```

ここでいう **同じ** とは、値が等価という意味ではなく、参照しているインスタンスが同じかどうかを意味しています。言い換えれば、`is` で比較しようとしている 2 つの変数の代入元を追っていって同じ変数にたどり着く場合に `is` の結果は `True` になります。

```python
x = [0, 1, 2]
y = x
z = y

x is y  # True
y is z  # True
z is x  # True

a = [0, 1, 2]
b = a

x is a  # False
x is b  # False
```

変数に `None` が代入されているかどうかを調べるときは `==` ではなく `is` を使用します。

```python
x is None
```

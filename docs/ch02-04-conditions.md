# 条件文

ある条件を満たしている時だけ行いたい処理がある場合は条件文を使って処理を書きます。

## `if`

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-


def main():
    check(3)
    check(7)


def check(x):
    if x < 5:
        print('condition was true')
    else:
        print('condition was false')


if __name__ == '__main__':
    main()
```

`x` の値が `5` 未満かどうかで出力されるメッセージが変化します。`if` に渡す値は必ずしも評価式である必要はありません。次のように値そのものを渡すこともできます。

```python
x = 10

if x:
    print('x is not 0')
```

この条件は `x` を `bool` に変換した値が評価されます。値を `bool` に変換した場合の結果は次のように評価されます。

- `0, 0.0, '', b'', [], (), {}, set(), None` のとき `False`
- それ以外のとき `True`

## `elif`

複数の条件を見たい場合は `if, elif, else` を使います。

```python
def check(number):
    if number % 4 == 0:
        print('number is divisible by 4')
    elif number % 3 == 0:
        print('number is divisible by 3')
    elif number % 2 == 0:
        print('number is divisible by 2')
    else:
        print('number is not divisible by 4, 3, or 2')


def main():
    check(number)
```

`else if` ではなく `elif` であることに注意してください。

!!! note "switch 文"
    Python には switch 文がありませんので `if, elif, else` を使用して下さい。

## 空の条件文

条件文内の処理を空にしたい場合は `pass` と書いておきます。

```python
if x == 0:
    pass
```

## 演算子

条件文で使用できる演算子には次のようなものがあります。

### `and`

複数の条件が成立するかどうかを調べるときに使用します。

```python
def check(x):
    if x >= 0 and x < 10:
        print('x is in [0, 10)')


def main():
    check(10)
```

ただし変数の範囲チェックをする場合は `and` を使わなくてもシンプルな書き方ができます。

```python

def check(x):
    if 0 <= x < 10:     # x >= 0 and x < 10 と同じ
        print('x is in [0, 10)')


def main():
    check(10)
```

### `or`

複数の条件のうちどれか 1 つが成立するかどうかを調べるときに使用します。

```python
def check(x, y):
    if x > 0 or y > 0:
        print('Either x or y is a positive value')


def main():
    check(10, -3)
```

### `in`

リスト・タプル・集合内に特定の要素が含まれているかどうかを調べます。

```python
def check(data, x):
    if x in data:
        print(f'{data} contains {x}')


def main():
    check([0, 1, 2, 3, 4], 3)
```

辞書に対して使用するとキーの存在を調べることができます。

```python
def check(data, key):
    if key in data:
        print(f'{data} contains the value of key {key}')


def main():
    check({'x': 0, 'y': 1, 'z': 2}, 'x')
```

### `is`

`is` は 2 つの変数が同じインスタンスを参照しているかどうかを調べるときに使用します。

```python
def check(x, y):
    if x is y:
        print('x is y == True')


def main():
    x = [0, 1, 2]
    y = x
    z = x
    check(y, z)
```

ここでいう「同じ」とは保持している値が等価という意味ではありません。参照しているインスタンスが同じかどうかを意味しています。言い換えれば変数 `x, y` に対して、これらの代入元の変数をたどっていって同じ変数にたどり着くなら `x is y` は `True` になります。

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

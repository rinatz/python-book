# 関数

関数を定義するには `def` キーワードを使います。

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-


def another_function():
    print('Another function')


def main():
    print('Hello, World!')

    another_function()


if __name__ == '__main__':
    main()
```

関数名は自由に与えることができますが、慣習的に英数字かつ *snake case* （小文字を `_` でつなぐ記法）で表記します。

!!! note
    関数定義の間は慣習的に 2 行開けるルールになっています。

## 引数

関数には引数を渡すことができます。

```python
def another_function(x, y):
    print(f'The value of x is {x}')
    print(f'The value of y is {y}')


def main():
    another_function(5, 6)
```

## デフォルト引数

関数には引数を明示的に渡さなかった場合にデフォルト値を暗黙的に渡す機能があります。

```python
def another_function(x, y=10):
    print(f'The value of x is {x}')
    print(f'The value of y is {y}')


def main():
    another_functin(5, 3)   # x: 5, y: 3
    another_functin(7)      # x: 7, y: 10
```

デフォルト引数は引数内で一番最後に渡す必要があります。

```python
# OK
def f1(x, y=10):
    print(f'The value of x is {x}')
    print(f'The value of y is {y}')


# OK
def f2(x, y=10, z=20):
    print(f'The value of x is {x}')
    print(f'The value of y is {y}')
    print(f'The value of z is {z}')


# NG
def f3(y=10, x, z=20):
    print(f'The value of x is {x}')
    print(f'The value of y is {y}')
    print(f'The value of z is {z}')
```

!!! note
    デフォルト引数の定義は慣習的に `=` の両端にはスペースを入れずに書きます。

## キーワード引数

関数を呼び出すときに引数名を指定すれば引数を順不同で渡すこともできます。

```python hl_lines="7"
def another_function(x, y):
    print(f'The value of x is {x}')
    print(f'The value of y is {y}')


def main():
    another_function(y=10, x=20)
```

## `*args, **kwargs`

関数の引数名に `*` が付いたものがあると、その変数は複数の引数を 1 つのタプルとして受け取るようになります。

```python
def another_function(x, *args):
    print(f'The value of x is {x}')         # x: 0
    print(f'The value of args is {args}')   # args: (1, 2, 3)


def main():
    another_function(0, 1, 2, 3)
```

また引数名に `**` を付けると複数のキーワード引数を 1 つの辞書として受け取るようになります。

```python
def another_function(x, **kwargs):
    print(f'The value of x is {x}')             # x: 0
    print(f'The value of kwargs is {kwargs}')   # kwargs: {'y': 10, 'z': 20}


def main():
    another_function(0, y=10, z=20)
```

`*args, **kwargs` は併用することも可能です。

```python
def another_function(x, *args, **kwargs):
    print(f'The value of x is {x}')             # x: 0
    print(f'The value of args is {args}')       # args: (1, 2)
    print(f'The value of kwargs is {kwargs}')   # kwargs: {'y': 10, 'z': 20}


def main():
    another_function(0, 1, 2, y=10, z=20)
```

!!! note
    `*` 引数と `**` 引数はどのような名前にしても構いませんが、慣習的に `*args, **kwargs` が使われます。

## 引数のアンパック

関数に引数を渡すときにタプルに `*` を付けて渡すとタプルの各要素を個別の引数として渡せるようになります。

```python
def another_function(x, y, z):
    print(f'The value of x is {x}')     # x: 0
    print(f'The value of y is {y}')     # y: 1
    print(f'The value of z is {z}')     # z: 2


def main():
    args = (0, 1, 2)
    another_function(*args)             # another_function(0, 1, 2)
```

また辞書に `**` を付けて渡すと辞書の各要素をキーワード引数として渡せるようになります。

```python
def another_function(x, y, z):
    print(f'The value of x is {x}')     # x: 0
    print(f'The value of y is {y}')     # y: 1
    print(f'The value of z is {z}')     # z: 2


def main():
    kwargs = {'x': 0, 'y': 1, 'z': 2}
    another_function(**kwargs)          # another_function(x=0, y=1, z=2)
```

## 型ヒント

引数に特定の型だけを渡せるようにしたければ **型ヒント** を使用します。

```python
def another_function(x: int, y: int):
    print(f'The value of x * y is {x * y}')
```

型ヒントを使用しなければどんな型の変数も渡せます。これはしばしば混乱の元となるので、なるべく型ヒントを使うようにしましょう。

## 戻り値

関数の呼び出し側に値を返却する場合は `return` を使用します。

```python
def plus_one(x):
    return x + 1


def main():
    x = plus_one(5)     # x: 6

    print(f'The value of x is {x}')
```

戻り値として返す型は複数あっても構いません。

```python
def another_function(x):
    if x == 0:
        return x + 3.14
    else:
        return x + 1
```

この関数は `x` が `0` のときは `float` 型を返し、そうでないときは `int` 型を返します。複数の型を返すことを想定してなければ、型ヒントを使うことで誤って意図しない型を返却してしまうことを防ぐことができます。

```python
def plus_one(x: int) -> int:
    return x + 1
```

Python の関数は必ず戻り値を持っており、`return` を明示的に使わなかった場合は `None` が返ります。

```python
def f(x):
    print(f'The value of x is {x}')
```

この関数は下記と同じ意味になります。

```python
def f(x):
    print(f'The value of x is {x}')
    return None
```

## 空実装

関数の実装を空にしたい場合は `pass` と書いておきます。

```python
# 何もしない関数
def empty_function():
    pass
```

# 関数

Python で関数を定義するには `def` キーワードを使います。

**main.py**

```python
def main():
    print('Hello, World!')

    another_function()


def another_function():
    print('Another function')
```

関数名は自由に与えることができますが、慣習的に英数字かつ *snake case* で表記します。

!!! tip "snake case （スネーク記法）"
    snake case とは小文字の単語を `_` でつなぐ記法のことです。

関数定義の順序は好きなように配置できます。また関数定義の間は慣習的に 2 行開けるルールになっています（従っていなくても正しく実行はできます）。

## 引数

関数に引数を渡したい場合は関数名の後ろの `()` 内に列挙します。

```python
def main():
    another_function(5)


def another_function(x):
    print(f'The value of x is {x}')
```

引数を複数渡したい場合は `,` で区切ります。

```python
def main():
    another_function(5, 6)


def another_function(x, y):
    print(f'The value of x is {x}')
    print(f'The value of y is {y}')
```

## デフォルト引数

Python の関数には引数を明示的に渡さなかった場合にデフォルト値を設定して暗黙的に引数を渡す機能があります。

```python
def main():
    another_functin(5, 3)   # x: 5, y: 3
    another_functin(7)      # x: 7, y: 10


def another_function(x, y=10):
    print(f'The value of x is {x}')
    print(f'The value of y is {y}')
```

上記の例だと `y` は明示的に値を渡さなかった場合は `10` を設定して関数内で使用されます。仕様上デフォルト引数は関数の引数内で一番最後に渡す必要があります。

```python
def f1(x, y=10):        # OK
    print(f'The value of x is {x}')
    print(f'The value of y is {y}')


def f2(x, y=10, z=20):  # OK
    print(f'The value of x is {x}')
    print(f'The value of y is {y}')
    print(f'The value of z is {z}')


def f3(y=10, x, z=20):  # NG
    print(f'The value of x is {x}')
    print(f'The value of y is {y}')
    print(f'The value of z is {z}')
```

デフォルト引数の定義は慣習的に `=` の両端にはスペースを入れずに書きます。

## キーワード引数

関数の引数は順不同で渡すことも可能です。順不同で引数を渡す場合は次のように書き、これをキーワード引数といいます。

```python
def main():
    another_function(y=10, x=20)


def another_function(x, y):
    print(f'The value of x is {x}')
    print(f'The value of y is {y}')
```

デフォルト引数が複数あり、かつ一部のデフォルト引数だけを渡す場合によく使用されます。キーワード引数は慣習的に `=` の両端にはスペースを入れずに書きます。

## `*args, **kwargs`

関数の引数名に `*` が付いたものがあると、その変数は複数の引数を 1 つのタプルとして受け取るようになます。

```python
def main():
    another_function(0, 1, 2, 3)


def another_function(x, *args):
    print(f'The value of x is {x}')         # x: 0
    print(f'The value of args is {args}')   # args: (1, 2, 3)
```

また引数名に `**` を付けると複数のキーワード引数を 1 つの辞書として受け取るようになります。

```python
def main():
    another_function(0, y=10, z=20)


def another_function(x, **kwargs):
    print(f'The value of x is {x}')             # x: 0
    print(f'The value of kwargs is {kwargs}')   # kwargs: {'y': 10, 'z': 20}
```

`*args, **kwargs` は併用することも可能です。

```python
def main():
    another_function(0, 1, 2, y=10, z=20)


def another_function(x, *args, **kwargs):
    print(f'The value of x is {x}')             # x: 0
    print(f'The value of args is {args}')       # args: (1, 2)
    print(f'The value of kwargs is {kwargs}')   # kwargs: {'y': 10, 'z': 20}
```

`*` 引数と `**` 引数はどのような名前にしても構いませんが、慣習的に `*args, **kwargs` が使われます。Python には同名の関数を定義する機能（関数のオーバーロード）がないため、引数に `*args, **kwargs` を用意させておくことでオーバーロドの代用ができます。

## 引数のアンパック

関数に引数を渡すときにタプルに `*` を付けて渡すとタプルの各要素を個別の引数として渡せるようになります。

```python
def main():
    args = (0, 1, 2)
    another_function(*args)             # another_function(0, 1, 2)


def another_function(x, y, z):
    print(f'The value of x is {x}')     # x: 0
    print(f'The value of y is {y}')     # y: 1
    print(f'The value of z is {z}')     # z: 2
```

また辞書に `**` を付けて渡すと辞書の各要素をキーワード引数として渡せるようになります。

```python
def main():
    kwargs = {'x': 0, 'y': 1, 'z': 2}
    another_function(**kwargs)          # another_function(x=0, y=1, z=2)


def another_function(x, y, z):
    print(f'The value of x is {x}')     # x: 0
    print(f'The value of y is {y}')     # y: 1
    print(f'The value of z is {z}')     # z: 2
```

## 型ヒント

Python は変数の型に対しては楽観的に振る舞います。すなわち引数の型については検証せず、どのような型の変数が渡ってきてもコードが正しく動くならそれで OK とします。もし関数内で特定の型に対してしか行えない演算を使っていれば、その時点でエラーが発生します。

```python
def main():
    another_function('Hello', 'World!')


def another_function(x, y):
    print(f'The value of x * y is {x * y}')     # 'Hello' * 'World!' は不正な演算なのでエラーが発生
```

引数の型を明示的に指定したい場合は次のような **型ヒント** を使用します。

```python
def another_function(x: int, y: int):
    print(f'The value of x * y is {x * y}')
```

こうすると引数に整数型以外を渡せばエラーになります。型ヒントを使用しなかった場合は `x * y` をしようとした時点でエラーになるのに対し、型ヒントを使用した場合は関数を呼び出した時点でエラーになるため、エラーの原因がより明確になります。

## 戻り値

関数内で `return` キーワードを使うとその行で関数を抜け呼び出し側に制御が戻ります。また `return` を使うと関数の呼び出し側に値を返すことができます。

```python
def main():
    x = plus_one(5)     # x: 6

    print(f'The value of x is {x}')


def plus_one(x):
    return x + 1
```

戻り値として返す型は複数あっても構いません。

```python
def another_function(x):
    if x == 0:
        return x + 3.14
    else:
        return x + 1
```

この関数は `x` が `0` のときは `float` 型を返し、そうでないときは `int` 型を返します。引数と同様、戻り値の型もたとえ異なる型を返しても正しく動くならそれで OK とする仕様となっています。また戻り値に対しても型ヒントを次のように使うことができます。

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

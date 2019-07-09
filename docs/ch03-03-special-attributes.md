# 特殊属性

新たなクラスを定義したときには自動で定義されるメンバやメソッドが存在しており、それらを特殊属性といいます。代表的な特殊属性をいくつか紹介します。

下記のようなクラスを定義したときの特殊属性には次のようなものがあります。

```python
import math


class Point:
    """Point クラスです。"""

    def __init__(self, x, y):
        self.x = x
        self.y = y

    def distance(self):
        return math.sqrt(self.x * self.x + self.y * self.y)
```

## `__doc__`

`Point.__doc__` という変数には `"""Point クラスです。"""` という文字列が入ります。`""" ... """` というトリプルクオテーションでくくられた文字列は改行を含む複数行の文字列を定義できる文字列です。

```python
"""この文字列は
一つの文字列として
扱われます。"""
```

`__doc__` は docstring と呼ばれ、ドキュメンテーションをする際に使用される文字列として扱われます。

## `__init__`

クラスインスタンスを作成するときは `__init__()` が呼び出されます。

```python
point = Point(10, 20)   # point.__init__(10, 20)
```

## `__getattribute__`

クラスのメンバやメソッドを参照したときは `__getattribute__()` が呼び出されます。

```python
point = Point(10, 20)
point.x             # point.__getattribute__('x')
point.distance()    # point.__getattribute__('distance')()
```

## `__getattr__`

`__getattribute__()` でのメンバ参照に失敗した場合は `__getattr__()` が呼び出されます。このような事が起こるのはクラスのメンバとして定義されていないものにアクセスしようとしたときに起こります。

```python
point.foo   # point.__getattr__('foo')
```

## `__setattr__`

メンバへの代入が行われた場合は `__setattr__()` が呼び出されます。

```python
point = Point(10, 20)
point.x = 30    # point.__setattr__('x', 30)
```

## `__eq__`

インスタンスに対して `==` が使用された場合は `__eq__()` が呼ばれます。

```python
point1 = Point(10, 20)
point2 = Point(30, 40)
point1 == point2    # point1.__eq__(point2)
```

その他類似の特殊属性が下記の通り用意されています。

| 特殊属性 | 意味               |
|----------|--------------------|
| `__ne__` | `point1 != point2` |
| `__le__` | `point1 <= point2` |
| `__lt__` | `point1 < point2`  |
| `__ge__` | `point1 >= point2` |
| `__gt__` | `point1 > point2`  |

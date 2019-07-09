# 特殊属性

クラスには特殊属性と呼ばれるメソッドが存在しており、クラスを使う際に使用される構文はどれも特殊属性の呼び出しに変換されて実行されます。代表的な特殊属性をいくつか紹介します。

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
point.x2   # point.__getattr__('x2')
```

`__getattr__()` は明示的には定義されません。使用するには自分で定義する必要があります。

```python
class Point:
    ...

    def __getattr__(self, item):
        if item == 'x2':
            return self.x * self.x
        elif item == 'y2':
            return self.y * self.y
```

## `__getitem__`

クラスインスタンスに対して `[]` を使用した際には `__getitem__()` が呼び出されます。

```python
point = Point(10, 20)
point['x']      # point.__getitem__('x')
```

`__getitem__()` を使用するには自分で定義する必要があります。

```python
class Point:
    ...

    def __getitem__(self, item):
        if item == 'x':
            return self.x
        elif item == 'y':
            return self.y
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

## `__str__`

クラスインスタンスに対して文字列型へのキャストを行うと `__str__()` が呼び出されます。明示的なキャストでなくても文字列への変換が必要とされるケースでも同様の振る舞いをします。

```python
point = Point(10, 20)
print(point)    # print(point.__str__())
```

`__str__()` はデフォルトで定義されていますが、大抵の場合は有益な文字列にはなっていないので自分で定義したほうが良いです。

```python
class Point:
    ...

    def __str__(self):
        return f'<Point(x={self.x}, y={self.y})>'
```

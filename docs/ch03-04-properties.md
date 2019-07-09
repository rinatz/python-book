# プロパティ

クラスのメンバで変数のように参照することのできる関数のことをプロパティといいます。

```python
import math


class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    @property
    def distance(self):
        return math.sqrt(self.x * self.x + self.y * self.y)
```

`@property` のように `@` ではじまるキーワードは **デコレータ** といって関数やクラスに特殊な振る舞いを注入することのできる機能になっています。`distance()` は関数として定義されていますが `@property` デコレータがついていると変数のように参照することができるようになります。

```python
point = Point(10, 20)
point.distance  # 22.360679775
```

プロパティは `point.distance()` のように呼ぶことはできません。

メンバ変数 `x, y` を隠蔽して、代わりにプロパティを提供すると代入ができなくなるので安全です。

```python
import math


class Point:
    def __init__(self, x, y):
        # _ をつけて隠蔽していることを示す
        self._x = x
        self._y = y

    @property
    def x(self):
        return self._x

    @property
    def y(self):
        return self._y

    @property
    def distance(self):
        return math.sqrt(self.x * self.x + self.y * self.y)
```

```python
point = Point(10, 20)
print(point.x, point.y)     # _x, _y の参照は可能
point.x = 30                # _x, _y への代入はできない
```

プロパティに対して代入を行いたい場合は `setter` プロパティを定義します。

```python
@property
def x(self):
    return self._x      # getter

@x.setter
def x(self, value):
    self._x = value     # setter
```


```python
point.x = 30    # OK
```

プロパティの利点は `get_x()` のような関数を定義しなくても、まるで変数を直接参照しているようなコードが書ける点にあります。これはクラスを利用する人からするとシンプルなコードが書けるので便利です。ただしプロパティは変数と同じくらいに気軽に参照するメンバになるので、パフォーマンスが遅い関数をむやみにプロパティとして定義するのは避けたほうが良いです。
# クラス

クラスとは新しい型を定義するための仕組みであり、タプルのように複数の変数を集約して扱うためのデータ構造を提供することができます。

## 定義

クラスを定義するには `class` キーワードにクラス名を付けて定義します。さらにそのクラスで管理する変数を定義するために `__init__()` という関数を定義します。

```python
class Rectangle:
    def __init__(self, width, height):
        self.width = width
        self.height = height
```

`__init__()` にはそのクラスを初期化するために必要な変数を引数として渡します。`self.width = width` と書くことで、そのクラスには `width` というメンバ変数が定義されます。`self.height = height` についても同様です。これで `Rectangle` という型が作成され、その型は `width, height` をメンバ変数として持っていることになります。

`Rectangle` をインスタンス化するには次のように書きます。

```python
rectangle = Rectangle(10, 20)

print(f'The value of width is {rectangle.width}')
print(f'The value of height is {rectangle.height}')
```

`Rectangle(10, 20)` と書くと `__init__(self, 10, 20)` のように初期化関数が呼び出されます。

## `self`

`Rectangle` をインスタンス化する際は `10, 20` という 2 つの値しか渡してないのに `__init__()` の第 1 引数には `self` という変数が含まれており、合計 3 つの引数が用意されています。これは一体どういうことでしょうか。この謎はクラスのインスタンス化の仕組みを理解すれば分かってきます。

`rectangle = Rectangle(10, 20)` という処理をイメージで説明すると、だいたいこんな感じになります。

```python
rectangle = (Rectangle クラスの変数を用意)  # この時点では rectangle.width, rectangle.height は存在しない
Rectangle.__init__(rectangle, 10, 20)       # rectangle.width = width, rectangle.height = height という処理が実行される
```

すなわち `self` というのはクラスインスタンスを表す変数です。

## 関数

クラスには関数を定義することもできます。

```python
class Rectangle:
    def __init__(self, width, height):
        self.width = width
        self.height = height

    def area(self):
        return self.width * self.height


def main():
    rectangle = Rectangle(10, 20)
    area = rectangle.area()

    print(f'The area is {area}')


if __name__ == '__main__':
    main()
```

クラスに関数を定義するときは第 1 引数が `self` である必要があります。これは `rectangle.area()` という呼び出しは実際には `Rectangle.area(rectangle)` のように呼び出されるためです。

## 継承

定義済みのクラスのメンバを持つ新たなクラスを作成することもできます。

```python
class Square(Rectangle):
    def __init__(self, size):
        super().__init__(size, size)


def main():
    square = Square(10)
    area = square.area()

    print(f'The area is {area}')


if __name__ == '__main__':
    main()
```

`Square` クラスは `Rectangle` クラスのメンバを全て引き継いだクラスになっており、これをクラスの継承といいます。`Rectangle` が長方形を扱うクラスなのに対し、`Square` は正方形を扱うクラスになっています。さらに `Square` は `Rectangle` が持つ全てのメンバ `square.width, square.height, square.area()` が参照できます。

!!! tip "インターフェース"
    Python にはインターフェースが存在しません。また多態性を実現するのにクラスに継承関係を作る必要もありません。例えば、継承関係を持たない 2 つのクラス `A, B` が同名の関数 `f()` を持っていれば次のコードは正しく実行できます。

    ```python
    def call(x):
        x.f()

    call(A())
    call(B())
    ```

    Python は例え継承関係を持っていなくてもコードが実行できるような構造になっていればそれで OK とします。このような構造のことを **ダックタイピング** といいます。

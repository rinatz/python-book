# クラス

クラスとは新しい型を定義するための仕組みです。クラスを使うことで複数の変数と関数を集約した変数を作ることができるようになります。

## 定義

クラスを定義するには `class` キーワードにクラス名を付けて定義します。下記の `Rectangle` クラスは長方形に関する情報を扱うクラスで、長方形の幅と高さをメンバ変数として持ったクラスになります。

```python hl_lines="5 6 7 8"
#!/usr/bin/env python
# -*- coding: utf-8 -*-


class Rectangle:
    def __init__(self, width, height):
        self.width = width
        self.height = height


def main():
    rectangle = Rectangle(10, 20)

    print(f'The value of width is {rectangle.width}')
    print(f'The value of height is {rectangle.height}')


if __name__ == '__main__':
    main()
```

## `__init__()`

`__init__()` はインスタンス化するときに必ず呼び出される初期化関数です。引数には初期化に必要な値を渡すことができます。ただし第 1 引数は必ず `self` という引数にして下さい。`self` については後述します。

クラスで扱うメンバ変数を定義したいときは次のようにします。

```python hl_lines="3 4"
class Rectangle:
    def __init__(self, width, height):
        self.width = width
        self.height = height
```

これはクラスのメンバ変数として `width, height` を用意するという意味になります。これで `Rectangle` という型が作成され、その型は `width, height` をメンバ変数として持っていることになります。

`width` に `10` 、`height` に `20` を渡して `Rectangle` の変数を作るには次のようにします。

```python
def main():
    rectangle = Rectangle(10, 20)

    print(f'The value of width is {rectangle.width}')
    print(f'The value of height is {rectangle.height}')
```

## `self`

`Rectangle` をインスタンス化する際は `10, 20` という 2 つの値しか渡してないのに `__init__()` の第 1 引数には `self` という変数が含まれており、合計 3 つの引数が用意されています。これは一体どういうことでしょうか。この謎はクラスのインスタンス化の仕組みを理解すれば分かってきます。

`rectangle = Rectangle(10, 20)` という処理をイメージで説明すると、だいたいこんな感じになります。

```python
rectangle = (Rectangle クラスの変数を用意)  # この時点では rectangle.width, rectangle.height は存在しない
Rectangle.__init__(rectangle, 10, 20)       # rectangle.width = width, rectangle.height = height という処理が実行される
```

すなわち `self` というのはクラスインスタンスを表す変数です。

## 関数

クラスには関数を定義することもできます。クラスのメンバとして定義された関数はメソッドとも呼ばれます。

```python hl_lines="10 11 16"
#!/usr/bin/env python
# -*- coding: utf-8 -*-


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
#!/usr/bin/env python
# -*- coding: utf-8 -*-


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

`Square` クラスは `Rectangle` クラスのメンバを全て引き継いだクラスになっており、これをクラスの継承といいます。`Rectangle` が長方形を扱うクラスなのに対し、`Square` は正方形を扱うクラスになっており、`Rectangle` が持つ全てのメンバ `square.width, square.height, square.area()` が参照できます。

## インターフェース

Python にはインターフェースが存在しません。また多態性を実現するのにクラスに継承関係を作る必要もありません。それを確認するために継承関係にない 2 つのクラス `A, B` を作ってみます。またメソッドとして `greet()` という関数をそれぞれのクラスで定義しておきます。

```python hl_lines="5 6 13 14"
class A:
    def __init__(self):
        pass

    def greet(self):
        print('This is class A')


class B:
    def __init__(self):
        pass

    def greet(self):
        print('This is class B')
```

次に `greet()` 関数をメンバに持った変数を受け取るような関数 `call()` を次のように作成します。

```python
def call(x):
    x.greet()
```

この関数に `A, B` の変数をそれぞれ渡してみます。

```python
def main():
    call(A())
    call(B())
```

ソースコードの全体は次のようになります。

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-


class A:
    def __init__(self):
        pass

    def greet(self):
        print('This is class A')


class B:
    def __init__(self):
        pass

    def greet(self):
        print('This is class B')


def call(x):
    x.greet()


def main():
    call(A())
    call(B())


if __name__ == '__main__':
    main()
```

このコードは問題なく実行することができます。Python は例え継承関係を持っていなくてもクラスの構造（メンバ変数や関数の名前・引数）が一致していれば同種の型として扱えるようになります。このような多態性の実現方法のことを **ダックタイピング** といいます。

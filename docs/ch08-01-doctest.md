# doctest

Python にはソースコードのドキュメンテーションをサポートするための docstring という文字列を使ってドキュメントを作成することができます。さらに docstring には関数の使用例を記述するための構文が用意されています。またその使用例を示すコードは関数が実際に記述したとおりに振る舞うかどうかをテストする機能も備わっており doctest と呼ばれます。

**main.py**

```python
#!/usr/bin/env python


"""
サンプルモジュールです。

このモジュールは factorial() という関数を提供しており、次のように使用します。

>>> factorial(5)
120
"""


import math


def factorial(n):
    """n >=0 であるような整数に対する階乗を計算します。

    >>> [factorial(n) for n in range(6)]
    [1, 1, 2, 6, 24, 120]

    >>> factorial(30)
    265252859812191058636308480000000
    >>> factorial(-1)
    Traceback (most recent call last):
        ...
    ValueError: n >= 0 である必要があります

    浮動小数点型も渡せますが、その値は整数値である必要があります。
    >>> factorial(30.1)
    Traceback (most recent call last):
        ...
    ValueError: n は整数でなければいけません
    >>> factorial(30.0)
    265252859812191058636308480000000

    極端に大きな整数値を渡しても階乗の計算はできません。
    >>> factorial(1e100)
    Traceback (most recent call last):
        ...
    OverflowError: n の値が大きすぎます
    """

    if not n >= 0:
        raise ValueError('n >= 0 である必要があります')
    if math.floor(n) != n:
        raise ValueError('n は整数でなければいけません')
    if n + 1 == n:
        raise OverflowError('n の値が大きすぎます')

    result = 1
    factor = 2

    while factor <= n:
        result *= factor
        factor += 1

    return result


if __name__ == '__main__':
    import doctest
    doctest.testmod()
```

`"""..."""` のようにトリプルクオテーションで囲まれた文字列が docstring です。通常はソースコード・関数・クラスの先頭部分で記述します。`>>>` から始まる行

```python
>>> factorial(5)
120
```

は Python のコードを記述するための行で、その処理を実行したらどのように振る舞うのかを `>>>` の下部に記述します。実行時に例外を送出する場合はその旨を記述することもできます。

```python
>>> factorial(-1)
Traceback (most recent call last):
    ...
ValueError: n >= 0 である必要があります
```

docstring 内のコードが記述したとおりに動くかどうかを確認するためには doctest モジュールを使用します。

```python
import doctest
doctest.testmod()
```

このように記述しておき

```shell
$ python main.py
```

と実行すると doctest が走ります。`factorial()` の実装が期待通りになっている場合は何も表示されませんが、もしバグが混入していた場合はエラーメッセージが出力されます。下記は `result = 1` の部分を `result = 10` と書いてしまっていた場合の doctest の実行結果になります。

```shell
$ python main.py
**********************************************************************
File "main.py", line 9, in __main__
Failed example:
    factorial(5)
Expected:
    120
Got:
    1200
**********************************************************************
File "main.py", line 20, in __main__.factorial
Failed example:
    [factorial(n) for n in range(6)]
Expected:
    [1, 1, 2, 6, 24, 120]
Got:
    [10, 10, 20, 60, 240, 1200]
**********************************************************************
File "main.py", line 23, in __main__.factorial
Failed example:
    factorial(30)
Expected:
    265252859812191058636308480000000
Got:
    2652528598121910586363084800000000
**********************************************************************
File "main.py", line 35, in __main__.factorial
Failed example:
    factorial(30.0)
Expected:
    265252859812191058636308480000000
Got:
    2652528598121910586363084800000000
**********************************************************************
2 items had failures:
   1 of   1 in __main__
   3 of   6 in __main__.factorial
***Test Failed*** 4 failures.
```

## なぜ doctest を使うのか

doctest を使うことで次のような機能を提供することができます。

- プログラムの使用例をドキュメントに記述できる
- その使用例が単体テストとして使用できる
- プログラムの実装と使用例が同期しているかどうか用意に確認できる

プログラムの使い方を記述しておくことはとても重要なことですが、ドキュメントというのは時間が経つと形骸化しやすいものです。しかし doctest を使ってドキュメントを管理しておくとプログラムの内容と同期が取れているかどうかを簡単に確認できるため、形骸化することがなくなります。

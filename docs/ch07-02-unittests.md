# 単体テスト

Python には単体テストを書くためのフレームワークがいくつかあります。

| フレームワーク | 説明               |
|----------------|--------------------|
| unittest       | 標準ライブラリ     |
| nose           | かつては主流だった |
| pytest         | 現在主流のもの     |

上記の通り Python は標準ライブラリを使って単体テストを書くことができますが、サードパーティ製の pytest の使い勝手が良いため、pytest を使って書かれることが多いです。そこでここでは pytest の簡単な使い方について説明します。

## 準備

[プロジェクト構成](./ch04-06-project-structures.md) を参考に、単体テストのソースコードは `tests` 配下に作成するようにします。ソースコードが 1 つで十分な場合はディレクトリを作らなくても構いません。

下記のような構成でファイルを作成し、素数判定のコードをテストしてみましょう。

```shell
prime
├── prime.py
└── test_prime.py
```

## インストール

pipenv を使ってインストールします。

```shell
$ mkdir fibonacci
$ cd fibonacci
$ pipenv install -d pytest
```

`-d` というのは開発時にだけ必要となるパッケージをインストールするときに指定するフラグです。単体テストは通常開発時にしか必要ないため大抵のケースで pytest は `-d` を指定してインストールするのが良いでしょう。

## テストの書き方

まず素数判定を行う関数を書きます。


**prime.py**

```python
def is_prime(n: int) -> bool:
    if n <= 1:
        return False

    if n == 2:
        return True

    if n % 2 == 0:
        return False

    i = 3

    while i * i <= n:
        if n % i == 0:
            return False

        i += 2

    return True
```

今回はこのプログラムを直接実行するわけではないため、シバンや `main()` は不要です。次にこの関数に対するテストを下記のように記述します。

**test_prime.py**

```python
from prime import is_prime


def test_is_prime():
    assert not is_prime(0)
    assert not is_prime(1)
    assert is_prime(2)
    assert is_prime(3)
    assert not is_prime(4)
    assert is_prime(5)
```

pytest は `test_` で始まるファイル・関数を単体テストのコードとみなします。テストしたい関数を `import` 文で取り込み、`assert` という文の後ろにテストしたい式を記述します。

## テスト実行

テストを実行するには `pytest` というコマンドを使います。

```shell
$ pipenv shell
(prime) $ pytest test_prime.py
============================================== test session starts ==============================================
platform darwin -- Python 3.7.3, pytest-4.5.0, py-1.8.0, pluggy-0.11.0
rootdir: /Users/kenichiro-ida/Documents/github.com/rinatz/prime
collected 1 item                                                                                                

test_prime.py .                                                                                           [100%]

=========================================== 1 passed in 0.02 seconds ============================================
```

素数判定が正しく実装されていなかった場合の挙動を確認するため、`is_prime()` から次の行を無効にして再度テストを実行してみます。

**prime.py**

```python hl_lines="8 9"
def is_prime(n: int) -> bool:
    if n <= 1:
        return False

    if n == 2:
        return True

    # if n % 2 == 0:
    #     return False

    i = 3

    while i * i <= n:
        if n % i == 0:
            return False

        i += 2

    return True
```

```shell
(prime) $ pytest test_prime.py
============================================== test session starts ==============================================
platform darwin -- Python 3.7.3, pytest-4.5.0, py-1.8.0, pluggy-0.11.0
rootdir: /Users/kenichiro-ida/Documents/github.com/rinatz/prime
collected 1 item                                                                                                

test_prime.py F                                                                                           [100%]

=================================================== FAILURES ====================================================
_________________________________________________ test_is_prime _________________________________________________

    def test_is_prime():
        assert not is_prime(0)
        assert not is_prime(1)
        assert is_prime(2)
        assert is_prime(3)
>       assert not is_prime(4)
E       assert not True
E        +  where True = is_prime(4)

test_prime.py:9: AssertionError
=========================================== 1 failed in 0.09 seconds ============================================
```

`is_prime(4)` が `True` になっているというエラーメッセージが出力されています。

[pytest]: https://docs.pytest.org/en/latest/

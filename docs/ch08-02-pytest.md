# pytest

Python には単体テストを書くためのフレームワークがいくつかあります。

| フレームワーク | 説明               |
|----------------|--------------------|
| unittest       | 標準ライブラリ     |
| nose           | かつては主流だった |
| pytest         | 現在主流のもの     |

上記の通り Python は標準ライブラリを使って単体テストを書くことができますが、サードパーティ製の pytest の使い勝手が良いため、pytest を使って書かれることが多いです。そこでここでは pytest の簡単な使い方について説明します。

## 準備

[プロジェクト構成](./ch04-07-project-structures.md) を参考に、単体テストのソースコードは `tests` 配下に作成するようにします。ソースコードが 1 つで十分な場合はディレクトリを作らなくても構いません。

下記のような構成でファイルを作成し、素数判定のコードをテストしてみましょう。

```shell
prime
├── prime.py
└── test_prime.py
```

!!! warning "注意"
    テストを複数ファイルに分割して書く場合は `tests` ディレクトリを作成し、その中に `__init__.py` を含めるようにしてください。`__init__.py` がないとテストが正しく実行できなくなります。詳しくは [ディレクトリ構成](./ch04-07-project-structures.md) を参考にしてください。

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
    assert not is_prime(1)
    assert is_prime(2)
    assert is_prime(3)
    assert not is_prime(4)
    assert is_prime(5)
    assert not is_prime(6)
    assert is_prime(7)
    assert not is_prime(8)
    assert not is_prime(9)
    assert not is_prime(10)
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

## パラメータ化したテスト

上記の例では `is_prime(4)` のテストに失敗すると、その時点でテストが終わってしまうため、`is_prime(5)` 以降のテストがどうなるかは分かりませんでした。このようなケースでは **パラメータ化したテスト** を作ることで `1～10` までのすべての値をテストできるようになります。

パラメータ化したテストはテスト内で使用するパラメータを関数の引数として渡せるように書き直したテストのことです。パラメータ化したテストでテストを記述した場合は、すべてのパラメータのテストを実行するまでテストが続行されます。チュートリアルの `test_is_prime()` をパラメータ化したテストで書き直すと次のようになります。

```python
import pytest

from prime import is_prime


@pytest.mark.parametrize(('number', 'expected'), [
    (1, False),
    (2, True),
    (3, True),
    (4, False),
    (5, True),
    (6, False),
    (7, True),
    (8, False),
    (9, False),
    (10, False),
])
def test_is_prime(number, expected):
    assert is_prime(number) == expected
```

`@pytest.mark.parametrize()` はデコレータと呼ばれるもので、これにテストで使用するパラメータを記述します。デコレータの最初の引数 `('number', 'expected')` はテスト関数に渡すパラメータの引数名になります。第 2 引数は実際に渡すパラメータの値をタプルのリストとして記述します。

```python
@pytest.mark.parametrize(('number', 'expected'), [
    (1, False),
])
```

のように記述すると `test_is_prime(1, False)` が実行されます。複数記述すればその分だけ `number, expected` に値が渡され `test_is_prime()` が実行されます。

### 注意点

デコレータの書き方には注意して下さい。次のいずれも正しい書き方ではありません。

**スペルミス**

!!! warning "誤"
    `@pytest.mark.parameterized`

!!! check "正"
    `@pytest.mark.parametrized`

**文字列をタプルにしていない**

!!! warning "誤"
    ```python
    @pytest.mark.parametrized('number', 'expected', [
        ...
    ])
    ```

!!! check "正"
    ```python
    @pytest.mark.parametrized(('number', 'expected'), [
        ...
    ])
    ```

**タプルをリストの要素としない**

!!! warning "誤"
    ```python
    @pytest.mark.parametrized(('number', 'expected'),
        (1, False),
        (2, True),
        ...
    )
    ```

!!! check "正"
    ```python
    @pytest.mark.parametrized(('number', 'expected'), [
        (1, False),
        (2, True),
        ...
    ])
    ```

## フィクスチャ

フィクスチャはテストの実行前後で行いたい前処理・後処理を記述するために使用する関数のことです。各テストで同じ前処理・後処理を行う必要がある場合に暗黙的にそれが実行できるようになります。

### ファイルを扱うテスト

ファイルを扱う関数はフィクスチャが有効です。今ファイルから整数を受け取り、それを昇順に読み込む関数を考えます。

```python
from typing import List


# List[int] で要素が int のリスト型を表す型ヒントになる
def load_numbers_sorted(txt: str) -> List[int]:
    numbers = []

    with open(txt) as f:
        numbers = sorted(map(lambda e: int(e), f))

    return numbers
```

この関数は入力値としてファイルのパスを受け取ります。そのため、事前にファイルを用意しなければいけません。このファイルを用意するためにフィクスチャが利用できます。

!!! warning "注意"
    関数がファイルを必要とするからと言ってテスト用のファイルをあらかじめリポジトリにコミットするようなことは避けるべきです。そのようなことをするとテストパターンが増えるたびにファイルも増えてしまい、管理が複雑になります。

### 前処理の書き方

下記のような整数を保存したファイルを用意して `load_numbers_sorted()` のためのテスト `test_load_numbers_sorted()` を作成してみます。

**numbers.txt**

```
2
5
4
3
1
```

`test_load_numbers_sorted()` が実行される前にファイルを用意する必要があるため次のようにフィクスチャを使ってファイルを作成します。

```python
import pytest


@pytest.fixture
def txt() -> str:
    with open('numbers.txt', 'w') as f:
        for n in [2, 5, 4, 3, 1]:
            f.write('{}\n'.format(n))

    yield 'numbers.txt'
```

`numbers.txt` というファイルを作り、そのファイル名を返却しています。このフィクスチャを使って `test_load_numbers_sorted()` を実行するには次のようにします。

```python
def test_load_numbers_sorted(txt):
    assert load_numbers_sorted(txt) == [1, 2, 3, 4, 5]
```

テスト関数にフィクスチャと同じ名前の引数 `txt` を渡します。すると `txt` にはフィクスチャ `txt()` の戻り値 `numbers.txt` が入ってきます。このコードを実行すると

1. `txt()` が呼ばれる
1. `numbers.txt` が作成される
1. `test_load_numbers_sorted('numbers.txt')` が呼ばれる

という振る舞いをします。

### 後処理の書き方

`numbers.txt` はテストが終われば不要なため、後処理としてファイルを削除してあげましょう。ファイルを削除するにはフィクスチャ `txt()` に次の行を追加します。

```python
import os


@pytest.fixture
def txt() -> str:
    ...

    yield 'numbers.txt'

    os.remove('numbers.txt')
```

こうするとテストが終わると `os.remove('numbers.txt')` が呼び出され、ファイルが削除されます。つまりフィクスチャは

```python
@pytest.fixture
def txt():
    # 前処理

    yield ...   # テスト関数に何らかの値を渡す

    # 後処理
```

という構造をしています。`test_load_numbers_sorted(txt)` の引数 `txt` はフィクスチャ `txt()` で
何を返したかで型が決まります。

### フィクスチャの連携

フィクスチャから別のフィクスチャを呼び出すこともできます。

```python
@pytest.fixture
def txt_and_list(txt) -> Tuple[str, List[int]]:
    yield txt, [1, 2, 3, 4, 5]


def test_load_numbers_sorted(txt_and_list):
    assert load_numbers_sorted(txt_and_list[0]) == txt_and_list[1]
```

この場合 `txt() -> txt_and_list()` の順にフィクスチャが実行され、その結果が `test_load_numbers_sorted()` に渡されます。

### テンポラリの作成

pytest には安全にテンポラリを作成するための `tmpdir` というフィクスチャがあらかじめ用意されています。先に見た例ではファイルがローカルに作られるため、大量のファイルが作られるとディレクトリが汚れてしまいますが `tmpdir` を使うと `/tmp` 配下にファイルを作成するため、ファイル管理がスマートになります。

`tmpdir` の使い方は次のとおりです。

```python
@pytest.fixture
def txt(tmpdir) -> str:
    tmpfile = tmpdir.join('numbers.txt')

    with tmpfile.open('w') as f:
        for n in [2, 5, 4, 3, 1]:
            f.write('{}\n'.format(n))

    yield str(tmpfile)

    tmpfile.remove()
```

### フィクスチャのスコープ

通常フィクスチャはテスト単位で呼び出されます。

```python
def test_sample1(txt):
    ...


def test_sample2(txt):
    ...
```

この場合、フィクスチャ `txt()` は各テスト関数を実行するたびに毎回呼び出されます。場合によってはこれが非効率で冗長になることもあります。このような場合はフィクスチャが呼び出されるタイミングを次のようにして変更することができます。

```python
@pytest.fixture(scope='module')
def txt(tmpdir) -> str:
    ...
```

`scope` に指定できる値は次のとおりです。

| scope    | 説明                                                        |
| -------- | ----------------------------------------------------------- |
| function | テスト関数ごとにフィクスチャを実行（デフォルト）            |
| module   | 同一モジュール（ソースコード）内で1回だけフィクスチャを実行 |
| class    | 同一クラス内で1回だけフィクスチャを実行                     |
| session  | テスト実行時に1回だけフィクスチャを実行                     |

ただフィクスチャのスコープはむやみに広げないほうが良いです。フィクスチャの設定をテスト間で共有すると依存関係が生まれてしまい、不意にテストが成功してしまうケースがあるからです。テスト関数ごとにフィクスチャを実行しても問題ない場合はそのようにすべきです。

### conftest.py

複数のファイルをまたいで共通のフィクスチャを使用したいこともあると思います。そのような時はフィクスチャを `conftest.py` というファイルに定義しましょう。`conftest.py` 内のフィクスチャは pytest によって自動的にインポートされ、`conftest.py` があるディレクトリ配下で暗黙的に参照できるようになります。

```
.
└─tests
    ├─conftest.py .............. 全テストで参照可能
    ├─test_sample1
    │  ├─conftest.py .......... test_sample2.py, test_sample3.py で参照可能
    │  ├─test_sample2.py
    │  └─test_sample3.py
    └─test_sample4
        ├─conftest.py .......... test_sample5.py, test_sample6.py で参照可能
        ├─test_sample5.py
        └─test_sample6.py
```

## 標準出力のキャプチャ

標準出力にメッセージを出力する関数をテストしたい時には標準出力をキャプチャして出力されたメッセージを確認することができます。例えば次のようなフィボナッチ数列を出力する関数を考えます。

```python
def fibonacci(n: int):
    a = 0
    b = 1

    for _ in range(n):
        print(b)

        a, b = b, a + b
```

この関数を `fibonacci(5)` として呼び出すと標準出力には

```
1
1
2
3
5
```

と出力されます。本当にこのように出力されるかどうかをテストしたい時には次のように書きます。

```python
def test_fibonacci(capsys):
    fibonacci(5)

    out, _ = capsys.readouterr()

    assert out == (
        '1\n'
        '1\n'
        '2\n'
        '3\n'
        '5\n'
    )
```

`capsys` は標準出力と標準エラー出力をキャプチャするためのフィクスチャです。

```python
capsys.readouterr()
```

はキャプチャした標準出力と標準エラー出力の文字列をタプルとして返します。

## モック

モックとは関数やクラスが相互に依存して動作する時に、依存する関数やクラスが正しく使われているかどうかをテストする時に使われるオブジェクトのことです。例えば次のコードを見てみましょう。

**interaction.py**

```python
def send(message: str):
    receive(message)


def receive(message: str):
    print('received: {}'.format(message))
```

いま関数 `send()` は引数で受け取った文字列を `receive()` にそのまま渡さなければならないという仕様があったとします。このとき、 `send()` が仕様どおりに実装されているかどうかをテストするためには

- `send()` は `receive()` を1回だけ呼び出しているか？
- `send()` が受け取った文字列は `receive()` にそのまま渡されているか？

を確認する必要があります。もしこの振る舞いをテストで確認することができれば

```python
def send(message: str):
    receive('[1]: {}'.format(message))
    receive('[2]: {}'.format(message))
```

のように仕様に沿っていない実装を間違った実装として検出できるようになります。モックを使うとこのような確認がテストできるようになります。

### モックの使い方

モックを使うには [pytest-mock] という pytest のプラグインを使用します。インストールは pipenv で次のようにできます。

```shell
$ pipenv install -d pytest-mock
```

`send()` が正しい形式で `receive()` を呼び出しているかどうかを確認するためには `receive()` が受け取った引数と呼び出し回数を記憶する仕組みが必要になります。それを実現するために `receive()` を偽の実装にすり替えて、引数や呼び出し回数を保存できるオブジェクト（すなわちモック）にするというアプローチを取ります（これをモンキーパッチといいます）。`pytest-mock` をインストールすると `mocker` というフィクスチャが使用できるようになります。この `mocker` を使って次のように `receive()` をモックにすることができます。

```python
def test_send(mocker):
    receive = mocker.patch('studies.interaction.receive')
```

`mocker.patch()` は引数で受け取った文字列の関数をモック化して返す関数です。`mocker.patch()` を呼び出した後では `send()` が呼び出す `receive()` は `interaction.py` で定義された `receive()` の代わりにモック化された偽の `receive()` が呼び出されるようになります。

```python
def test_send(mocker):
    receive = mocker.patch('studies.interaction.receive')

    send('Hello World!')
```

ここで呼び出した `send()` は内部で `receive()` を呼んでいますがその `receive()` は `mocker.patch()` が作成したモック化された `receive` になります。そしてこの `receive` は引数で受け取った値や呼び出し回数を記録したオブジェクトになっています。

さらに次のような行をテストコードに追加してみましょう。

```python
receive.assert_called_once_with('Hello World!')
```

これは `receive()` が `'Hello World!'` という文字列を受け取って 1 回だけ呼び出されたかどうかを確認するテストになります。テストコード全体は次のとおりになります。

```python
def test_send(mocker):
    receive = mocker.patch('studies.interaction.receive')

    send('Hello World!')

    receive.assert_called_once_with('Hello World!')
```

試しに `send()` の実装をわざと間違えた実装にしてみましょう。`receive.assert_called_once_with()` のところでテストが失敗するはずです。

### 呼び出し履歴の確認

モック `receive` は自分がどのような引数で何回呼ばれたのかを履歴として残しています。その呼び出し履歴を参照するには `receive.call_args_list` を参照します。

```python
>>> receive.call_args_list
[call('Hello World!')]
```

これは `receive()` が `'Hello World!'` を引数として1回だけ呼ばれたことを意味します。このリストの内容を確認しても `send()` が `receive()` を正しく呼んだかどうかをテストすることができます。

```python
def test_send(mocker):
    receive = mocker.patch('studies.interaction.receive')

    send('Hello World!')

    assert receive.call_args_list == [
        mocker.call('Hello World!'),
    ]
```

例えば `send()` が次のように実装されていたとすると

```python
def send(message: str):
    receive('[1]: {}'.format(message))
    receive('[2]: {}'.format(message))
```

呼び出し履歴のテストは

```python
assert receive.call_args_list == [
    mocker.call('[1]: Hello World!'),
    mocker.call('[2]: Hello World!'),
]
```

と書くことができます。

### 戻り値の定義

`send()` の振る舞いが `receive()` の戻り値に依存して変わるケースを考えます。

```python
def send(message: str):
    ok = receive(message)

    if ok:
        print('success')
    else:
        print('failure')


def receive(message: str) -> bool:
    print('received: {}'.format(message))

    return True
```

この場合 `receive()` の戻り値に応じて `send()` が出力するメッセージが変わることをテストで確認する必要が出てきます。サンプルの `receive()` は常に `True` しか返さないので、 `False` を返した時の
`send()` の振る舞いが確認できません。このような場合でもモックを使って `receive()` の戻り値を上手く制御することができます。

```python
def test_send(mocker, capsys):
    receive = mocker.patch('studies.interaction.receive', return_value=False)

    send('Hello World!')

    receive.assert_called_once_with('Hello World!')

    out, _ = capsys.readouterr()

    assert out == 'failure\n'
```

`mocker.patch()` の引数に `return_value=False` を渡すと `send()` 内で呼び出している `receive()` は `False` を返すように偽装されます。

### スパイ

モックを使うと `receive()` の実装は完全に別物に置き換わりますが場合によっては本物の `receive()` を呼びつつ、呼び出し回数を確認したいこともあると思います。そのような場合はスパイを作成することで実現できます。例えば `receive()` が `studies/interaction.py` に定義されている場合

```python
import studies.interaction

receive = mocker.spy(studies.interaction, 'receive')
```

とすることでスパイを作成することができます。`mocker.spy()` が返却する関数は本物の `receive()` に `assert_called_once_with()` などのメソッドが追加されたインスタンスになります。使い方はモンキーパッチの場合と同様です。

[pytest]: https://docs.pytest.org/en/latest/
[pytest-mock]: https://github.com/pytest-dev/pytest-mock

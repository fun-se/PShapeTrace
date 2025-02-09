# PShapeTrace

PShapeTrace は Processing のプログラムが実行する描画命令を記録し、
実行された命令と、画面に表示されている図形の対応関係を可視化するライブラリです。

PDE（Processing Development Environment）で導入することで、
実行したプログラム内の図形がどのような関数・引数によって描画されたのかを表示することができます。
また、実行を一時停止させたり、過去のフレームに巻き戻して表示させたりすることも可能です。


## 導入方法

PShapeTrace は、分析対象のプログラムに直接組み込んで使うプログラムファイルとして作られています。

### 導入例

[exampleディレクトリ](example)に、ツールを導入した状態のプログラムの例が書かれています。以下の手順で実行を確認することができます。

1. [exampleディレクトリ](example) に格納されたすべての pde ファイルをダウンロードします。
2. Processing IDE でダウンロードしたファイルを開きます。プログラムの中身は以下のようになっています。
  - `setup` の中では、ウィンドウのサイズを設定する `size()` の呼び出しを行ったあと、PShapeTrace の設定を行う `extraSettings` を呼び出しています。プログラム用の設定を、その下に記述しています。
  - `drawMain` は、通常のプログラムにおける `draw` の内容を記述しています。
	![demo2](fig/demo2.png)
3. このプログラムを実行すると、実行画面右側に、画面内にある図形の描画情報が一覧表示されます。
描画情報は、"[描画関数を呼び出した関数名]:[描画関数名]\([実際の引数の値])"です。
引数に変数や計算式を使用していた場合でも、その中身の数値が表示されます。
	![demo3](fig/demo3.png)
4. 実行画面の図形をクリックすると、描画情報一覧の内、該当する図形を赤字でハイライトすることができます。
	![demo4](fig/demo4.gif)
5. 実行画面下部の右側に表示されているボタンは一時停止・解除ボタンです。
クリックすると実行の一時停止・解除が行えます。
	![demo5](fig/demo5.gif)
6. 実行画面下部の長方形はタイムラインです。
一時停止中にクリックまたは十字キーを操作すると、過去のフレームにさかのぼって表示させることが可能です。
	![demo7](fig/demo6.gif)
7. 実行の一時停止中・過去のフレーム表示中でも、描画情報一覧のハイライト機能は使用可能です。


### 既存のプログラムに導入する方法

既存の Processing プログラムに PShapeTrace を導入する場合は、以下の操作を行ってください。

1. [toolファイル](example/tool.pde)をダウンロードします。
2. ツールを導入したいプログラムのディレクトリ内に tool ファイルを設置します。
3. 設置した状態で PDE を開くと、tool のタブが増えていることを確認できます。確認できなかった場合は、プログラムを閉じ、開き直してください。
4. プログラムを2箇所書き換えます。
   1. `setup` 関数内で、`size` 関数を呼び出した直後に `extraSettings();`という記述を追加してください。
   2. `draw` 関数の名前を `drawMain` に変更してください。
5. プログラムを実行します。上記の設定が正しく行われていれば、ツールの GUI がウィンドウに表示されます。

ツールの使用を終了する場合は、上記の操作を取り消すための以下の操作を行います。

 - `setup` 関数の中の `extraSettings();` という行を取り除く。
 - `drawMain` 関数の名前を `draw` 関数に変更する。
 - `tool.pde` ファイルを削除する。


### ツールを有効にした状態の最小限のプログラム

PShapeTrace が使える状態の最小限のプログラムは以下の通りです。

 - `setup` 関数を定義し、ウィンドウのサイズ設定を行った後に `extraSettings();` を呼び出す記述を行う。
 - `drawMain` 関数を定義し、ウィンドウに描きたいプログラムを書く。
 - [toolファイル](example/tool.pde) を、プログラムと同一のディレクトリに配置する。

以下に記述例を示します。

```java
void setup() {
  size(400, 300);
  extraSettings();
  
}

void drawMain() {
  background(0);
    
}
```


## 使用上の注意

分析対象のプログラムは、PShapeTrace の機能と競合しないよう、いくつかの制限を受けます。

- ウィンドウのサイズを定義する関数`size`を必ず使用してください。`fullScreen`および 3D には非対応です。
- `setup`内に記述を追加したい場合は、`extraSettings`の呼び出しより後に記述してください。
  また、`size`より前に記述を追加しないでください。
- フレーム内の図形描画情報のリセットを`background`により検知しているので、`drawMain`(`draw`)内で`background`を使用するようにしてください。


## Publication

本ツールについては、下記論文で発表されています。

```
@article{yamasaki_2024,
	title = {Processingプログラミング初学者のための 図形描画命令の実行と描画結果の対応関係の可視化},
	volume = {2024},
	url = {https://ipsj.ixsq.nii.ac.jp/ej/index.php?active_action=repository_view_main_item_detail&page_id=13&block_id=8&item_id=239264&item_no=1},
	abstract = {情報学広場 情報処理学会電子図書館},
	language = {ja},
	urldate = {2024-09-18},
	journal = {ソフトウェアエンジニアリングシンポジウム2024論文集},
	author = {山崎, 雄太 and 石尾, 隆},
	month = sep,
	year = {2024},
	pages = {232--239},
    note = {本論文は「一般論文」カテゴリで発表されました。The paper is unreviewed by the program committee of the event.}
}
```


## License

本プロジェクトは MIT ライセンスのもとで公開されています。
詳しい条件は [LICENSE](https://github.com/yourusername/PShapeTrace/blob/main/LICENSE) をご覧ください。

This project is licensed under the MIT License. See the [LICENSE](https://github.com/yourusername/PShapeTrace/blob/main/LICENSE) file for details.

## Acknowledgements

本プロジェクトは科研費 No.JP20H05706 の補助を受けて実施された研究の成果物です。

# PShapeTrace

PShapeTrace は Processing のプログラムが実行する描画命令を記録し、
実行された命令と、画面に表示されている図形の対応関係を可視化するライブラリです。

PDE（Processing Development Environment）で導入することで、
実行したプログラム内の図形がどのような関数・引数によって描画されたのかを表示することができます。
また、実行を一時停止させたり、過去のフレームに巻き戻して表示させたりすることも可能です。

## デモ
ダウンロードしたツール導入済ファイルにプログラムを記述する方法のデモです。
1. [exampleファイル](example)をダウンロードします。
2. Processing IDE でダウンロードしたファイルを開き、プログラムを記述します。
  - `setup`内に記述したいプログラムは、`extraSettings`より下に記述してください。
  - `drawMain`を通常の`draw`と同様に扱ってください。
	![demo2](demo2.png)
3. 実行を行うと、実行画面右側には、画面内にある図形の描画情報を一覧で表示します。
描画情報は、"[描画関数を呼び出した関数名]:[描画関数名]\([実際の引数の値])"です。
引数に変数を使用していた場合でも、数値として表示されます。
	![demo3](demo3.png)
4. 実行画面の図形をクリックすると、描画情報一覧の内、該当する図形を赤字でハイライトすることができます。
	![demo4](demo4.gif)
5. 実行画面下部の右側に表示されているボタンは一時停止・解除ボタンです。
クリックすると実行の一時停止・解除が行えます。
	![demo5](demo5.gif)
6. 実行画面下部の長方形はタイムラインです。
一時停止中にクリックまたは十字キーを操作すると、過去のフレームにさかのぼって表示させることが可能です。
	![demo7](demo6.gif)
7. 実行の一時停止中・過去のフレーム表示中でも、描画情報一覧のハイライト機能は使用可能です。

## 導入方法
ここでは、既存の Processing プログラムに PShapeTrace を導入する方法について説明します。
1. [toolファイル](example/tool.pde)をダウンロードします。
2. ツールを導入したいプログラムのディレクトリ内に tool ファイルを設置します。
3. 設置した状態で PDE を開くと、tool のタブが増えていることを確認できます。確認できなかった場合は、プログラムを閉じ、開き直してください。
4. プログラムを2箇所書き換えます。
   1. `setup`内で、`size`関数を呼び出した直後に`extraSettings();`という記述を追加してください。
   2. `draw`関数の名前を`drawMain`に変更してください。
5. プログラムを実行すると、ツールが導入された状態で実行されます。

ツールを解除したい場合は、この手順と逆の手順で操作を行なってください。

## 使用上の注意
- ウィンドウサイズを定義する関数`size`を必ず使用してください。`fullScreen`および 3D には非対応です。
- `setup`内に記述を追加したい場合は、`extraSettings`より後に記述してください。
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

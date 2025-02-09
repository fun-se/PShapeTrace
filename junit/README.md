# JUnit test cases for PShapeTrace

プロパティ processing.path に processing のインストールディレクトリ（processing-java.exe が存在するディレクトリ）を設定してください。
以下のように `mvn` のコマンドで直接指定できます。

```
mvn test -Dprocessing.path=C:\Users\username\processing-4.3
```

example ディレクトリにあるサンプルプログラムとツールを Java コードに変換し、
それを使って JUnit のソースコードをコンパイルしたのち、テストケースを実行します。

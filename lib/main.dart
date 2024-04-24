import 'package:flutter/material.dart';

// 中枢！main.dart の main() が最初に呼ばれる
void main() {
  // 下の MyApp を run するよ〜
  runApp(const MyApp());
}

// こちらが MyApp
// Widget を使うよってことで Widget を extend したクラスを作る
// StatelessWidget に関しては後で説明するよ！
class MyApp extends StatelessWidget {
  // コンストラクタ
  // クラスが作られたときにクラス内で使う変数を初期化するためのもの
  // 今回は変数がないのでデフォルトの Key のみ突っ込まれてる
  // Key, super の説明は今回は省略
  const MyApp({super.key});

  // MaterialApp を作って返して表示させるよ！
  // MaterialApp は Flutter アプリケーションの全体を管理するもので，全体のデザイン `theme: ` や
  // 画面遷移をする場合の状態監視，最初に表示させるページ `home: ` を指定しているよ
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // OS のテーマ設定に合わせて変更できる
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // 最初に表示させるページをは下の MyHomePage
      // 引数として title 渡してる（無くてもいいよ）
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// こちらが　MyHomePage
// StatefulWidget に関しても後で説明するよ！！！！！
class MyHomePage extends StatefulWidget {
  // title を受け取ってるね👀
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold は土台みたいな感じ（白紙みたいな）
    return Scaffold(
      // AppBar は上のヘッダー
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // Center で真ん中寄せ
      body: Center(
        // Column は [] の中身を縦に並べてくれる widget
        // Row で横になるよ
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      // 右下のプラスボタン（Floating Action Button と言います）
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';

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
  int _counter2 = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _twice() {
    setState(() {
      _counter2 = _counter2 * 2;
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
              '足し算',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text(
              '２倍されてく',
            ),
            Text(
              '$_counter2',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      // 右下のプラスボタン（Floating Action Button と言います）
      floatingActionButton: Row(
        // Row は親サイズまで広がるんだったね！
        // min を指定して自分自身のサイズに合わせるよ
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            // onPressed の書き方はお好みで😘
            // 一行の関数や式を簡潔に記述する場合に便利なアロー関数記法
            // onPressed: () => _twice(),
            // 複数の命令や条件分岐をする場合や print デバッグとか挟んだりする時に便利なブロックボディ記法
            // onPressed: () {
            //   _twice();
            // },
            // 今回は簡潔に，メソッド名だけを指定して Flutter にメソッドの実行を委ねるダイレクトリファレンス記法で！
            onPressed: _twice,
            tooltip: 'Twice',
            child: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}

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
            // Row で横に並べる
            const Row(
              children: [
                // SizedBox で大きさ（論理ピクセル）を決めてあげる
                SizedBox(
                  width: 100,
                  height: 100,
                  // ColoredBox で色を塗ってあげる
                  // 色も用意してくれてる🎨
                  child: ColoredBox(
                    color: Colors.pink,
                  ),
                  // 自分で色指定もできる（丸動かすと自動で RGB 挿入してくれる🥺）
                  // ```
                  // child: ColoredBox(color: Color.fromARGB(255, 85, 170, 116)),
                  // ```
                ),
                SizedBox(
                  width: 80,
                  height: 40,
                  child: ColoredBox(
                    color: Colors.amberAccent,
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 200,
                  child: ColoredBox(
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text(
              '久野だよ〜',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
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

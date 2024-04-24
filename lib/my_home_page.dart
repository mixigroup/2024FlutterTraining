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
  // リストを用意
  final list = ['ドラえもん', 'おぱんちゅうさぎ', 'カレーの恩返し', 'ブラックサンダー'];

  @override
  Widget build(BuildContext context) {
    // Scaffold は土台みたいな感じ（白紙みたいな）
    return Scaffold(
      // AppBar は上のヘッダー
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // ListView を作ってくれるビルダー
      body: ListView.builder(
        // 上で作った list の長さ分リストを作るよ！
        // タイトル分を含めるために +1 してる
        itemCount: list.length + 1,
        // 今回は使わないので BuildContext は省略
        // index に番目が入る
        itemBuilder: (_, index) {
          // index が 0 のときはタイトルを表示
          if (index == 0) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '久野のすきなものリスト〜！',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            );
          }
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              // list の index 番目のテキストを表示
              child: Text(
                // index の0番目はタイトルなので -1 してる
                list[index - 1],
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

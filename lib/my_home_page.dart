import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        child: GridView.count(
          // 横に並べる数
          crossAxisCount: 3,
          // 縦の間隔
          mainAxisSpacing: 50,
          // 横の感覚
          crossAxisSpacing: 50,
          children: List.generate(
            // 並べる個数
            9,
            // 並べる要素
            (index) {
              return const ColoredBox(
                color: Colors.deepPurple,
              );
            },
          ),
        ),
      ),
    );
  }
}

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
      body: const Center(
        // Column は [] の中身を縦に並べてくれる widget
        // Row で横になるよ
        child: Column(
          // 端っこから端っこまで隙間を含めて均等に配置
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              // 端っこからスタートして端っこまで均等に配置
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ColoredBox(color: Colors.deepPurple),
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ColoredBox(color: Colors.deepPurple),
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ColoredBox(color: Colors.deepPurple),
                ),
              ],
            ),
            Row(
              // 端っこから端っこまで均等に配置
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ColoredBox(color: Colors.deepPurple),
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ColoredBox(color: Colors.deepPurple),
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ColoredBox(color: Colors.deepPurple),
                ),
              ],
            ),
            Row(
              // 端っこから端っこまで均等に配置
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ColoredBox(color: Colors.deepPurple),
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ColoredBox(color: Colors.deepPurple),
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ColoredBox(color: Colors.deepPurple),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              // start で左端に並ぶ
              mainAxisAlignment: MainAxisAlignment.start,
              // 要素を下に寄せる
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: ColoredBox(color: Colors.blue),
                ),
                SizedBox(width: 24),
                SizedBox(
                  height: 25,
                  width: 25,
                  child: ColoredBox(color: Colors.blue),
                ),
                SizedBox(width: 24),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: ColoredBox(color: Colors.blue),
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              // center で真ん中寄せに
              // mainAxisAlignment とかにカーソルをあてると
              // `{MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start}`
              // みたいな感じで初期値がわかるよ
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 75,
                  width: 75,
                  child: ColoredBox(color: Colors.pink),
                ),
                // 隙間
                SizedBox(width: 24),
                SizedBox(
                  height: 35,
                  width: 35,
                  child: ColoredBox(color: Colors.pink),
                ),
                SizedBox(width: 24),
                SizedBox(
                  height: 75,
                  width: 75,
                  child: ColoredBox(color: Colors.pink),
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              // end にすることで右端に並ぶ
              mainAxisAlignment: MainAxisAlignment.end,
              // start にすることで上に寄せる
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ColoredBox(color: Colors.green),
                ),
                SizedBox(width: 24),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: ColoredBox(color: Colors.green),
                ),
                SizedBox(width: 24),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ColoredBox(color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

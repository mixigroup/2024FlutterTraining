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
  // state 準備！
  String text = '';
  String tmpText = '';

  @override
  Widget build(BuildContext context) {
    // Scaffold は土台みたいな感じ（白紙みたいな）
    return Scaffold(
      // AppBar は上のヘッダー
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'なんか打ってね',
              ),
              // 打った文字が value に入ってくる
              onChanged: (value) {
                tmpText = value;
              },
            ),
          ),
          IconButton(
            onPressed: () {
              // ボタンが押された時に state に反映
              setState(() {
                text = tmpText;
              });
            },
            icon: const Icon(Icons.arrow_downward_rounded),
          ),
          // 打った文字を表示
          Text(text),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  // リポジトリ取得するメソッド
  // async キーワードは関数が非同期であることを示す
  // async を付けた関数は内部で await を使用することができる＆常に Future オブジェクトを返す
  Future<void> getRepositoryList() async {
    // url とパスを書く
    final url = Uri.https('api.github.com', 'users/kno3a87/repos');
    // 今回は get でリポジトリ一覧取得！結果が response に入ってくる！
    // ネットワーク通信は非同期処理なので await で待ってあげる
    final response = await http.get(
      url,
      // ヘッダー書きたいならこう！
      // ```
      // headers: {
      //   'Authorization':
      //       'Bearer <MY-TOKEN>',
      //   'X-GitHub-Api-Version': '2022-11-28',
      //   'Accept': 'application/vnd.github+json'
      // },
      // ```
    );
    // ステータスコードを確認してみる
    // 200OK なら成功！
    debugPrint('Response status: ${response.statusCode}');
    // ボディを確認してみる
    // さっき curl で叩いた時と一緒のものが返ってきてるはず
    debugPrint('Response body: ${response.body}');
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
      body: const Center(
        // Column は [] の中身を縦に並べてくれる widget
        // Row で横になるよ
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      // 右下のプラスボタン（Floating Action Button と言います）
      floatingActionButton: FloatingActionButton(
        onPressed: getRepositoryList,
        tooltip: 'get my repository list',
        child: const Icon(Icons.star),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sample_2024/model/repository.dart';
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
  // state を変更！
  List<Repository> _repositories = [];

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

    // json から dart で扱える（Map<String, dynamic> のリスト）に変換（decode）
    final List list = json.decode(response.body);
    // こういう取得方法になるので typo したりネストしたりが大変！🥺
    // debugPrint(list[0]['name']);

    // リストに入ってる Map<String, dynamic> を map で１つ１つ取り出しさっき作った Repository モデルに変換
    final List<Repository> repositories =
        list.map((item) => Repository.fromJson(item)).toList();
    // 'name' と指定したものが，直接アクセスして取得できるように！
    // ドットを打つと候補が出てくるので便利〜！🎉
    debugPrint(repositories[0].name);

    // ボディを表示してみる
    setState(() {
      _repositories = repositories;
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
      // SingleChildScrollView を使ってスクロールできるようにしてる
      body: _repositories.isEmpty
          ? const SizedBox.shrink()
          : ListView.builder(
              itemCount: _repositories.length,
              itemBuilder: ((context, index) {
                return Text(_repositories[index].name);
              }),
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

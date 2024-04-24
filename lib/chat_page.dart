import 'package:flutter/material.dart';
import 'package:flutter_sample_2024/model/answer.dart';
import 'package:flutter_sample_2024/post_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.title});

  final String title;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String _text = '';
  // ローディングの表示・非表示を切り替える bool の state を追加
  bool isLoading = false;

  Future<void> postChat(String text) async {
    // ローディング開始！
    setState(() {
      isLoading = true;
    });

    // dart-define コマンドから環境変数を取得
    // Uri.https で接続するときに接頭の http は不要なので注意⚠️
    const apiUrl = String.fromEnvironment('API_URL');
    const deployName = String.fromEnvironment('DEPLOY_NAME');
    const apiKey = String.fromEnvironment('API_KEY');

    // 接続！
    var url = Uri.https(
      apiUrl,
      'openai/deployments/$deployName/chat/completions',
      // クエリパラメタの書き方注意！
      {'api-version': '2024-02-15-preview'},
    );

    final response = await http.post(
      url,
      body: json.encode({
        'messages': [
          {'role': 'user', 'content': text}
        ]
      }),
      headers: {'Content-Type': 'application/json', 'api-key': apiKey},
    );

    // ステータスコード確認！
    debugPrint(response.statusCode.toString());
    // body をそのまま出力すると文字化けしてしまう
    debugPrint(response.body);
    // 文字化けをなくすために utf8 に decode してから json.decode する！
    final bdoy = json.decode(utf8.decode(response.bodyBytes));
    // model に変換！
    final answer = Answer.fromJson(bdoy);

    // ▲ response をみながら返信を state に渡す
    setState(() {
      _text = answer.choices.first.message.content;
      isLoading = false;
    });
  }

  Future<void> openPostPage() async {
    // push で画面遷移
    // pop 時に渡ってきた値は await して取得！
    final v = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PostPage(),
        // fullscreenDialog を true にすることで遷移方法が横ではなく下からになる
        // またヘッダー左上のアイコンが戻るボタンからバツボタンに変わる！
        fullscreenDialog: true,
      ),
    );

    // バツボタンを押して戻ると pop 時に値が渡って来なくて null になってしまうので条件を追加
    if (v != null) {
      await postChat(v);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // Center で真ん中寄せ
      body: Center(
        child: Column(
          children: [
            Text(
              _text,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            isLoading
                ? const CircularProgressIndicator(
                    color: Colors.orange,
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
      // 右下のプラスボタン（Floating Action Button と言います）
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await openPostPage();
        },
        tooltip: 'post',
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}

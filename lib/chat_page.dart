import 'package:flutter/material.dart';
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

  Future<void> postChat(String text) async {
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
    final answer = json.decode(utf8.decode(response.bodyBytes));

    // === response example ===
    // flutter: {
    //   "id": "chatcmpl-9HVE55cvXZfls72I18t5NIwir6dqp",
    //   "object": "chat.completion",
    //   "created": 1713958637,
    //   "model": "gpt-4",
    //   "usage": {
    //     "prompt_tokens": 11,
    //     "completion_tokens": 19,
    //     "total_tokens": 30
    //   },
    //   "choices": [
    //     {
    //       "message": {
    //         "role": "assistant",
    //         "content": "こんにちは、何かお手伝いできることはありますか？"
    //       },
    //       "finish_reason": "stop",
    //       "index": 0,
    //       "logprobs": null,
    //       "content_filter_results": {
    //         "hate": {"filtered": false, "severity": "safe"},
    //         "self_harm": {"filtered": false, "severity": "safe"},
    //         "sexual": {"filtered": false, "severity": "safe"},
    //         "violence": {"filtered": false, "severity": "safe"}
    //       }
    //     }
    //   ],
    //   "prompt_filter_results": [
    //     {
    //       "prompt_index": 0,
    //       "content_filter_results": {
    //         "hate": {"filtered": false, "severity": "safe"},
    //         "self_harm": {"filtered": false, "severity": "safe"},
    //         "sexual": {"filtered": false, "severity": "safe"},
    //         "violence": {"filtered": false, "severity": "safe"}
    //       }
    //     }
    //   ],
    //   "system_fingerprint": null
    // }

    // ▲ response をみながら返信を state に渡す
    setState(() {
      _text = answer['choices'][0]['message']['content'];
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
        child: Text(
          _text,
          style: Theme.of(context).textTheme.headlineMedium,
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

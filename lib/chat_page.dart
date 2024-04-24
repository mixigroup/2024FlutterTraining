import 'package:flutter/material.dart';
import 'package:flutter_sample_2024/model/answer.dart';
import 'package:flutter_sample_2024/post_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.title});

  final String title;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // state を Message 型のリストに変更！
  List<Message> stateMessage = [];
  // List stateMessage = [];
  // ローディングの表示・非表示を切り替える bool の state を追加
  bool isLoading = false;
  // SharedPreferences のインスタンスを作成
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // SharedPreferences に保存するキーを定義
  final key = 'messages';

  // initState は初めてこのウィジェットが作成された時に自動的に一度呼ばれる
  // 初期化処理を書くのに便利
  @override
  void initState() {
    super.initState();
    // await を使うために Future で囲う
    Future(() async {
      // 画面が表示されたときにメッセージを取得
      final SharedPreferences prefs = await _prefs;
      final List<String> messages = prefs.getStringList(key) ?? [];
      // メッセージを state にセット
      setState(() {
        // message を取り出して json に変換してから Message クラスに変換してリストに追加
        stateMessage = messages
            .map((message) => Message.fromJson(json.decode(message)))
            .toList();
      });
    });
  }

  Future<void> postChat(String text) async {
    final SharedPreferences prefs = await _prefs;
    // 今までのメッセージを取得
    // なかったら空のリストを返す
    final List<String> messages = prefs.getStringList(key) ?? [];

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

    final Message myMessage = Message('user', text);
    // 今までのメッセージに今回のメッセージを追加
    // ...はスプレッド演算子といい，リストの要素を展開して新しいリストの中に直接挿入できる
    //　例: [1, 2, 3, ...[4, 5]] => [1, 2, 3, 4, 5]
    prefs.setStringList(
      key,
      [...messages, jsonEncode(myMessage.toJson())],
    );
    // デバッグ用
    debugPrint(prefs.getStringList(key).toString());

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'messages': prefs
              .getStringList(key)
              ?.map((message) => json.decode(message))
              .toList(),
        }),
        headers: {'Content-Type': 'application/json', 'api-key': apiKey},
      ).timeout(
          const Duration(seconds: 30)); // 30秒経っても返答なかったら TimeoutException を投げる

      // ステータスコード確認！
      debugPrint(response.statusCode.toString());
      // body をそのまま出力すると文字化けしてしまう
      // debugPrint(response.body);
      // 文字化けをなくすために utf8 に decode してから json.decode する！
      final bdoy = json.decode(utf8.decode(response.bodyBytes));
      // model に変換！
      final answer = Answer.fromJson(bdoy);

      final Message aiMessage =
          Message('assistant', answer.choices.first.message.content);
      // 今までのメッセージに今回のメッセージを追加
      prefs.setStringList(
        key,
        [
          ...prefs.getStringList(key) ?? [],
          jsonEncode(aiMessage.toJson()),
        ],
      );

      // ▲ response をみながら返信を state に渡す
      setState(() {
        stateMessage = [
          ...stateMessage,
          myMessage,
          Message('assistant', answer.choices.first.message.content),
        ];
        isLoading = false;
      });
    } catch (e) {
      // エラーになったらローディングは一旦止める
      setState(() {
        isLoading = false;
      });

      debugPrint("エラー: $e");

      // await 内で context 使う時は mounted を使ってウィジェットが破棄されていないかを確認する
      if (mounted) {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text('エラー'),
              content: const Text('しばらく時間を置いてからお試しください'),
              actions: [
                TextButton(
                  child: const Text('はい'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
      }
    }
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
      body: SafeArea(
        child: stateMessage.isEmpty
            ? const Center(
                child: Text(
                  'ChatGPT に何か聞いてみよう🫶🏻',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            // separated にするとアイテムの間に何かしらウィジェットを置ける（今回は隙間開けただけだけど線引いたりもできる）
            : ListView.separated(
                // reverse にすると List の下部から表示してくれるのでチャットぽい UI になる
                reverse: true,
                padding: const EdgeInsets.only(
                  right: 14,
                  left: 14,
                  bottom: 40,
                ),
                itemCount: stateMessage.length + 1,
                itemBuilder: (context, index) {
                  // ローカルストレージには新しいメッセージを先頭にしてデータが保存されていく
                  // チャットアプリでは最新のメッセージが一番下になる方がより自然な UI になるので reverse する
                  final reverseMessage = stateMessage.reversed.toList();
                  // reverse してるのでローディングを一番上に追加 = 一番下に表示されるように！
                  if (index == 0) {
                    return SizedBox(
                      height: 40,
                      width: 40,
                      // Align がないとローディングが横幅いっぱい広がろうとする
                      child: Align(
                        alignment: Alignment.center,
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.orangeAccent,
                              )
                            : const SizedBox.shrink(),
                      ),
                    );
                  }
                  // 保存されてるメッセージの content を取得
                  return chatText(reverseMessage[index - 1]);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 12);
                },
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

  // 長いのでチャットひとつひとつのデザインを切り出し！
  Widget chatText(Message message) {
    // メッセージの投稿主が自分なのか AI なのか
    final isAssistant = message.role == 'assistant';

    return Align(
      // 自分の投稿は右寄せ，AI の投稿は左寄せに
      alignment: isAssistant ? Alignment.centerLeft : Alignment.centerRight,
      child: Padding(
        padding: isAssistant
            ? const EdgeInsets.only(right: 48)
            : const EdgeInsets.only(left: 48),
        child: DecoratedBox(
          // 角丸にしたり背景色つけたりデコってる💖
          decoration: isAssistant
              ? BoxDecoration(
                  color: Colors.amber[900],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                )
              : BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              // ?? は左辺が null だったら右辺を使用する，の意味
              // 今回は message['content'] が null だったら ''（空文字）を Text として表示する
              message.content,
              style: TextStyle(
                fontSize: 20,
                color: isAssistant ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

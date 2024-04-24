import 'package:flutter/material.dart';
import 'package:flutter_sample_2024/post_page.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.title});

  final String title;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String text = '';

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
      setState(() {
        text = v;
      });
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
          text,
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

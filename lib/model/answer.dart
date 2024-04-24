import 'package:json_annotation/json_annotation.dart';

// 以下は最初はエラーが出ますが無視して OK！
// `flutter pub run build_runner build` を実行するとファイルが自動生成されてエラーも出なくなる
part 'answer.g.dart';

// model にするのは必要な要素だけで十分！
// 今回は id と created と content くらいを使いそうだったのでそれだけ定義
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

@JsonSerializable()
class Answer {
  Answer(
    this.id,
    this.created,
    this.choices,
  );

  String id;
  int created;
  List<Choice> choices;

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);
  Map<String, dynamic> toJson() => _$AnswerToJson(this);
}

// ネストしているものは explicitToJson: true で切り出し
@JsonSerializable(explicitToJson: true)
class Choice {
  Choice(this.message);

  Message message;

  factory Choice.fromJson(Map<String, dynamic> json) => _$ChoiceFromJson(json);
  Map<String, dynamic> toJson() => _$ChoiceToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Message {
  Message(
    this.content,
  );

  String content;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

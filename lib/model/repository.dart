import 'package:json_annotation/json_annotation.dart';

// 最初はもろもろエラー出ててOK！
part 'repository.g.dart';

@JsonSerializable()
class Repository {
  // 使いたいものだけでOK
  final int id;
  final String name;

  Repository({
    required this.id,
    required this.name,
  });

  factory Repository.fromJson(Map<String, dynamic> json) =>
      _$RepositoryFromJson(json);

  Map<String, dynamic> toJson() => _$RepositoryToJson(this);
}

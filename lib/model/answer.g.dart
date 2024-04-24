// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answer _$AnswerFromJson(Map<String, dynamic> json) => Answer(
      json['id'] as String,
      json['created'] as int,
      (json['choices'] as List<dynamic>)
          .map((e) => Choice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'id': instance.id,
      'created': instance.created,
      'choices': instance.choices,
    };

Choice _$ChoiceFromJson(Map<String, dynamic> json) => Choice(
      Message.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChoiceToJson(Choice instance) => <String, dynamic>{
      'message': instance.message.toJson(),
    };

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      json['role'] as String,
      json['content'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'role': instance.role,
      'content': instance.content,
    };

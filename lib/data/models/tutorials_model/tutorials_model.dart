import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tutorials_model.g.dart';

@JsonSerializable()
class TutorialModel {
  TutorialModel({
    this.createdAt,
    this.updatedAt,
    required this.link,
    required this.title,
    required this.active,
    required this.description,
  });

  final bool active;
  final String link;
  final String title;
  final String description;

  @JsonKey(
    fromJson: _fromJsonDateTime,
    toJson: _toJsonDateTime,
  )
  final DateTime? createdAt;

  @JsonKey(
    fromJson: _fromJsonDateTime,
    toJson: _toJsonDateTime,
  )
  final DateTime? updatedAt;

  TutorialModel copyWith({
    String? link,
    bool? active,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      TutorialModel(
        link: link ?? this.link,
        title: title ?? this.title,
        active: active ?? this.active,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        description: description ?? this.description,
      );

  factory TutorialModel.fromRawJson(String str) =>
      TutorialModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  static DateTime? _fromJsonDateTime(Timestamp value) => value.toDate();

  static DateTime? _toJsonDateTime(DateTime? value) => value;

  factory TutorialModel.fromJson(Map<String, dynamic> json) =>
      _$TutorialModelFromJson(json);

  Map<String, dynamic> toJson() => _$TutorialModelToJson(this);
}

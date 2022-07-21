import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'list_options_model.g.dart';

@JsonSerializable()
class ListOptionsModel {
  const ListOptionsModel({
    required this.label,
    required this.value,
  });

  final String label;
  final dynamic value;

  ListOptionsModel copyWith({
    String? label,
    dynamic value,
  }) =>
      ListOptionsModel(
        label: label ?? this.label,
        value: value ?? this.value,
      );

  factory ListOptionsModel.fromRawJson(String str) =>
      ListOptionsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListOptionsModel.fromJson(Map<String, dynamic> json) =>
      _$ListOptionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListOptionsModelToJson(this);
}

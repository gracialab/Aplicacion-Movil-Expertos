import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'documents_and_help_center_model.g.dart';

@JsonSerializable()
class LegalDocumentsAndHelpCenterModel {
  LegalDocumentsAndHelpCenterModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    required this.title,
    required this.status,
    required this.description,
  });

  final String? id;
  final bool status;
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

  LegalDocumentsAndHelpCenterModel copyWith({
    String? id,
    bool? status,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      LegalDocumentsAndHelpCenterModel(
        id: id ?? this.id,
        title: title ?? this.title,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        description: description ?? this.description,
      );

  factory LegalDocumentsAndHelpCenterModel.fromRawJson(String str) =>
      LegalDocumentsAndHelpCenterModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  static DateTime? _fromJsonDateTime(Timestamp value) => value.toDate();

  static DateTime? _toJsonDateTime(DateTime? value) => value;

  factory LegalDocumentsAndHelpCenterModel.fromJson(
          Map<String, dynamic> json) =>
      _$LegalDocumentsAndHelpCenterModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$LegalDocumentsAndHelpCenterModelToJson(this);
}

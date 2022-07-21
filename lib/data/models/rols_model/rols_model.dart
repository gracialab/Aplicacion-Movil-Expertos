import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rols_model.g.dart';

@JsonSerializable()
class RolModel {
  const RolModel({
    this.createdAt,
    this.reference,
    this.updatedAt,
    required this.name,
  });

  final String name;

  @JsonKey(
    fromJson: _fromJsonDocumentReference,
    toJson: _toJsonDocumentReference,
  )
  final DocumentReference? reference;

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

  RolModel copyWith({
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    DocumentReference? reference,
  }) =>
      RolModel(
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        reference: reference ?? this.reference,
      );

  factory RolModel.fromRawJson(String str) =>
      RolModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  static DocumentReference? _fromJsonDocumentReference(
      DocumentReference? documentReference) {
    return documentReference;
  }

  static DocumentReference? _toJsonDocumentReference(
      DocumentReference? documentReference) {
    return documentReference;
  }

  static DateTime? _fromJsonDateTime(Timestamp? value) => value?.toDate();

  static DateTime? _toJsonDateTime(DateTime? value) => value;

  factory RolModel.fromJson(Map<String, dynamic> json) =>
      _$RolModelFromJson(json);

  Map<String, dynamic> toJson() => _$RolModelToJson(this);
}

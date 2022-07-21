import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.lastName,
    required this.firtsName,
    required this.cellPhone,
    this.rol,
    this.photo,
    this.fcmToken,
    this.isActive,
    this.createdAt,
    this.reference,
    this.updatedAt,
    this.specialties,
    this.identification,
    this.typeIdentification,
  });

  final String id;
  final String? photo;
  final String email;
  final bool? isActive;
  final String lastName;
  final String? fcmToken;
  final String firtsName;
  final String cellPhone;
  final String? identification;
  final String? typeIdentification;

  @JsonKey(
    fromJson: _fromJsonListDocumentReference,
    toJson: _toJsonListDocumentReference,
  )
  final List<DocumentReference>? specialties;

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

  @JsonKey(
    fromJson: _fromJsonDocumentReference,
    toJson: _toJsonDocumentReference,
  )
  final DocumentReference? reference;

  @JsonKey(
    fromJson: _fromJsonDocumentReference,
    toJson: _toJsonDocumentReference,
  )
  final DocumentReference? rol;

  UserModel copyWith({
    String? id,
    String? photo,
    String? email,
    bool? isActive,
    String? fcmToken,
    String? lastName,
    String? firtsName,
    String? cellPhone,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? identification,
    DocumentReference? rol,
    String? typeIdentification,
    DocumentReference? reference,
    List<DocumentReference>? specialties,
  }) =>
      UserModel(
        id: id ?? this.id,
        rol: rol ?? this.rol,
        email: email ?? this.email,
        photo: photo ?? this.photo,
        fcmToken: fcmToken ?? this.fcmToken,
        lastName: lastName ?? this.lastName,
        isActive: isActive ?? this.isActive,
        reference: reference ?? this.reference,
        cellPhone: cellPhone ?? this.cellPhone,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        firtsName: firtsName ?? this.firtsName,
        specialties: specialties ?? this.specialties,
        identification: identification ?? this.identification,
        typeIdentification: typeIdentification ?? this.typeIdentification,
      );

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  static DateTime? _fromJsonDateTime(Timestamp value) => value.toDate();

  static DateTime? _toJsonDateTime(DateTime? value) => value;

  static List<DocumentReference>? _fromJsonListDocumentReference(List<dynamic>? specialties) {
    return specialties?.map((e) => e as DocumentReference).toList();
  }

  static List<DocumentReference>? _toJsonListDocumentReference(List<dynamic>? specialties) {
    return specialties?.map((e) => e as DocumentReference).toList();
  }

  static DocumentReference? _fromJsonDocumentReference(DocumentReference? documentReference) {
    return documentReference;
  }

  static DocumentReference? _toJsonDocumentReference(DocumentReference? documentReference) {
    return documentReference;
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

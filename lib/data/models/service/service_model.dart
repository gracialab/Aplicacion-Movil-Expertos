import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service_model.g.dart';

@JsonSerializable()
class ServiceModel {
  ServiceModel({
    required this.name,
    required this.price,
    this.id,
    this.image,
    this.active,
    this.quantity,
    this.category,
    this.reference,
    this.description,
  });

  final int price;
  final String? id;
  final String name;
  final bool? active;
  final String? image;
  final int? quantity;
  final String? description;

  @JsonKey(
    fromJson: _fromJsonDocumentReference,
    toJson: _toJsonDocumentReference,
  )
  final DocumentReference? reference;

  @JsonKey(
    fromJson: _fromJsonDocumentReference,
    toJson: _toJsonDocumentReference,
  )
  final DocumentReference? category;

  ServiceModel copyWith({
    int? price,
    String? id,
    String? name,
    bool? active,
    String? image,
    int? quantity,
    String? description,
    DocumentReference? category,
    DocumentReference? reference,
  }) =>
      ServiceModel(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        price: price ?? this.price,
        active: active ?? this.active,
        quantity: quantity ?? this.quantity,
        category: category ?? this.category,
        reference: reference ?? this.reference,
        description: description ?? this.description,
      );

  factory ServiceModel.fromRawJson(String str) => ServiceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  static DocumentReference? _fromJsonDocumentReference(DocumentReference? documentReference) {
    return documentReference;
  }

  static DocumentReference? _toJsonDocumentReference(DocumentReference? documentReference) {
    return documentReference;
  }

  factory ServiceModel.fromJson(Map<String, dynamic> json) => _$ServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);
}

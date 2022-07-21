import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mr_fix_expert/data/models/service/service_model.dart';

part 'purchase_model.g.dart';

@JsonSerializable()
class PurchaseModel {
  PurchaseModel({
    this.user,
    this.expert,
    this.descriptionAddress,
    required this.id,
    required this.date,
    required this.hour,
    required this.address,
    required this.service,
    required this.createAt,
    required this.updateAt,
    required this.coordinates,
    required this.statusPayment,
    required this.statusPurchase,
  });

  final String id;
  final String address;
  final int statusPayment;
  final int statusPurchase;
  final String? descriptionAddress;

  @JsonKey(
    fromJson: _fromJsonDateTime,
    toJson: _toJsonDateTime,
  )
  final DateTime date;

  @JsonKey(
    fromJson: _fromJsonDateTime,
    toJson: _toJsonDateTime,
  )
  final DateTime hour;

  @JsonKey(
    fromJson: _fromJsonDateTime,
    toJson: _toJsonDateTime,
  )
  final DateTime createAt;

  @JsonKey(
    fromJson: _fromJsonDateTime,
    toJson: _toJsonDateTime,
  )
  final DateTime updateAt;

  @JsonKey(fromJson: _fromJsonService, toJson: _toJsonService)
  final ServiceModel service;

  @JsonKey(
    fromJson: _fromJsonDocumentReference,
    toJson: _toJsonDocumentReference,
  )
  final DocumentReference? user;

  @JsonKey(
    fromJson: _fromJsonDocumentReference,
    toJson: _toJsonDocumentReference,
  )
  final DocumentReference? expert;

  @JsonKey(fromJson: _fromJsonGeoPoint, toJson: _toJsonGeoPoint)
  final GeoPoint coordinates;

  PurchaseModel copyWith({
    String? id,
    DateTime? date,
    DateTime? hour,
    String? address,
    int? statusPayment,
    DateTime? createAt,
    DateTime? updateAt,
    int? statusPurchase,
    ServiceModel? service,
    GeoPoint? coordinates,
    DocumentReference? user,
    DocumentReference? expert,
    String? descriptionAddress,
  }) =>
      PurchaseModel(
        id: id ?? this.id,
        user: user ?? this.user,
        date: date ?? this.date,
        hour: hour ?? this.hour,
        expert: expert ?? this.expert,
        address: address ?? this.address,
        service: service ?? this.service,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
        coordinates: coordinates ?? this.coordinates,
        statusPayment: statusPayment ?? this.statusPayment,
        statusPurchase: statusPurchase ?? this.statusPurchase,
        descriptionAddress: descriptionAddress ?? this.descriptionAddress,
      );

  factory PurchaseModel.fromRawJson(String str) => PurchaseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  static DocumentReference? _fromJsonDocumentReference(DocumentReference? documentReference) {
    return documentReference;
  }

  static DocumentReference? _toJsonDocumentReference(DocumentReference? documentReference) {
    return documentReference;
  }

  static ServiceModel _fromJsonService(Map<String, dynamic> service) {
    return ServiceModel.fromJson(service);
  }

  static Map<String, dynamic> _toJsonService(ServiceModel service) {
    return service.toJson()..removeWhere((key, value) => value == null);
  }

  static DateTime _fromJsonDateTime(Timestamp dateTime) {
    return dateTime.toDate();
  }

  static DateTime _toJsonDateTime(DateTime dateTime) {
    return dateTime;
  }

  static GeoPoint _fromJsonGeoPoint(GeoPoint geoPoint) {
    return geoPoint;
  }

  static GeoPoint _toJsonGeoPoint(GeoPoint geoPoint) {
    return geoPoint;
  }

  factory PurchaseModel.fromJson(Map<String, dynamic> json) => _$PurchaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseModelToJson(this);
}

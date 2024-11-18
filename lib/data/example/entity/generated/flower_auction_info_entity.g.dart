// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../flower_auction_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlowerAuctionInfoEntity _$FlowerAuctionInfoEntityFromJson(
        Map<String, dynamic> json) =>
    FlowerAuctionInfoEntity(
      id: json['_id'] as String,
      saleDate:
          const DateTimeJsonConverter().fromJson(json['saleDate'] as String),
      pummock: json['pummock'] as String,
      pumjong: json['pumjong'] as String,
      grade: json['grade'] as String,
      maximumPrice: (json['maximumPrice'] as num).toInt(),
      minimumPrice: (json['minimumPrice'] as num).toInt(),
      averagePrice: (json['averagePrice'] as num).toInt(),
      totalPrice: (json['totalPrice'] as num).toInt(),
      totalAmount: (json['totalAmount'] as num).toInt(),
    );

Map<String, dynamic> _$FlowerAuctionInfoEntityToJson(
        FlowerAuctionInfoEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'saleDate': const DateTimeJsonConverter().toJson(instance.saleDate),
      'pummock': instance.pummock,
      'pumjong': instance.pumjong,
      'grade': instance.grade,
      'maximumPrice': instance.maximumPrice,
      'minimumPrice': instance.minimumPrice,
      'averagePrice': instance.averagePrice,
      'totalPrice': instance.totalPrice,
      'totalAmount': instance.totalAmount,
    };

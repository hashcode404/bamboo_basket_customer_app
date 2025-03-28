// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OfferDetailsModelImpl _$$OfferDetailsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$OfferDetailsModelImpl(
      id: json['id'] as String?,
      shopID: json['shopID'] as String?,
      coupenCode: json['coupenCode'] as String?,
      coupenType: json['coupenType'] as String?,
      coupenAmount: json['coupenAmount'] as String?,
      expiryDate: json['expiryDate'] as String?,
      minSpend: json['minSpend'] as String?,
      maxSpend: json['maxSpend'] as String?,
      coupenDetails: json['coupenDetails'] as String?,
      coupenStatus: json['coupenStatus'] as String?,
    );

Map<String, dynamic> _$$OfferDetailsModelImplToJson(
        _$OfferDetailsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shopID': instance.shopID,
      'coupenCode': instance.coupenCode,
      'coupenType': instance.coupenType,
      'coupenAmount': instance.coupenAmount,
      'expiryDate': instance.expiryDate,
      'minSpend': instance.minSpend,
      'maxSpend': instance.maxSpend,
      'coupenDetails': instance.coupenDetails,
      'coupenStatus': instance.coupenStatus,
    };

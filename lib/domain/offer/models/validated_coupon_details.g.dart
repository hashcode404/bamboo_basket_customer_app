// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validated_coupon_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ValidatedCouponDetailsImpl _$$ValidatedCouponDetailsImplFromJson(
        Map<String, dynamic> json) =>
    _$ValidatedCouponDetailsImpl(
      shopID: json['shopID'] as String?,
      coupenCode: json['coupenCode'] as String?,
      coupenData: json['coupenData'] == null
          ? null
          : CoupenData.fromJson(json['coupenData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ValidatedCouponDetailsImplToJson(
        _$ValidatedCouponDetailsImpl instance) =>
    <String, dynamic>{
      'shopID': instance.shopID,
      'coupenCode': instance.coupenCode,
      'coupenData': instance.coupenData,
    };

_$CoupenDataImpl _$$CoupenDataImplFromJson(Map<String, dynamic> json) =>
    _$CoupenDataImpl(
      id: json['id'] as String?,
      shopID: json['shopID'] as String?,
      coupenCode: json['coupenCode'] as String?,
      coupenType: json['coupenType'] as String?,
      coupenAmount: json['coupenAmount'] as String?,
      expiryDate: json['expiryDate'] as String?,
      minSpend: json['minSpend'] as String?,
      maxSpend: json['maxSpend'] as String?,
      limitPerCoupen: json['limitPerCoupen'] as String?,
      limitPerUser: json['limitPerUser'] as String?,
      coupenDetails: json['coupenDetails'] as String?,
      coupenStatus: json['coupenStatus'] as String?,
      addedTime: json['addedTime'] as String?,
      lastUpdate: json['lastUpdate'] as String?,
    );

Map<String, dynamic> _$$CoupenDataImplToJson(_$CoupenDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shopID': instance.shopID,
      'coupenCode': instance.coupenCode,
      'coupenType': instance.coupenType,
      'coupenAmount': instance.coupenAmount,
      'expiryDate': instance.expiryDate,
      'minSpend': instance.minSpend,
      'maxSpend': instance.maxSpend,
      'limitPerCoupen': instance.limitPerCoupen,
      'limitPerUser': instance.limitPerUser,
      'coupenDetails': instance.coupenDetails,
      'coupenStatus': instance.coupenStatus,
      'addedTime': instance.addedTime,
      'lastUpdate': instance.lastUpdate,
    };

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'validated_coupon_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ValidatedCouponDetails _$ValidatedCouponDetailsFromJson(
    Map<String, dynamic> json) {
  return _ValidatedCouponDetails.fromJson(json);
}

/// @nodoc
mixin _$ValidatedCouponDetails {
  String? get shopID => throw _privateConstructorUsedError;
  String? get coupenCode => throw _privateConstructorUsedError;
  CoupenData? get coupenData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ValidatedCouponDetailsCopyWith<ValidatedCouponDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValidatedCouponDetailsCopyWith<$Res> {
  factory $ValidatedCouponDetailsCopyWith(ValidatedCouponDetails value,
          $Res Function(ValidatedCouponDetails) then) =
      _$ValidatedCouponDetailsCopyWithImpl<$Res, ValidatedCouponDetails>;
  @useResult
  $Res call({String? shopID, String? coupenCode, CoupenData? coupenData});

  $CoupenDataCopyWith<$Res>? get coupenData;
}

/// @nodoc
class _$ValidatedCouponDetailsCopyWithImpl<$Res,
        $Val extends ValidatedCouponDetails>
    implements $ValidatedCouponDetailsCopyWith<$Res> {
  _$ValidatedCouponDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shopID = freezed,
    Object? coupenCode = freezed,
    Object? coupenData = freezed,
  }) {
    return _then(_value.copyWith(
      shopID: freezed == shopID
          ? _value.shopID
          : shopID // ignore: cast_nullable_to_non_nullable
              as String?,
      coupenCode: freezed == coupenCode
          ? _value.coupenCode
          : coupenCode // ignore: cast_nullable_to_non_nullable
              as String?,
      coupenData: freezed == coupenData
          ? _value.coupenData
          : coupenData // ignore: cast_nullable_to_non_nullable
              as CoupenData?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CoupenDataCopyWith<$Res>? get coupenData {
    if (_value.coupenData == null) {
      return null;
    }

    return $CoupenDataCopyWith<$Res>(_value.coupenData!, (value) {
      return _then(_value.copyWith(coupenData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ValidatedCouponDetailsImplCopyWith<$Res>
    implements $ValidatedCouponDetailsCopyWith<$Res> {
  factory _$$ValidatedCouponDetailsImplCopyWith(
          _$ValidatedCouponDetailsImpl value,
          $Res Function(_$ValidatedCouponDetailsImpl) then) =
      __$$ValidatedCouponDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? shopID, String? coupenCode, CoupenData? coupenData});

  @override
  $CoupenDataCopyWith<$Res>? get coupenData;
}

/// @nodoc
class __$$ValidatedCouponDetailsImplCopyWithImpl<$Res>
    extends _$ValidatedCouponDetailsCopyWithImpl<$Res,
        _$ValidatedCouponDetailsImpl>
    implements _$$ValidatedCouponDetailsImplCopyWith<$Res> {
  __$$ValidatedCouponDetailsImplCopyWithImpl(
      _$ValidatedCouponDetailsImpl _value,
      $Res Function(_$ValidatedCouponDetailsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shopID = freezed,
    Object? coupenCode = freezed,
    Object? coupenData = freezed,
  }) {
    return _then(_$ValidatedCouponDetailsImpl(
      shopID: freezed == shopID
          ? _value.shopID
          : shopID // ignore: cast_nullable_to_non_nullable
              as String?,
      coupenCode: freezed == coupenCode
          ? _value.coupenCode
          : coupenCode // ignore: cast_nullable_to_non_nullable
              as String?,
      coupenData: freezed == coupenData
          ? _value.coupenData
          : coupenData // ignore: cast_nullable_to_non_nullable
              as CoupenData?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ValidatedCouponDetailsImpl
    with DiagnosticableTreeMixin
    implements _ValidatedCouponDetails {
  const _$ValidatedCouponDetailsImpl(
      {this.shopID, this.coupenCode, this.coupenData});

  factory _$ValidatedCouponDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ValidatedCouponDetailsImplFromJson(json);

  @override
  final String? shopID;
  @override
  final String? coupenCode;
  @override
  final CoupenData? coupenData;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ValidatedCouponDetails(shopID: $shopID, coupenCode: $coupenCode, coupenData: $coupenData)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ValidatedCouponDetails'))
      ..add(DiagnosticsProperty('shopID', shopID))
      ..add(DiagnosticsProperty('coupenCode', coupenCode))
      ..add(DiagnosticsProperty('coupenData', coupenData));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidatedCouponDetailsImpl &&
            (identical(other.shopID, shopID) || other.shopID == shopID) &&
            (identical(other.coupenCode, coupenCode) ||
                other.coupenCode == coupenCode) &&
            (identical(other.coupenData, coupenData) ||
                other.coupenData == coupenData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, shopID, coupenCode, coupenData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidatedCouponDetailsImplCopyWith<_$ValidatedCouponDetailsImpl>
      get copyWith => __$$ValidatedCouponDetailsImplCopyWithImpl<
          _$ValidatedCouponDetailsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ValidatedCouponDetailsImplToJson(
      this,
    );
  }
}

abstract class _ValidatedCouponDetails implements ValidatedCouponDetails {
  const factory _ValidatedCouponDetails(
      {final String? shopID,
      final String? coupenCode,
      final CoupenData? coupenData}) = _$ValidatedCouponDetailsImpl;

  factory _ValidatedCouponDetails.fromJson(Map<String, dynamic> json) =
      _$ValidatedCouponDetailsImpl.fromJson;

  @override
  String? get shopID;
  @override
  String? get coupenCode;
  @override
  CoupenData? get coupenData;
  @override
  @JsonKey(ignore: true)
  _$$ValidatedCouponDetailsImplCopyWith<_$ValidatedCouponDetailsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CoupenData _$CoupenDataFromJson(Map<String, dynamic> json) {
  return _CoupenData.fromJson(json);
}

/// @nodoc
mixin _$CoupenData {
  String? get id => throw _privateConstructorUsedError;
  String? get shopID => throw _privateConstructorUsedError;
  String? get coupenCode => throw _privateConstructorUsedError;
  String? get coupenType => throw _privateConstructorUsedError;
  String? get coupenAmount => throw _privateConstructorUsedError;
  String? get expiryDate => throw _privateConstructorUsedError;
  String? get minSpend => throw _privateConstructorUsedError;
  String? get maxSpend => throw _privateConstructorUsedError;
  String? get limitPerCoupen => throw _privateConstructorUsedError;
  String? get limitPerUser => throw _privateConstructorUsedError;
  String? get coupenDetails => throw _privateConstructorUsedError;
  String? get coupenStatus => throw _privateConstructorUsedError;
  String? get addedTime => throw _privateConstructorUsedError;
  String? get lastUpdate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CoupenDataCopyWith<CoupenData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoupenDataCopyWith<$Res> {
  factory $CoupenDataCopyWith(
          CoupenData value, $Res Function(CoupenData) then) =
      _$CoupenDataCopyWithImpl<$Res, CoupenData>;
  @useResult
  $Res call(
      {String? id,
      String? shopID,
      String? coupenCode,
      String? coupenType,
      String? coupenAmount,
      String? expiryDate,
      String? minSpend,
      String? maxSpend,
      String? limitPerCoupen,
      String? limitPerUser,
      String? coupenDetails,
      String? coupenStatus,
      String? addedTime,
      String? lastUpdate});
}

/// @nodoc
class _$CoupenDataCopyWithImpl<$Res, $Val extends CoupenData>
    implements $CoupenDataCopyWith<$Res> {
  _$CoupenDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? shopID = freezed,
    Object? coupenCode = freezed,
    Object? coupenType = freezed,
    Object? coupenAmount = freezed,
    Object? expiryDate = freezed,
    Object? minSpend = freezed,
    Object? maxSpend = freezed,
    Object? limitPerCoupen = freezed,
    Object? limitPerUser = freezed,
    Object? coupenDetails = freezed,
    Object? coupenStatus = freezed,
    Object? addedTime = freezed,
    Object? lastUpdate = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      shopID: freezed == shopID
          ? _value.shopID
          : shopID // ignore: cast_nullable_to_non_nullable
              as String?,
      coupenCode: freezed == coupenCode
          ? _value.coupenCode
          : coupenCode // ignore: cast_nullable_to_non_nullable
              as String?,
      coupenType: freezed == coupenType
          ? _value.coupenType
          : coupenType // ignore: cast_nullable_to_non_nullable
              as String?,
      coupenAmount: freezed == coupenAmount
          ? _value.coupenAmount
          : coupenAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as String?,
      minSpend: freezed == minSpend
          ? _value.minSpend
          : minSpend // ignore: cast_nullable_to_non_nullable
              as String?,
      maxSpend: freezed == maxSpend
          ? _value.maxSpend
          : maxSpend // ignore: cast_nullable_to_non_nullable
              as String?,
      limitPerCoupen: freezed == limitPerCoupen
          ? _value.limitPerCoupen
          : limitPerCoupen // ignore: cast_nullable_to_non_nullable
              as String?,
      limitPerUser: freezed == limitPerUser
          ? _value.limitPerUser
          : limitPerUser // ignore: cast_nullable_to_non_nullable
              as String?,
      coupenDetails: freezed == coupenDetails
          ? _value.coupenDetails
          : coupenDetails // ignore: cast_nullable_to_non_nullable
              as String?,
      coupenStatus: freezed == coupenStatus
          ? _value.coupenStatus
          : coupenStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      addedTime: freezed == addedTime
          ? _value.addedTime
          : addedTime // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUpdate: freezed == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CoupenDataImplCopyWith<$Res>
    implements $CoupenDataCopyWith<$Res> {
  factory _$$CoupenDataImplCopyWith(
          _$CoupenDataImpl value, $Res Function(_$CoupenDataImpl) then) =
      __$$CoupenDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? shopID,
      String? coupenCode,
      String? coupenType,
      String? coupenAmount,
      String? expiryDate,
      String? minSpend,
      String? maxSpend,
      String? limitPerCoupen,
      String? limitPerUser,
      String? coupenDetails,
      String? coupenStatus,
      String? addedTime,
      String? lastUpdate});
}

/// @nodoc
class __$$CoupenDataImplCopyWithImpl<$Res>
    extends _$CoupenDataCopyWithImpl<$Res, _$CoupenDataImpl>
    implements _$$CoupenDataImplCopyWith<$Res> {
  __$$CoupenDataImplCopyWithImpl(
      _$CoupenDataImpl _value, $Res Function(_$CoupenDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? shopID = freezed,
    Object? coupenCode = freezed,
    Object? coupenType = freezed,
    Object? coupenAmount = freezed,
    Object? expiryDate = freezed,
    Object? minSpend = freezed,
    Object? maxSpend = freezed,
    Object? limitPerCoupen = freezed,
    Object? limitPerUser = freezed,
    Object? coupenDetails = freezed,
    Object? coupenStatus = freezed,
    Object? addedTime = freezed,
    Object? lastUpdate = freezed,
  }) {
    return _then(_$CoupenDataImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      shopID: freezed == shopID
          ? _value.shopID
          : shopID // ignore: cast_nullable_to_non_nullable
              as String?,
      coupenCode: freezed == coupenCode
          ? _value.coupenCode
          : coupenCode // ignore: cast_nullable_to_non_nullable
              as String?,
      coupenType: freezed == coupenType
          ? _value.coupenType
          : coupenType // ignore: cast_nullable_to_non_nullable
              as String?,
      coupenAmount: freezed == coupenAmount
          ? _value.coupenAmount
          : coupenAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as String?,
      minSpend: freezed == minSpend
          ? _value.minSpend
          : minSpend // ignore: cast_nullable_to_non_nullable
              as String?,
      maxSpend: freezed == maxSpend
          ? _value.maxSpend
          : maxSpend // ignore: cast_nullable_to_non_nullable
              as String?,
      limitPerCoupen: freezed == limitPerCoupen
          ? _value.limitPerCoupen
          : limitPerCoupen // ignore: cast_nullable_to_non_nullable
              as String?,
      limitPerUser: freezed == limitPerUser
          ? _value.limitPerUser
          : limitPerUser // ignore: cast_nullable_to_non_nullable
              as String?,
      coupenDetails: freezed == coupenDetails
          ? _value.coupenDetails
          : coupenDetails // ignore: cast_nullable_to_non_nullable
              as String?,
      coupenStatus: freezed == coupenStatus
          ? _value.coupenStatus
          : coupenStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      addedTime: freezed == addedTime
          ? _value.addedTime
          : addedTime // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUpdate: freezed == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CoupenDataImpl with DiagnosticableTreeMixin implements _CoupenData {
  const _$CoupenDataImpl(
      {this.id,
      this.shopID,
      this.coupenCode,
      this.coupenType,
      this.coupenAmount,
      this.expiryDate,
      this.minSpend,
      this.maxSpend,
      this.limitPerCoupen,
      this.limitPerUser,
      this.coupenDetails,
      this.coupenStatus,
      this.addedTime,
      this.lastUpdate});

  factory _$CoupenDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$CoupenDataImplFromJson(json);

  @override
  final String? id;
  @override
  final String? shopID;
  @override
  final String? coupenCode;
  @override
  final String? coupenType;
  @override
  final String? coupenAmount;
  @override
  final String? expiryDate;
  @override
  final String? minSpend;
  @override
  final String? maxSpend;
  @override
  final String? limitPerCoupen;
  @override
  final String? limitPerUser;
  @override
  final String? coupenDetails;
  @override
  final String? coupenStatus;
  @override
  final String? addedTime;
  @override
  final String? lastUpdate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CoupenData(id: $id, shopID: $shopID, coupenCode: $coupenCode, coupenType: $coupenType, coupenAmount: $coupenAmount, expiryDate: $expiryDate, minSpend: $minSpend, maxSpend: $maxSpend, limitPerCoupen: $limitPerCoupen, limitPerUser: $limitPerUser, coupenDetails: $coupenDetails, coupenStatus: $coupenStatus, addedTime: $addedTime, lastUpdate: $lastUpdate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CoupenData'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('shopID', shopID))
      ..add(DiagnosticsProperty('coupenCode', coupenCode))
      ..add(DiagnosticsProperty('coupenType', coupenType))
      ..add(DiagnosticsProperty('coupenAmount', coupenAmount))
      ..add(DiagnosticsProperty('expiryDate', expiryDate))
      ..add(DiagnosticsProperty('minSpend', minSpend))
      ..add(DiagnosticsProperty('maxSpend', maxSpend))
      ..add(DiagnosticsProperty('limitPerCoupen', limitPerCoupen))
      ..add(DiagnosticsProperty('limitPerUser', limitPerUser))
      ..add(DiagnosticsProperty('coupenDetails', coupenDetails))
      ..add(DiagnosticsProperty('coupenStatus', coupenStatus))
      ..add(DiagnosticsProperty('addedTime', addedTime))
      ..add(DiagnosticsProperty('lastUpdate', lastUpdate));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoupenDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.shopID, shopID) || other.shopID == shopID) &&
            (identical(other.coupenCode, coupenCode) ||
                other.coupenCode == coupenCode) &&
            (identical(other.coupenType, coupenType) ||
                other.coupenType == coupenType) &&
            (identical(other.coupenAmount, coupenAmount) ||
                other.coupenAmount == coupenAmount) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.minSpend, minSpend) ||
                other.minSpend == minSpend) &&
            (identical(other.maxSpend, maxSpend) ||
                other.maxSpend == maxSpend) &&
            (identical(other.limitPerCoupen, limitPerCoupen) ||
                other.limitPerCoupen == limitPerCoupen) &&
            (identical(other.limitPerUser, limitPerUser) ||
                other.limitPerUser == limitPerUser) &&
            (identical(other.coupenDetails, coupenDetails) ||
                other.coupenDetails == coupenDetails) &&
            (identical(other.coupenStatus, coupenStatus) ||
                other.coupenStatus == coupenStatus) &&
            (identical(other.addedTime, addedTime) ||
                other.addedTime == addedTime) &&
            (identical(other.lastUpdate, lastUpdate) ||
                other.lastUpdate == lastUpdate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      shopID,
      coupenCode,
      coupenType,
      coupenAmount,
      expiryDate,
      minSpend,
      maxSpend,
      limitPerCoupen,
      limitPerUser,
      coupenDetails,
      coupenStatus,
      addedTime,
      lastUpdate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CoupenDataImplCopyWith<_$CoupenDataImpl> get copyWith =>
      __$$CoupenDataImplCopyWithImpl<_$CoupenDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CoupenDataImplToJson(
      this,
    );
  }
}

abstract class _CoupenData implements CoupenData {
  const factory _CoupenData(
      {final String? id,
      final String? shopID,
      final String? coupenCode,
      final String? coupenType,
      final String? coupenAmount,
      final String? expiryDate,
      final String? minSpend,
      final String? maxSpend,
      final String? limitPerCoupen,
      final String? limitPerUser,
      final String? coupenDetails,
      final String? coupenStatus,
      final String? addedTime,
      final String? lastUpdate}) = _$CoupenDataImpl;

  factory _CoupenData.fromJson(Map<String, dynamic> json) =
      _$CoupenDataImpl.fromJson;

  @override
  String? get id;
  @override
  String? get shopID;
  @override
  String? get coupenCode;
  @override
  String? get coupenType;
  @override
  String? get coupenAmount;
  @override
  String? get expiryDate;
  @override
  String? get minSpend;
  @override
  String? get maxSpend;
  @override
  String? get limitPerCoupen;
  @override
  String? get limitPerUser;
  @override
  String? get coupenDetails;
  @override
  String? get coupenStatus;
  @override
  String? get addedTime;
  @override
  String? get lastUpdate;
  @override
  @JsonKey(ignore: true)
  _$$CoupenDataImplCopyWith<_$CoupenDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

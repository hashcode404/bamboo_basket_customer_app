// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String? userID;
  final String? shopID;
  final String? userFirstName;
  final String? userLastName;
  final String? userAddress;
  final String? userPostCode;
  final String? userMobile;
  final String? userEmail;
  final String? userPassword;
  final String? userStatus;
  final String? addedTime;
  final String? userActivationCode;
  User({
    required this.userID,
    required this.shopID,
    required this.userFirstName,
    required this.userLastName,
    required this.userAddress,
    required this.userPostCode,
    required this.userMobile,
    required this.userEmail,
    required this.userPassword,
    required this.userStatus,
    required this.addedTime,
    required this.userActivationCode,
  });

  User copyWith({
    String? userID,
    String? shopID,
    String? userFirstName,
    String? userLastName,
    String? userAddress,
    String? userPostCode,
    String? userMobile,
    String? userEmail,
    String? userPassword,
    String? userStatus,
    String? addedTime,
    String? userActivationCode,
  }) {
    return User(
      userID: userID ?? this.userID,
      shopID: shopID ?? this.shopID,
      userFirstName: userFirstName ?? this.userFirstName,
      userLastName: userLastName ?? this.userLastName,
      userAddress: userAddress ?? this.userAddress,
      userPostCode: userPostCode ?? this.userPostCode,
      userMobile: userMobile ?? this.userMobile,
      userEmail: userEmail ?? this.userEmail,
      userPassword: userPassword ?? this.userPassword,
      userStatus: userStatus ?? this.userStatus,
      addedTime: addedTime ?? this.addedTime,
      userActivationCode: userActivationCode ?? this.userActivationCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userID': userID,
      'shopID': shopID,
      'userFirstName': userFirstName,
      'userLastName': userLastName,
      'userAddress': userAddress,
      'userPostCode': userPostCode,
      'userMobile': userMobile,
      'userEmail': userEmail,
      'userPassword': userPassword,
      'userStatus': userStatus,
      'addedTime': addedTime,
      'userActivationCode': userActivationCode,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userID: map['userID'] != null ? map['userID'] as String : null,
      shopID: map['shopID'] != null ? map['shopID'] as String : null,
      userFirstName:
          map['userFirstName'] != null ? map['userFirstName'] as String : null,
      userLastName:
          map['userLastName'] != null ? map['userLastName'] as String : null,
      userAddress:
          map['userAddress'] != null ? map['userAddress'] as String : null,
      userPostCode:
          map['userPostCode'] != null ? map['userPostCode'] as String : null,
      userMobile:
          map['userMobile'] != null ? map['userMobile'] as String : null,
      userEmail: map['userEmail'] != null ? map['userEmail'] as String : null,
      userPassword:
          map['userPassword'] != null ? map['userPassword'] as String : null,
      userStatus:
          map['userStatus'] != null ? map['userStatus'] as String : null,
      addedTime: map['addedTime'] != null ? map['addedTime'] as String : null,
      userActivationCode: map['userActivationCode'] != null
          ? map['userActivationCode'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(userID: $userID, shopID: $shopID, userFirstName: $userFirstName, userLastName: $userLastName, userAddress: $userAddress, userPostCode: $userPostCode, userMobile: $userMobile, userEmail: $userEmail, userPassword: $userPassword, userStatus: $userStatus, addedTime: $addedTime, userActivationCode: $userActivationCode)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.userID == userID &&
        other.shopID == shopID &&
        other.userFirstName == userFirstName &&
        other.userLastName == userLastName &&
        other.userAddress == userAddress &&
        other.userPostCode == userPostCode &&
        other.userMobile == userMobile &&
        other.userEmail == userEmail &&
        other.userPassword == userPassword &&
        other.userStatus == userStatus &&
        other.addedTime == addedTime &&
        other.userActivationCode == userActivationCode;
  }

  @override
  int get hashCode {
    return userID.hashCode ^
        shopID.hashCode ^
        userFirstName.hashCode ^
        userLastName.hashCode ^
        userAddress.hashCode ^
        userPostCode.hashCode ^
        userMobile.hashCode ^
        userEmail.hashCode ^
        userPassword.hashCode ^
        userStatus.hashCode ^
        addedTime.hashCode ^
        userActivationCode.hashCode;
  }
}

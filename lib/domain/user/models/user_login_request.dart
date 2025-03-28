import 'dart:convert';

class UserLoginRequest {
  final String shopID;
  final String user;
  final String password;
  UserLoginRequest({
    required this.shopID,
    required this.user,
    required this.password,
  });

  UserLoginRequest copyWith({
    String? shopID,
    String? user,
    String? password,
  }) {
    return UserLoginRequest(
      shopID: shopID ?? this.shopID,
      user: user ?? this.user,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shopID': shopID,
      'user': user,
      'password': password,
    };
  }

  factory UserLoginRequest.fromMap(Map<String, dynamic> map) {
    return UserLoginRequest(
      shopID: map['shopID'] as String,
      user: map['user'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLoginRequest.fromJson(String source) =>
      UserLoginRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserLoginRequest(shopID: $shopID, user: $user, password: $password)';

  @override
  bool operator ==(covariant UserLoginRequest other) {
    if (identical(this, other)) return true;

    return other.shopID == shopID &&
        other.user == user &&
        other.password == password;
  }

  @override
  int get hashCode => shopID.hashCode ^ user.hashCode ^ password.hashCode;
}

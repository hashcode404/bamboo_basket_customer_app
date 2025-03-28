import 'dart:convert';

import 'user.dart';

class UserLoginResponse {
  final String token;
  final int? expireAt;
  final User user;

  UserLoginResponse({
    required this.token,
    this.expireAt,
    required this.user,
  });

  UserLoginResponse copyWith({
    String? token,
    int? expireAt,
    User? user,
  }) {
    return UserLoginResponse(
      token: token ?? this.token,
      expireAt: expireAt ?? this.expireAt,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'expireAt': expireAt,
      'user': user.toMap(),
    };
  }

  factory UserLoginResponse.fromMap(Map<String, dynamic> map) {
    return UserLoginResponse(
      token: map['token'] as String,
      expireAt: map['expireAt'].toInt() as int,
      user: User.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLoginResponse.fromJson(String source) =>
      UserLoginResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserLoginResponse(token: $token, expireAt: $expireAt, user: $user)';

  @override
  bool operator ==(covariant UserLoginResponse other) {
    if (identical(this, other)) return true;

    return other.token == token &&
        other.expireAt == expireAt &&
        other.user == user;
  }

  @override
  int get hashCode => token.hashCode ^ expireAt.hashCode ^ user.hashCode;
}

import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final String token;
  final int userID;
  final String username;

  const Auth({required this.userID, required this.username, required this.token});

  @override
  List<Object> get props => [
        token,
        userID,
        username,
      ];

  static Auth fromJson(dynamic json) {
    print(json);
    // final authData = json['data'];
    return Auth(
      token: json['token'],// authData['token'] as String,
      userID: 1,//authData['user_id'] as int,
      username: 'ana',//authData['username'] as String,
    );
  }
}

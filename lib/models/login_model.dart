import 'package:airbnb_cybersoft/models/user_model.dart';

class DangNhapView {
  String email;
  String password;

  DangNhapView({required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return {'email': email, 'password': password};
  }

  factory DangNhapView.fromMap(Map<String, dynamic> map) {
    return DangNhapView(email: map['email'], password: map['password']);
  }
}

class AuthContent {
  final ThongTinNguoiDung user;
  final String token;

  AuthContent({required this.user, required this.token});

  factory AuthContent.fromMap(Map<String, dynamic> map) {
    return AuthContent(
      user: ThongTinNguoiDung.fromMap(map['user']),
      token: map['token'],
    );
  }
}

class AuthResponse {
  final int statusCode;
  final AuthContent content;
  final String dateTime;

  AuthResponse({
    required this.statusCode,
    required this.content,
    required this.dateTime,
  });

  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    return AuthResponse(
      statusCode: map['statusCode'],
      content: AuthContent.fromMap(map['content']),
      dateTime: map['dateTime'],
    );
  }
}

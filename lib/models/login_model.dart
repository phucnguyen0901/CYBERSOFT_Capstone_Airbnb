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

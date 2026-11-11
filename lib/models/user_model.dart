class ThongTinNguoiDung {
  int? id;
  String name;
  String email;
  String password;
  String phone;
  String birthday;
  bool gender;
  String role;

  ThongTinNguoiDung({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.birthday,
    required this.gender,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'birthday': birthday,
      'gender': gender,
      'role': role,
    };
  }

  factory ThongTinNguoiDung.fromMap(Map<String, dynamic> map) {
    return ThongTinNguoiDung(
      id: map['id'] as int?,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      phone: map['phone'] as String,
      birthday: map['birthday'] as String,
      gender: map['gender'] as bool,
      role: map['role'] as String,
    );
  }
}

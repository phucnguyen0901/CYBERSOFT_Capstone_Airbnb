class UpdateUserModel {
  int? id;
  String name;
  String email;
  String phone;
  String birthdday;
  bool gender;
  String role;

  UpdateUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.birthdday,
    required this.gender,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {};
  }

  factory UpdateUserModel.fromMap(Map<String, dynamic> map) {
    return UpdateUserModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      birthdday: map['birthdday'] as String,
      gender: map['gender'] as bool,
      role: map['role'] as String,
    );
  }
}

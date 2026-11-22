class BinhLuanViewModel {
  int? id;
  int maPhong;
  int maNguoiBinhLuan;
  String ngayBinhLuan;
  String noiDung;
  int saoBinhLuan;

  BinhLuanViewModel({
    required this.id,
    required this.maPhong,
    required this.maNguoiBinhLuan,
    required this.ngayBinhLuan,
    required this.noiDung,
    required this.saoBinhLuan,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'maPhong': maPhong,
      'maNguoiBinhLuan': maNguoiBinhLuan,
      'ngayBinhLuan': ngayBinhLuan,
      'noiDung': noiDung,
      'saoBinhLuan': saoBinhLuan,
    };
  }

  factory BinhLuanViewModel.fromMap(Map<String, dynamic> map) {
    return BinhLuanViewModel(
      id: map['id'] as int?,
      maPhong: map['maPhong'] as int,
      maNguoiBinhLuan: map['maNguoiBinhLuan'] as int,
      ngayBinhLuan: map['ngayBinhLuan'] as String,
      noiDung: map['noiDung'] as String,
      saoBinhLuan: map['saoBinhLuan'] as int,
    );
  }
}

class ModelBinhLuanTheoPhong {
  int id;
  String ngayBinhLuan;
  String noiDung;
  int saoBinhLuan;
  String tenNguoiBinhLuan;
  String avatar;

  ModelBinhLuanTheoPhong({
    required this.id,
    required this.ngayBinhLuan,
    required this.noiDung,
    required this.saoBinhLuan,
    required this.tenNguoiBinhLuan,
    required this.avatar,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ngayBinhLuan': ngayBinhLuan,
      'noiDung': noiDung,
      'saoBinhLuan': saoBinhLuan,
      'tenNguoiBinhLuan': tenNguoiBinhLuan,
      'avatar': avatar,
    };
  }

  factory ModelBinhLuanTheoPhong.fromMap(Map<String, dynamic> map) {
    return ModelBinhLuanTheoPhong(
      id: map['id'] as int,
      ngayBinhLuan: map['ngayBinhLuan'] as String,
      noiDung: map['noiDung'] as String,
      saoBinhLuan: map['saoBinhLuan'] as int,
      tenNguoiBinhLuan: map['tenNguoiBinhLuan'] as String,
      avatar: map['avatar'] as String,
    );
  }
}

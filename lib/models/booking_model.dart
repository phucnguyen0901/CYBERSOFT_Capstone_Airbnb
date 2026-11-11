class DatPhongViewModel {
  int? id;
  int maPhong;
  String ngayDen;
  String ngayDi;
  int soLuongKhach;
  int maNguoiDung;

  DatPhongViewModel({
    required this.id,
    required this.maPhong,
    required this.ngayDen,
    required this.ngayDi,
    required this.soLuongKhach,
    required this.maNguoiDung,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'maPhong': maPhong,
      'ngayDen': ngayDen,
      'ngayDi': ngayDi,
      'soLuongKhach': soLuongKhach,
      'maNguoiDung': maNguoiDung,
    };
  }

  factory DatPhongViewModel.fromMap(Map<String, dynamic> map) {
    return DatPhongViewModel(
      id: map['id'] as int?,
      maPhong: map['maPhong'] as int,
      ngayDen: map['ngayDen'] as String,
      ngayDi: map['ngayDi'] as String,
      soLuongKhach: map['soLuongKhach'] as int,
      maNguoiDung: map['maNguoiDung'] as int,
    );
  }
}

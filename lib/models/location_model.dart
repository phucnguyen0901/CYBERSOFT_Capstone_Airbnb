class ViTriViewModel {
  int? id;
  String tenViTri;
  String tinhThanh;
  String quocGia;
  String hinhAnh;

  ViTriViewModel({
    required this.id,
    required this.tenViTri,
    required this.tinhThanh,
    required this.quocGia,
    required this.hinhAnh,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tenViTri': tenViTri,
      'tinhThanh': tinhThanh,
      'quocGia': quocGia,
      'hinhAnh': hinhAnh,
    };
  }

  factory ViTriViewModel.fromMap(Map<String, dynamic> map) {
    return ViTriViewModel(
      id: map['id'] as int?,
      tenViTri: map['tenViTri'] as String,
      tinhThanh: map['tinhThanh'] as String,
      quocGia: map['quocGia'] as String,
      hinhAnh: map['hinhAnh'] as String,
    );
  }
}

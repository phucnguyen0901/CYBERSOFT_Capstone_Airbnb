class PhongViewModel {
  int? id;
  String tenPhong;
  int khach;
  int phongNgu;
  int giuong;
  int phongTam;
  String moTa;
  int giaTien;
  bool mayGiat;
  bool banLa;
  bool tivi;
  bool dieuHoa;
  bool wifi;
  bool bep;
  bool doXe;
  bool hoBoi;
  bool banUi;
  int maViTri;
  String hinhAnh;

  PhongViewModel({
    required this.id,
    required this.tenPhong,
    required this.khach,
    required this.phongNgu,
    required this.giuong,
    required this.phongTam,
    required this.moTa,
    required this.giaTien,
    required this.mayGiat,
    required this.banLa,
    required this.tivi,
    required this.dieuHoa,
    required this.wifi,
    required this.bep,
    required this.doXe,
    required this.hoBoi,
    required this.banUi,
    required this.maViTri,
    required this.hinhAnh,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "tenPhong": tenPhong,
      "khach": khach,
      "phongNgu": phongNgu,
      "giuong": giuong,
      "phongTam": phongTam,
      "moTa": moTa,
      "giaTien": giaTien,
      "mayGiat": mayGiat,
      "banLa": banLa,
      "tivi": tivi,
      "dieuHoa": dieuHoa,
      "wifi": wifi,
      "bep": bep,
      "doXe": doXe,
      "hoBoi": hoBoi,
      "banUi": banUi,
      "maViTri": maViTri,
      "hinhAnh": hinhAnh,
    };
  }

  factory PhongViewModel.fromMap(Map<String, dynamic> map) {
    return PhongViewModel(
      id: map['id'] as int?,
      tenPhong: map['tenPhong'] as String,
      khach: map['khach'] as int,
      phongNgu: map['phongNgu'] as int,
      giuong: map['giuong'] as int,
      phongTam: map['phongTam'] as int,
      moTa: map['moTa'] as String,
      giaTien: map['giaTien'] as int,
      mayGiat: map['mayGiat'] as bool,
      banLa: map['banLa'] as bool,
      tivi: map['tivi'] as bool,
      dieuHoa: map['dieuHoa'] as bool,
      wifi: map['wifi'] as bool,
      bep: map['bep'] as bool,
      doXe: map['doXe'] as bool,
      hoBoi: map['hoBoi'] as bool,
      banUi: map['banUi'] as bool,
      maViTri: map['maViTri'] as int,
      hinhAnh: map['hinhAnh'] as String,
    );
  }
}

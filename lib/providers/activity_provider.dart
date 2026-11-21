import 'package:airbnb_cybersoft/models/booking_model.dart';
import 'package:airbnb_cybersoft/models/room_model.dart';
import 'package:airbnb_cybersoft/services/reservation_service.dart';
import 'package:airbnb_cybersoft/services/room_service.dart';
import 'package:flutter/material.dart';

class ActivityProvider extends ChangeNotifier {
  List<DatPhongViewModel> _activities = [];
  List<PhongViewModel> _rooms = [];

  List<DatPhongViewModel> get activities => _activities;
  List<PhongViewModel> get rooms => _rooms;

  Future<void> getActivities(int maNguoiDung) async {
    final activities = await ReservationService.getRoomsByUserID(maNguoiDung);
    final rooms = await Future.wait(
      activities.map((activity) => RoomService.getRoomByID(activity.maPhong)),
    );

    _activities = activities;
    _rooms = rooms;
    notifyListeners();
  }

  Future<void> booking(DatPhongViewModel reserveInfo) async {
    final result = await ReservationService.booking(reserveInfo.toMap());
    if (result) {
      await getActivities(reserveInfo.maNguoiDung);
    }
  }
}

import 'package:airbnb_cybersoft/models/booking_model.dart';
import 'package:airbnb_cybersoft/services/reservation_service.dart';
import 'package:flutter/material.dart';

class ActivityProvider extends ChangeNotifier {
  List<DatPhongViewModel> _activities = [];

  List<DatPhongViewModel> get activities => _activities;

  void loadActivity(List<DatPhongViewModel> activities) {
    _activities = activities;
    notifyListeners();
  }

  Future<void> getActivities(int maNguoiDung) async {
    final result = await ReservationService.getRoomsByUserID(maNguoiDung);
    loadActivity(result);
  }

  Future<void> booking(DatPhongViewModel reserveInfo) async {
    final result = await ReservationService.booking(reserveInfo.toMap());
    if (result) {
      await getActivities(reserveInfo.maNguoiDung);
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_alarmapp/helpers/location_service.dart';

class LocationViewModel extends ChangeNotifier {
  bool isLoading = false;
  String errorMessage = '';
  Position? currentPosition;
  String? currentAddress;

  // request permission, get position, then address
  Future<void> requestAndGetLocation() async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      // Debug: Check permission and GPS status
      print('Permission status: ${await Geolocator.checkPermission()}');
      print('GPS enabled: ${await Geolocator.isLocationServiceEnabled()}');
      final pos = await LocationService.getCurrentLocation();
      currentPosition = pos;
      currentAddress = await LocationService.getAddressFromPosition(pos);
    } catch (e) {
      errorMessage = e.toString();
      currentPosition = null;
      currentAddress = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}

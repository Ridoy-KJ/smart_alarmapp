import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'alarm_model.dart';

class HomeViewModel extends ChangeNotifier {
  List<AlarmModel> alarms = [];

  HomeViewModel() {
    _initializeDefaultAlarms();
  }

  /// Initializes 3 default alarms with mixed enabled states
  void _initializeDefaultAlarms() {
    DateTime now = DateTime.now();
    alarms = [
      AlarmModel.create(DateTime(now.year, now.month, now.day, 7, 10), 1), // enabled
      AlarmModel.create(DateTime(now.year, now.month, now.day, 6, 55), 2)..isEnabled = false, // disabled
      AlarmModel.create(DateTime(now.year, now.month, now.day, 7, 10), 3), // enabled
    ];
  }

  void addAlarm(DateTime time) {
    final id = alarms.length + 1;
    alarms.add(AlarmModel.create(time, id));
    alarms.sort((a, b) => a.time.compareTo(b.time));
    notifyListeners();
  }

  void removeAlarm(int index) {
    alarms.removeAt(index);
    notifyListeners();
  }

  void toggleAlarm(int index, bool value) {
    alarms[index].isEnabled = value;
    notifyListeners();
  }

  String formatTime(DateTime dt) => DateFormat('hh:mm a').format(dt);
  String formatDate(DateTime dt) => DateFormat('EEE dd MMM yyyy').format(dt);
}

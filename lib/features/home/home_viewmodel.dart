import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'alarm_model.dart';
import '../../helpers/notification_service.dart';

/// ViewModel for managing alarm logic and state.
/// Handles alarm creation, toggling, deletion, formatting, and local persistence.
class HomeViewModel extends ChangeNotifier {
  /// List of all alarms currently loaded in memory.
  List<AlarmModel> alarms = [];

  /// Constructor: loads saved alarms or initializes default ones.
  HomeViewModel() {
    _loadAlarms();
  }

  /// Loads alarms from SharedPreferences.
  /// If no saved alarms exist, initializes 3 default alarms.
  Future<void> _loadAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList('alarms');

    if (rawList != null && rawList.isNotEmpty) {
      // Load saved alarms
      alarms = rawList
          .map((jsonStr) => AlarmModel.fromJson(json.decode(jsonStr)))
          .toList();
    } else {
      // No saved alarms — initialize defaults
      _initializeDefaultAlarms();
      _saveAlarms();
    }

    notifyListeners();
  }

  /// Saves current [alarms] list to SharedPreferences.
  /// Called after any modification to the alarm list.
  Future<void> _saveAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = alarms.map((alarm) => json.encode(alarm.toJson())).toList();
    await prefs.setStringList('alarms', rawList);
  }

  /// Initializes 3 default alarms with mixed enabled states.
  void _initializeDefaultAlarms() {
    DateTime now = DateTime.now();
    alarms = [
      AlarmModel.create(DateTime(now.year, now.month, now.day, 7, 10), 1),
      AlarmModel.create(DateTime(now.year, now.month, now.day, 6, 55), 2)..isEnabled = false,
      AlarmModel.create(DateTime(now.year, now.month, now.day, 7, 10), 3),
    ];
  }

  /// Adds a new alarm at the specified [time].
  /// Automatically assigns a unique ID and schedules a notification.
  void addAlarm(DateTime time) {
    final id = alarms.length + 1;
    final alarm = AlarmModel.create(time, id);
    alarms.add(alarm);
    alarms.sort((a, b) => a.time.compareTo(b.time));
    _saveAlarms();
    notifyListeners();

    // Schedule local notification for this alarm
    NotificationService.scheduleNotification(
      id,
      'Alarm',
      'It’s time!',
      time,
    );
  }

  /// Removes the alarm at the given [index].
  /// Updates local storage and UI.
  void removeAlarm(int index) {
    alarms.removeAt(index);
    _saveAlarms();
    notifyListeners();
  }

  /// Toggles the enabled state of the alarm at [index].
  /// Updates local storage and UI.
  void toggleAlarm(int index, bool value) {
    alarms[index].isEnabled = value;
    _saveAlarms();
    notifyListeners();
  }

  /// Formats a [DateTime] into a readable time string (e.g., "07:00 AM").
  String formatTime(DateTime dt) => DateFormat('hh:mm a').format(dt);

  /// Formats a [DateTime] into a readable date string (e.g., "Sat 28 Sep 2025").
  String formatDate(DateTime dt) => DateFormat('EEE dd MMM yyyy').format(dt);
}

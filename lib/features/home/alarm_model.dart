class AlarmModel {
  final int id;
  final DateTime time;
  bool isEnabled;

  AlarmModel({
    required this.id,
    required this.time,
    this.isEnabled = true,
  });

  factory AlarmModel.create(DateTime time, int id) {
    return AlarmModel(id: id, time: time);
  }

  // Convert to Map for storage
  Map<String, dynamic> toJson() => {
    'id': id,
    'time': time.toIso8601String(),
    'isEnabled': isEnabled,
  };

  // Convert from Map
  factory AlarmModel.fromJson(Map<String, dynamic> json) => AlarmModel(
    id: json['id'],
    time: DateTime.parse(json['time']),
    isEnabled: json['isEnabled'],
  );
}

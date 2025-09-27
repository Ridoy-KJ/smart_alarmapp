class AlarmModel {
  final int id;
  final DateTime time;
  bool isEnabled;

  AlarmModel({
    required this.id,
    required this.time,
    this.isEnabled = true,
  });

  // Simple factory for easy creation and ID handling
  factory AlarmModel.create(DateTime time, int id) {
    return AlarmModel(id: id, time: time);
  }
}

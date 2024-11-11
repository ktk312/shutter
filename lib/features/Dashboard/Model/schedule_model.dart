class ScheduleModel {
  final String day;
  final String firstOpeningTime;
  final String firstClosingTime;
  final String secondOpeningTime;
  final String secondClosingTime;

ScheduleModel({
    required this.day,
    required this.firstOpeningTime,
    required this.firstClosingTime,
    required this.secondOpeningTime,
    required this.secondClosingTime,

  });


  factory ScheduleModel.fromJson(Map<dynamic, dynamic> json) {
    return ScheduleModel(
      day: json['day'] as String,
      firstOpeningTime: json['firstOpeningTime'] as String,
      firstClosingTime: json['firstClosingTime'] as String,
      secondOpeningTime: json['secondOpeningTime'] as String,
      secondClosingTime: json['secondClosingTime'] as String,
    );
  }

Map<String, dynamic> toJson() {
    return {
      'day': day,
      'firstOpeningTime': firstOpeningTime,
      'firstClosingTime': firstClosingTime,
      'secondOpeningTime': secondOpeningTime,
      'secondClosingTime': secondClosingTime,
    };
  }

}

class WeightModel {
  String? gender;
  int? weight;
  String? sleepTime;
  String? wakeTime;

  WeightModel({this.gender, this.weight, this.sleepTime, this.wakeTime});

  Map<String, dynamic> toMap() {
    return {
      'gender': gender,
      'weight': weight,
      'sleeptime': sleepTime,
      'waketime': wakeTime,
    };
  }

  factory WeightModel.fromMap(map) {
    return WeightModel(
        gender: map['gender'],
        weight: map['weight'],
        sleepTime: map['sleeptime'],
        wakeTime: map['waketime']);
  }

}

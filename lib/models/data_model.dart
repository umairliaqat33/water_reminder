class WeightModel {
  String? gender;
  int? weight;
  String? sleepTime;
  String? wakeTime;
  int? waterIntakeGoal;

  WeightModel(
      {this.gender,
      this.weight,
      this.sleepTime,
      this.wakeTime,
      this.waterIntakeGoal});

  Map<String, dynamic> toMap() {
    return {
      'gender': gender,
      'weight': weight,
      'sleeptime': sleepTime,
      'waketime': wakeTime,
      'waterIntakeGoal': waterIntakeGoal,
    };
  }

  factory WeightModel.fromMap(map) {
    return WeightModel(
        gender: map['gender'],
        weight: map['weight'],
        sleepTime: map['sleeptime'],
        wakeTime: map['waketime'],
        waterIntakeGoal: map['waterIntakeGoal']);
  }
}

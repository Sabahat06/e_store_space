import 'package:get/get.dart';

class TimeSlotModel {
  String id;
  String timeFrom;
  String timeTo;
  RxString status = ''.obs;

  TimeSlotModel({this.id, this.timeFrom, this.timeTo, this.status});

  TimeSlotModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timeFrom = json['time_from'];
    timeTo = json['time_to'];
    status.value = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['time_from'] = this.timeFrom;
    data['time_to'] = this.timeTo;
    data['status'] = this.status.value;
    return data;
  }
}

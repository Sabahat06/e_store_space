import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_store_space/models/time_slot.dart';
import 'package:e_store_space/services/http_services.dart';

class TimeSlotsController extends GetxController{

  RxBool loading = true.obs;
  RxList<TimeSlotModel> timeSlots = <TimeSlotModel>[].obs;
  RxInt timeSlotIndex = 0.obs;
  RxString selectedTimeSlot = ''.obs;
  TextEditingController slotFieldController = TextEditingController();



  TimeSlotsController(){
    loadSlots().then((value) {
      if(timeSlots.length!=0)
        loading.value = false;
      int tempIndex  = timeSlots.indexWhere((slot) => slot.status.toUpperCase() == 'Enabled'.toUpperCase());
      if(tempIndex+1 != timeSlots.length){
        timeSlotIndex.value = tempIndex;
      }else{
        timeSlotIndex.value = tempIndex+1;
      }
      // slotFieldController.text = "${timeSlots[tempIndex].timeFrom} - ${timeSlots[tempIndex].timeTo}";
      // selectedTimeSlot.value = "${timeSlots[tempIndex].timeFrom} - ${timeSlots[tempIndex].timeTo}";
    });
  }

  Future<void> loadSlots() async {
    timeSlots.value =  await  HttpService.getTimeSlots();
    // showDatePicker  = await HttpService.getShowDatePickerStatus();
  }
}
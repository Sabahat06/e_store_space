import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlaceOrderLoginController extends GetxController{

  RxBool progressing = false.obs;
  DateTime selectedDate = DateTime.now();
  String todayDate;
  TextEditingController dateController;
  RxString deliveryDate = ''.obs;

  PlaceOrderLoginController(){
    dateController =  TextEditingController(text: '${DateTime.now()}'.split(' ')[0].toString());
    deliveryDate.value = dateController.text;
    todayDate = deliveryDate.value;
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      dateController.value = TextEditingController(text: '$picked.toLocal()'.split(' ')[0].toString()).value;
      deliveryDate.value = dateController.text;
    }
  }

}
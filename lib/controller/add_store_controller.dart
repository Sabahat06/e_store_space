import 'package:e_store_space/models/add_store_model.dart';
import 'package:get/get.dart';

class AddStoreController extends GetxController{
  RxBool progressing = false.obs;
  AddStoreModel store = AddStoreModel();
}
import 'package:get/get.dart';
class StaticVariable{

  static String baseString='';
  static String userId='';

  static String deliveryCharges= '';
  static String initial_slide_1= '';
  static String initial_slide_2= '';
  static String initial_slide_3= '';
  static RxString account_status = ''.obs;
  static RxString user_status = ''.obs;
  static RxBool appSettings= false.obs;
  static int loginResponseCode = 0;
  static int addUserDealResponseCode = 0;
  static int registerResponseCode = 0;
  static int placeOrderResponseCode = 0;
  static int updateProfileResponseCode = 0;
  static int becameASellerResponseCode = 0;
  static int addStoreResponseCode = 0;
  static RxString isSeller = '0'.obs;
  static RxString isAffiliate = '0'.obs;
}
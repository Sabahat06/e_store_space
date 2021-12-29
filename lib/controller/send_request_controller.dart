import 'package:get/get.dart';
import 'package:e_store_space/models/send_request_model.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:e_store_space/settings/color_palates.dart';


class SendRequestController extends GetxController {

  void sendRequestToSystem(String customerId, String subject, String description)async{

   SendRequestResponse response= await HttpService.sendRequest(customerId, subject, description);
   if(response!=null){
     Fluttertoast.showToast(msg: response.msg,backgroundColor: ColorPalette.red);
   }
   else
   {
     Fluttertoast.showToast(msg: response.msg);
     Get.back();
     Get.back();
   }
  }

}
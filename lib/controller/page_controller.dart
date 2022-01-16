import 'package:e_store_space/models/page.dart';
import 'package:get/get.dart';
import 'package:e_store_space/models/category_model.dart';
import 'package:e_store_space/services/http_services.dart';


class HtmlPageController extends GetxController{

  HtmlPageModel htmlPages;
  String faqs;
  String privacyPolicy;
  String termAndCondition;
  @override
  void onInit()  {
   loadPages();
    super.onInit();
  }
  loadPages()async{
    htmlPages = await HttpService.getAllPages();
    faqs = htmlPages.htmlpages[0].content;
    privacyPolicy = htmlPages.htmlpages[1].content;
    termAndCondition = htmlPages.htmlpages[2].content;
    print('');

  }
}
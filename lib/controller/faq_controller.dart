import 'package:get/get.dart';
import 'package:e_store_space/models/faq_model.dart';
import 'package:e_store_space/services/http_services.dart';

class FAQController extends GetxController{

  RxInt expandedIndex = 0.obs;

  String answers;
  RxBool loading = true.obs;
  List<Faq> faqs =[];
  FAQController(){
    loadFaqs();
  }

  loadFaqs() async{
    faqs = await HttpService.getFaqs();
    expandedIndex.value = faqs.length;
    loading.value = false;
  }



}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/controller/bottom_bar_controller.dart';
import 'package:e_store_space/controller/cart/shop_cart_screen_controller.dart';
import 'package:e_store_space/controller/category_controller.dart';
import 'package:e_store_space/services/http_services.dart';
import 'package:e_store_space/statics/static_var.dart';
import 'package:e_store_space/view/product/cart_screen.dart';
import 'package:e_store_space/view/search_screen.dart';
import 'package:e_store_space/widgets/my_category_box.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreenTab extends StatelessWidget {
  RxInt currentIndex = 0.obs;
  RxString selectedValue = ''.obs;
  RxList<Map<String, String>> splashData = [
    {"image": StaticVariable.initial_slide_1},
    {"image": StaticVariable.initial_slide_2},
    {"image": StaticVariable.initial_slide_3}
  ].obs;

  BottomBarController bottomBarController = Get.find();

  HomeScreenTab({Key key}) : super(key: key);
  CategoryController categoryController=Get.find();
  CartControllerNew cartController=Get.find();
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    RxBool isexpanded = false.obs;
    StaticVariable.appSettings.value = false;
    currentIndex.value = 0;
    authController.isLogedIn.value
      ? loadAppSettings(id: authController.user.value.id)
      : loadAppSettings();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: PopupMenuButton(
          // onSelected: (val) => {
          //   // if(val == "Search Product"){
          //   //   Get.to(SearchScreen())
          //   // }
          // },
          color: Colors.orange,
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry>[
              PopupMenuItem(
                // onTap: (){Get.to(SearchScreen());},
                child: GestureDetector(
                  onTap: (){Get.to(SearchScreen());},
                  child: Row(
                    children: const [
                      Icon(Icons.search_outlined, color: Colors.black,),
                      SizedBox(width: 2,),
                      Text('Search Product', style: TextStyle(fontSize: 16, color: Colors.black),),
                    ],
                  ),
                ),
              ),
            ];
          },
        ),

        title: const Text('Home'),
        actions: [
          Obx(
          ()=> GestureDetector(
              onTap: ()=>Get.to(CartScreen()),
              child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.shopping_cart_outlined),
                        onPressed: () {
                          // Get.to(StepperBar());
                          Get.to(CartScreen());
                        },
                        color: Colors.black
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        cartController.cart.items.length == 0
                            ? Container()
                            : const Icon(
                          Icons.circle,
                          color: Colors.white,
                        ),
                        cartController.cart.items.length == 0
                            ?Container()
                            : Text(
                          (cartController.cart.items.length).toString(),
                          style: const TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ]
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Container(
                  height: 200,
                  width: double.infinity,
                  child: PageView.builder(
                    onPageChanged: (value){
                      currentIndex.value = value;
                    },
                    itemCount: splashData.value.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return splashContent(splashData.value[index]['image'], index);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 5,),
              Center(
                 child: Container(
                   height: 8,
                   child: ListView.builder(
                     itemCount: splashData.value.length,
                     shrinkWrap: true,
                     scrollDirection: Axis.horizontal,
                     itemBuilder: (context, index) {
                       return splashDot(index);
                     },
                   ),
                 ),
              ),
              const SizedBox(height: 10,),
              Obx(
               () => StaticVariable.appSettings.value
                   ? authController.isLogedIn.value && StaticVariable.user_status.value == 'approved'
                    ? Container()
                    : !authController.isLogedIn.value
                       ? const Center(child: Text('برائے مہربانی اپنا اکاؤنٹ رجسٹر کریں اور تصدیق کے لیے ہم سے واٹس ایپ پر رابطہ کریں۔ شکریہ', style: TextStyle(color: Colors.red, fontSize: 16), textAlign: TextAlign.center))
                       : const Center(child: Text('قیمتیں دیکھنے اور آرڈر کرنے کے لیے اپنے اکاؤنٹ کی تصدیق کے لیے برائے مہربانی ہم سے واٹس ایپ پر رابطہ کریں۔ شکریہ', style: TextStyle(color: Colors.red, fontSize: 16),textAlign: TextAlign.center))
                   : Container(),
              ),
              const SizedBox(height: 10,),
              Obx(
               ()=> Container(
                height: StaticVariable.appSettings.value
                    ? authController.isLogedIn.value && StaticVariable.user_status.value == 'approved'
                      ? size.height * 0.52
                      : size.height*0.43
                    : size.height*0.43,
                  child: GridView.builder(
                    itemCount: categoryController.categories.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1.1
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: MyCategoryBox(
                          imagePath: categoryController.categories[index].banner,
                          title: categoryController.categories[index].title,
                          subtitle: 'dummy subtitle',
                        ),
                        onTap: (){
                          bottomBarController.currentBNBIndex.value=1;
                          categoryController.currentTabIndex.value=index;
                        },
                      );
                    }
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        child: GestureDetector(
          child: Image.asset('assets/image/whatsapp.png',width: 60,height: 60,),
          onTap: (){
            openwhatsapp(context);
          },
        ),
      ),
    );
  }

  loadAppSettings({String id}) async {
    var response = await HttpService.getAppSettings(userID: id??"0");
    if(response['account_status'] != 'active'){
      authController.logOut();
    }
  }

  splashContent(String image,int index){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
          image:
              DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
      width: Get.width * 0.9,
      height: 150,
    );
  }

  splashDot(int index){
    return Obx(
      () => Row(
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: currentIndex.value == index ? Colors.orange :Colors.grey,
              borderRadius: BorderRadius.circular(20)
            ),
            child: const SizedBox(width: 5,),
          ),
          const SizedBox(width: 5,),
        ],
      ),
    );
  }

  openwhatsapp(BuildContext context) async{
    var whatsapp ="+923105450027";
    var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=Hello there, I am contacting from your app. ";
    if( await canLaunch(whatsappURl_android)){
      await launch(whatsappURl_android);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: new Text("whatsapp not installed")));
    }
  }

  void onSelected(String value){
    print(value);
    Get.to(SearchScreen());
  }
}

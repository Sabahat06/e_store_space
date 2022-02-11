import 'package:e_store_space/controller/cart/shop_cart_screen_controller.dart';
import 'package:e_store_space/controller/product_detials_controller.dart';
import 'package:e_store_space/controller/wish_list_controller.dart';
import 'package:e_store_space/models/cart/new_cart_model.dart';
import 'package:e_store_space/models/product_detail.dart';
import 'package:e_store_space/view/product/review_screen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductDetailsModel productDetailsModel;

  ProductDetailsScreen({@required this.productDetailsModel}) {}

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  WishListController wishListController = Get.find();

  CartControllerNew cartControllerNew = Get.find();

  List<String> productImages = ['assets/image/image6.jpg', 'assets/image/appbar.jpg', 'assets/image/appimage.jpeg', 'assets/image/image6.jpg'];

  List<int> colorCode = [0xff039e2c, 0xffDEDEDE, 0xffffb852, 0xffe95a5c];

  RxInt choiceid = 0.obs;

  RxInt quantity = 0.obs;

  RxBool isExpanded = false.obs;

  RxString subCategoryImages=''.obs;

  String _linkMessage;
  RxString _link = ''.obs;
  bool _isCreatingLink = false;
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  final String DynamicLink = 'https://wwww.google.com/';
  final String Link = 'https://sabahat.page.link/qbvQ';
  final String _testString = 'join video';

  Future<void> initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      Navigator.pushNamed(context, dynamicLinkData.link.path);
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }
  initState(){
    super.initState();
    initDynamicLinks();
    _createDynamicLink(false);
  }
  @override
  Widget build(BuildContext context) {
    cartControllerNew.currentChoiceID.value = widget.productDetailsModel.productDetails.productColors.first.colorId;
    subCategoryImages.value = "https://spinningsoft.co/projects/eStoreSpace/admin/images/product_images/${widget.productDetailsModel.productDetails.productColors.first.image}";
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Center(
          child: GestureDetector(
            onTap: (){Get.back();},
            child: Container(
              height: 30.h,
              width: 35.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Center(child: const Icon(Icons.arrow_back, color: Colors.black,))
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          Center(
            child: Row(
              children: [
                Container(
                  height: 25.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(
                    child: Text(double.parse(widget.productDetailsModel.rating == null ? "0" : widget.productDetailsModel.rating == "" ? "0" : widget.productDetailsModel.rating).toStringAsFixed(1), style: TextStyle(fontSize: 16.sp, color: Colors.black),),
                  ),
                ),
                const SizedBox(width: 13,),
              ],
            ),
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Obx(
                      () => Container(
                        width: double.infinity,
                        height: 240.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(subCategoryImages.value),
                            fit: BoxFit.contain,
                          )
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 60.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        itemBuilder: (context, index){
                          return subCategoriesImages(widget.productDetailsModel.productDetails.productColors[index] ,index);
                        },
                        itemCount: widget.productDetailsModel.productDetails.productColors.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.productDetailsModel.productDetails.name, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)
                          ),
                          color: Colors.transparent
                        ),
                        width: 85.w,
                        height: 35.h,
                        child: Center(
                          child: Row(
                            children: [
                              Obx(
                                () => IconButton(
                                  icon: Icon(
                                    wishListController.items.any((element) => element.productDetails.id==widget.productDetailsModel.productDetails.id)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  onPressed: (){
                                    wishListController.addOrRemoveItem(widget.productDetailsModel);
                                  },
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.share_outlined,
                                  color: Colors.red,
                                  size: 30,
                                ),
                                onPressed: () async {
                                  // onPressed:
                                  if(!_isCreatingLink){
                                    _createDynamicLink(false);
                                  }
                                  else{
                                    return null;
                                  }
                                  // !_isCreatingLink
                                  //     ? () => _createDynamicLink(false)
                                  //     : null;
                                  FlutterShare.share(
                                      title: _linkMessage,
                                      text: _linkMessage
                                  );
                                },
                                // onPressed: !_isCreatingLink
                                //     ? () => _createDynamicLink(false)
                                //     : null,
                              ),
                            ],
                          ),
                          // Icon(
                          //   Icons.favorite, size: 30, color: Colors.red,
                          // ),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(right: 10.0, left: 10),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15)
                        ),
                        color: Colors.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left:10,bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(widget.productDetailsModel.productDetails.name, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),),
                                Row(
                                  children: [
                                    Text('More Detail', style: TextStyle(fontSize: 16.sp, color: Colors.blue),),
                                    IconButton(
                                      onPressed: () {
                                        isExpanded.value = !isExpanded.value;
                                      },
                                      icon: Icon(isExpanded.value ? Icons.expand_less_outlined : Icons.expand_more_outlined, color: Colors.blue,)
                                    )
                                  ],
                                ),
                                isExpanded.value
                                  ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 320.w,
                                        child: Text(widget.productDetailsModel.productDetails.description, textAlign: TextAlign.justify,),
                                      ),
                                      const SizedBox(height: 7,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {Get.to(() => ReviewsScreen(ratings: widget.productDetailsModel.productDetails.ratings, productName: widget.productDetailsModel.productDetails.name,));},
                                            child: SmoothStarRating(
                                              color: Colors.purpleAccent,
                                              rating: double.parse(widget.productDetailsModel.rating == null ? "0" : widget.productDetailsModel.rating=="" ? "0" : widget.productDetailsModel.rating),
                                              size: 15,
                                              isReadOnly: true,
                                              borderColor: Colors.purpleAccent,
                                            ),
                                          ),
                                          const SizedBox(width: 7,),
                                          Text(
                                            widget.productDetailsModel.rating == null ? "0.0" : double.parse(widget.productDetailsModel.rating).toStringAsFixed(1),
                                            style: const TextStyle(fontSize: 15, color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                  : Container()
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15)
                      ),
                      color: Colors.blue.shade100,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:10.0, right: 10),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              ),
                              color: Colors.blue.shade100,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left:15, right: 15, top: 15, bottom: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 40.w,
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.blue, width: 2),
                                        ),
                                        child: const Center(
                                          child: Icon(Icons.location_city_outlined, color: Colors.blue,),
                                        ),
                                      ),
                                      SizedBox(width: 10.w,),
                                      Text("Taxial", style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                  SizedBox(height: 10.h,),
                                  Row(
                                    children: [
                                      Container(
                                        width: 40.w,
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.blue, width: 2),
                                        ),
                                        child: const Center(
                                          child: Icon(Icons.lock_clock_outlined, color: Colors.blue,),
                                        ),
                                      ),
                                      SizedBox(width: 10.w,),
                                      Text("Delivery Time", style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                  SizedBox(height: 10.h,),
                                  Container(
                                    height: 40.h,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Center(child: Text('Color', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp, color: Colors.blue), textAlign: TextAlign.center,)),
                                        ListView.builder(
                                          itemBuilder: (context, index){
                                            return renderingColors(widget.productDetailsModel.productDetails.productColors[index] ,index);
                                          },
                                          itemCount: widget.productDetailsModel.productDetails.productColors.length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5.h,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('No. of Item in Cart', style: TextStyle(fontSize: 14.sp, color: Colors.black),),
                                      Obx(
                                        () => Row(
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                widget.productDetailsModel.productDetails.quantity.value--;
                                                if(widget.productDetailsModel.productDetails.quantity.value<=0){
                                                  widget.productDetailsModel.productDetails.quantity.value=0;
                                                }
                                              },
                                              child: Container(
                                                width: 25.w,
                                                height: 25.h,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20.r),
                                                    color: Colors.white
                                                ),
                                                child: Icon(Icons.remove, size: 20.w, color: Colors.blue,),
                                              ),
                                            ),
                                            SizedBox(width: 10.w,),
                                            widget.productDetailsModel.productDetails.quantity.value <=0 ? Text('0', style: TextStyle(fontSize: 14.sp, color: Colors.black),) : Text(widget.productDetailsModel.productDetails.quantity.value.toString(), style: TextStyle(fontSize: 14.sp, color: Colors.black), ),
                                            SizedBox(width: 10.w,),
                                            GestureDetector(
                                              onTap: () {
                                                widget.productDetailsModel.productDetails.quantity.value++;
                                              },
                                              child: Container(
                                                width: 25.w,
                                                height: 25.h,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20.r),
                                                  color: Colors.white
                                                ),
                                                child: Icon(Icons.add, size: 25.w, color: Colors.blue,),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 5.h,),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                            height: 65.h,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)
                              )
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 25.w),
                              child: GestureDetector(
                                onTap: (){
                                  if(widget.productDetailsModel.productDetails.quantity.value==0){
                                    Fluttertoast.showToast(msg: "Please Select Quantity");
                                  }else{
                                    Map json = widget.productDetailsModel.productDetails.toJson();
                                    // json['choiceID'] = cartControllerNew.currentChoiceID.value;
                                    // json['quantity'] = productDetailsModel.productDetails.quantity.value;
                                    Item item = Item.fromJson(json);
                                    item.quantity.value = widget.productDetailsModel.productDetails.quantity.value;
                                    item.choiceID = cartControllerNew.currentChoiceID.value;
                                    cartControllerNew.addItem(item);
                                  }
                                },
                                child: Container(
                                    height: 35.h,
                                    color: Colors.blue,
                                    width: double.infinity,
                                    child: const Center(
                                      child: Text('Add To Bag', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),),
                                    )
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  subCategoriesImages(ProductColors productColors ,int index){
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(left: 10,),
        child: CircleAvatar(
          radius: 25,
          backgroundColor: choiceid.value == index ? Colors.blue : Colors.transparent,
          child: GestureDetector(
            onTap: (){
              choiceid.value = index;
              subCategoryImages.value = "https://spinningsoft.co/projects/eStoreSpace/admin/images/product_images/${productColors.image}";
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage("https://spinningsoft.co/projects/eStoreSpace/admin/images/product_images/${productColors.image}"),
              radius: 23,
            ),
          ),
        ),
      ),
    );
  }

  renderingColors(ProductColors productColors,int index){
    String valueString = productColors.color.colorCode.replaceAll('#', "0xff");
    String valueString1 = valueString.replaceAll('\r', "");
    String valueString2 = valueString1.replaceAll('\n', "");
    int colorCodesss = int.parse(valueString2.toString());
    print(colorCodesss);
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: cartControllerNew.colorCodeid.value == index ? Colors.blue : Colors.transparent,
          child: GestureDetector(
            onTap: (){
              cartControllerNew.colorCodeid.value = index;
              cartControllerNew.currentChoiceID.value = productColors.colorId.toString();
            },
            child: CircleAvatar(
              backgroundColor: Color(colorCodesss),
              radius: 18,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _createDynamicLink(bool short) async {
    setState(() {
      _isCreatingLink = true;
    });

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://sabahat.page.link/qbvQ',
      link: Uri.parse(DynamicLink),
      androidParameters: const AndroidParameters(
        packageName: 'com.sabahat.e_store_space',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'io.invertase.testing',
        minimumVersion: '0',
      ),
    );
    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
      await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    }
    else {
      url = await dynamicLinks.buildLink(parameters);
      _linkMessage = url.toString();
      setState(() {
        _linkMessage = url.toString();
        _isCreatingLink = false;
      });
    }

  }

  Future<void> shareFile() async {

    await FlutterShare.share(
      title: 'Your Promo Code :8282',
      text: '${_linkMessage}',
    );
  }
}

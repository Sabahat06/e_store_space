import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:e_store_space/controller/cart/shop_cart_screen_controller.dart';
import 'package:e_store_space/controller/product_controller.dart';
import 'package:e_store_space/controller/send_request_controller.dart';
import 'package:e_store_space/models/cart/new_cart_model.dart';
import 'package:e_store_space/models/product_model.dart';
import 'package:e_store_space/settings/color_palates.dart';
import 'package:e_store_space/statics/static_var.dart';
import 'package:e_store_space/widgets/my_appbar.dart';
import 'package:e_store_space/widgets/my_filled_button.dart';
import 'package:e_store_space/widgets/my_text_field.dart';


class ProductScreen extends StatelessWidget {
  RxString id = '0'.obs;
  String subCategoryID;
  int pageNo;
  String title;
  ProductController productController;
  CartControllerNew cartController=Get.find();
  CartControllerNew newCartController=Get.find();

  ProductScreen(this.subCategoryID, this.pageNo, this.title){
    productController =Get.put(ProductController(subCategoryID: subCategoryID,pageNo: pageNo));
  }

  var subject = TextEditingController();
  var description = TextEditingController();
  var price = TextEditingController();
  var sendReqController = Get.put(SendRequestController());
  AuthController authController = Get.find();
  TextEditingController searchController = TextEditingController();
  RefreshController _refreshController = RefreshController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: MyAppBarWidgets(title: 'Products').getMyAppBar(),
      body: Obx(
        () => productController.progressing.value
          ? const Center(child: CircularProgressIndicator(),)
          : GetX<ProductController>(
              builder: (productController) {
                return productController.productsModal.value.products.length == 0
                  ? const Center(child: Text('There are no Products in this List', style: TextStyle(fontSize: 18),),)
                  : SmartRefresher(
                      enablePullUp: productController.search.value?
                      !(productController.productsModal.value.totalPages==productController.currentSearchPage.value):
                      !(productController.productsModal.value.totalPages==productController.currentPage.value),
                      controller: _refreshController,
                      onRefresh: (){
                        productController.loadProducts(loadMore: false).then((value)  {
                          _refreshController.refreshCompleted();
                        });
                      },
                      onLoading: (){
                        productController.loadProducts(loadMore: true).then((value) {_refreshController.loadComplete();});
                      },
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: productController.productsModal.value.products.length,
                        itemBuilder: (BuildContext context, int index) {
                          return renderingProduct(index, productController.productsModal.value.products[index], context);
                        }
                      ),
                  );
              },
        ),
      ),
      floatingActionButton: Container(
        child: SizedBox(
          height: 40,
          child: Container(
            child: RaisedButton(
              color: Colors.orange,
              elevation: 20,
              onPressed: (){
                Get.bottomSheet(renderBottomSheetForRequest());
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35),),
              child: const Text('Send Request',style: TextStyle(color: Colors.white, fontSize: 18),),
            ),
          ),
        ),
      ),
    );
  }

  renderBottomSheetForRequest(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        // height: 600,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorPalette.orange)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: ColorPalette.orange, width: 2)),
                            child: const Icon(
                              Icons.ios_share,
                              size: 30,
                              color: ColorPalette.orange,
                            )),
                          const SizedBox(height: 5,),
                          const   Text('اپنی مرضی کی درخواست کریں۔', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          const  SizedBox(height: 5,),
                          const  Text('اگر آپ کوئی خاص ڈیوائس ڈھونڈ رہے ہیں جو آپ کو یہاں نہیں ملا تو بس اس فارم کو پر کریں۔ ہم جلد ہی مطلوبہ ڈیوائس فراہم کریں گے۔', style: TextStyle(fontSize: 16,), textAlign: TextAlign.center,),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  MyTextField(controller: subject, label: 'پسندیدہ ڈیوائس کا نام درج کریں۔',),
                  const SizedBox(height: 10,),
                  TextFormField(
                    minLines: 3,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: description,
                    decoration: const InputDecoration(
                      fillColor: ColorPalette.orange,
                      focusColor: ColorPalette.orange,
                      hoverColor: ColorPalette.orange,
                      labelText: 'اپنے پسندیدہ ڈیوائس کے بارے میں تفصیلات درج کریں ',
                      hintStyle: TextStyle(color: Colors.black54, fontSize: 12),
                      labelStyle: TextStyle(color: Colors.black, fontSize: 16,),
                      disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorPalette.orange)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorPalette.orange)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorPalette.orange)),
                      border: OutlineInputBorder(borderSide: BorderSide(color: ColorPalette.orange)),
                    ),
                  ),
                  const SizedBox(height: 25,),
                  MyFilledButton(
                    ontap: () async {
                      if (sendRequestValidation()) {
                        sendReqController.sendRequestToSystem(
                            authController.user.value.id,
                            subject.text,
                            description.text);
                        subject.clear();
                        description.clear();
                        Get.back();
                      }
                    },
                    color: ColorPalette.orange,
                    width: double.infinity,
                    height: 40,
                    borderRadius: 10,
                    txt: 'Send Request',
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );


  }

  renderBottomSheetForAddToCart(int index, Products product){
    String _dropDownValue;
    if(product.choices.length!=0){
      cartController.currentChoiceColorName.value=product.choices.first.colorName;
      cartController.currentChoiceID.value=product.choices.first.id;
    }else{
      cartController.currentChoiceColorName.value="";
      cartController.currentChoiceID.value="";
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    child: Image.network(product.photo),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(product.title,style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),),
                        Text(product.salePrice),
                      ],
                    ),
                  ),
                  product.choices.length == 0
                      ? Container()
                      : SizedBox(
                    width: Get.width * 0.7,
                    child: DropdownButton(
                      hint: _dropDownValue == null
                          ? Obx(()=> Text( newCartController.currentChoiceColorName.value ?? 'Select Color'))
                          : Text(
                        _dropDownValue,
                        style: const TextStyle(color: Colors.black),
                      ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: const TextStyle(color: Colors.black),
                      items:product.choices.map(
                            (choice) {
                          return DropdownMenuItem<String>(
                            value: '${choice.id},${choice.colorName.toString()}',
                            child: Text(choice.colorName.toString()),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        var splittedValue=val.toString().split(",");
                        newCartController.currentChoiceID.value = splittedValue[0];
                        newCartController.currentChoiceColorName.value = splittedValue[1];
                      }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       MyFilledButton(
                          txt: 'Add to cart',
                          fontSize: 16,
                          height: 45,
                          width: 300,
                          color: ColorPalette.orange,
                          borderRadius: 25,
                          ontap: () async{
                            await addToBag(product);
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool sendRequestValidation(){
    if(subject.text.isEmpty){
      Fluttertoast.showToast(msg: 'please Enter subject');
      return false;
    }
    else if(description.text.isEmpty){
      Fluttertoast.showToast(msg: 'please Enter Subject');
      return false;
    }

    else {
      return true;
    }
  }

  renderingProduct(int index, Products product, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    RxInt cartIndex =  cartController.cart.items.indexWhere((element) => element.id==product.id).obs;
    if(cartIndex !=-1){
      product.quantity.value = cartController.cart.items[cartIndex.value].quantity.value;
    }
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12, top: 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: Text(product.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Image.network(
                    product.photo,
                    height: 75,
                    width: 75,
                    fit: BoxFit.cover,
                  )
                ),
                const SizedBox(width: 15,),
                Container(
                    width: size.width*0.58,
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(child: Text(product.shortDetails, style: const TextStyle(fontSize: 14, color: Colors.black54), maxLines: 3,)),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: authController.isLogedIn.value && StaticVariable.user_status.value != "not_approved"
                                ? product.discount == "0"
                                  ? Text(product.salePrice, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)
                                  : Row(
                                      children: [
                                        Text(product.discountedPrice, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold,),),
                                        const SizedBox(width: 10,),
                                        Text(product.salePrice, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, decoration: TextDecoration.lineThrough, color: Colors.grey),)
                                      ],
                                    )
                                : const Text('', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)
                            ),
                            Obx(
                              () => authController.isLogedIn.value && StaticVariable.user_status.value == "approved"
                               ? Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  product.status == '0'
                                    ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.deepOrangeAccent,
                                    ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text('Out of Stock',style: TextStyle(
                                          color: Colors.white
                                        ),),
                                      )) : MyFilledButton(
                                    txt: 'Add to cart',
                                    fontSize: 14,
                                    height: 25,
                                    width: Get.width * 0.25,
                                    color: ColorPalette.orange,
                                    borderRadius: 25,
                                    ontap: (){
                                      Get.bottomSheet(renderBottomSheetForAddToCart(index, productController.productsModal.value.products[index]));
                                    },
                                  ),
                                  const SizedBox(width: 10,),
                                ],
                              )
                               : Container(),
                            )
                          ],
                        ),
                      ],
                    )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Future<void> addToBag(Products product) async {
      Map json = product.toJson();
      /// adding quantity, size and choiceID to this raw json which isnt available in product's json and not Bag's json
      json['quantity'] = 1;
      json['choiceID'] = cartController.currentChoiceID.value;
      json['color_name'] = cartController.currentChoiceColorName.value;
      Item item = Item.fromJson(json);
      cartController.addItem(item);
      Get.back();
  }
}
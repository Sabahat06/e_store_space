import 'dart:ui';
import 'package:e_store_space/controller/auth_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/dummy_order_controller.dart';
import 'package:e_store_space/controller/place_order_login_controler.dart';
import 'package:e_store_space/view/homepage.dart';
import 'package:e_store_space/widgets/my_text_field.dart';
import 'dart:io' show Platform;


class PlaceOrderLoginScreen extends StatelessWidget {
  AuthController authController = Get.find();
  PlaceOrderLoginController controller = Get.put(PlaceOrderLoginController());
  String totalAmount;

  TextEditingController addressController;
  TextEditingController messageController = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  PlaceOrderLoginScreen({this.totalAmount}){
    name = TextEditingController(text: authController.user.value.user.name);
    email = TextEditingController(text: authController.user.value.user.email);
    address = TextEditingController(text: authController.user.value.user.address);
    phone = TextEditingController(text: authController.user.value.user.phoneNo);
    city = TextEditingController(text: authController.user.value.user.city);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.white,),
        leadingWidth: 30,
        title: const Text('Checkout', style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MyTextField(
                        prefixIcon: IconButton(icon: Icon(Icons.person_outlined, color: Colors.blue,)),
                        controller: name,
                        label: 'Name',
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        prefixIcon: IconButton(icon: Icon(Icons.email_outlined, color: Colors.blue,)),
                        controller: email,
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        prefixIcon: IconButton(icon: Icon(Icons.phone_outlined, color: Colors.blue,)),
                        controller: phone,
                        label: 'Phone Number',
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        minLines: 2,
                        // any number you need (It works as the rows for the textarea)
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: address,
                        decoration: const InputDecoration(
                          prefixIcon: IconButton(icon: Icon(Icons.home_outlined, color: Colors.blue,)),
                          fillColor: Colors.blue,
                          focusColor: Colors.blue,
                          hoverColor: Colors.blue,
                          labelText: 'Address',
                          hintStyle:
                          TextStyle(color: Colors.black54, fontSize: 12),
                          labelStyle:
                          TextStyle(color: Colors.blue, fontSize: 16),
                          disabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.blue)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.blue)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.blue)),
                          border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.blue)),
                          // hintText: label,
                        ),
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        prefixIcon: IconButton(icon: Icon(Icons.home_outlined, color: Colors.blue,)),
                        controller: area,
                        label: 'Area',
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        prefixIcon: IconButton(icon: Icon(Icons.location_city_outlined, color: Colors.blue,)),
                        controller: city,
                        label: 'City',
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        prefixIcon: IconButton(icon: Icon(Icons.location_city_outlined, color: Colors.blue,)),
                        controller: country,
                        label: 'Country',
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue,)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(child: Text('Shipping Address', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),),
                              const SizedBox(height: 5,),
                              const Divider(color: Colors.grey,),
                              const SizedBox(height: 5,),
                              const Text('Address', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                              const SizedBox(height: 5,),
                              MyTextField(height: 80 ,controller: addressController, label: 'Billing Address', maxLines: 2,),
                              const SizedBox(height: 10,),
                              const Text('Order Notes', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                              const SizedBox(height: 5,),
                              Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height*0.17,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: TextField(
                                  controller: messageController,
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.newline,
                                  minLines: 1,
                                  maxLines: 5,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter Message',
                                    hintStyle: TextStyle(color: Colors.blue),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue)
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Delivery Charges', style: TextStyle(fontSize: 16),),
                            Text('To Be Calculated'),

                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue)
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Amount', style: TextStyle(fontSize: 16.sp),),
                            Text("450", style: TextStyle(fontSize: 16.sp, color: Colors.blue),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: GestureDetector(
                  onTap: () async {
                    Get.off(HomePage());
                    // if(placeOrderValidation()){
                    //   List<PlaceOrderDetailModal> orderDetails = [];
                    //   if(cartController.cart.items.length>0)
                    //   {
                    //     cartController.cart.items.forEach((product) {orderDetails.add(PlaceOrderDetailModal(productId: product.id,quantity: product.quantity.toString(),choiceId: product.choiceID));});
                    //   }
                    //   controller.progressing.value = true;
                    //   var response = await HttpService.placeOrderForLoginCustomer(
                    //       billingAddress: addressController.text,
                    //       customerID: authController.user.value.id,
                    //       slotId: slotsController.timeSlotIndex.value.toString(),
                    //       orderNotes: messageController.text,
                    //       deliveryDate: controller.deliveryDate.value,
                    //       amount: totalAmount,
                    //       orderDetails: orderDetails
                    //   );
                    //   Orders order = await HttpService.getOrderWithID( response['order_id'].toString());
                    //   controller.progressing.value = false;
                    //   Fluttertoast.showToast(msg: response['msg']);
                    //   cartController.clearCart();
                    //   Get.off(() => OrderStatusScreen(order: order));
                    // }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    height: 45,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text('CONFIRM ORDER', style: TextStyle(color: Colors.white, fontSize: 20),),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Platform.isIOS ? const SizedBox(height: 10,) : Container()
            ],
          ),
        ),

    );
  }


  // renderDialogBoxItem(TimeSlotModel slot, int index){
  //   if(controller.deliveryDate.value != controller.todayDate){
  //     for(int i=0;i<slotsController.timeSlots.value.length; i++){
  //       slotsController.timeSlots[i].status.value = 'Enabled';
  //     }
  //   }
  //   return Container(
  //     width: double.infinity,
  //     child: GestureDetector(
  //       onTap: (){
  //         if(slot.status.value != 'Disabled')
  //         {
  //           slotsController.timeSlotIndex.value=index;
  //           slotsController.slotFieldController.text = "${slot.timeFrom} - ${slot.timeTo}";
  //           slotsController.selectedTimeSlot.value = "${slot.timeFrom} - ${slot.timeTo}";
  //         }
  //       },
  //       child: Column(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.only(left: 12),
  //             child: Row(
  //               children: [
  //                 Obx(
  //                 () =>
  //                 slot.status.value == 'Disabled' ?  disabledIcon : slotsController.timeSlotIndex.value==index?selectedIcon:enableIcon,),
  //                 const SizedBox(width: 15,),
  //                 Text("${slot.timeFrom} - ${slot.timeTo}", style: const TextStyle(fontSize: 18),),
  //               ],
  //             ),
  //           ),
  //           const SizedBox(height: 5,),
  //           Divider(color: Colors.grey[700],),
  //           const SizedBox(height: 5,),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // renderDialogBox(){
  //   slotsController.loadSlots();
  //   // controller.isChecked.value = false;
  //   return Get.dialog(Scaffold(
  //     backgroundColor: Colors.transparent,
  //     body: Center(
  //       child: Stack(
  //         children: [
  //           GestureDetector(
  //             onTap:(){
  //               Get.back();
  //             },
  //             child: Container(
  //               color: Colors.transparent,
  //               width: Get.width,
  //               // height: Get.height,
  //             ),
  //           ), Center(
  //             child: Stack(
  //               children: [
  //                 Container(
  //                   height: 450,
  //                   width: 350,
  //                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white,),
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(12.0),
  //                     child: Center(
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.center,
  //                         children: [
  //                           const SizedBox(height: 10,),
  //                           Row(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               const Icon(Icons.schedule_outlined, color: ColorPalette.blue, size: 75,),
  //                               const SizedBox(width: 7,),
  //                               Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   const Text('Select Estimated Time', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
  //                                   const SizedBox(height: 7,),
  //                                   Container(width: 200, child: Text('SELECT FROM THE OPTION BELOW', style: TextStyle(fontSize: 16))),
  //                                   const SizedBox(height: 7,),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           const SizedBox(height: 5,),
  //                           Divider(color: Colors.grey[700],),
  //                           const SizedBox(height: 5,),
  //                           Container(
  //                             height: 240,
  //                             child: ListView.builder(
  //                                 itemCount: slotsController.timeSlots.length,
  //                                 shrinkWrap: true,
  //                                 itemBuilder: (context, index) => renderDialogBoxItem(slotsController.timeSlots[index], index)
  //                             ),
  //                           ),
  //                           const SizedBox(height: 7,),
  //                           Container(),
  //                           const SizedBox(height: 7,),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.end,
  //                             children: [
  //                               MyFilledButton(
  //                                 width: 100,
  //                                 txtColor: Colors.grey ,
  //                                 color: Colors.white,
  //                                 txt: 'CANCEL',
  //                                 borderRadius: 5,
  //                                 ontap: (){
  //                                   Get.back();
  //                                 },
  //                               ),
  //                               const SizedBox(width: 7,),
  //                               MyFilledButton(
  //                                 width: 80,
  //                                 color: ColorPalette.blue,
  //                                 txt: 'DONE',
  //                                 borderRadius: 5,
  //                                 ontap: (){
  //                                   Get.back();
  //                                 },
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   ));
  // }
  //
  // bool placeOrderValidation(){
  //   if(slotsController.selectedTimeSlot.value.length==0){
  //     Fluttertoast.showToast(msg: 'Time Slot is Required');
  //     return false;
  //   }
  //   else if
  //   (addressController.text.trim().length==0){
  //     Fluttertoast.showToast(msg: 'Address is required');
  //     return false;
  //   }else if
  //   (controller.deliveryDate.value.length==0){
  //     Fluttertoast.showToast(msg: 'Date is required');
  //     return false;
  //   }
  //   else
  //     return true;
  // }

}

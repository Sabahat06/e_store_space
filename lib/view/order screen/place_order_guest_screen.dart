// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:yousafmobile/controller/cart_controller.dart';
// import 'package:yousafmobile/controller/place_order_login_controler.dart';
// import 'package:yousafmobile/controller/time_slots_controller.dart';
// import 'package:yousafmobile/models/place_order_detail_modal.dart';
// import 'package:yousafmobile/models/time_slot.dart';
// import 'package:yousafmobile/services/http_services.dart';
// import 'package:yousafmobile/settings/color_palates.dart';
// import 'package:yousafmobile/widgets/my_filled_button.dart';
// import 'package:yousafmobile/widgets/my_text_field.dart';
//
// class PlaceOrderGuestScreen extends StatelessWidget {
//   PlaceOrderLoginController controller = PlaceOrderLoginController();
//   CartController cartController = Get.find();
//   TimeSlotsController slotsController = TimeSlotsController();
//   Icon disabledIcon = Icon(Icons.circle,color:Colors.grey);
//   Icon selectedIcon = Icon(Icons.circle,color:Colors.green);
//   Icon enableIcon = Icon(Icons.circle_outlined,color:Colors.green);
//   TextEditingController addressController = TextEditingController();
//   TextEditingController messageController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController mobileController = TextEditingController();
//   TextEditingController cityController = TextEditingController();
//
//   String totalAmount;
//   PlaceOrderGuestScreen(this.totalAmount);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {Get.back();}, color: Colors.black,),
//         leadingWidth: 30,
//         title: const Text('Checkout', style: TextStyle(color: Colors.black),),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                           border: Border.all(color: Colors.orange,)
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Center(child: Text('Billing Address', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),),
//                             const SizedBox(height: 5,),
//                             const Divider(color: Colors.grey,),
//                             const SizedBox(height: 5,),
//                             const Text('Name:', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
//                             const SizedBox(height: 5,),
//                             MyTextField(controller: nameController, label: 'Name'),
//                             const SizedBox(height: 10,),
//                             const Text('Email:', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
//                             const SizedBox(height: 5,),
//                             MyTextField(controller: emailController, label: 'Email', keyboardType: TextInputType.emailAddress,),
//                             const SizedBox(height: 10,),
//                             const Text('Mobile Number:', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
//                             const SizedBox(height: 5,),
//                             MyTextField(controller: mobileController, label: 'Mobile Number', keyboardType: TextInputType.emailAddress,),
//                             const SizedBox(height: 10,),
//                             const Text('City:', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
//                             const SizedBox(height: 5,),
//                             MyTextField(controller: cityController, label: 'City', keyboardType: TextInputType.emailAddress,),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10,),
//                     Row(
//                       children: [
//                         Row(
//                           children: const [
//                             Icon(Icons.calendar_today_outlined, size: 20,),
//                             SizedBox(width: 7),
//                             Text('Delivery Day', style: TextStyle(color: Colors.black, fontSize: 16)),
//                           ],
//                         ),
//                         const SizedBox(width: 14,),
//                         Expanded(
//                           child: Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.orange,),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 10),
//                               child: GestureDetector(
//                                 onTap: (){
//                                   controller.selectDate(context);
//                                 },
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Obx(() => Text(controller.deliveryDate.value, style: const TextStyle(fontSize: 16),)),
//                                     const IconButton(
//                                       icon: Icon(
//                                         Icons.reorder_outlined,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10,),
//                     Row(
//                       children: [
//                         Row(
//                           children: const [
//                             Icon(Icons.watch_later_outlined, size: 20,),
//                             SizedBox(width: 7),
//                             Text('Delivery Time', style: TextStyle(color: Colors.black, fontSize: 16)),
//                           ],
//                         ),
//                         const SizedBox(width: 7,),
//                         Expanded(
//                           child: Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.orange,),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 7),
//                               child: GestureDetector(
//                                 onTap: (){renderDialogBox();},
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Obx(() => Text(slotsController.selectedTimeSlot.value, style: const TextStyle(fontSize: 14),)),
//                                     const IconButton(
//                                       icon: Icon(
//                                         Icons.reorder_outlined,
//                                         color: Colors.black,),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10,),
//                     Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                           border: Border.all(color: Colors.orange,)
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Center(child: Text('Billing Address', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),),
//                             const SizedBox(height: 5,),
//                             const Divider(color: Colors.grey,),
//                             const SizedBox(height: 5,),
//                             const Text('Address:', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
//                             const SizedBox(height: 5,),
//                             MyTextField(controller: addressController, label: 'Billing Address'),
//                             const SizedBox(height: 10,),
//                             const Text('Order Notes:', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
//                             const SizedBox(height: 5,),
//                             Container(
//                               width: double.infinity,
//                               height: MediaQuery.of(context).size.height*0.17,
//                               decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.orange),
//                                 borderRadius: BorderRadius.circular(5),
//                               ),
//                               child: TextField(
//                                 controller: messageController,
//                                 keyboardType: TextInputType.multiline,
//                                 textInputAction: TextInputAction.newline,
//                                 minLines: 1,
//                                 maxLines: 5,
//                                 decoration: const InputDecoration(
//                                   hintText: 'Enter Message',
//                                   hintStyle: TextStyle(color: Colors.black87),
//                                   border: OutlineInputBorder(
//                                     borderSide: BorderSide.none,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 10,),
//                     Container(
//                       decoration: BoxDecoration(
//                           border: Border.all(color: Colors.orange)
//                       ),
//                       padding: const EdgeInsets.all(10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text('Total Amount', style: TextStyle(fontSize: 16),),
//                           Text(totalAmount, style: const TextStyle(fontSize: 16),),
//                         ],
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(3.0),
//               child: GestureDetector(
//                 onTap: () async {
//                   if(placeOrderValidation()){
//                     List<PlaceOrderDetailModal> orderDetails = [];
//                     if(cartController.cart.products.length>0)
//                     {
//                       cartController.cart.products.forEach((product) {orderDetails.add(PlaceOrderDetailModal(productId: product.id,quantity: product.quantity.toString()));});
//                     }
//                     controller.progressing.value = true;
//                     // var response = await HttpService.placeOrderForLoginCustomer(
//                     //     billingAddress: addressController.text,
//                     //     customerID: authController.user.value.id,
//                     //     slotId: slotsController.timeSlotIndex.value.toString(),
//                     //     orderNotes: messageController.text,
//                     //     deliveryDate: controller.deliveryDate.value,
//                     //     amount: totalAmount,
//                     //     orderDetails: orderDetails
//                     // );
//                     controller.progressing.value = false;
//                     // if(response['status']=='success'){
//                     //   Fluttertoast.showToast(msg: response['msg']);
//                     //   Get.off(HomePage());
//                     // }
//                   }
//                 },
//                 child: Container(
//                   height: 45,
//                   color: Colors.orange,
//                   width: double.infinity,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       Padding(
//                         padding: EdgeInsets.all(10),
//                         child: Text('CONFIRM ORDER', style: TextStyle(color: Colors.white, fontSize: 20),),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   renderDialogBoxItem(TimeSlotModel slot, int index){
//     if(controller.deliveryDate.value != controller.todayDate){
//       for(int i=0;i<slotsController.timeSlots.value.length; i++){
//         slotsController.timeSlots[i].status.value = 'Enabled';
//       }
//     }
//     return Container(
//       width: double.infinity,
//       child: GestureDetector(
//         onTap: (){
//           if(slot.status.value != 'Disabled')
//           {
//             slotsController.timeSlotIndex.value=index;
//             slotsController.slotFieldController.text = "${slot.timeFrom} - ${slot.timeTo}";
//             slotsController.selectedTimeSlot.value = "${slot.timeFrom} - ${slot.timeTo}";
//           }
//         },
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 12),
//               child: Row(
//                 children: [
//                   Obx(
//                         () =>
//                     slot.status.value == 'Disabled' ?  disabledIcon : slotsController.timeSlotIndex.value==index?selectedIcon:enableIcon,),
//                   const SizedBox(width: 15,),
//                   Text("${slot.timeFrom} - ${slot.timeTo}", style: const TextStyle(fontSize: 18),),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 5,),
//             Divider(color: Colors.grey[700],),
//             const SizedBox(height: 5,),
//           ],
//         ),
//       ),
//     );
//   }
//
//   renderDialogBox(){
//     slotsController.loadSlots();
//     // controller.isChecked.value = false;
//     return Get.dialog(Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Center(
//         child: Stack(
//           children: [
//             GestureDetector(
//               onTap:(){
//                 Get.back();
//               },
//               child: Container(
//                 color: Colors.transparent,
//                 width: Get.width,
//                 // height: Get.height,
//               ),
//             ), Center(
//               child: Stack(
//                 children: [
//                   Container(
//                     height: 450,
//                     width: 350,
//                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white,),
//                     child: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Center(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             const SizedBox(height: 10,),
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Icon(Icons.schedule_outlined, color: ColorPalette.green, size: 75,),
//                                 const SizedBox(width: 7,),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text('Select Estimated Time', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
//                                     const SizedBox(height: 7,),
//                                     Container(width: 200, child: Text('SELECT FROM THE OPTION BELOW', style: TextStyle(fontSize: 16))),
//                                     const SizedBox(height: 7,),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 5,),
//                             Divider(color: Colors.grey[700],),
//                             const SizedBox(height: 5,),
//                             Container(
//                               height: 240,
//                               child: ListView.builder(
//                                   itemCount: slotsController.timeSlots.length,
//                                   shrinkWrap: true,
//                                   itemBuilder: (context, index) => renderDialogBoxItem(slotsController.timeSlots[index], index)
//                               ),
//                             ),
//                             const SizedBox(height: 7,),
//                             Container(),
//                             const SizedBox(height: 7,),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 MyFilledButton(
//                                   width: 100,
//                                   txtColor: Colors.grey ,
//                                   color: Colors.white,
//                                   txt: 'CANCEL',
//                                   borderRadius: 5,
//                                   ontap: (){
//                                     Get.back();
//                                   },
//                                 ),
//                                 const SizedBox(width: 7,),
//                                 MyFilledButton(
//                                   width: 80,
//                                   color: ColorPalette.orange,
//                                   txt: 'DONE',
//                                   borderRadius: 5,
//                                   ontap: (){
//                                     Get.back();
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
//
//   bool placeOrderValidation(){
//     if(nameController.text.trim().length==0){
//       Fluttertoast.showToast(msg: 'Name is Required');
//       return false;
//     }else if
//     (!GetUtils.isEmail(emailController.text)){
//       Fluttertoast.showToast(msg: 'Email format is not correct');
//       return false;
//     }
//     else if
//     (emailController.text.trim().length==0){
//       Fluttertoast.showToast(msg: 'Email is required');
//       return false;
//     }else if
//     (mobileController.text.trim().length == 0){
//       Fluttertoast.showToast(msg: 'Phone Number is required');
//       return false;
//     }
//     else if
//     (addressController.text.trim().length==0){
//       Fluttertoast.showToast(msg: 'Address is required');
//       return false;
//     }else if
//     (cityController.text.trim().length==0){
//       Fluttertoast.showToast(msg: 'City is required');
//       return false;
//     }else if
//     (controller.deliveryDate.value.length==0){
//       Fluttertoast.showToast(msg: 'Time Slot is required');
//       return false;
//     }
//     else
//       return true;
//   }
//
// }

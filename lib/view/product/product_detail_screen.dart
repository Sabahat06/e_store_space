// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:yousafmobile/controller/cart_controller.dart';
// import 'package:yousafmobile/models/product_model.dart';
//
// class ProductDetailsScreen extends StatelessWidget {
//   Products products;
//
//
//   ProductDetailsScreen({@required this.products}) {
//     productDetailsController.totalPrice.value = int.parse(products.salePrice);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(products.title),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Image(
//                   image: NetworkImage(
//                 products.photo,
//               )),
//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     products.title,
//                     style: const TextStyle(
//                       fontSize: 23,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   IconButton(
//                       onPressed: () {}, icon: const Icon(Icons.favorite_border))
//                 ],
//               ),
//               const SizedBox(height: 12,),
//               Obx(
//                 () =>
//                     Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                    Container(
//                      child: Row(
//                        children: [
//                          GestureDetector(
//                            onTap: () {
//                              if(productDetailsController.amount.value>1){
//                                productDetailsController.amount.value--;
//                                productDetailsController.totalPrice.value= productDetailsController.totalPrice.value-int.parse(products.salePrice);
//                              };
//                            },
//                            child: Container(
//                              width: 30,
//                              height: 30,
//                              decoration: BoxDecoration(
//                                  borderRadius: BorderRadius.circular(7),
//                                  color: Colors.blueGrey[100]),
//                              child: const Icon(
//                                Icons.remove,
//                                size: 20,
//                              ),
//                            ),
//                          ),
//                          const SizedBox(
//                            width: 7,
//                          ),
//                          Text(
//                            '${productDetailsController.amount.value}',
//                            style: const TextStyle(fontSize: 20),
//                          ),
//                          const SizedBox(
//                            width: 7,
//                          ),
//                          GestureDetector(
//                            onTap: (){
//                              productDetailsController.amount.value++;
//                              productDetailsController.totalPrice.value=productDetailsController.totalPrice.value+int.parse(products.salePrice);
//                              print(productDetailsController.totalPrice.value);
//                            },
//                            child: Container(
//                              width: 30,
//                              height: 30,
//                              decoration: BoxDecoration(
//                                  borderRadius: BorderRadius.circular(7),
//                                  color: Colors.blueGrey[100]),
//                              child: const Icon(
//                                Icons.add,
//                                size: 20,
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(products.salePrice,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//                     ),
//
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

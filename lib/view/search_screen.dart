import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_store_space/controller/bottom_bar_controller.dart';
import 'package:e_store_space/controller/search_product_controller.dart';
import 'package:e_store_space/view/product/product_screen.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController search = TextEditingController();
  SearchProductController controller = SearchProductController();
  BottomBarController bottomBarController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              Get.back();
            },
            color: Colors.black,
          ),
          leadingWidth: 25,
          title: Container(
            alignment: Alignment.centerLeft,
            color: Colors.white,
            width: double.infinity,
            child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search Product',
              ),
              onChanged: (value) {
                if (value.length == 0)
                  controller.clearSearches();
                else
                  controller.loadSearchProduct(value);
              },
            ),
          ),
        ),
        body: controller.searchedProducts.length == 0
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.search_outlined,
                      size: 60,
                      color: Colors.black38,
                    ),
                    Text(
                      'Looking for anything search here',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    //),
                    // listItem(1),
                  ],
                ),
              )
            : ListView(
                children: controller.searchedProducts.value.map(
                (item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => ProductScreen(
                            item.subCategoryId, 0, item.subCategoryTitle));
                      },
                      child: Container(
                        // height: 50,
                        color: Colors.grey[100],
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  child: Text(
                                item.title,
                                style:
                                    TextStyle(fontSize: 16, letterSpacing: 1),
                              )),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  item.discount != '0'
                                      ? item.discountedPrice
                                      : item.salePrice,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ).toList()),
      ),
    );
  }
}

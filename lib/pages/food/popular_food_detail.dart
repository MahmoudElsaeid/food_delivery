import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';

import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_column_detail.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;

  const PopularFoodDetail({
    Key? key,
    required this.pageId, required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            //background image
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(AppConstants.BASE_URL +
                      AppConstants.UPLOAD_URL +
                      product.img!),
                )),
              ),
            ),
            //icon widgets
            Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if(page=='cartPage'){
                        Get.toNamed(RouteHelper.getCartPage());
                      }else{
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                    ),
                  ),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: (){
                        if(controller.totalItems >= 1)
                        Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: Stack(children: [
                        AppIcon(
                          icon: Icons.shopping_cart_outlined,
                        ),
                        controller.totalItems >= 1
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: AppIcon(
                                  icon: Icons.circle,
                                  size: Dimensions.iconSize20,
                                  iconColor: Colors.transparent,
                                  backgroundColor: AppColors.mainColor,
                                ),
                              )
                            : Container(),
                        Get.find<PopularProductController>().totalItems >= 1
                            ? Positioned(
                                right: 3,
                                top: 3,
                                child: Center(
                                  child: BigText(
                                    text: Get.find<PopularProductController>()
                                        .totalItems
                                        .toString(),
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Container(),
                      ]),
                    );
                  })
                ],
              ),
            ),
            //introduction of food
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImgSize - 20,
              child: Container(
                padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.height20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius30),
                    topLeft: Radius.circular(Dimensions.radius30),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumnDetail(
                      text: product.name!,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    BigText(
                      text: 'Description',
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: ExpandableTextWidget(
                          text: product.description!,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar:
        GetBuilder<PopularProductController>(builder: (popularProduct) {
          return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(
              top: Dimensions.height30,
              bottom: Dimensions.height30,
              left: Dimensions.height20,
              right: Dimensions.height20,
            ),
            decoration: BoxDecoration(
              color: AppColors.buttomBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  Dimensions.radius20 * 2,
                ),
                topRight: Radius.circular(
                  Dimensions.height20 * 2,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(Dimensions.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Dimensions.radius20,
                      ),
                      color: Colors.white),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(false);
                        },
                        child: const Icon(
                          Icons.remove,
                          color: AppColors.signColor,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      BigText(text: popularProduct.inCartItems.toString()),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(true);
                        },
                        child: const Icon(
                          Icons.add,
                          color: AppColors.signColor,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    popularProduct.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.height20),
                    child: BigText(
                      text: 'EGP ${product.price!} | Add to card',
                      color: Colors.white,
                      size: Dimensions.font16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Dimensions.radius20,
                      ),
                      color: AppColors.mainColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        },)
    );
  }
}

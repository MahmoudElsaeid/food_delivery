import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
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
                    icon: Icons.clear,
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
                            text: Get.find<PopularProductController>().totalItems.toString(),
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
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30),
              child: Container(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                child: Center(
                  child: BigText(
                    text: product.name!,
                    size: Dimensions.font26,
                  ),
                ),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.height30),
                    topLeft: Radius.circular(Dimensions.height30),
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            //collapsedHeight: 70,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: ExpandableTextWidget(
                      text: product.description!,
                  ),
                  margin: EdgeInsets.only(
                      left: Dimensions.width20, right: Dimensions.width20),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: Dimensions.width20*2.5,
                left: Dimensions.width20*2.5,
                bottom: Dimensions.height10,
                top: Dimensions.height10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap:(){
                      controller.setQuantity(false);
                    },
                    child: AppIcon(
                      icon: Icons.remove,
                      iconSize: Dimensions.iconSize24,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                    ),
                  ),
                  BigText(
                    text: '\$ ${product.price!}  X  ${controller.inCartItems} ',
                    color: AppColors.mainBlackColor,
                    size: Dimensions.font26,
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(true);
                    },
                    child: AppIcon(
                      icon: Icons.add,
                      iconSize: Dimensions.iconSize24,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
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
                  topLeft: Radius.circular(Dimensions.radius20*2,),
                  topRight: Radius.circular(Dimensions.height20*2,),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(Dimensions.height20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20,),
                        color: Colors.white
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.height20),
                      child: BigText(text: '\$ ${product.price!} | Add to card', color: Colors.white,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20,),
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }
      ),
    );
  }
}

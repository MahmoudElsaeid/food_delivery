import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/common_text_button.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/pages/order/delivery_option.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/utils/styles.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/app_text_Field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/payment_option_button.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import '../../models/place_order_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _noteController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          //header
          Positioned(
            top: Dimensions.height20 * 3,
            right: Dimensions.width20,
            left: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: ()=>Get.back(),
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                SizedBox(
                  width: Dimensions.width45 * 4,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
              ],
            ),
          ),
          //bode
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getItems.isNotEmpty ? Positioned(
              top: Dimensions.height20 * 6,
              right: Dimensions.width20,
              left: Dimensions.width20,
              bottom: 0,
              child: Container(
                //color: Colors.redAccent,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder: (cartController) {
                    var _cartList = cartController.getItems;
                    return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: _cartList.length,
                        itemBuilder: (_, index) {
                          return Container(
                            width: double.maxFinite,
                            height: Dimensions.height20 * 5,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    var popularIndex =
                                    Get
                                        .find<PopularProductController>()
                                        .popularProductList
                                        .indexOf(_cartList[index].product!);
                                    if (popularIndex >= 0) {
                                      Get.toNamed(RouteHelper.getPopularFood(
                                          popularIndex, 'cartPage'));
                                    } else {
                                      var recommendedIndex =
                                      Get
                                          .find<RecommendedProductController>()
                                          .recommendedProductList
                                          .indexOf(_cartList[index].product!);
                                      if (recommendedIndex < 0) {
                                        Get.snackbar(
                                          "History product",
                                          "Product review is not available for history products",
                                          backgroundColor: AppColors.mainColor,
                                          colorText: Colors.white,
                                        );
                                      } else {
                                        Get.toNamed(
                                            RouteHelper.getRecommendedFood(
                                                recommendedIndex, 'cartPage'));
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: Dimensions.height20 * 5,
                                    height: Dimensions.height20 * 5,
                                    margin: EdgeInsets.only(
                                        bottom: Dimensions.height10),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          AppConstants.BASE_URL +
                                              AppConstants.UPLOAD_URL +
                                              cartController.getItems[index]
                                                  .img!,
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius20),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.width10,
                                ),
                                Expanded(
                                  child: Container(
                                    height: Dimensions.height20 * 5,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(
                                          text: cartController
                                              .getItems[index].name!,
                                          color: Colors.black54,
                                        ),
                                        SmallText(text: "Spicy"),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(
                                              text:
                                              "\$ ${cartController
                                                  .getItems[index].price!
                                                  .toString()}",
                                              color: Colors.redAccent,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Dimensions.height10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                    Dimensions.radius20,
                                                  ),
                                                  color: Colors.white),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      cartController.addItem(
                                                          _cartList[index]
                                                              .product!,
                                                          -1);
                                                    },
                                                    child: const Icon(
                                                      Icons.remove,
                                                      color: AppColors
                                                          .signColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: Dimensions.width10 /
                                                        2,
                                                  ),
                                                  BigText(
                                                      text: _cartList[index]
                                                          .quantity
                                                          .toString()),
                                                  //popularProduct.inCartItems.toString()),
                                                  SizedBox(
                                                    width: Dimensions.width10 /
                                                        2,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      cartController.addItem(
                                                          _cartList[index]
                                                              .product!,
                                                          1);
                                                    },
                                                    child: const Icon(
                                                      Icons.add,
                                                      color: AppColors
                                                          .signColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  }),
                ),
              ),
            )
                : const NoDataPage(text: "Your cart is empty");
          })
        ],
      ),
      //bottom bar
      bottomNavigationBar: GetBuilder<OrderController>(builder: (orderController){
        _noteController.text = orderController.foodNote;
        return GetBuilder<CartController>(
            builder: (cartController) {
              return Container(
                height: Dimensions.bottomHeightBar + 50,
                padding: EdgeInsets.only(
                  top: Dimensions.height10,
                  bottom: Dimensions.height10,
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
                child: cartController.getItems.length>0?Column(
                  children: [
                    InkWell(
                      onTap: () =>
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (_) {
                              return Column(
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: Container(
                                        height: MediaQuery.of(context).size.height * 0.9,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(Dimensions.radius20),
                                              topRight: Radius.circular(Dimensions.radius20),
                                            )
                                        ),
                                        child:Column(
                                          children: [
                                            Container(
                                              height: 520,
                                              padding: EdgeInsets.only(
                                                top: Dimensions.height20,
                                                right: Dimensions.width20,
                                                left: Dimensions.width20,
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const PaymentOptionButton(
                                                    title: 'cash on delivery',
                                                    icon: Icons.money,
                                                    subTittle: 'You pay after getting the delivery',
                                                    index: 0,
                                                  ),
                                                  SizedBox(height: Dimensions.height10/2),
                                                  const PaymentOptionButton(
                                                    title: 'digital payment',
                                                    icon: Icons.paypal_outlined,
                                                    subTittle: 'Safer and faster way of payment',
                                                    index: 1,
                                                  ),
                                                  SizedBox(height: Dimensions.height30),
                                                  Text(
                                                    'Delivery option',
                                                    style: robotoRegular.copyWith(fontSize: Dimensions.font24),
                                                  ),
                                                  DeliveryOption(
                                                    value: 'delivery',
                                                    title: 'Home delivery',
                                                    amount: double.parse(Get.find<CartController>().totalAlmount.toString()),
                                                    isFree: false,
                                                  ),
                                                  // SizedBox(height: Dimensions.height10/4),
                                                  const DeliveryOption(
                                                    value: 'take away',
                                                    title: 'Take away',
                                                    amount: 10.0,
                                                    isFree: true,
                                                  ),
                                                  SizedBox(height: Dimensions.height20),
                                                  Text(
                                                    'Additional info',
                                                    style: robotoRegular.copyWith(fontSize: Dimensions.font24),
                                                  ),
                                                  SizedBox(height: Dimensions.height10),
                                                  AppTextField(
                                                    textController: _noteController,
                                                    hintText: '',
                                                    icon: Icons.note,
                                                    maxLines: true,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ).whenComplete(() => orderController.setFoodNote(_noteController.text.trim())),
                      child: const SizedBox(
                        width: double.maxFinite,
                        child: CommonTextButton(text: 'Payment options'),
                      ),
                    ),
                    SizedBox(height: Dimensions.height10),
                    Row(
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
                              SizedBox(
                                width: Dimensions.width10 / 2,
                              ),
                              BigText(text: '\$ ' +
                                  cartController.totalAlmount.toString()),
                              SizedBox(
                                width: Dimensions.width10 / 2,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              if (Get.find<AuthController>().userLoggedIn()) {
                                Get.find<AuthController>().updateToken();
                                if (Get.find<LocationController>().addressList.isEmpty) {
                                  Get.toNamed(RouteHelper.getAddressPage());
                                } else {
                                  var location = Get.find<LocationController>().getUserAddress();
                                  var cart = Get.find<CartController>().getItems;
                                  var user = Get.find<UserController>().userModel;
                                  PlaceOrderBody placeOrder = PlaceOrderBody(
                                    cart: cart,
                                    orderAmount: 100.0,
                                    orderNote: orderController.foodNote,
                                    address: location.address,
                                    latitude: location.latitude,
                                    longitude: location.longitude,
                                    contactPersonName: user!.name,
                                    contactPersonNumber: user!.phone,
                                    scheduleAt: '',
                                    distance: 10.0,
                                    orderType: orderController.orderType,
                                    paymentMethod: orderController.paymentIndex==0?'cash_on_delivery':'digital_payment',
                                  );
                                  /*print(placeOrder.toJson()['order_type']);
                                  return;*/
                                  Get.find<OrderController>().placeOrder(
                                    placeOrder,
                                    _callback,
                                  );
                                }
                              } else {
                                Get.toNamed(RouteHelper.getSignInPage());
                              }
                            },
                            child: const CommonTextButton(text: 'Check out')
                        ),
                      ],
                    ),
                  ],
                ) : Container(),
              );
            });
      }),
    );
  }

  void _callback(bool isSuccess, String message, String orderID) {
    if (isSuccess) {
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPreference();
      Get.find<CartController>().addToHistory();
      if(Get.find<OrderController>().paymentIndex==0){
        Get.offNamed(RouteHelper.getOrderSuccessPage(orderID, 'success'));
      }else{
        Get.offNamed(RouteHelper.getPaymentPage(orderID, Get.find<UserController>().userModel!.id));
      }
    } else {
      showCustomSnackBar(message);
    }
  }
}

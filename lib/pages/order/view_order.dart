import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/styles.dart';
import 'package:get/get.dart';

import '../../base/custom_loader.dart';
import '../../utils/dimensions.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;

  const ViewOrder({Key? key, required this.isCurrent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(builder: (orderController) {
        if (orderController.isLoading == false) {
          late List<OrderModel> orderList;
          if (orderController.currentOrderList.isNotEmpty) {
            orderList = isCurrent
                ? orderController.currentOrderList.reversed.toList()
                : orderController.historyOrderList.reversed.toList();
          }
          return SizedBox(
            width: Dimensions.screenWidth,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width15,),
              child: ListView.builder(
                itemCount: orderList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => null,
                    child: Column(children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(width: 0.5, color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(Dimensions.radius20/4)
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(Dimensions.height10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Order ID',
                                    style: robotoMedium.copyWith(
                                      fontSize: Dimensions.font14
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.width10/2),
                                  Text('#${orderList[index].id.toString()}'),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      borderRadius: BorderRadius.circular(Dimensions.radius20/4)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: Dimensions.height10/2,
                                        horizontal: Dimensions.height10,
                                      ),
                                      child: Text('${orderList[index].orderStatus}',
                                        style: robotoMedium.copyWith(fontSize: Dimensions.font12,color: Theme.of(context).cardColor),
                                      ),
                                    ),),
                                  SizedBox(
                                    height: Dimensions.height10 / 2,
                                  ),
                                  InkWell(
                                    onTap: () => null,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                                          borderRadius: BorderRadius.circular(Dimensions.radius20/4)
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: Dimensions.height10/4,
                                          horizontal: Dimensions.height10/2,
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/image/tracking.png',
                                              height: Dimensions.height20,
                                              width: Dimensions.width20,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                            SizedBox(width: Dimensions.width10/2),
                                            Text('Track order'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.height10,),
                    ]),
                  );
                },
              ),
            ),
          );
        } else {
          return CustomLoader();
        }
      }),
    );
  }
}

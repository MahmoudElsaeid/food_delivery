import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/utils/styles.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';

class DeliveryOption extends StatelessWidget {
  final String value;
  final String title;
  final double amount;
  final bool isFree;

   const DeliveryOption({Key? key,
     required this.value,
     required this.title,
     required this.amount,
     required this.isFree
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController){
      return Row(
        children: [
          Radio(
            value: value,
            groupValue: orderController.orderType,
            onChanged: (String? value)=>orderController.setDeliveryType(value!),
            activeColor: AppColors.mainColor,
          ),
          SizedBox(height: Dimensions.height10/2),
          Text(title, style: robotoRegular.copyWith(fontSize: Dimensions.font20)),
          SizedBox(height: Dimensions.height10/2),
          Text(
              '(${(value == 'Take away' || isFree) ? 'Free' : '\$${amount/10}'})',
              style: robotoMedium.copyWith(fontSize: Dimensions.font16)
          ),
        ],
      );
    });
  }
}

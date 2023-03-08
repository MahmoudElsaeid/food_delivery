import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/utils/styles.dart';
import 'package:get/get.dart';

class PaymentOptionButton extends StatelessWidget {

  final IconData icon;
  final String title;
  final String subTittle;
  final int index;

   const PaymentOptionButton({Key? key,
     required this.icon,
     required this.title,
     required this.subTittle,
     required this.index
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController){
      bool _selected = orderController.paymentIndex == index;
      return InkWell(
        onTap: ()=>orderController.setPaymentIndex(index),
        child: Container(
          margin: EdgeInsets.only(top: Dimensions.height10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20/4),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[100]!,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 1,
                ),
              ]
          ),
          child: ListTile(
            leading: Icon(
              icon,
              size: Dimensions.font20*2,
              color: _selected ? AppColors.mainColor : Theme.of(context).disabledColor,
            ),
            title: Text(
              title,
              style: robotoMedium.copyWith(fontSize: Dimensions.font20),
            ),
            subtitle: Text(
              subTittle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: robotoRegular.copyWith(
                  color: Theme.of(context).disabledColor,
                  fontSize: Dimensions.font16
              ),
            ),
            trailing: _selected ? Icon(
              Icons.check_circle,
              color: Theme.of(context).primaryColor,
            ) : Icon(
              Icons.check_circle_outline,
              color: Theme.of(context).disabledColor,
            ),
          ),
        ),
      );
    });
  }
}

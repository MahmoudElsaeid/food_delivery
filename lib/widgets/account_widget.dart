import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;

  AccountWidget({Key? key , required this.appIcon, required this.bigText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: Dimensions.width10,
        bottom: Dimensions.width10,
        left: Dimensions.width20
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(
            width: Dimensions.width20,
          ),
          bigText,
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2),
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 1,
            ),
          ]
      ),
    );
  }
}

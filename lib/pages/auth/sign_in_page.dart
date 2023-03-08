import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/models/sign_up_body_model.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_text_Field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController){
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if(phone.isEmpty){
        showCustomSnackBar("Type in your phone number", title: "Phone number");

      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password", title: "Password");

      }else if(password.length<6){
        showCustomSnackBar("Password can not be less then six characters", title: "Password");

      }else{

        authController.login(phone, password).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getCartPage());
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (authController){
          return !authController.isLoading ? SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: Dimensions.screenHeight*0.09,),
                //app logo
                Container(
                  height: Dimensions.screenHeight*0.26,
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: Dimensions.radius20*5,
                      backgroundImage: AssetImage('assets/image/logo part 1.jpg'),
                    ),
                  ),
                ),
                //welcome
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Hello',
                        style: TextStyle(
                            fontSize: Dimensions.font24*2+Dimensions.font10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54
                        ),
                      ),
                      SizedBox(height: Dimensions.height10/8,),
                      Text(
                        'login now to browse our hot offers',
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.height20*2,
                ),
                //your email
                AppTextField(
                  textController: phoneController,
                  hintText: 'Phone',
                  icon: Icons.phone,
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                //your password
                AppTextField(
                  isObscure: true,
                  textController: passwordController,
                  hintText: 'Password',
                  icon: Icons.password_sharp,
                ),
                SizedBox(
                  height: Dimensions.height15,
                ),
                //tag line
                Padding(
                  padding: EdgeInsets.only(right: Dimensions.width20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Sign into your account',
                          style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: Dimensions.font16
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.height20*2,
                ),
                //sign in button
                GestureDetector(
                  onTap: (){
                    _login(authController);
                  },
                  child: Container(
                    width: Dimensions.screenWidth/2,
                    height: Dimensions.screenHeight/13,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),
                    child: Center(
                      child: BigText(
                        text: 'Sign in',
                        size: Dimensions.font26,
                        color: Colors.white,
                      ),
                    ),

                  ),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                SizedBox(
                  height: Dimensions.screenHeight*0.03,
                ),
                //sign up options
                RichText(
                  text: TextSpan(
                      text: 'Don\'n have an account?',
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: Dimensions.font16,
                      ),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(), transition: Transition.fade),
                          text: ' Create',
                          style: TextStyle(
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.font16
                          ),),
                      ]
                  ),
                ),
              ],
            ),
          ) : const CustomLoader();
        },
      )
    );
  }
}

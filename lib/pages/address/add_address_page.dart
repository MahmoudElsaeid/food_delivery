import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_app_bar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/models/address_model.dart';
import 'package:food_delivery/pages/address/pick_address_map.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/app_text_Field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  bool mapIsTapped = Get.find<LocationController>().updateAddressData;
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition = const CameraPosition(
      target: LatLng(31.233020, 29.946686),
      zoom: 17,
  );
  late LatLng _initialPosition = LatLng(31.233020, 29.946686);

  @override
  void initState(){
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if(_isLogged&&Get.find<UserController>().userModel==null){
      Get.find<UserController>().getUserInfo();
    }
    if(Get.find<LocationController>().addressList.isNotEmpty){
      if(Get.find<LocationController>().getUserAddressFromLocalStorage()==''){
        Get.find<LocationController>().saveUserAddress(
            Get.find<LocationController>().addressList.last
        );
      }
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(target: LatLng(
       double.parse(Get.find<LocationController>().getAddress['latitude']),
       double.parse(Get.find<LocationController>().getAddress['longitude']),
      ));
      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress['latitude']),
        double.parse(Get.find<LocationController>().getAddress['longitude']),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Address'),
      body: GetBuilder<UserController>(builder: (userController){
        if(userController.userModel!=null&&_contactPersonName.text.isEmpty){
          _contactPersonName.text = '${userController.userModel?.name}';
          _contactPersonNumber.text = '${userController.userModel?.phone}';
          if(Get.find<LocationController>().addressList.isNotEmpty){
            _addressController.text = Get.find<LocationController>().getUserAddress().address;
          }
        }
        return GetBuilder<LocationController>(builder: (locationController){
          _addressController.text = '${locationController.placemark.name??''}'
              '${locationController.placemark.locality??''}'
              '${locationController.placemark.postalCode??''}'
              '${locationController.placemark.country??''}';
          print('address in my view is now '+_addressController.text);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Dimensions.height45*3 + Dimensions.height10,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: Dimensions.width10/2, right: Dimensions.width10/2, top: Dimensions.width10/2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                    border: Border.all(
                      width: 2,
                      color: AppColors.mainColor,
                    ),
                  ),
                  child: Stack(
                    children: [
                      GoogleMap(initialCameraPosition: CameraPosition(
                          target: _initialPosition,
                          zoom: 17,
                        ),
                        onTap: (latlan){
                          Get.toNamed(RouteHelper.getPickAddressPage(),
                            arguments: PickAddressMap(
                              fromSignup: false,
                              fromAddress: true,
                              googleMapController: locationController.mapController,
                            ),
                          );
                        },
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: false,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        onCameraIdle: (){
                          locationController.updatePosition(_cameraPosition, /*true*/ mapIsTapped);
                        },
                        onCameraMove: (position){ _cameraPosition=position; mapIsTapped = true;},
                        onMapCreated: (GoogleMapController controller){
                          locationController.setMapController(controller);
                         /* if(Get.find<LocationController>().addressList.isEmpty){

                          }*/
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height20,),
                SizedBox(
                  height: Dimensions.height45,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: locationController.addressTypeList.length,
                      itemBuilder: (context, index){
                        return InkWell(
                          onTap: (){
                            locationController.setAddressTypeIndex(index);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.width20,),
                            margin: EdgeInsets.only(left: Dimensions.width20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                              color: Theme.of(context).cardColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[200]!,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                ),
                              ]
                            ),
                            child: Icon(
                              index == 0 ? Icons.home_filled : index == 1 ? Icons.work : Icons.location_on,
                              color: locationController.addressTypeIndex == index ?
                              AppColors.mainColor : Theme.of(context).disabledColor,
                            ),
                          ),
                        );
                      },
                  ),
                ),
                SizedBox(height: Dimensions.height20),
                Padding(
                  padding:  EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Delivery address", color: Colors.black45
                    ,),
                ),
                SizedBox(height: Dimensions.height10),
                AppTextField(
                  textController: _addressController,
                  hintText: "Your address",
                  icon: Icons.location_city,
                ),
                SizedBox(height: Dimensions.height20),
                Padding(
                  padding:  EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Contact name", color: Colors.black45,),
                ),
                SizedBox(height: Dimensions.height10),
                AppTextField(
                  textController: _contactPersonName,
                  hintText: "Your name",
                  icon: Icons.person,
                ),
                SizedBox(height: Dimensions.height20),
                Padding(
                  padding:  EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Your number", color: Colors.black45,),
                ),
                SizedBox(height: Dimensions.height10),
                AppTextField(
                  textController: _contactPersonNumber,
                  hintText: "Your number",
                  icon: Icons.phone,
                ),
              ],
            ),
          );
        });
      }),
      bottomNavigationBar: GetBuilder<LocationController>(builder: (locationController){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      AddressModel _addressModel = AddressModel(
                        addressType: locationController.addressTypeList[locationController.addressTypeIndex],
                        contactPersonName: _contactPersonName.text,
                        contactPersonNumber: _contactPersonNumber.text,
                        address: _addressController.text,
                        latitude: locationController.position.latitude.toString(),
                        longitude: locationController.position.longitude.toString(),
                      );
                      locationController.addAddress(_addressModel).then((response){
                        if (response.isSuccess) {
                          Get.toNamed(RouteHelper.getInitial());
                          Get.snackbar('Address', 'Added Successfully');
                        }else{
                          Get.snackbar('Address', "Couldn't save address");
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.height20),
                      child: BigText(text: 'Save address', color: Colors.white,),
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

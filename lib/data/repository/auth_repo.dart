import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/models/sign_up_body_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  //registration
  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(AppConstants.REGISTRATION_URI, signUpBody.toJson());
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  //token
  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.TOKEN)??'None';
  }

  //login
  Future<Response> login(String phone, String password) async {
    return await apiClient.postData(AppConstants.LOGIN_URI, {'phone':phone, 'password':password});
  }


  Future<bool> saveUserToken(String token) async {
    apiClient.token =token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserNumberAndPassword(String number, String password)async {
    try{
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    }catch(e){
      throw e;
    }
  }

  bool clearSharedData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiClient.token='';
    apiClient.updateHeader('');
    return true;
  }

  Future<Response> updateToken() async{
    String? _deviceToken;
    if(GetPlatform.isIOS && !GetPlatform.isWeb){
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true, badge: true, sound: true,
        announcement: false, carPlay: false,
        criticalAlert: false, provisional: false,
      );
      if(settings.authorizationStatus == AuthorizationStatus.authorized){
        _deviceToken = await _saveDeviceToken();
        print('My token is 1'+_deviceToken!);
      }
    }else{
      _deviceToken = await _saveDeviceToken();
      print('My token is 2'+_deviceToken!);
    }
    if(!GetPlatform.isWeb){
      //
    }
    return await apiClient.postData(AppConstants.TOKEN_URI, {'_method': 'put', 'cm_firebase_token':_deviceToken});
  }

  Future<String?> _saveDeviceToken() async{
    String? _deviceToken = '@';
    if(GetPlatform.isWeb){
      try{
        FirebaseMessaging.instance.requestPermission();
        _deviceToken = await FirebaseMessaging.instance.getToken();

      }catch(e){
        print('could not get the token');
        print(e.toString());
      }
    }
    if(_deviceToken != null){
      print('----------Device Token---------'+_deviceToken);
    }
    return _deviceToken;
  }
}
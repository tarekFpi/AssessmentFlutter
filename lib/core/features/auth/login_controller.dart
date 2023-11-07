
import 'package:assessment/core/features/auth/login_screen.dart';
import 'package:assessment/core/features/auth/model/login_response.dart';
import 'package:assessment/core/features/nav/nav_screen.dart';
import 'package:assessment/core/features/network/dio_client.dart';
import 'package:assessment/core/features/utils/toast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class AuthController extends GetxController{

  final dioClient = DioClient.instance;

  final storage = GetStorage();

  Future login(phone, pin) async{

    EasyLoading.show(dismissOnTap: false, maskType: EasyLoadingMaskType.custom);

    try {

      final res = await dioClient.post("/api/ClientCabinetBasic/IsAccountCredentialsCorrect",data:{
        "login": phone,
        "password": pin
      });

      final loginResponse = LoginResponse.fromJson(res.data);

      if(loginResponse.result==true){

        final userToken = loginResponse.token.toString();

        saveToken(userToken,phone,pin);

        Toast.successToast("User logged in successfully");

        Get.off(NavScreen());

        EasyLoading.dismiss();

      }else {
        Toast.errorToast("${loginResponse.result}");
        EasyLoading.dismiss();
      }

    } catch(e) {
      Toast.errorToast("${e.toString()}");
      EasyLoading.dismiss();
    }
  }


  void saveToken(token,phone,pin){

    storage.write("user_token", token);
    storage.write("login",phone);
    storage.write("pin",pin);
  }

  void logout() async {
    try{

      EasyLoading.show(dismissOnTap: false, maskType: EasyLoadingMaskType.custom);

      Get.offAll(() =>  LoginScreen());

      storage.remove("user_token");

      Toast.successToast("LogOut Successfully",);
      EasyLoading.dismiss();

    }catch(e){
      EasyLoading.dismiss();
      Toast.errorToast(e.toString());
    }
  }


  bool isLoggedIn(){
    if(storage.read("user_token") != null) return true;
    return false;
  }

}
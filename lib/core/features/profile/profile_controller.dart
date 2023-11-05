import 'package:assessment/core/features/network/dio_client.dart';
import 'package:assessment/core/features/profile/model/profile_response.dart';
import 'package:assessment/core/features/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

 class ProfileController  extends GetxController  with StateMixin<ProfileResponse> {

  final dioClient = DioClient.instance;

  final profilelist = ProfileResponse().obs;

  final storage = GetStorage();

  RxInt GetLastFourNumbersPhone = 0.obs;


  Future<void> ShowProfile() async{

   try {

    change(null, status: RxStatus.loading());

    final response = await dioClient.post("/api/ClientCabinetBasic/GetAccountInformation",data: {
     "login": storage.read("login"),
     "token": storage.read("user_token")
    });


    var result = ProfileResponse.fromJson(response.data);
    profilelist(result);

    change(profilelist.value, status: RxStatus.success());

   } catch(e) {

    Toast.errorToast("${e.toString()}");

    debugPrint(e.toString());

    change(null, status: RxStatus.error(e.toString()));
   }
  }


  Future<void> getLastNumberShow() async{

   try {

  
    final response = await dioClient.post("/api/ClientCabinetBasic/GetLastFourNumbersPhone",data: {
     "login": storage.read("login"),
     "token": storage.read("user_token")
    });


      String number= response.toString();

     var splitted = number.split('********');

      print("splitted:${splitted[1]}");

      GetLastFourNumbersPhone.value = int.parse(splitted[1].toString());

   } catch(e) {

    Toast.errorToast("${e.toString()}");

    debugPrint(e.toString());
    
   }
  }


 }
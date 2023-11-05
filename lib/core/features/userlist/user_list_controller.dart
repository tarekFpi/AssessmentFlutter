
import 'package:assessment/core/features/network/dio_client.dart';
import 'package:assessment/core/features/userlist/model/user_response.dart';
import 'package:assessment/core/features/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class UserlistController extends GetxController with StateMixin<List<UserResponse>> {

  final dioClient = DioClient.instance;

  final userlist = <UserResponse>[].obs;

  final storage = GetStorage();

  @override
  void onInit() {

    userListReport();
  }

  Future<void> userListReport() async{

    try {

      change(null, status: RxStatus.loading());


      final user_response = await dioClient.post("/api/ClientCabinetBasic/GetOpenTrades",data: {
        "login": storage.read("login"),
        "token": storage.read("user_token")
      });


      user_response.data.forEach((element) {
        var list = UserResponse.fromJson(element);
        userlist.add(list);
      });

        if(userlist.isEmpty){

          change(null, status: RxStatus.empty());

        }

        change(userlist, status: RxStatus.success());

    } catch(e) {

      Toast.errorToast("${e.toString()}");

      debugPrint(e.toString());

      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void filterUserList(String? query) {

    if (query == null || query.isEmpty) {

      change(userlist.value, status: RxStatus.success());

    }else{

      try {

        final list = userlist.value
            .where((element) =>
            element.openTime!
                .toLowerCase()
                .contains(query!.toLowerCase().trim()))
            .toList();

        if (list.isEmpty) {
          change([], status: RxStatus.empty());
        } else {
          change(list, status: RxStatus.success());
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
}

}

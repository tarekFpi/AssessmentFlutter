import 'dart:convert';

import 'package:assessment/core/features/network/dio_client.dart';
import 'package:assessment/core/features/task/model/task_response.dart';
import 'package:assessment/core/features/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class TasklistController extends GetxController with StateMixin<List<TaskResponse>> {

  final dioClient = DioClient.instance;

  final tasklist = <TaskResponse>[].obs;

  @override
  void onInit() {

    TaskReport();
  }

  Future<void> TaskReport() async{

    try {

      change(null, status: RxStatus.loading());

      final task_response = await dioClient.get("api/characters");


      task_response.forEach((element) {
        var list = TaskResponse.fromJson(element);
        tasklist.add(list);
      });

        if(tasklist.isEmpty){

          change(null, status: RxStatus.empty());

        }

        change(tasklist, status: RxStatus.success());

    } catch(e) {

      Toast.errorToast("${e.toString()}");

      debugPrint(e.toString());

      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void filterTask(String? query) {

    if (query == null || query.isEmpty) {

      change(tasklist.value, status: RxStatus.success());

    }else{

      try {

        final list = tasklist.value
                 .where((element) =>
                  element.name!
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

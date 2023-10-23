import 'package:assessment/core/features/task/model/task_response.dart';
import 'package:assessment/core/features/task/task_details_screen.dart';
import 'package:assessment/core/features/task/task_list_controller.dart';
import 'package:assessment/core/features/theme/color_scheme.dart';
import 'package:assessment/core/features/utils/hexcolor.dart';
import 'package:assessment/core/features/video_mp4/video_screen.dart';
import 'package:assessment/core/features/widgets/custom_error_widget.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {

  final taskListController = Get.put(TasklistController());

  final queryEditingController = TextEditingController();

  String query = "";

  void goToDetails(TaskResponse taskResponse){

    FocusScope.of(context).unfocus();

    Get.to(() => TaskDetailsScreen(
      tasklist: taskResponse,
    ));

  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(child: Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){

        Get.to(() => VideoDownloadScreen());
      },child: Icon(Icons.download,color: Colors.white,),backgroundColor: Colors.green,),

      backgroundColor:colorScheme.surfaceVariant,
      appBar: AppBar(
        backgroundColor:colorScheme.surface,
        elevation: 2,
        title: Text("Task List",style: textTheme.bodySmall?.copyWith(
            color: lightColorScheme.onTertiaryContainer, fontSize: 18,fontWeight: FontWeight.w500),),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [

            Card(
              child: TextFormField(
                controller: queryEditingController,
                decoration: InputDecoration(
                  fillColor: Colors.white38,
                  filled: true,
                  contentPadding: EdgeInsets.all(16),
                  hintText: "Search...For..Name",
                  prefixIcon: Icon(
                    Icons.search,
                    color: HexColor('#855EA9'),
                  ),

                    hintStyle: textTheme.bodyMedium
                        ?.copyWith(color: HexColor("#BCC2EB")),
                    suffixIcon: query.isBlank == true || query.isEmpty
                        ? Icon(
                      FluentIcons.search_24_regular,
                      color: HexColor("#BCC2EB"),
                    )
                        : IconButton(
                        icon: Icon(Icons.close, color: HexColor("#BCC2EB")),
                        onPressed: () {
                          //clear query
                          setState(() {
                            query = "";
                          });
                          queryEditingController.clear();
                          FocusScope.of(context).unfocus();
                          taskListController.filterTask(null);
                        })

                ),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                  taskListController.filterTask(value);
                },
              ),
            ),

            Expanded(
              child: taskListController.obx((state) =>
                  RefreshIndicator(child: ListView.builder(
                      itemCount: state!.length,
                      itemBuilder: (BuildContext context,index){

                        final item = state[index];

                        return InkWell(
                          splashColor: Colors.transparent,
                          onTap: (){
                            goToDetails(item);
                          },
                          child: Card(
                            color:  HexColor("#FAFDFC"),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [

                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Text(
                                          "Name : ${item.name}",
                                          style: textTheme.bodySmall?.copyWith(
                                              color: lightColorScheme.onTertiaryContainer,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),

                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "Species :${item.species}",
                                          style: textTheme.bodySmall?.copyWith(
                                              color: lightColorScheme.onTertiaryContainer,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),

                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "Gender :${item.gender}",
                                            style: textTheme.bodySmall?.copyWith(
                                                color: lightColorScheme.primary,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),

                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "House :${item.house}",
                                          style: textTheme.bodySmall?.copyWith(
                                              color: lightColorScheme.error,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }), onRefresh: taskListController.TaskReport),onError: (msg) {
                     return CustomErrorWidget(
                    icon: Icon(
                      msg == "No Internet." ? FluentIcons.wifi_off_24_regular : FluentIcons.error_circle_24_filled,
                      color: Colors.red,
                      size: 40,
                    ),
                    btnLevel: "Retry",
                    message: msg.toString(),
                    onClick: () {
                      taskListController.TaskReport();
                    });
              }),
            ),
          ],
        ),
      ),
    ));
  }
}

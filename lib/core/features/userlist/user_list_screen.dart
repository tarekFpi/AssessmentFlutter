
import 'package:assessment/core/features/theme/color_scheme.dart';
import 'package:assessment/core/features/userlist/user_list_controller.dart';
import 'package:assessment/core/features/utils/hexcolor.dart';
import 'package:assessment/core/features/widgets/custom_error_widget.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {

  final userListController = Get.put(UserlistController());

  final queryEditingController = TextEditingController();

  String query = "";


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(child: Scaffold(

      backgroundColor:colorScheme.surfaceVariant,
      appBar: AppBar(
        backgroundColor:colorScheme.surface,
        elevation: 2,
        title: Text("User List",style: textTheme.bodySmall?.copyWith(
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
                  hintText: "Search...For..Date",
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
                          userListController.filterUserList(null);
                        })

                ),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                  userListController.filterUserList(value);
                },
              ),
            ),

            Expanded(
              child: userListController.obx((state) =>
                  RefreshIndicator(child: ListView.builder(
                      itemCount: state!.length,
                      itemBuilder: (BuildContext context,index){

                        final item = state[index];

                        return InkWell(
                          splashColor: Colors.transparent,
                          onTap: (){

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
                                          "CurrentPrice : ${item.currentPrice}",
                                          style: textTheme.bodySmall?.copyWith(
                                              color: lightColorScheme.onTertiaryContainer,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),

                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "Digits :${item.digits}",
                                          style: textTheme.bodySmall?.copyWith(
                                              color: lightColorScheme.onTertiaryContainer,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),

                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "Login :${item.login}",
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
                                          "OpenTime :${item.openTime}",
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
                      }), onRefresh: userListController.userListReport),onError: (msg) {
                     return CustomErrorWidget(
                    icon: Icon(
                      msg == "No Internet." ? FluentIcons.wifi_off_24_regular : FluentIcons.error_circle_24_filled,
                      color: Colors.red,
                      size: 40,
                    ),
                    btnLevel: "Retry",
                    message: msg.toString(),
                    onClick: () {
                      userListController.userListReport();
                    });
              }),
            ),
          ],
        ),
      ),
    ));
  }
}

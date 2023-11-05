 import 'package:assessment/core/features/auth/login_controller.dart';
import 'package:assessment/core/features/profile/profile_controller.dart';
import 'package:assessment/core/features/utils/hexcolor.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  AuthController authController = Get.put(AuthController());

  var profileController = Get.put(ProfileController());

  final storage = GetStorage();

  @override
  void initState() {

   profileController.ShowProfile();

   profileController.getLastNumberShow();

    super.initState();
  }

  void logoutDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm logout"),
        content: Text("Do you want to log out??"),
        actions: <Widget>[
          TextButton(
            child: Text('No'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            onPressed: (){
              Navigator.of(context).pop();

              setState(() {
                authController.logout();
              });
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(child: Scaffold(
      backgroundColor:colorScheme.surfaceVariant,
      appBar: AppBar(
        backgroundColor:colorScheme.surface,
        elevation: 2,
        centerTitle: true,
        title: Text(
          "User Profile",
          style: textTheme.titleMedium?.copyWith(
              color: HexColor('#855EA9'),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),

      body:Container(
        margin: EdgeInsets.only(left: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(
              height: 12,
            ),

            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('assets/images/user_image.png'),
              backgroundColor: Colors.transparent,
            ),

            SizedBox(
              height: 8,
            ),


             profileController.obx((state) {

               return Card(
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(16),
                 ),
                 elevation: 0.3,
                 color: HexColor('#FCFDFF'),
                 child: InkWell(
                   focusColor: Colors.white,
                   borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Text("Address:${state!.address}",
                              style: textTheme.headlineLarge?.copyWith(
                                color: HexColor('#5C5D72'),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )),

                          Divider(
                            height: 12,
                            color: Colors.black54,
                          ),

                          Text("Name:${state!.name}",
                              style: textTheme.headlineLarge?.copyWith(
                                color: HexColor('#5C5D72'),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )),

                          Divider(
                            height: 12,
                            color: Colors.black54,
                          ),

                          Text("Country:${state!.country}",
                              style: textTheme.headlineLarge?.copyWith(
                                color: HexColor('#5C5D72'),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )),
                          
                        ],
                      ),
                    ),
                 ),
               ) ;
             }),

              SizedBox(
                height: 16,
              ),
            Obx(() => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0.3,
                color: HexColor('#FCFDFF'),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("GetLastFourNumbersPhone:${profileController.GetLastFourNumbersPhone}",
                    style: textTheme.headlineLarge?.copyWith(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            )),

            SizedBox(
              height: 16,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0.3,
              color: HexColor('#FCFDFF'),
              child: InkWell(
                focusColor: Colors.white,
                borderRadius: BorderRadius.circular(16),
                onTap: (){
                  logoutDialog();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Row(
                        children: [
                          CircleAvatar(
                              backgroundColor:  HexColor('#FFEDED'),
                              radius: 16,
                              child:  Icon(Icons.logout,size: 16,)
                          ),

                          SizedBox(
                            width: 16,
                          ),
                          Text("logout",
                              style: textTheme.headlineLarge?.copyWith(
                                color: HexColor('#FF6464'),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),


                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

import 'dart:async';

import 'package:aikmccbangalore/Provider/UserProvider.dart';
import 'package:aikmccbangalore/Screens/User/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unique_identifier/unique_identifier.dart';

import '../Constant/images.dart';
import '../Constant/my_functions.dart';
import '../Provider/LoginProvider.dart';
import '../Provider/mainprovider.dart';
import 'admin/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences prefs;
  String? packageName;

  Future<void> localDB() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {

    localDB();
    // getPackageName();
    super.initState();
    LoginProvider loginProvider =
    Provider.of<LoginProvider>(context, listen: false);
    MainProvider mainProvider =
    Provider.of<MainProvider>(context, listen: false);
    UserProvider userProvider =
    Provider.of<UserProvider>(context, listen: false);
    mainProvider.lockApp();
    mainProvider.  carouselImages();
    // userProvider.fetchPanjayath();
    Timer(const Duration(seconds: 3), () async {

      try {
        userProvider.strDeviceID = await UniqueIdentifier.serial;
      } on PlatformException {
        userProvider.strDeviceID = 'Failed to get Unique Identifier';
      }
     // await  mainProvider.carouselImages();

      // userProvider  . fetchWard();
      // userProvider .fetchAllWards();
      // if(packageName=="com.spine.aikmccbangaloreAdmin"){
        var user = prefs.getString("appwrite_token");
        if (user == null) {
          // String? strDeviceID = "";
          // try {
          //   strDeviceID = await UniqueIdentifier.serial;
          // } on PlatformException {
          //   strDeviceID = 'Failed to get Unique Identifier';
          // }
          userProvider.  fetchMyRegistrations(userProvider.strDeviceID!);
          callNextReplacement(const HomeScreen(), context);
        } else {
          loginProvider.userAuthorized("LOGIN",prefs.getString("phone_number").toString(),user, context,);
        }
      // }else{
      // }






    });
  }
  @override
  Widget build(BuildContext context) {
    var width =MediaQuery.of(context).size.width;
    var height =MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(splashBackground),fit: BoxFit.fill)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 50),
            Image.asset(sarLogo,scale: 3),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Image.asset(nueroSpineLogo,scale: 4),
            )
          ],
        ),
      ),
    );
  }
  Future<void> getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(()
    {
      packageName = packageInfo.packageName;
    }
    );

  }
}

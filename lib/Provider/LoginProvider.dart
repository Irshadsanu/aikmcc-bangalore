import 'package:aikmccbangalore/Constant/my_colors.dart';
import 'package:aikmccbangalore/Constant/my_functions.dart';
import 'package:aikmccbangalore/Provider/UserProvider.dart';
import 'package:aikmccbangalore/Screens/User/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/User/registration_screen.dart';
import '../Screens/admin/AdminHomeScreen.dart';
import '../Screens/admin/LoginScreen.dart';
import 'mainprovider.dart';

class LoginProvider extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  String loginUserArea='';
  String loginUserAreaDistrict='';
  Future<void> userAuthorized(String from ,String? phoneNumber,var token, BuildContext context) async {

    MainProvider mainProvider =
    Provider.of<MainProvider>(context, listen: false);

    String loginUserid='';
    String loginUserName='';
    String loginUserType='';
    String loginUserPhone='';


    try {

      var phone = phoneNumber!.substring(3,13);
      print(phone+"sdfsdfs");

      db.collection("USERS")
          .where("PHONE",isEqualTo:phone )
          .get().then((value)async {
        if(value.docs.isNotEmpty){
          print("data exist");
          Map<dynamic,dynamic> map = value.docs.first.data();
          loginUserType=map["TYPE"]??"";
          loginUserid=value.docs.first.id;
          loginUserName = map["NAME"];
          loginUserPhone = map["PHONE"];
          if(map["AREA"]!=null) {
            loginUserArea = map["AREA"];
            loginUserAreaDistrict = map["AREA_DISTRICT"];
            print(loginUserArea+loginUserAreaDistrict);
            print("xxtfyghijklh");
            notifyListeners();
          }
         if(loginUserType=="ADMIN"){
           mainProvider.getPendingRegistration(true);
           mainProvider.getApprovedRegistration(true);
           mainProvider.getRejectedRegistration(true);
           mainProvider.fetchTotal();
           mainProvider.fetchCoordinators();
           callNextReplacement(AdminHomeScreen(uid: loginUserid,type: loginUserType,name: loginUserName,phone: loginUserPhone, coArea: loginUserArea, coAreaDistrit: loginUserAreaDistrict,), context);
         }else{
           mainProvider.fetchCoordinatorsFilter(map["AREA"].toString(),map["ID"]);
           mainProvider.getCoordinatorPendingRegistration(map["AREA"].toString(),true);
           mainProvider.getCoordinatorApprovedRegistration(map["AREA"].toString(),true);
           mainProvider.getCoordinatorRejectedRegistration(map["AREA"].toString(),true);
           callNextReplacement(AdminHomeScreen(uid: loginUserid,type: loginUserType,name: loginUserName,phone: loginUserPhone, coArea: loginUserArea,coAreaDistrit: loginUserAreaDistrict), context);

         }

          if(from=="LOGIN"){
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('appwrite_token', token);
            prefs.setString('phone_number', phoneNumber);
          }


        }
        else {
          callNextReplacement( LoginScreen(), context);
        }
      });


    } catch (e) {
      const snackBar = SnackBar(
        content: Text('Sorry , Some Error Occurred'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    notifyListeners();
  }


  logOutAlert(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    AlertDialog alert =AlertDialog(
      backgroundColor: Colors.white,
      scrollable: true,
      title: const Text(
        "Do you want to Logout",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      content: Consumer<MainProvider>(
          builder: (context,value,child) {
            return
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 35,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: maincolor),
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: TextButton(
                            child: Text('No', style: TextStyle(color: Colors.black)),
                            onPressed: () {
                              finish(context);
                            }),
                      ),
                      Container(
                        height: 35,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: maincolor),
                          color: maincolor,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: TextButton(
                            child: Text(
                              'Yes',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.clear();
                              UserProvider userProvider =
                              Provider.of<UserProvider>(context, listen: false);
                              userProvider.  fetchMyRegistrations(userProvider.strDeviceID!);

                              callNextReplacement(const HomeScreen(), context);
                              // finish(context);
                            }),
                      ),
                    ],
                  ),
                ],
              );
          }
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }








}
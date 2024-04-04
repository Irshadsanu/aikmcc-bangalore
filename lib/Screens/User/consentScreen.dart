import 'package:aikmccbangalore/Screens/User/HomeScreen.dart';
import 'package:aikmccbangalore/Screens/User/loding_Screnn.dart';
import 'package:aikmccbangalore/Screens/admin/AdminHomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constant/my_colors.dart';
import '../../Constant/my_functions.dart';
import '../../Provider/LoginProvider.dart';
import '../../Provider/UserProvider.dart';

class ConsentScreen extends StatelessWidget {
  const ConsentScreen(
      {super.key,
      required this.uid,
      required this.type,
      required this.name,
      required this.phone,
        required this.date,
        required this.docId,
        required this.coArea,
        required this.coAreaDistrict,
      });

  final String uid;
  final String type;
  final String name;
  final String phone;
  final DateTime date;
  final String docId;
  final String coArea;
  final String coAreaDistrict;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/consentBg.png"))),
          child: SingleChildScrollView(
            child: SizedBox(
              width: width,
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/result 1.png",
                    scale: 4,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  SizedBox(
                    width: width / 1.235849056603774,
                    child: const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'I AGREE!\n',
                            style: TextStyle(
                              color: Color(0xFF1F6D8B),
                              fontSize: 22,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text:
                                'I wholeheartedly embrace the opportunity to collaborate within the guidelines set forth by AIKMCC, a respected organization affiliated with the Indian Union Muslim League. I am committed to working within its established framework.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                  SizedBox(
                    width: width / 1.228125,
                    child: const Text(
                      'ഇന്ത്യൻ യൂനിയൻ മുസ്ലിം ലീഗിന്റെ അംഗീകൃത പോഷക സംഘടനയായ AIKMCC യുടെ നിയമ നിർദേശങ്ങൾക്ക് വിധേയമായി പ്രവർത്തിക്കാൻ ഞാൻ സന്നദ്ധനാണ്.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              agreeAlert(context, "cancel");
            },
            child: Container(
              width: width / 3,
              height: 50,
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(76),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 4,
                    offset: Offset(0, 3),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: const Text(
                'Cancel',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF113D4E),
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              agreeAlert(context, "proceed");
            },
            child: Container(
              width: width / 3,
              height: 50,
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(-1.00, -0.02),
                  end: Alignment(1, 0.02),
                  colors: [Color(0xFF1F6D8B), Color(0xFF0F3848)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(76),
                ),
              ),
              child: const Text(
                'Agree',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFF7F7F7),
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  agreeAlert(BuildContext context, String from) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      scrollable: true,
      title: Text(
        "Are you sure to $from",
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      content: Consumer<UserProvider>(builder: (context, value, child) {
        return Column(
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
                      child: const Text('No',
                          style: TextStyle(color: Colors.black)),
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
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        LoginProvider loginProvider =
                        Provider.of<LoginProvider>(context, listen: false);
                        if (from == "proceed") {

                          // callNextReplacement(LoadingScreen(uid: uid, type: type, name: name, phone: phone, loginUserArea: coArea, docId: docId, dateTime: date), context);
                          await value.addRegisterCt(context, docId, uid,type, name,phone,coArea, date,coAreaDistrict);


                        } else {
                          if(type==""){

                          callNextReplacement(const HomeScreen(), context);}
                          else{

                            callNextReplacement(AdminHomeScreen(uid: uid, type: type, name: name, phone: phone, coArea: loginProvider.loginUserArea, coAreaDistrit: loginProvider.loginUserAreaDistrict,), context);
                          }

                        }
                      }),
                ),
              ],
            ),
          ],
        );
      }),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

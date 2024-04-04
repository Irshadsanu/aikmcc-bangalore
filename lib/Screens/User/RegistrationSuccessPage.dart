import 'package:aikmccbangalore/Constant/my_functions.dart';
import 'package:aikmccbangalore/Provider/LoginProvider.dart';
import 'package:aikmccbangalore/Screens/admin/AdminHomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import '../../Constant/images.dart';
import '../../Constant/my_colors.dart';
import '../../Constant/widgets.dart';
import '../../Provider/UserProvider.dart';
import 'HomeScreen.dart';

class RegistrationSuccessPage extends StatelessWidget {
  const RegistrationSuccessPage({super.key,  required this.uid, required this.type,
    required this.name, required this.phone,required this.userName, required this.userPhone, required this.image, required this.area, required this.areaDistrict});
  final String uid;
  final String type;
  final String name;
  final String userName;
  final String userPhone;
  final String phone;
  final String image;
  final String area;
  final String areaDistrict;

  @override
  Widget build(BuildContext context) {
    print("name   : $name");
    print("phone   : $phone");
    ScreenshotController screenshotController = ScreenshotController();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: false,
      child: Scaffold(

        body: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                scrolledUnderElevation: 0,
                elevation: 0,
                centerTitle: true,
                automaticallyImplyLeading: false,
                title: const GradientText(
                          'Successfully Registered',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold),
                          gradient: LinearGradient(colors: [
                            Color(0xff067B35),
                            Color(0xff00C14D),
                          ]),
                        ),
          
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Screenshot(
                    controller: screenshotController,
                    child: Container(
                      height:470,
                      width: width,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(IdCard),fit: BoxFit.fill),
                          color: Colors.white
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 245,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                margin:  EdgeInsets.only(left: width*0.13),
                                width: width*0.315,
                                height: 175,
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(20),
                                    border: Border.all(width: 3,color: Colors.white)
                                ),
                                child: ClipRRect(
                                  // borderRadius: BorderRadius.circular(15),
                                    child: image!=""?
                                    Image.network(image,fit: BoxFit.cover)
                                        :Image.asset("assets/images/appBarBG.png",fit: BoxFit.cover)
                                ),
                              ),
                              SizedBox(width: width*0.035,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width*0.32,
                                    child: Text(userName,style: const TextStyle(color: maincolor,
                                        fontWeight: FontWeight.bold,fontSize: 8,fontFamily: "Poppins"),
                                      maxLines: 1,overflow: TextOverflow.clip,),
                                  ),
                                  Text(userPhone,style: const TextStyle(color: Colors.grey,
                                      fontWeight: FontWeight.bold,fontSize: 8,fontFamily: "Poppins"),),
                                ],
                              ),
                            ],
                          ),
          
          
          
          
          
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Consumer<UserProvider>(
                  builder: (context,user,child) {
                    return InkWell(
                      onTap: () {
                        user.shareIDCard(screenshotController);
                      },
                      child: Container(
                        width: width / 1.1,
                        height: 50,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment(-1.00, -0.02),
                            end: Alignment(1, 0.02),
                            colors: [Color(0xFF0F3848), Color(0xFF1F6D8B)],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(76),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.share,color: Colors.white,size: 18),
                            SizedBox(width: 15,),
                            Text(
                              "Share",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFF7F7F7),
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              ),
              const SizedBox(height: 15,),
              Consumer<UserProvider>(
                  builder: (context,user,child) {
                    return InkWell(
                      onTap: () {
                        if(type==""){
                          callNextRemoveUntil(const HomeScreen(), context);
                        }
                        else{
                          LoginProvider loginProvider =
                          Provider.of<LoginProvider>(context, listen: false);
                          callNextRemoveUntil( AdminHomeScreen(uid: uid, type: type, name: name, phone: phone, coArea: area, coAreaDistrit: areaDistrict,), context);
                        }
                      },
                      child: Container(

                        width: width / 1.1,
                        height: 50,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment(-1.00, -0.02),
                            end: Alignment(1, 0.02),
                            colors: [Color(0xFF0F3848), Color(0xFF1F6D8B)],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(76),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Back to Home",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFF7F7F7),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Image.asset(paymentSuccessIcon, scale: 3),
        //       const SizedBox(
        //         height: 5,
        //       ),
        //       const GradientText(
        //         'Successfully Registered',
        //         style: TextStyle(
        //             fontSize: 15,
        //             fontFamily: "Poppins",
        //             fontWeight: FontWeight.bold),
        //         gradient: LinearGradient(colors: [
        //           Color(0xff067B35),
        //           Color(0xff00C14D),
        //         ]),
        //       ),
        //       const SizedBox(
        //         height: 20,
        //       ),
        //       type==""
        //           ? const Text(
        //         "Thank you for completing AIKMCC Membership Registration!"
        //         "Your application is now pending for approval.Your ID card will"
        //         " be delivered to your provided address by area coordinator once the application is approved.",
        //         textAlign: TextAlign.center,
        //         style: TextStyle(fontFamily: "Poppins", color: Colors.black54),
        //       )
        //           : const Text(
        //         "Thank you for completing AIKMCC Membership Registration!"
        //             ,
        //         textAlign: TextAlign.center,
        //         style: TextStyle(fontFamily: "Poppins", color: Colors.black54),
        //       ),
        //       const SizedBox(
        //         height: 10,
        //       ),
        //       const Text(
        //         "Thank you for your patience!",
        //         style: TextStyle(
        //             fontFamily: "Poppins",
        //             color: Colors.black,
        //             fontWeight: FontWeight.bold),
        //       )
        //     ],
        //   ),
        // ),




        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: CustomFlotingButton(
        //   text: "Back to Home",
        //   width: width,
        //   onTap: () {
        //     if(type==""){
        //     callNextReplacement(const HomeScreen(), context);
        //     }
        //     else{
        //       callNextReplacement( AdminHomeScreen(uid: uid, type: type, name: name, phone: phone), context);
        //     }
        //   },
        // ),
      ),
    );
  }
}

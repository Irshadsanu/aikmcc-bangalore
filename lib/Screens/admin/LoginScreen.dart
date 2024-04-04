import 'package:aikmccbangalore/Constant/images.dart';
import 'package:appwrite/appwrite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../Constant/my_colors.dart';
import '../../Constant/widgets.dart';
import '../../Provider/LoginProvider.dart';
import '../User/registration_screen.dart';

enum MobileVarificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE
}


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVarificationState currentSate = MobileVarificationState.SHOW_MOBILE_FORM_STATE;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FocusNode _pinPutFocusNode = FocusNode();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  Client client = Client();
  String VerificationId ="";
  late var tocken;
  bool showLoading = false;
  bool showTick = false;
  LoginProvider loginProvider = LoginProvider();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    client
        .setEndpoint('https://cloud.appwrite.io/v1') // Your Appwrite Endpoint
        .setProject('6594e9a1c47214ec36fc') // Your project ID
        .setSelfSigned() ;


    fixedOtpChecking();

  }

  List<String> fixedOtpList = [];

  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
  void fixedOtpChecking(){
    fixedOtpList.clear();

    setState(() {


    mRoot.child("FIXED_OTP").onValue.listen((databaseEvent) {
      if(databaseEvent.snapshot.exists){
        print("object");
        fixedOtpList.clear();
        Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;

          map.forEach((key, value) {
            print("va${value}df${key}");
            fixedOtpList.add(key.toString());
          });

        print(fixedOtpList.toString()+"ef");
        print(fixedOtpList.contains("9048001001"));
      }
    });
    });

    
  }

  void checkValueForKey(String targetKey,String pin) {

    setState(() {
      mRoot.child("FIXED_OTP").onValue.listen((databaseEvent) {
        if (databaseEvent.snapshot.exists) {
          Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;

          map.forEach((key, value) {
            String keyControllerValue = key.toString();
            String valueControllerValue = value.toString();

            if (keyControllerValue == targetKey) {
              // The targetKey exists in the database
              // Do something with the corresponding value
              print("Value for key $targetKey is $valueControllerValue");

              if(valueControllerValue==pin){
                loginProvider.userAuthorized("LOGIN","+91${phoneController.text}", "tocken",context);
              }

            }
          });
        }
      });
    });
  }


  Future<void> otpsend() async {
    setState(() {
      showLoading = true;
    });
    if (showTick) {
      db
          .collection("USERS")
          .where("PHONE", isEqualTo: phoneController.text)
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {


          // otpsend();
          final account = Account(client);
          try {
            final sessionToken = await account.createPhoneSession(
                userId: ID.unique(),
                phone: '+91${phoneController.text}');

            VerificationId = sessionToken.userId;
            tocken = sessionToken.$id;

            setState(() {
              showLoading = false;
              currentSate =
                  MobileVarificationState.SHOW_OTP_FORM_STATE;


              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(
                content: Text("OTP sent to phone successfully"),
                duration: Duration(milliseconds: 3000),
              ));
            });

            // ScaffoldMessenger.of(context)
            //     .showSnackBar(const SnackBar(
            //   content: Text("Verification Completed"),
            //   duration: Duration(milliseconds: 3000),
            // ));





          } catch (e) {
            if (e is AppwriteException) {
              setState(() {
                showLoading = false;
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar( SnackBar(
                content: Text("Sorry, Verification Failed"),
                duration: Duration(milliseconds: 3000),
              ));
            } else {
              setState(() {
                showLoading = false;
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(
                content: Text("Sorry, Verification Failed"),
                duration: Duration(milliseconds: 3000),
              ));
              // Handle other types of exceptions or errors
              print('An unexpected error occurred: $e');
            }
          }
        }
        else {
          setState(() {
            showLoading = false;
          });
          const snackBar = SnackBar(
            content: Text('No Access'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

        }
      });
    }


  }

  Future<void> verify() async {
    setState(() {
      showLoading = true;
    });
    final account = Account(client);
    try {

      final session = await account.updatePhoneSession(
          userId: VerificationId, secret: otpController.text);




      try {

        print("object ddddddd");

        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // final loginUser = prefs.getString('appwrite_token');
        // final phonenum = prefs.getString('phone_number');


        print("sfsfsfsfsfsf");
        LoginProvider loginProvider = LoginProvider();
        // var phone = phonenum!.substring(3, 13);
        var phone = phoneController.text.trim();
        db
            .collection("USERS")
            .where("PHONE", isEqualTo: phone)
            .get()
            .then((value) {
          if (value.docs.isNotEmpty) {
            loginProvider.userAuthorized("LOGIN","+91$phone", tocken,context);
          } else {
            // setState(() {
            //   currentSate = MobileVarificationState.SHOW_MOBILE_FORM_VERIFIED;
            // });
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Login Success"),
          duration: Duration(milliseconds: 3000),
        ));

        setState(() {
          showLoading = false;
        });

        if (kDebugMode) {
          print("Login Success");
        }

      } catch (e) {
        const snackBar = SnackBar(
          content: Text('Otp failed'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text("login successfully"),
      //     backgroundColor: Colors.purple,
      //   ),
      // );
      // Process the successful response if needed
    } catch (e) {
      if (e is AppwriteException) {
        // Handle AppwriteException
        final errorMessage = e.message ?? 'An error occurred.';

        // Display the error message using a Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.purple,
          ),
        );
      } else {
        // Handle other types of exceptions or errors
        print('An unexpected error occurred: $e');
      }
    }

    // print(session.userId.toString()+"dsc");

    // print(session.providerAccessToken+"789456");
  }

  Widget getMobileFormWidget(context) {
    var width =MediaQuery.of(context).size.width;
    var height =MediaQuery.of(context).size.height;
    return Column(
      children: [
        const Align(
            alignment: Alignment.topLeft,
            child: Text("OTP Verification!",style: TextStyle(color: maincolor,fontWeight: FontWeight.bold),)),
        const SizedBox(height: 20,),
        Container(
          width:width ,
          height: 50,
          decoration: BoxDecoration(color: lategrey,borderRadius: BorderRadius.circular(50)),
          child: TextFormField(
            controller: phoneController,
            onChanged: (value) {


              setState(() {
                if (value.length == 10) {
                  showTick = true;
                  SystemChannels.textInput
                      .invokeMethod('TextInput.hide');
                } else {
                  showTick = false;
                }
              });
            },
            style:  const TextStyle(color: Colors.black, fontSize: 17,fontWeight: FontWeight.w700,fontFamily: "Poppins"),
            autofocus: false,
            keyboardType: TextInputType.number,
            // textAlign: TextAlign.center,
            inputFormatters: [LengthLimitingTextInputFormatter(10)],
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                fillColor: lategrey,
                filled: true,
                // counterStyle: const TextStyle(color: Colors.grey),
                hintStyle:  const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                hintText: 'Mobile Number',
                focusedBorder:border,
                enabledBorder: border,
                errorBorder: border,
                border:border,
            ),

          ),

        ),
        const SizedBox(height: 15),
        InkWell(
          onTap: () {
            setState(() {

              if(showTick){
              if(fixedOtpList.contains(phoneController.text.toString())){
                setState(() {
                  currentSate = MobileVarificationState
                      .SHOW_OTP_FORM_STATE;
                });

              }else{
                otpsend();
              }

              // currentSate = MobileVarificationState
              //     .SHOW_OTP_FORM_STATE;
            }else{
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("invalid Mobile Number",style: TextStyle(color: Colors.white)),
                  duration: Duration(milliseconds: 3000),
                ));
              }
            });

          },
          child: Container(
            width:width ,
            height: 50,
            decoration: BoxDecoration(color: maincolor,borderRadius: BorderRadius.circular(50)),
            child: Center(child:showLoading?waitingIndicator:const Text("Send OTP",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold))),
          ),
        ),
      ],
    );
  }


  Widget getOtpFormWidget(context){

    var width =MediaQuery.of(context).size.width;
    var height =MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: [
          const Align(
              alignment: Alignment.topLeft,
              child: Text("Login!",style: TextStyle(color: maincolor,fontWeight: FontWeight.bold),)),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: PinFieldAutoFill(
              codeLength: 6,
              focusNode: _pinPutFocusNode,
              keyboardType: TextInputType.number,
              autoFocus: true,
              controller: otpController,
              currentCode: "",
              decoration: UnderlineDecoration(

                textStyle:  TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 18,fontWeight: FontWeight.w700),
                colorBuilder: const FixedColorBuilder(lategrey),
              ),
              onCodeChanged: (pin) {
                if (pin!.length == 6) {
                  if(fixedOtpList.contains(phoneController.text)){
                    checkValueForKey(phoneController.text.toString(),otpController.text.toString());
                  }else{

                    verify();
                  }
                }
              },
            ),
          ),
          const SizedBox(height: 15,),
          InkWell(
            onTap: () {

              setState(() {
                if(fixedOtpList.contains(phoneController.text)){
                  checkValueForKey(phoneController.text.toString(),otpController.text.toString());
                }else{
                  verify();
                }

                // currentSate = MobileVarificationState
                //     .SHOW_MOBILE_FORM_STATE;
              });

            },
            child: Container(
              width:width ,
              height: 50,
              decoration: BoxDecoration(color: maincolor,borderRadius: BorderRadius.circular(50)),
              child:  Center(child:showLoading?waitingIndicator :const Text("Verify",
                  style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold))),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width =MediaQuery.of(context).size.width;
    var height =MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Spacer(),
              Image.asset(sarLogoDark,scale: 2.9,),
               // SizedBox(height: height*0.12,),
              const Spacer(),

              Image.asset(AIKMCCLOGO,scale: 3.8,),
              // SizedBox(height: height*0.12,),
              // getMobileFormWidget(context)
              // getOtpFormWidget(context)
              const Spacer(),
              currentSate == MobileVarificationState.SHOW_MOBILE_FORM_STATE
                  ? getMobileFormWidget(context)
                  : getOtpFormWidget(context),
              const SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}

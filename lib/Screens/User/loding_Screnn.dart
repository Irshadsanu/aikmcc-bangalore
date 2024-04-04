import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/UserProvider.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen(
      {super.key,
      required this.uid,
      required this.type,
      required this.name,
      required this.phone,
      required this.loginUserArea,
      required this.docId,
      required this.dateTime});

  final String uid;
  final String type;
  final String name;
  final String phone;
  final String loginUserArea;
  final String docId;
  final DateTime dateTime;

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    // hai();
  }

  // Future<void> hai() async {
  //   UserProvider userProvider =
  //       Provider.of<UserProvider>(context, listen: false);
  //   await userProvider.addRegisterCt(
  //       context,
  //       widget.docId,
  //       widget.uid,
  //       widget.type,
  //       widget.name,
  //       widget.phone,
  //       widget.loginUserArea,
  //       widget.dateTime);
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      // backgroundColor: const Color(0xFF353535),
      backgroundColor: Colors.white,
      body: SizedBox(
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: 90,
                  height: 90,
                  child: Lottie.asset('assets/images/yyhWaRPrJd.json',
                      repeat: true, fit: BoxFit.fill)),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Please Wait',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )),
    );
  }
}

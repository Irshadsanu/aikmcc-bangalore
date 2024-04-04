import 'package:aikmccbangalore/Constant/my_colors.dart';
import 'package:aikmccbangalore/Constant/widgets.dart';
import 'package:aikmccbangalore/Provider/UserProvider.dart';
import 'package:aikmccbangalore/Provider/mainprovider.dart';
import 'package:aikmccbangalore/Screens/User/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constant/my_functions.dart';
import '../User/Share Id card.dart';

class AdminApproveScree extends StatelessWidget {
  const AdminApproveScree({
    super.key,
    required this.name,
    required this.phone,
    // required this.age,
    required this.area,
    required this.address,
    // required this.homeAddress,
    // required this.bloodGroup,
    // required this.occupation,
    required this.from,
    required this.image,
    required this.id,
    required this.uid,
    required this.type,
    required this.adName,
    required this.adPhone,
    required this.status,
    // required this.seconderyPhone,
    // required this.aadhaar,
    // required this.gender,
    // required this.fullAddres,
    required this.coApprovedName,
    // required this.coApprovedPhone,
    required this.adminApprovedName,
    // required this.adminApprovedPhone,
    required this.coRejectedName,
    // required this.coRejectedPhone,
    required this.adminRejectedName,
    // required this.adminRejectedPhone,
    // required this.dateOfBirth,
    // required this.ward,
    // required this.panchayath,
    // required this.homeDistrict,
    // required this.assembly,
    required this.mainArea,
    // required this.homeAddress,
    // required this.userAreaDistrict,
    // required this.idName,
    // required this.idImage,
    // required this.idNumber,
  });

  final String from;
  final String name;
  final String phone;
  final String area;
  final String address;

  final String image;
  final String id;
  final String uid;
  final String type;
  final String adName;
  final String adPhone;
  final String status;

  final String coApprovedName;
  final String adminApprovedName;
  final String coRejectedName;
  final String adminRejectedName;

  final String mainArea;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    final T = TextStyle(
      color: Colors.black,
      fontSize: width / 28.07142857142857,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w700,
    );
    final r = TextStyle(
      color: Colors.grey.withOpacity(0.90),
      fontSize: width / 28.07142857142857,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w700,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      // body: ,

      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/splashScreenBackground.jpg"),
                fit: BoxFit.fill)),
        child: SafeArea(
          child: Consumer<MainProvider>(builder: (context, mainPro, _) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    scrolledUnderElevation: 0,
                    elevation: 0,
                    centerTitle: true,
                    leading: InkWell(
                      onTap: () {
                        finish(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    title: Image.asset(
                      "assets/images/sarLogo.png",
                      scale: 6.5,
                    ),
                    actions: [
                      Consumer<UserProvider>(builder: (context, use, _) {
                        return status == "PENDING"
                            ? GestureDetector(
                                onTap: () {
                                  callNext(
                                      ShareIdCard(
                                          image: image,
                                          phone: phone,
                                          name: name),
                                      context);
                                },
                                child: Container(
                                  height: 30,
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.only(right: 20),
                                  // width: width / 2,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(76),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Share Status',
                                    style: TextStyle(
                                      color: maincolor,
                                      fontSize: 11,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox();
                      })
                    ],
                  ),
                  const Text(
                    'AIKMCC\nBENGALURU',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: width / 1.1,
                    // height: 500,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x26000000).withOpacity(.08),
                          blurRadius: 2.0, // soften the shadow
                          spreadRadius: 1.0, //extend the shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        image != ""
                            ? Container(
                                width: width / 3.3,
                                height: 130,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: NetworkImage(image),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(24.27),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x19000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                      spreadRadius: -3,
                                    )
                                  ],
                                ),
                              )
                            : Container(
                                width: width / 3.3,
                                height: 130,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: const Icon(Icons.perm_identity_outlined,
                                    color: maincolor),
                              ),
                        const SizedBox(
                          height: 15,
                        ),
                        DetailesScreeWidget(
                          r: r,
                          T: T,
                          name: name,
                          head: 'NAME',
                        ),
                        DetailesScreeWidget(
                          r: r,
                          T: T,
                          name: phone,
                          head: 'PHONE',
                        ),
                        mainPro.seconderyPhone != ""
                            ? DetailesScreeWidget(
                                r: r,
                                T: T,
                                name: mainPro.seconderyPhone,
                                head: 'Secondary Phone',
                              )
                            : const SizedBox(),
                        DetailesScreeWidget(
                          r: r,
                          T: T,
                          name: mainPro.gender,
                          head: 'Gender',
                        ),
                        DetailesScreeWidget(
                          r: r,
                          T: T,
                          name: mainPro.age,
                          head: 'AGE',
                        ),
                        DetailesScreeWidget(
                          r: r,
                          T: T,
                          name: mainPro.dateOfBirth,
                          head: 'Date of Birth',
                        ),
                        DetailesScreeWidget(
                          r: r,
                          T: T,
                          name: mainPro.idNumber == ""
                              ? mainPro.aadhaar
                              : mainPro.idNumber,
                          head: mainPro.idName == ""
                              ? "Aadhaar"
                              : '${mainPro.idName} Number',
                        ),
                        mainPro.idImage != ""
                            ? Consumer<UserProvider>(builder: (context, va, _) {
                                return Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _showBlankAlertDialog(context, width);
                                      },
                                      child: Container(
                                          height: 150,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    mainPro.idImage),
                                                fit: BoxFit.contain),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                );
                              })
                            : const SizedBox(),
                        DetailesScreeWidget(
                          r: r,
                          T: T,
                          name: area,
                          head: 'AREA',
                        ),
                        DetailesScreeWidget(
                          r: r,
                          T: T,
                          name: address,
                          head: 'ADDRESS',
                        ),
                        DetailesScreeWidget(
                          r: r,
                          T: T,
                          name:
                              "${mainPro.ward}\n${mainPro.panchayath}\n${mainPro.homeDistrict}",
                          head: 'HOME ADDERS',
                        ),
                        mainPro.fullAddres != ""
                            ? DetailesScreeWidget(
                                r: r,
                                T: T,
                                name: mainPro.fullAddres,
                                head: 'FULL ADDRESS',
                              )
                            : const SizedBox(),
                        DetailesScreeWidget(
                          r: r,
                          T: T,
                          name: mainPro.bloodGroup,
                          head: 'BLOOD GROUP',
                        ),
                        DetailesScreeWidget(
                          r: r,
                          T: T,
                          name: mainPro.occupation,
                          head: 'OCCUPATION',
                        ),
                        DetailesScreeWidget(
                          r: r,
                          T: T,
                          name: status,
                          head: 'STATUS',
                        ),
                        type == "ADMIN" && adminApprovedName != ""
                            ? DetailesScreeWidget(
                                r: r,
                                T: T,
                                name: adminApprovedName,
                                head: 'APROVED BY',
                              )
                            : const SizedBox(),
                        coApprovedName != ""
                            ? DetailesScreeWidget(
                                r: r,
                                T: T,
                                name: coApprovedName,
                                head: 'APPROVED COORDINATOR',
                              )
                            : const SizedBox(),
                        type == "ADMIN" && adminRejectedName != ""
                            ? DetailesScreeWidget(
                                r: r,
                                T: T,
                                name: adminRejectedName,
                                head: 'REJECTED BY',
                              )
                            : const SizedBox(),
                        coRejectedName != ""
                            ? DetailesScreeWidget(
                                r: r,
                                T: T,
                                name: coRejectedName,
                                head: 'REJECTED COORDINATOR',
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 20,
                        ),
                        Consumer<MainProvider>(builder: (context, mainPro, _) {
                          return Row(
                            mainAxisAlignment: (from == "APPROVED" &&
                                        type == "ADMIN") ||
                                    (from == "PENDING" && type == "COORDINATOR")
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.spaceEvenly,
                            children: [
                              from == "PENDING" &&
                                      (status == "PENDING" ||
                                          (type == "ADMIN" &&
                                              status == "CO-APPROVED"))
                                  ? Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            mainPro.approvalAlert(
                                                context,
                                                "Reject",
                                                id,
                                                uid,
                                                width * .23,
                                                type,
                                                adName,
                                                adPhone,
                                                phone,
                                                name);
                                          },
                                          child: Container(
                                            height: 40,
                                            width: width / 4,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    width: 0.30,
                                                    color: Color(0xFF0F3848)),
                                                borderRadius:
                                                    BorderRadius.circular(76),
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              'Reject',
                                              style: TextStyle(
                                                color: Color(0xFFD00000),
                                                fontSize: 11,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (image != "" &&
                                                mainPro.idImage != "") {
                                              mainPro.approvalAlert(
                                                  context,
                                                  "Approve",
                                                  id,
                                                  uid,
                                                  width * .23,
                                                  type,
                                                  adName,
                                                  adPhone,
                                                  phone,
                                                  name);
                                            }else{
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                  backgroundColor: Colors.black, content: Text("⚠️ Profile photo and proof image are mandatory")));
                                            }
                                          },
                                          child: Container(
                                            height: 40,
                                            width: width / 4,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: ShapeDecoration(
                                              gradient: const LinearGradient(
                                                begin: Alignment(-1.00, -0.02),
                                                end: Alignment(1, 0.02),
                                                colors: [
                                                  Color(0xFF0F3848),
                                                  Color(0xFF1F6D8B)
                                                ],
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(76),
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              'Approve',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 11,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : const SizedBox(),
                              (from == "APPROVED" || from == "PENDING") &&
                                      type == "ADMIN"
                                  ? Consumer<UserProvider>(
                                      builder: (context, val, _) {
                                      return InkWell(
                                        onTap: () {
                                          val.fileImage = null;
                                          val.fileProof = null;
                                          DateTime date = DateTime.now();
                                          // String id =
                                          // date.millisecondsSinceEpoch.toString();
                                          val.editRegister(
                                              name,
                                              phone,
                                              address,
                                              area,
                                              mainPro.gender,
                                              mainPro.dateOfBirth,
                                              mainPro.aadhaar,
                                              mainPro.fullAddres,
                                              mainPro.ward,
                                              mainPro.bloodGroup,
                                              mainPro.occupation,
                                              mainPro.age,
                                              mainPro.seconderyPhone,
                                              mainPro.panchayath,
                                              mainPro.homeDistrict,
                                              mainPro.assembly,
                                              mainPro.userAreaDistrict,
                                              mainPro.idName,
                                              mainPro.idImage,
                                              mainPro.idNumber);
                                          callNext(
                                              RegistrationScreen(
                                                uid: uid,
                                                type: type,
                                                name: adName,
                                                phone: adPhone,
                                                from: 'EDIT',
                                                proImage: image,
                                                id: id,
                                                coArea: mainArea,
                                                coAreaDistrict: "",
                                                idImage: mainPro.idImage,
                                                docId: '',
                                                date: date,
                                                status: status,
                                              ),
                                              context);
                                        },
                                        child: Container(
                                          height: 40,
                                          width: width / 4,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: ShapeDecoration(
                                            gradient: const LinearGradient(
                                              begin: Alignment(-1.00, -0.02),
                                              end: Alignment(1, 0.02),
                                              colors: [
                                                Color(0xFF0F3848),
                                                Color(0xFF1F6D8B)
                                              ],
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(76),
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                "Edit",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Icon(
                                                Icons.edit_outlined,
                                                color: Colors.white,
                                                size: 15,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                  : from == "PENDING" && type == "COORDINATOR"
                                      ? Consumer<UserProvider>(
                                          builder: (context, val, _) {
                                          return InkWell(
                                            onTap: () {
                                              val.fileImage = null;
                                              val.fileProof = null;
                                              DateTime date = DateTime.now();
                                              // String id =
                                              // date.millisecondsSinceEpoch.toString();
                                              val.editRegister(
                                                  name,
                                                  phone,
                                                  address,
                                                  area,
                                                  mainPro.gender,
                                                  mainPro.dateOfBirth,
                                                  mainPro.aadhaar,
                                                  mainPro.fullAddres,
                                                  mainPro.ward,
                                                  mainPro.bloodGroup,
                                                  mainPro.occupation,
                                                  mainPro.age,
                                                  mainPro.seconderyPhone,
                                                  mainPro.panchayath,
                                                  mainPro.homeDistrict,
                                                  mainPro.assembly,
                                                  mainPro.userAreaDistrict,
                                                  mainPro.idName,
                                                  mainPro.idImage,
                                                  mainPro.idNumber);
                                              callNext(
                                                  RegistrationScreen(
                                                    uid: uid,
                                                    type: type,
                                                    name: adName,
                                                    phone: adPhone,
                                                    from: 'EDIT',
                                                    proImage: image,
                                                    id: id,
                                                    coArea: mainArea,
                                                    coAreaDistrict: '',
                                                    idImage: mainPro.idImage,
                                                    docId: '',
                                                    date: date,
                                                    status: status,
                                                  ),
                                                  context);
                                            },
                                            child: Container(
                                              height: 40,
                                              width: width / 4,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: ShapeDecoration(
                                                gradient: const LinearGradient(
                                                  begin:
                                                      Alignment(-1.00, -0.02),
                                                  end: Alignment(1, 0.02),
                                                  colors: [
                                                    Color(0xFF0F3848),
                                                    Color(0xFF1F6D8B)
                                                  ],
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(76),
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "Edit",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.edit_outlined,
                                                    color: Colors.white,
                                                    size: 15,
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        })
                                      : const SizedBox(),
                            ],
                          );
                        })
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Future<void> _showBlankAlertDialog(BuildContext context, double width) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        var height = MediaQuery.sizeOf(context).height;

        return Consumer<MainProvider>(builder: (context, va, _) {
          return SizedBox(
            // height: 600,
            child: InteractiveViewer(
              panEnabled: false,
              // Set it to false
              boundaryMargin: const EdgeInsets.all(100),
              minScale: 0.5,
              maxScale: 2,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: va.idImage != ""
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(21),
                        image: DecorationImage(
                            image: NetworkImage(va.idImage), fit: BoxFit.fill))
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(21),
                      ),
                height: height / 1.5,
                // width: width / 1.1,
              ),
            ),
          );
        });
      },
    );
  }
}

class DetailesScreeWidget extends StatelessWidget {
  const DetailesScreeWidget({
    super.key,
    required this.r,
    required this.T,
    required this.name,
    required this.head,
  });

  final TextStyle r;
  final TextStyle T;
  final String name;
  final String head;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "$head ",
                style: r,
              ),
            ),
            Text(": ", style: T),
            Expanded(
              flex: 2,
              child: Text(
                name,
                style: T,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 13,
        ),
      ],
    );
  }
}

import 'dart:io';

import 'package:aikmccbangalore/Constant/images.dart';
import 'package:aikmccbangalore/Constant/my_colors.dart';
import 'package:aikmccbangalore/Constant/my_functions.dart';
import 'package:aikmccbangalore/Provider/UserProvider.dart';
import 'package:aikmccbangalore/Provider/mainprovider.dart';
import 'package:aikmccbangalore/Provider/LoginProvider.dart';
import 'package:aikmccbangalore/Screens/User/registration_screen.dart';
import 'package:aikmccbangalore/Screens/admin/Add_Cordinator.dart';
import 'package:aikmccbangalore/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Constant/my_colors.dart';
import '../../Constant/widgets.dart';
import 'approveScreen.dart';

class AdminHomeScreen extends StatefulWidget {
  String uid;
  String type;
  String name;
  String phone;
  String coArea;
  String coAreaDistrit;

  AdminHomeScreen(
      {super.key,
      required this.uid,
      required this.type,
      required this.name,
      required this.phone,
      required this.coArea,
      required this.coAreaDistrit,
      });

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  int indexNew = 0;
  bool detailsBool = false;

  @override
  void initState() {
    super.initState();
    // var tablength = widget.type == "ADMIN" ? 3 :2;

    controller = TabController(initialIndex: 0, length: 4, vsync: this);
    controller.addListener(handleTabChange);
  }

  void handleTabChange() {
    indexNew = controller.index;
    setState(() {
      if (indexNew == 0) {
        // userProvider.sortDistributionList=userProvider.masterDistributionList;
      } else if (indexNew == 1) {
        // userProvider.sortDistributionList=userProvider.starDistributionList;
      } else {
        // userProvider.sortDistributionList=userProvider.crownDistributionList;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        return showExitPopup();
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(appBarBG),
                alignment: Alignment.topCenter,
                fit: BoxFit.fill,
              ),
            ),
            child: Stack(
              children: [
                SizedBox(
                  height: height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        // color:Colors.blue,
                        width: width,
                        // height: 100,
                        child: Column(
                          children: [
                            AppBar(
                              backgroundColor: Colors.transparent,
                              centerTitle: true,
                              leadingWidth: 100,
                              leading: Image.asset(sarLogo, scale: 7),
                              title: const Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'AIKMCC\n',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.43,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'BENGALURU',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                Consumer<LoginProvider>(
                                    builder: (context, value, child) {
                                  return InkWell(
                                      onTap: () {
                                        value.logOutAlert(context);
                                      },
                                      child: const Icon(
                                        Icons.logout,
                                        color: Colors.white,
                                      ));
                                }),
                                const SizedBox(
                                  width: 9,
                                )
                              ],
                            ),

                            // Padding(
                            //   padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment
                            //         .spaceBetween,
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     children: [
                            //       Image.asset(sarLogo, scale: 7),
                            //
                            //       Text.rich(
                            //         TextSpan(
                            //           children: [
                            //             TextSpan(
                            //               text: 'AIKMCC\n',
                            //               style: TextStyle(
                            //                 color: Colors.white,
                            //                 fontSize: 16.43,
                            //                 fontFamily: 'Poppins',
                            //                 fontWeight: FontWeight.w700,
                            //               ),
                            //             ),
                            //             TextSpan(
                            //               text: 'BENGALURU',
                            //               style: TextStyle(
                            //                 color: Colors.white,
                            //                 fontSize: 12,
                            //                 fontFamily: 'Poppins',
                            //                 fontWeight: FontWeight.w700,
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //         textAlign: TextAlign.center,
                            //       ),
                            //
                            //        const SizedBox(width: 3,),
                            //
                            //       // Container(
                            //       //   // margin: const EdgeInsets.only(right: 0),
                            //       //   width: 30,
                            //       //   height: 30,
                            //       //   alignment: Alignment.center,
                            //       //
                            //       //   decoration: BoxDecoration(
                            //       //       borderRadius: const BorderRadius.all(
                            //       //           Radius.circular(7)),
                            //       //       color: Colors.white,
                            //       //       image: DecorationImage(
                            //       //           image: AssetImage(AIKMCCLOGO),
                            //       //           scale: 30)),
                            //       // ),
                            //       // InkWell(
                            //       //     child: CircleAvatar(
                            //       //       radius: 20,backgroundColor: Colors.white,
                            //       //       child: Icon(Icons.perm_identity_outlined,color: maincolor),)),
                            //       Consumer<LoginProvider>(
                            //           builder: (context, value, child) {
                            //             return InkWell(
                            //                 onTap: () {
                            //                   value.logOutAlert(context);
                            //                 },
                            //                 child: const Icon(
                            //                   Icons.logout,
                            //                   color: Colors.white,
                            //                 ));
                            //           }),
                            //     ],
                            //   ),
                            // ),

                            SizedBox(
                              width: width,
                              child: Text(
                                widget.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.5,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width,
                              child: Text(
                                widget.phone,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),

                            //  SizedBox(
                            //   height:5 ,
                            // ),
                          ],
                        ),
                      ),
                      Image.asset(
                        curveIcon,
                        fit: BoxFit.fill,
                      ),
                      Expanded(child: Container(color: Colors.white))
                    ],
                  ),
                ),
                Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(top: height / 4)),
                Consumer<MainProvider>(builder: (context, mainPro, _) {
                  return SizedBox(
                      height: height,
                      width: width,
                      child: Column(children: [
                        Container(
                          height: 135,
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Column(
                            children: [
                              Container(
                                width: width * .9,
                                height: 40,
                                alignment: Alignment.center,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x0A000000),
                                      blurRadius: 5.15,
                                      offset: Offset(0, 2.58),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    suffixIcon: SizedBox(
                                      width: width * .23,
                                      child: widget.type == "ADMIN"
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Icon(Icons.search,
                                                    color: Colors.black,
                                                    size: 22),
                                                InkWell(
                                                    onTap: () {
                                                      if (mainPro.filterOnApproved ||
                                                          mainPro
                                                              .filterOnPending ||
                                                          mainPro
                                                              .filterOnRejected) {
                                                        mainPro.clearFilters(
                                                            mainPro
                                                                .filterOnApproved,
                                                            mainPro
                                                                .filterOnPending,
                                                            mainPro
                                                                .filterOnRejected,
                                                            true);
                                                      } else {
                                                        mainPro.alertFilter(
                                                            context,
                                                            width,
                                                            indexNew);
                                                      }
                                                    },
                                                    child: Image.asset(
                                                      mainPro.filterOnApproved ||
                                                              mainPro
                                                                  .filterOnPending ||
                                                              mainPro
                                                                  .filterOnRejected
                                                          ? clearFilter
                                                          : filterIcon,
                                                      scale: 2.5,
                                                    )),
                                                InkWell(
                                                    onTap: () {
                                                      mainPro.refreshButton(widget.type,widget.coArea,widget.uid);
                                                    },
                                                    child: const Icon(
                                                        Icons.refresh_outlined))
                                              ],
                                            )
                                          : SizedBox(
                                        width:  width * .17,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                const Icon(Icons.search,
                                                    color: Colors.black, size: 22),
                                                InkWell(
                                                    onTap: () {
                                                      mainPro.refreshButton(widget.type,widget.coArea,widget.uid);
                                                    },
                                                    child: const Icon(
                                                        Icons.refresh_outlined))
                                              ],
                                            ),
                                          ),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.only(bottom: 1),
                                    hintText: 'Search here',
                                    hintStyle: const TextStyle(
                                      color: Color(0xFFB1B1B1),
                                      fontSize: 10,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      height: 0.14,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (text) {
                                    if (indexNew == 0) {
                                      mainPro.filterApprovedUsers(text);
                                    } else if (indexNew == 1) {
                                      mainPro.filterPendingUsers(text);
                                    } else if (indexNew == 2) {
                                      mainPro.filterRejectedUsers(text);
                                    } else {
                                      mainPro.filterCoordinatedUsers(text);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 19,
                              ),
                              Consumer<MainProvider>(
                                  builder: (context, tabValue, child) {
                                return TabBar(
                                  controller: controller,
                                  // unselectedLabelColor: Colors.redAccent,
                                  // indicatorColor: Colors.black,
                                  indicator: const ShapeDecoration(
                                    shape: RoundedRectangleBorder(),
                                  ),
                                  dividerColor: Colors.transparent,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  labelColor: Colors.yellow,
                                  onTap: (index) {
                                    if (!controller.indexIsChanging) {
                                      controller.animateTo(index);
                                    }
                                    if (index == 0) {
                                    } else if (index == 1) {
                                    } else {}
                                  },
                                  tabs: [
                                    Tab(
                                      child: Column(
                                        children: [
                                          Text(
                                            widget.type == "ADMIN"
                                                ? " ${tabValue.approvedLength}\nApproved"
                                                : " ${tabValue.coApprovedLength}\nApproved",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: indexNew == 0
                                                  ? Colors.black
                                                  : Colors.black
                                                      .withOpacity(0.20),
                                              fontSize: 9,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              height: 1,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Container(
                                            height: 9,
                                            // width: width / 0.6,
                                            alignment: Alignment.center,
                                            decoration: ShapeDecoration(
                                              gradient: LinearGradient(
                                                begin: const Alignment(
                                                    -1.00, -0.02),
                                                end: const Alignment(1, 0.02),
                                                colors: indexNew == 0
                                                    ? [
                                                        const Color(0xFF1F6D8B),
                                                        const Color(0xFF0F3848)
                                                      ]
                                                    : [
                                                        Colors.black
                                                            .withOpacity(0.10),
                                                        Colors.black
                                                            .withOpacity(0.10)
                                                      ],
                                              ),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(76),
                                                  topRight: Radius.circular(76),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Tab(
                                      child: Column(
                                        children: [
                                          Text(
                                            widget.type == "ADMIN"
                                                ? " ${tabValue.pendingLength}\nPending"
                                                : " ${tabValue.coPendingLength}\nPending",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: indexNew == 1
                                                  ? Colors.black
                                                  : Colors.black
                                                      .withOpacity(0.20),
                                              fontSize: 9,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              height: 1,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Container(
                                            height: 10,
                                            // width: width / 0.6,
                                            alignment: Alignment.center,
                                            decoration: ShapeDecoration(
                                              gradient: LinearGradient(
                                                begin: const Alignment(
                                                    -1.00, -0.02),
                                                end: const Alignment(1, 0.02),
                                                colors: indexNew == 1
                                                    ? [
                                                        const Color(0xFF1F6D8B),
                                                        const Color(0xFF0F3848)
                                                      ]
                                                    : [
                                                        Colors.black
                                                            .withOpacity(0.10),
                                                        Colors.black
                                                            .withOpacity(0.10)
                                                      ],
                                              ),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(76),
                                                  topRight: Radius.circular(76),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Tab(
                                      child: Column(
                                        children: [
                                          Text(
                                            widget.type == "ADMIN"
                                                ? "${tabValue.rejectedLength}\nRejected "
                                                : "${tabValue.coRejectedLength}\nRejected ",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: indexNew == 2
                                                  ? Colors.black
                                                  : Colors.black
                                                      .withOpacity(0.20),
                                              fontSize: 9,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              height: 1,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Container(
                                            height: 10,
                                            // width: width / 0.6,
                                            alignment: Alignment.center,
                                            decoration: ShapeDecoration(
                                              gradient: LinearGradient(
                                                begin: const Alignment(
                                                    -1.00, -0.02),
                                                end: const Alignment(1, 0.02),
                                                colors: indexNew == 2
                                                    ? [
                                                        const Color(0xFF1F6D8B),
                                                        const Color(0xFF0F3848)
                                                      ]
                                                    : [
                                                        Colors.black
                                                            .withOpacity(0.10),
                                                        Colors.black
                                                            .withOpacity(0.10)
                                                      ],
                                              ),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(76),
                                                  topRight: Radius.circular(76),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Tab(
                                      child: Column(
                                        children: [
                                          Text(
                                            "${tabValue.filterCoordinatorModelList.length}\nCoordinator",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: indexNew == 3
                                                  ? Colors.black
                                                  : Colors.black
                                                      .withOpacity(0.20),
                                              fontSize: 8.2,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              height: 1,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Container(
                                            // width: width / 0.6,
                                            height: 9,
                                            alignment: Alignment.center,
                                            decoration: ShapeDecoration(
                                              gradient: LinearGradient(
                                                begin: const Alignment(
                                                    -1.00, -0.02),
                                                end: const Alignment(1, 0.02),
                                                colors: indexNew == 3
                                                    ? [
                                                        const Color(0xFF1F6D8B),
                                                        const Color(0xFF0F3848)
                                                      ]
                                                    : [
                                                        Colors.black
                                                            .withOpacity(0.10),
                                                        Colors.black
                                                            .withOpacity(0.10)
                                                      ],
                                              ),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(76),
                                                  topRight: Radius.circular(76),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }),
                              Flexible(
                                  fit: FlexFit.loose,
                                  child: TabBarView(
                                      controller: controller,
                                      children: [
                                        SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Consumer<UserProvider>(builder:
                                                  (context, userVal, child) {
                                                return Consumer<MainProvider>(
                                                    builder: (context,
                                                        approveValue, child) {
                                                  return approveValue
                                                          .loadingTrue
                                                      ? const Column(
                                                          children: [
                                                            SizedBox(
                                                                height: 30),
                                                            CircularProgressIndicator(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                          Color>(
                                                                      maincolor),
                                                            ),
                                                          ],
                                                        )
                                                      : approveValue
                                                              .filterApprovedRegisterModelList
                                                              .isNotEmpty
                                                          ? ListView.builder(
                                                              itemCount:
                                                                  approveValue
                                                                      .filterApprovedRegisterModelList
                                                                      .length,
                                                              shrinkWrap: true,
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              physics:
                                                                  const ScrollPhysics(),
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                var items =
                                                                    approveValue
                                                                            .filterApprovedRegisterModelList[
                                                                        index];
                                                                return Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          8.0,
                                                                      right: 15,
                                                                      left: 15),
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      approveValue.fetchUserFullDetailes(items.id);

                                                                      callNext(
                                                                          AdminApproveScree(
                                                                            from:
                                                                                "APPROVED",
                                                                            name:
                                                                                items.name,
                                                                            // age:
                                                                            //     items.age,
                                                                            area:
                                                                                items.area,
                                                                            phone:
                                                                                items.phone,
                                                                            address:
                                                                                items.address,
                                                                            // homeAddress: items.ward.trim() != ""
                                                                            //     ? "${items.ward}\n${items.panchayath}\n${items.district}"
                                                                            //     : "",
                                                                            // bloodGroup:
                                                                            //     items.bloodGroup,
                                                                            // occupation:
                                                                            //     items.occupation,
                                                                            image:
                                                                                items.image,
                                                                            id: items.id,
                                                                            uid:
                                                                                widget.uid,
                                                                            adName:
                                                                                widget.name,
                                                                            type:
                                                                                widget.type,
                                                                            adPhone:
                                                                                widget.phone,
                                                                            status:
                                                                                items.status,
                                                                            // seconderyPhone:
                                                                            //     items.seconderyNumber,
                                                                            // aadhaar:
                                                                            //     items.aadhaar,
                                                                            // gender:
                                                                            //     items.gender,
                                                                            // fullAddres:
                                                                            //     items.fullAddress,
                                                                            // coRejectedName:
                                                                            //     items.coRejectedName,
                                                                            coApprovedName:
                                                                                items.coApprovedName,
                                                                            // coApprovedPhone:
                                                                            //     items.coApprovedPhone,
                                                                            adminApprovedName:
                                                                                items.adminApprovedName,
                                                                            // adminApprovedPhone:
                                                                            //     items.adminApprovedPhone,
                                                                            adminRejectedName: items.adminRejectedName,
                                                                            // coRejectedPhone:
                                                                            //     items.coRejectedPhone,
                                                                            // adminRejectedPhone:
                                                                            //     items.adminRejectedPhone,
                                                                            // dateOfBirth:
                                                                            //     items.dob,
                                                                            // ward:
                                                                            //     items.ward,
                                                                            // panchayath:
                                                                            //     items.panchayath,
                                                                            // homeDistrict: items.district,
                                                                            // assembly: items.assembly,
                                                                              mainArea: widget.coArea, coRejectedName: items.coRejectedName,
                                                                            // userAreaDistrict: items.areaDistrict, idName: items.proofName, idImage: items.fetchProofImage, idNumber: items.proofNumber
                                                                          ),
                                                                          context);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              5),
                                                                      clipBehavior:
                                                                          Clip.antiAlias,
                                                                      decoration:
                                                                          ShapeDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20),
                                                                        ),
                                                                        shadows: const [
                                                                          BoxShadow(
                                                                            color:
                                                                                Color(0x0A000000),
                                                                            blurRadius:
                                                                                5.15,
                                                                            offset:
                                                                                Offset(0, 2.58),
                                                                            spreadRadius:
                                                                                0,
                                                                          )
                                                                        ],
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Container(
                                                                              height: 60,
                                                                              width: width / 6.383333333333333,
                                                                              margin: const EdgeInsets.only(left: 5),
                                                                              decoration: items.image != ""
                                                                                  ? BoxDecoration(
                                                                                      borderRadius: const BorderRadius.all(
                                                                                        Radius.circular(10),
                                                                                      ),
                                                                                      image: DecorationImage(
                                                                                          image: NetworkImage(
                                                                                            items.image,
                                                                                          ),
                                                                                          fit: BoxFit.fill))
                                                                                  : const BoxDecoration(
                                                                                      borderRadius: BorderRadius.all(
                                                                                        Radius.circular(10),
                                                                                      ),
                                                                                    ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                5,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(
                                                                                left: 13.0,
                                                                              ),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Expanded(
                                                                                        flex: 2,
                                                                                        child: SizedBox(
                                                                                          child: Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Text(items.name, style: titleStyle),
                                                                                              Text(items.phone, style: subtitleStyle),
                                                                                              Text(items.area, style: subtitleStyle),
                                                                                              Text(items.time, style: subtitleStyle),
                                                                                              widget.type == "ADMIN" ? Text("Approved by ${items.adminApprovedName}", style: subtitleStyle) : const SizedBox(),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        flex: 1,
                                                                                        child: SizedBox(
                                                                                          width: width * .22,
                                                                                          child: Column(
                                                                                            children: [
                                                                                              const Row(
                                                                                                children: [
                                                                                                  Icon(Icons.check, color: Color(0xFF02AD47), size: 15),
                                                                                                  Text(
                                                                                                    ' Approved',
                                                                                                    textAlign: TextAlign.right,
                                                                                                    style: TextStyle(
                                                                                                      color: Color(0xFF02AD47),
                                                                                                      fontSize: 11,
                                                                                                      fontFamily: 'Poppins',
                                                                                                      fontWeight: FontWeight.w400,
                                                                                                      height: 0.15,
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                              const SizedBox(
                                                                                                height: 5,
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                                                                                child: Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                                  children: [
                                                                                                    InkWell(
                                                                                                        onTap: () {
                                                                                                          launch("tel://${items.phone}");
                                                                                                        },
                                                                                                        child: Image.asset(
                                                                                                          callIcon,
                                                                                                          scale: 3,
                                                                                                        )),
                                                                                                    const SizedBox(
                                                                                                      width: 15,
                                                                                                    ),
                                                                                                    InkWell(
                                                                                                        onTap: () {
                                                                                                          launch('whatsapp://send?phone=${items.phone}');
                                                                                                        },
                                                                                                        child: Image.asset(
                                                                                                          whatsappIcon,
                                                                                                          scale: 3,
                                                                                                        )),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              })
                                                          : const Center(
                                                              child: Text(
                                                                  "No More Approved Registrations",
                                                                  style: TextStyle(
                                                                      color:
                                                                          maincolor,
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            );
                                                });
                                              }),
                                              // Consumer<MainProvider>(builder:
                                              //     (context, value2, child) {
                                              //   return value2.approvedLength ==
                                              //       value2
                                              //           .filterApprovedRegisterModelList
                                              //           .length ||
                                              //       value2.filterOnApproved == false
                                              //       ? const SizedBox()
                                              //       : Center(
                                              //     child: LoadMoreButton(
                                              //       function: (){
                                              //         value2.filterFetchFunctionsForApproved(
                                              //             value2
                                              //                 .selectedAreaForFil,
                                              //             false,
                                              //             value2
                                              //                 .filterApprovedRegisterModelList[
                                              //             value2.filterApprovedRegisterModelList.length -
                                              //                 1]
                                              //                 .regDateTime);
                                              //       },
                                              //     ),
                                              //   );
                                              // }),
                                              Consumer<LoginProvider>(
                                                  builder: (context, val43, _) {
                                                return Consumer<MainProvider>(
                                                    builder: (context4, value3,
                                                        child) {
                                                  return value3.filterOnApproved
                                                      ? value3.filterApprovedLimit >
                                                                  value3
                                                                      .filterApprovedRegisterModelList
                                                                      .length ||
                                                              value3
                                                                  .filterApprovedRegisterModelList
                                                                  .isEmpty
                                                          ? const SizedBox()
                                                          : Center(
                                                              child:
                                                                  LoadMoreButton(
                                                                function: () {
                                                                  value3.filterFetchFunctionsForApproved(
                                                                      value3
                                                                          .selectedAreaForFil,
                                                                      false,
                                                                      value3
                                                                          .filterApprovedRegisterModelList[value3.filterApprovedRegisterModelList.length -
                                                                              1]
                                                                          .regDateTime);
                                                                },
                                                              ),
                                                            )
                                                      : value3.approvedLimit >
                                                                  value3
                                                                      .filterApprovedRegisterModelList
                                                                      .length ||
                                                              value3
                                                                  .filterApprovedRegisterModelList
                                                                  .isEmpty
                                                          ? const SizedBox()
                                                          : Center(
                                                              child:
                                                                  LoadMoreButton(
                                                                function: () {
                                                                  if (widget
                                                                          .type ==
                                                                      "ADMIN") {
                                                                    value3.getApprovedRegistration(
                                                                        false,
                                                                        value3
                                                                            .filterApprovedRegisterModelList[value3.filterApprovedRegisterModelList.length -
                                                                                1]
                                                                            .regDateTime);
                                                                  } else {
                                                                    value3.getCoordinatorApprovedRegistration(
                                                                        val43
                                                                            .loginUserArea,
                                                                        false,
                                                                        value3
                                                                            .filterApprovedRegisterModelList[value3.filterApprovedRegisterModelList.length -
                                                                                1]
                                                                            .regDateTime);
                                                                  }
                                                                },
                                                              ),
                                                            );
                                                });
                                              }),
                                            ],
                                          ),
                                        ),
                                        SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Consumer<MainProvider>(builder:
                                                  (context, pendingValue,
                                                      child) {
                                                return pendingValue.loadingTrue
                                                    ? const Column(
                                                        children: [
                                                          SizedBox(height: 30),
                                                          CircularProgressIndicator(
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    maincolor),
                                                          ),
                                                        ],
                                                      )
                                                    : pendingValue
                                                            .filterPendingRegisterModelList
                                                            .isNotEmpty
                                                        ? ListView.builder(
                                                            itemCount: pendingValue
                                                                .filterPendingRegisterModelList
                                                                .length,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            physics:
                                                                const ScrollPhysics(),
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              var items =
                                                                  pendingValue
                                                                          .filterPendingRegisterModelList[
                                                                      index];
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            8.0,
                                                                        right:
                                                                            15,
                                                                        left:
                                                                            15),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    pendingValue.fetchUserFullDetailes(items.id);
                                                                    callNext(
                                                                        AdminApproveScree(
                                                                            from:
                                                                                "PENDING",
                                                                            name: items
                                                                                .name,
                                                                            // age: items
                                                                            //     .age,
                                                                            area: items
                                                                                .area,
                                                                            phone: items
                                                                                .phone,
                                                                            address: items
                                                                                .address,
                                                                            // homeAddress: items.ward.trim() != ""
                                                                            //     ? "${items.ward}\n${items.panchayath}\n${items.district}"
                                                                            //     : "",
                                                                            // bloodGroup:
                                                                            //     items.bloodGroup,
                                                                            // occupation: items.occupation,
                                                                            image: items.image,
                                                                            id: items.id,
                                                                            uid: widget.uid,
                                                                            adName: widget.name,
                                                                            adPhone: widget.phone,
                                                                            type: widget.type,
                                                                            status: items.status,
                                                                            // seconderyPhone: items.seconderyNumber,
                                                                            // aadhaar: items.aadhaar,
                                                                            // gender: items.gender,
                                                                            // fullAddres: items.fullAddress,
                                                                            coRejectedName: items.coRejectedName,
                                                                            coApprovedName: items.coApprovedName,
                                                                            // coApprovedPhone: items.coApprovedPhone,
                                                                            adminApprovedName: items.adminApprovedName,
                                                                            // adminApprovedPhone: items.adminApprovedPhone,
                                                                            adminRejectedName: items.adminRejectedName,
                                                                            // coRejectedPhone: items.coRejectedPhone,
                                                                            // adminRejectedPhone: items.adminRejectedPhone,
                                                                            // dateOfBirth: items.dob,
                                                                            // ward: items.ward,
                                                                            // panchayath: items.panchayath,
                                                                            // homeDistrict: items.district,
                                                                          // assembly: items.assembly,
                                                                          mainArea: widget.coArea,
                                                                            // userAreaDistrict: items.areaDistrict,
                                                                            //
                                                                            // idName: items.proofName, idImage: items.fetchProofImage, idNumber: items.proofNumber
                                                                        ),
                                                                        context);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            5),
                                                                    clipBehavior:
                                                                        Clip.antiAlias,
                                                                    decoration:
                                                                        ShapeDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                      ),
                                                                      shadows: const [
                                                                        BoxShadow(
                                                                          color:
                                                                              Color(0x0A000000),
                                                                          blurRadius:
                                                                              5.15,
                                                                          offset: Offset(
                                                                              0,
                                                                              2.58),
                                                                          spreadRadius:
                                                                              0,
                                                                        )
                                                                      ],
                                                                    ),
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              60,
                                                                          width:
                                                                              width / 6.383333333333333,
                                                                          margin: const EdgeInsets
                                                                              .only(
                                                                              left: 5),
                                                                          decoration: items.image != ""
                                                                              ? BoxDecoration(
                                                                                  borderRadius: const BorderRadius.all(
                                                                                    Radius.circular(10),
                                                                                  ),
                                                                                  image: DecorationImage(
                                                                                      image: NetworkImage(
                                                                                        items.image,
                                                                                      ),
                                                                                      fit: BoxFit.fill))
                                                                              : const BoxDecoration(
                                                                                  borderRadius: BorderRadius.all(
                                                                                    Radius.circular(10),
                                                                                  ),
                                                                                ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              5,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 13.0, right: 5),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Text(items.name, style: titleStyle),
                                                                                          Text(items.phone, style: subtitleStyle),
                                                                                          Text(items.area, style: subtitleStyle),
                                                                                          Text(items.time, style: subtitleStyle),
                                                                                          items.coApprovedName != "" ? Text("Approved by ${items.coApprovedName}", style: subtitleStyle) : const SizedBox(),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      flex: 1,
                                                                                      child: Column(
                                                                                        children: [
                                                                                          SizedBox(
                                                                                            width: width * .2,
                                                                                            child: Row(
                                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                                              children: [
                                                                                                Image.asset(
                                                                                                  pendingIcon,
                                                                                                  scale: 3.3,
                                                                                                ),
                                                                                                const Text(
                                                                                                  ' Pending',
                                                                                                  textAlign: TextAlign.right,
                                                                                                  style: TextStyle(
                                                                                                    color: Color(0xFF2DC0FF),
                                                                                                    fontSize: 11,
                                                                                                    fontFamily: 'Poppins',
                                                                                                    fontWeight: FontWeight.w400,
                                                                                                    height: 0.15,
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          const SizedBox(
                                                                                            height: 5,
                                                                                          ),
                                                                                          items.status != "PENDING"
                                                                                              ? Text(items.status,
                                                                                                  style: TextStyle(
                                                                                                    color: maincolor,
                                                                                                    fontSize: width / 38,
                                                                                                    fontFamily: 'Poppins',
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                    // height: 0.12,
                                                                                                  ))
                                                                                              : const SizedBox(),
                                                                                          const SizedBox(
                                                                                            height: 5,
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: [
                                                                                                InkWell(
                                                                                                    onTap: () {
                                                                                                      launch("tel://${items.phone}");
                                                                                                    },
                                                                                                    child: Image.asset(
                                                                                                      callIcon,
                                                                                                      scale: 3,
                                                                                                    )),
                                                                                                const SizedBox(
                                                                                                  width: 15,
                                                                                                ),
                                                                                                InkWell(
                                                                                                    onTap: () {
                                                                                                      launch('whatsapp://send?phone=${items.phone}');
                                                                                                    },
                                                                                                    child: Image.asset(
                                                                                                      whatsappIcon,
                                                                                                      scale: 3,
                                                                                                    )),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            })
                                                        : const Text(
                                                            "No More Pending Registrations",
                                                            style: TextStyle(
                                                                color:
                                                                    maincolor,
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold));
                                              }),
                                              Consumer<LoginProvider>(
                                                  builder: (context, val43, _) {
                                                return Consumer<MainProvider>(
                                                    builder: (context4, value3,
                                                        child) {
                                                  return value3.filterOnPending
                                                      ? value3.filterPendingLimit >
                                                                  value3
                                                                      .filterPendingRegisterModelList
                                                                      .length ||
                                                              value3
                                                                  .filterPendingRegisterModelList
                                                                  .isEmpty
                                                          ? const SizedBox()
                                                          : Center(
                                                              child:
                                                                  LoadMoreButton(
                                                                function: () {
                                                                  value3.filterFetchFunctionsForPending(
                                                                      value3
                                                                          .selectedAreaForFil,
                                                                      false,
                                                                      value3
                                                                          .filterPendingRegisterModelList[value3.filterPendingRegisterModelList.length -
                                                                              1]
                                                                          .regDateTime);
                                                                },
                                                              ),
                                                            )
                                                      : value3.pendingLimit >
                                                                  value3
                                                                      .filterPendingRegisterModelList
                                                                      .length ||
                                                              value3
                                                                  .filterPendingRegisterModelList
                                                                  .isEmpty
                                                          ? const SizedBox()
                                                          : Center(
                                                              child:
                                                                  LoadMoreButton(
                                                                function: () {
                                                                  if (widget
                                                                          .type ==
                                                                      "ADMIN") {
                                                                    value3.getPendingRegistration(
                                                                        false,
                                                                        value3
                                                                            .filterPendingRegisterModelList[value3.filterPendingRegisterModelList.length -
                                                                                1]
                                                                            .regDateTime);
                                                                  } else {
                                                                    value3.getCoordinatorPendingRegistration(
                                                                        val43
                                                                            .loginUserArea,
                                                                        false,
                                                                        value3
                                                                            .filterPendingRegisterModelList[value3.filterPendingRegisterModelList.length -
                                                                                1]
                                                                            .regDateTime);
                                                                  }
                                                                },
                                                              ),
                                                            );
                                                });
                                              }),
                                            ],
                                          ),
                                        ),
                                        SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Consumer<MainProvider>(builder:
                                                  (context, pendingValue,
                                                      child) {
                                                return pendingValue.loadingTrue
                                                    ? const Column(
                                                        children: [
                                                          SizedBox(height: 30),
                                                          CircularProgressIndicator(
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    maincolor),
                                                          ),
                                                        ],
                                                      )
                                                    : pendingValue
                                                            .filterRejectedRegisterModelList
                                                            .isNotEmpty
                                                        ? ListView.builder(
                                                            itemCount: pendingValue
                                                                .filterRejectedRegisterModelList
                                                                .length,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            physics:
                                                                const ScrollPhysics(),
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              var items =
                                                                  pendingValue
                                                                          .filterRejectedRegisterModelList[
                                                                      index];
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            8.0,
                                                                        right:
                                                                            15,
                                                                        left:
                                                                            15),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    pendingValue.fetchUserFullDetailes(items.id);

                                                                    callNext(
                                                                        AdminApproveScree(
                                                                            from:
                                                                                "REJECTED",
                                                                            name: items
                                                                                .name,
                                                                            // age: items
                                                                            //     .age,
                                                                            area: items
                                                                                .area,
                                                                            phone: items
                                                                                .phone,
                                                                            address: items
                                                                                .address,
                                                                            // homeAddress: items.ward.trim() != ""
                                                                            //     ? "${items.ward}\n${items.panchayath}\n${items.district}"
                                                                            //     : "",
                                                                            // bloodGroup: items
                                                                            //     .bloodGroup,
                                                                            // occupation: items
                                                                            //     .occupation,
                                                                            image: items
                                                                                .image,
                                                                            id:
                                                                                items.id,
                                                                            uid:
                                                                                '',
                                                                            adPhone:
                                                                                '',
                                                                            type: widget
                                                                                .type,
                                                                            adName:
                                                                                '',
                                                                            status:
                                                                                items.status,
                                                                            // seconderyPhone: items.seconderyNumber,
                                                                            // aadhaar: items.aadhaar,
                                                                            // gender: items.gender,
                                                                            // fullAddres: items.fullAddress,
                                                                            coRejectedName: items.coRejectedName,
                                                                            coApprovedName: items.coApprovedName,
                                                                            // coApprovedPhone: items.coApprovedPhone,
                                                                            adminApprovedName: items.adminApprovedName,
                                                                            // adminApprovedPhone: items.adminApprovedPhone,
                                                                            adminRejectedName: items.adminRejectedName,
                                                                          //   coRejectedPhone: items.coRejectedPhone,
                                                                          //   adminRejectedPhone: items.adminRejectedPhone,
                                                                          //   dateOfBirth: items.dob,
                                                                          //   ward: items.ward,
                                                                          //   panchayath: items.panchayath,
                                                                          // homeDistrict: items.district,
                                                                          // assembly: items.assembly,
                                                                          mainArea: widget.coArea,
                                                                            // userAreaDistrict: items.areaDistrict,
                                                                            // idName: items.proofName, idImage: items.fetchProofImage, idNumber: items.proofNumber
                                                                        ),
                                                                        context);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            5),
                                                                    clipBehavior:
                                                                        Clip.antiAlias,
                                                                    decoration:
                                                                        ShapeDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                      ),
                                                                      shadows: const [
                                                                        BoxShadow(
                                                                          color:
                                                                              Color(0x0A000000),
                                                                          blurRadius:
                                                                              5.15,
                                                                          offset: Offset(
                                                                              0,
                                                                              2.58),
                                                                          spreadRadius:
                                                                              0,
                                                                        )
                                                                      ],
                                                                    ),
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              60,
                                                                          width:
                                                                              width / 6.383333333333333,
                                                                          margin: const EdgeInsets
                                                                              .only(
                                                                              left: 5),
                                                                          decoration: items.image != ""
                                                                              ? BoxDecoration(
                                                                                  borderRadius: const BorderRadius.all(
                                                                                    Radius.circular(10),
                                                                                  ),
                                                                                  image: DecorationImage(
                                                                                      image: NetworkImage(
                                                                                        items.image,
                                                                                      ),
                                                                                      fit: BoxFit.fill))
                                                                              : const BoxDecoration(
                                                                                  borderRadius: BorderRadius.all(
                                                                                    Radius.circular(10),
                                                                                  ),
                                                                                ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              5,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(
                                                                              left: 13.0,
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Text(items.name, style: titleStyle),
                                                                                          Text(items.phone, style: subtitleStyle),
                                                                                          Text(items.area, style: subtitleStyle),
                                                                                          Text(items.time, style: subtitleStyle),
                                                                                          items.coRejectedName != "" ? Text("Rejected by ${items.coRejectedName}", style: subtitleStyle) : const SizedBox(),
                                                                                          items.adminRejectedName != "" && widget.type == "ADMIN" ? Text("Rejected by ${items.adminRejectedName}", style: subtitleStyle) : const SizedBox(),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      flex: 1,
                                                                                      child: SizedBox(
                                                                                        width: width * .22,
                                                                                        child: Column(
                                                                                          children: [
                                                                                            const Row(
                                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                                              children: [
                                                                                                Icon(
                                                                                                  Icons.close,
                                                                                                  color: Colors.red,
                                                                                                ),
                                                                                                Text(
                                                                                                  ' Rejected',
                                                                                                  textAlign: TextAlign.right,
                                                                                                  style: TextStyle(
                                                                                                    color: Colors.red,
                                                                                                    fontSize: 11,
                                                                                                    fontFamily: 'Poppins',
                                                                                                    fontWeight: FontWeight.w400,
                                                                                                    height: 0.15,
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            items.status != "REJECTED"
                                                                                                ? Text(items.status,
                                                                                                    style: const TextStyle(
                                                                                                      color: maincolor,
                                                                                                      fontSize: 10,
                                                                                                      fontFamily: 'Poppins',
                                                                                                      fontWeight: FontWeight.w500,
                                                                                                      // height: 0.12,
                                                                                                    ))
                                                                                                : const SizedBox(),
                                                                                            const SizedBox(
                                                                                              height: 5,
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                                                                              child: Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                                children: [
                                                                                                  InkWell(
                                                                                                      onTap: () {
                                                                                                        launch("tel://${items.phone}");
                                                                                                      },
                                                                                                      child: Image.asset(
                                                                                                        callIcon,
                                                                                                        scale: 3,
                                                                                                      )),
                                                                                                  const SizedBox(
                                                                                                    width: 15,
                                                                                                  ),
                                                                                                  InkWell(
                                                                                                      onTap: () {
                                                                                                        launch('whatsapp://send?phone=${items.phone}');
                                                                                                      },
                                                                                                      child: Image.asset(
                                                                                                        whatsappIcon,
                                                                                                        scale: 3,
                                                                                                      )),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            })
                                                        : const Center(
                                                            child: Text(
                                                                "No More Rejected Registrations",
                                                                style: TextStyle(
                                                                    color:
                                                                        maincolor,
                                                                    fontFamily:
                                                                        "Poppins",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          );
                                              }),
                                              Consumer<LoginProvider>(
                                                  builder: (context, val, _) {
                                                return Consumer<MainProvider>(
                                                    builder: (context4, value3,
                                                        child) {
                                                  return value3.filterOnRejected
                                                      ? value3.filterRejectedLimit >
                                                                  value3
                                                                      .filterRejectedRegisterModelList
                                                                      .length ||
                                                              value3
                                                                  .filterRejectedRegisterModelList
                                                                  .isEmpty
                                                          ? const SizedBox()
                                                          : Center(
                                                              child:
                                                                  LoadMoreButton(
                                                                function: () {
                                                                  value3.filterFetchFunctionsForPending(
                                                                      value3
                                                                          .selectedAreaForFil,
                                                                      false,
                                                                      value3
                                                                          .filterRejectedRegisterModelList[value3.filterRejectedRegisterModelList.length -
                                                                              1]
                                                                          .regDateTime);
                                                                },
                                                              ),
                                                            )
                                                      : value3.rejectedLimit >
                                                                  value3
                                                                      .filterRejectedRegisterModelList
                                                                      .length ||
                                                              value3
                                                                  .filterRejectedRegisterModelList
                                                                  .isEmpty
                                                          ? const SizedBox()
                                                          : Center(
                                                              child:
                                                                  LoadMoreButton(
                                                                function: () {
                                                                  if (widget
                                                                          .type ==
                                                                      "ADMIN") {
                                                                    value3.getRejectedRegistration(
                                                                        false,
                                                                        value3
                                                                            .filterRejectedRegisterModelList[value3.filterRejectedRegisterModelList.length -
                                                                                1]
                                                                            .regDateTime);
                                                                  } else {
                                                                    print(
                                                                        "cvbnmk");
                                                                    value3.getCoordinatorRejectedRegistration(
                                                                        val
                                                                            .loginUserArea,
                                                                        false,
                                                                        value3
                                                                            .filterRejectedRegisterModelList[value3.filterRejectedRegisterModelList.length -
                                                                                1]
                                                                            .regDateTime);
                                                                  }
                                                                },
                                                              ),
                                                            );
                                                });
                                              }),
                                            ],
                                          ),
                                        ),
                                        SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Consumer<MainProvider>(builder:
                                                  (context, coordinatorValue,
                                                      child) {
                                                return Consumer<UserProvider>(
                                                    builder:
                                                        (context, userPro, _) {
                                                  return coordinatorValue
                                                          .loadingTrue
                                                      ? const Column(
                                                          children: [
                                                            SizedBox(
                                                                height: 30),
                                                            CircularProgressIndicator(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                          Color>(
                                                                      maincolor),
                                                            ),
                                                          ],
                                                        )
                                                      : coordinatorValue
                                                              .filterCoordinatorModelList
                                                              .isNotEmpty
                                                          ? ListView.builder(
                                                              itemCount:
                                                                  coordinatorValue
                                                                      .filterCoordinatorModelList
                                                                      .length,
                                                              shrinkWrap: true,
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              physics:
                                                                  const ScrollPhysics(),
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                var items =
                                                                    coordinatorValue
                                                                            .filterCoordinatorModelList[
                                                                        index];
                                                                return Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          8.0,
                                                                      right: 20,
                                                                      left: 23),
                                                                  child:
                                                                      GestureDetector(
                                                                    onLongPress:
                                                                        () {
                                                                      userPro.fileImage=null;
                                                                      if(widget.type=="ADMIN"){
                                                                      deleteAlert(
                                                                          context,
                                                                          items
                                                                              .name,
                                                                          items
                                                                              .id,
                                                                          widget
                                                                              .name,
                                                                          widget
                                                                              .phone,
                                                                          widget
                                                                              .uid);}
                                                                    },
                                                                    onTap: () {
                                                                      if(widget.type=="ADMIN"){
                                                                      userPro.editCoordinator(
                                                                          items
                                                                              .name,
                                                                          items
                                                                              .phone,
                                                                          items
                                                                              .address,
                                                                          items
                                                                              .area,
                                                                          items
                                                                              .areaDistrict,
                                                                          items
                                                                              .image);
                                                                      callNext(
                                                                          AddCordinatorScreen(
                                                                            uid:
                                                                                widget.uid,
                                                                            type:
                                                                                widget.type,
                                                                            name:
                                                                                widget.name,
                                                                            phone:
                                                                                widget.phone,
                                                                            from:
                                                                                'EDIT',
                                                                            coPhone:
                                                                                items.phone,
                                                                            coId:
                                                                                items.id,
                                                                            coArea:
                                                                                items.area,
                                                                          ),
                                                                          context);}
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      clipBehavior:
                                                                          Clip.antiAlias,
                                                                      decoration:
                                                                          ShapeDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20),
                                                                        ),
                                                                        shadows: const [
                                                                          BoxShadow(
                                                                            color:
                                                                                Color(0x0A000000),
                                                                            blurRadius:
                                                                                5.15,
                                                                            offset:
                                                                                Offset(0, 2.58),
                                                                            spreadRadius:
                                                                                0,
                                                                          )
                                                                        ],
                                                                      ),
                                                                      child:
                                                                          ListTile(
                                                                        leading: items.image !=
                                                                                ""
                                                                            ? NetWorkImageStyle(items.image)
                                                                            : Container(
                                                                                width: 50,
                                                                                height: 61,
                                                                                decoration: const BoxDecoration(
                                                                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                                                                ),
                                                                                child: const Icon(Icons.perm_identity_outlined, color: maincolor),
                                                                              ),
                                                                        title:
                                                                            Text(
                                                                          items
                                                                              .name,
                                                                          style:
                                                                              titleStyle,
                                                                        ),
                                                                        subtitle:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(items.phone,
                                                                                style: subtitleStyle),
                                                                            Text(items.area,
                                                                                style: subtitleStyle),
                                                                          ],
                                                                        ),
                                                                        trailing:
                                                                            SizedBox(
                                                                          width:
                                                                              width * .25,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              InkWell(
                                                                                  onTap: () {
                                                                                    launch("tel://${items.phone}");
                                                                                  },
                                                                                  child: Image.asset(
                                                                                    callIcon,
                                                                                    scale: 2.2,
                                                                                  )),
                                                                              SizedBox(
                                                                                width: width * .03,
                                                                              ),
                                                                              InkWell(
                                                                                  onTap: () {
                                                                                    launch('whatsapp://send?phone=${items.phone}');
                                                                                  },
                                                                                  child: Image.asset(
                                                                                    whatsappIcon,
                                                                                    scale: 2.2,
                                                                                  )),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              })
                                                          : const Center(
                                                              child: Text(
                                                                  "No More Coordinators",
                                                                  style: TextStyle(
                                                                      color:
                                                                          maincolor,
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            );
                                                });
                                              }),
                                            ],
                                          ),
                                        ),
                                      ])),
                            ],
                          ),
                        )
                      ]));
                })
              ],
            ),
          ),
          floatingActionButton: indexNew == 3
              ? widget.type == "ADMIN"
                  ? Consumer<UserProvider>(builder: (context, val, _) {
                      return InkWell(
                        onTap: () {
                          val.clearText();
                          callNext(
                              AddCordinatorScreen(
                                uid: widget.uid,
                                type: widget.type,
                                phone: widget.phone,
                                name: widget.name,
                                from: 'NEW',
                                coPhone: '',
                                coId: "",
                                coArea: '',
                              ),
                              context);
                        },
                        child: Container(
                            alignment: Alignment.center,
                            width: 55,
                            height: 55,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              gradient: gradientStyle,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(76),
                              ),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            )),
                      );
                    })
                  : const SizedBox()
              : Consumer<UserProvider>(builder: (context, va, _) {
                  return InkWell(
                    onTap: () {
                      va.clearText();
                      DateTime date = DateTime.now();
                      String id =
                      date.millisecondsSinceEpoch.toString();
                      callNext(
                          RegistrationScreen(
                            name: widget.name,
                            phone: widget.phone,
                            type: widget.type,
                            uid: widget.uid,
                            from: '',
                            proImage: '',
                            id: '', coArea: widget.coArea, coAreaDistrict: widget.coAreaDistrit, idImage: '', docId: id, date: date, status: '',
                          ),
                          context);
                      if(va.alertBool){
                        va.alertBool=false;
                        va.registrationAlert(context,MediaQuery.sizeOf(context));
                      }
                    },
                    child: Container(
                        alignment: Alignment.center,
                        width: 55,
                        height: 55,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          gradient: gradientStyle,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(76),
                          ),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        )),
                  );
                }),
        ),
      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            scrollable: true,
            title: const Text(
              "Do you want to exit?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            content: Consumer<MainProvider>(builder: (context, value, child) {
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
                              exit(0);
                            }),
                      ),
                    ],
                  ),
                ],
              );
            }),
          );
        });
  }

  deleteAlert(BuildContext context, String coName, String coID, String adName,
      String adPhone, String adId) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      scrollable: true,
      title: Text(
        "Do you want Delete $coName",
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
                        value.deleteAdmin(coID, adName, adId, adPhone);
                        finish(context);
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

class LoadMoreButton extends StatelessWidget {
  const LoadMoreButton({
    super.key,
    required this.function,
  });

  final Function() function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        width: 100,
          height: 35,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: maincolor),
          alignment: Alignment.center,
          child: const Text(
            "Load More",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 11),
          )),
    );
  }
}

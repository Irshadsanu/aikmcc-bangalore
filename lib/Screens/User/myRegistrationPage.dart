import 'package:aikmccbangalore/Constant/my_colors.dart';
import 'package:aikmccbangalore/Provider/UserProvider.dart';
import 'package:aikmccbangalore/Screens/User/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constant/images.dart';
import '../../Constant/my_functions.dart';
import '../../Constant/widgets.dart';
import '../../Models/RequestMemberModel.dart';
import 'Share Id card.dart';

class MyRegistration extends StatelessWidget {
  const MyRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Consumer<UserProvider>(
        builder: (context,va,_) {
          return InkWell(
            onTap: () {
              DateTime date = DateTime.now();
              String id =
              date.millisecondsSinceEpoch.toString();
              va.    fileImage = null;
              va.    fileProof = null;
va.clearText();
              callNext(
                  RegistrationScreen(
                    uid: '',
                    type: "",
                    phone: "",
                    name: "",
                    from: '',
                    proImage: '',
                    id: '', coArea: '', coAreaDistrict: '', idImage: '', docId: id, date: date, status: '',
                  ),
                  context);
              if(va.alertBool){
                va.alertBool=false;
                va.registrationAlert(context,MediaQuery.sizeOf(context));
              }
            },
            child: const CircleAvatar(
              backgroundColor: maincolor,
              radius: 30,
              child: Icon(Icons.add, color: Colors.white),
            ),
          );
        }
      ),
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar(head: "My Registrations")),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 60,
            width: width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(appBarBG), fit: BoxFit.cover),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Total Registrations",
                  style: TextStyle(
                    color: Color(0xFFF7F7F7),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Consumer<UserProvider>(builder: (context, va, _) {
                  return Text(
                    "${va.allMyRegistrations.length}",
                    style: const TextStyle(
                      color: Color(0xFFF7F7F7),
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 60,
            width: width,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x26000000).withOpacity(.08),
                    blurRadius: 2.0, // soften the shadow
                    spreadRadius: 1.0, //extend the shadow
                  ),
                ],
                // image: DecorationImage(image: AssetImage(appBarBG),fit: BoxFit.cover),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: Center(
              child: Consumer<UserProvider>(builder: (context, val, _) {
                return TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    suffixIcon:
                        Icon(Icons.search, color: Colors.black, size: 22),
                    // contentPadding: EdgeInsets.only(bottom: 1),
                    hintText: 'Search here',
                    hintStyle: TextStyle(
                      color: Color(0xFFB1B1B1),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0.14,
                    ),
                    border: InputBorder.none,
                  ),
                  onChanged: (text) {
                    val.filterRegisteredUsers(text);
                  },
                );
              }),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Consumer<UserProvider>(builder: (context, val1, _) {
                return val1.filterAllMyRegistrations.isNotEmpty
                    ? ListView.builder(
                        itemCount: val1.filterAllMyRegistrations.length,
                        itemBuilder: (context, index) {
                          RequestMemberModel item =
                              val1.filterAllMyRegistrations[index];
                          return Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (item.status == "PENDING" ||
                                      item.status == "CO-APPROVED") {
                                    callNext(
                                        ShareIdCard(
                                            image: item.image,
                                            phone: item.phone,
                                            name: item.name),
                                        context);
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 2),
                                  width: width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0x26000000)
                                            .withOpacity(.08),
                                        blurRadius: 2.0, // soften the shadow
                                        spreadRadius: 1.0, //extend the shadow
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 28),
                                        child: SizedBox(
                                          width: width * .22,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          item.image,
                                                        ),
                                                        fit: BoxFit.fill)),
                                              ),
                                              item.status == "PENDING"
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              7.0),
                                                      child: Image.asset(
                                                        pendingIcon,
                                                        scale: 3.3,
                                                      ),
                                                    )
                                                  : item.status == "CO-APPROVED"
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(7.0),
                                                          child: Image.asset(
                                                            pendingIcon,
                                                            scale: 3.3,
                                                          ),
                                                        )
                                                      : item.status ==
                                                              "APPROVED"
                                                          ? const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(7.0),
                                                              child: Icon(
                                                                Icons.check,
                                                                color: Colors
                                                                    .green,
                                                                size: 15,
                                                              ))
                                                          : const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(7.0),
                                                              child: Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                                size: 15,
                                                              )),
                                              Text(
                                                item.status == "CO-APPROVED"
                                                    ? "PENDING"
                                                    : item.status ==
                                                            "CO-REJECTED"
                                                        ? "REJECTED"
                                                        : item.status,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  color: item.status ==
                                                          "PENDING"
                                                      ? const Color(0xFF2DC0FF)
                                                      : item.status ==
                                                              "CO-APPROVED"
                                                          ? const Color(
                                                              0xFF2DC0FF)
                                                          : item.status ==
                                                                  "APPROVED"
                                                              ? const Color(
                                                                  0xFF02AD47)
                                                              : const Color(
                                                                  0xFFD00000),
                                                  fontSize: 11,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 13.0,
                                            top: 10,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  //Name
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: width / 4.5,
                                                        child: Text(
                                                          'Name',
                                                          style: nameTextStyle,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: width / 25,
                                                          child: Text(
                                                            ':',
                                                            style:
                                                                textTextStyle,
                                                          )),
                                                      SizedBox(
                                                        width: width / 2.9,
                                                        child: Text(item.name,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 11,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              // height: 0.15,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                  // mobile

                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: width / 4.5,
                                                        child: Text(
                                                          'Mobile',
                                                          style: nameTextStyle,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: width / 25,
                                                          child: Text(
                                                            ':',
                                                            style:
                                                                textTextStyle,
                                                          )),
                                                      SizedBox(
                                                        width: width / 2.9,
                                                        child: Row(
                                                          children: [
                                                            Text(item.phone,
                                                                style:
                                                                    textTextStyle),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  //age
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: width / 4.5,
                                                        child: Text(
                                                          'Age',
                                                          style: nameTextStyle,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: width / 25,
                                                          child: Text(
                                                            ':',
                                                            style:
                                                                textTextStyle,
                                                          )),
                                                      SizedBox(
                                                        width: width / 2.9,
                                                        child: Text(
                                                          item.age,
                                                          style: textTextStyle,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  //area
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: width / 4.5,
                                                        child: Text(
                                                          'Area',
                                                          style: nameTextStyle,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: width / 25,
                                                          child: Text(
                                                            ':',
                                                            style:
                                                                textTextStyle,
                                                          )),
                                                      SizedBox(
                                                        width: width / 2.9,
                                                        child: Text(
                                                          item.area,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: textTextStyle,
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  //address
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: width / 4.5,
                                                        child: Text(
                                                          'Address',
                                                          style: nameTextStyle,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: width / 25,
                                                          child: Text(
                                                            ':',
                                                            style:
                                                                textTextStyle,
                                                          )),
                                                      SizedBox(
                                                        // color: Colors.red,
                                                        width: width / 3.4,
                                                        child: Text(
                                                          item.address,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: textTextStyle,
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  // home address
                                                  // Row(
                                                  //   crossAxisAlignment:
                                                  //       CrossAxisAlignment.start,
                                                  //   children: [
                                                  //     SizedBox(
                                                  //       width: width / 4.5,
                                                  //       child: Text(
                                                  //         'Home Address',
                                                  //         style: nameTextStyle,
                                                  //       ),
                                                  //     ),
                                                  //     SizedBox(
                                                  //         width: width / 25,
                                                  //         child: Text(
                                                  //           ':',
                                                  //           style: textTextStyle,
                                                  //         )),
                                                  //     SizedBox(
                                                  //       width: width / 2.9,
                                                  //       child: Text(
                                                  //         "addres",
                                                  //         maxLines: 2,
                                                  //         overflow: TextOverflow.ellipsis,
                                                  //         style: textTextStyle,
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  // blood
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: width / 4.5,
                                                        child: Text(
                                                          'Blood Group',
                                                          style: nameTextStyle,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: width / 25,
                                                          child: Text(
                                                            ':',
                                                            style:
                                                                textTextStyle,
                                                          )),
                                                      SizedBox(
                                                        width: width / 2.9,
                                                        child: Text(
                                                          item.bloodGroup,
                                                          style: textTextStyle,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  // occupation
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: width / 4.5,
                                                        child: Text(
                                                          'Occupation',
                                                          style: nameTextStyle,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: width / 25,
                                                          child: Text(
                                                            ':',
                                                            style:
                                                                textTextStyle,
                                                          )),
                                                      SizedBox(
                                                        width: width / 2.9,
                                                        child: Text(
                                                          item.occupation,
                                                          style: textTextStyle,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: 10,
                                  top: 10,
                                  child: Consumer<UserProvider>(
                                    builder: (context,userPro,_) {
                                      return item.status!="APPROVED"? GestureDetector(
                                        onTap: (){
                                          userPro. fileImage = null;
                                          userPro. fileProof = null;
                                          DateTime date = DateTime.now();
                                          String id =
                                          date.millisecondsSinceEpoch.toString();
                                          userPro.editRegister(
                                              item.name,
                                              item.phone,
                                              item.address,
                                              item.area,
                                              item.gender,
                                              item.dob,
                                              item.aadhaar,
                                              item.fullAddress,
                                              item.ward,
                                              item.bloodGroup,
                                              item.occupation,
                                              item.age,
                                              item.seconderyNumber,item.panchayath,
                                              item.district,item.assembly,item.areaDistrict,
                                            item.proofName,item.fetchProofImage,item.proofNumber
                                          );
                                          callNext(
                                              RegistrationScreen(
                                                uid: "SELF",
                                                type: "SELF",
                                                name: "SELF",
                                                phone: "SELF",
                                                from: 'EDIT', proImage: item.image, id: item.id, coArea: "", coAreaDistrict: '', idImage: item.fetchProofImage, docId: id, date: date, status: item.status,
                                              ),
                                              context);

                                        },
                                        child: CircleAvatar(
                                          radius: 17,
                                          backgroundColor: Colors.grey.shade200,
                                            child: const Icon(Icons.edit_outlined,size: 19,)),
                                      ):SizedBox();
                                    }
                                  ))
                            ],
                          );
                        },
                      )
                    : const Center(child: Text("No Registration Yet"));
              }),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:aikmccbangalore/Constant/my_functions.dart';
import 'package:aikmccbangalore/Provider/UserProvider.dart';
import 'package:aikmccbangalore/Provider/mainprovider.dart';
import 'package:aikmccbangalore/Screens/User/loding_Screnn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import '../../Constant/my_colors.dart';
import '../../Constant/widgets.dart';
import '../../Models/unitModel.dart';
import '../../Provider/LoginProvider.dart';
import 'RegistrationSuccessPage.dart';
import 'consentScreen.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen(
      {super.key,
      required this.uid,
      required this.type,
      required this.name,
      required this.phone,
      required this.from,
      required this.coArea,
      required this.coAreaDistrict,
      required this.proImage,
      required this.id, required this.idImage, required this.docId, required this.date, required this.status});

  final String uid;
  final String coArea;
  final String coAreaDistrict;
  final String type;
  final String name;
  final String phone;
  final String from;
  final String proImage;
  final String idImage;
  final String id;
  final String docId;
  final DateTime date;
  final String status;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    userProvider.buttonShow = true;
    userProvider.fullAddressChecked = false;

    // userProvider.fetchWard();
    // userProvider.fetchAllWards();
    // userProvider.fetchAllArea();

    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: CustomAppBar(
                head: "Registration Form",
              )),
          body: Form(
            key: _formKey,
            child: SizedBox(
              width: width,
              height: height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Consumer<UserProvider>(builder: (context, val0, _) {
                      return GestureDetector(
                        onTap: () {
                          if(from=="EDIT"){
                            val0.showBottomSheet(context, "",id);
                          }
                          else{
                            val0.showBottomSheet(context, "",docId);

                          }
                          // val0.showBottomSheet(context, "",docId);
                        },
                        child: val0.fileImage != null
                            ? Container(
                                width: width / 4.415730337078652,
                                height: height / 9.382022471910112,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24.27),
                                  image: DecorationImage(
                                      image: FileImage(val0.fileImage!),
                                      fit: BoxFit.fill),
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
                            : proImage != ""
                                ? Container(
                                    width: width / 4.415730337078652,
                                    height: height / 9.382022471910112,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(24.27),
                                      image: DecorationImage(
                                          image: NetworkImage(proImage),
                                          fit: BoxFit.fill),
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
                                    width: width / 4.415730337078652,
                                    height: height / 9.382022471910112,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Color(0xFFEDEDED)),
                                        borderRadius:
                                            BorderRadius.circular(24.27),
                                      ),
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0x19000000),
                                          blurRadius: 4,
                                          offset: Offset(0, 4),
                                          spreadRadius: -3,
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.perm_identity_rounded,
                                          color: Colors.black.withOpacity(.50),
                                          size: width / 13.1,
                                        ),
                                        Text(
                                          'Add photo',
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(.50),
                                            fontSize: width / 39.3,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                      );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Consumer<UserProvider>(
                              builder: (context, userPro, _) {
                            return RegisterTextField(
                              hint: 'Name*',
                              controller: userPro.nameTC,
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          Consumer<UserProvider>(
                              builder: (context, userPro, _) {
                            return NumberTextForm(
                              from: from,
                              controller: userPro.phoneTC,
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          Consumer<UserProvider>(builder: (context, userPr, _) {
                            return SecondaryNumberTextForm(
                              controller: userPr.optionalPhoneTC,
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          Consumer<UserProvider>(
                              builder: (context, userPro9, _) {
                            return CustomAutoCompleateForm(
                              controller: userPro9.genderController,
                              image:
                                  "assets/images/male_FILL0_wght400_GRAD0_opsz24 2.png",
                              hint: "Gender*",
                              list: userPro9.genderList,
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          Consumer<UserProvider>(builder: (context, val, _) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: InkWell(
                                    onTap: () {
                                      _selectDate(context);

                                      // donationProvider.dateWiseFeedBackReport(context,"Age");
                                    },
                                    child: Consumer<UserProvider>(
                                        builder: (context, value, child) {
                                      return TextFormField(
                                        enabled: false,
                                        textAlign: TextAlign.left,
                                        controller: value.dateOfBirthController,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 17),
                                        decoration: InputDecoration(
                                          prefixIcon: Image.asset(
                                            "assets/images/calendar_month_FILL0_wght300_GRAD0_opsz24 1.png",
                                            scale: 2.3,
                                          ),
                                          fillColor: const Color(0xFFF6F6F6),
                                          filled: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 0),
                                          hintText: 'Date of Birth*',
                                          // labelText: "Date of Birth",
                                          label: const Padding(
                                            padding: EdgeInsets.only(
                                              left: 15.0,
                                            ),
                                            child: Text("Date of Birth*",
                                                style: TextStyle(
                                                    color: maincolor)),
                                          ),
                                          hintStyle: hintStyle,
                                          labelStyle: hintStyle,
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Select Date Of Birth';
                                          }

                                          return null;
                                        },
                                      );
                                    }),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Consumer<UserProvider>(
                                      builder: (context, value, child) {
                                    return TextFormField(
                                      textAlign: TextAlign.center,
                                      controller: value.ageController,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontFamily: "Poppins"),
                                      decoration: InputDecoration(
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        enabled: false,
                                        fillColor: const Color(0xFFF6F6F6),
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 10),
                                        hintText: 'Age*',
                                        hintStyle: hintStyle,
                                        labelStyle: hintStyle,
                                        label: const Padding(
                                          padding: EdgeInsets.only(
                                            left: 15.0,
                                          ),
                                          child: Text("Age*",
                                              style:
                                                  TextStyle(color: maincolor)),
                                        ),
                                        // labelText: "Age",
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      // validator: (value) {
                                      //   if (value!.isEmpty) {
                                      //     return 'Enter Age';
                                      //   }
                                      //
                                      //   return null;
                                      // },
                                    );
                                  }),
                                ),
                              ],
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),

                          Consumer<UserProvider>(
                              builder: (context, val54, child) {
                                print(status);
                                print(type);
                                print(from);
                            return from=="EDIT"&&type=="SELF"&&status!="PENDING"?const SizedBox():

                            Container(
                              height: 45,
                              width: width,
                              padding: const EdgeInsets.only(
                                left: 13,
                              ),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF6F6F6),
                                  borderRadius: BorderRadius.circular(21)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Row(children: [ Image.asset(
                                    "assets/images/data_info_alert_FILL0_wght300_GRAD0_opsz24 1.png",
                                    scale: 2,
                                  ),
                                  ],)),

                                  Expanded(
                                    flex: 8,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: DropdownButton<String>(
                                        underline: const SizedBox(),
                                        icon:SizedBox(
                                            width: width/2.8,
                                            child: const Align(
                                                alignment: Alignment.centerRight,
                                                child: Icon(Icons.keyboard_arrow_down_outlined))),
                                        elevation: 0,
                                        style: hintStyle,
                                        value: val54.selectedProof,
                                        onChanged: (String? newValue) {
                                          val54.proofValue(newValue!);
                                        },
                                        items: val54.proof.map((String item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily: "Poppins"),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  // GestureDetector(
                                  //     onTap: () {
                                  //       if (val54.fileProof == null) {
                                  //         val54.showBottomSheet(
                                  //             context, "PROOF");
                                  //       } else {
                                  //         _showBlankAlertDialog(context, width);
                                  //       }
                                  //     },
                                  //     child: val54.fileProof == null
                                  //         ? const Icon(
                                  //             Icons
                                  //                 .add_photo_alternate_outlined,
                                  //             size: 19,
                                  //           )
                                  //         : Padding(
                                  //             padding:
                                  //                 const EdgeInsets.all(8.0),
                                  //             child: ClipRRect(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(8),
                                  //                 child: Container(
                                  //                   width: 35,
                                  //                   decoration: BoxDecoration(
                                  //                       image: DecorationImage(
                                  //                           image: FileImage(
                                  //                               val54
                                  //                                   .fileProof!),
                                  //                           fit: BoxFit.fill)),
                                  //                   // child: Image.file(val54.fileProof!)
                                  //                 )),
                                  //           )),
                                ],
                              ),
                            );
                          }),
                          from=="EDIT"&&type=="SELF"&&status!="PENDING"?const SizedBox(): const SizedBox(
                            height: 20,
                          ),
                          Consumer<UserProvider>(builder: (context, userPr, _) {
                            return from=="EDIT"&&type=="SELF"&&status!="PENDING"?const SizedBox(): AadharTextForm(
                              controller: userPr.aadhaarNumberController,
                            );
                          }),
                          Consumer<UserProvider>(
                              builder: (context22, value58, child) {
                                return from=="EDIT"&&type=="SELF"&&status!="PENDING"?const SizedBox(): const SizedBox(height: 20);
                              }),
                          Consumer<UserProvider>(builder: (context, va87, _) {
                            return from=="EDIT"&&type=="SELF"&&status!="PENDING"?const SizedBox():va87.selectedProof!="Select Your Proof" ?Container(
                              height: 45,
                              width: width,
                              padding: const EdgeInsets.only(
                                left: 13,
                              ),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF6F6F6),
                                  borderRadius: BorderRadius.circular(21)),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: InkWell(
                                      onTap: () {
                                        if(from=="EDIT"){
                                        va87.showBottomSheet(context, "PROOF",id);
                                        }
                                        else{
                                          va87.showBottomSheet(context, "PROOF",docId);

                                        }
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.add_photo_alternate_outlined,
                                            size: 19,
                                            color: Colors.green,
                                          ),
                                          const SizedBox(
                                            width: 22,
                                          ),
                                  Text(
                                            va87.fileProof==null&&idImage==""?  "Proof Image":"Uploaded",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontFamily: "Poppins"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: InkWell(

                                          child:va87.fileProof==null?InkWell(
                                            onTap: () {
                                              if(from=="EDIT"){
                                                va87.showBottomSheet(context, "PROOF",id);
                                              }
                                              else{
                                                va87.showBottomSheet(context, "PROOF",docId);

                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.all(8),
                                              padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(21),color: Colors.green),
                                                child: const Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text("Upload",style: TextStyle(color: Colors.white,fontSize: 12)),
                                                    Icon(Icons.upload,color: Colors.white,size: 15,),
                                                  ],
                                                )),
                                          ): InkWell(
                                              onTap: (){
                                                va87.setContainerSize();
                                              },
                                              child: SizedBox(child: Icon(va87.containerHeight?Icons.keyboard_arrow_up_outlined:Icons.keyboard_arrow_down_outlined)))))
                                ],
                              ),
                            ):const SizedBox();
                          }),


                          Consumer<UserProvider>(
                            builder: (context,model,_) {
                              return from=="EDIT"&&type=="SELF"&&status!="PENDING"?const SizedBox(): model.fileProof!=null&&model.containerHeight?
                              AnimatedContainer(
                                height: !model.containerHeight?0:150,
                                // color: Colors.blue,
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInOut,
                                decoration: BoxDecoration(image: DecorationImage(image: FileImage(model.fileProof!),fit: BoxFit.contain)),
                              )
                                  :from=="EDIT"&&idImage!=""?Container(
                                margin: const EdgeInsets.only(top: 5,bottom: 5),
                                height: 150,
                                decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(idImage),fit: BoxFit.contain)),

                              ):const SizedBox();
                            }
                          ),

                          Consumer<UserProvider>(
                              builder: (context22, value58, child) {
                                return  SizedBox(height:value58.aadhaarNumberController.text!=""? 20:0);
                              }),
                          type != "COORDINATOR"
                              ? Consumer<UserProvider>(
                                  builder: (context22, value56, child) {
                                  return value56.aadhaarNumberController.text!=""? Autocomplete<AreaModel>(
                                    optionsBuilder:
                                        (TextEditingValue textEditingValue) {
                                      return (value56.areaAllList)
                                          .where((AreaModel areas) =>
                                              areas.area.toLowerCase().contains(
                                                  textEditingValue.text
                                                      .toLowerCase()) ||
                                              areas.district
                                                  .toLowerCase()
                                                  .contains(textEditingValue
                                                      .text
                                                      .toLowerCase()))
                                          .toList();
                                    },
                                    displayStringForOption:
                                        (AreaModel option) => option.area,
                                    fieldViewBuilder: (BuildContext context,
                                        TextEditingController
                                            fieldTextEditingController,
                                        FocusNode fieldFocusNode,
                                        VoidCallback onFieldSubmitted) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        fieldTextEditingController.text =
                                            value56.areaController.text;
                                      });
                                      return TextFormField(
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10),
                                          hintText: 'Area*',
                                          prefixIcon: Image.asset(
                                            "assets/images/diversity_2_FILL0_wght300_GRAD0_opsz24 (1) 1.png",
                                            scale: 2.3,
                                          ),
                                          suffixIcon: const Icon(
                                            Icons.keyboard_arrow_down_sharp,
                                            size: 20,
                                            color: Colors.black38,
                                          ),
                                          label: const Padding(
                                            padding: EdgeInsets.only(
                                              left: 15.0,
                                            ),
                                            child: Text("Area*",
                                                style: TextStyle(
                                                    color: maincolor)),
                                          ),
                                          // labelText: "Area",
                                          hintStyle: hintStyle,
                                          labelStyle: hintStyle,
                                          filled: true,
                                          fillColor: const Color(0xFFF6F6F6),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        validator: (name) => name == '' ||
                                                !(value56.areaBaseList +
                                                        value56.areaJsonList)
                                                    .map((e) => e.area)
                                                    .contains(name)
                                            ? 'Enter Valid Area Name'
                                            : null,
                                        controller: fieldTextEditingController,
                                        focusNode: fieldFocusNode,
                                        // style: const TextStyle(fontWeight: FontWeight.bold),
                                      );
                                    },
                                    onSelected: (AreaModel selection) {
                                      value56.areaController.text =
                                          selection.area;

                                      value56.selectPinArea(selection,
                                          selection.area, selection.district);
                                    },
                                    optionsViewBuilder: (BuildContext context,
                                        AutocompleteOnSelected<AreaModel>
                                            onSelected,
                                        Iterable<AreaModel> options) {
                                      return Align(
                                        alignment: Alignment.topLeft,
                                        child: Material(
                                          child: Container(
                                            // width: MediaQuery.of(context).size.width / 1.5,
                                            height: 200,
                                            color: Colors.white,
                                            child: ListView.builder(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              itemCount: options.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                final AreaModel option =
                                                    options.elementAt(index);

                                                return GestureDetector(
                                                  onTap: () {
                                                    onSelected(option);
                                                  },
                                                  child: Container(
                                                    // height: 60,
                                                    color: Colors.white,
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(option.area,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          Text(option.district),
                                                          const SizedBox(
                                                              height: 10)
                                                        ]),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ):const SizedBox();
                                })
                              : const SizedBox(),
                          Consumer<UserProvider>(
                            builder: (context,val678,_) {
                              return SizedBox(
                                height: type != "COORDINATOR"&&val678.areaController.text!="" ? 20 : 0,
                              );
                            }
                          ),
                          Consumer<UserProvider>(
                              builder: (context, userPro, _) {
                            return userPro.areaController.text!=""||type == "COORDINATOR"&&userPro.aadhaarNumberController.text!=""?
                                RegisterTextField(
                              hint: 'Present Address* (BENGALURU)',
                              controller: userPro.userAddress,
                            ):const SizedBox();
                          }),
                          // Consumer<UserProvider>(
                          //   builder: (context, checkboxProvider, child) {
                          //     return Row(
                          //       children: [
                          //         Checkbox(
                          //           materialTapTargetSize:
                          //               MaterialTapTargetSize.shrinkWrap,
                          //           value: checkboxProvider.isChecked,
                          //           onChanged: (newValue) {
                          //             checkboxProvider.toggleCheckbox();
                          //           },
                          //           activeColor: Colors.green,
                          //         ),
                          //         Text(
                          //           "Same as Above",
                          //           style: hintStyle,
                          //         ),
                          //       ],
                          //     );
                          //   },
                          // ),
                          Consumer<UserProvider>(
                              builder: (context22, value58, child) {
                                return  SizedBox(height:value58.userAddress.text!=""? 20:0);
                              }),
                          Consumer<UserProvider>(
                              builder: (context, userPro99, _) {
                            return userPro99.userAddress.text!=""? RegisterTextField(
                              hint: 'Permanent Address*',
                              controller: userPro99.userFullAddress,
                            ):const SizedBox();
                          }),
                          Consumer<UserProvider>(
                              builder: (context22, value58, child) {
                            return  SizedBox(height:value58.userFullAddress.text!=""? 20:0);
                          }),
                          Consumer<UserProvider>(
                              builder: (context3, value, child) {
                            return value.userFullAddress.text != ""
                                ? Autocomplete<PanjayathModel>(
                                    optionsBuilder:
                                        (TextEditingValue textEditingValue) {
                                      return (value.panjayathList)
                                          .where((PanjayathModel wardd) => wardd
                                              .panjayath
                                              .toLowerCase()
                                              .contains(textEditingValue.text
                                                  .toLowerCase()))
                                          .toList();
                                    },
                                    displayStringForOption:
                                        (PanjayathModel option) =>
                                            option.panjayath,
                                    fieldViewBuilder: (BuildContext context,
                                        TextEditingController
                                            fieldTextEditingController,
                                        FocusNode fieldFocusNode,
                                        VoidCallback onFieldSubmitted) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        fieldTextEditingController.text =
                                            value.panchayathTc.text;
                                      });
                                      return TextFormField(
                                        // onChanged: ,
                                        scrollPadding:
                                            const EdgeInsets.only(bottom: 500),
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10),
                                          hintText: 'Select Panchayath*',
                                          prefixIcon: Image.asset(
                                            "assets/images/matter_FILL0_wght300_GRAD0_opsz24 1.png",
                                            scale: 2.3,
                                          ),
                                          suffixIcon: const Icon(
                                            Icons.keyboard_arrow_down_sharp,
                                            size: 20,
                                            color: Colors.black38,
                                          ),
                                          label: const Padding(
                                            padding: EdgeInsets.only(
                                              left: 15.0,
                                            ),
                                            child: Text('Select Panchayath*',
                                                style: TextStyle(
                                                    color: maincolor)),
                                          ),
                                          // labelText: "Home Address",
                                          hintStyle: hintStyle,
                                          labelStyle: hintStyle,
                                          filled: true,
                                          fillColor: const Color(0xFFF6F6F6),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        controller: fieldTextEditingController,
                                        focusNode: fieldFocusNode,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: maincolor,
                                            fontSize: 16),
                                        // validator: (text) => value.assemblyList.map((e) => e.assembly.contains(text)) ? "Please Select Your Assembly" : null,
                                        validator: (value2) {
                                          if (value2!.trim().isEmpty ||
                                              !value.panjayathList
                                                  .map((item) => item.panjayath)
                                                  .contains(value2)) {
                                            return "Please Select Your Panchayath";
                                          } else {
                                            return null;
                                          }
                                        },
                                      );
                                    },
                                    onSelected: (PanjayathModel selection) {
                                      value.setPanchFun(selection.panjayath);
                                      value.panchayathTc.text =
                                          selection.panjayath;
                                      value.districtTc.text =
                                          selection.district;

                                      value.fetchSelectedUnits(
                                          selection.district,
                                          selection.panjayath);
                                    },
                                    optionsViewBuilder: (BuildContext context,
                                        AutocompleteOnSelected<PanjayathModel>
                                            onSelected,
                                        Iterable<PanjayathModel> options) {
                                      return Align(
                                        alignment: Alignment.topLeft,
                                        child: Material(
                                          child: Container(
                                            width: width - 30,
                                            height: 400,
                                            color: Colors.white,
                                            child: ListView.builder(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              itemCount: options.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                final PanjayathModel option =
                                                    options.elementAt(index);

                                                return GestureDetector(
                                                  onTap: () {
                                                    onSelected(option);
                                                  },
                                                  child: Container(
                                                    color: Colors.white,
                                                    // height: 50,
                                                    width: width - 30,
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(option.panjayath,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          Text(
                                                            option.district,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                          const SizedBox(
                                                              height: 10)
                                                        ]),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : const SizedBox();
                          }),
                          Consumer<UserProvider>(
                              builder: (context, userPro49, _) {
                            return SizedBox(
                              height:
                                  userPro49.panchayathTc.text != "" ? 20 : 0,
                            );
                          }),

                          Consumer<UserProvider>(
                              builder: (context22, value55, child) {
                            return value55.panchayathTc.text != ""
                                ? Autocomplete<WardModel>(
                                    optionsBuilder:
                                        (TextEditingValue textEditingValue) {
                                      // return (value55.allWards)
                                      return (value55.allWards)
                                          .where((WardModel wardd) =>
                                              wardd.wardName
                                                  .toLowerCase()
                                                  .contains(textEditingValue
                                                      .text
                                                      .toLowerCase()) ||
                                              wardd.panchayath
                                                  .toLowerCase()
                                                  .contains(textEditingValue
                                                      .text
                                                      .toLowerCase()))
                                          .toList();
                                    },
                                    displayStringForOption:
                                        (WardModel option) => option.wardName,
                                    fieldViewBuilder: (BuildContext context,
                                        TextEditingController
                                            fieldTextEditingController,
                                        FocusNode fieldFocusNode,
                                        VoidCallback onFieldSubmitted) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        fieldTextEditingController.text =
                                            value55.pinWardTC.text;
                                      });
                                      return TextFormField(
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10),
                                          hintText: 'Select Ward*(Kerala)',
                                          prefixIcon: Image.asset(
                                            "assets/images/home_pin_FILL0_wght300_GRAD0_opsz24 1.png",
                                            scale: 2.3,
                                          ),
                                          suffixIcon: const Icon(
                                            Icons.keyboard_arrow_down_sharp,
                                            size: 20,
                                            color: Colors.black38,
                                          ),
                                          label: const Padding(
                                            padding: EdgeInsets.only(
                                              left: 15.0,
                                            ),
                                            child: Text('Select Ward*(Kerala)',
                                                style: TextStyle(
                                                    color: maincolor)),
                                          ),
                                          // labelText: "Home Address",
                                          hintStyle: hintStyle,
                                          labelStyle: hintStyle,
                                          filled: true,
                                          fillColor: const Color(0xFFF6F6F6),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        validator: (name) => name == '' ||
                                                !(value55.allWards)
                                                    .map((e) => e.wardName)
                                                    .contains(name)
                                            ? 'Please Enter Valid Ward Name'
                                            : null,
                                        controller: fieldTextEditingController,
                                        focusNode: fieldFocusNode,
                                        // style: const TextStyle(fontWeight: FontWeight.bold),
                                      );
                                    },
                                    onSelected: (WardModel selection) {
                                      // value55.
                                      value55.pinWardTC.text =
                                          selection.wardName;

                                      value55.selectPinWard(selection);
                                    },
                                    optionsViewBuilder: (BuildContext context,
                                        AutocompleteOnSelected<WardModel>
                                            onSelected,
                                        Iterable<WardModel> options) {
                                      return Align(
                                        alignment: Alignment.topLeft,
                                        child: Material(
                                          child: Container(
                                            // width: MediaQuery.of(context).size.width / 1.5,
                                            height: 200,
                                            color: Colors.white,
                                            child: ListView.builder(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              itemCount: options.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                final WardModel option =
                                                    options.elementAt(index);

                                                return GestureDetector(
                                                  onTap: () {
                                                    onSelected(option);
                                                  },
                                                  child: Container(
                                                    // height: 60,
                                                    color: Colors.white,
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(option.wardName,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          Text(option
                                                                      .panchayath
                                                                      .contains(
                                                                          "MUNICIPALITY") ||
                                                                  option
                                                                      .panchayath
                                                                      .contains(
                                                                          "PANCHAYATH") ||
                                                                  option
                                                                      .panchayath
                                                                      .contains(
                                                                          "CORPORATION")
                                                              ? option
                                                                  .panchayath
                                                              : "${option.panchayath} PANCHAYATH"),
                                                          const SizedBox(
                                                              height: 10)
                                                        ]),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : const SizedBox();
                          }),
                          Consumer<UserProvider>(
                              builder: (context, userPro49, _) {
                            return SizedBox(
                              height:userPro49.panchayathTc.text!=""?20:20
                                  // userPro49.panchayathTc.text != "" ? 20 : 0,
                            );
                          }),

                          Consumer<UserProvider>(
                              builder: (context, userPro3, _) {
                            return CustomAutoCompleateForm(
                              controller: userPro3.bloodGroupController,
                              image:
                                  "assets/images/bloodtype_FILL0_wght300_GRAD0_opsz24 1.png",
                              hint: "Blood Group*",
                              list: userPro3.bloodGroupsList,
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          Consumer<UserProvider>(
                              builder: (context, userPro3, _) {
                            return CustomAutoCompleateForm(
                              controller: userPro3.occupationController,
                              image:
                                  "assets/images/school_FILL0_wght300_GRAD0_opsz24 1.png",
                              hint: "Occupation/Job*",
                              list: userPro3.occupationList,
                            );
                          }),
                          const SizedBox(
                            height: 180,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton:
              Consumer<UserProvider>(builder: (context, value45, _) {
            return value45.buttonShow
                ? CustomFlotingButton(
                    width: width,
                    text: "Submit",
                    onTap: () async {
                      final FormState? form = _formKey.currentState;
                      if (from != "EDIT") {
                        if (form!.validate()) {
                          if (value45.selectedProof != "Select Your Proof") {
                            if (value45.fileImage != null) {
                              if (value45.fileProof != null) {
                                bool checkPhoneNumber = false;
                                checkPhoneNumber = await value45
                                    .checkNumberExist(value45.phoneTC.text);
                                // value45.loaderDialogNormal(context);
                                if (!checkPhoneNumber) {


                                  value45.showButton();
                                  callNext(
                                      ConsentScreen(
                                        uid: uid,
                                        type: type,
                                        name: name,
                                        phone: phone,
                                        date: date,
                                        docId: docId,
                                        coArea: coArea,
                                        coAreaDistrict: coAreaDistrict,
                                      ),
                                      context);

                                  value45.addRegisterUser(
                                      context,
                                      uid,
                                      type,
                                      name,
                                      phone,
                                      coArea,
                                      date,
                                      docId,
                                      coAreaDistrict);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor: Colors.black,
                                          content:
                                              Text("Number Already Exist")));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.black,
                                        content: Text("Please Upload Proof Photo")));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.black,
                                      content: Text("Please Upload Photo")));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.black,
                                    content: Text("Please Select Your Proof")));
                          }
                        }
                      } else {
                        if (form!.validate()) {
// if(){
                          print(type);
                          print("dfghjkiokjhghcvbnmyughjb");
                          if(value45.selectedProof!="Select Your Proof"){
                            if(idImage!=""||value45.fileProof!=null){
                            value45.loaderDialogNormal(context);

                            value45.editRegisterUser(
                              context,
                              id,
                              uid,
                              type,
                              name,
                              phone,
                              value45.phoneTC.text,
                              value45.areaController.text,
                              value45.areaDistrictController.text,
                              value45.pinWardTC.text,
                              proImage,
                              value45.districtTc.text,
                              value45.panchayathTc.text,
                              value45.assemblyTc.text,
                              coArea,
                          idImage,
                            value45.selectedProof,

                          );}else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.black,
                                      content: Text("Upload Your Proof Photo")));
                            }}else{
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.black,
                                    content: Text("Please Select Your Proof")));
                          }
                        }
                      }
                    },
                  )
                : const SizedBox();
          }),
        ),
      ),
    );
  }


  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate =
        Provider.of<UserProvider>(context, listen: false).selectedDate;

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != currentDate) {
      Provider.of<UserProvider>(context, listen: false)
          .updateSelectedDate(picked);
      Provider.of<UserProvider>(context, listen: false).updateControllers();
    }
  }
}

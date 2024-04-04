import 'package:aikmccbangalore/Constant/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constant/my_colors.dart';
import '../../Models/unitModel.dart';
import '../../Provider/UserProvider.dart';

class AddCordinatorScreen extends StatelessWidget {
  AddCordinatorScreen(
      {super.key,
      required this.uid,
      required this.type,
      required this.name,
      required this.phone,
      required this.from, required this.coPhone, required this.coId, required this.coArea});

  final String uid;
  final String type;
  final String name;
  final String phone;
  final String from;
  final String coPhone;
  final String coId;
  final String coArea;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    print(from);
    print("drxfcygvhbjk");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(head: "Add Coordinator"),
      ),
      body: Form(
        key: _formKey,
        child: SizedBox(
          height: height,
          width: width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Consumer<UserProvider>(builder: (context, val0, _) {
                    return GestureDetector(
                      onTap: () {
                        val0.showBottomSheet(context,"","");
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
                          :from=="EDIT"&&val0.proImage1!=""? Container(
                        width: width / 4.415730337078652,
                        height: height / 9.382022471910112,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24.27),
                          image: DecorationImage(
                              image: NetworkImage(val0.proImage1),
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
                      ):Container(
                        width: width / 4.415730337078652,
                        height: height / 9.382022471910112,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Color(0xFFEDEDED)),
                            borderRadius: BorderRadius.circular(24.27),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.perm_identity_rounded,
                              color: Colors.black.withOpacity(.50),
                              size: width / 13.1,
                            ),
                            Text(
                              'Add photo',
                              style: TextStyle(
                                color: Colors.black.withOpacity(.50),
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
                  Consumer<UserProvider>(builder: (context, userPro, _) {
                    return RegisterTextField(
                      hint: 'Name',
                      controller: userPro.nameTC,
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer<UserProvider>(builder: (context, userPro, _) {
                    return NumberTextForm(
                      controller: userPro.phoneTC, from: from,
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer<UserProvider>(builder: (context, userPro, _) {
                    return RegisterTextField(
                      hint: 'Address',
                      controller: userPro.userAddress,
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),

                  // Consumer<UserProvider>(builder: (context22, value56, child) {
                  //   return Autocomplete<AreaModel>(
                  //     optionsBuilder: (TextEditingValue textEditingValue) {
                  //       return (value56.areaAllList)
                  //           .where((AreaModel areas) =>
                  //       areas.area.toLowerCase().contains(
                  //           textEditingValue.text.toLowerCase()) ||
                  //           areas.district.toLowerCase().contains(
                  //               textEditingValue.text.toLowerCase()))
                  //           .toList();
                  //     },
                  //     displayStringForOption: (AreaModel option) => option.area,
                  //     fieldViewBuilder: (BuildContext context,
                  //         TextEditingController fieldTextEditingController,
                  //         FocusNode fieldFocusNode,
                  //         VoidCallback onFieldSubmitted) {
                  //       return TextFormField(
                  //         decoration: InputDecoration(
                  //           contentPadding:
                  //           const EdgeInsets.symmetric(horizontal: 10),
                  //           hintText: 'Area',
                  //           prefixIcon: Image.asset("assets/images/diversity_2_FILL0_wght300_GRAD0_opsz24 (1) 1.png", scale: 2.3,),
                  //           suffixIcon: const Icon(
                  //             Icons.keyboard_arrow_down_sharp,
                  //             size: 20,
                  //             color: Colors.black38,
                  //           ),
                  //           // labelText: "Area"
                  //           label:  const Padding(
                  //                             padding: EdgeInsets.only(left: 15.0,),
                  //                             child: Text("Area",style: TextStyle(color: maincolor),),
                  //                           ),
                  //           hintStyle: hintStyle,
                  //           labelStyle: hintStyle,
                  //           filled: true,
                  //           fillColor: const Color(0xFFF6F6F6),
                  //           focusedBorder: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(20),
                  //             borderSide: const BorderSide(
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //           enabledBorder: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(20),
                  //             borderSide: const BorderSide(
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //           disabledBorder: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(20),
                  //             borderSide: const BorderSide(
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //           focusedErrorBorder:
                  //           OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(20),
                  //             borderSide: const BorderSide(
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //           errorBorder:
                  //           OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(20),
                  //             borderSide: const BorderSide(
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(20),
                  //             borderSide: const BorderSide(
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //         ),
                  //         validator: (name) => name == '' ||
                  //             !(value56.areaBaseList + value56.areaJsonList).map((e) => e.area).contains(name)
                  //             ? 'Enter Valid Area Name'
                  //             : null,
                  //         controller: fieldTextEditingController,
                  //         focusNode: fieldFocusNode,
                  //         // style: const TextStyle(fontWeight: FontWeight.bold),
                  //       );
                  //     },
                  //     onSelected: (AreaModel selection) {
                  //       value56.selectPinArea(selection);
                  //
                  //     },
                  //     optionsViewBuilder: (BuildContext context,
                  //         AutocompleteOnSelected<AreaModel> onSelected,
                  //         Iterable<AreaModel> options) {
                  //       return Align(
                  //         alignment: Alignment.topLeft,
                  //         child: Material(
                  //           child: Container(
                  //             // width: MediaQuery.of(context).size.width / 1.5,
                  //             height: 200,
                  //             color: Colors.white,
                  //             child: ListView.builder(
                  //               padding: const EdgeInsets.all(10.0),
                  //               itemCount: options.length,
                  //               itemBuilder: (BuildContext context, int index) {
                  //                 final AreaModel option =
                  //                 options.elementAt(index);
                  //
                  //                 return GestureDetector(
                  //                   onTap: () {
                  //                     onSelected(option);
                  //
                  //                   },
                  //                   child: Container(
                  //                     // height: 60,
                  //                     color: Colors.white,
                  //                     child: Column(
                  //                         crossAxisAlignment: CrossAxisAlignment.start,
                  //                         children: [
                  //                           Text(option.area,
                  //                               style: const TextStyle(
                  //                                   fontWeight:
                  //                                   FontWeight.bold)),
                  //                           Text(option.district ),
                  //                           const SizedBox(height: 10)
                  //                         ]),
                  //                   ),
                  //                 );
                  //               },
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   );
                  // }),
                  SizedBox(
                    width: double.infinity,
                    child: Consumer<UserProvider>(
                        builder: (context, value, child) {
                      return Autocomplete<AreaModel>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          return (value.areaAllList)
                              .where((AreaModel areas) =>
                                  areas.area.toLowerCase().contains(
                                      textEditingValue.text.toLowerCase()) ||
                                  areas.district.toLowerCase().contains(
                                      textEditingValue.text.toLowerCase()))
                              .toList();
                        },
                        displayStringForOption: (AreaModel option) =>
                            option.area,
                        fieldViewBuilder: (BuildContext context,
                            TextEditingController fieldTextEditingController,
                            FocusNode fieldFocusNode,
                            VoidCallback onFieldSubmitted) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            fieldTextEditingController.text =
                                value.areaControllerForCoordinator.text;
                          });
                          return TextFormField(
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              hintText: 'Area',
                              prefixIcon: Image.asset(
                                "assets/images/diversity_2_FILL0_wght300_GRAD0_opsz24 (1) 1.png",
                                scale: 2.3,
                              ),
                              suffixIcon: const Icon(
                                Icons.keyboard_arrow_down_sharp,
                                size: 20,
                                color: Colors.black38,
                              ),
                              // labelText: "Area"
                              label: const Padding(
                                padding: EdgeInsets.only(
                                  left: 15.0,
                                ),
                                child: Text(
                                  "Area",
                                  style: TextStyle(color: maincolor),
                                ),
                              ),
                              hintStyle: hintStyle,
                              labelStyle: hintStyle,
                              filled: true,
                              fillColor: const Color(0xFFF6F6F6),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            controller: fieldTextEditingController,
                            focusNode: fieldFocusNode,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                fontFamily: "Poppins"),
                            validator: (name) => name == '' ||
                                    !(value.areaBaseList + value.areaJsonList)
                                        .map((e) => e.area)
                                        .contains(name)
                                ? 'Enter Valid Area Name'
                                : null,
                          );
                        },
                        onSelected: (AreaModel selection) {
                          value.areaControllerForCoordinator.text =
                              selection.area;
                          value.selectPinArea(selection,selection.area,selection.district);
                        },
                        optionsViewBuilder: (BuildContext context,
                            AutocompleteOnSelected<AreaModel> onSelected,
                            Iterable<AreaModel> options) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              child: Container(
                                // width: MediaQuery.of(context).size.width / 1.5,
                                height: 200,
                                color: Colors.white,
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(10.0),
                                  itemCount: options.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
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
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(option.area,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(option.district),
                                              const SizedBox(height: 10)
                                            ]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Consumer<UserProvider>(builder: (context, userPro, _) {
                    return CustomFlotingButton(
                        text: "Submit",
                        onTap: () async {
                          final FormState? form = _formKey.currentState;
                          if (form!.validate()) {
                            if(from=='EDIT'){
                              userPro.loaderDialogNormal(context);
                              await userPro.editCordinatorDetaild(context, coId, uid, name, phone, coPhone,coArea);
                            }else {
                              userPro.loaderDialogNormal(context);
                              await userPro.addCoordinator(
                                  context, uid, type, name, phone);
                            }
                          }
                        },
                        width: width);
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

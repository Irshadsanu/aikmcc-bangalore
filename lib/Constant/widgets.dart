import 'package:aikmccbangalore/Constant/my_colors.dart';
import 'package:aikmccbangalore/Constant/my_functions.dart';
import 'package:aikmccbangalore/Provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.head,
  });

  final String head;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: AppBar(
          backgroundColor: Colors.white,
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
            ),
          ),
          title: Text(
            head,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          )),
    );
  }
}

final textFormDecoration = OutlineInputBorder(
  borderRadius: BorderRadius.circular(20),
  borderSide: const BorderSide(
    color: Colors.white,
  ),
);


final hintStyle = TextStyle(
  color: Colors.black.withOpacity(.50),
  fontSize: 12,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w400,
);


const nameTextStyle = TextStyle(
  color: Color(0xFF818181),
  fontSize: 11.2,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w600,
  // height: 0.15,
);
const textTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 11,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w600,
  // height: 0.15,
);
const subtitleStyle = TextStyle(
  color: Color(0xFF818181),
  fontSize: 12,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  // height: 0.12,
);
const titleStyle = TextStyle(
  color: Colors.black,
  fontSize: 12,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w600,
  // height: 0.12,
);
const gradientStyle = LinearGradient(
    begin: Alignment(-1.00, -0.02),
    end: Alignment(1, 0.02),
    colors: [Color(0xFF1F6D8B), Color(0xFF0F3848)]);

class RegisterTextField extends StatelessWidget {
  const RegisterTextField({
    super.key,
    required this.hint,
    required this.controller,
  });

  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context,val,_) {
        return TextFormField(

          minLines: 1,
          textAlign: TextAlign.start,
          controller: controller,
          style: const TextStyle(
              color: Colors.black, fontSize: 17, fontFamily: "Poppins"),
          maxLines:hint == "Name*"?1:6,
          onChanged: (text){

            if(hint=="Permanent Address*"){
            val. setFirstTextFieldValue(text);}
            else if(hint!="Name*"){
              val. setTextFieldValue(text,controller);

            }
          },
          decoration: InputDecoration(

            prefixIcon: hint == "Name*"
                ? Image.asset(
                    "assets/images/person_FILL0_wght300_GRAD0_opsz24 (1) 1.png",
                    scale: 2.3,
                  )
                : hint == "Permanent Address*"
                ? Image.asset(
                    "assets/images/contact_mail_FILL0_wght300_GRAD0_opsz24 1.png",
                    scale: 2.3,
                  ):Image.asset(
                    "assets/images/location_home_FILL0_wght300_GRAD0_opsz24 1.png",
                    scale: 2.3,
                  ),
            fillColor: const Color(0xFFF6F6F6),
            filled: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 0),
            hintText: hint,
            // helperText: "",
            label: Padding(
              padding: const EdgeInsets.only(left: 15.0,),
              child: Text(hint,style: const TextStyle(color: maincolor)),
            ),
        // labelText:hint ,
            labelStyle:hintStyle ,
            hintStyle: hintStyle,
            focusedBorder: OutlineInputBorder(
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
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          validator: (txt) {
            if (txt!.trim().isEmpty) {
              if (hint == "Name*") {
                return "Enter Your Name";
              } else  {
                return "Enter Your Address";
              }
            }
            return null;
          },
        );
      }
    );
  }
}

InputBorder border = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(50)),
    borderSide: BorderSide(color: lategrey, width: 0.2));

CircularProgressIndicator waitingIndicator = const CircularProgressIndicator(
    color: Colors.white,
    strokeCap: StrokeCap.round,
    strokeWidth: 7,
    strokeAlign: 0.01);

class NumberTextForm extends StatelessWidget {
  const NumberTextForm({
    super.key,
    required this.controller, required this.from,
  });

  final TextEditingController controller;
  final String from;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(
          color: Colors.black, fontSize: 17, fontFamily: "Poppins"),
      decoration: InputDecoration(
        prefixIcon: Image.asset(
          "assets/images/phone_enabled_FILL0_wght300_GRAD0_opsz24 1.png",
          scale: 2.3,
        ),
        fillColor: const Color(0xFFF6F6F6),
        filled: true,enabled: from=="EDIT"?false:true,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        hintText: 'Mobile Number*',
        // helperText: "",
        label: const Padding(
          padding: EdgeInsets.only(left: 15.0,),
          child: Text("Mobile Number*",style: TextStyle(color: maincolor),),
        ),        labelStyle:hintStyle ,
        hintStyle: hintStyle,
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
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "Enter The Mobile Number";
        } else if (!RegExp(r'^[0-9]+$').hasMatch(value)||value.length!=10) {
          return "Enter Correct Number";
        } else {
          return null;
        }
      },
    );
  }
}
class AadharTextForm extends StatelessWidget {
  const AadharTextForm({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;


  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context1,va,_) {
        return TextFormField(
          onChanged: (text) {
           va. setTextFieldValue(text,controller);
            controller.text = text.toUpperCase();
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length),

            );
          },
          // textCapitalization: TextCapitalization.words,
          controller: controller,
          style: const TextStyle(
              color: Colors.black, fontSize: 17, fontFamily: "Poppins"),
          decoration: InputDecoration(
            prefixIcon: Image.asset(
              "assets/images/badge_FILL0_wght300_GRAD0_opsz24 1.png",
              scale: 2.3,
            ),
            fillColor: const Color(0xFFF6F6F6),
            filled: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            hintText: '${va.selectedProof}*',
            // helperText: "",
            label:  Padding(
              padding: const EdgeInsets.only(left: 15.0,),
              child: Text('${va.selectedProof} Number*',style: TextStyle(color: maincolor),),
            ),        labelStyle:hintStyle ,
            hintStyle: hintStyle,
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
          // keyboardType: TextInputType.number,
          // inputFormatters: [
          //   FilteringTextInputFormatter.digitsOnly,
          //   LengthLimitingTextInputFormatter(12)
          // ],
          validator: (value) {
            if (value!.trim().isEmpty) {


              return "Enter The ${va.selectedProof} Number";

            } else if(va.selectedProof=="Aadhaar Card"){
              if (!RegExp(r'^[0-9]+$').hasMatch(value)||value.length!=12) {
                  return "Enter Correct Aadhaar Number";
                } else {
                  return null;
                }
            }
            // else if(va.selectedProof=="Election ID"){
            //   if (!RegExp(r'^[A-Z]{3}[0-9]{7}$').hasMatch(value)) {
            //     return "Enter Correct ID Number";
            //   } else {
            //     return null;
            //   }
            // }else if(va.selectedProof=="Driving License"){
            //   if (!RegExp(r'^[A-Z]{2}[0-9]{13}$').hasMatch(value)) {
            //     return "Enter Correct License Number";
            //   } else {
            //     return null;
            //   }
            //}
            else if(va.selectedProof=="Passport"){
              if (value.length<8) {
                return "Enter Correct Passport Number";
              } else {
                return null;
              }
            }
//RegExp(r'^[A-Z]{2}[0-9]{7}$')

            // else if (!RegExp(r'^[0-9]+$').hasMatch(value)||value.length!=12) {
            //   return "Enter Correct ID Number";
            // } else {
            //   return null;
            // }
          },
        );
      }
    );
  }
}
class SecondaryNumberTextForm extends StatelessWidget {
  const SecondaryNumberTextForm({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(
          color: Colors.black, fontSize: 17, fontFamily: "Poppins"),
      decoration: InputDecoration(
        prefixIcon: Image.asset(
          "assets/images/phone_enabled_FILL0_wght300_GRAD0_opsz24 1.png",
          scale: 2.3,
        ),
        fillColor: const Color(0xFFF6F6F6),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        hintText: 'Secondary Number (Optional)',
        // helperText: "",
        label: const Padding(
          padding: EdgeInsets.only(left: 15.0,),
          child: Text("Secondary Number (Optional)",style: TextStyle(color: maincolor),),
        ),        labelStyle:hintStyle ,
        hintStyle: hintStyle,
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
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10)
      ],
      validator: (value) {
        if (value!.isNotEmpty && value.length != 10) {
          return 'Enter Correct Number';
        }
        return null;
      },

    );
  }
}

class CustomAutoCompleateForm extends StatelessWidget {
  const CustomAutoCompleateForm({
    super.key,
    required this.list,
    required this.controller,
    required this.hint,
    required this.image,
  });

  final List<String> list;
  final TextEditingController controller;
  final String hint;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        return (list)
            .where((String item) => item
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase()))
            .toList();
      },
      displayStringForOption: (String option) => option,
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          fieldTextEditingController.text = controller.text;
        });

        return SizedBox(
          child: Material(
            elevation: 0,
            borderRadius: BorderRadius.circular(15),
            child: TextFormField(
              maxLines: 1,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                // enabled: type == "REQUEST-EDIT" ? false : true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                hintStyle: hintStyle,
                labelStyle: hintStyle,
                // labelText:hint ,
                label:  Padding(
                  padding: const EdgeInsets.only(left: 15.0,),
                  child: Text(hint,style: const TextStyle(color: maincolor),),
                ),
                filled: true,
                fillColor: const Color(0xFFF6F6F6),
                prefixIcon: Image.asset(
                  image,
                  scale: 2.3,
                ),
                // labelText: "Occupation",
                hintText: hint,
                suffixIcon: const Icon(
                  Icons.keyboard_arrow_down_sharp,
                  size: 20,
                  color: Colors.black38,
                ),
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
              validator: (txt) {
                if(hint == "Blood Group*"){
    if (txt!.trim().isEmpty || !list.contains(txt)) {
      return "Enter Your Blood Group";
    }
                }else if(hint=="Gender*"){
                  if (txt!.trim().isEmpty || !list.contains(txt)) {
                    return "Enter Your Gender";
                  }
                }else{
                  if (txt!.trim().isEmpty) {
                    if (hint == "Area*") {
                      return "Enter Your Area Name";
                    } else {
                      return "Enter Your Occupation";
                    }
                  }
                }

                // print(hint);
                // print("dtfghjkjk");
                // if (hint != "Blood Group*"||hint!="Gender*") {
                //   print("cfhbjnk");
                //
                //   return null;
                // } else {
                //   if (txt!.trim().isEmpty || !list.contains(txt)) {
                //     if(hint=="Gender*"){
                //       return "Enter Your Gender";
                //
                //     }else{
                //     return "Enter Your Blood Group";
                //     }
                //   }
                // }
                // return null;
              },
              onChanged: (txt) {
                controller.text = txt;
              },
              controller: fieldTextEditingController,
              focusNode: fieldFocusNode,
            ),
          ),
        );
      },
      onSelected: (String selection) {
        controller.text = selection;
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.86,
              height: MediaQuery.of(context).size.height*0.6,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final String option = options.elementAt(index);

                        return GestureDetector(
                          onTap: () {
                            onSelected(option);
                          },
                          child: Container(
                            color: Colors.white,
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.86,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(option,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10)
                                ]),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomFlotingButton extends StatelessWidget {
  const CustomFlotingButton({
    super.key,
    required this.width,
    required this.text,
    required this.onTap,
  });

  final double width;
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFFF7F7F7),
            fontSize: 15,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

class NetWorkImageStyle extends StatelessWidget {
  const NetWorkImageStyle(this.image);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 61,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

// TextFormField(
// keyboardType: TextInputType.phone,
// // maxLength: 10,
// textAlign: TextAlign.left,
// controller: value.mobileCT,
// style: const TextStyle(color: Colors.black, fontSize: 17,fontFamily: "Poppins"),
// decoration: InputDecoration(
// counterText: '',
// prefixIcon: const Icon(Icons.call_outlined,color: iconGreen,),
// fillColor: textFieldColor,
// filled: true,
// contentPadding:
// const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
// hintText: 'Mobile Number',
// helperText: "",
// hintStyle: hintStyle,
// labelText: "Mobile Number",
// labelStyle: hintStyle,
// focusedBorder: OutlineInputBorder(
// borderRadius: BorderRadius.circular(20),
// borderSide: const BorderSide(
// color: Colors.white,
// ),
// ),
// enabledBorder: OutlineInputBorder(
// borderRadius: BorderRadius.circular(20),
// borderSide: const BorderSide(
// color: Colors.white,
// ),
// ),
// errorBorder: OutlineInputBorder(
// borderRadius: BorderRadius.circular(20)),
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(20),
// borderSide: const BorderSide(
// color: Colors.white,
// ),
// ),
// ),
// validator: (value) {
// if (value!.trim().isEmpty) {
// return "Please Enter Mobile Number";
// } else if (
// // !RegExp(r'^\+\d{1,3}\d{6,14}$')
// //     .hasMatch(value) ||
// value.length <= 6) {
// return "Enter Correct Mobile Number";
// } else {
// return null;
// }
// }
// ),

import 'package:aikmccbangalore/Constant/my_colors.dart';
import 'package:aikmccbangalore/Constant/my_functions.dart';
import 'package:aikmccbangalore/Provider/UserProvider.dart';
import 'package:aikmccbangalore/Screens/User/myRegistrationPage.dart';
import 'package:aikmccbangalore/Screens/User/registration_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Constant/images.dart';
import '../../Constant/widgets.dart';
import '../../Provider/LoginProvider.dart';
import '../../Models/RequestMemberModel.dart';
import '../../Provider/mainprovider.dart';
import '../admin/LoginScreen.dart';
import 'Share Id card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: Alignment(-1.00, -0.02),
          end: Alignment(1, 0.02),
          colors: [Color(0xFF0F3848), Color(0xFF1F6D8B)],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: height / 2.306340057636888,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage(homebackground),
                        fit: BoxFit.fill,
                        alignment: Alignment.topCenter),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(sarLogo, scale: 6.5),
                            Consumer<LoginProvider>(
                                builder: (context, value, child) {
                              return Row(
                                children: [
                                  Consumer<MainProvider>(
                                      builder: (context, newValue, child) {
                                      return InkWell(
                                        onTap: () {
                                          newValue.alertSupport(context);
                                        },
                                          child: Image.asset(supportIcon,scale: 2));
                                    }
                                  ),
                                  SizedBox(width: 10),
                                  InkWell(
                                      onTap: () {
                                        callNext(const LoginScreen(), context);
                                      },
                                      child:Container(
                                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(22)
                                        ),
                                          child: const Row(
                                            children: [
                                              Text("Login ",style: TextStyle(color: maincolor, height: 1,
                                                  fontFamily: "Poppins",
                                                  fontSize: 12)),
                                              Icon(Icons.login,color: maincolor,size: 15,)
                                            ],
                                          )) ),
                                ],
                              );
                            })
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 28,
                                height: 28,
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.white),
                                child: Image.asset(
                                  AIKMCCLOGO,
                                  scale: 20,
                                )),
                            const SizedBox(width: 4),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "AIKMCC",
                                  style: TextStyle(
                                      color: Colors.white,
                                      height: 1,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins",
                                      fontSize: 16),textAlign: TextAlign.center,
                                ),
                                Text(
                                  "BENGALURU",
                                  style: TextStyle(
                                      color: Colors.white,
                                       height: 1,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins",
                                      fontSize: 10),textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Consumer<MainProvider>(
                              builder: (context, value, child) {
                            return Column(
                              children: [
                               SizedBox(
                                  height: 0.251 * height,
                                  width: width,
                                  child: value.carosalImages.isNotEmpty? CarouselSlider.builder(
                                    itemCount: value.carosalImages.length,
                                    itemBuilder: (context, index, realIndex) {
                                      final image = value.carosalImages[index];
                                      return buildImage(image, context, width);
                                    },
                                    options: CarouselOptions(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        // autoPlayCurve: Curves.linear,
                                        height: 0.212 * height,
                                        viewportFraction: 1,
                                        autoPlay: true,
                                        //enableInfiniteScroll: false,
                                        pageSnapping: true,
                                        enlargeStrategy:
                                            CenterPageEnlargeStrategy.height,
                                        enlargeCenterPage: true,
                                        autoPlayInterval:
                                            const Duration(seconds: 3),
                                        onPageChanged: (index, reason) {
                                          value.setActiveIndex(index);
                                        }),
                                  ):const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(color: Colors.transparent,)),
                                ),
                                buildIndiCator(value.carosalImages.length, context, value.activeIndex),
                              ],
                            );
                          }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Consumer<UserProvider>(builder: (context, val, _) {
                  return val.allMyRegistrations.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "My Registrations",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                  onTap: () {
                                    callNext(const MyRegistration(), context);
                                  },
                                  child: const Text(
                                    "View all",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Blue,
                                        color: Blue),
                                  )),
                            ],
                          ),
                        )
                      : const SizedBox();
                }),
                const SizedBox(
                  height: 10,
                ),
                Consumer<UserProvider>(builder: (context, val, _) {
                  return val.allMyRegistrations.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                            height: val.allMyRegistrations.isEmpty
                                ? 50
                                : val.allMyRegistrations.length >= 3
                                    ? 220
                                    : val.allMyRegistrations.length == 2
                                        ? 140
                                        : 70,
                            width: width,
                            child: val.allMyRegistrations.isNotEmpty
                                ? ListView.builder(
                                    itemCount:
                                        val.allMyRegistrations.length >= 3
                                            ? 3
                                            : val.allMyRegistrations.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      RequestMemberModel item =
                                          val.allMyRegistrations[index];

                                      return GestureDetector(
                                        onTap: () {
                                          if(item.status=="PENDING"||item.status=="CO-APPROVED") {
                                            callNext(  ShareIdCard(image: item.image,phone:item.phone ,name:item.name), context);
                                          }
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 1),
                                          clipBehavior: Clip.antiAlias,
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
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
                                          child: ListTile(
                                            leading: Container(
                                              width: 50,
                                              height: 61,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(15)),
                                                image: DecorationImage(
                                                  image: NetworkImage(item.image),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              item.name,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                height: 0.12,
                                              ),
                                            ),
                                            subtitle: Text(
                                              item.phone,
                                              style: const TextStyle(
                                                color: Color(0xFF818181),
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                                height: 0.12,
                                              ),
                                            ),
                                            trailing: SizedBox(
                                              width: width * .21,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                      item.status == "PENDING"
                                                          ? Icons.refresh_sharp
                                                          : item.status ==
                                                                  "APPROVED"
                                                              ? Icons.check:
                                                      item.status == "CO-APPROVED"
                                                          ? Icons.refresh_sharp
                                                              : Icons.close,
                                                      color:
                                                          item.status == "PENDING"
                                                              ? const Color(
                                                                  0xFF2EC0FF)
                                                              : item.status ==
                                                                      "APPROVED"
                                                                  ? const Color(
                                                                      0xFF02AD47)
                                                                  :item.status == "CO-APPROVED"
                                                              ?  const Color(
                                                              0xFF2EC0FF): const Color(
                                                                      0xFFD10000),
                                                      size: 15),
                                                  Text(
                                                    item.status == "CO-APPROVED"
                                                        ? "PENDING"
                                                        : item.status=="CO-REJECTED"?"REJECTED": item.status,
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color:
                                                          item.status == "APPROVED"
                                                              ? const Color(
                                                              0xFF02AD47)
                                                              : item.status ==
                                                                      "REJECTED"||item.status=="CO-REJECTED"
                                                                  ? const Color(
                                                                      0xFFD10000)
                                                                  :const Color(
                                                              0xFF2EC0FF),

                                                      fontSize: 11,
                                                      fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.w400,
                                                      height: 0.15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : const Center(
                                    child: Text("No Registrations Yet")),
                          ),
                        )
                      : const SizedBox();
                }),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                          text: const TextSpan(
                              text: "About ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                            TextSpan(
                              text: "AIKMCC",
                              style: TextStyle(
                                  color: green,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: " !",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold),
                            )
                          ]))),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child:
                      Consumer<MainProvider>(builder: (context, value, child) {
                    return RichText(
                      text: TextSpan(
                        text: value.isExpanded
                            ? "AIKMCC ( All India Kerala Muslim Cultural Center) is an organisation formed by the Keralites who are doing service outside Kerala"
                            " in the rest of India by following the ideologies of former Indian constitutional assembly member late Quaid e Millath Muhammed Ismail"
                            " sahib.KMCC is the largest expatriate organisation in the world. It works in the interests of expats from all over India, not just Kerala,"
                            " and is known for its humanitarian and philanthropic activities. The organisation has paved a path of valuable contributions in the fields"
                            " of social, cultural and compassionate service. Through its tradition of relentless service, KMCC has found a favoured place in the hearts "
                            "of Malayalees There is no doubt that for any scribe or scholar in search of the past and present of migration, the first name in organised"
                            " strength that comes to their mind and flows out from their pen will be that of KMCC."
                            : "AIKMCC ( All India Kerala Muslim Cultural Center) is an organisation formed by the Keralites who are doing service outside Kerala"
                            " in the rest of India by following the ideologies of former Indian constitutional assembly member late Quaid e Millath Muhammed "
                            "Ismail sahib.KMCC is the largest expatriate organisation in the world. It works in the interests of expats from all over India,"
                            " not just Kerala",
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          height: 1.6,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                value.expandtext();
                              },
                            text: value.isExpanded
                                ? '  Read less'
                                : '  Read more...',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: green,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
          floatingActionButton:
              Consumer<UserProvider>(builder: (context, userPro, _) {
            return CustomFlotingButton(
              text: "Register",
              width: width,
              onTap: () async {
                 // userPro.loopForStatus();
                 // userPro.fetchFullData();


                DateTime date = DateTime.now();
                String id =
                date.millisecondsSinceEpoch.toString();
                userPro.clearText();
                callNext(
                    RegistrationScreen(name: "", phone: "", type: "", uid: "", from: '', proImage: '', id: '', coArea: '', coAreaDistrict: '', idImage: '', docId: id, date: date, status: '',),
                    context);
                if(userPro.alertBool){
                  userPro.alertBool=false;
                userPro.registrationAlert(context,MediaQuery.sizeOf(context));
                }

              },
            );
          }),
        ),
      ),
    );
  }

  buildIndiCator(int count, BuildContext context, int activeindex) {
    //    print(activeIndex.toString()+"dpddoopf");

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: AnimatedSmoothIndicator(
          activeIndex: activeindex,
          count: count,
          effect: ExpandingDotsEffect(
              dotWidth: 7,
              dotHeight: 7,
              strokeWidth: 1,
              paintStyle: PaintingStyle.fill,
              activeDotColor: maincolor,
              dotColor: Colors.grey.shade300),
        ),
      ),
    );
  }

  buildImage(var image, context, double width) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      width: MediaQuery.of(context).size.width,
      child: ClipPath(
        // clipper: DoubleCurvedContainerClipper(),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(image, fit: BoxFit.fill)),
      ),
    );
  }
}

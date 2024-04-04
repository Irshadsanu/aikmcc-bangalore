import 'package:aikmccbangalore/Constant/my_colors.dart';
import 'package:aikmccbangalore/Constant/widgets.dart';
import 'package:aikmccbangalore/Provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import '../../Constant/images.dart';

class ShareIdCard extends StatelessWidget {
  String image;
  String name;
  String phone;
   ShareIdCard({super.key,required this.image,required this.name,required this.phone});


  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return  Scaffold(
      appBar:const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBar(
            head: "ID Card",
          )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
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
                                child: Image.network(image,fit: BoxFit.cover)),
                          ),
                          SizedBox(width: width*0.035,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width*0.32,
                                child: Text(name,style: const TextStyle(color: maincolor,
                                    fontWeight: FontWeight.bold,fontSize: 8,fontFamily: "Poppins"),
                                maxLines: 1,overflow: TextOverflow.clip,),
                              ),
                              Text(phone,style: const TextStyle(color: Colors.grey,
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
          )
        ],
      ),
    );
  }
}

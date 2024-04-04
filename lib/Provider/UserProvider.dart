import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
import 'package:universal_html/html.dart' as web_file;

import 'package:aikmccbangalore/Constant/my_functions.dart';
import 'package:aikmccbangalore/Provider/LoginProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:unique_identifier/unique_identifier.dart';

import '../Constant/my_colors.dart';
import '../Constant/wards_service.dart';
import '../Models/RequestMemberModel.dart';
import '../Models/unitModel.dart';
import '../Screens/User/RegistrationSuccessPage.dart';
import '../Screens/User/loding_Screnn.dart';
import 'mainprovider.dart';
import 'package:image/image.dart' as img;
class UserProvider extends ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();

  TextEditingController nameTC = TextEditingController();
  TextEditingController phoneTC = TextEditingController();
  TextEditingController optionalPhoneTC = TextEditingController();
  TextEditingController aadhaarNumberController = TextEditingController();
  TextEditingController userAddress = TextEditingController();
  TextEditingController userFullAddress = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController areaDistrictController = TextEditingController();
  TextEditingController homeAddressController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController pinWardTC = TextEditingController();
  TextEditingController areaControllerForCoordinator = TextEditingController();
  TextEditingController panchayathTc = TextEditingController();
  TextEditingController assemblyTc = TextEditingController();
  TextEditingController districtTc = TextEditingController();

  Reference ref3 = FirebaseStorage.instance.ref("PROFILE_IMAGE");

  final ImagePicker picker = ImagePicker();
  File? fileImage;
  File? fileProof;
  bool bloodVisibility = false;
  List<String> areaList = [];
  String? strDeviceID = "";
  String proImage1 = "";
  String selectedProof = "Select Your Proof";

  List<String> bloodGroupsList = [
    'A+ve',
    'A-ve',
    'AB+ve',
    'AB-ve',
    'B+ve',
    'B-ve',
    'O+ve',
    'O-ve',
    'OTHER',
  ];
  List<String> genderList = [
    'Male',
    'Female',
    'Others',
  ];
  List<String> proof = [
    "Select Your Proof",
    "Aadhaar Card",
    "Election ID",
    "Driving License",
    "Passport",
  ];
  List<String> occupationList = [];
  List<String> homeAddressList = [];
  List<WardModel> wards = [];
  List<WardModel> allWards = [];
  List<WardModel> newWards = [];
  List<WardModel> hideWards = [];
  Map<dynamic, dynamic> newWardsMap = {};
  Map<dynamic, dynamic> newAreaMap = {};
  Map<dynamic, dynamic> hideWardsMap = {};
  WardModel? selectedWard;
  AreaModel? selectedArea;

  UserProvider() {
    getOccupation();
    // fetchDatabaseWard();
    // fetchDatabaseHideWard();
    // fetchWard();
    fetchAllPanchayaths();
    // fetchAllWards();
    fetchAllArea();
  }

  bool _containerHeight = false;
  bool photoLoading = false;

  bool get containerHeight => _containerHeight;

  void setContainerSize() {
    _containerHeight = _containerHeight == true ? false : true;
    notifyListeners();
  }

  bool _isChecked = false;
  bool fullAddressChecked = false;
  bool alertBool = true;

  bool get isChecked => _isChecked;

  void toggleCheckbox() {
    _isChecked = !_isChecked;
    fullAddressChecked = false;
    userFullAddress.clear();
    pinWardTC.clear();
    checkString = "";
    selectedWard = null;
    firstTextFieldValue1 = "";
    notifyListeners();
  }

  String firstTextFieldValue1 = "";

  String get firstTextFieldValue => firstTextFieldValue1;

  void setFirstTextFieldValue(String value) {
    firstTextFieldValue1 = value;
    notifyListeners();
  }

  void setTextFieldValue(String value, TextEditingController controller) {
    controller.text = value;
    notifyListeners();
  }

  void proofValue(String value) {
    selectedProof = value;
    notifyListeners();
  }

  void addOcupation() {
    String occupation = occupationController.text.toString().toUpperCase();
    Map<String, Object> map = HashMap();
    map[occupation] = occupation;
    mRoot.child("OCCUPATION").update(map);
  }

  String checkString = "";

  void selectPinWard(WardModel wardName) {
    pinWardTC.text = wardName.wardName;
    panchayathTc.text = wardName.panchayath;
    assemblyTc.text = wardName.assembly;
    districtTc.text = wardName.district;
    checkString = wardName.wardName;
    selectedWard = wardName;
    fullAddressChecked = true;

    notifyListeners();
  }

  void selectPinArea(AreaModel areaName, String area, String areaDistrict) {
    areaController.text = area;
    areaDistrictController.text = areaDistrict;
    selectedArea = areaName;
    notifyListeners();
  }

  void fetchDatabaseWard() {
    mRoot
        .child('NewWards')
        .onValue
        .listen((databaseEvent) {
      newWards.clear();
      if (databaseEvent.snapshot.value != null) {
        newWardsMap = databaseEvent.snapshot.value as Map;
        Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;

        map.forEach((key, value) {
          newWards.add(WardModel(
              value['district'].toString(),
              value['panchayath'].toString(),
              value['assembly'].toString(),
              value['wardname'].toString(),
              value['wardnumber'].toString()));

          print("newWards : ${newWards.length}");
        });

        notifyListeners();
      }
    });
  }

  void fetchDatabaseHideWard() {
    mRoot
        .child('HideWards')
        .onValue
        .listen((databaseEvent) {
      newWards.clear();
      if (databaseEvent.snapshot.value != null) {
        hideWardsMap = databaseEvent.snapshot.value as Map;
        Map<dynamic, dynamic> map = databaseEvent.snapshot.value as Map;

        map.forEach((key, value) {
          hideWards.add(WardModel(
              value['district'].toString(),
              value['panchayath'].toString(),
              value['assembly'].toString(),
              value['wardname'].toString(),
              value['wardnumber'].toString()));
          print("hideWards : ${hideWards.length}");
        });

        notifyListeners();
      }
    });
  }

  List<PanjayathModel> panjayathList = [];

  fetchAllPanchayaths() async {
    print("unit 1");
    panjayathList.clear();
    List<PanjayathModel> baseUnitList = [];
    List<PanjayathModel> baseHideUnitList = [];
    List<PanjayathModel> jsonUnitList = [];
    var jsonText =
    await rootBundle.loadString('assets/images/msf_paper_revolution.json');
    var jsonResponse = json.decode(jsonText.toString());
    mRoot.child('NewWards').once().then((databaseEvent) {
      mRoot.child('HideWards').once().then((databaseHideEvent) {
        print("unit 2");
        Map<dynamic, dynamic> map = jsonResponse as Map;
        jsonUnitList.clear();
        map.forEach((key, value) {
          if (!jsonUnitList
              .map((item) => (item.district + item.assembly + item.panjayath))
              .contains(value['district'].toString() +
              value['assembly'].toString() +
              value['panchayath'].toString())) {
            jsonUnitList.add(PanjayathModel(
              value['district'].toString(),
              value['assembly'].toString(),
              value['panchayath'].toString(),
            ));
          }
        });

        print("unit 3");
        if (databaseEvent.snapshot.value != null) {
          Map<dynamic, dynamic> baseMap = databaseEvent.snapshot.value as Map;
          baseUnitList.clear();
          baseMap.forEach((key, value) {
            if (!baseUnitList
                .map((item) =>
            (item.district + item.assembly + item.panjayath))
                .contains(value['district'].toString() +
                value['assembly'].toString() +
                value['panchayath'].toString()) &&
                !jsonUnitList
                    .map((item) =>
                (item.district + item.assembly + item.panjayath))
                    .contains(value['district'].toString() +
                    value['assembly'].toString() +
                    value['panchayath'].toString())) {
              baseUnitList.add(PanjayathModel(
                value['district'].toString(),
                value['assembly'].toString(),
                value['panchayath'].toString(),
              ));
            }
          });
          notifyListeners();
        }
        print("unit 4");

        if (databaseHideEvent.snapshot.value != null) {
          Map<dynamic, dynamic> baseMap =
          databaseHideEvent.snapshot.value as Map;
          baseHideUnitList.clear();
          baseMap.forEach((key, value) {
            if (!baseHideUnitList
                .map((item) =>
            (item.district + item.assembly + item.panjayath))
                .contains(value['district'].toString() +
                value['assembly'].toString() +
                value['panchayath'].toString()) &&
                !jsonUnitList
                    .map((item) =>
                (item.district + item.assembly + item.panjayath))
                    .contains(value['district'].toString() +
                    value['assembly'].toString() +
                    value['panchayath'].toString())) {
              baseHideUnitList.add(PanjayathModel(
                value['district'].toString(),
                value['assembly'].toString(),
                value['panchayath'].toString(),
              ));
            }
          });
          notifyListeners();
        }
        print("unit 5");
        panjayathList = jsonUnitList + baseUnitList;
        panjayathList.removeWhere((item1) =>
            baseHideUnitList.any((item2) =>
            (item1.panjayath == item2.panjayath &&
                item1.assembly == item2.assembly &&
                item1.district == item2.district)));
        notifyListeners();
        print("unit 6");
      });
    });
  }

  fetchSelectedUnits(String selectedDistrict,
      String selectedPanchayath,) async {
    allWards.clear();
    List<WardModel> baseUnitList = [];
    List<WardModel> jsonUnitList = [];
    List<WardModel> baseHideUnitList = [];
    var jsonText =
    await rootBundle.loadString('assets/images/msf_paper_revolution.json');
    var jsonResponse = json.decode(jsonText.toString());
    mRoot
        .child('NewWards')
        .onValue
        .listen((databaseEvent) {
      mRoot
          .child('HideWards')
          .onValue
          .listen((databaseHideEvent) {
        Map<dynamic, dynamic> map = jsonResponse as Map;
        jsonUnitList.clear();
        map.forEach((key, value) {
          if (value['district'].toString() == selectedDistrict &&
              value['panchayath'].toString() == selectedPanchayath) {
            if (!jsonUnitList
                .map(
                    (item) => (item.district + item.panchayath + item.wardName))
                .contains(value['district'].toString() +
                value['panchayath'].toString() +
                value['wardname'].toString())) {
              jsonUnitList.add(WardModel(
                value['district'].toString(),
                value['assembly'].toString(),
                value['panchayath'].toString(),
                value['wardname'].toString(),
                value['wardnumber'].toString(),
              ));
            }
          }
        });

        if (databaseEvent.snapshot.value != null) {
          Map<dynamic, dynamic> baseMap = databaseEvent.snapshot.value as Map;
          baseUnitList.clear();
          baseMap.forEach((key, value) {
            if (value['district'].toString() == selectedDistrict &&
                value['panchayath'].toString() == selectedPanchayath) {
              if (!baseUnitList
                  .map((item) =>
              (item.district + item.panchayath + item.wardName))
                  .contains(value['district'].toString() +
                  value['panchayath'].toString() +
                  value['wardname'].toString()) &&
                  !jsonUnitList
                      .map((item) =>
                  (item.district + item.panchayath + item.wardName))
                      .contains(value['district'].toString() +
                      value['panchayath'].toString() +
                      value['wardname'].toString())) {
                baseUnitList.add(WardModel(
                    value['district'].toString(),
                    value['assembly'].toString(),
                    value['panchayath'].toString(),
                    value['wardname'].toString(),
                    value['wardnumber'].toString()));
              }
            }
          });
          notifyListeners();
        }
        if (databaseHideEvent.snapshot.value != null) {
          Map<dynamic, dynamic> baseMap =
          databaseHideEvent.snapshot.value as Map;
          baseHideUnitList.clear();
          baseMap.forEach((key, value) {
            if (value['district'].toString() == selectedDistrict &&
                value['panchayath'].toString() == selectedPanchayath) {
              if (!baseHideUnitList
                  .map((item) =>
              (item.district + item.panchayath + item.wardName))
                  .contains(value['district'].toString() +
                  value['panchayath'].toString() +
                  value['wardname'].toString())) {
                baseHideUnitList.add(WardModel(
                    value['district'].toString(),
                    value['assembly'].toString(),
                    value['panchayath'].toString(),
                    value['wardname'].toString(),
                    value['wardnumber'].toString()));
              }
            }
          });
          notifyListeners();
        }
        allWards = jsonUnitList + baseUnitList;
        allWards.removeWhere((item1) =>
            baseHideUnitList.any((item2) =>
            (item1.wardName == item2.wardName &&
                item1.panchayath == item2.panchayath &&
                item1.assembly == item2.assembly &&
                item1.district == item2.district)));
        notifyListeners();
      });
    });
  }

  fetchWard() async {
    var jsonText =
    await rootBundle.loadString('assets/images/msf_paper_revolution.json');
    var jsonResponse = json.decode(jsonText.toString());

    Map<dynamic, dynamic> map = jsonResponse as Map;
    wards.clear();
    allWards.clear();
    map.forEach((key, value) {
      wards.add(WardModel(
          value['district'].toString(),
          value['assembly'].toString(),
          value['panchayath'].toString(),
          value['wardname'].toString(),
          value['wardnumber'].toString()));
      allWards = wards;
    });
  }

  Future<void> fetchAllWards() async {
    var jsonText =
    await rootBundle.loadString('assets/images/msf_paper_revolution.json');
    var jsonResponse = json.decode(jsonText.toString());

    mRoot
        .child('NewWards')
        .onValue
        .listen((databaseEvent) {
      // mRoot.child('HideWards').onValue.listen((databaseHideEvent) {
      Map<dynamic, dynamic> map = jsonResponse as Map;
      wards.clear();
      map.forEach((key, value) {
        if (!wards
            .map((item) => (item.district + item.panchayath + item.wardName))
            .contains(value['district'].toString() +
            value['panchayath'].toString() +
            value['wardname'].toString())) {
          wards.add(WardModel(
              value['district'].toString(),
              value['assembly'].toString(),
              value['panchayath'].toString(),
              value['wardname'].toString(),
              value['wardnumber'].toString()));
        }
      });

      newWards.clear();
      if (databaseEvent.snapshot.value != null) {
        Map<dynamic, dynamic> map1 = databaseEvent.snapshot.value as Map;
        map1.forEach((key, value) {
          if (!newWards
              .map((item) => (item.district + item.panchayath + item.wardName))
              .contains(value['district'].toString() +
              value['panchayath'].toString() +
              value['wardname'].toString())) {
            newWards.add(WardModel(
                value['district'].toString(),
                value['assembly'].toString(),
                value['panchayath'].toString(),
                value['wardname'].toString(),
                value['wardnumber'].toString()));
          }
        });
        print(newWards.length.toString() + "qqwwdedj44");

        notifyListeners();
      }

      // if (databaseHideEvent.snapshot.value != null) {
      //   Map<dynamic, dynamic> map1 = databaseHideEvent.snapshot.value as Map;
      //   wards.clear();
      //   map1.forEach((key, value) {
      //     if(!newWards.map((item) => (item.district+item.panchayath+item.wardName)).contains(value['district'].toString()+value['panchayath'].toString()+value['wardname'].toString())
      //         &&!wards.map((item) => (item.district+item.panchayath+item.wardName)).contains(value['district'].toString()+value['panchayath'].toString()+value['wardname'].toString())) {
      //       newWards.add(WardModel(
      //           value['district'].toString(),
      //           value['assembly'].toString(),
      //           value['panchayath'].toString(),
      //           value['wardname'].toString(),
      //           value['wardnumber'].toString()));
      //     }
      //   });
      //   print(newWards.length.toString() + "qqwwdedj44");
      //
      //   notifyListeners();
      // }
      allWards = wards + newWards;
      // allWards.removeWhere((item1) => newWards.any((item2) => (item1.wardName == item2.wardName && item1.panchayath == item2.panchayath && item1.assembly == item2.assembly && item1.district == item2.district )));

      notifyListeners();
      // });
    });
  }

  List<AreaModel> areaBaseList = [];
  List<AreaModel> areaJsonList = [];
  List<AreaModel> areaAllList = [];
  List<AreaModel> FilterareaAllList = [];

  Future<void> fetchAllArea() async {
    var jsonText = await rootBundle.loadString('assets/images/areaJson.json');
    var jsonResponse = json.decode(jsonText.toString());

    mRoot
        .child('area')
        .onValue
        .listen((databaseEvent) {
      Map<dynamic, dynamic> map = jsonResponse as Map;
      areaJsonList.clear();
      map.forEach((key, value) {
        areaJsonList.add(AreaModel(
          value['district'].toString(),
          value['area'].toString(),
        ));
      });

      areaBaseList.clear();
      if (databaseEvent.snapshot.value != null) {
        Map<dynamic, dynamic> map2 = databaseEvent.snapshot.value as Map;

        map2.forEach((key, value) {
          areaBaseList.add(AreaModel(
            value['district'].toString(),
            value['area'].toString(),
          ));
        });
        notifyListeners();
      }
      areaAllList = areaJsonList + areaBaseList;
      FilterareaAllList = areaAllList;
      notifyListeners();
    });
  }

  void getOccupation() {
    occupationList.clear();
    mRoot.child("OCCUPATION").once().then((value) {
      if (value.snapshot.exists) {
        occupationList.clear();
        Map<dynamic, dynamic> map = value.snapshot.value as Map;
        map.forEach((key, value) {
          occupationList.add(value.toString());
          notifyListeners();
        });
      }
    });
    notifyListeners();
  }

  Future<bool> checkNumberExist(String phone) async {
    var D = await db
        .collection("REGISTRATIONS")
        .where("PHONE", isEqualTo: phone)
        .where("STATUS", whereIn: ["APPROVED", "CO-APPROVED","PENDING"]).get();
    if (D.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkNumberExistForCoordinator(String phone) async {
    var D = await db
        .collection("COORDINATORS")
        .where("PHONE", isEqualTo: phone)
        .get();
    if (D.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void setPanchFun(var panjayath) {
    panchayathTc.text = panjayath;
    notifyListeners();
  }

  void clearText() {
    selectedProof = "Select Your Proof";
    fileImage = null;
    fileProof = null;
    nameTC.clear();
    pinWardTC.clear();
    phoneTC.clear();
    userAddress.clear();
    userAddress.clear();
    bloodGroupController.clear();
    occupationController.clear();
    areaController.clear();
    dateOfBirthController.clear();
    ageController.clear();
    occupationController.clear();
    homeAddressController.clear();
    areaController.clear();
    areaDistrictController.clear();
    areaControllerForCoordinator.clear();
    aadhaarNumberController.clear();
    genderController.clear();
    userFullAddress.clear();
    optionalPhoneTC.clear();
    panchayathTc.clear();
    districtTc.clear();
    assemblyTc.clear();
    _isChecked = false;
    firstTextFieldValue1 = "";
    notifyListeners();
  }

  Future<Uint8List> compressImage(final pickedFile) async {
    try {
      Uint8List uint8List = await pickedFile.readAsBytes();

      img.Image image = img.decodeImage(uint8List)!;
      final width = image.width;
      final height = image.height;
      print("width sp " + width.toString());
      print("height sp " + height.toString());
      img.Image compressedImage = img.copyResize(
        image,
        width: 600,
        height: 600,
        interpolation: img.Interpolation.linear,
      );

      List<int> compressedBytes = img.encodeJpg(compressedImage, quality: 30);

      return Uint8List.fromList(compressedBytes);
    } catch (e) {
      print('Error during image compression: $e');
      rethrow;
    }
  }

  Future<void> addRegisterCt(BuildContext context,
      String docId,
      String uid,
      String type,
      String uname,
      String uphone,
      String userArea,
      DateTime date,
      String areaDist,) async {
    Map<String, Object> map = HashMap();
    if(shareImage!=""){
      map['PROFILE_IMAGE'] = shareImage;

    }
    if (type == "ADMIN") {
      map["STATUS"] = "APPROVED";
      map["ADMIN_APPROVED_BY"] = uid;
      map["ADMIN_APPROVED_NAME"] = uname;
      map["ADMIN_APPROVED_PHONE"] = uphone;
      map["ADDED_BY"] = uid;
      map["ADDED_BY_NAME"] = uname;
      map["ADDED_BY_PHONE"] = uphone;
      map["ADMIN_APPROVED_DATE"] = date;
    } else if (type == "COORDINATOR") {
      map["STATUS"] = "CO-APPROVED";
      map["COORDINATOR_APPROVED_BY"] = uid;
      map["COORDINATOR_APPROVED_NAME"] = uname;
      map["COORDINATOR_APPROVED_PHONE"] = uphone;
      map["ADDED_BY"] = uid;
      map["ADDED_BY_NAME"] = uname;
      map["ADDED_BY_PHONE"] = uphone;
      print(userArea);
      print("dxrftyghjnk");
      map["COORDINATOR_APPROVED_DATE"] = date;
    } else {
      map["STATUS"] = "PENDING";
      map["ADDED_BY"] = "SELF_REGISTER";
    }
    db.collection("REGISTRATIONS").doc(docId).set(map, SetOptions(merge: true));

    MainProvider mainProvider =
    Provider.of<MainProvider>(context, listen: false);
    LoginProvider login = Provider.of<LoginProvider>(context, listen: false);
    if (type == "ADMIN") {
      db
          .collection("TOTAL")
          .doc("COUNTS")
          .update({"APPROVED": FieldValue.increment(1)});

      await mainProvider.getApprovedRegistration(true);
    } else {
      db
          .collection("TOTAL")
          .doc("COUNTS")
          .update({"PENDING": FieldValue.increment(1)});
      if (type == "COORDINATOR") {
        print(userArea);
        print("34567890");
        print(login.loginUserArea);
        await mainProvider.getCoordinatorPendingRegistration(userArea, true);
      }
    }
    callNextReplacement(
        RegistrationSuccessPage(
          name: uname,
          phone: uphone,
          type: type,
          uid: uid,
          image: shareImage,
          userName: nameTC.text,
          userPhone: phoneTC.text,
          area: userArea,
          areaDistrict: areaDist,
        ),
        context);
  }

  String shareImage = "";
  String proofImage = "";

  Future<void> addRegisterUser(BuildContext context,
      String uid,
      String type,
      String uname,
      String uphone,
      String userArea,
      DateTime date,
      String id,
      String userAreaDistrict,) async {
    Map<String, Object> map = HashMap();

    if (!occupationList
        .contains(occupationController.text.toString().toUpperCase())) {
      addOcupation();
      getOccupation();
    }

    map["ID"] = id;
    map["NAME"] = nameTC.text;
    map["PHONE"] = phoneTC.text;
    map["ADDRESS"] = userAddress.text;
    map["BLOOD_GROUP"] = bloodGroupController.text;
    map["OCCUPATION"] = occupationController.text;
    if (type != "COORDINATOR") {
      map["AREA_DISTRICT"] = selectedArea!.district;
      map["AREA"] = areaController.text;
    } else {
      map["AREA_DISTRICT"] = userAreaDistrict;
      map["AREA"] = userArea;
    }
    map["DATE_OF_BIRTH"] = dateOfBirthController.text;
    map["AGE"] = ageController.text;
    map["OCCUPATION"] = occupationController.text;
    map["DEVICE_ID"] = strDeviceID!;
    map["TYPE"] = "MEMBER";
    map["WARD"] = pinWardTC.text;
    map["WARD_NAME"] = pinWardTC.text;
    map["STATUS"] = "ATTEMPT";

    map["DISTRICT"] = selectedWard!.district;
    map["ASSEMBLY"] = selectedWard!.assembly;
    map["PANCHAYATH"] = selectedWard!.panchayath;
    map["WARD_NUMBER"] = selectedWard!.wardNumber;

    // map["AADHAAR_NUMBER"] = aadhaarNumberController.text;
    map["GENDER"] = genderController.text;
    map["FULL_ADDRESS"] = userFullAddress.text;
    map["SECONDARY_NUMBER"] = optionalPhoneTC.text;
    map["REGISTERED_DATE"] = date;
    map['PROFILE_IMAGE'] = shareImage;
    map["ID_NUMBER"] = aadhaarNumberController.text;
    map["ID_NAME"] = selectedProof;
    map["ID_IMAGE"] = proofImage;

    db.collection("REGISTRATIONS").doc(id).set(map, SetOptions(merge: true));
    // finish(context);
  }

  Future<void> editRegisterUser(BuildContext context,
      String id,
      String uid,
      String type,
      String uname,
      String uphone,
      String userPhone,
      String userArea,
      String userAreaDistrict,
      String userWard,
      String userImage,
      String userDistrict,
      String userPanchayath,
      String userAssembly,
      String coArea,
      String idImage,
      String idName,) async {
    Map<String, Object> map = HashMap();
    DateTime date = DateTime.now();
    bool checkPhoneNumber = false;
    if (phoneTC.text != userPhone) {
      checkPhoneNumber = await checkNumberExist(phoneTC.text);
    }

    if (!checkPhoneNumber) {
      if (!occupationList
          .contains(occupationController.text.toString().toUpperCase())) {
        addOcupation();
        getOccupation();
      }
      map["EDITED_BY"] = uid;
      map["EDITED_NAME"] = uname;
      map["EDITED_PHONE"] = uphone;
      map["EDITED_DATE"] = date;

      map["NAME"] = nameTC.text;
      map["PHONE"] = phoneTC.text;
      map["ADDRESS"] = userAddress.text;
      map["BLOOD_GROUP"] = bloodGroupController.text;
      map["OCCUPATION"] = occupationController.text;
      map["AREA"] = userArea;
      map["AREA_DISTRICT"] = userAreaDistrict;
      map["DATE_OF_BIRTH"] = dateOfBirthController.text;
      map["AGE"] = ageController.text;
      map["OCCUPATION"] = occupationController.text;
      map["WARD"] = userWard;
      map["WARD_NAME"] = userWard;
      map["DISTRICT"] = userDistrict;
      map["ASSEMBLY"] = userAssembly;
      map["PANCHAYATH"] = userPanchayath;
      map["WARD_NUMBER"] = userWard;

      map["AADHAAR_NUMBER"] = aadhaarNumberController.text;
      map["GENDER"] = genderController.text;
      map["FULL_ADDRESS"] = userFullAddress.text;
      map["SECONDARY_NUMBER"] = optionalPhoneTC.text;
      map["ID_NUMBER"] = aadhaarNumberController.text;
      map["ID_NAME"] = idName;
      map["ID_IMAGE"] = idImage;
      String shareImage = "";
      if (fileImage != null) {
        final compImage = await compressImage(fileImage);

        String time =
            DateTime
                .now()
                .millisecondsSinceEpoch
                .toString() + "compressed";
        ref3 = FirebaseStorage.instance.ref().child(time);
        await ref3.putData(compImage).whenComplete(() async {
          await ref3.getDownloadURL().then((value2) {
            map['PROFILE_IMAGE'] = value2;
            shareImage = value2;
            notifyListeners();
          });
          notifyListeners();
        });
        notifyListeners();
      } else {
        map['PROFILE_IMAGE'] = userImage;
      }
      if (fileProof != null) {
        final compImage = await compressImage(fileProof);

        String time =
            DateTime
                .now()
                .millisecondsSinceEpoch
                .toString() + "compressed";
        ref3 = FirebaseStorage.instance.ref().child(time);
        await ref3.putData(compImage).whenComplete(() async {
          await ref3.getDownloadURL().then((value2) {
            map['ID_IMAGE'] = value2;

            notifyListeners();
          });
          notifyListeners();
        });
        notifyListeners();
      } else {
        map['ID_IMAGE'] = idImage;
      }

      db.collection("REGISTRATIONS").doc(id).set(map, SetOptions(merge: true));
      MainProvider mainProvider =
      Provider.of<MainProvider>(context, listen: false);
      if (type == "ADMIN") {
        mainProvider.getPendingRegistration(true);
        mainProvider.getApprovedRegistration(true);
      } else if (type == "COORDINATOR") {
        mainProvider.getCoordinatorPendingRegistration(coArea, true);
      }

      finish(context);
      finish(context);
      finish(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black, content: Text("Edit SuccessFully")));
    } else {
      finish(context);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black,
          content: Text("Number Already Exist")));
    }
  }

  Future<void> addCoordinator(BuildContext context,
      String uid,
      String type,
      String uname,
      String uphone,) async {
    Map<String, Object> map = HashMap();
    String id = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();

    bool checkPhoneNumber = false;
    checkPhoneNumber = await checkNumberExist(phoneTC.text);
    print(areaController.text);
    print(selectedArea!.district);
    print("dyfghjklhgyuf");
    // value45.loaderDialogNormal(context);
    if (!checkPhoneNumber) {
      map["NAME"] = nameTC.text;
      map["PHONE"] = phoneTC.text;
      map["ADDRESS"] = userAddress.text;
      map["ID"] = id;
      map["DEVICE_ID"] = strDeviceID!;
      map["TYPE"] = "COORDINATOR";
      map["STATUS"] = "SUCCESS";
      map["ADDED_BY"] = uid;
      map["AREA"] = areaController.text;
      map["AREA_DISTRICT"] = selectedArea!.district;
      map["ADDED_ADMIN_NAME"] = uname;
      map["ADDED_ADMIN_PHONE"] = uphone;
      map["ADDED_DATE"] = DateTime.now();
      if (fileImage != null) {
        String time = DateTime
            .now()
            .millisecondsSinceEpoch
            .toString();
        ref3 = FirebaseStorage.instance.ref().child(time);
        await ref3.putFile(fileImage!).whenComplete(() async {
          await ref3.getDownloadURL().then((value2) {
            map['PROFILE_IMAGE'] = value2;
            notifyListeners();
          });
          notifyListeners();
        });
        notifyListeners();
      } else {
        map['PROFILE_IMAGE'] = "";
      }
      db.collection("COORDINATORS").doc(id).set(map, SetOptions(merge: true));
      db.collection("USERS").doc(id).set(map, SetOptions(merge: true));
      finish(context);
      finish(context);
      db.collection("REGISTRATIONS").doc(id).set(map, SetOptions(merge: true));
      MainProvider mainProvider =
      Provider.of<MainProvider>(context, listen: false);
      mainProvider.fetchCoordinators();
      clearText();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black,
          content: Text("Coordinator Add Successfully")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black,
          content: Text("Phone Number Already Exist")));
    }
  }

  Future<void> editCordinatorDetaild(BuildContext context,
      String id,
      String uid,
      String uname,
      String uphone,
      String coordinatorPhone,
      String coordinatorArea) async {
    Map<String, Object> map = HashMap();
    bool checkPhoneNumber = false;

    if (phoneTC.text != coordinatorPhone) {
      checkPhoneNumber = await checkNumberExistForCoordinator(phoneTC.text);
    }
    if (!checkPhoneNumber) {
      map["NAME"] = nameTC.text;
      map["PHONE"] = phoneTC.text;
      map["ADDRESS"] = userAddress.text;
      map["DEVICE_ID"] = strDeviceID!;
      map["TYPE"] = "COORDINATOR";
      map["STATUS"] = "SUCCESS";
      map["EDITED_BY"] = uid;
      map["AREA"] = areaControllerForCoordinator.text;
      if (areaControllerForCoordinator.text != coordinatorArea) {
        map["AREA_DISTRICT"] = selectedArea!.district;
      }
      map["EDITED_ADMIN_NAME"] = uname;
      map["EDITED_ADMIN_PHONE"] = uphone;
      map["EDITED_DATE"] = DateTime.now();
      if (fileImage != null) {
        String time = DateTime
            .now()
            .millisecondsSinceEpoch
            .toString();
        ref3 = FirebaseStorage.instance.ref().child(time);
        await ref3.putFile(fileImage!).whenComplete(() async {
          await ref3.getDownloadURL().then((value2) {
            map['PROFILE_IMAGE'] = value2;
            notifyListeners();
          });
          notifyListeners();
        });
        notifyListeners();
      } else {
        map['PROFILE_IMAGE'] = proImage1;
      }
      db.collection("COORDINATORS").doc(id).set(map, SetOptions(merge: true));
      db.collection("USERS").doc(id).set(map, SetOptions(merge: true));
      finish(context);
      finish(context);
      clearText();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black, content: Text("Edit Successfully")));
    } else {
      finish(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.black,
          content: Text("Phone Number Already Exist")));
    }
  }

  void showBottomSheet(BuildContext context,
      String from,
      String id,) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            )),
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(
                      Icons.camera_enhance_sharp,
                      // color: cl172f55,
                    ),
                    title: const Text(
                      'Camera',
                    ),
                    onTap: () =>
                    {imageFromCamera(from, id), Navigator.pop(context)}),
                ListTile(
                    leading: const Icon(
                      Icons.photo,
                      //color: cl172f55
                    ),
                    title: const Text(
                      'Gallery',
                    ),
                    onTap: () =>
                    {imageFromGallery(from, id), Navigator.pop(context)}),
              ],
            ),
          );
        });
    // ImageSource
  }

  imageFromCamera(String from, String id) async {
    final pickedFile =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 15);

    if (pickedFile != null) {
      _cropImage(pickedFile.path, from, id);
    } else {}
    if (pickedFile!.path.isEmpty) {
      retrieveLostData();
    }

    notifyListeners();
  }

  imageFromGallery(String from, String id) async {
    final pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (pickedFile != null) {
      _cropImage(pickedFile.path, from, id);
    } else {}
    if (pickedFile!.path.isEmpty) {
      retrieveLostData();
    }

    notifyListeners();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      fileImage = File(response.file!.path);

      notifyListeners();
    }
  }

  Future<void> _cropImage(String path,
      String from,
      String id,) async {
    print("hai$path");
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid && from == "PROOF"
          ? [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ]
          : [
        CropAspectRatioPreset.square,
        // CropAspectRatioPreset.ratio3x2,
        // CropAspectRatioPreset.original,
        // CropAspectRatioPreset.ratio4x3,
        // CropAspectRatioPreset.ratio16x9,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    print("hello$path");
    if (from == "PROOF") {
      if (croppedFile != null) {
        fileProof = File(croppedFile.path);
        _containerHeight = true;
        final compImage = await compressImage(fileProof!);
        if (fileProof != null) {
          String time =
              DateTime
                  .now()
                  .millisecondsSinceEpoch
                  .toString() + "compressed";
          ref3 = FirebaseStorage.instance.ref().child(time);
          await ref3.putData(compImage).whenComplete(() async {
            await ref3.getDownloadURL().then((value2) async {
              proofImage = value2;
              await addImageAttempt(id, value2, from);
              notifyListeners();
            });
            notifyListeners();
          });
          notifyListeners();
        }
      }
    } else {
      if (croppedFile != null) {
        fileImage = File(croppedFile.path);

        final compImage = await compressImage(fileImage!);
        if (fileImage != null) {
          String time =
              DateTime
                  .now()
                  .millisecondsSinceEpoch
                  .toString() + "compressed";
          ref3 = FirebaseStorage.instance.ref().child(time);
          await ref3.putData(compImage).whenComplete(() async {
            await ref3.getDownloadURL().then((value2) async {
              shareImage = value2;
              await addImageAttempt(id, value2, from);
              notifyListeners();
            });
            notifyListeners();
          });
          notifyListeners();
        } else {
          // map['PROFILE_IMAGE'] = "";
        }
      }
    }

    notifyListeners();
  }

  addImageAttempt(String id,
      String image,
      String from,) {
    Map<String, Object> map = HashMap();
    if (from == "PROOF") {
      map["PROOF"] = image;
    } else {
      map["PROFILE"] = image;
    }
    db.collection("ATTEMPTS").doc(id).set(map, SetOptions(merge: true));
    notifyListeners();
  }

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void updateSelectedDate(DateTime newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }

  int calculateAge() {
    DateTime currentDate = DateTime.now();
    int differenceInYears = currentDate.year - _selectedDate.year;

    if (currentDate.month < _selectedDate.month ||
        (currentDate.month == _selectedDate.month &&
            currentDate.day < _selectedDate.day)) {
      differenceInYears--;
    }

    return differenceInYears;
  }

  void updateControllers() {
    final formattedDate = '${_selectedDate.day.toString().padLeft(2, '0')}/'
        '${_selectedDate.month.toString().padLeft(2, '0')}/'
        '${_selectedDate.year}';

    dateOfBirthController.text = formattedDate;
    ageController.text = '${calculateAge()}';
  }

  Future<void> loaderDialogNormal(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0XFFD4AF37)),
            ),
          );
        });
  }

  DateTime scheduledTimeFrom = DateTime.now();

  List<RequestMemberModel> allMyRegistrations = [];
  List<RequestMemberModel> filterAllMyRegistrations = [];
  var outputDayNode = DateFormat('dd MMM yyyy  hh:mm a');

  void fetchMyRegistrations(String deviceId) {
    print("jkl");

    allMyRegistrations.clear();
    filterAllMyRegistrations.clear();
    db
        .collection("REGISTRATIONS")
        .orderBy("REGISTERED_DATE", descending: true)
        .where("DEVICE_ID", isEqualTo: deviceId)
        .where("STATUS", whereIn: ["APPROVED", "PENDING", "CO-APPROVED"])
        .snapshots()
        .listen((value) {
      if (value.docs.isNotEmpty) {
        print("dxgfhjiouiygftghbjkl");
        allMyRegistrations.clear();
        filterAllMyRegistrations.clear();
        for (var elements in value.docs) {
          Map<dynamic, dynamic> map = elements.data();

          String time = "";
          if (map["REGISTERED_DATE"] != null) {
            time = outputDayNode
                .format(map["REGISTERED_DATE"].toDate())
                .toString();
            Timestamp stttTo = map["REGISTERED_DATE"];
            scheduledTimeFrom = DateTime.parse(stttTo.toDate().toString());
          }

          allMyRegistrations.add(RequestMemberModel(
              false,
              elements.id,
              map["NAME"],
              map['PHONE'],
              map["ADDRESS"],
              map["AGE"],
              map["AREA"] ?? "",
              map["ASSEMBLY"] ?? "",
              map['BLOOD_GROUP'],
              map['DATE_OF_BIRTH'],
              map['DISTRICT'] ?? "",
              map['OCCUPATION'],
              map['PANCHAYATH'] ?? "",
              map['PROFILE_IMAGE'],
              map['STATUS'],
              map['TYPE'],
              map['WARD'] ?? "",
              map['WARD_NAME'] ?? "",
              map['WARD_NUMBER'] ?? "",
              time,
              map["AADHAAR_NUMBER"] ?? "",
              map["FULL_ADDRESS"] ?? "",
              map["GENDER"] ?? "",
              map["SECONDARY_NUMBER"] ?? "",
              map["COORDINATOR_APPROVED_NAME"] ?? "",
              map["COORDINATOR_APPROVED_PHONE"] ?? "",
              map["ADMIN_APPROVED_NAME"] ?? "",
              map["ADMIN_APPROVED_PHONE"] ?? "",
              map["COORDINATOR_REJECTED_NAME"] ?? "",
              map["COORDINATOR_REJECTED_PHONE"] ?? "",
              map["ADMIN_REJECTED_NAME"] ?? "",
              map["ADMIN_REJECTED_PHONE"] ?? "",
              scheduledTimeFrom,
              map["AREA_DISTRICT"] ?? "",
              map["ID_NUMBER"] ?? "",
              map["ID_NAME"] ?? "",
              map["ID_IMAGE"] ?? "",

          ));
          filterAllMyRegistrations = allMyRegistrations;
          notifyListeners();
        }
      }
    });
  }

  filterRegisteredUsers(String item) {
    filterAllMyRegistrations = allMyRegistrations
        .where((element) =>
    element.name.toLowerCase().contains(item.toLowerCase()) ||
        element.phone.toLowerCase().contains(item.toLowerCase()))
        .toList();

    notifyListeners();
  }

  bool buttonShow = true;

  void showButton() {
    buttonShow = false;
    notifyListeners();
  }

  void deleteAdmin(String coId, String name, String adminId, String phone) {
    Map<String, Object> map = HashMap();
    map["STATUS"] = "DELETED";
    map["DELETED_ADMIN_NAME"] = name;
    map["DELETED_ADMIN_ID"] = adminId;
    map["DELETED_ADMIN_NUMBER"] = phone;
    map["DELETED_DATE"] = DateTime.now();
    db.collection("COORDINATORS").doc(coId).set(map, SetOptions(merge: true));
    db.collection("USERS").doc(coId).delete();

    notifyListeners();
  }

  void editCoordinator(String name, String phone, String address, String area,
      district, String proImage) {
    print(area);
    print("esrdtfyghjklm");
    nameTC.text = name;
    phoneTC.text = phone;
    userAddress.text = address;
    proImage1 = proImage;
    areaControllerForCoordinator.text = area;

    // district = district;
    notifyListeners();
  }

  void editRegister(String name,
      String phone,
      String presentAddress,
      String area,
      String gender,
      String dateofBirth,
      String aadhaar,
      String permenantAddress,
      String selectWard,
      String bloodGroup,
      String occupation,
      String age,
      String optionalNum,
      String panchayath,
      String district,
      String assembly,
      String areaDistrict,
      String idName,
      String idImage,
      String idNumber,) {
    fetchSelectedUnits(district, panchayath);
    nameTC.text = name;
    phoneTC.text = phone;
    userAddress.text = presentAddress;
    bloodGroupController.text = bloodGroup;
    occupationController.text = occupation;
    areaController.text = area;
    areaDistrictController.text = areaDistrict;
    dateOfBirthController.text = dateofBirth;
    ageController.text = age;
    occupationController.text = occupation;
    pinWardTC.text = selectWard;
    aadhaarNumberController.text = aadhaar;
    genderController.text = gender;
    userFullAddress.text = permenantAddress;
    firstTextFieldValue1 = permenantAddress;
    optionalPhoneTC.text = optionalNum;
    panchayathTc.text = panchayath;
    assemblyTc.text = assembly;
    districtTc.text = district;
    _isChecked = selectWard != "" ? false : true;
    if (idName == "") {
      selectedProof = "Select Your Proof";
    } else {
      selectedProof = idName;
    }
    if (idNumber != "") {
      aadhaarNumberController.text = idNumber;
    }

    notifyListeners();
  }

  // void fetchCar

  filterArea(String item) {
    FilterareaAllList = areaAllList
        .where((element) =>
    element.area.toLowerCase().contains(item.toLowerCase()) ||
        element.district.toLowerCase().contains(item.toLowerCase()))
        .toList();

    notifyListeners();
  }

  Future<void> shareIDCard(
      ScreenshotController screenshotControllerStatus) async {
    print("HHHHHHHHHHHHHH" + screenshotControllerStatus.toString());

    await screenshotControllerStatus.capture().then((Uint8List? image) async {
      print("HHHHHHHHHHHHHH555" + image.toString());

      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        await imagePath.writeAsBytes(image);
        print("sfwsdfgfdsg" + imagePath.toString());

        /// Share Plugin
        await Share.shareFiles([imagePath.path]);
      }

      // Handle captured image
    });
  }

  registrationAlert(BuildContext context, Size size) {
    TextStyle style = TextStyle(
        fontSize: 12,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w700,
        color: maincolor);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) =>
          AlertDialog(
            backgroundColor: Colors.white,
            elevation: 20,
            content: SizedBox(
              width: size.width / 1.1,
              // height: 400,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Instructions",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            color: maincolor)),
                    Text("* Please ensure all fields are filled accurately. ",
                        style: style),
                    Text(
                        "* Kindly upload a clear photo that accurately shows the face to be printed on the ID card",
                        style: style),
                    Text(
                        "* The permanent address field is for adding the native address. If your permanent address is not provided, your membership will not be approved",
                        style: style),
                    Text(
                        "* The number of any one of the government approved identification cards (Aadhar Card, Election ID, Driving License, Passport) and its copy must be uploaded.",
                        style: style),
                    SizedBox(
                      height: 10,
                    ),
                    Text("* എല്ലാ കോളങ്ങളും കൃത്യമായി പൂരിപ്പിക്കുക",
                        style: style),
                    Text(
                        "* ഐഡി കാർഡിൽ പ്രിൻറ് ചെയ്തു വരാനുള്ളതുകൊണ്ട് മുഖം വ്യക്തമാക്കുന്ന ഫോട്ടോ അപ്‌ലോഡ് ചെയ്യുക",
                        style: style),
                    Text(
                        "* പെർമെനന്റ് അഡ്രസ് എന്ന ഫീൽഡ് നാട്ടിലെ അഡ്രസ് ആഡ് ചെയ്യാനുള്ളതാണ്. പെർമെനന്റ് അഡ്രസ്  നല്കിയിട്ടില്ലങ്കിൽ നിങ്ങളുടെ മെമ്പർഷിപ് അപ്പ്രൂവൽ ലഭിക്കുന്നതല്ല ",
                        style: style),
                    Text(
                        "* സർക്കാർ അംഗീകരിച്ച തിരിച്ചറിയൽ കാർഡുകളിൽ (ആധാർ കാർഡ് , ഇലക്ഷൻ ഐ ഡി , ഡ്രൈവിംഗ് ലൈസൻസ് , പാസ്പോർട്ട്) ഏതെങ്കിലും ഒന്നിന്റെ നമ്പറും അതിന്റെ കോപ്പിയും നിർബന്ധമായും അപ്‌ലോഡ് ചെയ്യേണ്ടതാണ്.",
                        style: style),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  finish(context);
                },
                child: Container(
                    width: 100,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: maincolor),
                    alignment: Alignment.center,
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 11),
                    )),
              ),
            ],
          ),
    );
  }


// List<RequestMemberModel>fullList=[];
// var outputDayAndTime = DateFormat('dd/MM/yyy h:mm a');

//   void fetchFullData(){
//     db.collection("REGISTRATIONS").where("STATUS",whereIn: ["APPROVED","CO-APPROVED","PENDING",]).get().then((value) {
//
//       if(value.docs.isNotEmpty){
//         print(value.docs.length);
//         print("HBJKNLM:<kml");
//         for(var element in value.docs){
//           Map<dynamic, dynamic> regMap = element.data();
//
//           String time = "";
//           if (regMap["REGISTERED_DATE"] != null) {
//             time = outputDayNode
//                 .format(regMap["REGISTERED_DATE"].toDate())
//                 .toString();
//             Timestamp stttTo = regMap["REGISTERED_DATE"];
//             scheduledTimeFrom = DateTime.parse(stttTo.toDate().toString());
//           }
//
//           fullList.add(RequestMemberModel(
//             false,
//             element.id.toString(),
//             regMap["NAME"] ?? "",
//             regMap["PHONE"] ?? "",
//             regMap["ADDRESS"] ?? "",
//             regMap["AGE"] ?? "",
//             regMap["AREA"] ?? "",
//             regMap["ASSEMBLY"] ?? "",
//             regMap["BLOOD_GROUP"] ?? "",
//             regMap["DATE_OF_BIRTH"] ?? "",
//             regMap["DISTRICT"] ?? "",
//             regMap["OCCUPATION"] ?? "",
//             regMap["PANCHAYATH"] ?? "",
//             regMap["PROFILE_IMAGE"] ?? "",
//             regMap["STATUS"] ?? "",
//             regMap["TYPE"] ?? "",
//             regMap["WARD"] ?? "",
//             regMap["WARD_NAME"] ?? "",
//             regMap["WARD_NUMBER"] ?? "",
//             time,
//             regMap["AADHAAR_NUMBER"] ?? "",
//             regMap["FULL_ADDRESS"] ?? "",
//             regMap["GENDER"] ?? "",
//             regMap["SECONDARY_NUMBER"] ?? "",
//             regMap["COORDINATOR_APPROVED_NAME"] ?? "",
//             regMap["COORDINATOR_APPROVED_PHONE"] ?? "",
//             regMap["ADMIN_APPROVED_NAME"] ?? "",
//             regMap["ADMIN_APPROVED_PHONE"] ?? "",
//             regMap["COORDINATOR_REJECTED_NAME"] ?? "",
//             regMap["COORDINATOR_REJECTED_PHONE"] ?? "",
//             regMap["ADMIN_REJECTED_NAME"] ?? "",
//             regMap["ADMIN_REJECTED_PHONE"] ?? "",
//             scheduledTimeFrom,
//             regMap["AREA_DISTRICT"] ?? "",
//             regMap["ID_NUMBER"] ?? "",regMap["ID_NAME"] ?? "",regMap["ID_IMAGE"] ?? "",
//             time,
//
//
//           ));
//         }
//
//         createExcelPaymentReport();
//         notifyListeners();
//       }
//     }
//     );
//   }
//
//
//   void createExcelPaymentReport() async {
//     final xlsio.Workbook workbook = xlsio.Workbook();
//     final xlsio.Worksheet sheet = workbook.worksheets[0];
//     final List<Object> list = [
//       " ind",
//       " id",
//       " name",
//       " phone",
//       " address",
//       " age",
//       " area",
//       " areaDistrict",
//       " assembly",
//       " bloodGroup",
//       " dob",
//       " district",
//       " occupation",
//       " panchayath",
//       " image",
//       " status",
//       " type",
//       " ward",
//       " wardName",
//       " wardNumber",
//       " time",
//       " fullAddress",
//       " aadhaar",
//       " gender",
//       " seconderyNumber",
//       " coApprovedName",
//       " coApprovedPhone",
//       " adminApprovedName",
//       " adminApprovedPhone",
//       " coRejectedName",
//       " coRejectedPhone",
//       " adminRejectedName",
//       " adminRejectedPhone",
//       " regDateTime",
//       " proofName",
//       " proofNumber",
//       " fetchProofImage",
//     ];
//
//     const int firstRow = 1;
//
//     const int firstColumn = 1;
//
//     const bool isVertical = false;
//
//     sheet.importList(list, firstRow, firstColumn, isVertical);
//     int i = 1;
//     int last = 0;
//     double total = 0;
//
//     for (var element in fullList) {
//       int time = 00000000000;
//       try {
//         time = int.parse(element.ti);
//       } catch (e) {}
//       i++;
//       final List<Object> list = [
//         // getDate(time.toString()),
//         // getHour(time.toString()),
//         // getTime(time.toString()),
//
//         element. ind,
//         element. id,
//         element. name,
//         element. phone,
//         element. address,
//         element. age,
//         element. area,
//         element. areaDistrict,
//         element. assembly,
//         element. bloodGroup,
//         element. dob,
//         element. district,
//         element. occupation,
//         element. panchayath,
//         element. image,
//         element. status,
//         element. type,
//         element. ward,
//         element. wardName,
//         element. wardNumber,
//         element. time,
//         element. fullAddress,
//         element. aadhaar,
//         element. gender,
//         element. seconderyNumber,
//         element. coApprovedName,
//         element. coApprovedPhone,
//         element. adminApprovedName,
//         element. adminApprovedPhone,
//         element. coRejectedName,
//         element. coRejectedPhone,
//         element. adminRejectedName,
//         element. adminRejectedPhone,
//         element. regDateTime,
//         element. proofName,
//         element. proofNumber,
//         element. fetchProofImage,
//       ];
//       // total += double.parse(element.ti);
//       final int firstRow = i;
//
//       const int firstColumn = 1;
//
//       const bool isVertical = false;
//       last = i;
//       sheet.importList(list, firstRow, firstColumn, isVertical);
//     }
//     final List<Object> list1 = ["Grand Total", total];
//
//     sheet.importList(list1, last + 1, 5, isVertical);
//
//     sheet.getRangeByIndex(1, 1, 1, 4).autoFitColumns();
//     final List<int> bytes = workbook.saveAsStream();
//     workbook.dispose();
//     if
//     (!kIsWeb){
//       final String path = (await getApplicationSupportDirectory()).path;
//       final String fileName = '$path/Output.xlsx';
//       final File file = File(fileName);
//       await file.writeAsBytes(bytes, flush: true);
//       // OpenFile.open(fileName);
//     }
//     else{
//
//     var blob = web_file.Blob(
//         [bytes],
//         'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
//         'native');
//
//     var anchorElement = web_file.AnchorElement(
//       href: web_file.Url.createObjectUrlFromBlob(blob).toString(),
//     )
//       ..setAttribute("download", "data.xlsx")
//       ..click();
//     //}
//   }

}
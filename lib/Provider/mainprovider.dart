import 'dart:collection';
import 'dart:io';

import 'package:aikmccbangalore/Constant/my_colors.dart';
import 'package:aikmccbangalore/Constant/my_functions.dart';
import 'package:aikmccbangalore/Provider/UserProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:universal_html/html.dart' as web_file;

import '../Constant/images.dart';
import '../Constant/widgets.dart';
import '../Models/CoordinatorModel.dart';
import '../Models/RequestMemberModel.dart';
import '../Strings.dart';
import '../UpdateScreen.dart';
import 'LoginProvider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;

class MainProvider extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();

  var outputDayNode = DateFormat('dd MMM yyyy  hh:mm a');
  int activeIndex = 0;

  String userAreaDistrict = "";
  String idName = "";
  String idImage = "";
  String idNumber = "";
  String adminRejectedPhone = "";
  String dateOfBirth = "";
  String ward = "";
  String panchayath = "";
  String homeDistrict = "";
  String assembly = "";
  String coRejectedPhone = "";
  String adminApprovedPhone = "";
  String coApprovedPhone = "";
  String seconderyPhone = "";
  String aadhaar = "";
  String gender = "";
  String fullAddres = "";
  String bloodGroup = "";
  String occupation = "";
  String age = "";
  String homeAddress = "";
  String filterArea = "";

  bool isExpanded = false;
  bool filterOnApproved = false;
  bool filterOnPending = false;
  bool filterOnRejected = false;
  String contactNumber = "";
  String contactNumber2 = "";

  MainProvider() {
    fetchDetails();
  }

  Future<void> lockApp() async {
    mRoot.child("0").onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> map = event.snapshot.value as Map;
        List<String> versions = map['APPVERSION'].toString().split(',');
        for (var ee in versions) {}

        if (!versions.contains(appVersion)) {
          String address = map['ADDRESS'].toString();
          String button = map['BUTTON'].toString();
          String text = map['TEXT'].toString();

          runApp(MaterialApp(
            home: Update(
              ADDRESS: address,
              button: button,
              text: text,
            ),
          ));
        }
      }
    });
  }

  void fetchDetails() {
    mRoot.child('0').onValue.listen((event) {
      if (event.snapshot.exists) {
        Map<dynamic, dynamic> map = event.snapshot.value as Map;
        contactNumber = map['PhoneNumber'] ?? '';
        contactNumber2 = map['PhoneNumber2'] ?? '';
      }
    });
  }

  List<String> carosalImages = [];

  Future<void> carouselImages() async {
    mRoot.child("carousel").onValue.listen((event) {
      if (event.snapshot.exists) {
        carosalImages.clear();

        Map<dynamic, dynamic> map = event.snapshot.value as Map;
        map.forEach((key, value) {
          carosalImages.add(value.toString());
        });
        notifyListeners();
      }
    });
  }

  fetchTotal() {
    db.collection("TOTAL").doc("COUNTS").snapshots().listen((event) {
      Map<dynamic, dynamic> userMap = event.data() as Map;

      if (event.exists) {
        approvedLength = userMap["APPROVED"];
        pendingLength = userMap["PENDING"];
        rejectedLength = userMap["REJECTED"];
        notifyListeners();
      }
    });
  }

  List<MemberModelClass> approvedRegisterModelList = [];
  List<MemberModelClass> pendingRegisterModelList = [];
  List<MemberModelClass> rejectedRegisterModelList = [];
  List<CoordinatorModel> coordinatorModelList = [];
  List<MemberModelClass> filterApprovedRegisterModelList = [];
  List<MemberModelClass> filterPendingRegisterModelList = [];
  List<MemberModelClass> filterRejectedRegisterModelList = [];
  List<CoordinatorModel> filterCoordinatorModelList = [];

  Future<void> getPendingRegistration(bool firstFetch,
      [dynamic lastDoc]) async {
    var collectionRef;
    if (firstFetch) {
      pendingLimit = limit;
      pendingRegisterModelList.clear();
      filterPendingRegisterModelList.clear();
      collectionRef = await db
          .collection("REGISTRATIONS")
          .where("STATUS", whereIn: ["PENDING", "CO-APPROVED"])
          .orderBy("REGISTERED_DATE", descending: true)
          .limit(limit);
    } else {
      pendingLimit = pendingLimit + limit;

      collectionRef = db
          .collection("REGISTRATIONS")
          .where("STATUS", whereIn: ["PENDING", "CO-APPROVED"])
          .orderBy("REGISTERED_DATE", descending: true)
          .startAfter([lastDoc])
          .limit(limit);
    }
    collectionRef.get().then((event) async {
      print("puygfcgvhbjnk");
      if (event.docs.isNotEmpty) {
        for (var element in event.docs) {
          Map<dynamic, dynamic> regMap = element.data();
          String time = "";
          if (regMap["REGISTERED_DATE"] != null) {
            time = outputDayNode
                .format(regMap["REGISTERED_DATE"].toDate())
                .toString();
            Timestamp stttTo = regMap["REGISTERED_DATE"];
            scheduledTimeFrom = DateTime.parse(stttTo.toDate().toString());
          }

          pendingRegisterModelList.add(MemberModelClass(
              element.id.toString(),
              regMap["NAME"] ?? "",
              regMap["PHONE"] ?? "",
              regMap["ADDRESS"] ?? "",
              regMap["AREA"] ?? "",
              regMap["STATUS"] ?? "",
              regMap["COORDINATOR_APPROVED_NAME"] ?? "",
              regMap["ADMIN_APPROVED_NAME"] ?? "",
              regMap["ADMIN_REJECTED_NAME"] ?? "",
              regMap["COORDINATOR_REJECTED_NAME"] ?? "",
              regMap["PROFILE_IMAGE"] ?? "",
              time,
              scheduledTimeFrom));
        }
        filterPendingRegisterModelList = pendingRegisterModelList;
        print(pendingRegisterModelList.length.toString() + "ASdsdv ");

        notifyListeners();
      }
    });

    notifyListeners();
  }

  Future<void> fetchUserFullDetailes(String userId) async {
    db.collection("REGISTRATIONS").doc(userId).get().then((value) {
      if (value.exists) {
        Map<dynamic, dynamic> regMap = value.data() as Map;
        //
        userAreaDistrict = regMap["AREA_DISTRICT"] ?? "";
        idName = regMap["ID_NAME"] ?? "";
        idImage = regMap["ID_IMAGE"] ?? "";
        idNumber = regMap["ID_NUMBER"] ?? "";
        adminRejectedPhone = regMap["ADMIN_REJECTED_PHONE"] ?? "";
        dateOfBirth = regMap["DATE_OF_BIRTH"] ?? "";
        ward = regMap["WARD"] ?? "";
        panchayath = regMap["PANCHAYATH"] ?? "";
        homeDistrict = regMap["DISTRICT"] ?? "";
        assembly = regMap["ASSEMBLY"] ?? "";
        coRejectedPhone = regMap["COORDINATOR_REJECTED_PHONE"] ?? "";
        adminApprovedPhone = regMap["ADMIN_APPROVED_PHONE"] ?? "";
        coApprovedPhone = regMap["COORDINATOR_APPROVED_PHONE"] ?? "";
        seconderyPhone = regMap["SECONDARY_NUMBER"] ?? "";
        aadhaar = regMap["AADHAAR_NUMBER"] ?? "";
        gender = regMap["GENDER"] ?? "";
        fullAddres = regMap["FULL_ADDRESS"] ?? "";
        bloodGroup = regMap["BLOOD_GROUP"] ?? "";
        occupation = regMap["OCCUPATION"] ?? "";
        age = regMap["AGE"] ?? "";

        notifyListeners();
      }
    });
  }

  // filterAllListsByArea(String filterArea) {
  //   filterApprovedRegisterModelList = approvedRegisterModelList
  //       .where((element) => element.area == filterArea)
  //       .toSet()
  //       .toList();
  //   filterRejectedRegisterModelList = rejectedRegisterModelList
  //       .where((element) => element.area == filterArea)
  //       .toSet()
  //       .toList();
  //   filterPendingRegisterModelList = pendingRegisterModelList
  //       .where((element) => element.area == filterArea)
  //       .toSet()
  //       .toList();
  //
  //   notifyListeners();
  // }

  int limit = 50;
  int approvedLimit = 0;
  int pendingLimit = 0;
  int rejectedLimit = 0;
  int filterApprovedLimit = 0;
  int filterPendingLimit = 0;
  int filterRejectedLimit = 0;
  int approvedLength = 0;
  int pendingLength = 0;
  int rejectedLength = 0;
  int coApprovedLength = 0;
  int coPendingLength = 0;
  int coRejectedLength = 0;
  String selectedAreaForFil = '';
  DateTime scheduledTimeFrom = DateTime.now();

  Future<void> filterFetchFunctionsForPending(String area, bool firstFetch,
      [dynamic lastDoc]) async {
    var collectionRef;

    if (firstFetch) {
      filterPendingLimit = limit;
      filterPendingRegisterModelList.clear();
      pendingRegisterModelList.clear();

      collectionRef = db
          .collection("REGISTRATIONS")
          .where("STATUS", whereIn: ["PENDING", "CO-APPROVED"])
          .where("AREA", isEqualTo: area)
          .orderBy("REGISTERED_DATE", descending: true)
          .limit(limit);
    } else {
      filterPendingLimit = filterPendingLimit + limit;

      collectionRef = db
          .collection("REGISTRATIONS")
          .where("STATUS", whereIn: ["PENDING", "CO-APPROVED"])
          .where("AREA", isEqualTo: area)
          .orderBy("REGISTERED_DATE", descending: true)
          .startAfter([lastDoc])
          .limit(limit);
    }

    collectionRef.get().then((event) {
      if (event.docs.isNotEmpty) {
        for (var element in event.docs) {
          Map<dynamic, dynamic> regMap = element.data();
          String time = "";
          if (regMap["REGISTERED_DATE"] != null) {
            time = outputDayNode
                .format(regMap["REGISTERED_DATE"].toDate())
                .toString();
            Timestamp stttTo = regMap["REGISTERED_DATE"];
            scheduledTimeFrom = DateTime.parse(stttTo.toDate().toString());
          }

          pendingRegisterModelList.add(MemberModelClass(
              element.id.toString(),
              regMap["NAME"] ?? "",
              regMap["PHONE"] ?? "",
              regMap["ADDRESS"] ?? "",
              regMap["AREA"] ?? "",
              regMap["STATUS"] ?? "",
              regMap["COORDINATOR_APPROVED_NAME"] ?? "",
              regMap["ADMIN_APPROVED_NAME"] ?? "",
              regMap["ADMIN_REJECTED_NAME"] ?? "",
              regMap["COORDINATOR_REJECTED_NAME"] ?? "",
              regMap["PROFILE_IMAGE"] ?? "",
              time,
              scheduledTimeFrom));
        }
        filterPendingRegisterModelList = pendingRegisterModelList;
        print(pendingRegisterModelList.length.toString() + "ASdsdv ");

        notifyListeners();
      }
    });

    notifyListeners();
  }

  // Future<void> filterFetchFunctionsForPending(String area, bool firstFetch,
  //     [dynamic lastDoc]) async {
  //   var collectionRef;
  //
  //   if (firstFetch) {
  //     filterPendingLimit = limit;
  //     filterPendingRegisterModelList.clear();
  //     pendingRegisterModelList.clear();
  //
  //     collectionRef = db
  //         .collection("REGISTRATIONS")
  //         .where("STATUS", whereIn: ["PENDING", "CO-APPROVED"])
  //         .where("AREA", isEqualTo: area)
  //         .orderBy("REGISTERED_DATE", descending: true)
  //         .limit(limit);
  //   } else {
  //     filterPendingLimit = filterPendingLimit + limit;
  //
  //     collectionRef = db
  //         .collection("REGISTRATIONS")
  //         .where("STATUS", whereIn: ["PENDING", "CO-APPROVED"])
  //         .where("AREA", isEqualTo: area)
  //         .orderBy("REGISTERED_DATE", descending: true)
  //         .startAfter([lastDoc])
  //         .limit(limit);
  //   }
  //
  //   collectionRef.get().then((event) {
  //     if (event.docs.isNotEmpty) {
  //       for (var element in event.docs) {
  //         Map<dynamic, dynamic> regMap = element.data();
  //         String time = "";
  //         if (regMap["REGISTERED_DATE"] != null) {
  //           time = outputDayNode
  //               .format(regMap["REGISTERED_DATE"].toDate())
  //               .toString();
  //           Timestamp stttTo = regMap["REGISTERED_DATE"];
  //           scheduledTimeFrom = DateTime.parse(stttTo.toDate().toString());
  //         }
  //
  //         pendingRegisterModelList.add(RequestMemberModel(
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
  //           regMap["ID_NUMBER"] ?? "",regMap["ID_NAME"] ?? "",regMap["ID_IMAGE"] ?? "",
  //
  //         )
  //
  //
  //         );
  //       }
  //       filterPendingRegisterModelList = pendingRegisterModelList;
  //       print(pendingRegisterModelList.length.toString() + "ASdsdv ");
  //
  //       notifyListeners();
  //     }
  //   });
  //
  //   notifyListeners();
  // }

  Future<void> filterFetchFunctionsForApproved(String area, bool firstFetch,
      [dynamic lastDoc]) async {
    var collectionRef;

    if (firstFetch) {
      filterApprovedRegisterModelList.clear();
      approvedRegisterModelList.clear();
      filterApprovedLimit = limit;
      collectionRef = db
          .collection("REGISTRATIONS")
          .where("STATUS", isEqualTo: "APPROVED")
          .where("AREA", isEqualTo: area)
          .orderBy("REGISTERED_DATE", descending: true)
          .limit(limit);
    } else {
      filterApprovedLimit = filterApprovedLimit + limit;
      collectionRef = db
          .collection("REGISTRATIONS")
          .where("STATUS", isEqualTo: "APPROVED")
          .where("AREA", isEqualTo: area)
          .orderBy("REGISTERED_DATE", descending: true)
          .startAfter([lastDoc]).limit(limit);
    }

    collectionRef.get().then((event) {
      if (event.docs.isNotEmpty) {
        for (var element in event.docs) {
          Map<dynamic, dynamic> regMap = element.data();

          String time = "";
          if (regMap["REGISTERED_DATE"] != null) {
            time = outputDayNode
                .format(regMap["REGISTERED_DATE"].toDate())
                .toString();
            Timestamp stttTo = regMap["REGISTERED_DATE"];
            scheduledTimeFrom = DateTime.parse(stttTo.toDate().toString());
          }

          approvedRegisterModelList.add(MemberModelClass(
              element.id.toString(),
              regMap["NAME"] ?? "",
              regMap["PHONE"] ?? "",
              regMap["ADDRESS"] ?? "",
              regMap["AREA"] ?? "",
              regMap["STATUS"] ?? "",
              regMap["COORDINATOR_APPROVED_NAME"] ?? "",
              regMap["ADMIN_APPROVED_NAME"] ?? "",
              regMap["ADMIN_REJECTED_NAME"] ?? "",
              regMap["COORDINATOR_REJECTED_NAME"] ?? "",
              regMap["PROFILE_IMAGE"] ?? "",
              time,
              scheduledTimeFrom));
        }
        filterApprovedRegisterModelList = approvedRegisterModelList;
        notifyListeners();
      }
    });

    notifyListeners();
  }

  // Future<void> filterFetchFunctionsForApproved(String area, bool firstFetch,
  //     [dynamic lastDoc]) async {
  //   var collectionRef;
  //
  //   if (firstFetch) {
  //     filterApprovedRegisterModelList.clear();
  //     approvedRegisterModelList.clear();
  //     filterApprovedLimit = limit;
  //     collectionRef = db
  //         .collection("REGISTRATIONS")
  //         .where("STATUS", isEqualTo: "APPROVED")
  //         .where("AREA", isEqualTo: area)
  //         .orderBy("REGISTERED_DATE", descending: true)
  //         .limit(limit);
  //   } else {
  //     filterApprovedLimit = filterApprovedLimit + limit;
  //     collectionRef = db
  //         .collection("REGISTRATIONS")
  //         .where("STATUS", isEqualTo: "APPROVED")
  //         .where("AREA", isEqualTo: area)
  //         .orderBy("REGISTERED_DATE", descending: true)
  //         .startAfter([lastDoc]).limit(limit);
  //   }
  //
  //   collectionRef.get().then((event) {
  //     if (event.docs.isNotEmpty) {
  //       for (var element in event.docs) {
  //         Map<dynamic, dynamic> regMap = element.data();
  //
  //         String time = "";
  //         if (regMap["REGISTERED_DATE"] != null) {
  //           time = outputDayNode
  //               .format(regMap["REGISTERED_DATE"].toDate())
  //               .toString();
  //           Timestamp stttTo = regMap["REGISTERED_DATE"];
  //           scheduledTimeFrom = DateTime.parse(stttTo.toDate().toString());
  //         }
  //
  //         approvedRegisterModelList.add(RequestMemberModel(
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
  //           regMap["ID_NUMBER"] ?? "",regMap["ID_NAME"] ?? "",regMap["ID_IMAGE"] ?? "",
  //
  //         ));
  //       }
  //       filterApprovedRegisterModelList = approvedRegisterModelList;
  //       notifyListeners();
  //     }
  //   });
  //
  //   notifyListeners();
  // }

  Future<void> filterFetchFunctionsForRejected(String area, bool firstFetch,
      [dynamic lastDoc]) async {
    var collectionRef;

    if (firstFetch) {
      filterRejectedLimit = limit;
      filterRejectedRegisterModelList.clear();
      rejectedRegisterModelList.clear();

      collectionRef = db
          .collection("REGISTRATIONS")
          .where("STATUS", whereIn: ["REJECTED", "CO-REJECTED"])
          .where("AREA", isEqualTo: area)
          .orderBy("REGISTERED_DATE", descending: true)
          .limit(limit);
    } else {
      filterRejectedLimit = filterRejectedLimit + limit;

      collectionRef = db
          .collection("REGISTRATIONS")
          .where("STATUS", whereIn: ["REJECTED", "CO-REJECTED"])
          .where("AREA", isEqualTo: area)
          .orderBy("REGISTERED_DATE", descending: true)
          .startAfter([lastDoc])
          .limit(limit);
    }

    collectionRef.get().then((event) {
      if (event.docs.isNotEmpty) {
        for (var element in event.docs) {
          Map<dynamic, dynamic> regMap = element.data();

          String time = "";
          if (regMap["REGISTERED_DATE"] != null) {
            time = outputDayNode
                .format(regMap["REGISTERED_DATE"].toDate())
                .toString();
            Timestamp stttTo = regMap["REGISTERED_DATE"];
            scheduledTimeFrom = DateTime.parse(stttTo.toDate().toString());
          }

          rejectedRegisterModelList.add(MemberModelClass(
              element.id.toString(),
              regMap["NAME"] ?? "",
              regMap["PHONE"] ?? "",
              regMap["ADDRESS"] ?? "",
              regMap["AREA"] ?? "",
              regMap["STATUS"] ?? "",
              regMap["COORDINATOR_APPROVED_NAME"] ?? "",
              regMap["ADMIN_APPROVED_NAME"] ?? "",
              regMap["ADMIN_REJECTED_NAME"] ?? "",
              regMap["COORDINATOR_REJECTED_NAME"] ?? "",
              regMap["PROFILE_IMAGE"] ?? "",
              time,
              scheduledTimeFrom));
        }
        filterRejectedRegisterModelList = rejectedRegisterModelList;
        notifyListeners();
      }
    });

    notifyListeners();
  }

  void refreshButton(String from, String coArea, String id) {
    if (from == "ADMIN") {
      getApprovedRegistration(true);
      getPendingRegistration(true);
      getRejectedRegistration(true);
      fetchCoordinators();
      filterOnApproved = false;
      filterOnPending = false;
      filterOnRejected = false;
      notifyListeners();
    } else {
      getCoordinatorPendingRegistration(coArea, true);
      getCoordinatorApprovedRegistration(coArea, true);
      getCoordinatorRejectedRegistration(coArea, true);
      fetchCoordinatorsFilter(coArea, id);
      notifyListeners();
    }
  }

  clearFilters(bool one, bool two, bool three, bool s) {
    if (one) {
      getApprovedRegistration(true);
      filterOnApproved = false;
      notifyListeners();
    }
    if (two) {
      getPendingRegistration(true);
      filterOnPending = false;
      notifyListeners();
    }
    if (three) {
      getRejectedRegistration(true);
      filterOnRejected = false;
      notifyListeners();
    }
    if (s) {
      fetchCoordinators();
    }
  }

  bool loadingTrue = false;

  Future<void> getApprovedRegistration(bool firstFetch,
      [dynamic lastDoc]) async {
    loadingTrue = true;
    var collectionRef;
    if (firstFetch) {
      approvedLimit = limit;
      approvedRegisterModelList.clear();
      filterApprovedRegisterModelList.clear();
      collectionRef = db
          .collection("REGISTRATIONS")
          .where("STATUS", isEqualTo: "APPROVED")
          .orderBy("REGISTERED_DATE", descending: true)
          .limit(limit);
    } else {
      approvedLimit = approvedLimit + limit;
      print(approvedLimit);
      collectionRef = db
          .collection("REGISTRATIONS")
          .where("STATUS", isEqualTo: "APPROVED")
          .orderBy("REGISTERED_DATE", descending: true)
          .startAfter([lastDoc]).limit(limit);
    }
    collectionRef.get().then((event) async {
      if (event.docs.isNotEmpty) {
        loadingTrue = false;

        for (var element in event.docs) {
          Map<dynamic, dynamic> regMap = element.data();

          String time = "";
          if (regMap["REGISTERED_DATE"] != null) {
            time = outputDayNode
                .format(regMap["REGISTERED_DATE"].toDate())
                .toString();
            Timestamp stttTo = regMap["REGISTERED_DATE"];
            scheduledTimeFrom = DateTime.parse(stttTo.toDate().toString());
          }

          approvedRegisterModelList.add(MemberModelClass(
              element.id.toString(),
              regMap["NAME"] ?? "",
              regMap["PHONE"] ?? "",
              regMap["ADDRESS"] ?? "",
              regMap["AREA"] ?? "",
              regMap["STATUS"] ?? "",
              regMap["COORDINATOR_APPROVED_NAME"] ?? "",
              regMap["ADMIN_APPROVED_NAME"] ?? "",
              regMap["ADMIN_REJECTED_NAME"] ?? "",
              regMap["COORDINATOR_REJECTED_NAME"] ?? "",
              regMap["PROFILE_IMAGE"] ?? "",
              time,
              scheduledTimeFrom));
        }
        filterApprovedRegisterModelList = approvedRegisterModelList;
        notifyListeners();
      } else {
        loadingTrue = false;
      }
      notifyListeners();
    });
    notifyListeners();
  }

  // Future<void> getApprovedRegistration(bool firstFetch,
  //     [dynamic lastDoc]) async {
  //   loadingTrue = true;
  //   var collectionRef;
  //   if (firstFetch) {
  //     approvedLimit = limit;
  //     approvedRegisterModelList.clear();
  //     filterApprovedRegisterModelList.clear();
  //     collectionRef = db
  //         .collection("REGISTRATIONS")
  //         .where("STATUS", isEqualTo: "APPROVED")
  //         .orderBy("REGISTERED_DATE", descending: true)
  //         .limit(limit);
  //   } else {
  //     approvedLimit = approvedLimit + limit;
  //     print(approvedLimit);
  //     collectionRef = db
  //         .collection("REGISTRATIONS")
  //         .where("STATUS", isEqualTo: "APPROVED")
  //         .orderBy("REGISTERED_DATE", descending: true)
  //         .startAfter([lastDoc]).limit(limit);
  //   }
  //   collectionRef.get().then((event) async {
  //     if (event.docs.isNotEmpty) {
  //       loadingTrue = false;
  //
  //       for (var element in event.docs) {
  //         Map<dynamic, dynamic> regMap = element.data();
  //
  //         String time = "";
  //         if (regMap["REGISTERED_DATE"] != null) {
  //           time = outputDayNode
  //               .format(regMap["REGISTERED_DATE"].toDate())
  //               .toString();
  //           Timestamp stttTo = regMap["REGISTERED_DATE"];
  //           scheduledTimeFrom = DateTime.parse(stttTo.toDate().toString());
  //         }
  //
  //         approvedRegisterModelList.add(RequestMemberModel(
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
  //           regMap["ID_NUMBER"] ?? "",regMap["ID_NAME"] ?? "",regMap["ID_IMAGE"] ?? "",
  //
  //         ));
  //       }
  //       filterApprovedRegisterModelList = approvedRegisterModelList;
  //       notifyListeners();
  //     } else {
  //       loadingTrue = false;
  //     }
  //     notifyListeners();
  //   });
  //   notifyListeners();
  // }

  Future<void> getRejectedRegistration(bool firstFetch,
      [dynamic lastDoc]) async {
    loadingTrue = true;

    var collectionRef;
    if (firstFetch) {
      rejectedLimit = limit;

      rejectedRegisterModelList.clear();
      filterRejectedRegisterModelList.clear();
      collectionRef = db
          .collection("REGISTRATIONS")
          .where("STATUS", whereIn: ["REJECTED", "CO-REJECTED"])
          .orderBy("REGISTERED_DATE", descending: true)
          .limit(limit);
    } else {
      rejectedLimit = rejectedLimit + limit;

      collectionRef = db
          .collection("REGISTRATIONS")
          .where("STATUS", whereIn: ["REJECTED", "CO-REJECTED"])
          .orderBy("REGISTERED_DATE", descending: true)
          .startAfter([lastDoc])
          .limit(limit);
    }
    collectionRef.get().then((event) async {
      if (firstFetch) {
        rejectedRegisterModelList.clear();
        filterRejectedRegisterModelList.clear();
      }

      if (event.docs.isNotEmpty) {
        loadingTrue = false;

        for (var element in event.docs) {
          Map<dynamic, dynamic> regMap = element.data();

          String time = "";
          if (regMap["REGISTERED_DATE"] != null) {
            time = outputDayNode
                .format(regMap["REGISTERED_DATE"].toDate())
                .toString();
            Timestamp stttTo = regMap["REGISTERED_DATE"];
            scheduledTimeFrom = DateTime.parse(stttTo.toDate().toString());
          }

          rejectedRegisterModelList.add(MemberModelClass(
              element.id.toString(),
              regMap["NAME"] ?? "",
              regMap["PHONE"] ?? "",
              regMap["ADDRESS"] ?? "",
              regMap["AREA"] ?? "",
              regMap["STATUS"] ?? "",
              regMap["COORDINATOR_APPROVED_NAME"] ?? "",
              regMap["ADMIN_APPROVED_NAME"] ?? "",
              regMap["ADMIN_REJECTED_NAME"] ?? "",
              regMap["COORDINATOR_REJECTED_NAME"] ?? "",
              regMap["PROFILE_IMAGE"] ?? "",
              time,
              scheduledTimeFrom));
        }
        filterRejectedRegisterModelList = rejectedRegisterModelList;
        notifyListeners();
      } else {
        loadingTrue = false;
      }
      notifyListeners();
    });
    notifyListeners();
  }

  Future<void> getCoordinatorApprovedRegistration(String area, bool firstFetch,
      [dynamic lastDoc]) async {
    loadingTrue = true;

    var collectionRef;

    QuerySnapshot querySnapshot = await db
        .collection("REGISTRATIONS")
        .where("STATUS", isEqualTo: "APPROVED")
        .where("AREA", isEqualTo: area)
        .get();
    coApprovedLength = querySnapshot.size;
    if (firstFetch) {
      approvedLimit = limit;
      approvedRegisterModelList.clear();

      collectionRef = db
          .collection("REGISTRATIONS")
          .where("STATUS", isEqualTo: "APPROVED")
          .where("AREA", isEqualTo: area)
          .orderBy("REGISTERED_DATE", descending: true)
          .limit(limit);
    } else {
      approvedLimit = approvedLimit + limit;

      collectionRef = db
          .collection("REGISTRATIONS")
          .where("STATUS", isEqualTo: "APPROVED")
          .where("AREA", isEqualTo: area)
          .orderBy("REGISTERED_DATE", descending: true)
          .startAfter([lastDoc]).limit(limit);
    }

    collectionRef.get().then((event) {
      if (event.docs.isNotEmpty) {
        loadingTrue = false;

        for (var element in event.docs) {
          Map<dynamic, dynamic> regMap = element.data();

          String time = "";
          if (regMap["REGISTERED_DATE"] != null) {
            time = outputDayNode
                .format(regMap["REGISTERED_DATE"].toDate())
                .toString();
            Timestamp stttTo = regMap["REGISTERED_DATE"];
            scheduledTimeFrom = DateTime.parse(stttTo.toDate().toString());
          }

          approvedRegisterModelList.add(MemberModelClass(
              element.id.toString(),
              regMap["NAME"] ?? "",
              regMap["PHONE"] ?? "",
              regMap["ADDRESS"] ?? "",
              regMap["AREA"] ?? "",
              regMap["STATUS"] ?? "",
              regMap["COORDINATOR_APPROVED_NAME"] ?? "",
              regMap["ADMIN_APPROVED_NAME"] ?? "",
              regMap["ADMIN_REJECTED_NAME"] ?? "",
              regMap["COORDINATOR_REJECTED_NAME"] ?? "",
              regMap["PROFILE_IMAGE"] ?? "",
              time,
              scheduledTimeFrom));
        }
        filterApprovedRegisterModelList = approvedRegisterModelList;

        notifyListeners();
      } else {
        loadingTrue = false;
      }
      notifyListeners();
    });
    notifyListeners();
  }

  // Future<void> getCoordinatorApprovedRegistration(String area, bool firstFetch,
  //     [dynamic lastDoc]) async {
  //   loadingTrue = true;
  //
  //   var collectionRef;
  //
  //   QuerySnapshot querySnapshot = await db
  //       .collection("REGISTRATIONS")
  //       .where("STATUS", isEqualTo: "APPROVED")
  //       .where("AREA", isEqualTo: area)
  //       .get();
  //   coApprovedLength = querySnapshot.size;
  //   if (firstFetch) {
  //     approvedLimit = limit;
  //     approvedRegisterModelList.clear();
  //
  //     collectionRef = db
  //         .collection("REGISTRATIONS")
  //         .where("STATUS", isEqualTo: "APPROVED")
  //         .where("AREA", isEqualTo: area)
  //         .orderBy("REGISTERED_DATE", descending: true)
  //         .limit(limit);
  //   } else {
  //     approvedLimit = approvedLimit + limit;
  //
  //     collectionRef = db
  //         .collection("REGISTRATIONS")
  //         .where("STATUS", isEqualTo: "APPROVED")
  //         .where("AREA", isEqualTo: area)
  //         .orderBy("REGISTERED_DATE", descending: true)
  //         .startAfter([lastDoc]).limit(limit);
  //   }
  //
  //   collectionRef.get().then((event) {
  //     if (event.docs.isNotEmpty) {
  //       loadingTrue = false;
  //
  //       for (var element in event.docs) {
  //         Map<dynamic, dynamic> regMap = element.data();
  //
  //         String time = "";
  //         if (regMap["REGISTERED_DATE"] != null) {
  //           time = outputDayNode
  //               .format(regMap["REGISTERED_DATE"].toDate())
  //               .toString();
  //           Timestamp stttTo = regMap["REGISTERED_DATE"];
  //           scheduledTimeFrom = DateTime.parse(stttTo.toDate().toString());
  //         }
  //
  //         approvedRegisterModelList.add(RequestMemberModel(
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
  //           regMap["ID_NUMBER"] ?? "",regMap["ID_NAME"] ?? "",regMap["ID_IMAGE"] ?? "",
  //
  //         ));
  //       }
  //       filterApprovedRegisterModelList = approvedRegisterModelList;
  //
  //       notifyListeners();
  //     } else {
  //       loadingTrue = false;
  //     }
  //     notifyListeners();
  //   });
  //   notifyListeners();
  // }

  Future<void> getCoordinatorPendingRegistration(String area, bool firstFetch,
      [dynamic lastDoc]) async {
    print(area);
    print("dtfyguhkjl");
    loadingTrue = true;

    var collectionRef;
    QuerySnapshot querySnapshot = await db
        .collection("REGISTRATIONS")
        .where("STATUS", whereIn: ["PENDING", "CO-APPROVED"])
        .where("AREA", isEqualTo: area)
        .get();
    coPendingLength = querySnapshot.size;
    if (firstFetch) {
      pendingLimit = limit;
      pendingRegisterModelList.clear();

      collectionRef = db
          .collection("REGISTRATIONS")
          .where("STATUS", whereIn: ["PENDING", "CO-APPROVED"])
          .where("AREA", isEqualTo: area)
          .orderBy("REGISTERED_DATE", descending: true)
          .limit(limit);
    } else {
      pendingLimit = pendingLimit + limit;

      collectionRef = db
          .collection("REGISTRATIONS")
          .where("STATUS", whereIn: ["PENDING", "CO-APPROVED"])
          .where("AREA", isEqualTo: area)
          .orderBy("REGISTERED_DATE", descending: true)
          .startAfter([lastDoc])
          .limit(limit);
    }
    collectionRef.get().then((event) {
      if (event.docs.isNotEmpty) {
        loadingTrue = false;

        for (var element in event.docs) {
          Map<dynamic, dynamic> regMap = element.data();

          String time = "";
          if (regMap["REGISTERED_DATE"] != null) {
            time = outputDayNode
                .format(regMap["REGISTERED_DATE"].toDate())
                .toString();
            Timestamp stttTo = regMap["REGISTERED_DATE"];
            scheduledTimeFrom = DateTime.parse(stttTo.toDate().toString());
          }

          pendingRegisterModelList.add(MemberModelClass(
              element.id.toString(),
              regMap["NAME"] ?? "",
              regMap["PHONE"] ?? "",
              regMap["ADDRESS"] ?? "",
              regMap["AREA"] ?? "",
              regMap["STATUS"] ?? "",
              regMap["COORDINATOR_APPROVED_NAME"] ?? "",
              regMap["ADMIN_APPROVED_NAME"] ?? "",
              regMap["ADMIN_REJECTED_NAME"] ?? "",
              regMap["COORDINATOR_REJECTED_NAME"] ?? "",
              regMap["PROFILE_IMAGE"] ?? "",
              time,
              scheduledTimeFrom));
        }
        filterPendingRegisterModelList = pendingRegisterModelList;
        notifyListeners();
      } else {
        loadingTrue = false;
      }
      print(pendingRegisterModelList.length.toString() + "ASdsdv ");
    });
    notifyListeners();
  }

  Future<void> getCoordinatorRejectedRegistration(String area, bool firstFetch,
      [dynamic lastDoc]) async {
    loadingTrue = true;

    var collectionRef;

    QuerySnapshot querySnapshot = await db
        .collection("REGISTRATIONS")
        .where("STATUS", whereIn: ["REJECTED", "CO-REJECTED"])
        .where("AREA", isEqualTo: area)
        .get();
    coRejectedLength = querySnapshot.size;
    if (firstFetch) {
      rejectedLimit = limit;
      rejectedRegisterModelList.clear();

      collectionRef = db
          .collection("REGISTRATIONS")
          .where("STATUS", whereIn: ["REJECTED", "CO-REJECTED"])
          .where("AREA", isEqualTo: area)
          .orderBy("REGISTERED_DATE", descending: true)
          .limit(limit);
    } else {
      rejectedLimit = rejectedLimit + limit;

      collectionRef = db
          .collection("REGISTRATIONS")
          .where("STATUS", whereIn: ["REJECTED", "CO-REJECTED"])
          .where("AREA", isEqualTo: area)
          .orderBy("REGISTERED_DATE", descending: true)
          .startAfter([lastDoc])
          .limit(limit);
    }

    collectionRef.get().then((event) {
      if (event.docs.isNotEmpty) {
        loadingTrue = false;

        for (var element in event.docs) {
          Map<dynamic, dynamic> regMap = element.data();

          String time = "";
          if (regMap["REGISTERED_DATE"] != null) {
            time = outputDayNode
                .format(regMap["REGISTERED_DATE"].toDate())
                .toString();
            Timestamp stttTo = regMap["REGISTERED_DATE"];
            scheduledTimeFrom = DateTime.parse(stttTo.toDate().toString());
          }

          rejectedRegisterModelList.add(MemberModelClass(
              element.id.toString(),
              regMap["NAME"] ?? "",
              regMap["PHONE"] ?? "",
              regMap["ADDRESS"] ?? "",
              regMap["AREA"] ?? "",
              regMap["STATUS"] ?? "",
              regMap["COORDINATOR_APPROVED_NAME"] ?? "",
              regMap["ADMIN_APPROVED_NAME"] ?? "",
              regMap["ADMIN_REJECTED_NAME"] ?? "",
              regMap["COORDINATOR_REJECTED_NAME"] ?? "",
              regMap["PROFILE_IMAGE"] ?? "",
              time,
              scheduledTimeFrom));
        }
        filterRejectedRegisterModelList = rejectedRegisterModelList;
        notifyListeners();
      } else {
        loadingTrue = false;
      }
      notifyListeners();
    });
    notifyListeners();
  }

  void approveRequest(
      String memberId,
      String uid,
      BuildContext context,
      String type,
      String uname,
      String uphone,
      String userPhone,
      String userName,
      String fro,
      String filterArea) {
    db.collection("REGISTRATIONS").doc(memberId).get().then((value) async {
      if (value.data()!.isNotEmpty) {
        Map<String, Object> memberMap = HashMap();

        if (type == "ADMIN") {
          memberMap["STATUS"] = "APPROVED";
          memberMap["ADMIN_APPROVED_BY"] = uid;
          memberMap["ADMIN_APPROVED_NAME"] = uname;
          memberMap["ADMIN_APPROVED_PHONE"] = uphone;
          memberMap["ADMIN_APPROVED_DATE"] = DateTime.now();
          db
              .collection("TOTAL")
              .doc("COUNTS")
              .update({"APPROVED": FieldValue.increment(1)});
          db
              .collection("TOTAL")
              .doc("COUNTS")
              .update({"PENDING": FieldValue.increment(-1)});

          // final dio = Dio();
          // final response = await dio.get('http://sapteleservices.com/SMS_API/sendsms.php?username=spinecodes&password=1210212102&mobile=$userPhone&message=Dear $userName,\nYour registration for AIKMCC MEMBERSHIP is successful.\nAIKMCC BENGALURU.\nSpinecodes&sendername=SPINEO&UC=U&routetype=1 &tid=1707170564120204471');
          // print(response);
          //
          // if(response.statusCode==200){
          //
          //
          //   print("response success...message send");
          //
          // }else{
          //
          //   print("response failed");
          //
          // }
        } else {
          memberMap["STATUS"] = "CO-APPROVED";
          memberMap["COORDINATOR_APPROVED_BY"] = uid;
          memberMap["COORDINATOR_APPROVED_NAME"] = uname;
          memberMap["COORDINATOR_APPROVED_PHONE"] = uphone;
          memberMap["COORDINATOR_APPROVED_DATE"] = DateTime.now();
        }

        db
            .collection("REGISTRATIONS")
            .doc(memberId)
            .set(memberMap, SetOptions(merge: true));
      }

      if (type == "ADMIN") {
        if (fro == "FILTER") {
          filterFetchFunctionsForPending(filterArea, true);
          filterFetchFunctionsForApproved(filterArea, true);
        } else {
          getApprovedRegistration(true);
          getPendingRegistration(true);
        }
      } else {
        LoginProvider loginProvider =
            Provider.of<LoginProvider>(context, listen: false);
        getCoordinatorApprovedRegistration(loginProvider.loginUserArea, true);
      }

      notifyListeners();
    });

    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        "Approved",
        style: TextStyle(color: Colors.blue),
      ),
    ));
  }

  void rejectRequest(String memberId, String uid, BuildContext context,
      String type, String uname, String uphone, String fro, String filterArea) {
    db.collection("REGISTRATIONS").doc(memberId).get().then((value) {
      if (value.data()!.isNotEmpty) {
        Map<String, Object> memberMap = HashMap();
        if (type == "ADMIN") {
          memberMap["STATUS"] = "REJECTED";
          memberMap["ADMIN_REJECTED_BY"] = uid;
          memberMap["ADMIN_REJECTED_NAME"] = uname;
          memberMap["ADMIN_REJECTED_PHONE"] = uphone;
          memberMap["ADMIN_REJECTED_DATE"] = DateTime.now();
        } else {
          memberMap["STATUS"] = "CO-REJECTED";
          memberMap["COORDINATOR_REJECTED_BY"] = uid;
          memberMap["COORDINATOR_REJECTED_NAME"] = uname;
          memberMap["COORDINATOR_REJECTED_PHONE"] = uphone;
          memberMap["COORDINATOR_REJECTED_DATE"] = DateTime.now();
        }

        db
            .collection("REGISTRATIONS")
            .doc(memberId)
            .set(memberMap, SetOptions(merge: true));
        db
            .collection("TOTAL")
            .doc("COUNTS")
            .update({"REJECTED": FieldValue.increment(1)});
        db
            .collection("TOTAL")
            .doc("COUNTS")
            .update({"PENDING": FieldValue.increment(-1)});
        if (type == "ADMIN") {
          if (fro == "FILTER") {
            filterFetchFunctionsForPending(filterArea, true);
            filterFetchFunctionsForRejected(filterArea, true);
          } else {
            getRejectedRegistration(true);
            getPendingRegistration(true);
          }
        } else {
          LoginProvider loginProvider =
              Provider.of<LoginProvider>(context, listen: false);
          getCoordinatorRejectedRegistration(loginProvider.loginUserArea, true);
        }
      }
      notifyListeners();
    });
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        "Rejected",
        style: TextStyle(color: Colors.blue),
      ),
    ));
  }

  approvalAlert(
      BuildContext context,
      String from,
      String memberId,
      String uid,
      double width,
      String type,
      String uname,
      String uphone,
      String userPhone,
      String userName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        elevation: 20,
        content: Text("Do you want to $from ?",
            style: const TextStyle(
                fontSize: 17,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                color: maincolor)),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Container(
                    alignment: Alignment.center,
                    width: width,
                    height: 50,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 0.30, color: Color(0xFFE2E2E2)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'No',
                      style: TextStyle(
                        color: Color(0xFFD00000),
                        fontSize: 11,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 0.15,
                      ),
                    )),
              ),
              Consumer<MainProvider>(builder: (context, mainPro, _) {
                return TextButton(
                  onPressed: () {
                    if (from.toUpperCase() == "APPROVE") {
                      if (mainPro.filterOnApproved || mainPro.filterOnPending) {
                        approveRequest(
                            memberId,
                            uid,
                            context,
                            type,
                            uname,
                            uphone,
                            userPhone,
                            userName,
                            "FILTER",
                            mainPro.filterArea);
                      } else {
                        approveRequest(memberId, uid, context, type, uname,
                            uphone, userPhone, userName, "", "");
                      }
                    } else {
                      if (mainPro.filterOnRejected || mainPro.filterOnPending) {
                        rejectRequest(memberId, uid, context, type, uname,
                            uphone, "FILTER", mainPro.filterArea);
                      } else {
                        rejectRequest(memberId, uid, context, type, uname,
                            uphone, "", "");
                      }
                    }

                    finish(context);
                    finish(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: width,
                    height: 50,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      gradient: gradientStyle,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 0.15,
                      ),
                    ),
                  ),
                );
              }),
            ],
          )
        ],
      ),
    );
  }

  void setActiveIndex(int index) {
    activeIndex = index;
    notifyListeners();
  }

  void expandtext() {
    isExpanded = !isExpanded;
    notifyListeners();
  }

  void fetchCoordinators() {
    loadingTrue = true;

    db
        .collection("COORDINATORS")
        .where("STATUS", isEqualTo: "SUCCESS")
        .snapshots()
        .listen((value) {
      coordinatorModelList.clear();
      if (value.docs.isNotEmpty) {
        loadingTrue = false;

        for (var element in value.docs) {
          coordinatorModelList.add(CoordinatorModel(
            element.get("ID"),
            element.get("NAME"),
            element.get("ADDRESS"),
            element.get("AREA"),
            element.get("AREA_DISTRICT"),
            element.get("PHONE"),
            element.get("PROFILE_IMAGE"),
          ));
        }
        filterCoordinatorModelList = coordinatorModelList;
        notifyListeners();
      } else {
        loadingTrue = false;
      }
    });
  }

  void fetchCoordinatorsFilter(String area, String cid) {
    db
        .collection("COORDINATORS")
        .where("STATUS", isEqualTo: "SUCCESS")
        .where("AREA", isEqualTo: area)
        .snapshots()
        .listen((value) {
      coordinatorModelList.clear();
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          try {
            coordinatorModelList.add(CoordinatorModel(
              element.get("ID"),
              element.get("NAME"),
              element.get("ADDRESS"),
              element.get("AREA"),
              element.get("AREA_DISTRICT"),
              element.get("PHONE"),
              element.get("PROFILE_IMAGE"),
            ));
          } catch (e) {
            print(e);
          }
        }
        filterCoordinatorModelList = coordinatorModelList;
        filterCoordinatorModelList.removeWhere((element) => element.id == cid);
        notifyListeners();
      }
    });
  }

  filterApprovedUsers(String item) {
    filterApprovedRegisterModelList = approvedRegisterModelList
        .where((element) =>
            element.name.toLowerCase().contains(item.toLowerCase()) ||
            element.phone.toLowerCase().contains(item.toLowerCase()))
        .toList();

    notifyListeners();
  }

  filterPendingUsers(String item) {
    filterPendingRegisterModelList = pendingRegisterModelList
        .where((element) =>
            element.name.toLowerCase().contains(item.toLowerCase()) ||
            element.phone.toLowerCase().contains(item.toLowerCase()))
        .toList();

    notifyListeners();
  }

  filterCoordinatedUsers(String item) {
    filterCoordinatorModelList = coordinatorModelList
        .where((element) =>
            element.name.toLowerCase().contains(item.toLowerCase()) ||
            element.phone.toLowerCase().contains(item.toLowerCase()))
        .toList();

    notifyListeners();
  }

  filterRejectedUsers(String item) {
    filterRejectedRegisterModelList = rejectedRegisterModelList
        .where((element) =>
            element.name.toLowerCase().contains(item.toLowerCase()) ||
            element.phone.toLowerCase().contains(item.toLowerCase()))
        .toList();

    notifyListeners();
  }

  alertSupport(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Colors.white,
              scrollable: true,
              titleTextStyle: const TextStyle(color: maincolor),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Helpline",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: "Poppins"),
                  ),
                  const Text(
                    "Choose how do you want to contact.",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        fontFamily: "Poppins"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          launch("tel://$contactNumber");
                          finish(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                              // border: Border.all(color: maincolor),
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0x26000000).withOpacity(.08),
                                  blurRadius: 2.0, // soften the shadow
                                  spreadRadius: 1.0,
                                )
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(call, scale: 3),
                              const Text('Phone',
                                  style: TextStyle(
                                      color: maincolor,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          launch('whatsapp://send?phone=$contactNumber');
                          finish(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                              // border: Border.all(color: maincolor),
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0x26000000).withOpacity(.08),
                                  blurRadius: 2.0, // soften the shadow
                                  spreadRadius: 1.0,
                                )
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(whatsappnew, scale: 3.5),
                              const SizedBox(width: 3),
                              const Text(
                                'Whatsapp',
                                style: TextStyle(
                                    color: maincolor,
                                    fontSize: 12,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ));
        });
  }

  alertFilter(context, double width, int tabIndex) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              // backgroundColor: Colors.transparent,

              // contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              //  titlePadding: EdgeInsets.fromLTRB(14, 14, 14, 5),

              child: Container(
            height: 385,
            decoration: BoxDecoration(
                color: Colors.white54, borderRadius: BorderRadius.circular(25)),
            child: Column(
              children: [
                Consumer<UserProvider>(builder: (context, userPro, child) {
                  return Container(
                    margin: const EdgeInsets.fromLTRB(14, 18, 14, 5),
                    width: width,
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
                      decoration: const InputDecoration(
                        suffixIcon:
                            Icon(Icons.search, color: Colors.black, size: 22),
                        contentPadding: EdgeInsets.only(bottom: 1),
                        hintText: 'Filter here',
                        hintStyle: TextStyle(
                          color: Color(0xFFB1B1B1),
                          fontSize: 10,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 0.14,
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (text) {
                        userPro.filterArea(text);
                      },
                    ),
                  );
                }),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(
                            30,
                          ),
                          bottomLeft: Radius.circular(30))),
                  height: 290,
                  // width: width,

                  child: Consumer<MainProvider>(
                      builder: (context, mainPro, child) {
                    return Consumer<UserProvider>(
                        builder: (context, userPro, child) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: userPro.FilterareaAllList.length,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var items = userPro.FilterareaAllList[index];
                          return InkWell(
                            onTap: () {
                              if (tabIndex == 0) {
                                filterArea = items.area;
                                filterFetchFunctionsForApproved(
                                    items.area, true);
                              } else if (tabIndex == 1) {
                                filterArea = items.area;

                                filterFetchFunctionsForPending(
                                    items.area, true);
                              } else if (tabIndex == 2) {
                                filterFetchFunctionsForRejected(
                                    items.area, true);
                              } else {
                                fetchCoordinatorsFilter(items.area, "");
                              }
                              // filterOn=true;
                              filterOnApproved = true;
                              filterOnPending = true;
                              filterOnRejected = true;
                              mainPro.selectedAreaForFil = items.area;
                              // filterAllListsByArea(items.area);
                              finish(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              width: width,
                              height: 40,
                              decoration: BoxDecoration(
                                color: index.isEven
                                    ? Colors.white
                                    : Colors.white10,
                              ),
                              child: Text(items.area),
                            ),
                          );
                        },
                      );
                    });
                  }),
                ),
              ],
            ),
          ));
        });
  }

  void loopForStatus() {
    db
        .collection("REGISTRATIONS")
        .where("STATUS", whereIn: ["APPROVED", "CO-APPROVED"])
        .get()
        .then((value) {
          if (value.docs.isNotEmpty) {
            print(value.docs.length);
            print("HBJKNLM:<kml");
            // for(var elements in value.docs){
            //   Map<String, Object> memberMap = HashMap();
            //
            //   memberMap["STATUS"]="PENDING";
            //
            //   db
            //       .collection("ATTEMPTS")
            //       .doc(elements.id)
            //       .set(memberMap, SetOptions(merge: true));
            // }
          }
          notifyListeners();
        });
  }
  List<FetchModel> excelList = [];
  void fetchhhh(){
    FirebaseFirestore db = FirebaseFirestore.instance;
    DateTime scheduledTimeFrom = DateTime.now();
    var outputDayNode = DateFormat('dd MMM yyyy  hh:mm a');

    db.collection('REGISTRATIONS')
        .where("STATUS", whereIn: ["APPROVED","CO-APPROVED","REJECTED","CO-REJECTED","PENDING"])

        .get().then((event) {
      excelList.clear();
      int i=0;
      if (event.docs.isNotEmpty) {
        print(event.docs.length);
        print("fcygvhubkjnl");
        for (var element in event.docs) {
          i++;
          print(i);

          Map<dynamic, dynamic> map = element.data() as Map;

          String time = "";
          if (map["REGISTERED_DATE"] != null) {
            time = outputDayNode
                .format(map["REGISTERED_DATE"].toDate())
                .toString();
            Timestamp stttTo = map["REGISTERED_DATE"];
            scheduledTimeFrom =
                DateTime.parse(stttTo.toDate().toString());
          }
          excelList.add(FetchModel(
            element.id.toString(),
            map["NAME"] ?? "",
            map["PHONE"] ?? "",
            map["ADDRESS"] ?? "",
            map["AGE"] ?? "",
            map["AREA"] ?? "",
            map["AREA_DISTRICT"] ?? "",
            map["ASSEMBLY"] ?? "",
            map["BLOOD_GROUP"] ?? "",
            map["DATE_OF_BIRTH"] ?? "",
            map["DISTRICT"] ?? "",
            map["OCCUPATION"] ?? "",
            map["PANCHAYATH"] ?? "",
            map["PROFILE_IMAGE"] ?? "",
            map["STATUS"] ?? "",
            map["TYPE"] ?? "",
            map["WARD"] ?? "",
            map["WARD_NAME"] ?? "",
            map["WARD_NUMBER"] ?? "",
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
            map["ID_NAME"] ?? "",
            map["ID_NUMBER"] ?? "",
            map["ID_IMAGE"] ?? "",
          ));
        }
      }
    });
    notifyListeners();
  }

  void createExcel(List<FetchModel> historyList) async {
    print(historyList[1].id.toString()+"rthnrjnh");
    final xlsio.Workbook workbook = xlsio.Workbook();
    final xlsio.Worksheet sheet = workbook.worksheets[0];
    final List<Object> list = [
        "ID",
        "NAME",
        "PHONE",
        "ADDRESS",
        "AGE",
        "AREA",
        "AREA_DISTRICT",
        "ASSEMBLY",
        "BLOOD_GROUP",
        "DATE_OF_BIRTH",
        "DISTRICT",
        "OCCUPATION",
        "PANCHAYATH",
        "PROFILE_IMAGE",
        "STATUS",
        "TYPE",
        "WARD",
        "WARD_NAME",
        "WARD_NUMBER",
        "TIME",
        "AADHAAR_NUMBER",
        "FULL_ADDRESS",
        "GENDER",
        "SECONDARY_NUMBER",
        "COORDINATOR_APPROVED_NAME",
        "COORDINATOR_APPROVED_PHONE",
        "ADMIN_APPROVED_NAME",
        "ADMIN_APPROVED_PHONE",
        "COORDINATOR_REJECTED_NAME",
        "COORDINATOR_REJECTED_PHONE",
        "ADMIN_REJECTED_NAME",
        "ADMIN_REJECTED_PHONE",
        "REG_DATE",
        "ID_NAME",
        "ID_NUMBER",
        "ID_IMAGE",
    ];
    const int firstRow = 1;

    const int firstColumn = 1;

    const bool isVertical = false;

    sheet.importList(list, firstRow, firstColumn, isVertical);
    int i = 1;
    for (var element in historyList) {
      // int time= 00000000000;
      // try{
      //   time =int.parse(element.time);
      // }catch(e){
      //
      // }
      // double amount= 0;
      // try{
      //   amount =double.parse(element.amount.replaceAll(",", ''));
      //
      // }catch(e){
      //   print(element.id);
      // }

      i++;
      final List<Object> list = [
        // getDate(time.toString()),
        // getHour(time.toString()),
        // getTime(time.toString()),
            element.id,
            element.name,
            element.phone.toString(),
            element.address,
            element.age,
            element.area,
            element.areaDistrict,
            element.assembly,
            element.bloodGroup,
            element.dob,
            element.district,
            element.occupation,
            element.panchayath,
            element.image,
            element.status,
            element.type,
            element.ward,
            element.wardName,
            element.wardNumber,
            element.time,
            element.aadhaar,
            element.fullAddress,
            element.gender,
            element.seconderyNumber,
            element.coApprovedName,
            element.coApprovedPhone,
            element.coRejectedName,
            element.coRejectedPhone,
            element.adminRejectedName,
            element.adminRejectedPhone,
            element.adminRejectedName,
            element.adminRejectedPhone,
            element.regDateTime,
            element.proofName,
            element.proofNumber,
            element.fetchProofImage,
      ];
      final int firstRow = i;

      const int firstColumn = 1;

      const bool isVertical = false;

      sheet.importList(list, firstRow, firstColumn, isVertical);
    }
// print("dhniuf");
    sheet.getRangeByIndex(1, 1, 1, 4).autoFitColumns();
    // print("jediknik");
    final List<int> bytes = workbook.saveAsStream();
    print("fdwnkdikn");
    // workbook.dispose();
    if(!kIsWeb){
      // print("rgfhbuf");
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName = '$path/Output.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
    else{
      print("ghrugruu");
      var blob = web_file.Blob([bytes], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'native');

      var anchorElement = web_file.AnchorElement(
        href: web_file.Url.createObjectUrlFromBlob(blob).toString(),
      )..setAttribute("download", "data.xlsx")..click();
    }

  }
  getDate(String millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(millis));

    var d12 = DateFormat('dd-MMM-yy').format(dt);
    return d12;
  }
  getTime(String millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(millis));
    var d12 = DateFormat('hh:mm:ss a').format(dt);
    return d12;
  }
  getHour(String millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(millis));
    var d12 = DateFormat('hh').format(dt);
    return d12;
  }
}

class FetchModel{
  String id;
  String name;
  String phone;
  String address;
  String age;
  String area;
  String areaDistrict;
  String assembly;
  String bloodGroup;
  String dob;
  String district;
  String occupation;
  String panchayath;
  String image;
  String status;
  String type;
  String ward;
  String wardName;
  String wardNumber;
  String time;
  String fullAddress;
  String aadhaar;
  String gender;
  String seconderyNumber;
  String coApprovedName;
  String coApprovedPhone;
  String adminApprovedName;
  String adminApprovedPhone;
  String coRejectedName;
  String coRejectedPhone;
  String adminRejectedName;
  String adminRejectedPhone;
  DateTime regDateTime;
  String proofName;
  String proofNumber;
  String fetchProofImage;

  FetchModel(
      this.id,
      this.name,
      this.phone,
      this.address,
      this.age,
      this.area,
      this.areaDistrict,
      this.assembly,
      this.bloodGroup,
      this.dob,
      this.district,
      this.occupation,
      this.panchayath,
      this.image,
      this.status,
      this.type,
      this.ward,
      this.wardName,
      this.wardNumber,
      this.time,
      this.fullAddress,
      this.aadhaar,
      this.gender,
      this.seconderyNumber,
      this.coApprovedName,
      this.coApprovedPhone,
      this.adminApprovedName,
      this.adminApprovedPhone,
      this.coRejectedName,
      this.coRejectedPhone,
      this.adminRejectedName,
      this.adminRejectedPhone,
      this.regDateTime,
      this.proofName,
      this.proofNumber,
      this.fetchProofImage);


}

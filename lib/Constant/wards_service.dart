import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';

import '../Models/unitModel.dart';

class WardsService{
  Map <dynamic, dynamic> mapDataBase={};
  Map <dynamic, dynamic> hideWardMap={};

  WardsService(this.mapDataBase,this.hideWardMap);
  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();


  Future<Map <dynamic, dynamic>> getJason ()async {
    Map <dynamic, dynamic> map={};
    var jsonText = await rootBundle.loadString('assets/images/msf_paper_revolution.json');
    var jsonResponse = json.decode(jsonText.toString());
    Map <dynamic, dynamic> jsonMap = await jsonResponse as Map;
    Map <dynamic, dynamic> databaseMap = mapDataBase;
    Map <dynamic, dynamic> databasenewMap = hideWardMap;
    map.addAll(jsonMap);
    map.addAll(databaseMap);
    print("hideWards map length : ${hideWardMap.length}");

    map.removeWhere((key, value) => hideWardMap.values.any((element) =>
    element['district'].toString() == value['district'].toString() &&
        element['assembly'].toString() == value['assembly'].toString() &&
        element['panchayath'].toString() == value['panchayath'].toString() &&
        element['wardname'].toString() == value['wardname'].toString()));


    return map;
  }


  Future<List<PanjayathModel>> getAllPanjayath() async {
    List<PanjayathModel> list = [];
    Map <dynamic, dynamic> map = await getJason();
    map.forEach((key, value) {
      if(!list.map((item) => (item.panjayath+item.assembly+item.district))
          .contains(value['panchayath'].toString()+value['assembly'].toString()+value['district'].toString())){
        list.add(PanjayathModel(value['district'].toString(), value['assembly'].toString(), value['panchayath'].toString(),));
      }
    });
    return list;
  }

  Future<List<WardModel>> getUnitChip(String district,String panjayath) async {
    List<WardModel> list = [];
    Map <dynamic, dynamic> map = await getJason();

    map.forEach((key, value) {
      if(value['district'].toString()==district&&value['panchayath'].toString()==panjayath){
        if(!list.map((item) => item.wardName).contains(value['wardname'].toString())){

          list.add(WardModel(district,value['assembly'].toString(), panjayath, value['wardname'].toString(),value['wardname'].toString()));
        }
      }
    });

    return list;
  }



}
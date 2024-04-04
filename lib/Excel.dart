import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
import 'package:universal_html/html.dart' as web_file;

import 'Provider/mainprovider.dart';

class Download extends StatefulWidget {
  const Download({super.key});

  @override
  State<Download> createState() => _DownloadState();
}

class _DownloadState extends State<Download> {

  // void createExcel(List<FetchModel> historyList) async {
  //   final xlsio.Workbook workbook = xlsio.Workbook();
  //   final xlsio.Worksheet sheet = workbook.worksheets[0];
  //   final List<Object> list = [
  //     "ID",
  //     "NAME",
  //     "PHONE",
  //     "ADDRESS",
  //     "AGE",
  //     "AREA",
  //     "AREA_DISTRICT",
  //     "ASSEMBLY",
  //     "BLOOD_GROUP",
  //     "DATE_OF_BIRTH",
  //     "DISTRICT",
  //     "OCCUPATION",
  //     "PANCHAYATH",
  //     "PROFILE_IMAGE",
  //     "STATUS",
  //     "TYPE",
  //     "WARD",
  //     "WARD_NAME",
  //     "WARD_NUMBER",
  //     "TIME",
  //     "AADHAAR_NUMBER",
  //     "FULL_ADDRESS",
  //     "GENDER",
  //     "SECONDARY_NUMBER",
  //     "COORDINATOR_APPROVED_NAME",
  //     "COORDINATOR_APPROVED_PHONE",
  //     "ADMIN_APPROVED_NAME",
  //     "ADMIN_APPROVED_PHONE",
  //     "COORDINATOR_REJECTED_NAME",
  //     "COORDINATOR_REJECTED_PHONE",
  //     "ADMIN_REJECTED_NAME",
  //     "ADMIN_REJECTED_PHONE",
  //     "REG_DATE",
  //     "ID_NAME",
  //     "ID_NUMBER",
  //     "ID_IMAGE",
  //   ];
  //   const int firstRow = 1;
  //
  //   const int firstColumn = 1;
  //
  //   const bool isVertical = false;
  //
  //   sheet.importList(list, firstRow, firstColumn, isVertical);
  //   int i = 1;
  //   for (var element in historyList) {
  //     int time= 00000000000;
  //     try{
  //       time =int.parse(element.time);
  //     }catch(e){
  //
  //     }
  //     double amount= 0;
  //     try{
  //       // amount =double.parse(element.amount.replaceAll(",", ''));
  //
  //     }catch(e){
  //       print(element.id);
  //     }
  //
  //     i++;
  //     final List<Object> list = [
  //       element.id,
  //       element.name,
  //       element.phone,
  //       element.address,
  //       element.age,
  //       element.area,
  //       element.areaDistrict,
  //       element.assembly,
  //       element.bloodGroup,
  //       element.dob,
  //       element.district,
  //       element.occupation,
  //       element.panchayath,
  //       element.image,
  //       element.status,
  //       element.type,
  //       element.ward,
  //       element.wardName,
  //       element.wardNumber,
  //       element.time,
  //       element.aadhaar,
  //       element.fullAddress,
  //       element.gender,
  //       element.seconderyNumber,
  //       element.coApprovedName,
  //       element.coApprovedPhone,
  //       element.coRejectedName,
  //       element.coRejectedPhone,
  //       element.adminRejectedName,
  //       element.adminRejectedPhone,
  //       element.adminRejectedName,
  //       element.adminRejectedPhone,
  //       element.regDateTime,
  //       element.proofName,
  //       element.proofNumber,
  //       element.fetchProofImage,
  //     ];
  //     final int firstRow = i;
  //
  //     const int firstColumn = 1;
  //
  //     const bool isVertical = false;
  //
  //     sheet.importList(list, firstRow, firstColumn, isVertical);
  //   }
  //
  //   sheet.getRangeByIndex(1, 1, 1, 4).autoFitColumns();
  //   final List<int> bytes = workbook.saveAsStream();
  //   workbook.dispose();
  //   if(!kIsWeb){
  //     final String path = (await getApplicationSupportDirectory()).path;
  //     final String fileName = '$path/Output.xlsx';
  //     final File file = File(fileName);
  //     await file.writeAsBytes(bytes, flush: true);
  //     // OpenFile.open(fileName);
  //   }
  //   else{
  //
  //     var blob = web_file.Blob([bytes], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'native');
  //
  //     var anchorElement = web_file.AnchorElement(
  //       href: web_file.Url.createObjectUrlFromBlob(blob).toString(),
  //     )..setAttribute("download", "data.xlsx")..click();
  //   }
  //
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Consumer<MainProvider>(
            builder: (context,value,child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                child: const Text(
                  "Click here to Fetch Excel FireStore",
                ),
                onPressed: () {
                  value.fetchhhh();
                },
              ),
            );
          }
        ),
        Consumer<MainProvider>(
          builder: (context,value,child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                child: const Text(
                  "Click here to Download Excel",
                ),
                onPressed: () {
                  setState(() {
                    value.createExcel(value.excelList);
                    // final xlsio.Workbook workbook = xlsio.Workbook();
                    // final xlsio.Worksheet sheet = workbook.worksheets[0];
                    // final List<Object> headerList = [
                    //   "ID",
                    //   "NAME",
                    //   "PHONE",
                    //   "ADDRESS",
                    //   "AGE",
                    //   "AREA",
                    //   "AREA_DISTRICT",
                    //   "ASSEMBLY",
                    //   "BLOOD_GROUP",
                    //   "DATE_OF_BIRTH",
                    //   "DISTRICT",
                    //   "OCCUPATION",
                    //   "PANCHAYATH",
                    //   "PROFILE_IMAGE",
                    //   "STATUS",
                    //   "TYPE",
                    //   "WARD",
                    //   "WARD_NAME",
                    //   "WARD_NUMBER",
                    //   "TIME",
                    //   "AADHAAR_NUMBER",
                    //   "FULL_ADDRESS",
                    //   "GENDER",
                    //   "SECONDARY_NUMBER",
                    //   "COORDINATOR_APPROVED_NAME",
                    //   "COORDINATOR_APPROVED_PHONE",
                    //   "ADMIN_APPROVED_NAME",
                    //   "ADMIN_APPROVED_PHONE",
                    //   "COORDINATOR_REJECTED_NAME",
                    //   "COORDINATOR_REJECTED_PHONE",
                    //   "ADMIN_REJECTED_NAME",
                    //   "ADMIN_REJECTED_PHONE",
                    //   "REG_DATE",
                    //   "ID_NAME",
                    //   "ID_NUMBER",
                    //   "ID_IMAGE",
                    // ];
                    //
                    // const int firstRow = 1;
                    // const int firstColumn = 1;
                    // const bool isVertical = false;
                    //
                    // sheet.importList(headerList, firstRow, firstColumn, isVertical);
                    //
                    // int i = 1;
                    // for (var element in excelList) {
                    //   int time = 0;
                    //   try {
                    //     time = int.parse(element.time);
                    //   } catch (e) {}
                    //
                    //   i++;
                    //   final List<Object> dataList = [
                    //     element.id,
                    //     element.name,
                    //     element.phone,
                    //     element.address,
                    //     element.age,
                    //     element.area,
                    //     element.areaDistrict,
                    //     element.assembly,
                    //     element.bloodGroup,
                    //     element.dob,
                    //     element.district,
                    //     element.occupation,
                    //     element.panchayath,
                    //     element.image,
                    //     element.status,
                    //     element.type,
                    //     element.ward,
                    //     element.wardName,
                    //     element.wardNumber,
                    //     element.time,
                    //     element.aadhaar,
                    //     element.fullAddress,
                    //     element.gender,
                    //     element.seconderyNumber,
                    //     element.coApprovedName,
                    //     element.coApprovedPhone,
                    //     element.coRejectedName,
                    //     element.coRejectedPhone,
                    //     element.adminRejectedName,
                    //     element.adminRejectedPhone,
                    //     element.adminRejectedName,
                    //     element.adminRejectedPhone,
                    //     element.regDateTime,
                    //     element.proofName,
                    //     element.proofNumber,
                    //     element.fetchProofImage,
                    //   ];
                    //
                    //   final int dataRow = i;
                    //
                    //   sheet.importList(dataList, dataRow, firstColumn, isVertical);
                    // }
                    //
                    // sheet.getRangeByIndex(1, 1, 1, headerList.length).autoFitColumns();
                    //
                    // final List<int> bytes = workbook.saveAsStream();
                    // workbook.dispose();
                    //
                    // var blob = web_file.Blob([Uint8List.fromList(bytes)],
                    //     'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'native');
                    //
                    // var anchorElement = web_file.AnchorElement(
                    //   href: web_file.Url.createObjectUrlFromBlob(blob).toString(),
                    // )
                    //   ..setAttribute("download", "data.xlsx")
                    //   ..click();



                    // createExcel(excelList);
                    }
                  );
                },
              ),
            );
          }
        ),
      ],
    ));
  }





}

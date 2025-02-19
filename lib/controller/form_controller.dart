
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../services/tab/farmertab/Hometab.dart';

class FormController extends GetxController {
  String farmer_id = "";
  String planting_date = "";
  String cotton_variety_id = "";
  String expected_yield = "";
  String type_fertilization_id = "";
  String fertilization_amount = "";
  String watering_schedules = "";
  String pesticides_amount = "";
  String type_pesticides_id = "";
  String harvesting = "";
  String video="";
  String rain_fed_only="";
  String location="";
  String unit="";



 static login(BuildContext context,String farmerId, String plantingDate,String cottonVarietyId,
     String expectedYield, String typeFertilizationId,String fertilizationAmount,
     String wateringSchedules, String pesticidesAmount,String typePesticidesId,
     String harvesting,String video,String rainFedOnly,String location,String unit) async {

   farmerId = farmerId;
   plantingDate = plantingDate;
   cottonVarietyId=cottonVarietyId;
   expectedYield=expectedYield;
   typeFertilizationId=typeFertilizationId;
   fertilizationAmount=fertilizationAmount;
   wateringSchedules=wateringSchedules;
   pesticidesAmount=pesticidesAmount;
   typePesticidesId=typePesticidesId;
   harvesting=harvesting;
   video=video;
   rainFedOnly=rainFedOnly;
   location=location;
   unit=unit;

   EasyLoading.show(status: 'loading...');
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('https://ellatangenterprises.com/demoo/esg/api/farmer_form_create'),
        );
        request.files.add(await http.MultipartFile.fromPath(
          'video', video,
        ));
        request.fields['farmer_id'] = farmerId;
        request.fields['planting_date'] = plantingDate;
        request.fields['cotton_variety_id'] = cottonVarietyId;
        request.fields['expected_yield'] = expectedYield;
        request.fields['type_fertilization_id'] = typeFertilizationId;
        request.fields['fertilization_amount'] = fertilizationAmount;
        request.fields['watering_schedules'] = wateringSchedules;
        request.fields['type_pesticides_id'] = typePesticidesId;
        request.fields['pesticides_amount'] = pesticidesAmount;
        request.fields['harvesting'] = harvesting;
        request.fields['rain_fed_only'] = rainFedOnly;
        request.fields['location'] = location;
        request.fields['unit_price'] = unit;
        var response = await request.send();
        if (response.statusCode == 200) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess('Form uploaded successfully!');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeTab()),
          );
        } else {
          EasyLoading.dismiss();
          EasyLoading.showError('Form uploading faild');
        }
      }

  static loginwithoutvideo(BuildContext context,String farmerId, String plantingDate,String cottonVarietyId,
      String expectedYield, String typeFertilizationId,String fertilizationAmount,
      String wateringSchedules, String pesticidesAmount,String typePesticidesId,
      String harvesting,String video,String rainFedOnly,String location , String unit) async {

    farmerId = farmerId;
    plantingDate = plantingDate;
    cottonVarietyId=cottonVarietyId;
    expectedYield=expectedYield;
    typeFertilizationId=typeFertilizationId;
    fertilizationAmount=fertilizationAmount;
    wateringSchedules=wateringSchedules;
    pesticidesAmount=pesticidesAmount;
    typePesticidesId=typePesticidesId;
    harvesting=harvesting;
    video=video;
    rainFedOnly=rainFedOnly;
    location=location;
    unit=unit;

    EasyLoading.show(status: 'loading...');
    var headers = {'Content-Type': 'application/json'};
    try {
      var url =
      Uri.parse('https://ellatangenterprises.com/demoo/esg/api/farmer_form_create');
      Map body = {
        'farmer_id': farmerId,
        'planting_date': plantingDate,
        'cotton_variety_id': cottonVarietyId,
        'expected_yield': expectedYield,
        'type_fertilization_id': typeFertilizationId,
        'fertilization_amount': fertilizationAmount,
        'watering_schedules': wateringSchedules,
        'type_pesticides_id': typePesticidesId,
        'pesticides_amount': pesticidesAmount,
        'harvesting': harvesting,
        'rain_fed_only': rainFedOnly,
        'location': location,
        'unit_price':unit,

      };
      http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Form uploaded successfully!');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeTab()),
        );
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Form uploading faild');
      }

    } catch (error) {
  EasyLoading.dismiss();
  EasyLoading.showError('Failed Something is Wrong !');
  }

  }

  }




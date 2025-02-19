import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import '../../../Model/FarmerFormListResponce.dart';
import '../../../Model/SettingResponce.dart';
import '../../../Widget/DelayedWebView.dart';
import '../../../Widget/api.dart';
import '../../../profile.dart';


class CreateFormForGarmentbatch2 extends StatefulWidget {
  const CreateFormForGarmentbatch2({super.key});

  @override
  _CreateFormForGarmentbatch2State createState() => _CreateFormForGarmentbatch2State();
}

class _CreateFormForGarmentbatch2State extends State<CreateFormForGarmentbatch2> {
  final getstorage = GetStorage();
  Future<FarmerFormListResponce>? fetchdata;
  List<FormData>? data;
  final List<Setting> _settingsNumber = [];
  late Future<SettingResponce> fetchsettingdata;
  final List<CottonVariety> _cottonVeriety = [];
  final List<TypeFertilization> _typeFertilization = [];
  final List<TypePesticides> _typePesticides = [];
  final List<YarQuality> _yarQuality = [];
  TextEditingController fabric_methodController = TextEditingController();
  TextEditingController types_fabricController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  YarQuality? _selectedYarQuality;

  String expectedYarnGrade = 'Please enter Yarn Grade';
  String Steplelength = 'Please enter Staple length';
  String yarnStrength = 'Please enter Yarn Strength';
  String qualityGining = 'Please enter quality after Ginning';

  TextEditingController production_cutting_Controller = TextEditingController();
  TextEditingController production_sewing_Controller = TextEditingController();
  TextEditingController garments_design_Controller = TextEditingController();
  TextEditingController garments_size_Controller = TextEditingController();
  TextEditingController garments_labels_Controller = TextEditingController();
  TextEditingController touches_ironing_Controller = TextEditingController();
  TextEditingController touches_packaging_Controller = TextEditingController();
  TextEditingController final_quality_defects_Controller = TextEditingController();
  TextEditingController final_garment_quality_Controller = TextEditingController();
  TextEditingController quantity_Controller = TextEditingController();
  TextEditingController unit_price_Controller = TextEditingController();

  String locationValue = 'Please enter your address';
  late VideoPlayerController _controller;
  bool _isSaving = false;
  bool _isCreating = false;
  int userid=0;
  DateTime? selectedDate;
  DateTime? dyeing_date;
  int? _selectedIndex;
  int ginnerStatus=0;
  int adminStatus=0;
  Uint8List getBytesFromBase64(String base64String) {
    return base64Decode(base64String);
  }

  @override
  void initState() {
    super.initState();
    userid=getstorage.read("id");
    getsetting(userid.toString());
    fetchData();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
  Future<void> _selectDatee(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dyeing_date ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dyeing_date) {
      setState(() {
        dyeing_date = picked;
      });
    }
  }


  Future<bool> _onWillPop() async {
    return true;
  }

  void getsetting(String id) async {
    EasyLoading.show(status: 'loading...');

    fetchsettingdata = ApiService.fetchRouteData("2");
    _cottonVeriety.clear();
    _typeFertilization.clear();
    _typePesticides.clear();
    _yarQuality.clear();
    _settingsNumber.clear();
    fetchsettingdata.then((response) {
      fetchsettingdata.then((response) {
        setState(() {
          _cottonVeriety.clear();
          _typeFertilization.clear();
          _typePesticides.clear();
          _settingsNumber.clear();
          _yarQuality.clear();
          if(response.cottonVariety != null) {
            _cottonVeriety.addAll(response.cottonVariety!);
          }
          if( response.typeFertilization != null) {
            _typeFertilization.addAll(response.typeFertilization!);
          }
          if( response.typePesticides != null) {
            _typePesticides.addAll(response.typePesticides!);
          }
          if( response.setting != null) {
            _settingsNumber.addAll(response.setting!);
          }
          if( response.yarQuality != null) {
            _yarQuality.addAll(response.yarQuality!);
          }
        });

      }).catchError((error) {
        EasyLoading.dismiss();
      });});}


  void fetchData() async {
    var newData = await ChatApiService.fetchRouteData(userid.toString());
    FarmerFormListResponce? manufacturerListResponse = await Future.value(newData);

    setState(() {
      fetchdata = Future.value(newData);

      data?.clear();
      data = manufacturerListResponse?.data;
      _isSaving = false;
      _isCreating = false;
      EasyLoading.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child:Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // Add center point
            end: Alignment.center,
            colors: [
              Color(0xFF6EDB7B), // Green// Light green
              Color(0xFFCBFF6B), // Yellow-green
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Expanded(  // Allows the text to wrap onto the next line
                    child: const Text(
                      "Create Form For Textile Manufacturer",
                      style: TextStyle(
                        fontFamily: 'Poppins_semi',
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                      maxLines: 2,  // Limits text to two lines
                      overflow: TextOverflow.ellipsis,  // Handles overflow gracefully
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 1.0, 16.0, 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(), // Allow ListView to scroll vertically
                          itemCount: data?.length ?? 0, // Use data?.length with null check
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  // Handle the tap event
                                },
                                child: Card(
                                  color: Colors.white,
                                  margin: const EdgeInsets.all(15.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildTitleValueone('Farmer Detail'),
                                        buildTitleValue('Farmer Name', data![index].farmerDetail!.name!),
                                        buildTitleValue('Farmer Mobile Number', data![index].farmerDetail!.mobileNo!),
                                        buildTitleValue('Farmer Email address', data![index].farmerDetail!.email!),
                                        buildTitleValue('Profile QR code', ""),
                                        DelayedWebView(url:data![index].farmerDetail!.profile_qr_code!),

                                        if(data![index].ginnerDetail!=null)
                                          buildTitleValueone('Ginner Detail'),
                                        buildTitleValue('Ginner Name', data![index].ginnerDetail!.name!),
                                        buildTitleValue('Ginner Mobile Number', data![index].ginnerDetail!.mobileNo!),
                                        buildTitleValue('Ginner Email address', data![index].ginnerDetail!.email!),
                                        DelayedWebView(url:data![index].ginnerDetail!.profile_qr_code!),

                                        if(data![index].spinnerDetail!=null)
                                          buildTitleValueone('Spinner Detail'),
                                        buildTitleValue('Spinner Name', data![index].spinnerDetail!.name!),
                                        buildTitleValue('Spinner Mobile Number', data![index].spinnerDetail!.mobileNo!),
                                        buildTitleValue('Spinner Email address', data![index].spinnerDetail!.email!),
                                        DelayedWebView(url:data![index].spinnerDetail!.profile_qr_code!),

                                        if(data![index].textileManufacturerDetail!=null)
                                          buildTitleValueone('Textile Manufacturer Detail'),
                                        buildTitleValue('Textile Manufacturer Detail Name', data![index].textileManufacturerDetail!.name!),
                                        buildTitleValue('Textile Manufacturer Detail Mobile Number', data![index].textileManufacturerDetail!.mobileNo!),
                                       buildTitleValue('Textile Manufacturer Detail Email address', data![index].textileManufacturerDetail!.email!),
                                        DelayedWebView(url:data![index].textileManufacturerDetail!.profile_qr_code!),


                                        if(data![index].farmerFormTextileForm!=null)
                                          buildTitleValueone('Product Details'),
                                        if(data![index].farmerFormTextileForm!=null)
                                          buildTitleValue('Fabric method',data![index].farmerFormTextileForm!.fabricMethod!),
                                        if(data![index].farmerFormTextileForm!=null)
                                          buildTitleValue('Fabric Type',data![index].farmerFormTextileForm!.typesFabric!),
                                        if(data![index].farmerFormTextileForm!=null)
                                          buildTitleValue('Dyeing method ',data![index].farmerFormTextileForm!.dyeingMethod!),
                                        if(data![index].farmerFormTextileForm!=null)
                                          buildTitleValue('Dyeing Date', convertDate(data![index].farmerFormTextileForm!.dyeingDate!)),
                                        if(data![index].farmerFormTextileForm!=null)
                                          buildTitleValue('Production Date', convertDate(data![index].farmerFormTextileForm!.fabricProductionDate!)),
                                        if(data![index].farmerFormGarmentForm!=null)
                                          buildTitleValueone('Product Details'),
                                        if(data![index].farmerFormGarmentForm!=null)
                                          buildTitleValue('Production cutting method',data![index].farmerFormGarmentForm!.productionCutting!),
                                        if(data![index].farmerFormGarmentForm!=null)
                                          buildTitleValue('Fabric Production Date', convertDate(data![index].farmerFormGarmentForm!.dateFabric!)),
                                        if(data![index].farmerFormGarmentForm!=null)
                                          buildTitleValue('Production Sewing Type',data![index].farmerFormGarmentForm!.productionSewing!),
                                        if(data![index].farmerFormGarmentForm!=null)
                                          buildTitleValue('Garments design method',data![index].farmerFormGarmentForm!.garmentsDesign!),
                                        if(data![index].farmerFormGarmentForm!=null)
                                          buildTitleValue('Garments Labels',data![index].farmerFormGarmentForm!.garmentsLabels!),
                                        if(data![index].farmerFormGarmentForm!=null)
                                          buildTitleValue('Production Assembling Date', convertDate(data![index].farmerFormGarmentForm!.productionAssemblingDates!)),
                                        if(data![index].farmerFormGarmentForm!=null)
                                          buildTitleValue('Garments Size',data![index].farmerFormGarmentForm!.garmentsSize!),
                                        if(data![index].farmerFormGarmentForm!=null)
                                          buildTitleValue('Touches ironing type',data![index].farmerFormGarmentForm!.touchesIroning!),
                                        if(data![index].farmerFormGarmentForm!=null)
                                          buildTitleValue('Touches packaging method',data![index].farmerFormGarmentForm!.productionCutting!),
                                        if(data![index].farmerFormGarmentForm!=null)
                                          buildTitleValue('Final quality defects (Yes/No)',data![index].farmerFormGarmentForm!.finalQualityDefects!),
                                        if(data![index].farmerFormGarmentForm!=null)
                                          buildTitleValue('Garment Quality',data![index].farmerFormGarmentForm!.finalGarmentQuality!),
                                        if(data![index].farmerFormGarmentForm!=null)
                                          buildTitleValue('Product Quantity',data![index].farmerFormGarmentForm!.quantity!),
                                        if(data![index].farmerFormGarmentForm!=null)
                                          buildTitleValue('Product Unit',data![index].farmerFormGarmentForm!.unitPrice!),

                                        if(data![index].garmentInvoice!=null)
                                          if ((data![index].garmentInvoice!.textileStatus!) == 1 || (data![index].garmentInvoice!.adminStatus!) == 1)
                                            if(data![index].farmerFormGarmentForm==null)
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 400.0,
                                                    height: 60.0,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    ),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          _selectedIndex = index;
                                                          _isCreating=true;
                                                        });
                                                      },
                                                      child: const Text(
                                                        'Create Form',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14.0,
                                                          fontFamily: 'Reguler',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        if(_isCreating  && _selectedIndex == index)
                                          Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextFormField(
                                                  controller: production_cutting_Controller,
                                                  keyboardType: TextInputType.text,
                                                  decoration: const InputDecoration(
                                                    labelText: 'Enter Production cutting method',  // Label as title when field is focused or filled
                                                    labelStyle: TextStyle(
                                                      color: Colors.black,  // Label text color for contrast
                                                      fontSize: 14.0,
                                                      fontFamily: 'Poppins_sego',
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.black),  // Black border when focused
                                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.black),  // Black border when not focused
                                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                    ),

                                                  ),
                                                  style: const TextStyle(
                                                    color: Colors.black,  // Input text color for contrast
                                                    fontSize: 16.0,
                                                    fontFamily: 'Poppins_sego',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if(_isCreating  && _selectedIndex == index)
                                          Padding(
                                          padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: GestureDetector(
                                              onTap: () => _selectDate(context),  // Handle tap on the entire container
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  // Label-like text above the input
                                                  Text(
                                                    'Fabric Production Date',
                                                    style: TextStyle(
                                                      color: selectedDate == null ? Colors.grey : Colors.black,  // Grey when no date is selected
                                                      fontSize: 14.0,
                                                      fontFamily: 'Poppins_sego',
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),  // Space between label and box
                                                  Container(
                                                    height: 60.0,  // Height similar to TextFormField
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      border: Border.all(color: Colors.black),  // Black stroke border
                                                    ),
                                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                    child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(
                                                        selectedDate == null
                                                            ? 'Select Fabric Production Date'  // Placeholder when no date is selected
                                                            : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                                                        style: const TextStyle(
                                                          color: Colors.black,  // Text color
                                                          fontSize: 14.0,
                                                          fontFamily: 'Poppins_sego',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        if(_isCreating  && _selectedIndex == index)
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextFormField(
                                                  controller: production_sewing_Controller,
                                                  keyboardType: TextInputType.text,
                                                  decoration: const InputDecoration(
                                                    labelText: 'Enter Production Sewing Type',  // Label as title when field is focused or filled
                                                    labelStyle: TextStyle(
                                                      color: Colors.black,  // Label text color for contrast
                                                      fontSize: 14.0,
                                                      fontFamily: 'Poppins_sego',
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.black),  // Black border when focused
                                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.black),  // Black border when not focused
                                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                    ),

                                                  ),
                                                  style: const TextStyle(
                                                    color: Colors.black,  // Input text color for contrast
                                                    fontSize: 16.0,
                                                    fontFamily: 'Poppins_sego',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if(_isCreating  && _selectedIndex == index)
                                          Container(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    controller: garments_design_Controller,
                                                    keyboardType: TextInputType.text,
                                                    decoration: const InputDecoration(
                                                      labelText: 'Enter Garments design method',  // Label as title when field is focused or filled
                                                      labelStyle: TextStyle(
                                                        color: Colors.black,  // Label text color for contrast
                                                        fontSize: 14.0,
                                                        fontFamily: 'Poppins_sego',
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.black),  // Black border when focused
                                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.black),  // Black border when not focused
                                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                      ),

                                                    ),
                                                    style: const TextStyle(
                                                      color: Colors.black,  // Input text color for contrast
                                                      fontSize: 16.0,
                                                      fontFamily: 'Poppins_sego',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        if(_isCreating  && _selectedIndex == index)
                                          Container(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    controller: garments_labels_Controller,
                                                    keyboardType: TextInputType.text,
                                                    decoration: const InputDecoration(
                                                      labelText: 'Enter Garments Labels',  // Label as title when field is focused or filled
                                                      labelStyle: TextStyle(
                                                        color: Colors.black,  // Label text color for contrast
                                                        fontSize: 14.0,
                                                        fontFamily: 'Poppins_sego',
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.black),  // Black border when focused
                                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.black),  // Black border when not focused
                                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                      ),

                                                    ),
                                                    style: const TextStyle(
                                                      color: Colors.black,  // Input text color for contrast
                                                      fontSize: 16.0,
                                                      fontFamily: 'Poppins_sego',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        if(_isCreating  && _selectedIndex == index)
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: GestureDetector(
                                              onTap: () => _selectDatee(context),  // Handle tap on the entire container
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  // Label-like text above the input
                                                  Text(
                                                    'Select Production Assembling Date',
                                                    style: TextStyle(
                                                      color: dyeing_date == null ? Colors.grey : Colors.black,  // Grey when no date is selected
                                                      fontSize: 14.0,
                                                      fontFamily: 'Poppins_sego',
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),  // Space between label and box
                                                  Container(
                                                    height: 60.0,  // Height similar to TextFormField
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      border: Border.all(color: Colors.black),  // Black stroke border
                                                    ),
                                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                    child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(
                                                        dyeing_date == null
                                                            ? 'Select Production Assembling Date'  // Placeholder when no date is selected
                                                            : '${dyeing_date!.day}/${dyeing_date!.month}/${dyeing_date!.year}',
                                                        style: const TextStyle(
                                                          color: Colors.black,  // Text color
                                                          fontSize: 14.0,
                                                          fontFamily: 'Poppins_sego',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        if(_isCreating  && _selectedIndex == index)
                                          Container(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    controller: garments_size_Controller,
                                                    keyboardType: TextInputType.text,
                                                    decoration: const InputDecoration(
                                                      labelText: 'Enter Garments Size',  // Label as title when field is focused or filled
                                                      labelStyle: TextStyle(
                                                        color: Colors.black,  // Label text color for contrast
                                                        fontSize: 14.0,
                                                        fontFamily: 'Poppins_sego',
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.black),  // Black border when focused
                                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.black),  // Black border when not focused
                                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                      ),

                                                    ),
                                                    style: const TextStyle(
                                                      color: Colors.black,  // Input text color for contrast
                                                      fontSize: 16.0,
                                                      fontFamily: 'Poppins_sego',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        if(_isCreating  && _selectedIndex == index)
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextFormField(
                                                  controller: touches_ironing_Controller,
                                                  keyboardType: TextInputType.text,
                                                  decoration: const InputDecoration(
                                                    labelText: 'Enter Touches ironing type',  // Label as title when field is focused or filled
                                                    labelStyle: TextStyle(
                                                      color: Colors.black,  // Label text color for contrast
                                                      fontSize: 14.0,
                                                      fontFamily: 'Poppins_sego',
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.black),  // Black border when focused
                                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.black),  // Black border when not focused
                                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                    ),

                                                  ),
                                                  style: const TextStyle(
                                                    color: Colors.black,  // Input text color for contrast
                                                    fontSize: 16.0,
                                                    fontFamily: 'Poppins_sego',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if(_isCreating  && _selectedIndex == index)
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextFormField(
                                                  controller: touches_packaging_Controller,
                                                  keyboardType: TextInputType.text,
                                                  decoration: const InputDecoration(
                                                    labelText: 'Enter Touches packaging method',  // Label as title when field is focused or filled
                                                    labelStyle: TextStyle(
                                                      color: Colors.black,  // Label text color for contrast
                                                      fontSize: 14.0,
                                                      fontFamily: 'Poppins_sego',
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.black),  // Black border when focused
                                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.black),  // Black border when not focused
                                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                    ),

                                                  ),
                                                  style: const TextStyle(
                                                    color: Colors.black,  // Input text color for contrast
                                                    fontSize: 16.0,
                                                    fontFamily: 'Poppins_sego',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if(_isCreating  && _selectedIndex == index)
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextFormField(
                                                  controller: final_quality_defects_Controller,
                                                  keyboardType: TextInputType.text,
                                                  decoration: const InputDecoration(
                                                    labelText: 'Enter Final quality defects (Yes/No)',  // Label as title when field is focused or filled
                                                    labelStyle: TextStyle(
                                                      color: Colors.black,  // Label text color for contrast
                                                      fontSize: 14.0,
                                                      fontFamily: 'Poppins_sego',
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.black),  // Black border when focused
                                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.black),  // Black border when not focused
                                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                    ),

                                                  ),
                                                  style: const TextStyle(
                                                    color: Colors.black,  // Input text color for contrast
                                                    fontSize: 16.0,
                                                    fontFamily: 'Poppins_sego',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if(_isCreating  && _selectedIndex == index)
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextFormField(
                                                  controller: final_garment_quality_Controller,
                                                  keyboardType: TextInputType.text,
                                                  decoration: const InputDecoration(
                                                    labelText: 'Enter Garment Quality',  // Label as title when field is focused or filled
                                                    labelStyle: TextStyle(
                                                      color: Colors.black,  // Label text color for contrast
                                                      fontSize: 14.0,
                                                      fontFamily: 'Poppins_sego',
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.black),  // Black border when focused
                                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.black),  // Black border when not focused
                                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                    ),

                                                  ),
                                                  style: const TextStyle(
                                                    color: Colors.black,  // Input text color for contrast
                                                    fontSize: 16.0,
                                                    fontFamily: 'Poppins_sego',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if(_isCreating  && _selectedIndex == index)
                                          Container(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    controller: quantity_Controller,
                                                    keyboardType: TextInputType.number,
                                                    decoration: const InputDecoration(
                                                      labelText: 'Enter Product Quantity',  // Label as title when field is focused or filled
                                                      labelStyle: TextStyle(
                                                        color: Colors.black,  // Label text color for contrast
                                                        fontSize: 14.0,
                                                        fontFamily: 'Poppins_sego',
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.black),  // Black border when focused
                                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.black),  // Black border when not focused
                                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                      ),
                                                      suffixText: 'kg',
                                                      suffixStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16.0,
                                                        fontFamily: 'Poppins_sego',
                                                      ),
                                                    ),
                                                    style: const TextStyle(
                                                      color: Colors.black,  // Input text color for contrast
                                                      fontSize: 16.0,
                                                      fontFamily: 'Poppins_sego',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        if(_isCreating  && _selectedIndex == index)
                                          Container(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    controller: unit_price_Controller,
                                                    keyboardType: TextInputType.number,
                                                    decoration: const InputDecoration(
                                                      labelText: 'Enter Unit Price',  // Label as title when field is focused or filled
                                                      labelStyle: TextStyle(
                                                        color: Colors.black,  // Label text color for contrast
                                                        fontSize: 14.0,
                                                        fontFamily: 'Poppins_sego',
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.black),  // Black border when focused
                                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.black),  // Black border when not focused
                                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                      ),
                                                      suffixText: '/kg',
                                                      suffixStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16.0,
                                                        fontFamily: 'Poppins_sego',
                                                      ),
                                                    ),
                                                    style: const TextStyle(
                                                      color: Colors.black,  // Input text color for contrast
                                                      fontSize: 16.0,
                                                      fontFamily: 'Poppins_sego',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        if(_isCreating  && _selectedIndex == index)
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 400.0,
                                                height: 60.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    saveDataforginner(data![index].garmentInvoice!.farmerFormId!.toString(),data![index].garmentInvoice!.garmentManufacturerId!.toString());
                                                  },
                                                  child: const Text(
                                                    'Save Data For Textile Manufacturer',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0,
                                                      fontFamily: 'Reguler',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                      ],
                                    ),
                                  ),
                                )
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
  void approveform(String farmerFormId,String ginnerStatus,String spinnerInvoiceId) async {
    var newData = await ASpproveform.fetchRouteData(farmerFormId,ginnerStatus,spinnerInvoiceId);
    FarmerFormListResponce? manufacturerListResponse = await Future.value(newData);
    if (manufacturerListResponse?.errorCode == "0") {
      EasyLoading.show(status: 'loading...');
      fetchData();
    }else{
      EasyLoading.dismiss();
      EasyLoading.showError('Failed Something is Wrong !');
    }
  }

  String convertDate(String dateStr) {
    List<String> parts = dateStr.split('-');
    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int day = int.parse(parts[2]);
    DateTime parsedDate = DateTime(year, month, day);
    String formattedDate = DateFormat('dd MMMM yyyy').format(parsedDate);
    return formattedDate;
  }
  Widget buildTitleValue(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              fontFamily: 'Poppins_sego',
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              fontFamily: 'Reguler',
            ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
  Widget buildTitleValueone(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color:Color(0xFF6EDB7B),
              fontSize: 16.0,
              fontFamily: 'Poppins_medium',
            ),
          ),
          const SizedBox(height: 4.0),
        ],
      ),
    );
  }
  String getCottonVarietyName(int id) {
    for (var variety in _cottonVeriety) {
      if (variety.id == id) {
        return variety.name!;
      }
    }
    return 'Unknown Variety';
  }
  String getFertilizationtype(int id) {
    for (var variety in _typeFertilization) {
      if (variety.id == id) {
        return variety.name!;
      }
    }
    return 'Unknown Variety';
  }
  String getPesticidesName(int id) {
    for (var variety in _typePesticides) {
      if (variety.id == id) {
        return variety.name!;
      }
    }
    return 'Unknown Variety';
  }
  String getstatus(int id) {
    if (id == 0) {
      return "Pending";
    }else if(id==2){
      return "Rejected";
    }
    return 'Approved';
  }

  saveDataforginner(String incommingCottonBatchId,String ginnerId) async {
    if( production_cutting_Controller.text.trim().isEmpty){
      EasyLoading.showError('Please Enter Production cutting method');
    }else if(selectedDate==null){
      EasyLoading.showError('Please Select Fabric Processing Date');
    }else if(production_sewing_Controller.text.toString().isEmpty){
      EasyLoading.showError('Please Enter Production Sewing Method');
    }else if(garments_design_Controller.text.trim().isEmpty){
      EasyLoading.showError('Please enter Garment Design Method');
    }else if(garments_size_Controller.text.trim().isEmpty){
      EasyLoading.showError('Please enter Garment Size');
    }else if(garments_labels_Controller.text.trim().isEmpty){
      EasyLoading.showError('Please enter Garment Label');
    }else if(dyeing_date==null){
      EasyLoading.showError('Please Select Production assembling Date');
    }else if(touches_ironing_Controller.text.trim().isEmpty){
      EasyLoading.showError('Please enter Garment Ironing method');
    }else if(touches_packaging_Controller.text.trim().isEmpty){
      EasyLoading.showError('Please enter Garment packaging method');
    }else if(final_quality_defects_Controller.text.trim().isEmpty){
      EasyLoading.showError('Please enter Garment Final quality Defect condition');
    }else if(final_garment_quality_Controller.text.trim().isEmpty){
      EasyLoading.showError('Please enter Garment quality');
    }else if(quantity_Controller.text.trim().isEmpty){
      EasyLoading.showError('Please enter Garment Quantity');
    }else if(unit_price_Controller.text.trim().isEmpty){
      EasyLoading.showError('Please enter Garment Unit Price');
    }else{
      EasyLoading.show(status: 'loading...');
      String selectedDates="${selectedDate?.year}-${selectedDate?.month}-${selectedDate?.day}";
      String productDates="${dyeing_date?.year}-${dyeing_date?.month}-${dyeing_date?.day}";
      try {
        var newData = await SaveGinnerData.fetchRouteData(
            incommingCottonBatchId,
            ginnerId,
            selectedDates,
            production_cutting_Controller.text.toString(),
            production_sewing_Controller.text.toString(),
            productDates,
            garments_design_Controller.text.toString(),
            garments_size_Controller.text.toString(),
            garments_labels_Controller.text.toString(),
            touches_ironing_Controller.text.toString(),
            touches_packaging_Controller.text.toString(),
            final_quality_defects_Controller.text.toString(),
            final_garment_quality_Controller.text.toString(),
            quantity_Controller.text.toString(),
            unit_price_Controller.text.toString()
    );
        FarmerFormListResponce? manufacturerListResponse = await Future.value(newData);
        if (manufacturerListResponse?.errorCode == "0") {
          EasyLoading.showError('Data Saved Successfully');
          fetchData();
        }else{
          EasyLoading.dismiss();
          EasyLoading.showError('Failed Something is Wrong !');
        }
      } catch (e) {
        EasyLoading.showError('Failed to save invoice');
      }

    }

  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String url;

  const VideoPlayerWidget({super.key, required this.url});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {}); // Update the UI when the video is initialized
      });
    _controller.addListener(() {
      setState(() {
        _isPlaying = _controller.value.isPlaying;
      });
    });
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Column(
      children: [
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  _isPlaying ? _controller.pause() : _controller.play();
                });
              },
            ),
          ],
        ),
      ],
    )
        : const Center(child: CircularProgressIndicator());
  }
}



class SaveGinnerData {
  static var client = http.Client();

  static Future<FarmerFormListResponce> fetchRouteData(String farmer_form_id,
      String garment_manufacturer_id,String date_fabric,String production_cutting,
      String production_sewing,String production_assembling_dates,
      String garments_design,
      String garments_size,String garments_labels,String touches_ironing,String touches_packaging,
      String final_quality_defects,String final_garment_quality,  String quantity,String unit_price) async {

    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.garment_create_form);
    Map body = {
      'farmer_form_id': farmer_form_id,
      'garment_manufacturer_id': garment_manufacturer_id,
      'date_fabric': date_fabric,
      'production_cutting': production_cutting,
      'production_sewing': production_sewing,
      'production_assembling_dates': production_assembling_dates,
      'garments_design': garments_design,
      'garments_size': garments_size,
      'garments_labels': garments_labels,
      'touches_ironing': touches_ironing,
      'touches_packaging': touches_packaging,
      'final_quality_defects': final_quality_defects,
      'final_garment_quality': final_garment_quality,
      'quantity': quantity,
      'unit_price': unit_price,


    };
    http.Response response = await http.post(url, body: jsonEncode(body),headers: headers);

    if (response.statusCode == 200) {
      return formrouteModelFromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }}

class ChatApiService {
  static var client = http.Client();

  static Future<FarmerFormListResponce> fetchRouteData(String Farmerid) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.garment_textile_form);
    Map body = {
      'garment_manufacturer_id': Farmerid,
    };
    http.Response response = await http.post(url, body: jsonEncode(body),headers: headers);
    if (response.statusCode == 200) {
      return formrouteModelFromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }}

class ASpproveform {
  static var client = http.Client();

  static Future<FarmerFormListResponce> fetchRouteData(String farmerFormId,String farmerStatus,String ginnerInvoiceId) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.ginner_approve_reject_spinner_invoice);
    Map body = {
      'farmer_form_id': farmerFormId,
      'ginner_status':farmerStatus,
      'spinner_invoice_id': ginnerInvoiceId
    };
    http.Response response = await http.post(url, body: jsonEncode(body),headers: headers);
    if (response.statusCode == 200) {
      return formrouteModelFromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }}

import 'dart:convert';

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
import 'EditCreateFormForSpinnerCottonbatch.dart';
import 'dart:typed_data';


class CreateFormForSpinnerCottonbatch extends StatefulWidget {
  const CreateFormForSpinnerCottonbatch({super.key});

  @override
  _CreateFormForSpinnerCottonbatchState createState() => _CreateFormForSpinnerCottonbatchState();
}

class _CreateFormForSpinnerCottonbatchState extends State<CreateFormForSpinnerCottonbatch> {
  final getstorage = GetStorage();
  Future<FarmerFormListResponce>? fetchdata;
  List<FormData>? data;
  final List<Setting> _settingsNumber = [];
  late Future<SettingResponce> fetchsettingdata;
  final List<CottonVariety> _cottonVeriety = [];
  final List<TypeFertilization> _typeFertilization = [];
  final List<TypePesticides> _typePesticides = [];
  TextEditingController expectedYielderrorController = TextEditingController();
  TextEditingController fertilizationamountController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  String expectedYarnGrade = 'Please enter Yarn Grade';
  String unit_price = 'Please enter Unit Price';
  String Steplelength = 'Please enter Staple length';
  String yarnStrength = 'Please enter Yarn Strength';
  String qualityGining = 'Please enter quality after Ginning';
  TextEditingController unitpriceController = TextEditingController();
  TextEditingController expectedYarnGradeController = TextEditingController();
  TextEditingController SteplelengthController = TextEditingController();
  TextEditingController yarnStrengthController = TextEditingController();
  TextEditingController qualityGiningController = TextEditingController();

  String locationValue = 'Please enter your address';
  bool _isCreating = false;
  int userid=0;
  DateTime? selectedDate;
  int? _selectedIndex;


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

  Future<bool> _onWillPop() async {
    return true;
  }

  void getsetting(String id) async {
    EasyLoading.show(status: 'loading...');

    fetchsettingdata = ApiService.fetchRouteData("2");
    _cottonVeriety.clear();
    _typeFertilization.clear();
    _typePesticides.clear();
    _settingsNumber.clear();
    fetchsettingdata.then((response) {
      fetchsettingdata.then((response) {
        setState(() {
          _cottonVeriety.clear();
          _typeFertilization.clear();
          _typePesticides.clear();
          _settingsNumber.clear();

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
      _isCreating = false;
      EasyLoading.dismiss();
    });
  }

  void _refreshPage() {
    fetchData();
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
                  const Text(
                    "Create Form For Spinner",
                    style: TextStyle(
                      fontFamily: 'Poppins_semi',
                      color: Colors.black,
                      fontSize: 16.0,
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


                                        buildTitleValue('Planting Date', convertDate(data![index].plantingDate!)),
                                        buildTitleValue('Cotton Variety', getCottonVarietyName(data![index].cottonVarietyId!)),
                                        buildTitleValue('Expected Yield', data![index].expectedYield!),
                                        buildTitleValue('Fertilization Type', getFertilizationtype(data![index].typeFertilizationId!)),
                                        buildTitleValue('Fertilization Amount', data![index].fertilizationAmount!),
                                        buildTitleValue('Irrigation Amount', data![index].wateringSchedules!),
                                        buildTitleValue('Pesticides Type', getPesticidesName(data![index].typePesticidesId!)),
                                        if(data![index].pesticidesAmount!=null)
                                          buildTitleValue('Pesticides Amount', data![index].pesticidesAmount!),
                                        buildTitleValue('Harvesting Value', data![index].harvesting!),
                                       /* if(data![index].video!.isNotEmpty)
                                        buildTitleValueone('Video'),
                                        if(data![index].video!.isNotEmpty)
                                        VideoPlayerWidget(url:data![index].video!),*/
                                        const SizedBox(height: 10.0),
                                        if(data![index].ginnerInvoice!=null)
                                          buildTitleValueone('Cotton Order Details'),
                                        if(data![index].ginnerInvoice!=null)
                                          buildTitleValue('Cotton quantity',data![index].harvesting!),
                                        if(data![index].unitPrice!=null)
                                          buildTitleValue('Cotton Price per kg',data![index].unitPrice!),
                                        if(data![index].unitPrice==null)
                                          buildTitleValue('Cotton Price per kg',"0.0"),
                                        if(data![index].ginnerInvoice!=null)
                                          buildTitleValue('Cotton Total Price',data![index].ginnerInvoice!.totalPrice!),
                                        if(data![index].ginnerInvoice!=null)
                                          if(data![index].ginnerInvoiceSpinner==null)
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
                                                    'Create Form For Spinner',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
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
                                                    controller: locationController,
                                                    keyboardType: TextInputType.text,
                                                    decoration: const InputDecoration(
                                                      labelText: 'Enter your address',  // Label as title when field is focused or filled
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
                                                      'Select Planting Date',
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
                                                              ? 'Select Planting Date'  // Placeholder when no date is selected
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
                                                    controller: expectedYarnGradeController,
                                                    keyboardType: TextInputType.text,
                                                    decoration: const InputDecoration(
                                                      labelText: 'Enter Grade',  // Label as title when field is focused or filled
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
                                                    controller: SteplelengthController,
                                                    keyboardType: TextInputType.text,
                                                    decoration: const InputDecoration(
                                                      labelText: 'Enter Staple length',  // Label as title when field is focused or filled
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
                                                    controller: yarnStrengthController,
                                                    keyboardType: TextInputType.text,
                                                    decoration: const InputDecoration(
                                                      labelText: 'Enter Yarn Strength',  // Label as title when field is focused or filled
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
                                                    controller: qualityGiningController,
                                                    keyboardType: TextInputType.number,
                                                    decoration: const InputDecoration(
                                                      labelText: 'Quantity After Ginning',  // Label as title when field is focused or filled
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
                                                        color: Colors.white,
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
                                                    controller: unitpriceController,
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
                                                        color: Colors.white,
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
                                                    saveDataforginner(data![index].id!.toString(),data![index].ginnerId!.toString());
                                                  },
                                                  child: const Text(
                                                    'Save Data For Spinner',
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
                                        if(data![index].ginnerInvoiceSpinner!=null)
                                          buildTitleValueone('Yarn Details'),
                                        if(data![index].ginnerInvoiceSpinner!=null)
                                          buildTitleValue('Location',data![index].ginnerInvoiceSpinner!.location!),
                                        if(data![index].ginnerInvoiceSpinner!=null)
                                          buildTitleValue('Yarn grade',data![index].ginnerInvoiceSpinner!.grade!),
                                        if(data![index].ginnerInvoiceSpinner!=null)
                                          buildTitleValue('Yarn staple length',data![index].ginnerInvoiceSpinner!.stapleLength!),
                                        if(data![index].ginnerInvoiceSpinner!=null)
                                          buildTitleValue('Yarn strength',data![index].ginnerInvoiceSpinner!.strength!),
                                        if(data![index].ginnerInvoiceSpinner!=null)
                                          buildTitleValue('Yarn quantity after ginning',"${data![index].ginnerInvoiceSpinner!.quantityAfterGinning!}kg"),
                                        if(data![index].ginnerInvoiceSpinner!=null)
                                          buildTitleValue('Ginning Date', convertDate(data![index].ginnerInvoiceSpinner!.dateGinning!)),
                                        if(data![index].ginnerInvoiceSpinner!=null)
                                          if(data![index].ginnerInvoiceSpinner?.unitPrice!=null)
                                          buildTitleValue('Unit Price', data![index].ginnerInvoiceSpinner!.unitPrice!+"/kg".toString()??""),
                                        if(data![index].ginnerInvoiceSpinner!=null)
                                          if(data![index].ginnerInvoiceSpinner!.adminStatus!=1)

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
                                                child:
                                                TextButton(
                                                  onPressed: () async {
                                                    final result = await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => EditCreateFormForSpinnerCottonbatch(
                                                            incommingCottonBatchId:data![index].ginnerInvoiceSpinner!.id.toString(),
                                                            ginnerId:data![index].ginnerInvoiceSpinner!.ginnerId!.toString(),
                                                            location:data![index].ginnerInvoiceSpinner!.location.toString(),
                                                            dateGinning: data![index].ginnerInvoiceSpinner!.dateGinning.toString(),
                                                            grade:data![index].ginnerInvoiceSpinner!.grade.toString(),
                                                            stapleLength:data![index].ginnerInvoiceSpinner!.stapleLength!,
                                                            strength:  data![index].ginnerInvoiceSpinner!.strength!,
                                                            quantityAfterGinning: data![index].ginnerInvoiceSpinner!.quantityAfterGinning!,
                                                            unitprice:data![index].ginnerInvoiceSpinner!.unitPrice.toString()??'',
                                                            farmerformid:data![index].ginnerInvoiceSpinner!.farmerFormId!.toString(),

                                                        ),
                                                      ),
                                                    );
                                                    if (result != null) {
                                                      _refreshPage();
                                                    }
                                                  },
                                                  child: const Text(
                                                    'Edit Form',
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
  saveinvice(String incommingCottonBatchId,String ginnerId) async {
    if (expectedYielderrorController == null &&
        expectedYielderrorController.text
            .trim()
            .isEmpty) {
      EasyLoading.showError('Please Enter Cotton Quantity');
      return ''; // Return an empty string or handle as needed
    } else if (fertilizationamountController.text
        .trim()
        .isEmpty) {
      EasyLoading.showError('Please enter Cotton Price per kg');
      return ''; // Return an empty string or handle as needed
    } else {
      String qut = expectedYielderrorController.text.trim();
      String amunt = fertilizationamountController.text.trim();

      try {
        EasyLoading.show(status: 'loading...');
        double quantity = double.parse(qut);
        double amountPerKg = double.parse(amunt);

        // Calculate the total price
        double totalPrice = quantity * amountPerKg;
        String totalprice=totalPrice.toStringAsFixed(2);
        String incommingCottonBatchIds=incommingCottonBatchId;
        String ginnerIds=ginnerId;
        String qty=quantity.toStringAsFixed(1);
        String price=amountPerKg.toStringAsFixed(2);
        try {
          var newData = await SaveInvoice.fetchRouteData(incommingCottonBatchIds, ginnerIds, qty, price, totalprice);
          FarmerFormListResponce? manufacturerListResponse = await Future.value(newData);
          if (manufacturerListResponse?.errorCode == "0") {
            EasyLoading.showError('Invoice Generated Successfully');
            fetchData();
          }else{
            EasyLoading.dismiss();
            EasyLoading.showError('Failed Something is Wrong !');
          }
        } catch (e) {
          EasyLoading.showError('Failed to save invoice');
        }

      } catch (e) {
        // Handle any parsing errors
        EasyLoading.showError('Invalid input. Please enter valid numbers.');
        return ''; // Return an empty string or handle as needed
      }
    }
  }
  saveDataforginner(String incommingCottonBatchId,String ginnerId) async {
    if( locationController.text.trim().isEmpty){
      EasyLoading.showError('Please Enter Your Location');
    }else if(selectedDate==null){
      EasyLoading.showError('Please Select Ginning Date');
    }else if(expectedYarnGradeController.text.trim().isEmpty){
      EasyLoading.showError('Please enter Yarn Grade');
    }else if(SteplelengthController.text.trim().isEmpty){
      EasyLoading.showError('Please enter Staple Length');
    }else if(yarnStrengthController.text.trim().isEmpty){
      EasyLoading.showError('Please enter Yarn Strength');
    }else if(qualityGiningController.text.trim().isEmpty){
      EasyLoading.showError('Please enter Quantity After Ginning');
    }else if(unitpriceController.text.trim().isEmpty){
      EasyLoading.showError('Please enter Unit Price');
    }else{
      EasyLoading.show(status: 'loading...');
      String selectedDates="${selectedDate?.year}-${selectedDate?.month}-${selectedDate?.day}";
      try {
        var newData = await SaveGinnerData.fetchRouteData(incommingCottonBatchId, ginnerId, locationController.text.toString(), selectedDates,
            expectedYarnGradeController.text.toString(),SteplelengthController.text.toString(),yarnStrengthController.text.toString(),qualityGiningController.text.toString(),unitpriceController.text.toString());
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

class SaveInvoice {
  static var client = http.Client();

  static Future<FarmerFormListResponce> fetchRouteData(String incommingCottonBatchId,
      String ginnerId,String qty,String price,String totalPrice) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.ginner_incomming_cotton_batch_create_invoice);
    Map body = {
      'incomming_cotton_batch_id': incommingCottonBatchId,
      'ginner_id': ginnerId,
      'qty': qty,
      'price': price,
      'total_price': totalPrice,
    };
    http.Response response = await http.post(url, body: jsonEncode(body),headers: headers);

    if (response.statusCode == 200) {
      return formrouteModelFromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }}

class SaveGinnerData {
  static var client = http.Client();

  static Future<FarmerFormListResponce> fetchRouteData(String incommingCottonBatchId,
      String ginnerId,String location,String dateGinning,String grade,String stapleLength,String strength,String quantityAfterGinning,String unitprice) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.ginner_form_create_spinner);
    Map body = {
      'incomming_cotton_batch_id': incommingCottonBatchId,
      'ginner_id': ginnerId,
      'location': location,
      'date_ginning': dateGinning,
      'grade': grade,
      'staple_length': stapleLength,
      'strength': strength,
      'unit_price':unitprice,
      'quantity_after_ginning': quantityAfterGinning

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
    var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.ginner_incomming_cotton_batch);
    Map body = {
      'ginner_id': Farmerid,
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

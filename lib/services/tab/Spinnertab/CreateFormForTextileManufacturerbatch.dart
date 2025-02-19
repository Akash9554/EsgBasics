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


class CreateFormForTextileManufacturerbatch extends StatefulWidget {
  const CreateFormForTextileManufacturerbatch({super.key});

  @override
  _CreateFormForTextileManufacturerbatchState createState() => _CreateFormForTextileManufacturerbatchState();
}

class _CreateFormForTextileManufacturerbatchState extends State<CreateFormForTextileManufacturerbatch> {
  final getstorage = GetStorage();
  Future<FarmerFormListResponce>? fetchdata;
  List<FormData>? data;
  final List<Setting> _settingsNumber = [];
  late Future<SettingResponce> fetchsettingdata;
  final List<CottonVariety> _cottonVeriety = [];
  final List<TypeFertilization> _typeFertilization = [];
  final List<TypePesticides> _typePesticides = [];
  final List<YarQuality> _yarQuality = [];

  YarQuality? _selectedYarQuality;

  String expectedYarnGrade = 'Please enter Yarn Grade';
  String Steplelength = 'Please enter Staple length';
  String yarnStrength = 'Please enter Yarn Strength';
  String qualityGining = 'Please enter quality after Ginning';
  TextEditingController expectedYielderrorController = TextEditingController();
  TextEditingController fertilizationamountController = TextEditingController();



  TextEditingController locationController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController countController = TextEditingController();
  TextEditingController strengthController = TextEditingController();
  TextEditingController qualityspinningController = TextEditingController();
  TextEditingController unitController = TextEditingController();


  String locationValue = 'Please enter your address';

  bool _isCreating = false;
  int userid=0;
  DateTime? selectedDate;
  int? _selectedIndex;
  int ginnerStatus=0;
  int adminStatus=0;


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
                                        if(data![index].spinnerInvoice!=null)
                                            if(data![index].farmerFormSpinnerForm==null)
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
                                                        'Create Form For Textile Manufacturer',
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
                                                      labelText: 'Enter your location',  // Label as title when field is focused or filled
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
                                                      'Select Spinning Date',
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
                                                              ? 'Select Spinning Date'  // Placeholder when no date is selected
                                                              : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                                                          style: const TextStyle(
                                                            color: Colors.black,  // Text color
                                                            fontSize: 16.0,
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

                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Container(
                                                padding: const EdgeInsets.all(5.0), // Add padding for consistency
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  border: Border.all(color: Colors.black), // Black border
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const Text(
                                                      'Select Yarn Quality', // Label text
                                                      style: TextStyle(
                                                        color: Colors.black, // Label text color for contrast
                                                        fontSize: 14.0,
                                                        fontFamily: 'Poppins_sego',
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5.0), // Space between label and dropdown
                                                    DropdownButtonFormField<YarQuality>(
                                                      dropdownColor: Colors.white, // Set the dropdown background color to white
                                                      decoration: const InputDecoration(
                                                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                                                        border: InputBorder.none, // No border for the dropdown
                                                      ),
                                                      hint: const Text(
                                                        'Select Yarn Quality',
                                                        style: TextStyle(color: Colors.black), // Set hint text color to black for better contrast
                                                      ),
                                                      value: _selectedYarQuality,
                                                      onChanged: (YarQuality? newValue) {
                                                        setState(() {
                                                          _selectedYarQuality = newValue;
                                                        });
                                                      },
                                                      items: _yarQuality.map((yarQuality) {
                                                        return DropdownMenuItem<YarQuality>(
                                                          value: yarQuality,
                                                          child: Text(
                                                            yarQuality.name ?? '',
                                                            style: const TextStyle(
                                                              color: Colors.black, // Set dropdown item text color to black
                                                              fontSize: 16.0,
                                                              fontFamily: 'Poppins_sego',
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
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
                                                    controller: countController,
                                                    keyboardType: TextInputType.number,
                                                    decoration: const InputDecoration(
                                                      labelText: 'Enter Count',  // Label as title when field is focused or filled
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
                                                    controller: strengthController,
                                                    keyboardType: TextInputType.text,
                                                    decoration: const InputDecoration(
                                                      labelText: 'Enter Strength',  // Label as title when field is focused or filled
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
                                                    controller: qualityspinningController,
                                                    keyboardType: TextInputType.number,
                                                    decoration: const InputDecoration(
                                                      labelText: 'Enter Quantity After Spinning',  // Label as title when field is focused or filled
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
                                                    controller: unitController,
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
                                                    saveDataforginner(data![index].spinnerInvoice!.farmerFormId!.toString(),data![index].spinnerDetail!.id!.toString(),data![index].spinnerDetail!.name!.toString());
                                                  },
                                                  child: const Text(
                                                    'Save Data For Textile Manufacturer',
                                                    textAlign:TextAlign.center,
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
                                        if(data![index].farmerFormSpinnerForm!=null)
                                          buildTitleValueone('Product Details'),
                                        if(data![index].farmerFormSpinnerForm!=null)
                                          buildTitleValue('Location',data![index].farmerFormSpinnerForm!.location!),
                                        if(data![index].farmerFormSpinnerForm!=null)
                                          buildTitleValue('Name',data![index].farmerFormSpinnerForm!.name!),
                                        if(data![index].farmerFormSpinnerForm!=null)
                                          buildTitleValue('Product Quality', getFertilizationtype(int.parse(data![index].farmerFormSpinnerForm!.yarQualityId!))),
                                        if(data![index].farmerFormSpinnerForm!=null)
                                          buildTitleValue('Product Count',data![index].farmerFormSpinnerForm!.count!),
                                        if(data![index].farmerFormSpinnerForm!=null)
                                          buildTitleValue('Product strength',data![index].farmerFormSpinnerForm!.strength!),
                                        if(data![index].farmerFormSpinnerForm!=null)
                                          buildTitleValue('Product quantity after spinning',"${data![index].farmerFormSpinnerForm!.quantityYarnProduce!}kg"),
                                        if(data![index].farmerFormSpinnerForm!=null)
                                          buildTitleValue('Spinning Date', convertDate(data![index].farmerFormSpinnerForm!.dateSpinning!)),
                                        if(data![index].farmerFormSpinnerForm!=null)
                                          buildTitleValue('Unit Price',data![index].farmerFormSpinnerForm!.unitPrice!),
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
  String getstatus(int id) {
    if (id == 0) {
      return "Pending";
    }else if(id==2){
      return "Rejected";
    }
    return 'Approved';
  }
  String getFertilizationtype(int id) {
    for (var variety in _yarQuality) {
      if (variety.id == id) {
        return variety.name!;
      }
    }
    return 'Unknown Variety';
  }

  saveinvice(String incommingCottonBatchId,String ginnerId) async {
    if (expectedYielderrorController == null &&
        expectedYielderrorController.text
            .trim()
            .isEmpty) {
      EasyLoading.showError('Please Enter Cotton Quantity');
      return '';
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
  saveDataforginner(String incommingCottonBatchId,String ginnerId,String name) async {
    if( locationController.text.trim().isEmpty){
      EasyLoading.showError('Please Enter Your Location');
    }else if(selectedDate==null){
      EasyLoading.showError('Please Select Spinning Date');
    }else if(_selectedYarQuality==null){
      EasyLoading.showError('Please select Yarn Quality');
    }else if(countController.text.trim().isEmpty){
      EasyLoading.showError('Please enter Count');
    }else if(strengthController.text.trim().isEmpty){
      EasyLoading.showError('Please enter Yarn Strength');
    }else if(qualityspinningController.text.trim().isEmpty){
      EasyLoading.showError('Please enter Quantity After Ginning');
    }else if(unitController.text.trim().isEmpty){
      EasyLoading.showError('Please enter unit price');
    }

    else{
      EasyLoading.show(status: 'loading...');
      String selectedDates="${selectedDate?.year}-${selectedDate?.month}-${selectedDate?.day}";
      try {
        var newData = await SaveGinnerData.fetchRouteData(incommingCottonBatchId, ginnerId,name,
            locationController.text.toString(),
            selectedDates,
            _selectedYarQuality!.id!.toString(),
            countController.text.toString(),
            strengthController.text.toString(),
            qualityspinningController.text.toString(),
            unitController.text.toString());
        FarmerFormListResponce? manufacturerListResponse = await Future.value(newData);
        if (manufacturerListResponse?.errorCode == "0") {
          fetchData();
          EasyLoading.showError('Data Saved Successfully');
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

  static Future<FarmerFormListResponce> fetchRouteData(String farmer_form_id,
      String spinner_id,String name,String location,String date_spinning,String yar_quality_id,String count,String strength,String quantity_yarn_produce,String unitprice) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.spinner_create_form);
    Map body = {
      'farmer_form_id': farmer_form_id,
      'spinner_id': spinner_id,
      'name': name,
      'location': location,
      'date_spinning': date_spinning,
      'yar_quality_id': yar_quality_id,
      'count': count,
      'strength': strength,
      'quantity_yarn_produce': quantity_yarn_produce,
      'unit_price':unitprice,

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
    var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.spinner_ginner_invoice);
    Map body = {
      'spinner_id': Farmerid,
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

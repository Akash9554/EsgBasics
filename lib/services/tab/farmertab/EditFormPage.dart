
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:video_player/video_player.dart';
import 'dart:async';

import '../../../Listofallvideo.dart';
import '../../../Model/SettingResponce.dart';
import '../../../controller/Edit_form_controller.dart';
import '../../../profile.dart';




class EditFormPage extends StatefulWidget {
  final String farmer_id;
  final  String planting_date;
  final String cotton_variety_id;
  final String expected_yield;
  final String type_fertilization_id;
  final String fertilization_amount;
  final String watering_schedules;
  final String pesticides_amount;
  final String type_pesticides_id;
  final String harvesting;
  final String video;
  final String rain_fed_only;
  final String location;
  final String unit;
  const EditFormPage({required this.farmer_id,required this.planting_date,required this.cotton_variety_id,required this.expected_yield,
  required this.type_fertilization_id, required this.fertilization_amount, required this.watering_schedules,
  required this.pesticides_amount,required this.type_pesticides_id,required this.harvesting, required this.video,
  required this.rain_fed_only, required this.location,required this.unit});


  @override
  State<EditFormPage> createState() => _EditFormPageState();
}

class _EditFormPageState extends State<EditFormPage> {
  final getstorage = GetStorage();
  DateTime? selectedDate;
  late Future<SettingResponce> fetchsettingdata;
  TypeFertilization? _selectedFertilization;
  CottonVariety? _selectedCottonVariety;
  TypePesticides? _selectedTypePesticides;
  final List<CottonVariety> _cottonVeriety = [];
  final List<TypeFertilization> _typeFertilization = [];
  final List<TypePesticides> _typePesticides = [];
  final List<Setting> _settingsNumber = [];
  String expectedYielderror = 'Please enter expected yield';
  String fertilizationamount = 'Please enter fertilization amount';
  String wateringsedule = 'Please enter watering Schedules';
  String pesticidesamount = 'Please enter pesticides amount';
  String harvestingvalue = 'Please enter harvesting value';
  String locationValue = 'Please enter your address';
  TextEditingController expectedYielderrorController = TextEditingController();
  TextEditingController fertilizationamountController = TextEditingController();
  TextEditingController wateringseduleController = TextEditingController();
  TextEditingController pesticidesamountController = TextEditingController();
  TextEditingController harvestingvalueController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController priceperunitController = TextEditingController();

  VideoPlayerController? _controller;
  final ImagePicker _picker = ImagePicker();
  XFile? _video;
  int userid=0;
  bool _isChecked = false;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _video = pickedFile;
      });
      _initializeVideoController();
    }
  }

  void _initializeVideoController() {
    if (_video != null) {
      _controller = VideoPlayerController.file(File(_video!.path))
        ..initialize().then((_) {
          setState(() {}); // To rebuild the UI after the video is initialized
          _controller?.play();
        });
    }
  }

  void _removeVideo() {
    setState(() {
      _video = null;
      _controller?.dispose();
      _controller = null;
    });
  }


  @override
  void initState() {
    super.initState();
    userid=getstorage.read("id");
    selectedDate= convertDate(widget.planting_date);
    String expectedYieldText = widget.expected_yield.toString();

    RegExp regExp = RegExp(r'\d+');
    String? extractedKg = regExp.firstMatch(expectedYieldText)?.group(0);
    expectedYielderrorController.text=extractedKg!;
    String expectedYieldTexts = widget.fertilization_amount.toString();

    RegExp regExps = RegExp(r'\d+');
    String? extractedKgs = regExps.firstMatch(expectedYieldTexts)?.group(0);
    fertilizationamountController.text=extractedKgs!;

    String expectedYieldTextss = widget.watering_schedules.toString();

    RegExp regExpss = RegExp(r'\d+');
    String? extractedKgss = regExpss.firstMatch(expectedYieldTextss)?.group(0);
    wateringseduleController.text=extractedKgss!;

    String expectedYieldTextsss = widget.pesticides_amount.toString();

    RegExp regExpsss = RegExp(r'\d+');
    String? extractedKgsss = regExpsss.firstMatch(expectedYieldTextsss)?.group(0);

    pesticidesamountController.text=extractedKgsss!;
    harvestingvalueController.text=widget.harvesting.toString();
    locationController.text=widget.location.toString();
    priceperunitController.text=widget.unit.toString();
    if(widget.video!="")
    _video= XFile(widget.video);
    _controller = VideoPlayerController.file(File(widget.video));
    getsetting("2");
  }
  DateTime convertDate(String dateStr) {
    List<String> parts = dateStr.split('-');
    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int day = int.parse(parts[2]);
    DateTime parsedDate = DateTime(year, month, day);
    return parsedDate;
  }
  void getsetting(String id) async {
    EasyLoading.show(status: 'loading...');
      fetchsettingdata = ApiService.fetchRouteData(userid.toString());
      _cottonVeriety.clear();
      _typeFertilization.clear();
      _typePesticides.clear();
      _settingsNumber.clear();
        fetchsettingdata.then((response) {
          setState(() {
            _cottonVeriety.clear();
            _typeFertilization.clear();
            _typePesticides.clear();
            _settingsNumber.clear();

            if(response.cottonVariety != null) {
              _cottonVeriety.addAll(response.cottonVariety!);
            }
            if (_cottonVeriety.isNotEmpty) {
              _selectedCottonVariety = _cottonVeriety.firstWhere(
                    (variety) => variety.id == widget.cotton_variety_id,
                orElse: () => _cottonVeriety.first, // Fallback to the first item if no match
              );
            }
            if( response.typeFertilization != null) {
              _typeFertilization.addAll(response.typeFertilization!);
            }
            if (_typeFertilization.isNotEmpty) {
              _selectedFertilization = _typeFertilization.firstWhere(
                    (variety) => variety.id == widget.type_fertilization_id,
                orElse: () => _typeFertilization.first, // Fallback to the first item if no match
              );
            }
            if( response.typePesticides != null) {
              _typePesticides.addAll(response.typePesticides!);
            }
            if (_typePesticides.isNotEmpty) {
              _selectedTypePesticides = _typePesticides.firstWhere(
                    (variety) => variety.id == widget.type_pesticides_id,
                orElse: () => _typePesticides.first, // Fallback to the first item if no match
              );
            }
            if( response.setting != null) {
              _settingsNumber.addAll(response.setting!);
            }
          });
          EasyLoading.dismiss();
        }).catchError((error) {
          EasyLoading.dismiss();
          print("Error fetching data: $error");
        });}



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

  @override
  Widget build(BuildContext context) {
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF6EDB7B), // Green// Light green
                Color(0xFFCBFF6B), // Yellow-green
              ],
            ),
          ),
          width: swidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20.0), // Adjust the padding as needed
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 60),
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Align(
                  alignment: Alignment.center,
                  child:Text(
                    'Edit Farmer Form',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Poppins_sego'
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                child: SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () => _selectDate(context),  // Handle tap on the entire container
                    child: Container(
                      height: 70.0,  // Set the desired height here
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          selectedDate == null
                              ? 'Select Planting Date'
                              : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontFamily: 'Poppins_sego',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    height: 70.0, // Set the desired height here
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Center( // Center widget added here
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: double.infinity, // Make the dropdown take full width
                            child: DropdownButtonFormField<CottonVariety>(
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                                border: InputBorder.none,
                              ),
                              hint: const Text('Select Cotton Variety '),
                              value: _selectedCottonVariety,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedCottonVariety = newValue;
                                });
                              },
                              items: _cottonVeriety.map((cottonverity) {
                                return DropdownMenuItem<CottonVariety>(
                                  value: cottonverity,
                                  child: Text(
                                    cottonverity.name ?? '',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontFamily: 'Poppins_sego',
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: expectedYielderrorController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Expected Yield',
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontFamily: 'Poppins_sego',
                            ),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            suffixText: 'kg',
                            suffixStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontFamily: 'Poppins_sego',
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  height: 70.0, // Set the desired height here
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity, // Make the dropdown take full width
                          child: DropdownButtonFormField<TypeFertilization>(
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                              border: InputBorder.none,
                            ),
                            hint: const Text('Select Fertilization Type'),
                            value: _selectedFertilization,
                            onChanged: (newValue) {
                              if (newValue != _typeFertilization.first) {
                                setState(() {
                                  _selectedFertilization = newValue;
                                });
                              }else{
                                _selectedFertilization=null;
                              }
                            },
                            items: _typeFertilization.map((fertilization) {
                              return DropdownMenuItem<TypeFertilization>(
                                value: fertilization,
                                child: Text(
                                  fertilization.name ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontFamily: 'Poppins_sego',
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: fertilizationamountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Fertilization Amount',
                            hintStyle: TextStyle(color: Colors.black, fontSize: 14.0,fontFamily: 'Poppins_sego'),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            suffixText: 'kg',
                            suffixStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontFamily: 'Poppins_sego',
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: wateringseduleController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Irrigation Amount',
                            hintStyle: TextStyle(color: Colors.black, fontSize: 14.0,fontFamily: 'Poppins_sego'),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          suffixText: 'Litter',
                          suffixStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontFamily: 'Poppins_sego',
                          ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
              child: SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    // Handle container tap
                  },
                  child: Container(
                    height: 70.0, // Set the desired height here
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          value: _isChecked,

                          activeColor: Colors.black,
                          checkColor: Colors.white,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value!;
                                wateringseduleController.text="0";
                            });
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            // Handle text tap separately if needed
                          },
                          child: const Text(
                            'Rain fed only',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontFamily: 'Poppins_sego',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
              Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  height: 70.0, // Set the desired height here
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity, // Make the dropdown take full width
                          child: DropdownButtonFormField<TypePesticides>(
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                              border: InputBorder.none,
                            ),
                            hint: const Text('Select Pesticides'),
                            value: _selectedTypePesticides,
                            onChanged: (newValue) {
                              if (newValue != _typePesticides.first) {
                                setState(() {
                                  _selectedTypePesticides = newValue;
                                });
                              }else{
                                _selectedTypePesticides = null;
                              }
                            },
                            items: _typePesticides.map((pesticides) {
                              return DropdownMenuItem<TypePesticides>(
                                value: pesticides,
                                child: Text(
                                  pesticides.name ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontFamily: 'Poppins_sego',
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: pesticidesamountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Pesticides Amount',
                            hintStyle: TextStyle(color: Colors.black, fontSize: 14.0,fontFamily: 'Poppins_sego'),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            suffixText: 'kg',
                            suffixStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontFamily: 'Poppins_sego',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: harvestingvalueController,
                          decoration: const InputDecoration(
                            hintText: 'Harvesting Value',
                            hintStyle: TextStyle(color: Colors.black, fontSize: 14.0,fontFamily: 'Poppins_sego'),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: locationController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your address',
                            hintStyle: TextStyle(color: Colors.black, fontSize: 14.0,fontFamily: 'Poppins_sego'),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: priceperunitController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Enter price/unit',
                            hintStyle: TextStyle(color: Colors.black, fontSize: 14.0,fontFamily: 'Poppins_sego'),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child:SizedBox(
                  width: double.infinity,
                  child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child:
                  Column(
                  children: <Widget>[
                    _video == null
                        ? const Text('No video selected.',style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontFamily: 'Poppins_sego',
                    ))
                        : Column(
                      children: [
                        VideoPlayerWidget(url: _video!.path!),
                        const SizedBox(height: 10),
                    Container(
                    width: 400.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child:TextButton(
                          onPressed: _removeVideo,
                          child: const Text('Remove Video',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontFamily: 'Poppins_sego',
                            ),),
                        ),)
                      ],
                    ),
                    const SizedBox(height: 20),
                Container(
                  width: 400.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child:TextButton(
                      onPressed: _pickVideo,
                      child: const Text('Select Video from Gallery',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontFamily: 'Poppins_sego',
                        ),),
                    ),)
                  ],
                ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 400.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: TextButton(
                        onPressed: () {
                          save_form(context,widget.farmer_id);
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontFamily: 'Poppins_sego',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> save_form(BuildContext , String edit_id) async {
    if(selectedDate==null){
      EasyLoading.showError('Please Select Planting Date');
    }else if(_selectedCottonVariety == null){
      EasyLoading.showError('Please Select Cotton Type');
    }else if(expectedYielderrorController.text.trim().isEmpty){
      EasyLoading.showError('Please enter Expected Yield');
    }else if(_selectedFertilization==null){
      EasyLoading.showError('Please Select Fertilization Type');
    }else if(fertilizationamountController.text.trim().isEmpty){
      EasyLoading.showError('Please enter Fertilization Amount');
    }else if(wateringseduleController.text.trim().isEmpty){
      EasyLoading.showError('Please enter Watering Schedules');
    }else if(_selectedTypePesticides==null){
      EasyLoading.showError('Please Select Pesticides Type ');
    }else if(pesticidesamountController.text.trim().isEmpty){
      EasyLoading.showError('Please enter Pesticides Amount ');
    }else if(harvestingvalueController.text.trim().isEmpty){
      EasyLoading.showError('Please enter Harvesting Value  ');
    }else if(priceperunitController.text.trim().isEmpty){
      EasyLoading.showError('Please enter unit price');
    }else if(locationController.text.trim().isEmpty){
      EasyLoading.showError('Please enter your address');
    }else {
        String rainFedOnly="";
      if(_isChecked){
        rainFedOnly="1";
      }else{
        rainFedOnly="2";
      }
      if(_video!.path==null||_video!.path.contains(".mp4")){
        String selectedDates="${selectedDate?.year}-${selectedDate?.month}-${selectedDate?.day}";
        EditFormController.loginwithoutvideo(
            context,userid.toString(),selectedDates,_selectedCottonVariety!.id!.toString(),"${expectedYielderrorController.text.trim()} kg",
            _selectedFertilization!.id.toString(),"${fertilizationamountController.text.trim()} kg","${wateringseduleController.text.trim()} Litter",
            "${pesticidesamountController.text.trim()} kg",_selectedTypePesticides!.id.toString(),harvestingvalueController.text.trim(),
            "",rainFedOnly,locationController.text.trim(),priceperunitController.text.trim(),edit_id);
      }else{
        String selectedDates="${selectedDate?.year}-${selectedDate?.month}-${selectedDate?.day}";
        EditFormController.login(context,userid.toString(),selectedDates,_selectedCottonVariety!.id!.toString(),"${expectedYielderrorController.text.trim()} kg",
            _selectedFertilization!.id.toString(),"${fertilizationamountController.text.trim()} kg","${wateringseduleController.text.trim()} Litter",
            "${pesticidesamountController.text.trim()} kg",_selectedTypePesticides!.id.toString(),harvestingvalueController.text.trim(),
            _video!.path,rainFedOnly,locationController.text.trim(),priceperunitController.text.trim(),edit_id);
      }
    }
  }

}


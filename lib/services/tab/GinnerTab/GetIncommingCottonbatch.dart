import 'dart:convert';

import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../Model/FarmerFormListResponce.dart';
import '../../../Model/GinnerIncommingbatchList.dart';
import '../../../Model/SettingResponce.dart';
import '../../../Widget/DelayedWebView.dart';
import '../../../Widget/api.dart';
import '../../../profile.dart';

class GetIncommingCottonbatch extends StatefulWidget {
  const GetIncommingCottonbatch({super.key});

  @override
  _GetIncommingCottonbatchState createState() => _GetIncommingCottonbatchState();
}

class _GetIncommingCottonbatchState extends State<GetIncommingCottonbatch> {
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
  // The original list of data
  List<FormData> filteredData = [];
  TextEditingController searchController = TextEditingController();// The filtered list of data


  String expectedYarnGrade = 'Please enter Yarn Grade';
  String Steplelength = 'Please enter Staple length';
  String yarnStrength = 'Please enter Yarn Strength';
  String qualityGining = 'Please enter quality after Ginning';
  TextEditingController expectedYarnGradeController = TextEditingController();
  TextEditingController SteplelengthController = TextEditingController();
  TextEditingController yarnStrengthController = TextEditingController();
  TextEditingController qualityGiningController = TextEditingController();
  Map<int, TextEditingController> controllers = {};
  Map<int, TextEditingController> controllerssec = {};
  String expectedYielderror = 'Please enter Cotton Quantity';
  String fertilizationamount = 'Please enter Per kg amount';
  String locationValue = 'Please enter your address';
  int userid=0;
  DateTime? selectedDates;



  TextEditingController getTextController(int index, String value) {
    if (!controllers.containsKey(index)) {
      controllers[index] = TextEditingController();
      if (value.endsWith(' kg')) {
        value = value.substring(0, value.length - 3).trim();
      }

      controllers[index]!.text = value;
    }
    return controllers[index]!;
  }
  TextEditingController getTextControllersec(int index, String value) {
    if (!controllerssec.containsKey(index)) {
      controllerssec[index] = TextEditingController();
      if (value.endsWith(' kg')) {
        value = value.substring(0, value.length - 3).trim();
      }

      controllerssec[index]!.text = value;
    }
    return controllerssec[index]!;
  }


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  void _filterData() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredData = data!.where((item) {
        final nameMatches = item.farmerDetail?.name?.toLowerCase().contains(query) ?? false;
        final locationMatches = item.location?.toLowerCase().contains(query) ?? false;
        return nameMatches || locationMatches;
      }).toList();
    });
  }


  @override
  void initState() {
    super.initState();
    userid=getstorage.read("id");
    getsetting(userid.toString());
    fetchData();
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
        print("Error fetching data: $error");
      });});}


  void fetchData() async {
    var newData = await ChatApiService.fetchRouteData(userid.toString());
    FarmerFormListResponce? manufacturerListResponse = await Future.value(newData);

    setState(() {
      fetchdata = Future.value(newData);

      data?.clear();
      data = manufacturerListResponse?.data;
      filteredData = data!; // Initialize filteredData with allData
      searchController.addListener(_filterData);

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
              child: Column(
                children: [
                  // Row with back button and title
                  Row(
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
                        "Cotton Batch List",
                        style: TextStyle(
                          fontFamily: 'Poppins_semi',
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0), // Add some space between the row and text field
                  // Search TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add horizontal padding for the TextField
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
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
                          itemCount: filteredData.length, // Use data?.length with null check
                          itemBuilder: (context, index) {
                            final item = filteredData[index];
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
                                        buildTitleValue('Farmer Name', item.farmerDetail!.name!),
                                        buildTitleValue('Farmer Mobile Number', item.farmerDetail!.mobileNo!),
                                        buildTitleValue('Farmer Email address', item.farmerDetail!.email!),
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

                                        const SizedBox(height: 10.0),
                                        if(item.ginnerInvoice==null)
                                          buildTitleValueone('Cotton Invoice Form'),
                                        if(item.ginnerInvoice==null)

                                          Container(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    controller: getTextController(index, item.harvesting!),
                                                    keyboardType: TextInputType.number,
                                                    decoration: const InputDecoration(
                                                      labelText: 'Enter Cotton Quantity',  // Label as title when field is focused or filled
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

                                        if(item.ginnerInvoice==null)
                                          Container(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    controller:  getTextControllersec(index, item.unitPrice!),
                                                    keyboardType: TextInputType.number,
                                                    decoration: const InputDecoration(
                                                      labelText: 'Cotton Price per Kg',  // Label as title when field is focused or filled
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

                                        SizedBox(height: 20),
                                        if(item.ginnerInvoice==null)
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
                                                  saveinvice(item.id.toString(),item.ginnerId.toString(),index);
                                                },
                                                child: const Text(
                                                  'Purchase Order',
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
                                        if(item.ginnerInvoice==null)
                                        SizedBox(height: 20),
                                        if(item.ginnerInvoice!=null)
                                          buildTitleValueone('Cotton Order Details'),
                                        if(item.ginnerInvoice!=null)
                                        buildTitleValue('Cotton quantity',item.harvesting!),
                                        if(item.unitPrice!=null)
                                        buildTitleValue('Cotton Price per kg',item.unitPrice!),
                                        if(item.unitPrice==null)
                                          buildTitleValue('Cotton Price per kg',"0.0"),
                                        if(item.ginnerInvoice!=null)
                                        buildTitleValue('Cotton Total Price',item.ginnerInvoice!.totalPrice!),
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
    SettingResponce? manufacturerListResponse = await Future.value(newData);
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
  saveinvice(String incommingCottonBatchId,String ginnerId,int index) async {
    if (controllers[index]?.text.trim().isEmpty ?? true) {
      EasyLoading.showError('Please Enter Cotton Quantity');
      return ''; // Return an empty string or handle as needed
    }
// Check if the second controller is empty
    else if (controllerssec[index]?.text.trim().isEmpty ?? true) {
      EasyLoading.showError('Please enter Cotton Price per kg');
      return ''; // Return an empty string or handle as needed
    } else {
      // Get values from both controllers
      String quantitys = controllers[index]!.text.trim();
      String amount = controllerssec[index]!.text.trim();

      try {
        EasyLoading.show(status: 'loading...');
        double quantity = double.parse(quantitys);
        double amountPerKg = double.parse(amount);
        double totalPrice = quantity * amountPerKg;
        String totalprice=totalPrice.toStringAsFixed(2);
        String incommingCottonBatchIds=incommingCottonBatchId;
        String ginnerIds=ginnerId;
        String qty=quantity.toStringAsFixed(1);
        String price=amountPerKg.toStringAsFixed(2);
        try {
          var newData = await SaveInvoice.fetchRouteData(incommingCottonBatchIds, ginnerIds, qty, price, totalprice);
          GinnerIncommingbatchList? manufacturerListResponse = await Future.value(newData);
          if (manufacturerListResponse?.errorCode == "0") {
            EasyLoading.showError('Purchased Successfully');
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
    }else if(selectedDates==null){
      EasyLoading.showError('Please Select Ginning Date');
    }else if(expectedYarnGradeController.text.trim().isEmpty){
      EasyLoading.showError('Please enter Yarn Grade');
    }else if(SteplelengthController.text.trim().isEmpty){
      EasyLoading.showError('Please enter Staple Length');
    }else if(yarnStrengthController.text.trim().isEmpty){
      EasyLoading.showError('Please enter Yarn Strength');
    }else if(qualityGiningController.text.trim().isEmpty){
      EasyLoading.showError('Please enter Quantity After Ginning');
    }else{
      String selectedDate="${selectedDates?.year}-${selectedDates?.month}-${selectedDates?.day}";
      try {
        var newData = await SaveGinnerData.fetchRouteData(incommingCottonBatchId, ginnerId, locationController.text.toString(), selectedDate,
            expectedYarnGradeController.text.toString(),SteplelengthController.text.toString(),yarnStrengthController.text.toString(),qualityGiningController.text.toString());
        GinnerIncommingbatchList? manufacturerListResponse = await Future.value(newData);
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
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _loadVideoInBackground();
  }

  // Method to load the video in the background
  void _loadVideoInBackground() async {
    _controller = VideoPlayerController.network(widget.url);

    // Initialize the video in the background
    await _controller.initialize().then((_) {
      if (mounted) {
        setState(() {
          _isInitialized = true; // Mark the video as initialized when done
        });
      }
    });

    _controller.addListener(() {
      if (mounted) {
        setState(() {
          _isPlaying = _controller.value.isPlaying;
        });
      }
    });
  }

  @override
  void dispose() {
    if (_isInitialized) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isInitialized
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

  static Future<GinnerIncommingbatchList> fetchRouteData(
      String incommingCottonBatchId,
      String ginnerId,
      String qty,
      String price,
      String totalPrice) async {
    var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.ginner_incomming_cotton_batch_create_invoice);

    var request = http.MultipartRequest('POST', url);

    // Add the form fields
    request.fields['incomming_cotton_batch_id'] = incommingCottonBatchId;
    request.fields['ginner_id'] = ginnerId;
    request.fields['qty'] = qty;
    request.fields['price'] = price;
    request.fields['total_price'] = totalPrice;
    var response = await request.send();

    // Check the response
    if (response.statusCode == 200) {
      var responseBody = await http.Response.fromStream(response);
      return formrouteModelFromJsonsas(responseBody.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class SaveGinnerData {
  static var client = http.Client();

  static Future<GinnerIncommingbatchList> fetchRouteData(String incommingCottonBatchId,
      String ginnerId,String location,String dateGinning,String grade,String stapleLength,String strength,String quantityAfterGinning) async {
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
      'quantity_after_ginning': quantityAfterGinning

    };
    http.Response response = await http.post(url, body: jsonEncode(body),headers: headers);

    if (response.statusCode == 200) {
      return formrouteModelFromJsonsas(response.body);
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

  static Future<SettingResponce> fetchRouteData(String farmerFormId,String farmerStatus,String ginnerInvoiceId) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.ginner_approve_reject_spinner_invoice);
    Map body = {
      'farmer_form_id': farmerFormId,
      'ginner_status':farmerStatus,
      'spinner_invoice_id': ginnerInvoiceId
    };
    http.Response response = await http.post(url, body: jsonEncode(body),headers: headers);
    if (response.statusCode == 200) {
      return routeModelFromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }}

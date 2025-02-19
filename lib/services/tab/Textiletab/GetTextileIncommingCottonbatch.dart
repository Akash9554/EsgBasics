import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import '../../../Model/FarmerFormListResponce.dart';
import '../../../Model/GinnerIncommingbatchList.dart';
import '../../../Model/SettingResponce.dart';
import '../../../Widget/DelayedWebView.dart';
import '../../../Widget/api.dart';
import '../../../profile.dart';




class GetTextileIncommingCottonbatch extends StatefulWidget {
  const GetTextileIncommingCottonbatch({super.key});

  @override
  _GetTextileIncommingCottonbatchState createState() => _GetTextileIncommingCottonbatchState();
}

class _GetTextileIncommingCottonbatchState extends State<GetTextileIncommingCottonbatch> {
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
  String Steplelength = 'Please enter Staple length';
  String yarnStrength = 'Please enter Yarn Strength';
  String qualityGining = 'Please enter quality after Ginning';
  TextEditingController expectedYarnGradeController = TextEditingController();
  TextEditingController SteplelengthController = TextEditingController();
  TextEditingController yarnStrengthController = TextEditingController();
  TextEditingController qualityGiningController = TextEditingController();

  String expectedYielderror = 'Please enter Cotton Quantity';
  String fertilizationamount = 'Please enter Per kg amount';
  String locationValue = 'Please enter your address';
  int userid=0;
  DateTime? selectedDate;
  Map<int, TextEditingController> controllers = {};
  Map<int, TextEditingController> controllerssec = {};


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
    var newData = await ChatApiServicespinner.fetchRouteData(userid.toString());
    FarmerFormListResponce? manufacturerListResponse = await Future.value(newData);

    setState(() {
      fetchdata = Future.value(newData);
      data?.clear();
      data = manufacturerListResponse?.data;
      EasyLoading.dismiss();
    });
  }


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
                    "Yarn Batch List",
                    style: TextStyle(
                      fontFamily: 'Poppins_medium',
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
                    padding: const EdgeInsets.fromLTRB(10.0, 1.0, 10.0, 10.0),
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
                                        buildTitleValueone('Farmer Details'),
                                        buildTitleValue('Farmer Name', data![index].farmerDetail!.name!),
                                        buildTitleValue('Farmer Mobile Number', data![index].farmerDetail!.mobileNo!),
                                        buildTitleValue('Farmer Email address', data![index].farmerDetail!.email!),
                                        buildTitleValue('Profile QR code',""),
                                        DelayedWebView(url:data![index].farmerDetail!.profile_qr_code!),

                                        if(data![index].ginnerDetail!=null)
                                          buildTitleValueone('Ginner Details'),
                                        buildTitleValue('Ginner Name', data![index].ginnerDetail!.name!),
                                        buildTitleValue('Ginner Mobile Number', data![index].ginnerDetail!.mobileNo!),
                                        buildTitleValue('Ginner Email address', data![index].ginnerDetail!.email!),
                                        buildTitleValue('Profile QR code', ""),
                                        DelayedWebView(url:data![index].ginnerDetail!.profile_qr_code!),

                                        if(data![index].spinnerDetail!=null)
                                          buildTitleValueone('Spinner Detail'),
                                        buildTitleValue('Spinner Name', data![index].spinnerDetail!.name!),
                                        buildTitleValue('Spinner Mobile Number', data![index].spinnerDetail!.mobileNo!),
                                        buildTitleValue('Spinner Email address', data![index].spinnerDetail!.email!),
                                        buildTitleValue('Profile QR code', ""),
                                        DelayedWebView(url:data![index].spinnerDetail!.profile_qr_code!),

                                        if(data![index].farmerFormSpinnerForm!=null)
                                          ...[
                                            buildTitleValueone('Product Details'),
                                            buildTitleValue('Location', data![index].farmerFormSpinnerForm!.location!),
                                            buildTitleValue('Spinning Date', convertDate(data![index].farmerFormSpinnerForm!.dateSpinning!)),
                                            buildTitleValue('Product Quality ', data![index].farmerFormSpinnerForm!.yarQualityId!),
                                            buildTitleValue('Product count', data![index].farmerFormSpinnerForm!.count!),
                                            buildTitleValue('Product strength', data![index].farmerFormSpinnerForm!.strength!),
                                            buildTitleValue('Yarn Produce ',"${data![index].farmerFormSpinnerForm!.quantityYarnProduce!}kg"),
                                            buildTitleValue('Unit Price ',"${data![index].farmerFormSpinnerForm!.unitPrice!}kg"),

                                          ],
                                        if(data![index].textileInvoice!=null)
                                          buildTitleValueone('Invoice Details'),
                                        if(data![index].textileInvoice!=null)
                                          buildTitleValue('Yarn quantity',data![index].textileInvoice!.qty!),
                                        if(data![index].textileInvoice!=null)
                                          buildTitleValue('Yarn Price per kg',data![index].textileInvoice!.price!),
                                        if(data![index].textileInvoice!=null)
                                          buildTitleValue('Yarn Total Price',data![index].textileInvoice!.totalPrice!),

                                        if(data![index].textileInvoice==null)
                                          buildTitleValueone('Invoice Form'),
                                        if(data![index].textileInvoice==null)
                                          Container(

                                              padding: const EdgeInsets.all(5.0),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    TextFormField(
                                                      controller: getTextController(index, data![index].farmerFormSpinnerForm!.quantityYarnProduce!),
                                                      keyboardType: TextInputType.number,
                                                      decoration: const InputDecoration(
                                                        labelText: 'Product Quantity',  // Label as title when field is focused or filled
                                                        labelStyle: TextStyle(
                                                          color: Colors.black,  // Label text color for contrast
                                                          fontSize: 16.0,
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
                                                          color: Colors.black,  // Suffix text color
                                                          fontSize: 16.0,
                                                          fontFamily: 'Reguler',
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
                                        if(data![index].textileInvoice==null)
                                          Container(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    controller: getTextControllersec(index,data![index].farmerFormSpinnerForm!.unitPrice!),
                                                    keyboardType: TextInputType.number,
                                                    decoration: const InputDecoration(
                                                      labelText: 'Product Price per Kg',  // Label as title when field is focused or filled
                                                      labelStyle: TextStyle(
                                                        color: Colors.black,  // Label text color for contrast
                                                        fontSize: 16.0,
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
                                                        color: Colors.black,  // Suffix text color
                                                        fontSize: 16.0,
                                                        fontFamily: 'Reguler',
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
                                        if(data![index].textileInvoice==null)
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 400.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                                child: TextButton(
                                                  onPressed: () {
                                                    saveinvice(data![index].farmerFormSpinnerForm!.farmerFormId!.toString(),data![index].farmerFormSpinnerForm!.textileManufacturerId.toString(),index);
                                                  },
                                                  child: const Text(
                                                    'Save Invoice',
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
  String convertDate(String dateStr) {
    List<String> parts = dateStr.split('-');
    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int day = int.parse(parts[2]);
    DateTime parsedDate = DateTime(year, month, day);
    String formattedDate = DateFormat('dd MMMM yyyy').format(parsedDate);
    return formattedDate;
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
      EasyLoading.showError('Please Enter  Quantity');
      return ''; // Return an empty string or handle as needed
    }
// Check if the second controller is empty
    else if (controllerssec[index]?.text.trim().isEmpty ?? true) {
      EasyLoading.showError('Please enter Product Price per kg');
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
          var newData=await SaveInvoice.fetchRouteData(incommingCottonBatchIds, ginnerIds, qty, price, totalprice);
          FarmerFormListResponce? manufacturerListResponse = await Future.value(newData);
          if (manufacturerListResponse?.errorCode == "0") {
            EasyLoading.showError('Invoice Generated Successfully');
            EasyLoading.show(status: 'loading...');
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

 /* saveDataforginner(String incommingCottonBatchId,String ginnerId) async {
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
    }else{
      String selectedDates="${selectedDate?.year}-${selectedDate?.month}-${selectedDate?.day}";
      try {
        var newData= await SaveGinnerData.fetchRouteData(incommingCottonBatchId, ginnerId, locationController.text.toString(), selectedDates,
            expectedYarnGradeController.text.toString(),SteplelengthController.text.toString(),yarnStrengthController.text.toString(),qualityGiningController.text.toString());
        GinnerIncommingbatchList? manufacturerListResponse = await Future.value(newData);
        if (manufacturerListResponse?.errorCode == "0") {
          EasyLoading.showError('Data Saved Successfully');
          EasyLoading.show(status: 'loading...');
          fetchData();
        }else{
          EasyLoading.dismiss();
          EasyLoading.showError('Failed Something is Wrong !');
        }
      } catch (e) {
        EasyLoading.showError('Failed to save invoice');
      }
    }

  }*/

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
    var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.textile_create_invoice);
    Map body = {
      'farmer_form_id': incommingCottonBatchId,
      'textile_manufacturer_id': ginnerId,
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


class ChatApiServicespinner {
  static var client = http.Client();

  static Future<FarmerFormListResponce> fetchRouteData(String Farmerid) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.textile_spinner_form_list);
    Map body = {
      'textile_manufacturer_id': Farmerid,
    };
    http.Response response = await http.post(url, body: jsonEncode(body),headers: headers);
    if (response.statusCode == 200) {
      return formrouteModelFromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }}


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


class GarmentInvoiceForbatch extends StatefulWidget {
  const GarmentInvoiceForbatch({super.key});

  @override
  _GarmentInvoiceForbatchState createState() => _GarmentInvoiceForbatchState();
}

class _GarmentInvoiceForbatchState extends State<GarmentInvoiceForbatch> {
  final getstorage = GetStorage();
  Future<FarmerFormListResponce>? fetchdata;
  List<FormData>? data;
  final List<Setting> _settingsNumber = [];
  late Future<SettingResponce> fetchsettingdata;
  final List<CottonVariety> _cottonVeriety = [];
  final List<TypeFertilization> _typeFertilization = [];
  final List<TypePesticides> _typePesticides = [];
  final List<YarQuality> _yarQuality = [];
  TextEditingController expectedYielderrorController = TextEditingController();
  TextEditingController fertilizationamountController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  YarQuality? _selectedYarQuality;

  String expectedYarnGrade = 'Please enter Yarn Grade';
  String Steplelength = 'Please enter Staple length';
  String yarnStrength = 'Please enter Yarn Strength';
  String qualityGining = 'Please enter quality after Ginning';
  TextEditingController expectedYarnGradeController = TextEditingController();
  TextEditingController SteplelengthController = TextEditingController();
  TextEditingController yarnStrengthController = TextEditingController();
  TextEditingController qualityGiningController = TextEditingController();

  String locationValue = 'Please enter your address';

  int userid=0;
  DateTime? selectedDate;
  int ginnerStatus=0;
  int adminStatus=0;


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
                      const Text(
                        "Invoice From Textile Manufacturer",
                        style: TextStyle(
                          fontFamily: 'Poppins_medium',
                          color: Colors.black,
                          fontSize: 14.0,
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


                                            if(data![index].spinnerDetail!=null && data![index].spinnerDetail!="")
                                              ...[
                                                buildTitleValueone('Spinner Details'),
                                                buildTitleValue('Spinner Name', data![index].spinnerDetail!.name!),
                                                buildTitleValue('Spinner Phone Number', data![index].spinnerDetail!.mobileNo!),
                                                buildTitleValue('Spinner Email address', data![index].spinnerDetail!.email!),
                                                buildTitleValue('Profile QR code', ""),
                                                DelayedWebView(url:data![index].spinnerDetail!.profile_qr_code!),
                                              ],

                                            if(data![index].farmerFormTextileForm!=null)
                                              buildTitleValueone('Product Details'),
                                            if(data![index].farmerFormTextileForm!=null)
                                              buildTitleValue('Fabric Method',data![index].farmerFormTextileForm!.fabricMethod!),
                                            if(data![index].farmerFormTextileForm!=null)
                                              buildTitleValue('Fabric Type',data![index].farmerFormTextileForm!.typesFabric!),
                                            if(data![index].farmerFormSpinnerForm!=null)
                                              buildTitleValue('Dyeing Method',data![index].farmerFormTextileForm!.dyeingMethod!),
                                            if(data![index].farmerFormSpinnerForm!=null)
                                              buildTitleValue('Dyeing Chemical',data![index].farmerFormTextileForm!.dyeingChemical!),
                                            if(data![index].farmerFormSpinnerForm!=null)
                                              buildTitleValue('Product quantity ',"${data![index].farmerFormTextileForm!.quantity!}kg"),
                                            if(data![index].farmerFormSpinnerForm!=null)
                                              buildTitleValue('Production Date', convertDate(data![index].farmerFormTextileForm!.fabricProductionDate!)),
                                            if(data![index].farmerFormSpinnerForm!=null)
                                              buildTitleValue('Dying Date', convertDate(data![index].farmerFormTextileForm!.fabricProductionDate!)),
                                            if(data![index].farmerFormSpinnerForm!=null)
                                              buildTitleValue('Unit Price',"${data![index].farmerFormTextileForm!.unitPrice!}/per kg"),



                                            if(data![index].garmentInvoice!=null )
                                              ...[
                                                buildTitleValueone(' Order Details'),
                                                buildTitleValue('Product quantity', data![index].garmentInvoice!.qty!),
                                                buildTitleValue('Product Price per kg', data![index].garmentInvoice!.price!),
                                                buildTitleValue('Product Total Price', data![index].garmentInvoice!.totalPrice!),

                                                if(data![index].garmentInvoice!.textileStatus == 0)
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
                                                            approveform(data![index].garmentInvoice!.farmerFormId!.toString(), "1", data![index].garmentInvoice!.id!.toString());
                                                          },
                                                          child: const Text(
                                                            'Approve Invoice',
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
        // SaveInvoice.fetchRouteData(incomming_cotton_batch_ids, ginner_ids, qty, price, totalprice);

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
    }else if(SteplelengthController.text.trim().isEmpty){
      EasyLoading.showError('Please enter Count');
    }else if(yarnStrengthController.text.trim().isEmpty){
      EasyLoading.showError('Please enter Yarn Strength');
    }else if(qualityGiningController.text.trim().isEmpty){
      EasyLoading.showError('Please enter Quantity After Ginning');
    }else{
      EasyLoading.show(status: 'loading...');
      String selectedDates="${selectedDate?.year}-${selectedDate?.month}-${selectedDate?.day}";
      try {
        var newData = await SaveGinnerData.fetchRouteData(incommingCottonBatchId, ginnerId,name, locationController.text.toString(), selectedDates,
            _selectedYarQuality!.id!.toString(),SteplelengthController.text.toString(),yarnStrengthController.text.toString(),qualityGiningController.text.toString());
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

  static Future<FarmerFormListResponce> fetchRouteData(String farmer_form_id,
      String spinner_id,String name,String location,String date_spinning,String yar_quality_id,String count,String strength,String quantity_yarn_produce) async {
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
      'quantity_yarn_produce': quantity_yarn_produce

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

class ASpproveform {
  static var client = http.Client();

  static Future<FarmerFormListResponce> fetchRouteData(String farmerFormId,String farmerStatus,String ginnerInvoiceId) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.textile_approve_reject_garment_invoice);
    Map body = {
      'farmer_form_id': farmerFormId,
      'textile_status':farmerStatus,
      'garment_invoice_id': ginnerInvoiceId
    };
    http.Response response = await http.post(url, body: jsonEncode(body),headers: headers);
    if (response.statusCode == 200) {
      return formrouteModelFromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }}

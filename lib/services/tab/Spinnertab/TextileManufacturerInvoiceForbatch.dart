import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../Model/FarmerFormListResponce.dart';
import '../../../Model/SettingResponce.dart';
import '../../../Widget/DelayedWebView.dart';
import '../../../Widget/api.dart';
import '../../../profile.dart';

class TextileManufacturerInvoiceForbatch extends StatefulWidget {
  const TextileManufacturerInvoiceForbatch({super.key});

  @override
  _TextileManufacturerInvoiceForbatchState createState() =>
      _TextileManufacturerInvoiceForbatchState();
}

class _TextileManufacturerInvoiceForbatchState
    extends State<TextileManufacturerInvoiceForbatch> {
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

  String expectedYarnGrade = 'Please enter Yarn Grade';
  String Steplelength = 'Please enter Staple length';
  String yarnStrength = 'Please enter Yarn Strength';
  String qualityGining = 'Please enter quality after Ginning';
  TextEditingController expectedYarnGradeController = TextEditingController();
  TextEditingController SteplelengthController = TextEditingController();
  TextEditingController yarnStrengthController = TextEditingController();
  TextEditingController qualityGiningController = TextEditingController();

  String locationValue = 'Please enter your address';
  int userid = 0;
  DateTime? selectedDate;
  int ginnerStatus = 0;
  int adminStatus = 0;

  @override
  void initState() {
    super.initState();
    userid = getstorage.read("id");
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
          if (response.cottonVariety != null) {
            _cottonVeriety.addAll(response.cottonVariety!);
          }
          if (response.typeFertilization != null) {
            _typeFertilization.addAll(response.typeFertilization!);
          }
          if (response.typePesticides != null) {
            _typePesticides.addAll(response.typePesticides!);
          }
          if (response.setting != null) {
            _settingsNumber.addAll(response.setting!);
          }
          if (response.yarQuality != null) {
            _yarQuality.addAll(response.yarQuality!);
          }
        });
      }).catchError((error) {
        EasyLoading.dismiss();
      });
    });
  }

  void fetchData() async {
    var newData = await ChatApiService.fetchRouteData(userid.toString());
    FarmerFormListResponce? manufacturerListResponse =
        await Future.value(newData);

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
        child: Scaffold(
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8.0),
                        child: IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Expanded(
                        // Allows the text to wrap onto the next line
                        child: const Text(
                          'Invoice From Textile Manufacturer',
                          style: TextStyle(
                            fontFamily: 'Poppins_semi',
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                          maxLines: 2, // Limits text to two lines
                          overflow: TextOverflow
                              .ellipsis, // Handles overflow gracefully
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 1.0, 16.0, 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              // Allow ListView to scroll vertically
                              itemCount: data?.length ?? 0,
                              // Use data?.length with null check
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      // Handle the tap event
                                    },
                                    child: Card(
                                      color: Colors.white,
                                      margin: const EdgeInsets.all(15.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            buildTitleValueone('Farmer Detail'),
                                            buildTitleValue(
                                                'Farmer Name',
                                                data![index]
                                                    .farmerDetail!
                                                    .name!),
                                            buildTitleValue(
                                                'Farmer Mobile Number',
                                                data![index]
                                                    .farmerDetail!
                                                    .mobileNo!),
                                            buildTitleValue(
                                                'Farmer Email address',
                                                data![index]
                                                    .farmerDetail!
                                                    .email!),
                                            buildTitleValue(
                                                'Profile QR code', ""),
                                            DelayedWebView(
                                                url: data![index]
                                                    .farmerDetail!
                                                    .profile_qr_code!),
                                            if (data![index].ginnerDetail !=
                                                null)
                                              buildTitleValueone(
                                                  'Ginner Detail'),
                                            buildTitleValue(
                                                'Ginner Name',
                                                data![index]
                                                    .ginnerDetail!
                                                    .name!),
                                            buildTitleValue(
                                                'Ginner Mobile Number',
                                                data![index]
                                                    .ginnerDetail!
                                                    .mobileNo!),
                                            buildTitleValue(
                                                'Ginner Email address',
                                                data![index]
                                                    .ginnerDetail!
                                                    .email!),
                                            DelayedWebView(
                                                url: data![index]
                                                    .ginnerDetail!
                                                    .profile_qr_code!),
                                            if (data![index].spinnerDetail !=
                                                    null &&
                                                data![index].spinnerDetail !=
                                                    "") ...[
                                              buildTitleValueone(
                                                  'Spinner Details'),
                                              buildTitleValue(
                                                  'Spinner Name',
                                                  data![index]
                                                      .spinnerDetail!
                                                      .name!),
                                              buildTitleValue(
                                                  'Spinner Phone Number',
                                                  data![index]
                                                      .spinnerDetail!
                                                      .mobileNo!),
                                              buildTitleValue(
                                                  'Spinner Email address',
                                                  data![index]
                                                      .spinnerDetail!
                                                      .email!),
                                              buildTitleValue(
                                                  'Profile QR code', ""),
                                              DelayedWebView(
                                                  url: data![index]
                                                      .spinnerDetail!
                                                      .profile_qr_code!),
                                            ],
                                            if (data![index]
                                                    .farmerFormSpinnerForm !=
                                                null)
                                              buildTitleValueone(
                                                  'Product Details'),
                                            if (data![index]
                                                    .farmerFormSpinnerForm !=
                                                null)
                                              buildTitleValue(
                                                  'Location',
                                                  data![index]
                                                      .farmerFormSpinnerForm!
                                                      .location!),
                                            if (data![index]
                                                    .farmerFormSpinnerForm !=
                                                null)
                                              buildTitleValue(
                                                  'Product Quality',
                                                  data![index]
                                                      .farmerFormSpinnerForm!
                                                      .yarQualityId!),
                                            if (data![index]
                                                    .farmerFormSpinnerForm !=
                                                null)
                                              buildTitleValue(
                                                  'Product Count',
                                                  data![index]
                                                      .farmerFormSpinnerForm!
                                                      .count!),
                                            if (data![index]
                                                    .farmerFormSpinnerForm !=
                                                null)
                                              buildTitleValue(
                                                  'Product strength',
                                                  data![index]
                                                      .farmerFormSpinnerForm!
                                                      .strength!),
                                            if (data![index]
                                                    .farmerFormSpinnerForm !=
                                                null)
                                              buildTitleValue(
                                                  'Product quantity after ginning',
                                                  "${data![index].farmerFormSpinnerForm!.quantityYarnProduce!}kg"),
                                            if (data![index].farmerFormSpinnerForm != null)
                                              buildTitleValue(
                                                  'Spinning Date',
                                                  convertDate(data![index]
                                                      .farmerFormSpinnerForm!
                                                      .dateSpinning!)),
                                            if (data![index]
                                                    .farmerFormSpinnerForm !=
                                                null)
                                              buildTitleValue(
                                                  'Spinning Date',data![index]
                                                      .farmerFormSpinnerForm!
                                                      .unitPrice!),
                                            if (data![index].textileInvoice != null) ...[
                                              buildTitleValueone('Product Order Details'),
                                              buildTitleValue('Product quantity', data![index].textileInvoice!.qty!),
                                              buildTitleValue(
                                                  'Product Price per kg', data![index].textileInvoice!.price!),
                                              buildTitleValue('Product Total Price', data![index].textileInvoice!.totalPrice!),
                                              if (data![index].textileInvoice != null)
                                              if (data![index].textileInvoice!.spinnerStatus == 0)
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 400.0,
                                                      height: 60.0,
                                                      decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      child: TextButton(
                                                        onPressed: () {
                                                          approveform(
                                                              data![index]
                                                                  .textileInvoice!
                                                                  .farmerFormId!
                                                                  .toString(),
                                                              "1",
                                                              data![index]
                                                                  .textileInvoice!
                                                                  .id!
                                                                  .toString());
                                                        },
                                                        child: const Text(
                                                          'Approve Invoice',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14.0,
                                                            fontFamily:
                                                                'Reguler',
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
                                    ));
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

  void approveform(
      String farmerFormId, String ginnerStatus, String spinnerInvoiceId) async {
    var newData = await ASpproveform.fetchRouteData(
        farmerFormId, ginnerStatus, spinnerInvoiceId);
    FarmerFormListResponce? manufacturerListResponse = await Future.value(newData);
    if (manufacturerListResponse?.errorCode == "0") {
      EasyLoading.show(status: 'loading...');
      fetchData();
    } else {
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
              color: Color(0xFF6EDB7B),
              fontSize: 16.0,
              fontFamily: 'Poppins_medium',
            ),
          ),
          const SizedBox(height: 4.0),
        ],
      ),
    );
  }
}

class ChatApiService {
  static var client = http.Client();

  static Future<FarmerFormListResponce> fetchRouteData(String Farmerid) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(ApiEndPoints.baseUrl +
        ApiEndPoints.authEndpoints.spinner_ginner_invoice);
    Map body = {
      'spinner_id': Farmerid,
    };
    http.Response response =
        await http.post(url, body: jsonEncode(body), headers: headers);
    if (response.statusCode == 200) {
      return formrouteModelFromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }
}

class ASpproveform {
  static var client = http.Client();

  static Future<FarmerFormListResponce> fetchRouteData(
      String farmerFormId, String farmerStatus, String ginnerInvoiceId) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(ApiEndPoints.baseUrl +
        ApiEndPoints.authEndpoints.spinner_approve_reject_textile_invoice);
    Map body = {
      'farmer_form_id': farmerFormId,
      'spinner_status': farmerStatus,
      'textile_invoice_id': ginnerInvoiceId
    };
    http.Response response =
        await http.post(url, body: jsonEncode(body), headers: headers);
    if (response.statusCode == 200) {
      return formrouteModelFromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }
}

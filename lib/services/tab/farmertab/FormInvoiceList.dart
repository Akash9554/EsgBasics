import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
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

class FormInvoiceList extends StatefulWidget {
  const FormInvoiceList({super.key});

  @override
  _FormInvoiceListState createState() => _FormInvoiceListState();
}

class _FormInvoiceListState extends State<FormInvoiceList> {
  final getstorage = GetStorage();
  Future<FarmerFormListResponce>? fetchdata;
  List<FormData>? data;
  final List<Setting> _settingsNumber = [];

  late Future<SettingResponce> fetchsettingdata;
  final List<CottonVariety> _cottonVeriety = [];

  final List<TypeFertilization> _typeFertilization = [];
  final List<TypePesticides> _typePesticides = [];

  int userid = 0;

  @override
  void initState() {
    super.initState();
    FlutterDownloader.registerCallback(downloadCallback);
    userid = getstorage.read("id");
    getsetting(userid.toString());
    fetchData();
  }

  static void downloadCallback(String id, int status, int progress) {
    if (status == DownloadTaskStatus.complete) {
      print('Download complete: $id');
      // Use a local notification or another method to notify the user
    }
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
        });
      }).catchError((error) {
        EasyLoading.dismiss();
        print("Error fetching data: $error");
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

  void approveform(
      String farmerFormId, String farmerStatus, String ginnerInvoiceId) async {
    var newData = await ASpproveform.fetchRouteData(
        farmerFormId, farmerStatus, ginnerInvoiceId);
    FarmerFormListResponce? manufacturerListResponse =
        await Future.value(newData);
    if (manufacturerListResponse?.errorCode == "0") {
      EasyLoading.show(status: 'loading...');
      fetchData();
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError('Failed Something is Wrong !');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const Text(
                    "Farmer Invoice List",
                    style: TextStyle(
                      fontFamily: 'Poppins_sego',
                      color: Colors.black,
                      fontSize: 20.0,
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
                          physics: const NeverScrollableScrollPhysics(),
                          // Disable ListView scrolling
                          itemCount: data?.length ?? 0,
                          // Use data?.length with null check
                          itemBuilder: (context, index) {
                            if (data![index].ginnerInvoice == null) {
                              return const SizedBox.shrink();
                            }
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      buildTitleValue(
                                          'Planting Date',
                                          convertDate(
                                              data![index].plantingDate!)),
                                      buildTitleValue(
                                          'Cotton Variety',
                                          getCottonVarietyName(
                                              data![index].cottonVarietyId!)),
                                      buildTitleValue('Expected Yield',
                                          data![index].expectedYield!),
                                      buildTitleValue(
                                          'Fertilization Type',
                                          getFertilizationtype(data![index]
                                              .typeFertilizationId!)),
                                      buildTitleValue('Fertilization Amount',
                                          data![index].fertilizationAmount!),
                                      buildTitleValue('Irrigation Amount',
                                          data![index].wateringSchedules!),
                                      if (data![index].rainFedOnly == "1")
                                        buildTitleValue('Rain Fed Only', "Yes"),
                                      buildTitleValue(
                                          'Pesticides Type',
                                          getPesticidesName(
                                              data![index].typePesticidesId!)),
                                      if (data![index].pesticidesAmount != null)
                                        buildTitleValue('Pesticides Amount',
                                            data![index].pesticidesAmount!),
                                      buildTitleValue('Harvesting Value',
                                          data![index].harvesting!),
                                      if (data![index].location != null)
                                        buildTitleValue(
                                            'Location', data![index].location!),
                                      if (data![index].video!.isNotEmpty)
                                        buildTitleValueone('Video'),


                                      if (data![index].video!.isNotEmpty)
                                        VideoPlayerWidget(
                                            url: data![index].video!),
                                      buildTitleValue('Profile QR code', ""),

                                      DelayedWebView(url:data![index].farmerDetail!.profile_qr_code!),

                                      buildTitleValue('Video List QR code', ""),
                                      DelayedWebView(url:data![index].farmerDetail!.qrCode!),

                                      buildTitleValue('Status',
                                          getstatus(data![index].status!)),
                                      if (data![index].status == 2)
                                        buildTitleValue('Reply for rejection',
                                            data![index].reply!),
                                      const SizedBox(height: 10.0),
                                      if (data![index].status == 0)
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 400.0,
                                              height: 70.0,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                              ),
                                              child: TextButton(
                                                onPressed: () {
                                                  // save_form(context);
                                                },
                                                child: const Text(
                                                  'Delete Form',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0,
                                                    fontFamily: 'Poppins_sego',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      buildTitleValueone('Ginner Details'),
                                      buildTitleValue('Ginner Name',
                                          data![index].ginnerDetail!.name!),
                                      buildTitleValue('Ginner Phone Number',
                                          data![index].ginnerDetail!.mobileNo!),
                                      buildTitleValue('Ginner Email address',
                                          data![index].ginnerDetail!.email!),
                                      buildTitleValue('Profile QR code', ""),
                                      DelayedWebView(url:data![index].ginnerDetail!.profile_qr_code!),

                                      buildTitleValueone(
                                          'Cotton Order Details'),
                                      buildTitleValue('Cotton quantity',
                                          data![index].ginnerInvoice!.qty!),
                                      buildTitleValue('Cotton Price per kg',
                                          data![index].ginnerInvoice!.price!),
                                      buildTitleValue('Cotton Total Price', data![index]
                                              .ginnerInvoice!
                                              .totalPrice!),
                                      SizedBox(height: 20),
                                      if (data![index].ginnerInvoice!.farmerStatus == 0)
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
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: TextButton(
                                                onPressed: () {
                                                  approveform(
                                                      data![index]
                                                          .id!
                                                          .toString(),
                                                      "1",
                                                      data![index]
                                                          .ginnerInvoice!
                                                          .id!
                                                          .toString());
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
                                  ),
                                ),
                              ),
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

  String convertDate(String dateStr) {
    List<String> parts = dateStr.split('-');
    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int day = int.parse(parts[2]);
    DateTime parsedDate = DateTime(year, month, day);
    String formattedDate = DateFormat('dd MMMM yyyy').format(parsedDate);
    return formattedDate;
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
    } else if (id == 2) {
      return "Rejected";
    }
    return 'Approved';
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

class ChatApiService {
  static var client = http.Client();

  static Future<FarmerFormListResponce> fetchRouteData(String Farmerid) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.farmer_form_list);
    Map body = {
      'farmer_id': Farmerid,
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
        ApiEndPoints.authEndpoints.farmer_form_approve_reject);
    Map body = {
      'farmer_form_id': farmerFormId,
      'farmer_status': farmerStatus,
      'ginner_invoice_id': ginnerInvoiceId
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

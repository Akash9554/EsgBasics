import 'dart:convert';

import 'package:esgbasics/profile.dart';
import 'package:esgbasics/services/tab/farmertab/EditFormPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'Model/FarmerFormListResponce.dart';
import 'Model/SettingResponce.dart';
import 'Widget/api.dart';
// Import for iOS/macOS features.

import 'dart:typed_data';

class PreviousFormList extends StatefulWidget {
  const PreviousFormList({super.key});

  @override
  _PreviousFormListState createState() => _PreviousFormListState();
}

class _PreviousFormListState extends State<PreviousFormList> {
  final getstorage = GetStorage();
  Future<FarmerFormListResponce>? fetchdata;
  List<FormData>? data;
  late final WebViewController _controllers;

  final List<Setting> _settingsNumber = [];
  late Future<SettingResponce> fetchsettingdata;
  final List<CottonVariety> _cottonVeriety = [];

  final List<TypeFertilization> _typeFertilization = [];
  final List<TypePesticides> _typePesticides = [];

  late VideoPlayerController _controller;
  final bool _isPlaying = false;
  int userid=0;

  @override
  void initState() {
    super.initState();
    userid=getstorage.read("id");
    getsetting(userid.toString());
    fetchData();
  }

  void _refreshPage() {
    setState(() {});
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
      EasyLoading.dismiss();
    });
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
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const Text(
                    "Previous Ordered List",
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
                                      buildTitleValue('Planting Date', convertDate(data![index].plantingDate!)),
                                      buildTitleValue('Cotton Variety', getCottonVarietyName(data![index].cottonVarietyId!)),
                                      buildTitleValue('Expected Yield', data![index].expectedYield!),
                                      buildTitleValue('Fertilization Type', getFertilizationtype(data![index].typeFertilizationId!)),
                                      buildTitleValue('Fertilization Amount', data![index].fertilizationAmount!),
                                      buildTitleValue('Irrigation Amount', data![index].wateringSchedules!),
                                      if(data![index].rainFedOnly=="1")
                                        buildTitleValue('Rain Fed Only', "Yes"),

                                      buildTitleValue('Pesticides Type', getPesticidesName(data![index].typePesticidesId!)),
                                      if(data![index].pesticidesAmount!=null)
                                      buildTitleValue('Pesticides Amount', data![index].pesticidesAmount!),
                                      buildTitleValue('Harvesting Value', data![index].harvesting!),
                                      if(data![index].location != null)
                                      buildTitleValue('Location', data![index].location??""),
                                      buildTitleValue('Unit Price', data![index].unitPrice??""),
                                      if(data![index].video !="")
                                      buildTitleValue('Video', ""),
                                      if(data![index].video !="")
                                      VideoPlayerWidget(url: data![index].video!),
                                      buildTitleValue('Status', getstatus(data![index].status!)),
                                      _buildWebView('Profile QR Code', data![index].farmerDetail!.profile_qr_code!),
                                      _buildWebView('Video List QR Code', data![index].farmerDetail!.qrCode!),
                                      if(data![index].status==2)
                                      buildTitleValue('Reply for rejection', data![index].reply!),
                                      const SizedBox(height: 10.0),
                                      if(data![index].status==0)
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
                                                  delete_form(data![index].id!.toString());
                                                },
                                                child: const Text(
                                                  'Delete Form',
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
                                      const SizedBox(height: 20.0),
                                      if(data![index].status!=0)
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
                                              onPressed: () async {
                                                final result = await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => EditFormPage(
                                                        farmer_id:data![index].id.toString(),
                                                        planting_date:data![index].plantingDate!,
                                                        cotton_variety_id:data![index].cottonVarietyId.toString(),
                                                        expected_yield: data![index].expectedYield!.toString(),
                                                        type_fertilization_id:data![index].typeFertilizationId!.toString(),
                                                        fertilization_amount:data![index].fertilizationAmount!,
                                                        watering_schedules:  data![index].wateringSchedules!,
                                                        pesticides_amount: data![index].pesticidesAmount!,type_pesticides_id:data![index].typePesticidesId!.toString(),
                                                        harvesting:data![index].harvesting!,
                                                        video:data![index].video??"",
                                                        rain_fed_only:data![index].rainFedOnly?? "",
                                                        location :  data![index].location??"",
                                                        unit:data![index].unitPrice??""),
                                                  ),
                                                );
                                                // If there's a result, refresh the page
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
    );
  }
  Widget _buildWebView(String title, String url) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitleValue(title, ""),
        SizedBox(
          width: 100,
          height: 100,
          child: WebViewItem(url: url),
        ),
      ],
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
  String convertDate(String dateStr) {
    List<String> parts = dateStr.split('-');
    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int day = int.parse(parts[2]);

    // Create a DateTime object
    DateTime parsedDate = DateTime(year, month, day);

    // Format the date
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
    }else if(id==2){
        return "Rejected";
      }
    return 'Approved';
  }
  void delete_form(String farmerFormId) async {
    EasyLoading.show(status: 'loading...');
    var newData = await ASpproveform.fetchRouteData(farmerFormId);
    FarmerFormListResponce? manufacturerListResponse = await Future.value(newData);
    if (manufacturerListResponse?.errorCode == "0") {
      fetchData();
    }else{
      EasyLoading.dismiss();
      EasyLoading.showError('Failed Something is Wrong !');
    }
  }

}

class WebViewItem extends StatefulWidget {
  final String url;

  const WebViewItem({Key? key, required this.url}) : super(key: key);

  @override
  _WebViewItemState createState() => _WebViewItemState();
}

class _WebViewItemState extends State<WebViewItem> {
  bool isLoading = true;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the WebViewController
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..loadRequest(Uri.parse(widget.url));

    // Introduce a delay (if needed) before marking as not loading
    Future.delayed(const Duration(seconds: 10)).then((_) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        children: [
          if (!isLoading)
            WebViewWidget(
              controller: _controller,
            ), // Display WebView only when not loading
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}



class ASpproveform {
  static var client = http.Client();

  static Future<FarmerFormListResponce> fetchRouteData(String farmerFormId) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.farmer_form_delete);
    Map body = {
      'farmer_form_id': farmerFormId,
    };
    http.Response response = await http.post(url, body: jsonEncode(body),headers: headers);
    if (response.statusCode == 200) {
      return formrouteModelFromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }}

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
    var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.farmer_form_list);
    Map body = {
      'farmer_id': Farmerid,
    };
    http.Response response = await http.post(url, body: jsonEncode(body),headers: headers);
    if (response.statusCode == 200) {
      return formrouteModelFromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }}

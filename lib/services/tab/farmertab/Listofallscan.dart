
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;


import '../../../Model/FarmerFormListResponce.dart';
import '../../../PreviousFormList.dart';



class Listofallscan extends StatefulWidget {
  const Listofallscan({super.key});
  @override
  State<Listofallscan> createState() => _ListofallscanState();
}
class _ListofallscanState extends State<Listofallscan> {
  final getstorage = GetStorage();
  int userid=0;
  int edit_id=0;
  Future<FarmerFormListResponce>? fetchdata;
  List<FormData>? data;

  @override
  void initState() {
    super.initState();
    userid=getstorage.read("id");
    fetchData();
  }
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
      backgroundColor: Colors.transparent,
        body: Container(
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
    child: Center(
        child: Column(
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
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Text(
                'Scanner List',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontFamily: 'Poppins_sego'
                ),
              ),
            ),

            Expanded(
              child: Container(
                color: Colors.transparent, // Set background color to transparent
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(
                    // Filter items before generating the list
                    data?.where((item) => item.ginnerId != null ).length ?? 0,
                        (index) {
                      // Get the filtered item list
                      var filteredData = data?.where((item) => item.ginnerId != null ).toList() ?? [];

                      return GestureDetector(
                        onTap: () {
                          // Handle tap event (if needed for the card itself)
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
                                if (filteredData[index].ginnerId != null)
                                  Container(
                                    margin: const EdgeInsets.all(2),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 80,
                                          width: double.infinity,
                                          color: Colors.white, // Placeholder color
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                // Show dialog when the image is clicked
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return Dialog(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(10.0),
                                                      ),
                                                      child: Container(
                                                        width: 300,
                                                        height: 200,
                                                        padding: const EdgeInsets.all(10.0),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              'Open Link',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                            SizedBox(height: 20),
                                                            ElevatedButton(
                                                              onPressed: () async {
                                                                final url = Uri.parse(filteredData[index].unitPrice!);
                                                                if (await canLaunchUrl(url)) {
                                                                  await launchUrl(url);
                                                                } else {
                                                                  throw 'Could not launch $url';
                                                                }
                                                              },
                                                              child: Text('Open in Browser'),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Image.network(
                                                filteredData[index].unitPrice!, // Display image using filtered data
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) {
                                                  return Icon(Icons.error); // Placeholder if image fails to load
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    ));
  }
}




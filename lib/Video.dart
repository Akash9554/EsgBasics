import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';

import 'AddNewVideo.dart';
import 'Listofallvideo.dart';
import 'Model/FarmerFormListResponce.dart';
import 'PreviousFormList.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  _VideoPageState createState() => _VideoPageState();
}



class _VideoPageState extends State<VideoPage> {
  final getstorage = GetStorage();
  int userid=0;
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
              Color(0xFFFFFFFF), // Green
              Color(0xFF79DD8B), // Light green
              Color(0xFFCBFF6B), // Yellow-green
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Image.asset(
                  'assets/images/splogo.png', // Replace with your image asset path
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 20),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const VideoList()),
                            );

                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20), backgroundColor: Colors.black,
                          ),
                          child: const Text(
                            'Listing All Previous',
                            style: TextStyle(
                              fontFamily: 'Poppins_semi',
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const AddNewVideo()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20), backgroundColor: Colors.black,
                          ),
                          child: const Text(
                            'Add New Video',
                            style: TextStyle(
                              fontFamily: 'Poppins_semi',
                              color: Colors.white,
                              fontSize: 16.0,
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
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;

  const CustomButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20), backgroundColor: Colors.black,
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
  }
}

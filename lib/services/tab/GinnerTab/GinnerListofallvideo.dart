import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import '../../../Model/FarmerFormListResponce.dart';
import '../../../PreviousFormList.dart';


class GinnerVideoList extends StatefulWidget {
  const GinnerVideoList({super.key});
  @override
  State<GinnerVideoList> createState() => _GinnerVideoListState();
}
class _GinnerVideoListState extends State<GinnerVideoList> {
  final getstorage = GetStorage();
  int userid=0;
  int usertype=0;
  Future<FarmerFormListResponce>? fetchdata;
  List<FormData>? data;

  @override
  void initState() {
    super.initState();
    userid=getstorage.read("id");
    usertype=getstorage.read("user_type");
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
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text(
                    'Video List',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Poppins_sego'
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: List.generate(
                        data?.where((item) => item.video != null && item.video!.isNotEmpty).length ?? 0, // Filter items with non-empty video
                            (index) {
                          final filteredData = data!.where((item) => item.video != null && item.video!.isNotEmpty).toList();

                          return GestureDetector(
                            onTap: () {},
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
                                    Container(
                                      margin: const EdgeInsets.all(2),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 80,
                                            width: double.infinity,
                                            color: Colors.white,
                                            child: Center(
                                              child: VideoPlayerWidget(url: filteredData[index].video!),
                                            ),
                                          ),
                                          Container(
                                            color: Colors.transparent,
                                            child: Padding(
                                              padding: const EdgeInsets.all(1.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        _showVideoDialog(context, filteredData[index].video!);
                                                      },
                                                      child: Image.asset(
                                                        'assets/images/play.png',
                                                        width: 30,
                                                        height: 30,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
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

void _showVideoDialog(BuildContext context, String videoUrl) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: VideoPlayerWidget(url: videoUrl),
      );
    },
  );
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
  bool _isBuffering = true;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {
          _isBuffering = false;
          _controller.play();
          _isPlaying = true;
        });
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
    return _isPlaying && _controller.value.isInitialized
        ? Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
        if (_isBuffering)
          const CircularProgressIndicator(),
        Align(
          alignment: Alignment.bottomCenter,
          child: IconButton(
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
        ),
      ],
    ) : const Center(child: CircularProgressIndicator());
  }
}

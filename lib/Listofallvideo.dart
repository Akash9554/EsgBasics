
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'Model/FarmerFormListResponce.dart';
import 'PreviousFormList.dart';

class VideoList extends StatefulWidget {
  const VideoList({super.key});

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  final getstorage = GetStorage();
  late int userid;
  List<FormData>? data;
  final ImagePicker _picker = ImagePicker();
  XFile? _video;
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    userid = getstorage.read("id") ?? 0;
    fetchData();
  }

  void fetchData() async {
    EasyLoading.show(status: 'Loading...');
    try {
      var newData = await ChatApiService.fetchRouteData(userid.toString());
      setState(() {
        data = newData?.data;
      });
    } catch (e) {
      EasyLoading.showError("Failed to fetch data");
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> _pickVideo(int editId, int farmerId) async {
    final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _video = pickedFile);
      _uploadVideo(editId, farmerId);
    }
  }

  Future<void> _uploadVideo(int editId, int farmerId) async {
    if (_video == null) return;
    EasyLoading.show(status: 'Uploading...');
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://ellatangenterprises.com/demoo/esg/api/farmer_form_create'),
      );
      request.files.add(await http.MultipartFile.fromPath('video', _video!.path));
      request.fields['edit_id'] = editId.toString();
      request.fields['farmer_id'] = farmerId.toString();

      var response = await request.send();
      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Video uploaded successfully!');
        fetchData();
      } else {
        EasyLoading.showError('Video upload failed');
      }
    } catch (e) {
      EasyLoading.showError('Error uploading video');
    } finally {
      EasyLoading.dismiss();
    }
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
            colors: [Color(0xFF6EDB7B), Color(0xFFCBFF6B)],
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text(
                'Video List',
                style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'Poppins_sego'),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: [
                          data![index].video != null && data![index].video!.isNotEmpty
                              ? VideoPlayerWidget(url: data![index].video!)
                              : Image.asset('assets/images/video.png', width: 80, height: 80),
                          TextButton(
                            onPressed: () => _pickVideo(data![index].id!, data![index].farmerId!),
                            child: Text(data![index].video != null ? 'Edit Video' : 'Add Video'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() => _isInitialized = true);
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isInitialized
        ? AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: Stack(
        alignment: Alignment.center,
        children: [
          VideoPlayer(_controller),
          IconButton(
            icon: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow, size: 40, color: Colors.white),
            onPressed: () => setState(() => _controller.value.isPlaying ? _controller.pause() : _controller.play()),
          ),
        ],
      ),
    )
        : const Center(child: CircularProgressIndicator());
  }
}

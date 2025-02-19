import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DelayedWebView extends StatefulWidget {
  final String url;

  const DelayedWebView({Key? key, required this.url}) : super(key: key);

  @override
  _DelayedWebViewState createState() => _DelayedWebViewState();
}

class _DelayedWebViewState extends State<DelayedWebView> {
  bool isLoading = true;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..loadRequest(Uri.parse(widget.url)); // Load the initial URL
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
            ), // Use WebViewWidget with the controller
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

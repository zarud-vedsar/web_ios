import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const WebViewDemo(),
    );
  }
}

class WebViewDemo extends StatefulWidget {
  const WebViewDemo({super.key});

  @override
  State<WebViewDemo> createState() => _WebViewDemoState();
}

class _WebViewDemoState extends State<WebViewDemo> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();

    // Initialize WebViewController
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            // Handle progress
            print("Loading: $progress%");
          },
          onPageStarted: (url) {
            // Handle when the page starts loading
            print("Page started loading: $url");
          },
          onPageFinished: (url) {
            // Handle when the page finishes loading
            print("Page finished loading: $url");
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.vedhrmssoft.xyz/admin'));
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      await Permission.camera.request();
    } else if (status.isPermanentlyDenied) {
      // The user has denied the permission permanently; you can show a dialog to guide them to settings
      openAppSettings(); // Opens the app settings where they can enable the permission
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0, // Set height of AppBar (default is 56)
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}

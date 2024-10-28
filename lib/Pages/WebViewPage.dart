import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({super.key, required this.url});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;
  String _currentUrl = 'Carregando...';

  @override
  void initState() {
    super.initState();

    final PlatformWebViewControllerCreationParams params =
        const PlatformWebViewControllerCreationParams();
    if (WebViewPlatform.instance == null) {
      WebViewPlatform.instance = AndroidWebViewPlatform();
    }

    _controller = WebViewController.fromPlatformCreationParams(params);

    _controller
      ..loadRequest(Uri.parse(widget.url))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);

    _updateTitle();
  }

  Future<void> _updateTitle() async {
    String? url = await _controller.currentUrl();
    if (url != null) {
      setState(() {
        _currentUrl = url; // Atualiza o título
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        flexibleSpace: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 16.0), // Ajuste de margem superior
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'DetranApp',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  _currentUrl,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}

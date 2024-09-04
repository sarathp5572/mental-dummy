import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HelpScreen extends StatefulWidget {
  final String url;

  const HelpScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final WebViewController _controller = WebViewController();

  @override
  void initState() {
    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(widget.url),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              WebViewWidget(
                controller: _controller,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

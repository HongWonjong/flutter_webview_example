import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NaverWebView(),
    );
  }
}

class NaverWebView extends StatefulWidget {
  @override
  _NaverWebViewState createState() => _NaverWebViewState();
}

class _NaverWebViewState extends State<NaverWebView> {
  InAppWebViewController? _webViewController;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Naver WebView"),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri("https://www.naver.com")),
            initialSettings: InAppWebViewSettings(
              // 안드로이드와 iOS에서 하드웨어 키보드 지원
            ),
            onWebViewCreated: (controller) {
              _webViewController = controller;
            },
            onLoadStart: (controller, url) {
              setState(() {
                isLoading = true;
              });
            },
            onLoadStop: (controller, url) {
              setState(() {
                isLoading = false;
              });
            },
            onConsoleMessage: (controller, consoleMessage) {
              print("Naver Console: ${consoleMessage.message}");
            },
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _webViewController?.reload();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  @override
  void dispose() {
    // 캐시와 쿠키 정리 (선택적)
    _webViewController?.clearCache();
    CookieManager.instance().deleteAllCookies();
    super.dispose();
  }
}
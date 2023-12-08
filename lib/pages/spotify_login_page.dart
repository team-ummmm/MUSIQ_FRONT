import 'dart:io';

import 'package:flutter/material.dart';

import 'package:musiq_front/pages/root_page.dart';
import 'package:musiq_front/services/login_api_service.dart';
import 'package:musiq_front/style.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SpotifyLoginPage extends StatefulWidget {
  final spotifyLoginUri;
  const SpotifyLoginPage({super.key, this.spotifyLoginUri});

  @override
  _SpotifyLoginPageState createState() => _SpotifyLoginPageState();
}

class _SpotifyLoginPageState extends State<SpotifyLoginPage> {
  bool isLoggingIn = false;
  bool isLoggedIn = false;
  late final controller;
  final _cookieManager = WebViewCookieManager();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColor.backgroudColor)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {
            setState(() {
              isLoggingIn = false; // 웹 페이지 로딩 시작 시 로딩 인디케이터 비활성화
            });
          },
          onPageFinished: (String url) {
            isLoggedIn = false;
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            if (request.url.startsWith(LoginApiService.redirectUri)) {
              print('ok?');
              final Uri uri = Uri.parse(request.url);
              final String? code = uri.queryParameters['code'];
              print(code!);
              setState(() {
                isLoggingIn = true; // 로딩 인디케이터 활성화
              });
              print('okay~~?');
              try {
                isLoggedIn = await LoginApiService.postLogin(code);
                if (isLoggedIn) {
                  print('ok!!');
                  _cookieManager.clearCookies(); // 로그아웃 시 쿠키 지우기
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const RootPage()));
                } else {
                  // TODO: 에러 띄우기 추가
                  print('something wrong!');
                }
              } catch (e) {
                print(e);
              }
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.spotifyLoginUri));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroudColor,
      body: SafeArea(
        child: WebViewWidget(
          key: UniqueKey(),
          controller: controller,
        ),
      ),
    );
  }
}

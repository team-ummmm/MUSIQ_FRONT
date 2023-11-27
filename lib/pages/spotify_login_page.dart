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
  late final controller;

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
            print(isLoggingIn);
          },
          onPageFinished: (String url) {},
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
                bool isLoggedIn = await LoginApiService.postLogin(code);
                if (isLoggedIn) {
                  print('ok!!');
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const RootPage(),
                  ));
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
    // return Scaffold(
    //   appBar: PreferredSize(
    //     preferredSize: const Size.fromHeight(40.0),
    //     child: AppBar(
    //       backgroundColor: AppColor.backgroudColor,
    //     ),
    //   ),
    //   backgroundColor: AppColor.backgroudColor,
    //   body: isLoggingIn
    //       ? const Center(child: CircularProgressIndicator()) // 로딩 인디케이터만 표시
    //       : WebViewWidget(
    //           // 로딩 상태가 아닐 때만 웹뷰 표시
    //           controller: controller,
    //         ),
    // );
    return Scaffold(
      backgroundColor: AppColor.backgroudColor,
      body: SafeArea(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}

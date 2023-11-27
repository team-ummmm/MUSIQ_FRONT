import 'package:flutter/material.dart';
import 'package:musiq_front/pages/spotify_login_page.dart';
import 'package:musiq_front/services/login_api_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 10,
            right: 0,
            top: 260,
            child: Container(
              height: 70,
              width: 70,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/musiq_logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 400,
            child: Column(children: [
              const Text(
                '음악으로 대답해요!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'AppleSDGothicNeo',
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '다양한 질문에 대해 생각하고 고민하며',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'AppleSDGothicNeo',
                  fontSize: 18,
                  color: Colors.grey.withOpacity(0.7),
                ),
              ),
              Text(
                '음악을 다채롭게 즐겨보아요 :)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'AppleSDGothicNeo',
                  fontSize: 18,
                  color: Colors.grey.withOpacity(0.7),
                ),
              ),
            ]),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 600,
            child: Center(
                child: GestureDetector(
              onTap: () async {
                String spotifyLoginUri = await LoginApiService.getSpotifyLoginUrl();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SpotifyLoginPage(spotifyLoginUri: spotifyLoginUri)));
              },
              child: Container(
                height: 50,
                width: 320,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.black),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/spotify_logo.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Spotify로 시작하기',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'AppleSDGothicNeo',
                        fontSize: 17,
                      ),
                    )
                  ],
                ),
              ),
            )),
          )
        ],
      ),
    );
  }
}

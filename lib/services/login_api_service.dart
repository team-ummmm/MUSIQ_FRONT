import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LoginApiService {
  static const String baseUrl = 'http://musiq-api.ap-northeast-2.elasticbeanstalk.com';
  static const String redirectUri = 'http://musiq-api.ap-northeast-2.elasticbeanstalk.com/auth/callback';

  // GET: 리다이렉트 URI를 포함하여 스포티파이로 로그인할 수 있는 링크 받기
  static Future<String> getSpotifyLoginUrl() async {
    final url = Uri.parse("$baseUrl/auth/spotify-login?redirect_uri=$redirectUri");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      String uri = jsonDecode(response.body)['uri'];
      print(uri);
      return uri;
    }
    throw Error();
  }

  // POST: 유저 회원가입 혹은 로그인
  static Future<bool> postLogin(String code) async {
    final url = Uri.parse("$baseUrl/auth/code-login?code=$code&redirect_uri=$redirectUri");
    final response = await http.post(url);
    const storage = FlutterSecureStorage();

    if (response.statusCode == 200) {
      dynamic userInfo = await storage.read(key: 'login');
      if (userInfo != null) {
        await storage.delete(key: 'login');
      }

      int userId = jsonDecode(response.body)['user_id'];
      print(userId);
      String token = jsonDecode(response.body)['token'];
      print(token);

      var loginValue = jsonEncode({"token": token, "user_id": userId});
      await storage.write(key: 'login', value: loginValue);
      print('token updated');

      return true;
    }
    throw Error();
  }
}

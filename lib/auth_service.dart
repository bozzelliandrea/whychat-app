import 'dart:convert';

import 'package:chat_app/config.dart';
import 'package:http/http.dart' as http;
import 'package:whychat/whychat.dart';

class AuthService {
  Future<http.Response> register(
      String username, String email, String password) {
    Auth request = Auth(username, email, password);

    return http.post(Uri.parse('${Config.serverUri}/auth/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(request.toJson()));
  }

  Future<http.Response> login(String email, String password) {
    Auth request = Auth.login(email, password);

    return http.post(Uri.parse('${Config.serverUri}/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(request.toJson()));
  }

  Future<http.Response> logout() {
    return http.post(Uri.parse('${Config.serverUri}/auth/logout'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
  }
}

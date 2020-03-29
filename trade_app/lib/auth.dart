import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

const String authEndpoint = "https://api.tdameritrade.com/v1/oauth2/token";

class Auth with ChangeNotifier {
  String _accesstoken;
  String _grantToken;
  String api = 'JOTXQXFAHOSGC3CGXJMV71GTAWF3EFJR';

  Auth(this._grantToken);

  void initState(){

    postAuthRequest();
  }

  Future<void> postAuthRequest() async {
    Map<String, String> data = {
      'grant_type': 'authorization_code',
      'access_type': 'offline',
      'code': _grantToken,
      'client_id': api,
      'redirect_uri': 'http://localhost',
    };

    var body = jsonEncode(data);

    final response = await http.post(
      authEndpoint,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: body,
    );
    notifyListeners();

    print(response.body);
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;

const String baseUrl = 'http://127.0.0.1:8000/api';

class BaseClient {
  var client = http.Client();
  Future<dynamic> get(String api) async {
    var url = Uri.parse(baseUrl + api);

    var _headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    var jsonResponse;
    var response = await client.get(url, headers: _headers);
    final body = json.decode(response.body);
    print(body['data']);
    if (response.statusCode == 200) {
      // print(body);
      jsonResponse = response.body.toString();
      return jsonResponse;
    } else if (response.statusCode == 400) {
      jsonResponse = response.body.toString();
      throw Exception("Error while fetching. \n ${response.body}");
    } else {
      throw Exception("Error while fetching. \n ${response.body}");
    }
  }

  Future<dynamic> post(String api, dynamic body) async {
    var url = Uri.parse(baseUrl + api);
    var _payload = json.encode(body);
    var _headers = {
      'Content-Type': 'application/json',
    };

    var jsonResponse;
    var response = await client.post(url, body: _payload, headers: _headers);
    if (response.statusCode == 200) {
      print(body);
      jsonResponse = response.body.toString();
      return jsonResponse;
    } else if (response.statusCode == 400) {
      jsonResponse = response.body.toString();
      throw Exception("Error while fetching. \n ${response.body}");
    } else {
      throw Exception("Error while fetching. \n ${response.body}");
    }
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:task_project/models/Banners.dart';
import 'package:http/http.dart' as http;
import 'package:task_project/models/Restraunt.dart';

class Networking{
  Future<Banners> fetchBanner() async {
    final response = await http
        .get(Uri.parse("http://chotu.proinnovativesoftware.co/Api/Rebliss/GetMarkAttendanceUserInfo/0"));

    if (response.statusCode == 200) {
      log('data: $response.body');
      return Banners.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Map<String, dynamic>> postRestraunt(int num) async {
    final response = await http.post(
      Uri.parse('http://chotu.proinnovativesoftware.co/Api/Rebliss/ResturantName'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'Number': num,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Map<String, dynamic> list = json.decode(response.body);
      return list;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
}
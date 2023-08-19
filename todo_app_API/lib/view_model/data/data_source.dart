import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:todo_app_api/model/user.dart';

class WebService {
  late Dio dio;

  WebService() {
    dio = Dio();
  }

  Future<User> loginIn(
      {required String email,
      required String password,
      required String name}) async {
    Map<String, dynamic> headers = {'Accept': 'application/json'};
    FormData body = FormData.fromMap({
      'name': name,
      'email': email,
      'password': password,
    });

    var response = await dio.request(
      'https://tasks.eraasoft.com/api/login',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: body,
    );

    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    } else {
      print(response.statusMessage);
      throw Exception();
    }
  }
}

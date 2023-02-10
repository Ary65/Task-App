import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:task_app/constants/endpoint.dart';
import 'package:task_app/models/task_data_model.dart';

final dataProvider = Provider.autoDispose<ApiServices>((ref) => ApiServices());

class ApiServices {
  Future<List<TaskDataModel>> getUSers() async {
    Response response = await get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map(((e) => TaskDataModel.fromJson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

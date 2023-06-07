import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hionepedia/models/animal_model.dart';

abstract class ApiRepository {
  static const apiUrl = 'https://aturhionepedia.000webhostapp.com';
  static final dio = Dio();

  static getAllData() async {
    try {
      final response = await dio.get('$apiUrl/api/animal');
      if (response.statusCode == 200) {
        return AnimalModel.fromJson(response.data);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

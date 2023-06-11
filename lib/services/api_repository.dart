import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hionepedia/models/animal_model.dart';
import 'package:hionepedia/models/favorite_model.dart';
import 'package:hionepedia/models/user_model.dart';

abstract class ApiRepository {
  static const apiUrl = 'http://192.168.20.30:8080';
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

  static addToFavorite(String animalId) async {
    try {
      final response = await dio.post('$apiUrl/api/animal/$animalId/favorite');
      if (response.statusCode == 201) {
        return AddFav.fromJson(response.data);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static removeFromFavorite(String favId) async {
    try {
      final response = await dio.delete('$apiUrl/api/favorite/$favId');
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static getFavoriteData() async {
    try {
      final response = await dio.get('$apiUrl/api/favorite');
      if (response.statusCode == 201) {
        return FavoriteModel.fromJson(response.data);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static getUserData(String username, String pin) async {
    try {
      final response = await dio
          .post('$apiUrl/api/login', data: {'username': username, 'pin': pin});
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      return UserModel.fromJson(e.response!.data);
    }
  }
}

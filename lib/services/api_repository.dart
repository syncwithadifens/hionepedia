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

  static addToFavorite(int userId, String animalId) async {
    try {
      final response = await dio.post('$apiUrl/api/animal/$animalId/favorite',
          data: {'user_id': userId});
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

  static getFavoriteData(int userId) async {
    try {
      final response = await dio.get('$apiUrl/api/favorite?user_id=$userId');
      if (response.statusCode == 201) {
        return FavoriteModel.fromJson(response.data);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static login(String username, String pin) async {
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

  static register(String username, String pin, String age, String hobby) async {
    try {
      final response = await dio.post('$apiUrl/api/register', data: {
        'username': username,
        'pin': pin,
        'age': int.parse(age),
        'hobby': hobby
      });
      if (response.statusCode == 201) {
        return 'Account created successfully';
      }
    } on DioException catch (e) {
      return UserModel.fromJson(e.response!.data);
    }
  }
}

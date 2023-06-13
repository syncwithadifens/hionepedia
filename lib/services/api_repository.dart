import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hionepedia/models/animal_model.dart';
import 'package:hionepedia/models/favorite_model.dart';
import 'package:hionepedia/models/user_model.dart';

abstract class ApiRepository {
  static const apiUrl = 'https://de21-103-141-108-60.ngrok-free.app';

  static getAllData() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/api/animal'));
      if (response.statusCode == 200) {
        return animalModelFromJson(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static addToFavorite(String userId, String animalId) async {
    try {
      final response = await http.post(
          Uri.parse('$apiUrl/api/animal/$animalId/favorite'),
          body: {'user_id': userId});
      if (response.statusCode == 201) {
        return addFavFromJson(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static removeFromFavorite(String favId) async {
    try {
      final response =
          await http.delete(Uri.parse('$apiUrl/api/favorite/$favId'));
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static getFavoriteData(String userId) async {
    try {
      final response =
          await http.get(Uri.parse('$apiUrl/api/favorite?user_id=$userId'));
      if (response.statusCode == 201) {
        return favoriteModelFromJson(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static login(String username, String pin) async {
    try {
      final response = await http.post(Uri.parse('$apiUrl/api/login'),
          body: {'username': username, 'pin': pin});
      if (response.statusCode == 200) {
        return userModelFromJson(response.body);
      } else {
        return userModelFromJson(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static register(String username, String pin, String age, String hobby) async {
    try {
      final response = await http.post(Uri.parse('$apiUrl/api/register'),
          body: {
            'username': username,
            'pin': pin,
            'age': int.parse(age),
            'hobby': hobby
          });
      if (response.statusCode == 201) {
        return 'Account created successfully';
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

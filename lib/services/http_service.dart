import 'package:hionepedia/models/animal_model.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static const apiUrl = 'https://hionepedia.000webhostapp.com';

  Future<AnimalModel> getAllData() async {
    final response = await http.get(Uri.parse('$apiUrl/animals'));

    if (response.statusCode == 200) {
      return animalModelFromJson(response.body);
    } else {
      throw Exception('failed get all data');
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/animal_model.dart';

final Map<String, String> Headers = {
  'X-Api-Key': 'oaqzVwLu9nEI/OvnhS4SrA==QYbFg5sjhsgqKuxm',
};

class Animal_API {
  Animal_API._();
  static Animal_API animal_api = Animal_API._();

  Future<List<Animal_Modal>?> fectData({required String name}) async {
    // name = 'cheetah'
    //  api_url = 'https://api.api-ninjas.com/v1/animals?name={}'.format(name)
    Uri uri = Uri.parse("https://api.api-ninjas.com/v1/animals?name={$name}");

    http.Response res = await http.get(uri, headers: Headers);

    if (res.statusCode == 200) {
      List decodeData = jsonDecode(res.body);
      print(decodeData);
      List<Animal_Modal> list =
      decodeData.map((e) => Animal_Modal.fromMap(data: e)).toList();
      // print(list);
      return list;
    }
  }
}
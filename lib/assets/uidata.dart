import 'dart:async' show Future;

import 'package:http/http.dart' as http;

class UiResponse {
  Future<String> loadAsset() async {
    print('getting Data');
    final response = await http.get('http://demo9852994.mockable.io/template');
    print('dta ${response.body.toString()}');
    return response.body.toString();
  }
}

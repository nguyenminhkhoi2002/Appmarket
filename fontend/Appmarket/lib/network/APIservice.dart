// ignore: file_namescla
import 'package:http/http.dart' as http;
import 'dart:convert';
class APIservice {

  Future<int> Login(String email, String password) async {
    var url = Uri.parse('http://127.0.0.1:8000/api/customers/sigin/');
    var bd=json.encode({'email': email, 'password': password});
    var response = await http.post(url, body: bd);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    int result = json.decode(response.body)['id'] as int;
    if (response.statusCode == 200) {
      print(result);
      return result;
    }
    return 0;
  }

  Future<dynamic> GetProduct() async {
    var url = Uri.parse('http://127.0.0.1:8000/api/products/');
    var response = await http.get(url);
    dynamic fullpro=json.decode(response.body);
    print(fullpro.runtimeType);
    return fullpro['products'];
  }
}
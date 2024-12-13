import 'dart:convert';

import 'package:psicoapp/configs/constants.dart';
import 'package:http/http.dart' as http;
import 'package:psicoapp/models/entities/Usuario.dart';

class UserService {
  Future<Usuario?> validate(String email, String password) async {
    String url = "${BASE_URL}usuarios/login";

    try {
      // Enviar solicitud POST usando http.post
      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"correo": email, "contrasena": password}),
      );
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');


      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);

        final Usuario usuario = Usuario.fromJson(responseBody);
        return usuario;
      } else if (response.statusCode == 404) {
        return null;
      } else {
        print('Error de validación: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error no esperado: $e');
      return null;
    }
  }

  Future<String?> reset(String dni, String email) async {
    String url = "${BASE_URL}user/reset";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['dni'] = dni;
    request.fields['email'] = email;
    try {
      var response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        final String r = responseBody;
        return r;
      } else if (response.statusCode == 404) {
        var responseBody = await response.stream.bytesToString();
        final String r = responseBody;
        return r;
      } else {
        print('ERROORRR!!!');
      }
    } catch (e, stackTrace) {
      print('Error no esperado: $e');
      print(stackTrace);
    }
  }
}

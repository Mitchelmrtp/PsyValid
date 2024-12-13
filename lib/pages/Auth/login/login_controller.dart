import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psicoapp/models/entities/Usuario.dart';
import 'package:psicoapp/pages/home/Home_Paciente/homepaciente_page.dart';
import 'package:psicoapp/pages/home/home_page.dart';
import 'package:psicoapp/services/user_service.dart';
import '../../recover/recover_page.dart';
import '../../signin/signin_page.dart';

class LoginController extends GetxController {
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  RxString message = 'primer mensaje'.obs;
  var messageColor = Colors.white.obs;
  UserService userService = UserService();

  void login(BuildContext context) async {
    String correo = userController.text;
    String contrasena = passController.text;

    // Obtener el usuario autenticado desde el servicio de usuario
    Usuario? userValidated = await userService.validate(correo, contrasena);

    if (userValidated == null) {
      message.value = 'Error en el servidor';
      messageColor.value = Colors.red;
    } else if (userValidated.idUsuario == 0) {
      message.value = 'Usuario o contraseña incorrectos';
      messageColor.value = Colors.red;
    } else {
      // Redirigir dependiendo del rol del usuario
      if (userValidated.rol == 'Psicologo') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePacientePage(usuarioLogged: userValidated),
          ),
        );
      } else if (userValidated.rol == 'Paciente') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePacientePage(usuarioLogged: userValidated),
          ),
        );
      } else {
        // Manejar otros roles o redirigir a una página por defecto
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePacientePage(usuarioLogged: userValidated),
          ),
        );
      }
    }
  }

  void goToSignIn(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  }

  void goToRecover(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecoverPage()),
    );
  }
}

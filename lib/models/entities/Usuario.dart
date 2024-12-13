import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  int idUsuario;
  String correo;
  String contrasena;
  String rol;

  // Constructor vacío para inicialización predeterminada
  Usuario.empty()
      : idUsuario = 0,
        correo = '',
        contrasena = '',
        rol = 'Paciente'; // Por defecto, 'Paciente'

  Usuario({
    required this.idUsuario,
    required this.correo,
    required this.contrasena,
    required this.rol,
  });

  // Método copyWith para actualizar campos específicos
  Usuario copyWith({
    int? idUsuario,
    String? correo,
    String? contrasena,
    String? rol,
  }) {
    return Usuario(
      idUsuario: idUsuario ?? this.idUsuario,
      correo: correo ?? this.correo,
      contrasena: contrasena ?? this.contrasena,
      rol: rol ?? this.rol,
    );
  }

  // Método para crear un objeto Usuario desde JSON
  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idUsuario: json["id_usuario"],
        correo: json["correo"],
        contrasena: json["contrasena"],
        rol: json["rol"], // Agregar el rol desde el JSON
      );

  // Método para convertir un objeto Usuario a JSON
  Map<String, dynamic> toJson() => {
        "id_usuario": idUsuario,
        "correo": correo,
        "contrasena": contrasena,
        "rol": rol,  // Agregar el rol al JSON
      };

  @override
  String toString() {
    return 'Usuario -> idUsuario: $idUsuario, correo: $correo, contrasena: $contrasena, rol: $rol';
  }
}

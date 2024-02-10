import 'package:tutorados_app/entities/entities.dart';

class UserMapper {
  static User userJsonToEntity(Map<String, dynamic> json ) => 
  
  User(
    id: json['Usuario_Id'], 
    name: json['Nombre'], 
    lastName: json['Apellido'], 
    email: json['Correo'], 
    role: json['Rol'], 
    token: json['Token']
    );
}
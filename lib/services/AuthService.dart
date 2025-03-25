import 'package:dio/dio.dart';
import '../services/api_service.dart';

class AuthService {
  final Dio _dio = ApiService().dio; // Instance globale de Dio

  Future<Map<String, dynamic>> signIn(String email, String password) async {

    try {
      Response response = await _dio.post(
        "v1/auth/signin",
        data: {"email": email, "password": password},
      );
      print(response.data);
      return response.data;
    } catch (e) {
      print("Erreur de connexion : $e");
      throw Exception("Échec de l'authentification");
    }
  }

  Future<Map<String, dynamic>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      Response response = await _dio.post(
        "v1/auth/signup",
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "password": password,
          "role": "USER",
          "activated": true,
          "profil": "USER",
          "phone": phone,
        },
      );
      return response.data;
    } catch (e) {
      throw Exception("Échec de la création de compte");
    }
  }

  Future<Map<String, dynamic>> connectedUser() async {
    try {
      Response response = await _dio.get("v1/user/me");
      return response.data;
    } catch (e) {
      throw Exception("Une  erreur est survenue");
    }
  }
}

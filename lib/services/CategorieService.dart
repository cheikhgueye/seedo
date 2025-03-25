import 'package:dio/dio.dart';
import '../models/CategorieModel.dart';
import '../services/api_service.dart';
//service
class CategorieService {
  final Dio _dio = ApiService().dio; // Utilisation de l'instance globale

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    try {
      Response response = await _dio.get("categories/no-parent");
      List<Map<String, dynamic>> categories = List<Map<String, dynamic>>.from(response.data);

      return categories;
    } catch (e) {
      print("Erreur lors de la récupération des catégories : $e");
      throw Exception("Erreur réseau");
    }
  }
}
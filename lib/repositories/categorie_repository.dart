
import '../models/CategorieModel.dart';
import '../services/CategorieService.dart';

class CategorieRepository {
  final CategorieService _categorieService = CategorieService();



  Future<List<CategorieModel>> fetchCategoriesNoParent() async {
    try {
      final data= await _categorieService .fetchCategories();
      return CategorieModel.fromJsonList(data);
    } catch (e) {
      print("Erreur lors de la récupération des catégories : $e");
      throw Exception("Erreur réseau");
    }
  }



}

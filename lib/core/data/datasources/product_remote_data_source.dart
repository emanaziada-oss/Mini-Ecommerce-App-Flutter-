import '../models/product_model.dart';
import 'api_service.dart';

class ProductRemoteDataSource {
  final ApiService api;
  ProductRemoteDataSource(this.api);

  Future<List<ProductModel>> getAllProducts() async {
    final resp = await api.get('products');
    final data = resp.data;
    if (data == null) return [];
    final list = (data['products'] as List).cast<Map<String,dynamic>>();
    return list.map((e) => ProductModel.fromJson(e)).toList();
  }

  Future<List<String>> getAllCategories() async {
    final resp = await api.get('products/categories');
    if (resp.data == null) return [];
    return (resp.data as List).map((e) => e['name'].toString()).toList();
  }
}

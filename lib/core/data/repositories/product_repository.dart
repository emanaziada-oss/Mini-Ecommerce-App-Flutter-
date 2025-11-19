import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';
import 'package:hive/hive.dart';

class ProductRepository {
  final ProductRemoteDataSource remote;
  ProductRepository(this.remote);
  Future<List<ProductModel>> getAllProducts() async {
    final list = await remote.getAllProducts();
    return list;
  }

  Future<List<String>> getAllCategories() => remote.getAllCategories();
}

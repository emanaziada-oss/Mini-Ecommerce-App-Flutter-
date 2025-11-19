
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myproject/bloc/product/products_state.dart';
import 'package:myproject/core/data/repositories/product_repository.dart';

class ProductCubit extends Cubit<ProductState>{
  final ProductRepository repo;
  ProductCubit(this.repo) : super (ProductInitial());
  Future <void> fetchProducts() async{
    emit(ProductLoading());
    try{
      final list = await repo.getAllProducts();
      emit(ProductLoaded(list));
    } catch (e){
      emit(ProductError(e.toString()));
    }
  }
}
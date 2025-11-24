import 'package:equatable/equatable.dart';
import '../model/fav_model.dart';

abstract class FavState extends Equatable {
  const FavState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavState {}

class FavoritesLoaded extends FavState {
  final List<FavItem> items;

  const FavoritesLoaded(this.items);

  @override
  List<Object> get props => [items];
}

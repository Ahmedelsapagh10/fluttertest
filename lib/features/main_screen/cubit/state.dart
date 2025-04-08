import '../../../core/preferences/product_model.dart';
import '../data/model/product_model.dart';

abstract class MainState {}

class MainInitial extends MainState {}

class SearchedState extends MainState {}

class LoadedState extends MainState {
  final List<MainProductModel> products;
  LoadedState({required this.products});
}

class LoadingState extends MainState {}

class ErrorState extends MainState {}

class AddProductToCartState extends MainState {}

class CartInitial extends MainState {}

class CartLoading extends MainState {}

class LoadingLogoutState extends MainState {}

class CartLoaded extends MainState {
  final List<ProductModel> products;

  CartLoaded(this.products);
}

class CartError extends MainState {
  final String message;

  CartError(this.message);
}

class CartProductExists extends MainState {
  final String message;

  CartProductExists(this.message);
}

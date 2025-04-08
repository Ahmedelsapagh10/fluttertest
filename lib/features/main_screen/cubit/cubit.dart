import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/exports.dart';
import '../../../core/preferences/hive.dart';
import '../../../core/preferences/product_model.dart';
import '../../../core/widgets/show_loading_indicator.dart';
import '../data/main_repo.dart';
import '../data/model/product_model.dart';
import 'state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(this.api) : super(MainInitial());

  final MainRepo api;

  TextEditingController textEditingController = TextEditingController();

  List<MainProductModel> allProducts = [];
  List<ProductModel> cartProducts = [];

  Future<void> getAllProducts(BuildContext context) async {
    emit(LoadingState());
    try {
      final res = await api.getAllProducts();
      res.fold(
        (l) {
          emit(ErrorState());
        },
        (r) async {
          allProducts = r;

          // Load cart products
          await loadCart();

          // Assign `myCount` values based on cartProducts
          for (var product in allProducts) {
            product.myCount =
                cartProducts.any((p) => p.id == product.id) ? 0 : 1;
          }

          emit(LoadedState(products: allProducts));
        },
      );
    } catch (e) {
      log(e.toString());
      emit(ErrorState());
    }
  }

  /// Load cart products from Hive
  Future<void> loadCart() async {
    emit(CartLoading());
    try {
      cartProducts = HiveManager.getCartProducts();
      emit(CartLoaded(cartProducts));
    } catch (e) {
      log(e.toString());
      emit(CartError(e.toString()));
    }
  }

  /// Add a product to the cart
  Future<void> addProduct(ProductModel product) async {
    emit(CartLoading());
    try {
      // Check if the product already exists in the cart
      bool productExists = cartProducts.any((p) => p.id == product.id);
      log('productExists : ${productExists}');

      if (productExists) {
        await HiveManager.removeProduct(product.id!);
      } else {
        await HiveManager.saveProduct(product);
      }
      for (var product in allProducts) {
        product.myCount = cartProducts.any((p) => p.id == product.id) ? 0 : 1;
      }
      log('qty : ${product.myCount}');
      // Assign `myCount` values based on cartProducts

      // Reload cart products
      cartProducts = HiveManager.getCartProducts();

      // Emit the updated state
      emit(CartLoaded(cartProducts));

      // Optionally, update the UI with a success message
      if (productExists) {
        successGetBar('Product "${product.title}" removed from the cart.');
      } else {
        successGetBar('Product "${product.title}" added to the cart.');
      }
    } catch (e) {
      log(e.toString());
      emit(CartError(e.toString()));
    }
  }

  /// Remove a product from the cart
  Future<void> removeProduct(ProductModel product) async {
    emit(CartLoading());
    try {
      await HiveManager.removeProduct(product.id!);
      cartProducts = HiveManager.getCartProducts();

      for (var product in allProducts) {
        product.myCount = cartProducts.any((p) => p.id == product.id) ? 0 : 1;
      }
      emit(CartLoaded(cartProducts));
    } catch (e) {
      log(e.toString());
      emit(CartError(e.toString()));
    }
  }

  Future<void> updateQuantity(ProductModel product, int newQuantity) async {
    emit(CartLoading());
    try {
      // Find the product in the list
      int index = cartProducts.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        cartProducts[index].myCount = newQuantity; // Update the quantity
        await HiveManager.updateProducts(cartProducts);
      }

      emit(CartLoaded(cartProducts));
    } catch (e) {
      log(e.toString());
      emit(CartError(e.toString()));
    }
  }

  logOut(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BlocBuilder<MainCubit, MainState>(
          builder: (context, state) {
            return AlertDialog(
              title: Image.asset(
                ImageAssets.appIcon,
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              content: Text(
                'are_you_sure_to_logout'.tr(),
                style: const TextStyle(fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              actions: state is LoadingLogoutState
                  ? [CustomLoadingIndicator()]
                  : [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('cancel'.tr()),
                      ),
                      TextButton(
                        onPressed: () async {
                          emit(LoadingLogoutState());
                          await HiveManager.clearCart();
                          await HiveManager.logoutUser();
                          Navigator.pushNamedAndRemoveUntil(
                              context, Routes.initialRoute, (route) => false);
                        },
                        child: Text('ok'.tr()),
                      ),
                    ],
            );
          },
        );
      },
    );
  }
}

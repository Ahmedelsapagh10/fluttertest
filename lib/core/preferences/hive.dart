import 'package:fluttertest/core/preferences/product_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'user_model.dart'; // Import your UserModel

class HiveManager {
  static const String userBoxName = 'userModelBox';
  static const String productBoxName = 'productModelBox';

  /// Initialize Hive and register adapters
  static Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(ProductModelAdapter());
    Hive.registerAdapter(RatingAdapter());

    // Register adapter for ProductModel
    await Hive.openBox(userBoxName);
    await Hive.openBox(productBoxName); // Open the product box
  }

  /// Save user data to Hive
  static Future<void> saveUser(UserModel user) async {
    final userBox = Hive.box(userBoxName);
    await userBox.put('user', user); // Save the user model
  }

  /// Retrieve user data from Hive
  static UserModel? getUser() {
    final userBox = Hive.box(userBoxName);
    return userBox.get('user') as UserModel?; // Retrieve the user model
  }

  static String? getUserToken() {
    final userBox = Hive.box(userBoxName);
    final user = userBox.get('user') as UserModel?;
    return user?.token; // Return the token if it exists
  }

  /// Check if a user is logged in
  static bool isLoggedIn() {
    final userBox = Hive.box(userBoxName);
    return userBox.containsKey('user'); // Check if 'user' key exists
  }

  /// Log out the user by clearing their data
  static Future<void> logoutUser() async {
    final userBox = Hive.box(userBoxName);
    await userBox.clear(); // Clear all data in the user box
  }

  //! Products

  /// Save a product to the cart
  static Future<void> saveProduct(ProductModel product) async {
    final productBox = Hive.box(productBoxName);
    List<ProductModel> products =
        productBox.get('cart', defaultValue: []).cast<ProductModel>();
    products.add(product);
    await productBox.put('cart', products); // Save the updated list
  }

  /// Get all products in the cart
  static List<ProductModel> getCartProducts() {
    final productBox = Hive.box(productBoxName);
    return productBox.get('cart', defaultValue: []).cast<ProductModel>();
  }

  /// Remove a product from the cart
  static Future<void> removeProduct(int productId) async {
    final productBox = Hive.box(productBoxName);
    List<ProductModel> products =
        productBox.get('cart', defaultValue: []).cast<ProductModel>();
    products.removeWhere((product) => product.id == productId);
    await productBox.put('cart', products); // Save the updated list
  }

  /// Update the entire list of products in Hive
  static Future<void> updateProducts(List<ProductModel> updatedProducts) async {
    final productBox = Hive.box(productBoxName);
    await productBox.put('cart',
        updatedProducts); // Replace the existing list with the updated list
  }

  /// Clear all products from the cart
  static Future<void> clearCart() async {
    final productBox = Hive.box(productBoxName);
    await productBox.delete('cart'); // Delete the cart key
  }
}

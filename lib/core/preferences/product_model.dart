import 'package:hive/hive.dart';

part 'product_model.g.dart'; // This will be generated

@HiveType(typeId: 1) // Unique typeId for this model
class ProductModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  var price;

  @HiveField(3)
  String? description;

  @HiveField(4)
  String? category;

  @HiveField(5)
  String? image;

  @HiveField(6)
  Rating? rating;
  @HiveField(7)
  int? myCount;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    this.myCount = 0,
  });
}

@HiveType(typeId: 2) // Unique typeId for this model
class Rating extends HiveObject {
  @HiveField(0)
  var rate;

  @HiveField(1)
  int? count;

  Rating({this.rate, this.count});
}

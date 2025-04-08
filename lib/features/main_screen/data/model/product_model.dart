class MainProductModel {
  int? id;
  String? title;
  var price;
  String? description;
  String? category;
  String? image;
  int? myCount;

  MainRating? rating;
  MainProductModel({
    required this.id,
    required this.price,
    required this.title,
    required this.category,
    required this.description,
    required this.image,
    required this.rating,
    this.myCount = 0,
  });
  factory MainProductModel.fromJson(Map<String, dynamic> json) {
    return MainProductModel(
        id: json['id'],
        price: json['price'],
        title: json['title'],
        description: json['description'],
        image: json['image'],
        category: json['category'],
        rating: MainRating.fromJson(json['rating']));
  }
}

class MainRating {
  var count;
  var rate;
  MainRating({
    required this.count,
    required this.rate,
  });
  factory MainRating.fromJson(Map<String, dynamic> json) {
    return MainRating(count: json['count'], rate: json['rate']);
  }
}

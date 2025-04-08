import 'package:hive/hive.dart';

part 'user_model.g.dart'; // This will be generated

@HiveType(typeId: 0) // Unique typeId for this model
class UserModel extends HiveObject {
  @HiveField(0)
  final String? token;

  UserModel({this.token});
}

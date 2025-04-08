import 'package:fluttertest/core/exports.dart';

import 'model/product_model.dart';

class MainRepo {
  BaseApiConsumer dio;
  MainRepo(this.dio);

  Future<Either<Failure, List<MainProductModel>>> getAllProducts() async {
    try {
      dynamic response = await dio.get(EndPoints.homeUrl);
      final List<dynamic> responseData = response as List<dynamic>;

      final List<MainProductModel> products = responseData
          .map(
              (json) => MainProductModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(products);
    } on DioException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}

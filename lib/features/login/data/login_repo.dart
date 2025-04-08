import 'dart:convert';

import '../../../core/exports.dart';

class LoginRepo {
  BaseApiConsumer dio;
  LoginRepo(this.dio);

  Future<Either<Failure, LoginModel>> login(
      String email, String password) async {
        
    try {
      // Make the POST request
      dynamic response = await dio.post(
        EndPoints.loginUrl,
        body: {'email': email, 'password': password},
      );

      if (response['token'] == null) {
        return Left(ServerFailure());
      }

      return Right(LoginModel.fromJson(response));
    } on DioException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
  //!
}

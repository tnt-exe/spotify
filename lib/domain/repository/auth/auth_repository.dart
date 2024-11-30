import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/auth/create_user_request.dart';
import 'package:spotify/data/models/auth/sign_in_request.dart';
import 'package:spotify/domain/entities/auth/user.dart';

abstract class AuthRepository {
  Future<Either<String, String?>> signinGoogle();

  Future<Either<String, String?>> signup(CreateUserRequest request);

  Future<Either<String, String?>> signin(SignInRequest request);

  Future<Either<String, UserEntity>> getUser();
}

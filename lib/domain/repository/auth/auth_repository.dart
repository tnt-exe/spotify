import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/auth/create_user_request.dart';
import 'package:spotify/data/models/auth/sign_in_request.dart';

abstract class AuthRepository {
  Future<Either> signup(CreateUserRequest request);

  Future<Either> signin(SignInRequest request);

  Future<Either> getUser();
}

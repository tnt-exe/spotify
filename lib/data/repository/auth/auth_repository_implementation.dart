import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/auth/create_user_request.dart';
import 'package:spotify/data/models/auth/sign_in_request.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/domain/entities/auth/user.dart';
import 'package:spotify/domain/repository/auth/auth_repository.dart';
import 'package:spotify/service_locator.dart';

class AuthRepositoryImplementation extends AuthRepository {
  @override
  Future<Either<String, String?>> signin(SignInRequest request) async {
    return await sl<AuthFirebaseService>().signin(request);
  }

  @override
  Future<Either<String, String?>> signup(CreateUserRequest request) async {
    return await sl<AuthFirebaseService>().signup(request);
  }

  @override
  Future<Either<String, UserEntity>> getUser() async {
    return await sl<AuthFirebaseService>().getUser();
  }

  @override
  Future<Either<String, String?>> signinGoogle() async {
    return await sl<AuthFirebaseService>().signinGoogle();
  }
}

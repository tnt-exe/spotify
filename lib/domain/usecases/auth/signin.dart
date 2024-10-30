import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/data/models/auth/sign_in_request.dart';
import 'package:spotify/domain/repository/auth/auth_repository.dart';
import 'package:spotify/service_locator.dart';

class SigninUseCase implements UseCase<Either, SignInRequest> {
  @override
  Future<Either> call({SignInRequest? params}) async {
    return await sl<AuthRepository>().signin(params!);
  }
}

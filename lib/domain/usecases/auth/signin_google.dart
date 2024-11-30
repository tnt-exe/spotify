import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/domain/repository/auth/auth_repository.dart';
import 'package:spotify/service_locator.dart';

class SigninGoogleUseCase implements UseCase<Either<String, String?>, dynamic> {
  @override
  Future<Either<String, String?>> call({params}) async {
    return await sl<AuthRepository>().signinGoogle();
  }
}

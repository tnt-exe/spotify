import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/domain/entities/auth/user.dart';
import 'package:spotify/domain/repository/auth/auth_repository.dart';
import 'package:spotify/service_locator.dart';

class GetUserUseCase implements UseCase<Either<String, UserEntity>, dynamic> {
  @override
  Future<Either<String, UserEntity>> call({params}) async {
    return await sl<AuthRepository>().getUser();
  }
}

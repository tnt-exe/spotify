import 'package:get_it/get_it.dart';
import 'package:spotify/data/repository/auth/auth_repository_implementation.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth_repository.dart';

final sl = GetIt.instance;

Future<void> initializeDependency() async {
  sl.registerSingleton<AuthFirebaseService>(
      AuthFirebaseServiceImplementation());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImplementation());
}

import 'package:get_it/get_it.dart';
import 'package:spotify/data/repository/auth/auth_repository_implementation.dart';
import 'package:spotify/data/repository/song/song_repository_implementation.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/data/sources/song/song_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth_repository.dart';
import 'package:spotify/domain/repository/song/song_repository.dart';
import 'package:spotify/domain/usecases/auth/signin.dart';
import 'package:spotify/domain/usecases/auth/signup.dart';
import 'package:spotify/domain/usecases/song/get_news_songs.dart';

final sl = GetIt.instance;

Future<void> initializeDependency() async {
  sl.registerSingleton<AuthFirebaseService>(
      AuthFirebaseServiceImplementation());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImplementation());

  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());

  sl.registerSingleton<SongFirebaseService>(
      SongFirebaseServiceImplementation());
  sl.registerSingleton<SongRepository>(SongRepositoryImplementation());
  sl.registerSingleton<GetNewsSongsUseCase>(GetNewsSongsUseCase());
}

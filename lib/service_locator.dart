import 'package:get_it/get_it.dart';
import 'package:spotify/data/repository/auth/auth_repository_implementation.dart';
import 'package:spotify/data/repository/song/song_repository_implementation.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/data/sources/song/song_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth_repository.dart';
import 'package:spotify/domain/repository/song/song_repository.dart';
import 'package:spotify/domain/usecases/auth/get_user.dart';
import 'package:spotify/domain/usecases/auth/signin.dart';
import 'package:spotify/domain/usecases/auth/signup.dart';
import 'package:spotify/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:spotify/domain/usecases/song/get_favorite_song.dart';
import 'package:spotify/domain/usecases/song/get_news_songs.dart';
import 'package:spotify/domain/usecases/song/get_playlist.dart';
import 'package:spotify/domain/usecases/song/is_favorite_song.dart';

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
  sl.registerSingleton<GetPlaylistUseCase>(GetPlaylistUseCase());
  sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(
      AddOrRemoveFavoriteSongUseCase());
  sl.registerSingleton<IsFavoriteSongUseCase>(IsFavoriteSongUseCase());
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());
  sl.registerSingleton<GetFavoriteSongUseCase>(GetFavoriteSongUseCase());
}

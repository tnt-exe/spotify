import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/data/models/song/user_song.dart';
import 'package:spotify/domain/repository/song/song_repository.dart';
import 'package:spotify/service_locator.dart';

class AddOrRemoveFavoriteSongUseCase
    implements UseCase<Either<String, bool>, UserSong> {
  @override
  Future<Either<String, bool>> call({UserSong? params}) async {
    return await sl<SongRepository>().addOrRemoveFavoriteSongs(params!);
  }
}

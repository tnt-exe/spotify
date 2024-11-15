import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/data/models/song/user_song.dart';
import 'package:spotify/domain/repository/song/song_repository.dart';
import 'package:spotify/service_locator.dart';

class IsFavoriteSongUseCase implements UseCase<bool, UserSong> {
  @override
  Future<bool> call({UserSong? params}) async {
    return await sl<SongRepository>().isFavoriteSong(params!);
  }
}

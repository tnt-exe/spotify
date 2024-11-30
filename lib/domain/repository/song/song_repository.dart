import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/song/user_song.dart';
import 'package:spotify/domain/entities/song/song.dart';

abstract class SongRepository {
  Future<Either<String, List<SongEntity>>> getNewSongs(String? uId);
  Future<Either<String, List<SongEntity>>> getPlaylist(String? uId);
  Future<Either<String, bool>> addOrRemoveFavoriteSongs(UserSong userSong);
  Future<bool> isFavoriteSong(UserSong userSong);
  Future<Either<String, List<SongEntity>>> getUserFavoriteSongs(String? uId);
}

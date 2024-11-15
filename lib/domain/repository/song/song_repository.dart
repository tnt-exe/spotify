import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/song/user_song.dart';

abstract class SongRepository {
  Future<Either> getNewSongs(String? uId);
  Future<Either> getPlaylist(String? uId);
  Future<Either> addOrRemoveFavoriteSongs(UserSong userSong);
  Future<bool> isFavoriteSong(UserSong userSong);
  Future<Either> getUserFavoriteSongs(String? uId);
}

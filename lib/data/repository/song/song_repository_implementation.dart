import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/song/user_song.dart';
import 'package:spotify/data/sources/song/song_firebase_service.dart';
import 'package:spotify/domain/repository/song/song_repository.dart';
import 'package:spotify/service_locator.dart';

class SongRepositoryImplementation extends SongRepository {
  @override
  Future<Either> getNewSongs(String? uId) async {
    return await sl<SongFirebaseService>().getNewSongs(uId);
  }

  @override
  Future<Either> getPlaylist(String? uId) async {
    return await sl<SongFirebaseService>().getPlaylist(uId);
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(UserSong userSong) async {
    return await sl<SongFirebaseService>().addOrRemoveFavoriteSongs(userSong);
  }

  @override
  Future<bool> isFavoriteSong(UserSong userSong) async {
    return await sl<SongFirebaseService>().isFavoriteSong(userSong);
  }

  @override
  Future<Either> getUserFavoriteSongs(String? uId) async {
    return await sl<SongFirebaseService>().getUserFavoriteSongs(uId);
  }
}

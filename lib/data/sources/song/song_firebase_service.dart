import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/song/song.dart';
import 'package:spotify/data/models/song/user_song.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/domain/usecases/song/is_favorite_song.dart';
import 'package:spotify/service_locator.dart';

abstract class SongFirebaseService {
  Future<Either> getNewSongs(String? uId);
  Future<Either> getPlaylist(String? uid);
  Future<Either> addOrRemoveFavoriteSongs(UserSong userSong);
  Future<bool> isFavoriteSong(UserSong userSong);
  Future<Either> getUserFavoriteSongs(String? uId);
}

class SongFirebaseServiceImplementation implements SongFirebaseService {
  @override
  Future<Either> getNewSongs(String? uId) async {
    try {
      List<SongEntity> songs = [];

      var data = await FirebaseFirestore.instance
          .collection("Songs")
          .orderBy("releaseDate", descending: true)
          .limit(3)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteSongUseCase>().call(
          params: UserSong(
            songId: element.reference.id,
            uId: uId,
          ),
        );
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(
          songModel.toEntity(),
        );
      }

      return Right(songs);
    } catch (e) {
      return const Left("An error occurred");
    }
  }

  @override
  Future<Either> getPlaylist(String? uId) async {
    try {
      List<SongEntity> songs = [];

      var data = await FirebaseFirestore.instance
          .collection("Songs")
          .orderBy("releaseDate", descending: true)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteSongUseCase>().call(
          params: UserSong(
            songId: element.reference.id,
            uId: uId,
          ),
        );
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(
          songModel.toEntity(),
        );
      }

      return Right(songs);
    } catch (e) {
      return const Left("An error occurred");
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(UserSong userSong) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      late bool isFavorite;
      String? uId = userSong.uId;

      if (userSong.uId == null) {
        var userData = firebaseAuth.currentUser;
        uId = userData!.uid;
      }

      var favoriteSongs = await firebaseFirestore
          .collection("Users")
          .doc(uId)
          .collection("Favorites")
          .where('songId', isEqualTo: userSong.songId)
          .get();

      if (favoriteSongs.docs.isNotEmpty) {
        await favoriteSongs.docs.first.reference.delete();
        isFavorite = false;
      } else {
        await firebaseFirestore
            .collection("Users")
            .doc(uId)
            .collection("Favorites")
            .add({"songId": userSong.songId, "addedDate": Timestamp.now()});

        isFavorite = true;
      }
      return Right(isFavorite);
    } catch (e) {
      return const Left("An error occurred");
    }
  }

  @override
  Future<bool> isFavoriteSong(UserSong userSong) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      String? uId = userSong.uId;
      if (uId == null) {
        var userData = firebaseAuth.currentUser;
        uId = userData!.uid;
      }

      var favoriteSongs = await firebaseFirestore
          .collection("Users")
          .doc(uId)
          .collection("Favorites")
          .where('songId', isEqualTo: userSong.songId)
          .get();

      return favoriteSongs.docs.isNotEmpty ? true : false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either> getUserFavoriteSongs(String? uId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      if (uId == null) {
        var user = firebaseAuth.currentUser;
        uId = user!.uid;
      }

      var userFavoriteSong = await firebaseFirestore
          .collection("Users")
          .doc(uId)
          .collection("Favorites")
          .get();

      late List<SongEntity> favoriteSongList = [];
      for (var element in userFavoriteSong.docs) {
        String songId = element["songId"];

        var song =
            await firebaseFirestore.collection("Songs").doc(songId).get();

        SongModel songModel = SongModel.fromJson(song.data()!);
        songModel.isFavorite = true;
        songModel.songId = songId;
        favoriteSongList.add(songModel.toEntity());
      }

      return Right(favoriteSongList);
    } catch (e) {
      return const Left("An error occurred");
    }
  }
}

import 'package:spotify/domain/entities/song/song.dart';

abstract class FavoriteSongState {}

class FavoriteSongLoading extends FavoriteSongState {}

class FavoriteSongLoaded extends FavoriteSongState {
  final List<SongEntity> favoriteSongList;

  FavoriteSongLoaded({required this.favoriteSongList});
}

class FavoriteSongLoadFailed extends FavoriteSongState {}

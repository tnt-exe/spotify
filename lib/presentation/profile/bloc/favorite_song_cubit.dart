import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/domain/usecases/song/get_favorite_song.dart';
import 'package:spotify/presentation/profile/bloc/favorite_song_state.dart';
import 'package:spotify/service_locator.dart';

class FavoriteSongCubit extends Cubit<FavoriteSongState> {
  FavoriteSongCubit() : super(FavoriteSongLoading());

  List<SongEntity> favoriteSongList = [];
  Future<void> getFavoriteSongs(String uId) async {
    var result = await sl<GetFavoriteSongUseCase>().call(
      params: uId,
    );

    result.fold(
      (error) {
        emit(
          FavoriteSongLoadFailed(),
        );
      },
      (favoriteSongListResult) {
        favoriteSongList = favoriteSongListResult;
        emit(
          FavoriteSongLoaded(favoriteSongList: favoriteSongListResult),
        );
      },
    );
  }

  void removeSong(int index) {
    favoriteSongList.removeAt(index);

    emit(
      FavoriteSongLoaded(favoriteSongList: favoriteSongList),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:spotify/data/models/song/user_song.dart';
import 'package:spotify/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:spotify/service_locator.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  FavoriteButtonCubit() : super(FavoriteButtonInit());

  Future<void> favoriteButtonUpdate(String songId, String uId) async {
    var result = await sl<AddOrRemoveFavoriteSongUseCase>().call(
      params: UserSong(
        songId: songId,
        uId: uId,
      ),
    );

    result.fold((error) {}, (isFavorite) {
      emit(FavoriteButtonUpdate(
        isFavorite: isFavorite,
      ));
    });
  }
}

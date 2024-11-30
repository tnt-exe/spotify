import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/usecases/song/get_playlist.dart';
import 'package:spotify/presentation/home/bloc/playlist_state.dart';
import 'package:spotify/service_locator.dart';

class PlaylistCubit extends Cubit<PlaylistState> {
  PlaylistCubit() : super(PlaylistLoading());

  Future<void> getPlaylist(String uId) async {
    var returnedSongs = await sl<GetPlaylistUseCase>().call(
      params: uId,
    );

    returnedSongs.fold(
      (error) {
        emit(PlaylistLoadFailure());
      },
      (playList) {
        emit(PlaylistLoaded(songs: playList));
      },
    );
  }
}

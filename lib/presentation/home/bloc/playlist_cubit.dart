import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/usecases/song/get_playlist.dart';
import 'package:spotify/presentation/home/bloc/playlist_state.dart';
import 'package:spotify/service_locator.dart';

class PlaylistCubit extends Cubit<PlaylistState> {
  PlaylistCubit() : super(PlaylistLoading());

  Future<void> getPlaylist() async {
    var returnedSongs = await sl<GetPlaylistUseCase>().call();

    returnedSongs.fold(
      (l) {
        emit(PlaylistLoadFailure());
      },
      (r) {
        emit(PlaylistLoaded(songs: r));
      },
    );
  }
}

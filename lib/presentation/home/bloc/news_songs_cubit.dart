import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/usecases/song/get_news_songs.dart';
import 'package:spotify/presentation/home/bloc/news_songs_state.dart';
import 'package:spotify/service_locator.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  NewsSongsCubit() : super(NewsSongsLoading());

  Future<void> getNewsSongs(String uId) async {
    var returnedSongs = await sl<GetNewsSongsUseCase>().call(
      params: uId,
    );

    returnedSongs.fold(
      (l) {
        emit(NewsSongsLoadFailure());
      },
      (r) {
        emit(NewsSongsLoaded(songs: r));
      },
    );
  }
}

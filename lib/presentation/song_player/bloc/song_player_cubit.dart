import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/presentation/song_player/bloc/song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();

  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;
  double songVolume = 0;
  bool isLoopOne = false;

  SongPlayerCubit() : super(SongPlayerLoaded()) {
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSongPlayer();
    });

    audioPlayer.durationStream.listen((duration) {
      songDuration = duration!;
    });

    audioPlayer.play();

    songVolume = audioPlayer.volume;
  }

  void updateSongPlayer() {
    if (!isClosed) {
      emit(SongPlayerLoaded());
    }
  }

  Future<void> loadSong(String url) async {
    try {
      await audioPlayer.setUrl(url);
      emit(SongPlayerLoaded());
    } catch (e) {
      emit(SongPlayerFailure());
    }
  }

  Future<void> playOrPauseSong() async {
    if (audioPlayer.playing) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play();
    }

    emit(SongPlayerLoaded());
  }

  Future<void> changePlayPosition(double position) async {
    await audioPlayer.seek(Duration(seconds: position.toInt()));
  }

  Future<void> changeVolume(double volume) async {
    songVolume = volume;
    await audioPlayer.setVolume(volume);
  }

  Future<void> loopSong() async {
    isLoopOne = !isLoopOne;
    await audioPlayer.setLoopMode(isLoopOne ? LoopMode.one : LoopMode.off);
  }

  @override
  Future<void> close() async {
    await audioPlayer.dispose();
    return super.close();
  }
}

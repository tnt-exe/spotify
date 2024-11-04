import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/presentation/home/bloc/playlist_cubit.dart';
import 'package:spotify/presentation/home/bloc/playlist_state.dart';

class Playlist extends StatelessWidget {
  const Playlist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlaylistCubit()..getPlaylist(),
      child: BlocBuilder<PlaylistCubit, PlaylistState>(
        builder: (context, state) {
          if (state is PlaylistLoading) {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }

          if (state is PlaylistLoaded) {
            return const Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Playlist",
                    ),
                    Text(
                      "See more",
                    ),
                  ],
                ),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return Container();
  }
}

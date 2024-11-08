import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:spotify/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/domain/entities/song/song.dart';

class FavoriteButton extends StatelessWidget {
  final SongEntity songEntity;
  final Function? function;
  const FavoriteButton({
    super.key,
    this.function,
    required this.songEntity,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteButtonCubit(),
      child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
        builder: (context, state) {
          if (state is FavoriteButtonInit) {
            return IconButton(
              onPressed: () async {
                await context
                    .read<FavoriteButtonCubit>()
                    .favoriteButtonUpdate(songEntity.songId);

                if (function != null) {
                  function!();
                }
              },
              icon: Icon(
                songEntity.isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_outline_rounded,
                size: 25,
                color: AppColors.darkGrey,
              ),
            );
          }

          if (state is FavoriteButtonUpdate) {
            return IconButton(
              onPressed: () {
                context
                    .read<FavoriteButtonCubit>()
                    .favoriteButtonUpdate(songEntity.songId);
              },
              icon: Icon(
                state.isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_outline_rounded,
                size: 25,
                color: AppColors.darkGrey,
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}

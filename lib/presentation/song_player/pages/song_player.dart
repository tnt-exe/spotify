import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/common/helpers/responsive.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/favorite_button/favorite_button.dart';
import 'package:spotify/core/configs/constants/app_urls.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:spotify/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:spotify/presentation/song_player/bloc/song_player_state.dart';

enum SongPlayerMenu { changeMode }

class SongPlayer extends StatelessWidget {
  final SongEntity songEntity;
  const SongPlayer({
    super.key,
    required this.songEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: const Text(
          "Now playing",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        action: PopupMenuButton<SongPlayerMenu>(
          icon: const Icon(
            Icons.more_vert_rounded,
          ),
          offset: const Offset(0, 50),
          onSelected: (value) {
            if (value == SongPlayerMenu.changeMode) {
              context.read<ThemeCubit>().updateTheme(
                  context.isDarkMode ? ThemeMode.light : ThemeMode.dark);
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: SongPlayerMenu.changeMode,
              child: Row(
                children: [
                  Icon(
                    context.isDarkMode
                        ? Icons.light_mode_rounded
                        : Icons.dark_mode_rounded,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      context.isDarkMode ? "Light mode" : "Dark mode",
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: BlocProvider(
        create: (_) => SongPlayerCubit()
          ..loadSong(
            "${AppUrls.songFirestorage}${songEntity.title}${songEntity.type}${AppUrls.mediaAlt}",
          ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          child: Column(
            children: [
              _songCover(context),
              const SizedBox(
                height: 20,
              ),
              _songDetail(),
              const SizedBox(
                height: 30,
              ),
              _songPlayer(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    var heightSize = MediaQuery.of(context).size.height / 2.2;
    return Container(
      height: heightSize,
      width: heightSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(
            "${AppUrls.coverFirestorage}${songEntity.cover}${AppUrls.mediaAlt}",
          ),
        ),
      ),
    );
  }

  Widget _songDetail() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                songEntity.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                songEntity.artist,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          FavoriteButton(
            songEntity: songEntity,
          ),
        ],
      ),
    );
  }

  Widget _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return const CircularProgressIndicator();
        }

        if (state is SongPlayerLoaded) {
          return Column(
            children: [
              Slider(
                activeColor: AppColors.grey,
                min: 0,
                max: context
                    .read<SongPlayerCubit>()
                    .songDuration
                    .inSeconds
                    .toDouble(),
                value: context
                    .read<SongPlayerCubit>()
                    .songPosition
                    .inSeconds
                    .toDouble(),
                onChanged: (value) async {
                  await context
                      .read<SongPlayerCubit>()
                      .changePlayPosition(value);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDuration(
                        context.read<SongPlayerCubit>().songPosition),
                  ),
                  Text(
                    formatDuration(
                        context.read<SongPlayerCubit>().songDuration),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: context.isPhoneScreen
                    ? context.screenWidth
                    : context.responsiveScreenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await context.read<SongPlayerCubit>().loopSong();
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              context.read<SongPlayerCubit>().isLoopOne
                                  ? Icons.repeat_one_rounded
                                  : Icons.repeat_rounded,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await context.read<SongPlayerCubit>().playOrPauseSong();
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                        child: Icon(
                          context.read<SongPlayerCubit>().audioPlayer.playing
                              ? Icons.pause
                              : Icons.play_arrow,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            var volume =
                                context.read<SongPlayerCubit>().songVolume;

                            return StatefulBuilder(
                              builder: (_, setState) {
                                return SizedBox(
                                  height: 200,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 40,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            await context
                                                .read<SongPlayerCubit>()
                                                .changeVolume(0);
                                            setState(() {
                                              volume = 0;
                                            });
                                          },
                                          child: Icon(
                                            getVolumeIcon(volume),
                                          ),
                                        ),
                                        Expanded(
                                          child: Slider(
                                            activeColor: AppColors.grey,
                                            value: volume,
                                            onChanged: (value) async {
                                              await context
                                                  .read<SongPlayerCubit>()
                                                  .changeVolume(value);
                                              setState(() {
                                                volume = value;
                                              });
                                            },
                                          ),
                                        ),
                                        Text(
                                          formatVolume(volume),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          getVolumeIcon(
                            context.read<SongPlayerCubit>().songVolume,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        return Container();
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  String formatVolume(double volume) => (volume * 100).toInt().toString();

  IconData getVolumeIcon(double volume) {
    if (volume == 0) {
      return Icons.volume_off_rounded;
    }

    if (volume <= 0.5) {
      return Icons.volume_down_rounded;
    }

    return Icons.volume_up_rounded;
  }
}

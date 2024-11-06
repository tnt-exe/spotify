import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify/domain/entities/song/song.dart';

class SongModel {
  String? title;
  String? artist;
  Timestamp? releaseDate;
  num? duration;
  String? type;
  String? cover;

  SongModel({
    required this.title,
    required this.artist,
    required this.releaseDate,
    required this.duration,
    required this.type,
    required this.cover,
  });

  SongModel.fromJson(Map<String, dynamic> data) {
    title = data["title"];
    artist = data["artist"];
    releaseDate = data["releaseDate"];
    duration = data["duration"];
    type = data["type"];
    cover = data["cover"];
  }
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      title: title!,
      artist: artist!,
      releaseDate: releaseDate!,
      duration: duration!,
      type: type!,
      cover: cover!,
    );
  }
}

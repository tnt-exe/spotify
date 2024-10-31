import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity {
  final String title;
  final String artist;
  final Timestamp releaseDate;
  final num duration;

  SongEntity({
    required this.title,
    required this.artist,
    required this.releaseDate,
    required this.duration,
  });
}

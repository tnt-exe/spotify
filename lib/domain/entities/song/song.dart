import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity {
  final String title;
  final String artist;
  final Timestamp releaseDate;
  final num duration;
  final String type;
  final String cover;

  SongEntity({
    required this.title,
    required this.artist,
    required this.releaseDate,
    required this.duration,
    required this.type,
    required this.cover,
  });
}

import 'music.dart';

class Playlist {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<Music> songs;
  final DateTime createdAt;

  Playlist({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.songs,
    required this.createdAt,
  });

  int get totalDuration {
    return songs.fold(0, (sum, song) => sum + song.duration.inSeconds);
  }
}

class Music {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String imageUrl;
  final Duration duration;
  bool isFavorite;

  Music({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.imageUrl,
    required this.duration,
    this.isFavorite = false,
  });
}

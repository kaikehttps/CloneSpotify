import 'package:flutter/material.dart';
import 'package:programacaoparaaplicativosmoveis/services/music_service.dart';
import 'package:programacaoparaaplicativosmoveis/models/music.dart';

class FavoritesScreen extends StatefulWidget {
  final Function(Music) onPlayTrack;

  const FavoritesScreen({Key? key, required this.onPlayTrack})
    : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final MusicService _musicService = MusicService();

  @override
  Widget build(BuildContext context) {
    final favorites = _musicService.getFavoriteSongs();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Suas Músicas Favoritas',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${favorites.length} músicas',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          // Favorites list or empty state
          favorites.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 48),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 64,
                          color: Colors.grey[700],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Nenhuma música favorita ainda',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Adicione músicas aos seus favoritos',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final song = favorites[index];
                    return FavoriteSongTile(
                      song: song,
                      onPlay: () => widget.onPlayTrack(song),
                      onRemove: () {
                        setState(() {
                          _musicService.toggleFavorite(song);
                        });
                      },
                    );
                  },
                ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class FavoriteSongTile extends StatelessWidget {
  final Music song;
  final VoidCallback onPlay;
  final VoidCallback onRemove;

  const FavoriteSongTile({
    Key? key,
    required this.song,
    required this.onPlay,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPlay,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.withOpacity(0.1), Colors.grey[900]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.grey[800],
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Image.network(
                song.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[800],
                    child: const Icon(
                      Icons.music_note,
                      color: Colors.grey,
                      size: 24,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    song.artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.favorite, color: Colors.green, size: 20),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}

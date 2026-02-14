import 'package:flutter/material.dart';
import 'package:programacaoparaaplicativosmoveis/services/music_service.dart';
import 'package:programacaoparaaplicativosmoveis/models/playlist.dart';
import 'package:programacaoparaaplicativosmoveis/models/music.dart';

class HomeScreen extends StatefulWidget {
  final Function(Music) onPlayTrack;

  const HomeScreen({Key? key, required this.onPlayTrack}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MusicService _musicService = MusicService();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header com greeting
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bem-vindo ao Spotify',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Seus hits do momento',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          // Seção de playlists em destaque
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Playlists em Destaque',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: _musicService.getAllPlaylists().length,
              itemBuilder: (context, index) {
                final playlist = _musicService.getAllPlaylists()[index];
                return PlaylistCard(playlist: playlist, onTap: () {});
              },
            ),
          ),
          const SizedBox(height: 24),
          // Seção de músicas recentes
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Top Músicas',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: _musicService.getAllSongs().length,
            itemBuilder: (context, index) {
              final song = _musicService.getAllSongs()[index];
              return SongTile(
                song: song,
                onPlay: () => widget.onPlayTrack(song),
                onFavorite: () {
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

class PlaylistCard extends StatelessWidget {
  final Playlist playlist;
  final VoidCallback onTap;

  const PlaylistCard({Key? key, required this.playlist, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[800],
              ),
              child: Image.network(
                playlist.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[800],
                    child: const Icon(Icons.music_note, color: Colors.grey),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SongTile extends StatelessWidget {
  final Music song;
  final VoidCallback onPlay;
  final VoidCallback? onFavorite;

  const SongTile({
    Key? key,
    required this.song,
    required this.onPlay,
    this.onFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPlay,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.grey[800],
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
            Text(
              '${song.duration.inMinutes}:${(song.duration.inSeconds % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(width: 12),
            IconButton(
              icon: Icon(
                song.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: song.isFavorite ? Colors.green : Colors.grey,
                size: 20,
              ),
              onPressed: onFavorite,
            ),
          ],
        ),
      ),
    );
  }
}

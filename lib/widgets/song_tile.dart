import 'package:flutter/material.dart';
import '../models/music.dart';
import '../services/music_service.dart';

class SongTile extends StatefulWidget {
  final Music music;
  final VoidCallback? onTap;

  const SongTile({
    super.key,
    required this.music,
    this.onTap,
  });

  @override
  State<SongTile> createState() => _SongTileState();
}

class _SongTileState extends State<SongTile> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.music.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          image: DecorationImage(
            image: NetworkImage(widget.music.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        widget.music.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        widget.music.artist,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: IconButton(
        icon: Icon(
          _isFavorite ? Icons.favorite : Icons.favorite_border,
          color: _isFavorite ? const Color(0xFF1DB954) : Colors.grey,
        ),
        onPressed: () {
          setState(() {
            _isFavorite = !_isFavorite;
            MusicService().toggleFavorite(widget.music);
          });
        },
      ),
      onTap: widget.onTap,
      hoverColor: Colors.grey[800],
    );
  }
}

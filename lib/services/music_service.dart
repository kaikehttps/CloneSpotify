import '../models/music.dart';
import '../models/playlist.dart';

class MusicService {
  static final MusicService _instance = MusicService._internal();

  factory MusicService() {
    return _instance;
  }

  MusicService._internal();

  // Dados de exemplo
  late List<Music> _allSongs = [
    Music(
      id: '1',
      title: 'Radio/Video',
      artist: 'System Of Down',
      album: 'SOAD',
      imageUrl:
          'https://th.bing.com/th/id/OIP.1JqcSEyulxgVm5D8p3HvsQHaEo?w=286&h=180&c=7&r=0&o=7&pid=1.7&rm=3',
      duration: const Duration(minutes: 3, seconds: 20),
    ),
    Music(
      id: '2',
      title: 'A Little Piece Of Heaven',
      artist: 'Avenged Sevenfold',
      album: 'The Best of Avenged Sevenfold',
      imageUrl:
          'https://th.bing.com/th/id/R.5973f6961061d0ecfc48eb3182c9f552?rik=UwNl%2b9Ws3OrDVA&riu=http%3a%2f%2fwww.aceshowbiz.com%2fimages%2fnews%2favenged-sevenfold-announces-new-album-hail-to-the-king.jpg&ehk=%2f4RUNP5KP0gHtvQhlhiWJxWPJippMODHOV%2bPNywNkm4%3d&risl=&pid=ImgRaw&r=0',
      duration: const Duration(minutes: 8, seconds: 00),
    ),
    Music(
      id: '3',
      title: 'Aprendendo a mentir',
      artist: 'Selvagens à Procura de Lei',
      album: 'Aprendendo a Mentir',
      imageUrl:
          'https://i.scdn.co/image/ab67616d0000b273fa19846bd1d6def09a7748c9',
      duration: const Duration(minutes: 3, seconds: 23),
    ),
    Music(
      id: '4',
      title: 'The Great Gig In The Sky',
      artist: 'Pink Floyd',
      album: 'The Dark Side of the Moon',
      imageUrl:
          'https://thedali.org/wp-content/uploads/2024/09/Pink-Floyd_Banner_1200x500_v1.png',
      duration: const Duration(minutes: 3, seconds: 21),
    ),
    Music(
      id: '5',
      title: 'Delírios',
      artist: 'FBC',
      album: 'Baile',
      imageUrl:
          'https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/89/74/d7/8974d7f1-d285-2bdb-abbe-4f998ab57f67/0.jpg/1200x1200bf-60.jpg',
      duration: const Duration(minutes: 2, seconds: 47),
    ),

    Music(
      id: '6',
      title: 'Inúteis',
      artist: 'Ultraje a Rigor',
      album: '18 anos sem tirar!',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/pt/7/7b/Ultraje_a_Rigor_-_Sexo%21%21.jpg',
      duration: const Duration(minutes: 3, seconds: 15),
    ),
  ];
  late List<Playlist> _playlists = [
    Playlist(
      id: 'p1',
      name: 'Melhores do Rock',
      description: 'As 50 melhores do rock',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRr__v2QKkk9nO9clKK7_WsdVpYwrEfkxJ5KQ&s',
      songs: _allSongs.sublist(0, 3),
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    Playlist(
      id: 'p2',
      name: 'As músicas mais lindas do mundo',
      description: 'Os maiores sucessos mundiais',
      imageUrl:
          'https://i.pinimg.com/736x/0f/ff/1a/0fff1a837404ddc5cd67b0dac68cb3e3.jpg',
      songs: _allSongs.sublist(2, 5),
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
    Playlist(
      id: 'p3',
      name: 'Vibes Noturnas',
      description: 'Músicas para a noite',
      imageUrl: 'https://via.placeholder.com/200?text=Vibes+Noturnas',
      songs: _allSongs,
      createdAt: DateTime.now(),
    ),
  ];

  List<Music> getAllSongs() => _allSongs;

  List<Playlist> getAllPlaylists() => _playlists;

  List<Music> searchSongs(String query) {
    return _allSongs.where((song) {
      final titleMatch = song.title.toLowerCase().contains(query.toLowerCase());
      final artistMatch = song.artist.toLowerCase().contains(
        query.toLowerCase(),
      );
      return titleMatch || artistMatch;
    }).toList();
  }

  void toggleFavorite(Music music) {
    music.isFavorite = !music.isFavorite;
  }

  List<Music> getFavoriteSongs() {
    return _allSongs.where((song) => song.isFavorite).toList();
  }

  void addPlaylist(Playlist playlist) {
    _playlists.add(playlist);
  }

  void deletePlaylist(String playlistId) {
    _playlists.removeWhere((p) => p.id == playlistId);
  }
}

import 'package:flutter/material.dart';
import 'package:programacaoparaaplicativosmoveis/screens/home_screen.dart';
import 'package:programacaoparaaplicativosmoveis/screens/search_screen.dart';
import 'package:programacaoparaaplicativosmoveis/screens/library_screen.dart';
import 'package:programacaoparaaplicativosmoveis/screens/favorites_screen.dart';
import 'package:programacaoparaaplicativosmoveis/screens/player_screen.dart';
import 'package:programacaoparaaplicativosmoveis/models/music.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        colorScheme: ColorScheme.dark(
          primary: Colors.green,
          secondary: Colors.green,
          surface: Colors.grey[900]!,
          surfaceContainer: Colors.grey[800]!,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey[900],
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.green,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(onPlayTrack: _playTrack),
      SearchScreen(onPlayTrack: _playTrack),
      LibraryScreen(onPlayTrack: _playTrack),
      FavoritesScreen(onPlayTrack: _playTrack),
    ];
  }

  void _playTrack(Music song) {
    setState(() {
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayerScreen(
          song: song,
          onNext: _playNext,
          onPrevious: _playPrevious,
        ),
      ),
    ).then((_) {
      setState(() {});
    });
  }

  void _playNext() {
    // Implementar lógica de próxima música
  }

  void _playPrevious() {
    // Implementar lógica de música anterior
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Biblioteca',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}

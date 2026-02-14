import 'package:flutter/material.dart';
import 'package:programacaoparaaplicativosmoveis/models/music.dart';

class PlayerScreen extends StatefulWidget {
  final Music song;
  final Function()? onNext;
  final Function()? onPrevious;

  const PlayerScreen({
    Key? key,
    required this.song,
    this.onNext,
    this.onPrevious,
  }) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isPlaying = true;
  double _currentPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalSeconds = widget.song.duration.inSeconds.toDouble();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  'Now Playing',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.white, size: 24),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          // Album art with animation
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _animationController.value * 2 * 3.14159,
                      child: Container(
                        width: 280,
                        height: 280,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(140),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.5),
                              blurRadius: 30,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(140),
                          child: Image.network(
                            widget.song.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[800],
                                child: const Icon(
                                  Icons.music_note,
                                  size: 100,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          // Song info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.song.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.song.artist,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    widget.song.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: widget.song.isFavorite ? Colors.green : Colors.grey,
                    size: 28,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.song.isFavorite = !widget.song.isFavorite;
                    });
                  },
                ),
              ],
            ),
          ),
          // Progress bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Slider(
                  value: _currentPosition,
                  max: totalSeconds,
                  activeColor: Colors.green,
                  inactiveColor: Colors.grey[800],
                  onChanged: (value) {
                    setState(() {
                      _currentPosition = value;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(
                          Duration(seconds: _currentPosition.toInt()),
                        ),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        _formatDuration(widget.song.duration),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Player controls
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.shuffle, color: Colors.grey, size: 28),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.skip_previous,
                    color: Colors.white,
                    size: 32,
                  ),
                  onPressed: widget.onPrevious ?? () {},
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isPlaying = !_isPlaying;
                      if (_isPlaying) {
                        _animationController.repeat();
                      } else {
                        _animationController.stop();
                      }
                    });
                  },
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.5),
                          blurRadius: 15,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.black,
                      size: 32,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.skip_next,
                    color: Colors.white,
                    size: 32,
                  ),
                  onPressed: widget.onNext ?? () {},
                ),
                IconButton(
                  icon: const Icon(Icons.repeat, color: Colors.grey, size: 28),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          // Queue / Volume controls placeholder
          Padding(
            padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.queue_music, color: Colors.grey),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.devices, color: Colors.grey),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up, color: Colors.grey),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}

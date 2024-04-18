import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  // If the requirement is just to play a single video.
  final _controller = YoutubePlayerController.fromVideoId(
    videoId: 'XEBMqz_Yp2E',
    autoPlay: false,
    params: const YoutubePlayerParams(showFullscreenButton: true),
  );

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Видео Сабақ'),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              YoutubePlayer(
                controller: _controller,
                aspectRatio: 16 / 9,
              ),
              const Text(
                'Қайтымды және қайтымсыз процестер. Термодинамиканың екінші заңы.',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

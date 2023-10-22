import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


import 'package:cinema_pedia/domain/entities/video.dart';
import 'package:cinema_pedia/presentation/providers/movies/movies_repository_provider.dart';




final FutureProviderFamily<List<Video>, int> videosFromMovieProvider =
    FutureProvider.family((ref, int movieId) 
{

  final movieRepository = ref.watch(movieRepositoryProvider);
  return movieRepository.getYoutubeVideosById(movieId);

});




class VideosFromMovie extends ConsumerWidget {
  final int movieId;

  const VideosFromMovie({super.key, required this.movieId});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesFromVideo = ref.watch(videosFromMovieProvider(movieId));

    return moviesFromVideo.when(
      data: ( videos ) => _VideosList( videos: videos ),

      error: (_, __) =>
          const Center(child: Text('No se pudo cargar los vídeos de la película')),
      loading: () =>
          const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }

}



class _VideosList extends StatelessWidget {

  final List<Video> videos;

  const _VideosList({required this.videos });


  @override
  Widget build(BuildContext context) {

    // // movie does not have YT videos to play
    if ( videos.isEmpty ) {
      return const SizedBox();
    }

    // // there are videos
    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // ignore: prefer_const_constructors
          /* Label */
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Videos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ),

          /* videos */
          ...videos.map(
            (video) => _YouTubeVideoPlayer(youtubeId: videos.first.youtubeKey, name: video.name)
          ).toList()
        ],
      ),
      );
  }
}



class _YouTubeVideoPlayer extends StatefulWidget {

  final String youtubeId;
  final String name;

  const _YouTubeVideoPlayer({ required this.youtubeId, required this.name });


  @override
  State<_YouTubeVideoPlayer> createState() => _YouTubeVideoPlayerState();
}


class _YouTubeVideoPlayerState extends State<_YouTubeVideoPlayer> {

  late YoutubePlayerController _controller;  


  // // lifecycle
  @override
  void initState() {  // ngOnInit() :v
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),

      // // YouTube player (dep):
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(controller: _controller), 

        builder: (context, player) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(widget.name),
              player,
              const SizedBox(height: 20 ),
            ],
          );
        },
      ),
    );
  }
}

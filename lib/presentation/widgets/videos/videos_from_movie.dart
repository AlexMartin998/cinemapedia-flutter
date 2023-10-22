import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      data: (videos) => Container(
        color: Colors.red,
        margin: const EdgeInsetsDirectional.only(bottom: 50),

        child: SizedBox(
          height: 350,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: videos.map((e) => Text(e.name)).toList(),
          ),
        ),
      ),

      error: (_, __) =>
          const Center(child: Text('No se pudo cargar los vídeos de la película')),
      loading: () =>
          const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }

}

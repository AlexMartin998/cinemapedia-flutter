import 'package:cinema_pedia/domain/entities/video.dart';
import 'package:cinema_pedia/infrastructure/models/moviedb/moviedb_videos.dart';


class VideoMapper {

  static moviedbVideoToEntity( Result moviedbVideo ) => Video(
    id: moviedbVideo.id, 
    name: moviedbVideo.name, 
    youtubeKey: moviedbVideo.key,
    publishedAt: moviedbVideo.publishedAt
  );

}
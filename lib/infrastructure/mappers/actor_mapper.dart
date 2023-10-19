import 'package:cinema_pedia/domain/entities/actor.dart';
import 'package:cinema_pedia/infrastructure/models/moviedb/credits_response.dart';


class ActorMapper {

  static Actor castToEntity(Cast cast) => Actor(
    id: cast.id,
    name: cast.name,

    profilePath: cast.profilePath != null 
      ? 'https://image.tmdb.org/t/p/w500/${cast.profilePath}'
      : 'https://www.iprcenter.gov/image-repository/blank-profile-picture.png/@@images/image.png',

    character: cast.character,
  );

}
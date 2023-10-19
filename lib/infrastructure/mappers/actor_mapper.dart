import 'package:cinema_pedia/domain/entities/actor.dart';
import 'package:cinema_pedia/infrastructure/models/moviedb/credits_response.dart';


class ActorMapper {

  static Actor castToEntity(Cast cast) => Actor(
    id: cast.id,
    name: cast.name,

    profilePath: cast.profilePath != null 
      ? 'https://image.tmdb.org/t/p/w500/${cast.profilePath}'
      : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcGJegujCz3neLg3btfiVRfmV4dg52BBd38g&usqp=CAU',

    character: cast.character,
  );

}
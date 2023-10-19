import 'package:cinema_pedia/domain/entities/actor.dart';


// lo separo de Movie para q si despues no lo ocupo, lo remuva facil sin afectar nada
abstract class ActorsDatasource {

  Future<List<Actor>> getActorsByMovie(String movieId);

}
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movies_providers.dart';


// // // Provider para el loading general del Home
// // indica q todos tengan data
// solo lectura: solo quiero saber si esta en true/false
final initialLoadingProvider = Provider<bool>((ref) {
  final bool step1 = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final bool step2 = ref.watch(popularMoviesProvider).isEmpty;
  final bool step3 = ref.watch(upComingMoviesProvider).isEmpty;
  final bool step4 = ref.watch(topRatedMoviesProvider).isEmpty;

  if (step1 || step2 || step3 || step4) return true;

  return false; // terminamos de cargar
});

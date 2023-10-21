import 'package:card_swiper/card_swiper.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'package:cinema_pedia/domain/entities/movie.dart';


class MoviesSlideshow extends StatelessWidget {
  final List<Movie> movies;

  const MoviesSlideshow({super.key, required this.movies});


  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 210,
      width: double.infinity, // todo width disponible

      child: Swiper(  // slider/carrousel
        viewportFraction: 0.8, // ver fraccion del prev/next slide
        scale: 0.87, // scale prev/next slide
        autoplay: true,

        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0), // baje todo
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: colors.secondary
          )
        ),
      
        itemCount: movies.length,
        itemBuilder: (context, index) => _Slide(movie: movies[index]),
      ),
    );
  }
}



class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});


  @override
  Widget build(BuildContext context) {
    // Decoration Setup
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 10, // intensidad del difuminado
          offset: Offset(0, 10)
        )
      ]
    );

    return GestureDetector(
      // only onTap, so it actually allow scrolling
      onTap: () => context.push('/home/0/movie/${ movie.id }'),

      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
    
        child: DecoratedBox(
          decoration: decoration,
          child: ClipRRect( // w con borderRadious
            borderRadius: BorderRadius.circular(20),
    
            child: Stack(
              children: [
                FadeInImage(
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
                  image: NetworkImage(movie.backdropPath),
                ),
                /* Image.network(  // FadeInImage()
                  movie.backdropPath,
                  fit: BoxFit.cover,
                  width: double.infinity,
              
                  // saber cuando se construye la image
                  loadingBuilder: (context, child, loadingProgress) { // built in runtime
                    if(loadingProgress == null) return FadeIn(child: child); // ya la cargo x completo
                    
                    return const DecoratedBox(
                      decoration: BoxDecoration(color: Colors.black12),
                    );
                  },
                ), */
    
                _SlideLabel(
                  bottom: 12,
                  left: 12,
                  movie: movie,
                  child: Text(movie.title, style: const TextStyle(color: Colors.white)),
                ),
    
                _SlideLabel(
                  bottom: 12,
                  right: 12,
                  movie: movie,
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow, size: 14),
                      Text('${movie.voteAverage}', style: const TextStyle(color: Colors.white))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}

class _SlideLabel extends StatelessWidget {
  final Widget child;
  final double bottom;
  final double left;
  final double top;
  final double right;

  const _SlideLabel({
    required this.movie,
    required this.child,
    this.bottom = 0,
    this.right = 0,
    this.left = 0,
    this.top = 0,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top > 0 ? top : null,
      bottom: bottom > 0 ? bottom : null,
      right: right > 0 ? right : null,
      left: left > 0 ? left : null,

      child: ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: Container(
          color: Colors.black54,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: child,
        ),
      ),
    );
  }
}




import 'package:animate_do/animate_do.dart';
import 'package:cinema_pedia/config/helpers/human_formats.dart';
import 'package:cinema_pedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';


class MovieHorizontalListview extends StatelessWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  // infinite scroll
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview(
      {super.key,
      required this.movies,
      this.title,
      this.subTitle,
      this.loadNextPage});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(

        children: [
          if (title != null || subTitle != null)
            _Title(title: title, subTitle: subTitle),

          // listView req 1 size especifico
          Expanded(
            child: ListView.builder( // lazy & built in runtime
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(), // rebote ios/android

              itemBuilder: (context, index) {
                return _Slide(movie: movies[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}


class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});


  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return SingleChildScrollView( // fix screen overflow
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8), // seguir haciendo scroll
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* Image */
            SizedBox(
              width: 150,
              child: ClipRRect( // w borderradious
                borderRadius: BorderRadius.circular(20),
    
                child: Image.network(
                  movie.posterPath,
                  width: 150,  // like skeleton to prevent splits
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if(loadingProgress == null) return FadeIn(child: child);
                    
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 21),
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2.7)
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 6),
          
            /* Title */
            SizedBox(
              width: 150,
              child: Text(movie.title, maxLines: 2, style: textStyles.titleSmall),
            ),
    
            /* Rating */
            SizedBox(
              width: 150, // Spacer requires it

              child: Row(
                children: [
                  Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
                  const SizedBox(width: 3),
                  Text(
                    '${movie.voteAverage}',
                    style: textStyles.bodyMedium?.copyWith(color: Colors.yellow.shade800)
                  ),
            
                  const Spacer(),

                  Text(
                    HumanFormats.number(movie.popularity),
                    style: textStyles.bodySmall,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const _Title({this.title, this.subTitle});


  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 18, 0, 3),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null) Text(title!, style: titleStyle),

          const Spacer(), // like flex 1

          if (subTitle != null) FilledButton.tonal(
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
            onPressed: (){},
            child: Text(subTitle!),
          ),
        ],
      ),
    );
  }
}

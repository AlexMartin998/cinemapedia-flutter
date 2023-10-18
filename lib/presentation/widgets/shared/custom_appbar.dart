import 'package:flutter/material.dart';


class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});


  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 9),

        child: SizedBox(
          width: double.infinity, // todo el width q se pueda

          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: color.primary),
              const SizedBox(width: 5),
              Text('Cinemapedia', style: titleStyle),

              const Spacer(), // like flex 1
              IconButton(
                onPressed: (){},
                icon: const Icon(Icons.search)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
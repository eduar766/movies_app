import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/search/search_delegate.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en Cine'),
        actions: [
          IconButton(
            onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()), 
            icon: const Icon(Icons.search_outlined)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            MovieSlider(
              movies: moviesProvider.popularMovies,
              title: 'Populares',
              onNextPage: () => moviesProvider.getPopularMovies(),
            ),
            const SizedBox(height: 25,),
            MovieSlider(
              movies: moviesProvider.upcomingMovies,
              title: 'Próximos Estrenos',
              onNextPage: () => moviesProvider.getUpcomingMovies(),
            ),
            const SizedBox(height: 25,),
            MovieSlider(
              movies: moviesProvider.topMovies,
              title: 'Mejor Valoradas',
              onNextPage: () => moviesProvider.getTopRated(),
            ),
          ],
        ),
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:movie_list_app/common/icons/tv_mini_icons_icons.dart';
import 'package:movie_list_app/common/theme/app_theme.dart';
import 'package:movie_list_app/data/movie/model/header_movie.dart';
import 'package:movie_list_app/presentation/widget/movie/numbered_movie_card.dart';
import 'package:provider/provider.dart';

import 'package:movie_list_app/common/theme/app_colors.dart';
import 'package:movie_list_app/di/di.dart';
import 'package:movie_list_app/domain/movie/entity/movie.dart';
import 'package:movie_list_app/presentation/bloc/movie_list_bloc.dart';
import 'package:movie_list_app/presentation/widget/button/elevated_button/custom_button.dart';
import 'package:movie_list_app/presentation/widget/movie/movie_card.dart';

class MovieListScreen extends StatelessWidget {
  static const routeName = '/main';

  const MovieListScreen({super.key});

  static const List<IconData> iconList = [
    TvMiniIcons.search,
    TvMiniIcons.home,
    TvMiniIcons.movies,
    TvMiniIcons.television,
    TvMiniIcons.favorite,
    TvMiniIcons.profile,
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<MovieListBloc>(
            create: (_) => getIt<MovieListBloc>(),
            dispose: (_, bloc) => bloc.dispose(),
          )
        ],
        child: Consumer<MovieListBloc>(builder: (context, movieListBloc, _) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: _buildBody(context, movieListBloc),
          );
        }));
  }

  Widget _buildBody(BuildContext context, MovieListBloc movieListBloc) {
    return StreamBuilder<HeaderMovie?>(
        stream: movieListBloc.headerMovieStream,
        builder: (context, snapshot) {
          final HeaderMovie? headerMovie = snapshot.data;

          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                      child: _buildHeader(
                    context,
                    movieListBloc,
                    headerMovie,
                  )),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 118, bottom: 12, top: 50),
                      child: Text(
                        'Лучшие фильмы за всё время',
                        style: AppTheme.defaults().textTheme.titleMedium,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _buildMovieList(movieListBloc, headerMovie),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 30,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 118.5, vertical: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ShaderMask(
                              shaderCallback: (Rect rect) {
                                return AppColors.purpleBlueGradient.createShader(rect);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text('ТОП-100', style: AppTheme.defaults().textTheme.labelMedium),
                              )),
                          Text('популярных фильмов', style: AppTheme.defaults().textTheme.titleMedium)
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _buildMovieTop(movieListBloc, headerMovie),
                  ),
                ],
              ),
              _panelMenu(movieListBloc),
            ],
          );
        });
  }

  Widget _buildHeader(BuildContext context, MovieListBloc movieListBloc, HeaderMovie? headerMovie) {
    return Builder(builder: (context) {
      if (headerMovie != null) {
        return Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            ShaderMask(
              blendMode: BlendMode.darken,
              shaderCallback: (Rect rect) {
                return const LinearGradient(
                  colors: [Colors.transparent, AppColors.background],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ).createShader(rect);
              },
              child: ShaderMask(
                blendMode: BlendMode.darken,
                shaderCallback: (Rect rect) {
                  return const LinearGradient(
                    colors: [Colors.transparent, AppColors.background],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ).createShader(rect);
                },
                child: Image.network(
                  headerMovie.posterUrl,
                  width: 625,
                  height: 400,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Positioned(
                child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 450,
                    child: Text(
                      '${headerMovie.description}',
                      maxLines: 5,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.defaults().textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _changeSectionButtons(
                    context,
                    movieListBloc,
                  ),
                ],
              ),
            )),
          ],
        );
      }

      return const Center(child: CircularProgressIndicator());
    });
  }

  Widget _tvMiniIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Icon(
        icon,
        color: Colors.grey,
        size: 22,
      ),
    );
  }

  Widget _buildMovieList(MovieListBloc movieListBloc, HeaderMovie? selectedMovie) {
    return StreamBuilder<List<MovieEntity>>(
        stream: movieListBloc.bestMoviesStream,
        builder: (context, snapshot) {
          final List<MovieEntity> movieList = snapshot.data ?? [];

          return SizedBox(
            height: 400,
            child: CustomScrollView(
              controller: movieListBloc.bestMoviesScrollController,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              scrollDirection: Axis.horizontal,
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(
                    width: 107.5,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 11),
                        child: MovieCard(
                          onTap: () async {
                            await movieListBloc.fetchMovieAtId(movieList[index].filmId);
                          },
                          movie: movieList[index],
                          poster: movieListBloc.getPoster(movieList[index]),
                          isSelected: movieList[index].filmId == selectedMovie?.kinopoiskId,
                        ),
                      );
                    },
                    childCount: movieList.length,
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _buildMovieTop(MovieListBloc movieListBloc, HeaderMovie? selectedMovie) {
    return StreamBuilder<List<MovieEntity>>(
        stream: movieListBloc.popularMoviesStream,
        builder: (context, snapshot) {
          final List<MovieEntity> movieList = snapshot.data ?? [];
          return SizedBox(
            height: 300,
            child: CustomScrollView(
              controller: movieListBloc.popularMoviesScrollController,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              scrollDirection: Axis.horizontal,
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(
                    width: 108,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: NumberedMovieCard(
                          onTap: () async {
                            await movieListBloc.fetchMovieAtId(movieList[index].filmId);
                          },
                          movie: movieList[index],
                          number: index + 1,
                          poster: movieListBloc.getPoster(movieList[index]),
                          isSelected: movieList[index].filmId == selectedMovie?.kinopoiskId,
                        ),
                      );
                    },
                    childCount: movieList.length,
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _changeSectionButtons(BuildContext context, MovieListBloc movieListBloc) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          title: 'Смотреть',
          gradient: AppColors.purpleBlueGradient,
        ),
        SizedBox(width: 12),
        CustomButton(
          title: 'О фильме',
          buttonColor: AppColors.dark,
        ),
      ],
    );
  }

  Widget _panelMenu(MovieListBloc movieListBloc) {
    return StreamBuilder<bool>(
        stream: movieListBloc.hidePanelFlagStream,
        builder: (context, snapshot) {
          final bool hidePanelFlag = snapshot.data ?? false;
          return Positioned(
              top: 20,
              left: 32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Image.asset(
                    "assets/icon/icon_app.png",
                    height: 25,
                    width: 72,
                  ),
                  const SizedBox(height: 55),
                  Builder(builder: (context) {
                    if (hidePanelFlag) {
                      return Column(
                        children: [
                          ...iconList.map((e) => _tvMiniIcon(e)).toList(),
                          const SizedBox(height: 23),
                          GestureDetector(
                            onTap: () {
                              movieListBloc.changeFlag(hidePanelFlag);
                            },
                            child: _tvMiniIcon(TvMiniIcons.up_arrow),
                          ),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            movieListBloc.changeFlag(hidePanelFlag);
                          },
                          child: _tvMiniIcon(Icons.arrow_downward),
                        ),
                      ],
                    );
                  })
                ],
              ));
        });
  }
}

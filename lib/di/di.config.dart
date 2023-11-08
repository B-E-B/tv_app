// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/movie/datasource/movie_datasource.dart' as _i3;
import '../data/movie/datasource/movie_datasource_impl.dart' as _i4;
import '../domain/movie/repository/movie_repository.dart' as _i5;
import '../domain/movie/repository/movie_repository_impl.dart' as _i6;
import '../domain/movie/usecase/fetch_best_movies_usecase.dart' as _i7;
import '../domain/movie/usecase/fetch_popular_movie_at_id_usecase.dart' as _i8;
import '../domain/movie/usecase/fetch_popular_movies_usecase.dart' as _i9;
import '../presentation/bloc/movie_list_bloc.dart' as _i10;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.singleton<_i3.MovieDataSourceRemote>(_i4.MovieDataSourceRemoteImpl());
  gh.singleton<_i5.MovieRepository>(
      _i6.MovieRepositoryImpl(gh<_i3.MovieDataSourceRemote>()));
  gh.singleton<_i7.FetchBestMoviesUseCase>(
      _i7.FetchBestMoviesUseCase(gh<_i5.MovieRepository>()));
  gh.singleton<_i8.FetchPopularMovieAtIdUseCase>(
      _i8.FetchPopularMovieAtIdUseCase(gh<_i5.MovieRepository>()));
  gh.singleton<_i9.FetchPopularMoviesUseCase>(
      _i9.FetchPopularMoviesUseCase(gh<_i5.MovieRepository>()));
  gh.factory<_i10.MovieListBloc>(() => _i10.MovieListBloc(
        gh<_i9.FetchPopularMoviesUseCase>(),
        gh<_i7.FetchBestMoviesUseCase>(),
        gh<_i8.FetchPopularMovieAtIdUseCase>(),
      ));
  return getIt;
}

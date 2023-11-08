import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_list_app/data/movie/model/header_movie.dart';
import 'package:movie_list_app/domain/movie/usecase/fetch_best_movies_usecase.dart';
import 'package:movie_list_app/domain/movie/usecase/fetch_popular_movie_at_id_usecase.dart';
import 'package:rxdart/rxdart.dart';

import 'package:movie_list_app/domain/movie/entity/movie.dart';
import 'package:movie_list_app/domain/movie/usecase/fetch_popular_movies_usecase.dart';

@injectable
class MovieListBloc {
  final BehaviorSubject<List<MovieEntity>> _bestMoviesSubject = BehaviorSubject.seeded([]);
  final BehaviorSubject<List<MovieEntity>> _popularMoviesSubject = BehaviorSubject.seeded([]);
  final BehaviorSubject<HeaderMovie?> _headerMovieSubject = BehaviorSubject();
  final BehaviorSubject<bool> _hidePanelFlag = BehaviorSubject.seeded(false);

  final FetchPopularMoviesUseCase _fetchPopularMoviesUseCase;
  final FetchBestMoviesUseCase _fetchBestMoviesUseCase;
  final FetchPopularMovieAtIdUseCase _fetchPopularMovieAtIdUseCase;

  final ScrollController _bestMoviesScrollController = ScrollController();
  final ScrollController _popularMoviesScrollController = ScrollController();

  Stream<List<MovieEntity>> get popularMoviesStream => _popularMoviesSubject.stream;

  Stream<List<MovieEntity>> get bestMoviesStream => _bestMoviesSubject.stream;

  Stream<HeaderMovie?> get headerMovieStream => _headerMovieSubject.stream;

  Stream<bool> get hidePanelFlagStream => _hidePanelFlag.stream;

  ScrollController get popularMoviesScrollController => _popularMoviesScrollController;

  ScrollController get bestMoviesScrollController => _bestMoviesScrollController;

  int _currentPopularMoviesPage = 1;
  int _currentBestMoviesPage = 1;

  MovieListBloc(
    this._fetchPopularMoviesUseCase,
    this._fetchBestMoviesUseCase,
    this._fetchPopularMovieAtIdUseCase,
  ) {
    _popularMoviesScrollController.addListener(_popularHandleScroll);
    _bestMoviesScrollController.addListener(_bestHandleScroll);
    _fetchPopularMovies(_currentPopularMoviesPage);
    _fetchBestMovies(_currentBestMoviesPage);
  }

  Future<void> _popularHandleScroll() async {
    if (_popularMoviesScrollController.position.pixels == _popularMoviesScrollController.position.maxScrollExtent) {
      await _fetchNextPopularMoviesPage();
    }
  }

  Future<void> _bestHandleScroll() async {
    if (_bestMoviesScrollController.position.pixels == _bestMoviesScrollController.position.maxScrollExtent) {
      await _fetchNextBestMoviesPage();
    }
  }

  Future<void> _fetchPopularMovies(int page) async {
    _fetchPopularMoviesUseCase(page).fold(
      (failure) {
        if (kDebugMode) {
          print(" ${failure.message}");
        }
      },
      (popularMovies) async {
        final movies = await popularMovies;
        if (_currentPopularMoviesPage > 1) {
          _popularMoviesSubject.add(_popularMoviesSubject.value..addAll(movies));
        } else {
          _popularMoviesSubject.add(movies);
          fetchMovieAtId(movies[0].filmId);
        }
      },
    );
  }

  Future<void> _fetchBestMovies(int page) async {
    _fetchBestMoviesUseCase(page).fold(
      (failure) {
        if (kDebugMode) {
          print(" ${failure.message}");
        }
      },
      (bestMovies) async {
        final movies = await bestMovies;
        if (_currentBestMoviesPage > 1) {
          _bestMoviesSubject.add(_bestMoviesSubject.value..addAll(movies));
        } else {
          _bestMoviesSubject.add(movies);
        }
      },
    );
  }

  Future<void> fetchMovieAtId(int filmId) async {
    _fetchPopularMovieAtIdUseCase(filmId).fold(
      (failure) {
        if (kDebugMode) {
          print(" ${failure.message}");
        }
      },
      (futureMovie) async {
        final movie = await futureMovie;
        _headerMovieSubject.add(movie);
      },
    );
  }

  Future<void> _fetchNextPopularMoviesPage() async {
    _currentPopularMoviesPage++;
    await _fetchPopularMovies(_currentPopularMoviesPage);
  }

  Future<void> _fetchNextBestMoviesPage() async {
    _currentBestMoviesPage++;
    await _fetchBestMovies(_currentBestMoviesPage);
  }

  ImageProvider getPoster(MovieEntity movie) {
    return NetworkImage(movie.posterUrlPreview);
  }

  void changeFlag(bool panelState) {
    _hidePanelFlag.add(!panelState);
  }

  dispose() {
    _popularMoviesSubject.close();
    _bestMoviesSubject.close();
    _hidePanelFlag.close();
    _headerMovieSubject.close();
    _popularMoviesScrollController.removeListener(_popularHandleScroll);
    _bestMoviesScrollController.removeListener(_bestHandleScroll);
    _popularMoviesScrollController.dispose();
    _bestMoviesScrollController.dispose();
  }
}

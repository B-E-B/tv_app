import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:movie_list_app/common/theme/app_theme.dart';
import 'package:movie_list_app/di/di.dart';
import 'package:movie_list_app/presentation/screen/movie_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies(Environment.dev);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Твоё Лайв',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.defaults(),
      initialRoute: MovieListScreen.routeName,
      routes: {
        MovieListScreen.routeName: (context) => const MovieListScreen(),
      },
    );
  }
}

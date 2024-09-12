import 'package:flutter/material.dart';
import 'package:repository_pattern/data/datasources/remote_data_source.dart';
import 'package:repository_pattern/presentation/screens/home_screen.dart';
import 'package:repository_pattern/presentation/screens/splash_screen.dart';

import '../data/repositories/user_repository.dart';

class AppPages {
  static const initial = SplashScreen.routeName;
  static const home = HomeScreen.routeName;

  static Map<String, WidgetBuilder> routes = {
    SplashScreen.routeName: (context) => const SplashScreen(),
    HomeScreen.routeName: (context) => HomeScreen(
          userRepository: UserRepositoryImpl(
            remoteDataSource: RemoteDataSource(),
          ),
        ),
  };
}

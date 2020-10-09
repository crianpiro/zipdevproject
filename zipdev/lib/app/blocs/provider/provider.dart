
import 'package:zipdev/app/blocs/detail_bloc.dart';
import 'package:zipdev/app/blocs/home_bloc.dart';
import 'package:zipdev/app/blocs/signIn_bloc.dart';
import 'package:zipdev/app/blocs/splash_bloc.dart';

import 'bloc.dart';
import 'bloc_cache.dart';

class Provider {
  static T of<T extends Bloc>(Function instance) {
    switch (T) {
      case DetailBloc:
        {
          return BlocCache.getBlocInstance("DetailBloc", instance);
        }
      case HomeBloc:
        {
          return BlocCache.getBlocInstance("HomeBloc", instance);
        }
      case SignInBloc:
        {
          return BlocCache.getBlocInstance("SignInBloc", instance);
        }
      case SplashBloc:
        {
          return BlocCache.getBlocInstance("SplashBloc", instance);
        }
    }
    return null;
  }

  static void dispose<T extends Bloc>() {
    switch (T) {
      case DetailBloc:
        {
          BlocCache.dispose("DetailBloc");
          break;
        }
      case HomeBloc:
        {
          BlocCache.dispose("HomeBloc");
          break;
        }
      case SplashBloc:
        {
          BlocCache.dispose("SplashBloc");
          break;
        }
      case SignInBloc:
        {
          BlocCache.dispose("SignInBloc");
          break;
        }
    }
  }
}

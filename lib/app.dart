import 'package:authentication_repository/authentication_repostitory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/authentication/bloc/authentication_bloc_bloc.dart';
import 'package:login_app/home/view/home_page.dart';
import 'package:login_app/login/view/login_page.dart';
import 'package:login_app/splash/splash.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;

  @override
  void initState() {
    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository();
    super.initState();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: _authenticationRepository,
        child: BlocProvider(
          create: (_) => AuthenticationBlocBloc(
              authenticationRepository: _authenticationRepository,
              userRepository: _userRepository),
          child: AppView(),
        ));
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBlocBloc, AuthenticationBlocState>(
            listener: (context, state) {
          switch (state.status) {
            case AuthenticationStatus.unknown:
              break;
            case AuthenticationStatus.authenticated:
              _navigator.pushAndRemoveUntil(HomePage.route(), (route) => false);
            case AuthenticationStatus.unauthenticated:
              _navigator.pushAndRemoveUntil(
                  LoginPage.route(), (route) => false);
          }
          
        },child: child,);
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}

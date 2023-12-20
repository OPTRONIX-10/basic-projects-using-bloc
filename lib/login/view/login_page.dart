import 'package:authentication_repository/authentication_repostitory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/login/bloc/login_bloc.dart';
import 'package:login_app/login/view/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

   static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(create: (context)=>LoginBloc(
        authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context)
      ),child: LoginForm(),),
    );
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spider_learnings_bloc_pattern/pages/register/bloc/register_blocs.dart';
import 'package:spider_learnings_bloc_pattern/pages/signIn/bloc/signin_blocs.dart';
import 'package:spider_learnings_bloc_pattern/pages/welcome/bloc/welcom_blocs.dart';

class AppBlocProviders {
  static get allBlocProviders => [
        BlocProvider(
          create: (context) => WelcomeBloc(),
        ),
        BlocProvider(
          create: (context) => SignInBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBlocs(),
        ),
      ];
}

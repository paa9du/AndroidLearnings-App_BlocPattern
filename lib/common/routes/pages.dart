import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spider_learnings_bloc_pattern/common/routes/names.dart';
import 'package:spider_learnings_bloc_pattern/pages/HomePage/home_page.dart';
import 'package:spider_learnings_bloc_pattern/pages/HomePage/bloc/home_page_blocs.dart';
import 'package:spider_learnings_bloc_pattern/pages/application/application_page.dart';
import 'package:spider_learnings_bloc_pattern/pages/application/bloc/app_blocs.dart';
import 'package:spider_learnings_bloc_pattern/pages/profile/settings/bloc/settings_blocs.dart';
import 'package:spider_learnings_bloc_pattern/pages/profile/settings/settings_page.dart';
import 'package:spider_learnings_bloc_pattern/pages/register/bloc/register_blocs.dart';
import 'package:spider_learnings_bloc_pattern/pages/register/register.dart';
import 'package:spider_learnings_bloc_pattern/pages/signIn/bloc/signin_blocs.dart';
import 'package:spider_learnings_bloc_pattern/pages/signIn/sign_in.dart';
import 'package:spider_learnings_bloc_pattern/pages/welcome/bloc/welcom_blocs.dart';
import 'package:spider_learnings_bloc_pattern/pages/welcome/welcome.dart';

import '../../global.dart';

class AppPages {
  static List<PageEntity> routes() {
    return [
      PageEntity(
        route: AppRoutes.INITIAL,
        page: Welcome(),
        bloc: BlocProvider(
          create: (_) => WelcomeBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.INITIAL,
        page: Welcome(),
        bloc: BlocProvider(
          create: (_) => WelcomeBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.Sign_In,
        page: SignIn(),
        bloc: BlocProvider(
          create: (_) => SignInBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.REGISTER,
        page: Register(),
        bloc: BlocProvider(
          create: (_) => RegisterBlocs(),
        ),
      ),
      PageEntity(
        route: AppRoutes.APPLICATION,
        page: ApplicationPage(),
        bloc: BlocProvider(
          create: (_) => AppBlocs(),
        ),
      ),
      PageEntity(
        route: AppRoutes.HOME_PAGE,
        page: HomePage(),
        bloc: BlocProvider(
          create: (_) => HomePageBlocs(),
        ),
      ),
      PageEntity(
        route: AppRoutes.SETTINGS,
        page: SettingsPage(),
        bloc: BlocProvider(
          create: (_) => SettingsBlocs(),
        ),
      ),
    ];
  }

//return all the bloc providers
  static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in routes()) {
      blocProviders.add(bloc.bloc);
    }
    return blocProviders;
  }

//a model that covers  entire screen as we click on navigator object
  static MaterialPageRoute GenerateRouteSettings(RouteSettings settings) {
    if (settings != null) {
      //check for route name matching with navigator gets triggered
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        print("first log");
        print(result.first.route);
        bool deviceFirstOpen = Global.storageService.getDeviceFirstOpen();
        if (result.first.route == AppRoutes.INITIAL && deviceFirstOpen) {
          bool isLoggedin = Global.storageService.getIsloggedIn();
          if (isLoggedin) {
            return MaterialPageRoute(
                builder: (_) => ApplicationPage(), settings: settings);
          }
          print("Second log");
          return MaterialPageRoute(
              builder: (_) => SignIn(), settings: settings);
        }
        print("valid route name ${settings.name}");
        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
      }
    }
    print("inValid route name ${settings.name}");
    return MaterialPageRoute(builder: (_) => SignIn(), settings: settings);
  }
}

//unify blocprovider and routes and pages
class PageEntity {
  String route;
  Widget page;
  dynamic bloc;

  PageEntity({required this.route, required this.page, this.bloc});
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:spider_learnings_bloc_pattern/common/values/colors.dart';
import 'package:spider_learnings_bloc_pattern/pages/application/application_page.dart';
import 'package:spider_learnings_bloc_pattern/pages/block_providers.dart';
import 'package:spider_learnings_bloc_pattern/pages/register/register.dart';
import 'package:spider_learnings_bloc_pattern/pages/signIn/bloc/signin_blocs.dart';
import 'package:spider_learnings_bloc_pattern/pages/signIn/sign_in.dart';
import 'package:spider_learnings_bloc_pattern/pages/welcome/bloc/welcom_blocs.dart';
import 'package:spider_learnings_bloc_pattern/pages/welcome/welcome.dart';
import 'package:firebase_core/firebase_core.dart';

import 'common/routes/routes.dart';
import 'global.dart';

Future<void> main() async {
  await Global.init();
  runApp(const MyApp());
  Fluttertoast.showToast(
    msg: "",
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        // BlocProvider(
        //   create: (context) => WelcomeBloc(),
        MultiBlocProvider(
      providers: [...AppPages.allBlocProviders(context)],
      child: ScreenUtilInit(
        designSize: Size(375, 812),
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(color: AppColors.primaryText),
                elevation: 0,
                backgroundColor: Colors.white),
          ),
          onGenerateRoute: AppPages.GenerateRouteSettings,
          initialRoute: AppRoutes.INITIAL,
          // home: ApplicationPage(),
          //  initialRoute: "/",
          // routes: {
          //   "signIn": (context) => SignIn(),
          //   "register": (context) => Register(),
          // },
        ),
      ),
    );
  }
}

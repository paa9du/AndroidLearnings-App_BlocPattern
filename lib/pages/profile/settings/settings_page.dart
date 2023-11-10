import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spider_learnings_bloc_pattern/common/routes/routes.dart';
import 'package:spider_learnings_bloc_pattern/common/values/constant.dart';
import 'package:spider_learnings_bloc_pattern/global.dart';
import 'package:spider_learnings_bloc_pattern/pages/application/bloc/app_blocs.dart';
import 'package:spider_learnings_bloc_pattern/pages/application/bloc/app_events.dart';
import 'package:spider_learnings_bloc_pattern/pages/profile/settings/bloc/settings_blocs.dart';
import 'package:spider_learnings_bloc_pattern/pages/profile/settings/bloc/settings_states.dart';
import 'package:spider_learnings_bloc_pattern/pages/profile/settings/widgets/settings_widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void removeUserData() {
    //when login back the index should be zero . -> means app should be open at home page
    context.read<AppBlocs>().add(TriggerAppEvent(0));
    Global.storageService.remove(AppConstants.STORAGE_USER_TOKEN_KEY);
    Global.storageService.remove(AppConstants.STORAGE_USER_PROFILE_KEY);

    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoutes.Sign_In, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: BlocBuilder<SettingsBlocs, SettingsStates>(
          builder: (context, state) {
            return Column(
              children: [
                SettingsButton(context, removeUserData),
              ],
            );
          },
        ),
      ),
    );
  }
}

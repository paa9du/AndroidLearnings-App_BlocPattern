import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/widgets/base_text_widget.dart';

AppBar buildAppBar() {
  return AppBar(
    title: Container(
      child: Container(
        child: reusabaleText("Settings"),
      ),
    ),
  );
}

Widget SettingsButton(BuildContext context, void Function()? func) {
  return GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Confirm logout",
            ),
            content: Text("Confirm logout"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Cancel",
                ),
              ),
              TextButton(
                onPressed: func,
                child: Text(
                  "Confirm",
                ),
              ),
            ],
          );
        },
      );
    },
    child: Container(
      height: 100.w,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: AssetImage(
            "assets/icons/Logout.png",
          ),
        ),
      ),
    ),
  );
}

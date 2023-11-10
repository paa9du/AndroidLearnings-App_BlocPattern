import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spider_learnings_bloc_pattern/common/values/colors.dart';
import 'package:spider_learnings_bloc_pattern/common/values/constant.dart';
import 'package:spider_learnings_bloc_pattern/main.dart';
import 'package:spider_learnings_bloc_pattern/pages/welcome/bloc/welcom_blocs.dart';
import 'package:spider_learnings_bloc_pattern/pages/welcome/bloc/welcome_events.dart';

import '../../global.dart';
import 'bloc/welcome_states.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 34.h),
      color: Colors.white,
      child: Scaffold(body: BlocBuilder<WelcomeBloc, WelcomeState>(
        builder: (context, state) {
          return Container(
            width: 375.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    state.page = index;
                    BlocProvider.of<WelcomeBloc>(context).add(WelcomeEvent());
                  },
                  children: [
                    _page(
                        1,
                        context,
                        "Next",
                        'First See Learning',
                        'Forget about a for of paper all knowledge in one Language!',
                        "assets/images/reading.png"),
                    _page(
                        2,
                        context,
                        "Next",
                        'Connect With Everyone',
                        'Always keep in touch with your tutor & friend.Let`s get connected',
                        "assets/images/boy.png"),
                    _page(
                        3,
                        context,
                        "Get Started",
                        'Always Fascinated Learning',
                        'Anywhere, anytime.The time is at our discrtion so study whenever you want.',
                        "assets/images/man.png"),
                  ],
                ),
                Positioned(
                  bottom: 100.h,
                  child: DotsIndicator(
                    position: state.page,
                    mainAxisAlignment: MainAxisAlignment.center,
                    dotsCount: 3,
                    decorator: DotsDecorator(
                      color: Colors.grey,
                      activeColor: Colors.blue,
                      size: Size.square(8.0),
                      activeSize: Size(18.0, 8.0),
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      )),
    );
  }

  Widget _page(int index, BuildContext context, String buttonName, String title,
      String subTitle, String imagePath) {
    return Column(
      children: [
        SizedBox(
          width: 345.w,
          height: 345.w,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          child: Text(
            title,
            style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 24.sp,
                fontWeight: FontWeight.normal),
          ),
        ),
        Container(
          width: 375.w,
          padding: EdgeInsets.only(
            left: 30.w,
            right: 30.w,
          ),
          child: Text(
            subTitle,
            style: TextStyle(
                color: AppColors.primarySecondaryElementText,
                fontSize: 13.sp,
                fontWeight: FontWeight.normal),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (index < 3) {
              pageController.animateToPage(index,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.decelerate);
            } else {
              print("-1");
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => MyHomePage(title: 'hai'),
              // ));
              Global.storageService
                  .setBool(AppConstants.STORAGE_DVICE_OPEN_FIRST_TIME, true);
              print(
                  "The value is ${Global.storageService.getDeviceFirstOpen()}");
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/sign_in", (route) => false);
            }
          },
          child: Container(
            margin: EdgeInsets.only(top: 100.h, left: 25.w, right: 25.w),
            width: 325.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  15.w,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Text(
                buttonName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

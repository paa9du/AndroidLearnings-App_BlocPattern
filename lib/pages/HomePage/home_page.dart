import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spider_learnings_bloc_pattern/common/values/colors.dart';
import 'package:spider_learnings_bloc_pattern/pages/HomePage/bloc/home_page_blocs.dart';
import 'package:spider_learnings_bloc_pattern/pages/HomePage/bloc/home_page_states.dart';
import 'package:spider_learnings_bloc_pattern/pages/HomePage/widgets/home_page_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(),
        body: BlocBuilder<HomePageBlocs, HomePageStates>(
          builder: (context, state) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 25.w),
              child: CustomScrollView(
                //  crossAxisAlignment: CrossAxisAlignment.start,
                slivers: [
                  SliverToBoxAdapter(
                    child: homePageText(
                      "Hello",
                      color: AppColors.primaryThrdElementText,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: homePageText("Spider Dreams",
                        color: AppColors.primaryText, top: 5),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(
                      top: 20.h,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: searchView(),
                  ),
                  SliverToBoxAdapter(
                    child: sliderView(context, state),
                  ),
                  SliverToBoxAdapter(
                    child: menuView(),
                  ),
                  SliverPadding(
                    padding:
                        EdgeInsets.symmetric(vertical: 18.h, horizontal: 0.w),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(childCount: 4,
                          (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: courseGrid(),
                        );
                      }),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spider_learnings_bloc_pattern/pages/common_Widgets.dart';
import 'package:spider_learnings_bloc_pattern/pages/register/bloc/register_blocs.dart';
import 'package:spider_learnings_bloc_pattern/pages/register/bloc/register_events.dart';
import 'package:spider_learnings_bloc_pattern/pages/register/bloc/register_states.dart';
import 'package:spider_learnings_bloc_pattern/pages/register/register_controller.dart';

// import '../signIn/widgets/sign_in_widget.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBlocs, RegisterStates>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: buildAppBar("Sign Up"),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                        child: reusableText(
                            "Enter your details below & free sign Up")),
                    Container(
                      margin: EdgeInsets.only(top: 60.h),
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reusableText("User name"),
                          buildTextField(
                              "Enter your user name", "email", "user", (value) {
                            context
                                .read<RegisterBlocs>()
                                .add(UserNameEvent(value));
                          }),
                          reusableText("Email"),
                          buildTextField(
                              "Enter your email address", "email", "user",
                              (value) {
                            context
                                .read<RegisterBlocs>()
                                .add(EmailEvent(value));
                          }),
                          reusableText("Password"),
                          buildTextField(
                              "Enter your password", "password", "lock",
                              (value) {
                            context
                                .read<RegisterBlocs>()
                                .add(PasswordEvent(value));
                          }),
                          reusableText("Re-Enter your password"),
                          buildTextField(
                              "Enter confirm password", "password", "lock",
                              (value) {
                            context
                                .read<RegisterBlocs>()
                                .add(RePasswordEvent(value));
                          }),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 25.w,
                      ),
                      child: reusableText(
                          "By Creating an account you have to agree with our terms & Conditions"),
                    ),
                    buildLogInAndRegButton(
                      "Sign Up",
                      "login",
                      () {
                        // Navigator.of(context).pushNamed("register");
                        RegisterController(context: context)
                            .handleEmailRegister();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

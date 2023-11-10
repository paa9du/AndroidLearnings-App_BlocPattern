import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spider_learnings_bloc_pattern/common/widgets/flutter_toast.dart';
import 'package:spider_learnings_bloc_pattern/pages/register/bloc/register_blocs.dart';

class RegisterController {
  final BuildContext context;
  const RegisterController({required this.context});
  void handleEmailRegister() async {
    final state = context.read<RegisterBlocs>().state;
    String userName = state.userName;
    String email = state.email;
    String password = state.password;
    String rePassword = state.rePassword;
    if (userName.isEmpty) {
      toastInfo(msg: "User name can not be empty");
      return;
    }
    if (email.isEmpty) {
      toastInfo(msg: "Email can not be empty");
      return;
    }
    if (password.isEmpty) {
      toastInfo(msg: "Password can not be empty");
      return;
    }
    if (rePassword.isEmpty) {
      toastInfo(msg: "Conformation password can not be empty");
      return;
    }
    try {
      final Credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (Credential.user != null) {
        await Credential.user?.sendEmailVerification();
        await Credential.user?.updateDisplayName(userName);
        toastInfo(
            msg:
                "An email has been sent to your registered email.To activate it please check your email box and click on the link");
        Navigator.of(context).pop();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        toastInfo(msg: "The Password Provided is Too Weak");
      } else if (e.code == 'The email is  already in use') {
        toastInfo(msg: "The email is already in use");
      } else if (e.code == 'invalid-email') {
        toastInfo(msg: "Your email is is invalid");
      }
    }
  }
}

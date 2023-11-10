import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:spider_learnings_bloc_pattern/common/entities/user.dart';
import 'package:spider_learnings_bloc_pattern/common/values/constant.dart';
import 'package:spider_learnings_bloc_pattern/common/widgets/flutter_toast.dart';
import 'package:spider_learnings_bloc_pattern/pages/signIn/bloc/signin_blocs.dart';

import '../../../global.dart';

class SignInController {
  final BuildContext context;
  SignInController({required this.context});
//   void handleSignIn(String type) async {
//     try {
//       if (type == "email") {
//         //BlocProvider.of<SignInBloc>(context).state;
//         final state = context.read<SignInBloc>().state;
//         String emailAddress = state.email;
//         String password = state.password;
//         if (emailAddress.isEmpty) {
//           print("email empty");
//           toastInfo(msg: "You need to fill email address");
//           return;
//         } else {
//           print("email is $emailAddress");
//           return;
//         }
//         if (password.isEmpty) {
//           print("password empty");
//           toastInfo(msg: "You need to fill password");
//           return;
//         }
//         try {
//           final Credential = await FirebaseAuth.instance
//               .signInWithEmailAndPassword(
//                   email: emailAddress, password: password);
//           if (Credential.user == null) {
//             toastInfo(msg: "user dooesn't exit");
//             return;
//           }
//           if (!Credential.user!.emailVerified) {
//             toastInfo(msg: "You nedd to verify your email account");
//             return;
//           }
//           var user = Credential.user;
//           if (user != null) {
//             print("user exist");
//             Global.storageService
//                 .setString(AppConstants.STORAGE_USER_TOKEN_KEY, "12345678");
//             Navigator.of(context)
//                 .pushNamedAndRemoveUntil("/application", (route) => false);
//             //we got verified user from firebase.
//           } else {
//             toastInfo(msg: "Currently you are not a user of this app");
//             return;
//           }
//         } on FirebaseAuthException catch (e) {
//           if (e.code == 'user-not-found') {
//             toastInfo(msg: "No user found for that email.");
//           } else if (e.code == 'wrong-password') {
//             toastInfo(msg: 'wrong password provided for that user.');
//           } else if (e.code == 'invalid-email') {
//             toastInfo(msg: "your email formate is wrong");
//           }
//         }
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }

  void handleSignIn(String type) async {
    try {
      if (type == "email") {
        final state = context.read<SignInBloc>().state;
        String emailAddress = state.email;
        String password = state.password;

        if (emailAddress.isEmpty || password.isEmpty) {
          toastInfo(msg: "Please fill in both email and password fields");
          return; // Don't proceed if email or password is empty
        }

        try {
          final Credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailAddress, password: password);
          if (Credential.user == null) {
            toastInfo(msg: "User doesn't exist");
            return;
          }
          if (!Credential.user!.emailVerified) {
            toastInfo(msg: "You need to verify your email account");
            return;
          }

          var user = Credential.user;
          if (user != null) {
            String? displayName = user.displayName;
            String? email = user.email;
            String? id = user.uid;
            String? photoUrl = user.photoURL;
            print("user open_id ${id}");
            print("user photourl ${photoUrl}");

            LoginRequestEntity loginRequestEntity = LoginRequestEntity();
            loginRequestEntity.avatar = photoUrl;
            loginRequestEntity.name = displayName;
            loginRequestEntity.email = email;
            loginRequestEntity.open_id = id;
            loginRequestEntity.type = 1;

            print("User exists");
            Global.storageService
                .setString(AppConstants.STORAGE_USER_TOKEN_KEY, "12345678");
            Navigator.of(context).pushNamed("/application");
            // Don't use pushNamedAndRemoveUntil unless necessary
          } else {
            toastInfo(msg: "Currently you are not a user of this app");
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            toastInfo(msg: "No user found for that email.");
          } else if (e.code == 'wrong-password') {
            toastInfo(msg: 'Wrong password provided for that user.');
          } else if (e.code == 'invalid-email') {
            toastInfo(msg: "Invalid email format");
          } else {
            // Handle other FirebaseAuthException errors as needed
            print("FirebaseAuthException: ${e.code}");
            toastInfo(msg: "An error occurred during sign-in");
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void asyncPostAllData(LoginRequestEntity loginRequestEntity) {
    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );
  }
}

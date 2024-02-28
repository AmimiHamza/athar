import 'package:athar_app/screens/choice_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() {
    if (validate()) {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) {
        print(value.user!.email);
        Get.to(() => ChoiceScreen());
      }).catchError((onError) {
        Get.snackbar('Email is invalid !', "You should use a valid email",
            snackPosition: SnackPosition.TOP, backgroundColor: Colors.white, colorText: Colors.red);
      });
;
    } else {}
  }

  loginWithGoogle() {
    FirebaseAuth.instance
        .signInWithProvider(GoogleAuthProvider())
        .then((value) {
      print(value.user!.email);
      Get.to(() => ChoiceScreen());
    });
  }

  loginWithFacebook() {
    FirebaseAuth.instance
        .signInWithProvider(FacebookAuthProvider())
        .then((value) {
      print(value.user!.email);
      Get.to(() => ChoiceScreen());
    });
  }

  void forgotPassword() {}

  bool validate() {
    bool isValid = true;

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      print("email or password is empty");
      isValid = false;
    }
    return isValid;
  }

  @override
  dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

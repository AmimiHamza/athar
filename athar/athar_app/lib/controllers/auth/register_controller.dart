import 'package:athar_app/screens/auth/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController{

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  register() {
    if(validate())  {
      FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ).then((value) {
        FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set({
          'name': nameController.text,
          'email': emailController.text,
        });
        Get.offAll(LoginScreen(), transition: Transition.rightToLeft);
      }).catchError((onError) {
        Get.snackbar('Error', onError.message,
            snackPosition: SnackPosition.TOP);
      });

    }else{

    }
  }

bool validate() {
    bool isValid = true;
    
    if (nameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty) {
      print("email or password is empty");
      isValid = false;
      
    } 
    return isValid;
  }
}
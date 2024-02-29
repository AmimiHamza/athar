import 'package:athar_app/controllers/auth/register_controller.dart';
import 'package:athar_app/screens/auth/login_screen.dart';
import 'package:athar_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetBuilder<RegisterController>(builder: (controller) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 243, 243),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/login_back.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ATHAR',
                  style: TextStyle(
                    color: primary,
                    fontFamily: 'Mirza',
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: secondary,
                    fontFamily: 'Mirza',
                    fontSize: 32,
                    // Define font size and family here
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      // Define button style and action for Google
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(163, 56),
                        backgroundColor: Colors.white,
                      ),
                      child: const Center(
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Icon(
                          FontAwesomeIcons.facebook,
                          size: 25,
                          color: dark,
                        ),
                        SizedBox(width: 10),
                        Text('Facebook', style: TextStyle(color: dark, fontSize: 16)),
                      ])),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      // Define button style and action for Google
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(163, 56),
                        backgroundColor: Colors.white,
                      ),
                      child: const Center(
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Icon(
                          FontAwesomeIcons.google,
                          size: 25,
                          color: dark,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Google',
                          style: TextStyle(color: dark, fontSize: 16),
                        ),
                      ])),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Or',
                    style: TextStyle(
                      color: dark,
                      fontFamily: 'poppins',
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                /*TextButton(
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: secondary,
                        fontFamily: 'poppins',
                        fontSize: 14,
                      ),
                    ),
                    onPressed: () {
                      // controller.forgotPassword();
                    }, // Define action for "Forgot Password?"
                  ),*/
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(163, 56),
                      backgroundColor: const Color.fromRGBO(28, 124, 84, 1),
                    ),
                    child: const Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'poppins'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account ? ', style: TextStyle(fontFamily: 'poppins', fontSize: 14)),
                    InkWell(
                      onTap: () {
                        Get.offAll(() => LoginScreen(), transition: Transition.rightToLeft);
                      },
                      child: const Text(
                        ' Log In',
                        style: TextStyle(
                          color: secondary,
                          fontFamily: 'poppins',
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }));
  }
}

class RegisterPage {}

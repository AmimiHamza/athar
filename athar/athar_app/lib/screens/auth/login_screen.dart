import 'package:athar_app/controllers/auth/login_controller.dart';
import 'package:athar_app/screens/auth/Register_screen.dart';
import 'package:athar_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetBuilder<LoginController>(builder: (controller) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 243, 243),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/login_back.png'),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
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
                      'Sign In',
                      style: TextStyle(
                        color: secondary,
                        fontFamily: 'Mirza',
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(150, 56), // Adjusted size
                            backgroundColor: Colors.white,
                          ),
                          child: const Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.facebook,
                                  size: 25,
                                  color: dark,
                                ),
                                SizedBox(width: 4), // Adjusted space
                                Text(
                                  'Facebook',
                                  style: TextStyle(color: dark, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 5), // Adjusted space
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(150, 56), // Adjusted size
                            backgroundColor: Colors.white,
                          ),
                          child: const Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.google,
                                  size: 25,
                                  color: dark,
                                ),
                                SizedBox(width: 4), // Adjusted space
                                Text(
                                  'Google',
                                  style: TextStyle(color: dark, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
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
                    const SizedBox(height: 20),
                    TextField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                    TextButton(
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: secondary,
                          fontFamily: 'poppins',
                          fontSize: 14,
                        ),
                      ),
                      onPressed: () {
                        controller.forgotPassword();
                      }, // Define action for "Forgot Password?"
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          controller.login();
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(163, 56),
                          backgroundColor: const Color.fromRGBO(28, 124, 84, 1),
                        ),
                        child: const Center(
                          child: Text(
                            'Log In',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'poppins'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account ? ',
                            style:
                                TextStyle(fontFamily: 'poppins', fontSize: 14)),
                        InkWell(
                          onTap: () {
                            Get.offAll(() => RegisterScreen(),
                                transition: Transition.rightToLeft);
                          },
                          child: const Text(
                            ' Create account',
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
          ),
        ),
      );
    }));
  }
}

import 'package:athar_app/controllers/choice_controller.dart';
import 'package:athar_app/screens/food.dart';
import 'package:athar_app/screens/history_screen.dart';
import 'package:athar_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChoiceScreen extends StatelessWidget {
  var controller = Get.put(ChoiceController());
  ChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetBuilder<ChoiceController>(builder: (controller) {
      return Scaffold(
          backgroundColor: const Color.fromARGB(255, 245, 243, 243),
          body: Center(
            child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/login_back.png'),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter),
                ),
                child: Center(
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => HistoryScreen());
                      },
                      child: const Image(image: AssetImage('assets/images/monuments.png')),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        Get.to(() => FoodScreen());
                      },
                      child: const Image(image: AssetImage('assets/images/food.png')),
                    )
                  ]),
                )),
          ));
    }));
  }
}

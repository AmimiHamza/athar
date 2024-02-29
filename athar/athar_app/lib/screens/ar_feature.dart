import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:ar_location_view/ar_location_view.dart';
import 'package:athar_app/screens/monument.dart';
import 'package:geolocator/geolocator.dart';
import 'package:athar_app/processus/fetch_data.dart';
import 'dart:async';
import 'package:athar_app/screens/choice_screen.dart';
import 'package:athar_app/screens/discovery_screen.dart';
import 'package:athar_app/screens/history_screen.dart';

import 'package:get/get.dart';


// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  MainScreen({super.key, required this.title});

  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  late Timer fetchAnnotationsTimer;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Annotation> myAnnotations = [];

  // getter
  List<Annotation> getAnnotations() {
    return myAnnotations;
  }

  void startFetchAnnotationsTimer() {
    fetchAnnotationsTimer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      // Call your fetchAnnotations function here and update myAnnotations
      fetchMonumentsAnnotations().then((List<Annotation> fetchedAnnotations) {
        setState(() {
          myAnnotations = fetchedAnnotations;
        });
      });
    });
  }

  Widget buildArLocationWidget(List<Annotation> annotations) {
    ArLocationWidget arlocationwidget = ArLocationWidget(
      annotations: annotations,
      showDebugInfoSensor: false,
      annotationWidth: 160,
      annotationHeight: 240,
      radarPosition: RadarPosition.bottomCenter,
      annotationViewBuilder: (context, annotation) {
        return AnnotationView(
          key: ValueKey(annotation.uid),
          annotation: annotation as Annotation,
        );
      },
      radarWidth: 100,
      scaleWithDistance: true,
      onLocationChange: (Position position) {
        Future.delayed(const Duration(seconds: 5), () {
          annotations = annotations;
          setState(() {});
        });
      },
    );

    return arlocationwidget;
  }

  // camera methods
  int direction = 0;

  @override
  void initState() {
    super.initState();
    startCamera(direction);
    startFetchAnnotationsTimer();
  }

  void startCamera(int direction) async {
    cameras = await availableCameras();

    cameraController = CameraController(
      cameras[direction],
      ResolutionPreset.high,
      enableAudio: false,
    );

    await cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {}); // To refresh widget
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    fetchAnnotationsTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(43, 0, 0, 0),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 255, 255, 255),
          size: 40,
        ),
      ),
      body:
      buildArLocationWidget(myAnnotations),
      endDrawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(100, 124, 28, 28),
                ),
                child: Text('Menu'),
              ),
              ListTile(
                title: const Text('Home'),
                selected: _selectedIndex == 0,
                onTap: () {
                  _onItemTapped(0);
                  Navigator.pop(context);
                  Get.to(() => ChoiceScreen());
                },
              ),
              ListTile(
                title: const Text('Discovery'),
                selected: _selectedIndex == 1,
                onTap: () {
                  _onItemTapped(1);
                  Navigator.pop(context);
                  Get.to(() => DiscoveryScreen());
                },
              ),
              ListTile(
                title: const Text('History'),
                selected: _selectedIndex == 2,
                onTap: () {
                  _onItemTapped(2);
                  Navigator.pop(context);
                  Get.to(() => HistoryScreen());
                },
              ),
              ListTile(
                title: const Text('Settings'),
                selected: _selectedIndex == 3,
                onTap: () {
                  // _onItemTapped(3);
                  // Navigator.pop(context);
                  Get.snackbar('New feature 😅', "coming soon 😗",
                      snackPosition: SnackPosition.TOP, backgroundColor: Colors.white, colorText: Colors.green[800]);
                },
              ),
            ],
          ),
        ),
    );
  }
}

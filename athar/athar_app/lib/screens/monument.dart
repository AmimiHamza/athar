import 'package:flutter/material.dart';
import 'package:ar_location_view/ar_location_view.dart';
// ignore: unused_import
import 'package:geolocator/geolocator.dart';

class Annotation extends ArAnnotation {
  final String text;
  final String title;

  Annotation({
    required super.uid,
    required this.title,
    required super.position,
    required super.distanceFromUser,
    required this.text,
  });

  // Getter method for accessing the text variable
  String getText() {
    return text;
  }

  // Getter method for accessing the text variable
  String getTitle() {
    return title;
  }
}

class AnnotationView extends StatelessWidget {
  const AnnotationView({
    super.key,
    required this.annotation,
  });

  final Annotation annotation;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    annotation.getTitle(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    annotation.getText(),
                    maxLines: 6,
                    style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 10),
                  ),
                  Text(
                    '${annotation.distanceFromUser.toInt()} m',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

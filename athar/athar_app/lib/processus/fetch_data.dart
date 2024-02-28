import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:athar_app/screens/monument.dart';

class Monument {
  final String name;
  final String info;
  final GeoPoint coordinates;

  Monument({required this.name, required this.info, required this.coordinates});
}

Future<List<Annotation>> fetchMonumentsAnnotations() async {
  List<Annotation> annotations = [];

  // Get current position
  Position currentPosition = await Geolocator.getCurrentPosition();

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('test');

  QuerySnapshot querySnapshot = await collectionReference.get();

  for (QueryDocumentSnapshot doc in querySnapshot.docs) {
    String documentName = doc.id;

    // Access the Firebase Firestore collection
    DocumentSnapshot enDoc = await FirebaseFirestore.instance
        .collection('test')
        .doc(documentName)
        .collection('en')
        .doc('test')
        .get();

    Monument monument = Monument(
      name: enDoc['name'],
      info: enDoc['historyInfo'],
      coordinates: enDoc['coordinate'],
    );

    // Calculate distance between user and monument
    double distance = GeolocatorPlatform.instance.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      monument.coordinates.latitude,
      monument.coordinates.longitude,
    );

    // Check if the monument is within 500 meters
    if (distance <= 500) {
      // Construct Annotation object and add to the list
      annotations.add(Annotation(
        uid: documentName, // Use documentName or another identifier
        title: monument.name,
        text: monument.info,
        position: Position(
          latitude: monument.coordinates.latitude,
          longitude: monument.coordinates.longitude,
          altitude: 0.0,
          speed: 0.0,
          accuracy: 0.0,
          heading: 0.0,
          speedAccuracy: 0.0,
          timestamp: DateTime.now(),
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        ),
        distanceFromUser: distance,
      ));
    }
  }
  print(annotations);
  return annotations;
}

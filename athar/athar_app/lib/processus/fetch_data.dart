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
    // DocumentSnapshot enDoc = await FirebaseFirestore.instance
    //     .collection('test')
    //     .doc(documentName)
    //     .collection('en')
    //     .doc('test')
    //     .get();

    DocumentSnapshot enDoc = await FirebaseFirestore.instance
        .collection('test')
        .doc(documentName)
        .get();

    // Check if the initial document exists
    if (enDoc.exists) {
      // Access the nested collection and document
      DocumentSnapshot nestedDoc = await FirebaseFirestore.instance
          .collection('test')
          .doc(documentName)
          .collection('en')
          .doc('test')
          .get();

      Monument monument = Monument(
        name: nestedDoc['name'],
        info: nestedDoc['historyInfo'],
        coordinates: nestedDoc['coordinate'],
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

      // Check if the monument is within 20 meters
      if (distance <= 20) {
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

        // Add the monument to the history collection
        /*await FirebaseFirestore.instance.collection('history').add({
          'm_id': enDoc.id,
          'user_id': "IbUwFivTEySKcHfUgGvoDfgiFB03",
          'timestamp': Timestamp.now(),
        });
     */ 
 String mId = enDoc.id;

      // Check if a document with the specified m_id exists in the 'history' collection
      QuerySnapshot historyQuery = await FirebaseFirestore.instance
        .collection('history')
        .where('m_id', isEqualTo: mId)
        .get();

      if (historyQuery.docs.isNotEmpty) {
        // Document with m_id exists, update the timestamp
        DocumentSnapshot existingDoc = historyQuery.docs.first;
        await existingDoc.reference.update({
          'date': Timestamp.now(),
        });
        print("Document updated with m_id: $mId");
      } else {
        // Document with m_id does not exist, add a new document
        await FirebaseFirestore.instance.collection('history').add({
          'm_id': mId,
          'user_id': "IbUwFivTEySKcHfUgGvoDfgiFB03",
          'date': Timestamp.now(),
        });
        print("New document added with m_id: $mId");
      }

      }
       else {
        print("Initial document does not exist");
      }
    }
     
  }

  return annotations;
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Monument {
  final String name;
  final String info;
  final GeoPoint coordinates;

  Monument({required this.name, required this.info, required this.coordinates});
}

class DiscoveryScreen extends StatelessWidget {
  const DiscoveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discovery'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Discover Monuments and Dishes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Expanded to fetch "monuments" from firebase docs then colletion "en" then docs "test"
          Expanded(
            child: SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('monuments').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  return Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: snapshot.data!.docs.map((monumentDoc) {
                      // Accessing the 'en' subcollection within each monument document
                      return FutureBuilder<DocumentSnapshot>(
                        future: monumentDoc.reference.collection('en').doc('test').get(),
                        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> monumentSnapshot) {
                          if (monumentSnapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          if (monumentSnapshot.hasError) {
                            return Text('Error: ${monumentSnapshot.error}');
                          }

                          final monumentData = monumentSnapshot.data!.data() as Map<String, dynamic>;
                          return longCard(monumentData, context);
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget longCard(Map<String, dynamic> monumentData, context) {
    return InkWell(
      child: Card(
        color: Colors.white, // Set background color to white
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                monumentData["picture"], // Use image URL from monument data
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            const SizedBox(height: 8), // Add spacing between image and title
            // Title
            Text(
              monumentData["name"], // Use title from monument data
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(monumentData['name']),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(monumentData['picture']),
                    SizedBox(height: 10),
                    Text(monumentData['historyInfo']),
                  ],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

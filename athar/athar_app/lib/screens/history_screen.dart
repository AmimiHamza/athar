import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Remanence on Memories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('history').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  return Wrap(
                    spacing: 8.0, // Horizontal spacing between cards
                    runSpacing: 8.0, // Vertical spacing between rows
                    children: snapshot.data!.docs.map((historyDoc) {
                      return FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('test')
                            .doc(historyDoc['m_id'])
                            .collection('en')
                            .doc('test')
                            .get(),
                        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> monumentSnapshot) {
                          if (monumentSnapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          if (monumentSnapshot.hasError) {
                            return Text('Error: ${monumentSnapshot.error}');
                          }

                          final monumentData = monumentSnapshot.data!.data() as Map<String, dynamic>;

                          // Parse the date string to a DateTime object
                          Timestamp timestamp = historyDoc['date']; // Get the Timestamp
                          DateTime date = timestamp.toDate(); // Convert to DateTime

                          // Now you can format the date
                          String formattedDate = DateFormat.yMd().format(date); // Output format: mm/dd/yyyy
                          return longCard(monumentData, formattedDate, context);
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

  Widget longCard(Map<String, dynamic> monumentData, String formattedDate, context) {
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
            const SizedBox(height: 4), // Add spacing between title and label
            // Label and See More
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Label
                Text(
                  formattedDate, // Get date from history document
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                // See More
                const Row(
                  children: [
                    Icon(Icons.arrow_forward, color: Colors.black87),
                  ],
                ),
              ],
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
                    Text(
                      "Visited on${formattedDate}",
                      style: TextStyle(color: Colors.grey),
                    ),
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

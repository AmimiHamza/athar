import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';


class FoodScreen extends StatefulWidget {
  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  String foodName = '';
  bool isLoading = false;

  TextEditingController _controller = TextEditingController();

  void searchFood() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('food');

    QuerySnapshot querySnapshot = await collectionReference.get();

    querySnapshot.docs.forEach((doc) async {
      String documentName = doc.id;
      if (documentName.contains(foodName)) {
        if (foodName.isNotEmpty) {
          // Access the Firebase Firestore collection
          DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
              .collection('food')
              .doc(documentName) // Replace 'food1' with the actual document ID
              .collection('en')
              .doc('test') // Replace 'enDocumentID' with the actual document ID
              .get();

          setState(() {
            isLoading = false;
          });

          // Check if food is found
          if (documentSnapshot.exists) {
            // Get the first document (assuming there's only one food with the same name)
            var foodData = documentSnapshot;
            print(foodData);
            // Display the food information
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(foodData['name']),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.network(foodData['picture']),
                        SizedBox(height: 10),
                        Text(foodData['historyInfo']),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Close'),
                    ),
                  ],
                );
              },
            );
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Food not found'),
                  content:
                      Text('Sorry, the food you searched for was not found.'),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Close'),
                    ),
                  ],
                );
              },
            );
          }
        } else {
          Get.snackbar(
              'Food name is empty !', "You should enter a valid food name",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.white,
              colorText: Colors.red);
        }
      }
    });

   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Food'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: const InputDecoration(

                labelText: 'Enter food name',
              ),
              onChanged: (value) {
                setState(() {
                  foodName = value;
                });
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                searchFood();
              },
              child: const Text('Search'),
            ),
            if (isLoading) const CircularProgressIndicator(),

          ],
        ),
      ),
    );
  }
}

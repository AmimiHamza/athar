import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodScreen extends StatefulWidget {
  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  String foodName = '';
  bool isLoading = false;

  TextEditingController _controller = TextEditingController();

  void searchFood() async {
    setState(() {
      isLoading = true;
    });

    // Access the Firebase Firestore collection
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('food')
        .where('name', isEqualTo: foodName)
        .get();

    setState(() {
      isLoading = false;
    });

    // Check if food is found
    if (querySnapshot.docs.isNotEmpty) {
      // Get the first document (assuming there's only one food with the same name)
      var foodData = querySnapshot.docs.first.data();
      // Display the food information
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(foodData['name']),
            content: Column(
              children: [
                Image.network(foodData['picture']),
                Text(foodData['historyInfo']),
              ],
            ),
            actions: <Widget>[
              FlatButton(
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
      // Food not found
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Food not found'),
            content: Text('Sorry, the food you searched for was not found.'),
            actions: <Widget>[
              FlatButton(
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
              decoration: InputDecoration(
                labelText: 'Enter food name',
              ),
              onChanged: (value) {
                setState(() {
                  foodName = value;
                });
              },
            ),
            SizedBox(height: 20.0),
            RaisedButton(
              onPressed: () {
                searchFood();
              },
              child: Text('Search'),
            ),
            if (isLoading) CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

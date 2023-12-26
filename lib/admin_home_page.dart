import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'AddBabyPage.dart';
import 'ShowBabiesPage.dart';

class AdminHomePage extends StatelessWidget {
  Future<void> _deleteBaby(String babyId) async {
    try {
      // Check if the baby exists before deleting
      DocumentSnapshot babyDoc = await FirebaseFirestore.instance.collection('babies').doc(babyId).get();

      if (babyDoc.exists) {
        await FirebaseFirestore.instance.collection('babies').doc(babyId).delete();

        // Optionally, you can navigate back to the admin home page or display a success message.
      } else {
        print('Baby not found');
        // Optionally, you can display an error message or take appropriate action.
      }
    } catch (e) {
      print('Error deleting baby: $e');
      // Handle the error (display an error message or take appropriate action)
    }
  }

  Future<void> _deleteAllBabies() async {
    try {
      // Get all documents from the 'babies' collection
      QuerySnapshot babyQuery = await FirebaseFirestore.instance.collection('babies').get();

      // Delete each document in the 'babies' collection
      for (QueryDocumentSnapshot babyDoc in babyQuery.docs) {
        await babyDoc.reference.delete();
      }

      // Optionally, you can navigate back to the admin home page or display a success message.
    } catch (e) {
      print('Error deleting all babies: $e');
      // Handle the error (display an error message or take appropriate action)
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Admin Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // Change this to the desired background color
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddBabyPage()));
              },
              child: Text('Add Baby'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // Change this to the desired background color
              ),
              onPressed: _deleteAllBabies,
              child: Text('Delete All Babies'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // Change this to the desired background color
              ),
              onPressed: () {

                Navigator.push(context, MaterialPageRoute(builder: (context) => ShowBabiesPage()));
              },
              child: Text('Show Babies'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // Change this to the desired background color
              ),
              onPressed: () {
                // Navigate to Control Stepper Motor page or show dialog
              },
              child: Text('Control Stepper Motor'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // Change this to the desired background color
              ),
              onPressed: () {
                // Navigate to Show Sensors Information page or show dialog
              },
              child: Text('Show Sensors Information'),
            ),
          ],
        ),
      ),
    );
  }
}


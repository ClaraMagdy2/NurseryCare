import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowBabyInfoPage extends StatelessWidget {
  final String babyId;

  ShowBabyInfoPage({required this.babyId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Baby Information'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('babies').doc(babyId).get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Text('No baby information found.');
          }

          Map<String, dynamic> babyData = snapshot.data!.data() as Map<String, dynamic>;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Baby Name: ${babyData['babyName']}',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color:Colors.black),textAlign: TextAlign.center),
              Text('Birth Place: ${babyData['birthPlace']}',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color:Colors.black),textAlign: TextAlign.center),
              Text('Birth Doctor: ${babyData['birthDoctor']}',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color:Colors.black),textAlign: TextAlign.center),
              Text('Birth Date: ${babyData['birthDate']}',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color:Colors.black),textAlign: TextAlign.center),
              Text('Birth Weight: ${babyData['birthWeight']}',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color:Colors.black),textAlign: TextAlign.center),
              // Add more fields as needed
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowBabiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Show Babies'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('babies').get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('No baby information found.');
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot babyDoc) {
              Map<String, dynamic> babyData = babyDoc.data() as Map<String, dynamic>;

              return ListTile(
                title: Text('Baby Name: ${babyData['babyName']}',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color:Colors.black),textAlign: TextAlign.center),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ID: ${babyDoc.id}',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color:Colors.black),textAlign: TextAlign.center),
                    Text('Birth Place: ${babyData['birthPlace']}',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color:Colors.black),textAlign: TextAlign.center),
                    Text('Birth Date: ${babyData['birthDate']}',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color:Colors.black),textAlign: TextAlign.center),
                    Text('Birth Doctor: ${babyData['birthDoctor']}',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color:Colors.black),textAlign: TextAlign.center),
                    Text('Birth Weight: ${babyData['birthWeight']}',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color:Colors.black),textAlign: TextAlign.center),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

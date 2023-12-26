import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddBabyPage extends StatefulWidget {
  @override
  _AddBabyPageState createState() => _AddBabyPageState();
}

class _AddBabyPageState extends State<AddBabyPage> {
  final TextEditingController _babyNameController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _birthDoctorController = TextEditingController();
  final TextEditingController _birthWeightController = TextEditingController();

  String _savedBabyId = '';

  Future<void> _saveBabyInformation() async {
    try {
      DocumentReference babyRef = await FirebaseFirestore.instance.collection('babies').add({
        'babyName': _babyNameController.text.trim(),
        'birthPlace': _birthPlaceController.text.trim(),
        'birthDate': _birthDateController.text.trim(),
        'birthDoctor': _birthDoctorController.text.trim(),
        'birthWeight': _birthWeightController.text.trim(),
      });

      setState(() {
        _savedBabyId = babyRef.id;
      });

      // Optionally, you can navigate back to the admin home page or display a success message.
    } catch (e) {
      print('Error saving baby information: $e');
      // Handle the error (display an error message or take appropriate action)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Add Baby'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _babyNameController,
              decoration: InputDecoration(labelText: 'Baby Name'),
            ),
            TextField(
              controller: _birthPlaceController,
              decoration: InputDecoration(labelText: 'Birth Place',prefixIcon: Icon(Icons.place)),
            ),
            TextField(
              controller: _birthDateController,
              decoration: InputDecoration(labelText: 'Birth Date',prefixIcon: Icon(Icons.calendar_month)),
            ),
            TextField(
              controller: _birthDoctorController,
              decoration: InputDecoration(labelText: 'Birth Doctor',prefixIcon: Icon(Icons.local_hospital)),
            ),
            TextField(
              controller: _birthWeightController,
              decoration: InputDecoration(labelText: 'Birth Weight',prefixIcon: Icon(Icons.line_weight)),
            ),
            SizedBox(height: 16.0),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white, // Change this to the desired background color
          ),
          onPressed: () async {
            await _saveBabyInformation();
          },
          child: Text('Save Baby Information'),
        ),

          ],
        ),
      ),
    );
  }
}



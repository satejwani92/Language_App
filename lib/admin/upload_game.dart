import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class QuestionPage extends StatelessWidget {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _option1Controller = TextEditingController();
  final TextEditingController _option2Controller = TextEditingController();
  final TextEditingController _option3Controller = TextEditingController();
  final TextEditingController _correctOptionController = TextEditingController();

  void _uploadQuestion(BuildContext context) {
    FirebaseFirestore.instance.collection('questions').add({
      'question': _questionController.text,
      'options': [
        _option1Controller.text,
        _option2Controller.text,
        _option3Controller.text,
      ],
      'correctOption': _correctOptionController.text,
    }).then((value) {
      // Successfully uploaded
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Question uploaded successfully')),
      );
      // Clear text fields after successful upload
      _questionController.clear();
      _option1Controller.clear();
      _option2Controller.clear();
      _option3Controller.clear();
      _correctOptionController.clear();
    }).catchError((error) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload question: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _questionController,
              decoration: InputDecoration(labelText: 'Question'),
            ),
            TextField(
              controller: _option1Controller,
              decoration: InputDecoration(labelText: 'Option 1'),
            ),
            TextField(
              controller: _option2Controller,
              decoration: InputDecoration(labelText: 'Option 2'),
            ),
            TextField(
              controller: _option3Controller,
              decoration: InputDecoration(labelText: 'Option 3'),
            ),
            TextField(
              controller: _correctOptionController,
              decoration: InputDecoration(labelText: 'Correct Option'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _uploadQuestion(context),
              child: Text('Upload Question'),
            ),
          ],
        ),
      ),
    );
  }
}

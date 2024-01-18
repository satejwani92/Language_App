import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadListeningScreen extends StatefulWidget {
  @override
  _UploadListeningScreenState createState() => _UploadListeningScreenState();
}

class _UploadListeningScreenState extends State<UploadListeningScreen> {
  final TextEditingController textFieldController = TextEditingController();
  String selectedLanguage = 'English'; // Default language

  void _uploadText() async {
    String text = textFieldController.text.trim();

    if (text.isNotEmpty) {
      try {
        // Add the text to Firestore under the 'LISTENING' collection
        await FirebaseFirestore.instance.collection('LISTENING').add({
          'text': text,
          'language': selectedLanguage,
          'timestamp':
              FieldValue.serverTimestamp(), // Add a timestamp if needed
        });

        // Clear the text field after successful upload
        textFieldController.clear();

        // Display a success message (you can use a Snackbar or navigate to another screen)
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Text uploaded successfully!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } catch (error) {
        // Handle errors if any
        log('Error uploading text: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload to LISTENING'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: selectedLanguage,
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
              },
              items: ['English', 'Spanish', 'French'] // Add your languages here
                  .map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: textFieldController,
              decoration: const InputDecoration(
                labelText: 'Enter Text',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadText,
              child: const Text('Upload Text'),
            ),
          ],
        ),
      ),
    );
  }
}
